import 'package:path/path.dart';
import 'package:rentiq/Utilities/Rental.dart';
import 'dart:io';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rentiq/Utilities/Rental_Detail_Card.dart';
import 'tenantCard.dart';

List<TenantCard> tenantCardList = [];
List<RentalDetailCard> billItemCardList = [];
Map<String,dynamic> lastEbData;
double total = 0;

class DatabaseHelper{
  DatabaseHelper({this.rental});

  DatabaseHelper._privateConstructor();
  static final instance = DatabaseHelper._privateConstructor();
  Rental rental;
  String path;
  static final _dbName = "Rentiq.db";
  static final _dbVersion = 1;
  static final _masterTableName = 'rentiq';
  String _rentalBillTableName;
  String _rentalElectricityTableName;

  static Database _database;
  Future<Database> get database async{
    if(_database!=null)  return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    path = join(documentsDirectory.path,_dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate (Database db, int version){
    db.execute(
      '''
      CREATE TABLE $_masterTableName(
      rentalno TEXT PRIMARY KEY,
      tenant_name TEXT,
      phone_no TEXT,
      address TEXT NOT NULL,
      occupied INTEGER,
      status TEXT,
      rpu REAL)
      '''
    );
  }

  Future insert(Map<String,dynamic> row, String tableName) async{
    Database db = await instance.database;
    int index = await db.insert(tableName, row, conflictAlgorithm: ConflictAlgorithm.replace);
    print(tableName+ ':' + index.toString());
  }

  Future<int> update(Map<String, dynamic> row, String tableName, String referenceArgument, var referenceArgValue) async{
    Database db = await instance.database;
    return await db.update(tableName, row, where: '$referenceArgument == ?', whereArgs: [referenceArgValue]);
  }

  Future deleteRecord() async{
    Database db = await instance.database;
    return await db.delete(_masterTableName, where: 'rentalno == ?', whereArgs: [rental.rentalNo]);
  }

  Future deleteTable(String tableName) async{
    Database db = await instance.database;
    return await db.execute('DROP TABLE $tableName');
  }

  void deleteDB() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> data = await db.query(_masterTableName, columns: ['rentalno']);
    for(Map<String, dynamic> i in data){
      _rentalBillTableName = '"' + i['rentalno'] + 'bill' + '"';
      await deleteTable(_rentalBillTableName);
      _rentalElectricityTableName = '"' + i['rentalno'] + 'electricity' + '"';
      await deleteTable(_rentalElectricityTableName);
    }
    await deleteTable(_masterTableName);
  }

  Future getRentalList() async  {
    Database db = await instance.database;
    List<Map<String, dynamic>> data = await db.query(_masterTableName);
    tenantCardList = [];
    for (int i = 0; i < data.length; i++){
      Rental _rental = Rental();
      _rental.rentalNo = data[i]['rentalno'];
      _rental.tenantName = data[i]['tenant_name'];
      _rental.phoneNo = data[i]['phone_no'];
      _rental.address = data[i]['address'];
      _rental.occupied = data[i]['occupied'];
      _rental.status = data[i]['status'];
      _rental.rpu = data[i]['rpu'];
      _rental.billItems = {};
      tenantCardList.add(TenantCard(rental: _rental));
    }
    return tenantCardList;
  }

  Future getBillItems() async{
    Database db = await instance.database;
    DateTime date = DateTime.now();
    String usableDate = date.month.toString() + '-' + date.year.toString();
    _rentalBillTableName = '"' + rental.rentalNo + 'bill' + '"';
    billItemCardList = [];

    //  Getting this month bill Items if available, Else get last month bill items
    List<Map<String,dynamic>> billItems = await db.query(_rentalBillTableName, where: 'date == ?', whereArgs: [usableDate]);
    if(billItems.isEmpty){
      String previousMonth = (date.month-1).toString() + '-' + date.year.toString();
      billItems = await db.query(_rentalBillTableName, where: 'date == ?', whereArgs: [previousMonth]);
    }

    rental.billItems = {};
    total = 0;
    for(Map<String,dynamic> i in billItems){
      total += i['amount'];
      rental.dateBill = i['date'];
      rental.billItems.addAll({i['category']: i['amount']});
      billItemCardList.add(RentalDetailCard(text: i['category'], value: i['amount'].toString()));
    }
    return billItemCardList;
  }

  Future getElectricityReadings() async{
    Database db = await instance.database;
    _rentalElectricityTableName = '"' + rental.rentalNo + 'electricity' + '"';
    List<Map<String,dynamic>> dataEB = await db.query(_rentalElectricityTableName);
    lastEbData = dataEB[dataEB.length-1];
    DateTime date = DateTime.now();
    String usableDate = date.month.toString() + '-' + date.year.toString();
    rental.dateEB = lastEbData['date'];
    rental.previousEB = lastEbData['previous'];
    rental.currentEB = lastEbData['current'];
    rental.electricityCost = lastEbData['cost'];
    if(lastEbData['date'] == usableDate){
      rental.status = 'Noted';
      updateMaster();
    }
    else{
      rental.status = 'to_be_noted';
      updateMaster();
    }
    return dataEB;
  }

  Future addNewRental() async{
    Database db = await instance.database;
    insert({
      'rentalno' : rental.rentalNo,
      'tenant_name' : rental.tenantName,
      'phone_no' : rental.phoneNo,
      'address' : rental.address,
      'occupied' : rental.occupied,
      'status' : rental.status,
      'rpu' : rental.rpu,
    }, _masterTableName);

    _rentalElectricityTableName = '"' + rental.rentalNo + 'electricity' + '"';
    db.execute(
    '''
    CREATE TABLE $_rentalElectricityTableName(
    date TEXT,
    previous REAL,
    current REAL,
    cost REAL)
    '''
    );

    _rentalBillTableName = '"' + rental.rentalNo + 'bill' + '"';
    db.execute(
      '''
      CREATE TABLE $_rentalBillTableName(
      date TEXT,
      category TEXT,
      amount REAL)
      '''
    );
    DateTime date = DateTime.now();
    String usableDate = date.month.toString() + '-' + date.year.toString();

    insert({
      'date' : usableDate,
      'previous' : rental.previousEB,
      'current' : rental.currentEB,
      'cost' : rental.electricityCost
    }, _rentalElectricityTableName);

    if(rental.billItems != null){
      addBillItems();
    }
    rental.status = 'Noted';
    updateMaster();
  }

  Future addBillItems() async{
    DateTime date = DateTime.now();
    String usableDate = date.month.toString() + '-' + date.year.toString();
    _rentalBillTableName = '"' + rental.rentalNo + 'bill' + '"';
    for(var i in rental.billItems.keys){
      insert({
        'date' : usableDate,
        'category' : i,
        'amount' : rental.billItems[i]
      }, _rentalBillTableName);
    }
  }

  Future addElectricity() async{
    DateTime date = DateTime.now();
    String usableDate = date.month.toString() + '-' + date.year.toString();
    _rentalElectricityTableName = '"' + rental.rentalNo + 'electricity' + '"';
    rental.electricityCost = rental.rpu * (rental.currentEB - rental.previousEB);
    insert({
      'date' : usableDate,
      'previous': rental.previousEB,
      'current' : rental.currentEB,
      'cost' : rental.electricityCost
    }, _rentalElectricityTableName);
    print(rental.status);
      rental.status = 'Noted';
      updateMaster();
  }

  Future updateMaster() async{
    update({
      'tenant_name' : rental.tenantName,
      'phone_no' : rental.phoneNo,
      'occupied' : rental.occupied,
      'status' : rental.status,
    }, _masterTableName, 'rentalno', rental.rentalNo);
  }

  Future deleteRental() async{
    _rentalBillTableName = '"' + rental.rentalNo + 'bill' + '"';
    await deleteTable(_rentalBillTableName);
    _rentalElectricityTableName = '"' + rental.rentalNo + 'electricity' + '"';
    await deleteTable(_rentalElectricityTableName);
    deleteRecord();
  }
}
import 'package:rentiq/Utilities/DatabaseHelper.dart';

import 'tenantCard.dart';
import 'package:rentiq/Utilities/Rental.dart';

bool deleteSelector = false;
Rental rental = Rental();

void getValues(){
  rental.rentalNo = '101';
  rental.tenantName = 'Chris Hemsworth';
  rental.phoneNo = '9445345310';
  rental.address = '43/51, 53rd street, 9th sector, K.K.Nagar, Chennai-78';
  rental.occupied = 1;
  rental.status = 'SMS';
  rental.billItems = {
    'Rent' : 7000,
    'Water Tax' : 300,
    'Parking' : 200,
    'Maintenance' : 300};
}

void addTenant(Rental rental){
  rentalList.add(TenantCard(rental: rental,));
}

List<TenantCard> rentalList = [
  TenantCard(rental: rental),
  TenantCard(rental: rental),
  TenantCard(rental: rental),
  TenantCard(rental: rental),
  TenantCard(rental: rental),
  TenantCard(rental: rental),
  TenantCard(rental: rental),
  TenantCard(rental: rental),
  TenantCard(rental: rental),
  TenantCard(rental: rental),
];
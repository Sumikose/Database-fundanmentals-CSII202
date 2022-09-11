CREATE TABLE Branch(
branchNo VARCHAR(4),
street VARCHAR(25),
city VARCHAR(15),
postcode VARCHAR(25)
);
INSERT INTO Branch(branchNo, street, city, postcode)
VALUES("B005","22 Deer Rd","London","SW1 4EH"),
      ("B007","16 Argyll St","Aberdeen","AB2 3SU"),
      ("B003","163 Main St","Glasgow","G11 9QX"),
      ("B004","32 Manise St","Bristol","BS99 1NZ"),
      ("B002","56 Clover Dr","London","NW10 6EU");
      

 

CREATE TABLE Staff(
StaffNo VARCHAR(4),
fName VARCHAR(25),
lName VARCHAR(15),
position1 VARCHAR(25),
sex VARCHAR(1),
DOB DATE,
salary INT,
branchNo VARCHAR(4)
);
INSERT INTO Staff(staffNo, fName, lName, position1, sex, DOB, salary, branchNo)
VALUES("SL21","John","White","Manager","M","1945-10-01",30000,"B005"),
      ("SG37","Ann","Beech","Assistant","F","1960-11-01",12000,"B003"),
      ("SG14","David","Ford","Supervisor","M","1958-03-24",18000,"B003"),
      ("SA9","Mary","Howe","Assistant","F","1970-02-19",9000,"B007"),
      ("SG5","Susan","Brand","Manager","F","1940-06-03",24000,"B003"),
      ("SL41","Julie","Lee","Assistant","F","1965-06-13","9000","B005");
      
CREATE TABLE PropertyForRent(
propertyNo VARCHAR(4),
street VARCHAR(25),
city VARCHAR(20),
postcode VARCHAR(20),
type1 VARCHAR(15),
rooms INT,
rent INT,
ownerNo VARCHAR(4),
staffNo VARCHAR(4),
branchNo VARCHAR(4)
);
INSERT INTO PropertyForRent(propertyNo, street, city, postcode, type1, rooms, rent, ownerNo, staffNo, branchNo)
VALUES("PA14","16 Holland","Aberdeen","AB7 5SU","House",6,650,"CO46","SA9","B007"),
      ("PL94","6 Argyll St","London","NW2","Flat",4,400,"CO87","SL41","B005"),
      ("PG4","6 Lawrence St","Glasgow","G11 9QX","Flat",3,350,"CO40","","B003"),
      ("PG36","Manor Rd","Glasgow","G32 4QX","Flat",3,375,"CO93","SG37","B003"),
      ("PG21","18 Dale Rd","Glasgow","G12","House",5,600,"CO87","SG37","BOO3"),
      ("PG16","5 Novar Dr","Glasgow","G12 9AX","Flat",4,450,"CO93","SG14","B003");

CREATE TABLE client1(
clientNo VARCHAR(4),
fName VARCHAR(20),
lName VARCHAR(15),
telNo VARCHAR(15),
prefType VARCHAR(15),
maxRent INT
);
INSERT INTO client1(clientNo, fName, lName, telNo, prefType, maxRent)
VALUES("CR76","John","Kay","0207-774-5632","Flat",425),
      ("CR56","Aline","Stewart","0141-848-1825","Flat",350),
      ("CR74","Mike","Ritchie","01475-392178","House",750),
      ("CR62","Mary","Tregear","01224-196720","Flat",600);
    
      
CREATE TABLE PrivateOwner(
ownerNo VARCHAR(4),
fNAme VARCHAR(20),
lName VARCHAR(15),
address VARCHAR(35),
telNo VARCHAR(25)
);
INSERT INTO PrivateOwner(ownerNo, fName, lName, address, telNo)
VALUES("CO46","Joe","Keogh","2 Fergus Dr,Aberdeen AB2 75X","01224-861212"),
      ("CO87","Carol","Farrel","6 Achray St,Glasgow G32 9DX","0141-357-7419"),
      ("CO40","Tina","Murphy","63 Well St,Glasgow G42","0141-943-1728"),
      ("CO93","Tony","Shaw","12 Park Pl,Glasgow G4 0QR","0141-225-7025");
      
CREATE TABLE Viewing(
clientNo VARCHAR(4),
propertyNo VARCHAR(4),
viewDate DATE,
comment1 VARCHAR(25)
);
INSERT INTO Viewing(clientNo, propertyNo, viewDate, comment1)
VALUES("CR56","PA14","2004-05-24","too small"),
      ("CR76","PG4","2004-04-20","too remote"),
      ("CR56","PG4","2004-05-26",""),
      ("CR62","PA14","2004-05-14","non dining room"),
      ("CR56","PG36","2004-04-28","");

      
CREATE TABLE Registration(
clientNo VARCHAR(4),
branchNo VARCHAR(4),
staffNo VARCHAR(4),
dateJoined DATE
);
INSERT INTO Registration(clientNo, branchNo, staffNo, dateJoined)
VALUES("CR76","B005","SL41","2004-01-02"),
      ("CR56","B003","SG37","2003-04-11"),
      ("CR74","B003","SG37","2002-11-16"),
      ("CR62","B007","SA9","2003-03-07");
      
      

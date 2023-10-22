
-- -- Service Centers tab
-- Inserting Service Centers without managers
insert into ServiceCenter values (30001, '3921 Western Blvd, Raleigh, NC 27606', '3392601234', '1' , 30, 40, 35);
insert into ServiceCenter values (30002, '4500 Preslyn Dr Suite 103, Raleigh, NC 27616', '8576890280', '1', 25, 35, 25);
insert into ServiceCenter values (30003, '9515 Chapel Hill Rd, Morrisville, NC 27560', '7798182200', '0', 20, 25, 22);

-- Creating Users for each given manager
insert into Users values ('JohnDoe', 'JohnDoe');
insert into Users values ('RachelBrooks','RachelBrooks');
insert into Users values ('CalebSmith','CalebSmith');

-- Adding given managers as Employees assuming each manager manages center in order given
insert into Employee values ('JohnDoe', 123456789, 'John Doe', '1378 University Woods, Raleigh, NC 27612', 'jdoe@gmail.com', '8636368778', 30001);
insert into Employee values ('RachelBrooks', 987654321, 'Rachel Brooks', '2201 Gorman Parkwood, Raleigh, NC 27618', 'rbrooks@ymail.com', '8972468552', 30002);
insert into Employee values ('CalebSmith', 987612345, 'Caleb Smith', '1538 Red Bud Lane, Morrisville, NC 27560', 'csmith@yahoo.com', '8547963210', 30003);

-- Adding given managers as Managers
insert into Manager values (123456789, 30001, 44);
insert into Manager values (987654321, 30002, 35);
insert into Manager values (987612345, 30003, 25);

-- Adding Managers to the manages table to show which center they manage
-- Is this storing data twice?
-- insert into manages values (123456789, 30001);
-- insert into manages values (987654321, 30002);
-- insert into manages values (987612345, 30003);

-- -- Mechanics tab (Did not include field for start date!)
-- Creating Users for each given mechanic
insert into Users values ('JamesWilliams','JamesWilliams');
insert into Users values ('DavidJohnson','DavidJohnson');
insert into Users values ('MariaGarcia','MariaGarcia');
insert into Users values ('EllieClark','EllieClark');
insert into Users values ('RobertMartinez','RobertMartinez');
insert into Users values ('CharlesRodriguez','CharlesRodriguez');
insert into Users values ('JoseHernandez','JoseHernandez');
insert into Users values ('CharlieBrown','CharlieBrown');
insert into Users values ('JeffGibson','JeffGibson');
insert into Users values ('IsabelleWilder','IsabelleWilder');
insert into Users values ('PeterTitus','PeterTitus');
insert into Users values ('MarkMendez','MarkMendez');
insert into Users values ('LisaAlberti','LisaAlberti');

-- Adding given mechanics as Employees
insert into Employee values ('JamesWilliams', 132457689, 'James Williams', '1400 Gorman St, Raleigh, NC 27606-2972 ', 'jwilliams@gmail.com', '4576312882', 30001);
insert into Employee values ('DavidJohnson', 314275869, 'David Johnson', '686 Stratford Court, Raleigh, NC 27606', 'djohnson@ymail.com', '9892321100', 30001);
insert into Employee values ('MariaGarcia', 241368579, 'Maria Garcia', '1521 Graduate Lane, Raleigh, NC 27606', 'mgarcia@yahoo.com', '4573459090', 30001);
insert into Employee values ('EllieClark', 423186759, 'Ellie Clark', '3125 Avent Ferry Road, Raleigh, NC 27605', 'eclark@gmail.com', '9892180921', 30002);
insert into Employee values ('RobertMartinez', 123789456, 'Robert Martinez', '1232 Tartan Circle, Raleigh, NC 27607', 'rmartinez@ymail.com', '7652304282', 30002);
insert into Employee values ('CharlesRodriguez', 789123456, 'Charles Rodriguez', '218 Patton Lane, Raleigh, NC 27603', 'crodriguez@yahoo.com', '9092234281', 30002);
insert into Employee values ('JoseHernandez', 125689347, 'Jose Hernandez', '4747 Dola Mine Road, Raleigh, NC 27609', 'jhernandez@gmail.com', '7653241714', 30002);
insert into Employee values ('CharlieBrown', 347812569, 'Charlie Brown', '1 Rockford Mountain Lane, Morrisville, NC 27560', 'cbrown@ymail.com', '9091237568', 30003);
insert into Employee values ('JeffGibson', 123456780, 'Jeff Gibson', '900 Development Drive, Morrisville, NC 27560', 'jgibson@yahoo.com', '3390108899', 30003);
insert into Employee values ('IsabelleWilder', 123456708, 'Isabelle Wilder', '6601 Koppers Road, Morrisville, NC 27560', 'iwilder@gmail.com', '3394561231', 30003);
insert into Employee values ('PeterTitus', 123456078, 'Peter Titus', '2860 Slater Road, Morrisville, NC 27560', 'ptitus@ymail.com', '3396723418', 30003);
insert into Employee values ('MarkMendez', 123450678, 'Mark Mendez', '140 Southport Drive, Morrisville, NC 27560', 'mmendez@yahoo.com', '3395792080', 30003);
insert into Employee values ('LisaAlberti', 123405678, 'Lisa Alberti', '100 Valley Glen Drive, Morrisville, NC 27560', 'lalberti@yahoo.com', '3391126787', 30003);

-- Adding given Mechanics as Mechanics
-- Not including Compensation since it is stored in Service Center (But can it be different given min and max wage?)
-- What do we do about start date?
insert into Mechanic values (132457689, 30001);
insert into Mechanic values (314275869, 30001);
insert into Mechanic values (241368579, 30001);
insert into Mechanic values (423186759, 30002);
insert into Mechanic values (123789456, 30002);
insert into Mechanic values (789123456, 30002);
insert into Mechanic values (125689347, 30002);
insert into Mechanic values (347812569, 30003);
insert into Mechanic values (123456780, 30003);
insert into Mechanic values (123456708, 30003);
insert into Mechanic values (123456078, 30003);
insert into Mechanic values (123450678, 30003);
insert into Mechanic values (123405678, 30003);

-- -- Services tab
-- Inserting all listings from services tab. A listing has a name and a type.
insert into ServiceListing values ('Belt Replacement','r');
insert into ServiceListing values ('Engine Repair','r');
insert into ServiceListing values ('Exhaust Repair','r');
insert into ServiceListing values ('Muffler Repair','r');
insert into ServiceListing values ('Alternator Repair','r');
insert into ServiceListing values ('Power Lock Repair','r');
insert into ServiceListing values ('Axle Repair','r');
insert into ServiceListing values ('Tire Balancing','r');
insert into ServiceListing values ('Wheel Alignment','r');
insert into ServiceListing values ('Compressor Repair','r');

insert into ServiceListing values ('Evaporator Repair','mr');
insert into ServiceListing values ('Brake Repair','mr');

insert into ServiceListing values ('Oil Changes','m');
insert into ServiceListing values ('Filter Replacements','m');
insert into ServiceListing values ('Check Engine Light Diagnostics','m');
insert into ServiceListing values ('Suspension Repair','m');

-- Each item with a Service ID is put in to Services with its time
insert into Services values (101, 1);
insert into Services values (102, 5);
insert into Services values (103, 4);
insert into Services values (104, 2);
insert into Services values (105, 4);
insert into Services values (106, 5);
insert into Services values (107, 7);
insert into Services values (108, 3);
insert into Services values (109, 2);
insert into Services values (110, 1);
insert into Services values (111, 3);
insert into Services values (112, 4);
insert into Services values (113, 3);
insert into Services values (114, 6);
insert into Services values (115, 9);

-- Schedules are split from repair services
insert into Schedule values(113, 'A');
insert into Schedule values(114, 'B');
insert into Schedule values(115, 'C');

-- Schedules have ServiceListings
insert into ScheduleHasService values (113, 'Oil Changes');
insert into ScheduleHasService values (113, 'Filter Replacements');
insert into ScheduleHasService values (114, 'Oil Changes');
insert into ScheduleHasService values (114, 'Filter Replacements');
insert into ScheduleHasService values (114, 'Brake Repair');
insert into ScheduleHasService values (114, 'Check Engine Light Diagnostics');
insert into ScheduleHasService values (115, 'Oil Changes');
insert into ScheduleHasService values (115, 'Filter Replacements');
insert into ScheduleHasService values (115, 'Brake Repair');
insert into ScheduleHasService values (115, 'Check Engine Light Diagnostics');
insert into ScheduleHasService values (115, 'Suspension Repair');
insert into ScheduleHasService values (115, 'Evaporator Repair');

-- Repair Services have a category
insert into RepairService values (101, 'Engine Services');
insert into RepairService values (102, 'Engine Services');
insert into RepairService values (103, 'Exhaust Services');
insert into RepairService values (104, 'Exhaust Services');
insert into RepairService values (105, 'Electrical Services');
insert into RepairService values (106, 'Electrical Services');
insert into RepairService values (107, 'Transmission Services');
insert into RepairService values (108, 'Transmission Services');
insert into RepairService values (109, 'Tire Services');
insert into RepairService values (110, 'Tire Services');
insert into RepairService values (111, 'Heating and A/C Services');
insert into RepairService values (112, 'Heating and A/C Services');

-- Mapping RepairServices to ServiceListing (1:1 relaitionship)
insert into ServiceListingIsARepairService values(101, 'Belt Replacement');
insert into ServiceListingIsARepairService values(102, 'Engine Repair');
insert into ServiceListingIsARepairService values(103, 'Exhaust Repair');
insert into ServiceListingIsARepairService values(104, 'Muffler Repair');
insert into ServiceListingIsARepairService values(105, 'Alternator Repair');
insert into ServiceListingIsARepairService values(106, 'Power Lock Repair');
insert into ServiceListingIsARepairService values(107, 'Axle Repair');
insert into ServiceListingIsARepairService values(108, 'Brake Repair');
insert into ServiceListingIsARepairService values(109, 'Tire Balancing');
insert into ServiceListingIsARepairService values(110, 'Wheel Alignment');
insert into ServiceListingIsARepairService values(111, 'Compressor Repair');
insert into ServiceListingIsARepairService values(112, 'Evaporator Repair');

-- Inserting vehicle models that can be serviced 
insert into ServiceableVehicles values ('Honda');
insert into ServiceableVehicles values ('Nissan');
insert into ServiceableVehicles values ('Toyota');

-- Filling the service table which includes price for each service at each service center associated with each Vehicle 
-- How to insert 1096 records easily?
insert into service values ( 'Honda', 101, 30001, 140);
insert into service values ( 'Nissan', 101, 30001, 175);
insert into service values ( 'Toyota', 101, 30001, 160);
insert into service values ( 'Honda', 102, 30001, 400);
insert into service values ( 'Nissan', 102, 30001, 500);
insert into service values ( 'Toyota', 102, 30001, 450);
insert into service values ( 'Honda', 103, 30001, 590);
insert into service values ( 'Nissan', 103, 30001, 700);
insert into service values ( 'Toyota', 103, 30001, 680);
insert into service values ( 'Honda', 104, 30001, 140);
insert into service values ( 'Nissan', 104, 30001, 175);
insert into service values ( 'Toyota', 104, 30001, 160);
insert into service values ( 'Honda', 105, 30001, 400);
insert into service values ( 'Nissan', 105, 30001, 500);
insert into service values ( 'Toyota', 105, 30001, 450);
insert into service values ( 'Honda', 106, 30001, 400);
insert into service values ( 'Nissan', 106, 30001, 500);
insert into service values ( 'Toyota', 106, 30001, 450);
insert into service values ( 'Honda', 107, 30001, 1000);
insert into service values ( 'Nissan', 107, 30001, 1200);
insert into service values ( 'Toyota', 107, 30001, 1100);
insert into service values ( 'Honda', 108, 30001, 400);
insert into service values ( 'Nissan', 108, 30001, 500);
insert into service values ( 'Toyota', 108, 30001, 450);
insert into service values ( 'Honda', 109, 30001, 50);
insert into service values ( 'Nissan', 109, 30001, 70);
insert into service values ( 'Toyota', 109, 30001, 60);
insert into service values ( 'Honda', 110, 30001, 140);
insert into service values ( 'Nissan', 110, 30001, 175);
insert into service values ( 'Toyota', 110, 30001, 160);
insert into service values ( 'Honda', 111, 30001, 590);
insert into service values ( 'Nissan', 111, 30001, 700);
insert into service values ( 'Toyota', 111, 30001, 680);
insert into service values ( 'Honda', 112, 30001, 400);
insert into service values ( 'Nissan', 112, 30001, 500);
insert into service values ( 'Toyota', 112, 30001, 450);
insert into service values ( 'Honda', 113, 30001, 120);
insert into service values ( 'Nissan', 113, 30001, 190);
insert into service values ( 'Toyota', 113, 30001, 200);
insert into service values ( 'Honda', 114, 30001, 195);
insert into service values ( 'Nissan', 114, 30001, 210);
insert into service values ( 'Toyota', 114, 30001, 215);
insert into service values ( 'Honda', 115, 30001, 300);
insert into service values ( 'Nissan', 115, 30001, 310);
insert into service values ( 'Toyota', 115, 30001, 305);
insert into service values ( 'Honda', 101, 30002, 160);
insert into service values ( 'Nissan', 101, 30002, 195);
insert into service values ( 'Toyota', 101, 30002, 180);
insert into service values ( 'Honda', 102, 30002, 420);
insert into service values ( 'Nissan', 102, 30002, 520);
insert into service values ( 'Toyota', 102, 30002, 470);
insert into service values ( 'Honda', 103, 30002, 610);
insert into service values ( 'Nissan', 103, 30002, 720);
insert into service values ( 'Toyota', 103, 30002, 700);
insert into service values ( 'Honda', 104, 30002, 160);
insert into service values ( 'Nissan', 104, 30002, 195);
insert into service values ( 'Toyota', 104, 30002, 180);
insert into service values ( 'Honda', 105, 30002, 420);
insert into service values ( 'Nissan', 105, 30002, 520);
insert into service values ( 'Toyota', 105, 30002, 470);
insert into service values ( 'Honda', 106, 30002, 420);
insert into service values ( 'Nissan', 106, 30002, 520);
insert into service values ( 'Toyota', 106, 30002, 470);
insert into service values ( 'Honda', 107, 30002, 1020);
insert into service values ( 'Nissan', 107, 30002, 1220);
insert into service values ( 'Toyota', 107, 30002, 1120);
insert into service values ( 'Honda', 108, 30002, 420);
insert into service values ( 'Nissan', 108, 30002, 520);
insert into service values ( 'Toyota', 108, 30002, 470);
insert into service values ( 'Honda', 109, 30002, 70);
insert into service values ( 'Nissan', 109, 30002, 90);
insert into service values ( 'Toyota', 109, 30002, 80);
insert into service values ( 'Honda', 110, 30002, 160);
insert into service values ( 'Nissan', 110, 30002, 195);
insert into service values ( 'Toyota', 110, 30002, 180);
insert into service values ( 'Honda', 111, 30002, 610);
insert into service values ( 'Nissan', 111, 30002, 720);
insert into service values ( 'Toyota', 111, 30002, 700);
insert into service values ( 'Honda', 112, 30002, 420);
insert into service values ( 'Nissan', 112, 30002, 520);
insert into service values ( 'Toyota', 112, 30002, 470);
insert into service values ( 'Honda', 113, 30002, 125);
insert into service values ( 'Nissan', 113, 30002, 195);
insert into service values ( 'Toyota', 113, 30002, 205);
insert into service values ( 'Honda', 114, 30002, 200);
insert into service values ( 'Nissan', 114, 30002, 215);
insert into service values ( 'Toyota', 114, 30002, 220);
insert into service values ( 'Honda', 115, 30002, 305);
insert into service values ( 'Nissan', 115, 30002, 315);
insert into service values ( 'Toyota', 115, 30002, 310);
insert into service values ( 'Honda', 101, 30003, 175);
insert into service values ( 'Nissan', 101, 30003, 210);
insert into service values ( 'Toyota', 101, 30003, 195);
insert into service values ( 'Honda', 102, 30003, 435);
insert into service values ( 'Nissan', 102, 30003, 535);
insert into service values ( 'Toyota', 102, 30003, 485);
insert into service values ( 'Honda', 103, 30003, 625);
insert into service values ( 'Nissan', 103, 30003, 735);
insert into service values ( 'Toyota', 103, 30003, 715);
insert into service values ( 'Honda', 104, 30003, 175);
insert into service values ( 'Nissan', 104, 30003, 210);
insert into service values ( 'Toyota', 104, 30003, 195);
insert into service values ( 'Honda', 105, 30003, 435);
insert into service values ( 'Nissan', 105, 30003, 535);
insert into service values ( 'Toyota', 105, 30003, 485);
insert into service values ( 'Honda', 106, 30003, 435);
insert into service values ( 'Nissan', 106, 30003, 535);
insert into service values ( 'Toyota', 106, 30003, 485);
insert into service values ( 'Honda', 107, 30003, 1035);
insert into service values ( 'Nissan', 107, 30003, 1235);
insert into service values ( 'Toyota', 107, 30003, 1135);
insert into service values ( 'Honda', 108, 30003, 435);
insert into service values ( 'Nissan', 108, 30003, 535);
insert into service values ( 'Toyota', 108, 30003, 485);
insert into service values ( 'Honda', 109, 30003, 85);
insert into service values ( 'Nissan', 109, 30003, 105);
insert into service values ( 'Toyota', 109, 30003, 95);
insert into service values ( 'Honda', 110, 30003, 175);
insert into service values ( 'Nissan', 110, 30003, 210);
insert into service values ( 'Toyota', 110, 30003, 195);
insert into service values ( 'Honda', 111, 30003, 625);
insert into service values ( 'Nissan', 111, 30003, 735);
insert into service values ( 'Toyota', 111, 30003, 715);
insert into service values ( 'Honda', 112, 30003, 435);
insert into service values ( 'Nissan', 112, 30003, 535);
insert into service values ( 'Toyota', 112, 30003, 485);
insert into service values ( 'Honda', 113, 30003, 140);
insert into service values ( 'Nissan', 113, 30003, 180);
insert into service values ( 'Toyota', 113, 30003, 195);
insert into service values ( 'Honda', 114, 30003, 210);
insert into service values ( 'Nissan', 114, 30003, 220);
insert into service values ( 'Toyota', 114, 30003, 215);
insert into service values ( 'Honda', 115, 30003, 310);
insert into service values ( 'Nissan', 115, 30003, 305);
insert into service values ( 'Toyota', 115, 30003, 310);

-- -- Customers tab
insert into Users values ('PeterParker','PeterParker');
insert into Users values ('DianaPrince','DianaPrince');
insert into Users values ('BillyBatson','BillyBatson');
insert into Users values ('BruceWayne','BruceWayne');
insert into Users values ('SteveRogers','SteveRogers');
insert into Users values ('HappyHogan','HappyHogan');
insert into Users values ('TonyStark','TonyStark');
insert into Users values ('NatashaRomanoff','NatashaRomanoff');
insert into Users values ('HarveyBullock','HarveyBullock');
insert into Users values ('SamWilson','SamWilson');
insert into Users values ('WandaMaximoff','WandaMaximoff');
insert into Users values ('VirginiaPotts','VirginiaPotts');

-- Adding given customers as Customers
insert into Customer values ('PeterParker', 10001, 'Peter Parker', NULL, NULL, NULL, '1', 30001);
insert into Customer values ('DianaPrince', 10002, 'Diana Prince', NULL, NULL, NULL, '1', 30001);
insert into Customer values ('BillyBatson', 10053, 'Billy Batson', NULL, NULL, NULL, '1', 30002);
insert into Customer values ('BruceWayne', 10010, 'Bruce Wayne', NULL, NULL, NULL, '1', 30002);
insert into Customer values ('SteveRogers', 10001, 'Steve Rogers', NULL, NULL, NULL, '1', 30002);
insert into Customer values ('HappyHogan', 10035, 'Happy Hogan', NULL, NULL, NULL, '1', 30002);
insert into Customer values ('TonyStark', 10002, 'Tony Stark', NULL, NULL, NULL, '1', 30003);
insert into Customer values ('NatashaRomanoff', 10003, 'Natasha Romanoff', NULL, NULL, NULL, '1', 30003);
insert into Customer values ('HarveyBullock', 10011, 'Harvey Bullock', NULL, NULL, NULL, '1', 30003);
insert into Customer values ('SamWilson', 10062, 'Sam Wilson', NULL, NULL, NULL, '1', 30003);
insert into Customer values ('WandaMaximoff', 10501, 'Wanda Maximoff', NULL, NULL, NULL, '1', 30003);
insert into Customer values ('VirginiaPotts', 10010, 'Virginia Potts', NULL, NULL, NULL, '1', 30003);

-- Adding Vehicles mentioned for each Customer
insert into Vehicle values ('4Y1BL658', 'Toyota', 53000, 'B', 2007);
insert into Vehicle values ('7A1ST264', 'Honda', 117000, 'A', 1999);
insert into Vehicle values ('5TR3K914', 'Nissan', 111000, 'C', 2015);
insert into Vehicle values ('15DC9A87', 'Toyota', 21000, 'A', 2020);
insert into Vehicle values ('18S5R2D8', 'Nissan', 195500, 'C', 2019);
insert into Vehicle values ('9R2UHP54', 'Honda', 67900, 'B', 2013);
insert into Vehicle values ('88TSM888', 'Honda', 10000, 'A', 2000);
insert into Vehicle values ('71HK2D89', 'Toyota', 195550, 'B', 2004);
insert into Vehicle values ('34KLE19D', 'Toyota', 123800, 'C', 2010);
insert into Vehicle values ('29T56WC3', 'Nissan', 51300, 'A', 2011);
insert into Vehicle values ('P39VN198', 'Nissan', 39500, 'B', 2013);
insert into Vehicle values ('39YVS415', 'Honda', 49900, 'A', 2021);

-- Assigning Vehicles to Customers in the owns table
insert into owns values(10001, '4Y1BL658', 30001);
insert into owns values(10002, '7A1ST264', 30001);
insert into owns values(10053, '5TR3K914', 30002);
insert into owns values(10010, '15DC9A87', 30002);
insert into owns values(10001, '18S5R2D8', 30002);
insert into owns values(10035, '9R2UHP54', 30002);
insert into owns values(10002, '88TSM888', 30003);
insert into owns values(10003, '71HK2D89', 30003);
insert into owns values(10011, '34KLE19D', 30003);
insert into owns values(10062, '29T56WC3', 30003);
insert into owns values(10501, 'P39VN198', 30003);
insert into owns values(10010, '39YVS415', 30003);

-- -- ScheduledServices tab
-- Populating Timeslots for the month
insert into Timeslot values ( 1, 1, 1, 1);
insert into Timeslot values ( 2, 2, 1, 1);
insert into Timeslot values ( 3, 3, 1, 1);
insert into Timeslot values ( 4, 4, 1, 1);
insert into Timeslot values ( 5, 5, 1, 1);
insert into Timeslot values ( 6, 6, 1, 1);
insert into Timeslot values ( 7, 7, 1, 1);
insert into Timeslot values ( 8, 8, 1, 1);
insert into Timeslot values ( 9, 9, 1, 1);
insert into Timeslot values ( 10, 10, 1, 1);
insert into Timeslot values ( 11, 11, 1, 1);
insert into Timeslot values ( 12, 1, 1, 2);
insert into Timeslot values ( 13, 2, 1, 2);
insert into Timeslot values ( 14, 3, 1, 2);
insert into Timeslot values ( 15, 4, 1, 2);
insert into Timeslot values ( 16, 5, 1, 2);
insert into Timeslot values ( 17, 6, 1, 2);
insert into Timeslot values ( 18, 7, 1, 2);
insert into Timeslot values ( 19, 8, 1, 2);
insert into Timeslot values ( 20, 9, 1, 2);
insert into Timeslot values ( 21, 10, 1, 2);
insert into Timeslot values ( 22, 11, 1, 2);
insert into Timeslot values ( 23, 1, 1, 3);
insert into Timeslot values ( 24, 2, 1, 3);
insert into Timeslot values ( 25, 3, 1, 3);
insert into Timeslot values ( 26, 4, 1, 3);
insert into Timeslot values ( 27, 5, 1, 3);
insert into Timeslot values ( 28, 6, 1, 3);
insert into Timeslot values ( 29, 7, 1, 3);
insert into Timeslot values ( 30, 8, 1, 3);
insert into Timeslot values ( 31, 9, 1, 3);
insert into Timeslot values ( 32, 10, 1, 3);
insert into Timeslot values ( 33, 11, 1, 3);
insert into Timeslot values ( 34, 1, 1, 4);
insert into Timeslot values ( 35, 2, 1, 4);
insert into Timeslot values ( 36, 3, 1, 4);
insert into Timeslot values ( 37, 4, 1, 4);
insert into Timeslot values ( 38, 5, 1, 4);
insert into Timeslot values ( 39, 6, 1, 4);
insert into Timeslot values ( 40, 7, 1, 4);
insert into Timeslot values ( 41, 8, 1, 4);
insert into Timeslot values ( 42, 9, 1, 4);
insert into Timeslot values ( 43, 10, 1, 4);
insert into Timeslot values ( 44, 11, 1, 4);
insert into Timeslot values ( 45, 1, 1, 5);
insert into Timeslot values ( 46, 2, 1, 5);
insert into Timeslot values ( 47, 3, 1, 5);
insert into Timeslot values ( 48, 4, 1, 5);
insert into Timeslot values ( 49, 5, 1, 5);
insert into Timeslot values ( 50, 6, 1, 5);
insert into Timeslot values ( 51, 7, 1, 5);
insert into Timeslot values ( 52, 8, 1, 5);
insert into Timeslot values ( 53, 9, 1, 5);
insert into Timeslot values ( 54, 10, 1, 5);
insert into Timeslot values ( 55, 11, 1, 5);
insert into Timeslot values ( 56, 1, 1, 6);
insert into Timeslot values ( 57, 2, 1, 6);
insert into Timeslot values ( 58, 3, 1, 6);
insert into Timeslot values ( 59, 4, 1, 6);
insert into Timeslot values ( 60, 5, 1, 6);
insert into Timeslot values ( 61, 6, 1, 6);
insert into Timeslot values ( 62, 7, 1, 6);
insert into Timeslot values ( 63, 8, 1, 6);
insert into Timeslot values ( 64, 9, 1, 6);
insert into Timeslot values ( 65, 10, 1, 6);
insert into Timeslot values ( 66, 11, 1, 6);
insert into Timeslot values ( 67, 1, 1, 7);
insert into Timeslot values ( 68, 2, 1, 7);
insert into Timeslot values ( 69, 3, 1, 7);
insert into Timeslot values ( 70, 4, 1, 7);
insert into Timeslot values ( 71, 5, 1, 7);
insert into Timeslot values ( 72, 6, 1, 7);
insert into Timeslot values ( 73, 7, 1, 7);
insert into Timeslot values ( 74, 8, 1, 7);
insert into Timeslot values ( 75, 9, 1, 7);
insert into Timeslot values ( 76, 10, 1, 7);
insert into Timeslot values ( 77, 11, 1, 7);
insert into Timeslot values ( 78, 1, 2, 1);
insert into Timeslot values ( 79, 2, 2, 1);
insert into Timeslot values ( 80, 3, 2, 1);
insert into Timeslot values ( 81, 4, 2, 1);
insert into Timeslot values ( 82, 5, 2, 1);
insert into Timeslot values ( 83, 6, 2, 1);
insert into Timeslot values ( 84, 7, 2, 1);
insert into Timeslot values ( 85, 8, 2, 1);
insert into Timeslot values ( 86, 9, 2, 1);
insert into Timeslot values ( 87, 10, 2, 1);
insert into Timeslot values ( 88, 11, 2, 1);
insert into Timeslot values ( 89, 1, 2, 2);
insert into Timeslot values ( 90, 2, 2, 2);
insert into Timeslot values ( 91, 3, 2, 2);
insert into Timeslot values ( 92, 4, 2, 2);
insert into Timeslot values ( 93, 5, 2, 2);
insert into Timeslot values ( 94, 6, 2, 2);
insert into Timeslot values ( 95, 7, 2, 2);
insert into Timeslot values ( 96, 8, 2, 2);
insert into Timeslot values ( 97, 9, 2, 2);
insert into Timeslot values ( 98, 10, 2, 2);
insert into Timeslot values ( 99, 11, 2, 2);
insert into Timeslot values ( 100, 1, 2, 3);
insert into Timeslot values ( 101, 2, 2, 3);
insert into Timeslot values ( 102, 3, 2, 3);
insert into Timeslot values ( 103, 4, 2, 3);
insert into Timeslot values ( 104, 5, 2, 3);
insert into Timeslot values ( 105, 6, 2, 3);
insert into Timeslot values ( 106, 7, 2, 3);
insert into Timeslot values ( 107, 8, 2, 3);
insert into Timeslot values ( 108, 9, 2, 3);
insert into Timeslot values ( 109, 10, 2, 3);
insert into Timeslot values ( 110, 11, 2, 3);
insert into Timeslot values ( 111, 1, 2, 4);
insert into Timeslot values ( 112, 2, 2, 4);
insert into Timeslot values ( 113, 3, 2, 4);
insert into Timeslot values ( 114, 4, 2, 4);
insert into Timeslot values ( 115, 5, 2, 4);
insert into Timeslot values ( 116, 6, 2, 4);
insert into Timeslot values ( 117, 7, 2, 4);
insert into Timeslot values ( 118, 8, 2, 4);
insert into Timeslot values ( 119, 9, 2, 4);
insert into Timeslot values ( 120, 10, 2, 4);
insert into Timeslot values ( 121, 11, 2, 4);
insert into Timeslot values ( 122, 1, 2, 5);
insert into Timeslot values ( 123, 2, 2, 5);
insert into Timeslot values ( 124, 3, 2, 5);
insert into Timeslot values ( 125, 4, 2, 5);
insert into Timeslot values ( 126, 5, 2, 5);
insert into Timeslot values ( 127, 6, 2, 5);
insert into Timeslot values ( 128, 7, 2, 5);
insert into Timeslot values ( 129, 8, 2, 5);
insert into Timeslot values ( 130, 9, 2, 5);
insert into Timeslot values ( 131, 10, 2, 5);
insert into Timeslot values ( 132, 11, 2, 5);
insert into Timeslot values ( 133, 1, 2, 6);
insert into Timeslot values ( 134, 2, 2, 6);
insert into Timeslot values ( 135, 3, 2, 6);
insert into Timeslot values ( 136, 4, 2, 6);
insert into Timeslot values ( 137, 5, 2, 6);
insert into Timeslot values ( 138, 6, 2, 6);
insert into Timeslot values ( 139, 7, 2, 6);
insert into Timeslot values ( 140, 8, 2, 6);
insert into Timeslot values ( 141, 9, 2, 6);
insert into Timeslot values ( 142, 10, 2, 6);
insert into Timeslot values ( 143, 11, 2, 6);
insert into Timeslot values ( 144, 1, 2, 7);
insert into Timeslot values ( 145, 2, 2, 7);
insert into Timeslot values ( 146, 3, 2, 7);
insert into Timeslot values ( 147, 4, 2, 7);
insert into Timeslot values ( 148, 5, 2, 7);
insert into Timeslot values ( 149, 6, 2, 7);
insert into Timeslot values ( 150, 7, 2, 7);
insert into Timeslot values ( 151, 8, 2, 7);
insert into Timeslot values ( 152, 9, 2, 7);
insert into Timeslot values ( 153, 10, 2, 7);
insert into Timeslot values ( 154, 11, 2, 7);
insert into Timeslot values ( 155, 1, 3, 1);
insert into Timeslot values ( 156, 2, 3, 1);
insert into Timeslot values ( 157, 3, 3, 1);
insert into Timeslot values ( 158, 4, 3, 1);
insert into Timeslot values ( 159, 5, 3, 1);
insert into Timeslot values ( 160, 6, 3, 1);
insert into Timeslot values ( 161, 7, 3, 1);
insert into Timeslot values ( 162, 8, 3, 1);
insert into Timeslot values ( 163, 9, 3, 1);
insert into Timeslot values ( 164, 10, 3, 1);
insert into Timeslot values ( 165, 11, 3, 1);
insert into Timeslot values ( 166, 1, 3, 2);
insert into Timeslot values ( 167, 2, 3, 2);
insert into Timeslot values ( 168, 3, 3, 2);
insert into Timeslot values ( 169, 4, 3, 2);
insert into Timeslot values ( 170, 5, 3, 2);
insert into Timeslot values ( 171, 6, 3, 2);
insert into Timeslot values ( 172, 7, 3, 2);
insert into Timeslot values ( 173, 8, 3, 2);
insert into Timeslot values ( 174, 9, 3, 2);
insert into Timeslot values ( 175, 10, 3, 2);
insert into Timeslot values ( 176, 11, 3, 2);
insert into Timeslot values ( 177, 1, 3, 3);
insert into Timeslot values ( 178, 2, 3, 3);
insert into Timeslot values ( 179, 3, 3, 3);
insert into Timeslot values ( 180, 4, 3, 3);
insert into Timeslot values ( 181, 5, 3, 3);
insert into Timeslot values ( 182, 6, 3, 3);
insert into Timeslot values ( 183, 7, 3, 3);
insert into Timeslot values ( 184, 8, 3, 3);
insert into Timeslot values ( 185, 9, 3, 3);
insert into Timeslot values ( 186, 10, 3, 3);
insert into Timeslot values ( 187, 11, 3, 3);
insert into Timeslot values ( 188, 1, 3, 4);
insert into Timeslot values ( 189, 2, 3, 4);
insert into Timeslot values ( 190, 3, 3, 4);
insert into Timeslot values ( 191, 4, 3, 4);
insert into Timeslot values ( 192, 5, 3, 4);
insert into Timeslot values ( 193, 6, 3, 4);
insert into Timeslot values ( 194, 7, 3, 4);
insert into Timeslot values ( 195, 8, 3, 4);
insert into Timeslot values ( 196, 9, 3, 4);
insert into Timeslot values ( 197, 10, 3, 4);
insert into Timeslot values ( 198, 11, 3, 4);
insert into Timeslot values ( 199, 1, 3, 5);
insert into Timeslot values ( 200, 2, 3, 5);
insert into Timeslot values ( 201, 3, 3, 5);
insert into Timeslot values ( 202, 4, 3, 5);
insert into Timeslot values ( 203, 5, 3, 5);
insert into Timeslot values ( 204, 6, 3, 5);
insert into Timeslot values ( 205, 7, 3, 5);
insert into Timeslot values ( 206, 8, 3, 5);
insert into Timeslot values ( 207, 9, 3, 5);
insert into Timeslot values ( 208, 10, 3, 5);
insert into Timeslot values ( 209, 11, 3, 5);
insert into Timeslot values ( 210, 1, 3, 6);
insert into Timeslot values ( 211, 2, 3, 6);
insert into Timeslot values ( 212, 3, 3, 6);
insert into Timeslot values ( 213, 4, 3, 6);
insert into Timeslot values ( 214, 5, 3, 6);
insert into Timeslot values ( 215, 6, 3, 6);
insert into Timeslot values ( 216, 7, 3, 6);
insert into Timeslot values ( 217, 8, 3, 6);
insert into Timeslot values ( 218, 9, 3, 6);
insert into Timeslot values ( 219, 10, 3, 6);
insert into Timeslot values ( 220, 11, 3, 6);
insert into Timeslot values ( 221, 1, 3, 7);
insert into Timeslot values ( 222, 2, 3, 7);
insert into Timeslot values ( 223, 3, 3, 7);
insert into Timeslot values ( 224, 4, 3, 7);
insert into Timeslot values ( 225, 5, 3, 7);
insert into Timeslot values ( 226, 6, 3, 7);
insert into Timeslot values ( 227, 7, 3, 7);
insert into Timeslot values ( 228, 8, 3, 7);
insert into Timeslot values ( 229, 9, 3, 7);
insert into Timeslot values ( 230, 10, 3, 7);
insert into Timeslot values ( 231, 11, 3, 7);
insert into Timeslot values ( 232, 1, 4, 1);
insert into Timeslot values ( 233, 2, 4, 1);
insert into Timeslot values ( 234, 3, 4, 1);
insert into Timeslot values ( 235, 4, 4, 1);
insert into Timeslot values ( 236, 5, 4, 1);
insert into Timeslot values ( 237, 6, 4, 1);
insert into Timeslot values ( 238, 7, 4, 1);
insert into Timeslot values ( 239, 8, 4, 1);
insert into Timeslot values ( 240, 9, 4, 1);
insert into Timeslot values ( 241, 10, 4, 1);
insert into Timeslot values ( 242, 11, 4, 1);
insert into Timeslot values ( 243, 1, 4, 2);
insert into Timeslot values ( 244, 2, 4, 2);
insert into Timeslot values ( 245, 3, 4, 2);
insert into Timeslot values ( 246, 4, 4, 2);
insert into Timeslot values ( 247, 5, 4, 2);
insert into Timeslot values ( 248, 6, 4, 2);
insert into Timeslot values ( 249, 7, 4, 2);
insert into Timeslot values ( 250, 8, 4, 2);
insert into Timeslot values ( 251, 9, 4, 2);
insert into Timeslot values ( 252, 10, 4, 2);
insert into Timeslot values ( 253, 11, 4, 2);
insert into Timeslot values ( 254, 1, 4, 3);
insert into Timeslot values ( 255, 2, 4, 3);
insert into Timeslot values ( 256, 3, 4, 3);
insert into Timeslot values ( 257, 4, 4, 3);
insert into Timeslot values ( 258, 5, 4, 3);
insert into Timeslot values ( 259, 6, 4, 3);
insert into Timeslot values ( 260, 7, 4, 3);
insert into Timeslot values ( 261, 8, 4, 3);
insert into Timeslot values ( 262, 9, 4, 3);
insert into Timeslot values ( 263, 10, 4, 3);
insert into Timeslot values ( 264, 11, 4, 3);
insert into Timeslot values ( 265, 1, 4, 4);
insert into Timeslot values ( 266, 2, 4, 4);
insert into Timeslot values ( 267, 3, 4, 4);
insert into Timeslot values ( 268, 4, 4, 4);
insert into Timeslot values ( 269, 5, 4, 4);
insert into Timeslot values ( 270, 6, 4, 4);
insert into Timeslot values ( 271, 7, 4, 4);
insert into Timeslot values ( 272, 8, 4, 4);
insert into Timeslot values ( 273, 9, 4, 4);
insert into Timeslot values ( 274, 10, 4, 4);
insert into Timeslot values ( 275, 11, 4, 4);
insert into Timeslot values ( 276, 1, 4, 5);
insert into Timeslot values ( 277, 2, 4, 5);
insert into Timeslot values ( 278, 3, 4, 5);
insert into Timeslot values ( 279, 4, 4, 5);
insert into Timeslot values ( 280, 5, 4, 5);
insert into Timeslot values ( 281, 6, 4, 5);
insert into Timeslot values ( 282, 7, 4, 5);
insert into Timeslot values ( 283, 8, 4, 5);
insert into Timeslot values ( 284, 9, 4, 5);
insert into Timeslot values ( 285, 10, 4, 5);
insert into Timeslot values ( 286, 11, 4, 5);
insert into Timeslot values ( 287, 1, 4, 6);
insert into Timeslot values ( 288, 2, 4, 6);
insert into Timeslot values ( 289, 3, 4, 6);
insert into Timeslot values ( 290, 4, 4, 6);
insert into Timeslot values ( 291, 5, 4, 6);
insert into Timeslot values ( 292, 6, 4, 6);
insert into Timeslot values ( 293, 7, 4, 6);
insert into Timeslot values ( 294, 8, 4, 6);
insert into Timeslot values ( 295, 9, 4, 6);
insert into Timeslot values ( 296, 10, 4, 6);
insert into Timeslot values ( 297, 11, 4, 6);
insert into Timeslot values ( 298, 1, 4, 7);
insert into Timeslot values ( 299, 2, 4, 7);
insert into Timeslot values ( 300, 3, 4, 7);
insert into Timeslot values ( 301, 4, 4, 7);
insert into Timeslot values ( 302, 5, 4, 7);
insert into Timeslot values ( 303, 6, 4, 7);
insert into Timeslot values ( 304, 7, 4, 7);
insert into Timeslot values ( 305, 8, 4, 7);
insert into Timeslot values ( 306, 9, 4, 7);
insert into Timeslot values ( 307, 10, 4, 7);
insert into Timeslot values ( 308, 11, 4, 7);

-- Booking required mechanics for the timeslot
insert into booked values (12, 123405678, 30003, '0');

insert into booked values (12, 123450678, 30003, '0');

 insert into booked values (1, 123456780,30003, '0');

insert into booked values (112, 423186759,30002, '0');
insert into booked values (113, 423186759,30002, '0');
insert into booked values (114, 423186759,30002, '0');
insert into booked values (115, 423186759,30002, '0');

insert into booked values (80, 125689347,30002, '0');
insert into booked values (81, 125689347,30002, '0');
insert into booked values (82, 125689347,30002, '0');

insert into booked values (134, 789123456,30002, '0');
insert into booked values (135, 789123456,30002, '0');
insert into booked values (136, 789123456,30002, '0');
insert into booked values (137, 789123456,30002, '0');
insert into booked values (138, 789123456,30002, '0');
insert into booked values (139, 789123456,30002, '0');

insert into booked values (203, 125689347,30002, '0');
insert into booked values (204, 125689347,30002, '0');
insert into booked values (205, 125689347,30002, '0');

-- Creating the relevant Invoices
insert into Invoice values (1, 210, '0', NULL);
insert into Invoice values (2, 175, '0', NULL);
insert into Invoice values (3, 105, '1', NULL);
insert into Invoice values (4, 420, '1', NULL);
insert into Invoice values (5, 720, '1', NULL);
insert into Invoice values (6, 220, '1', NULL);
insert into Invoice values (7, 195, '1', NULL);

-- Creating relevant service events
insert into ServiceEvent values (10501, 'P39VN198', 30003, 'Nissan', 110, 12 ,123405678, 1);
insert into ServiceEvent values (10010, '39YVS415', 30003, 'Honda', 101, 12 ,123450678, 2);
insert into ServiceEvent values (10062, '29T56WC3', 30003, 'Nissan', 109, 1 ,123456780, 3);
insert into ServiceEvent values (10035, '9R2UHP54', 30002, 'Honda', 105, 112 ,423186759, 4);
insert into ServiceEvent values (10053, '5TR3K914', 30002, 'Nissan', 111, 80 ,125689347, 5);
insert into ServiceEvent values (10010, '15DC9A87', 30002, 'Toyota', 114, 134 ,789123456, 6);
insert into ServiceEvent values (10001, '18S5R2D8', 30002, 'Nissan', 113, 203 ,125689347, 7);









	
	
	
	
	





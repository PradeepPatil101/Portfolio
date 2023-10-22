
drop table serviceEvent;

drop table Invoice;

drop table booked;

drop table swaps;

drop table Timeslot;

drop table Receptionist;

drop table Mechanic;

drop table Manager;

drop table Employee;

drop table service;

drop table ServiceableVehicles;

drop table ServiceListingIsARepairService;

drop table RepairService;

drop table ScheduleHasService;

drop table Schedule;

drop table Services;

drop table ServiceListing;

drop table owns;

drop table Vehicle;

drop table Customer;

drop table ServiceCenter;

drop table Users;































-- create table manages(
-- 	empId int,
-- 	centerId int,
-- 	primary key(empId, centerId),
-- 	foreign key (centerId) references ServiceCenter (centerId),
-- 	foreign key (empId) references Manager (empId)
-- );

-- create table isReceptionistAt(
-- 	empId int,
-- 	centerId int,
-- 	primary key(empId, centerId),
-- 	foreign key (centerId) references ServiceCenter (centerId),
-- 	foreign key (empId) references Receptionist (empId)
-- );











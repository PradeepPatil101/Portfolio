create table Users(
	userId varchar(20),
    password varchar(20),
    primary key(userId)
);

create table ServiceCenter(
	centerId int,
	address varchar(50), 
	phoneNumber varchar(10), -- changed data type
	openSaturday char(1),
    mechMinWage int, -- new
    mechMaxWage int, -- new
	hourlyRate int,
	primary key (centerId)
);

create table Customer(
	userId varchar(20),
	customerId int,
    name varchar(20),
    address varchar(50),
    email varchar(20),
    phoneNumber varchar(10),
    active char(1),
    centerId int,
    primary key (userId),
    foreign key (userId) references Users (userId) on delete cascade,
    unique (customerId, centerId),
    foreign key (centerId) references ServiceCenter (centerId) on delete cascade
);

create table Vehicle(
	vinNumber varchar(9),
	manufacturer varchar(20),
	miles int,
	lastMaintenanceService char,
	year int,
	primary key (vinNumber)
);

create table owns(
	customerId int NOT NULL,
	vinNumber varchar(9),
    centerId int,
	primary key (vinNumber,customerId, centerId),
	foreign key (vinNumber) references Vehicle (vinNumber) on delete cascade,
	foreign key (customerId, centerId) references Customer (customerId,centerId) on delete cascade
);

create table ServiceListing(
	name varchar(30),
	type varchar(3),
	primary key (name)
);

create table Services(
	serviceId int,
	time int,
	primary key (serviceId)
);

create table Schedule(
	serviceId int,	
	scheduleType char unique,
	primary key (serviceId),
	foreign key (serviceId) references Services (serviceId)
);

create table ScheduleHasService(
	serviceId int,	
    name varchar(30),
    primary key (serviceId, name),
    foreign key (serviceId) references Schedule (serviceId) on delete cascade,
    foreign key (name) references ServiceListing (name)
);

create table RepairService(
	serviceId int,	
	category varchar(30),
	primary key (serviceId),
	foreign key (serviceId) references Services (serviceId) on delete cascade
);

create table ServiceListingIsARepairService(
	serviceId int,	
    name varchar(30),
    primary key (serviceId, name),
    foreign key (serviceId) references RepairService (serviceId) on delete cascade,
    foreign key (name) references ServiceListing (name)
);

create table ServiceableVehicles(
	model varchar(10),
    primary key (model)
);

create table service(
	model varchar(10),
	serviceId int,
	centerId int,
	cost int,
	primary key(model, centerId, serviceId),
	foreign key (model) references ServiceableVehicles (model) on delete cascade,
	foreign key (centerId) references ServiceCenter (centerId) on delete cascade,
	foreign key (serviceId) references Services (serviceId) on delete cascade
);

create table Employee(
	userId varchar(20),
	empId int,
	name varchar(20),
	address varchar(50),
	email varchar(20),
	phoneNumber varchar(10), -- Changed to varchar
	centerId int,
    primary key(userId),
	unique (empId, centerId),
    foreign key (userId) references Users (userId) on delete cascade,
	foreign key (centerId) references ServiceCenter (centerId) on delete cascade
);

create table Manager(
	empId int,
	centerId int,
	salary int,
	primary key(empId, centerId),
	foreign key (empId, centerId) references Employee (empId, centerId) on delete cascade
);

create table Receptionist(
	empId int,
	centerId int,
	salary int,
	primary key(empId, centerId),
	foreign key (empId, centerId) references Employee (empId, centerId) on delete cascade
);

create table Mechanic(
	empId int,
    centerId int,
	primary key(empId, centerId),
	foreign key (empId, centerId) references Employee (empId, centerId) on delete cascade
);

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

-- Month and year not needed so I removed it
create table Timeslot(
	slotId int,
	slot int,
    week int,
	day int,
    primary key(slotId)
);

create table booked(
	slotId int,
    empId int,
	centerId int,
    isTimeOff char(1),
    primary key(slotId, empId, centerId),
    foreign key (slotId) references Timeslot (slotId),
	foreign key (empId,centerId) references Mechanic (empId, centerId)
);

create table swaps(
	referenceId int,
	startSlotId int,
	endSlotId int,
	takeStartSlotId int,
	takeEndSlotId int,
    askId int,
	answerId int,
	centerId int,
	requestStatus varchar(10),
    primary key(referenceId),
    foreign key (startSlotId) references Timeslot (slotId),
	foreign key (endSlotId) references Timeslot (slotId),
	foreign key (askId, centerId) references Mechanic (empId, centerId),
	foreign key (answerId, centerId) references Mechanic (empId, centerId)
);


create table Invoice(
	invoiceId int,
    bill float,
    paid char(1),
    invoiceDate date,
    primary key(invoiceId)
);

create table serviceEvent(
	customerId int NOT NULL,
	vinNumber varchar(9),
    centerId int,
    model varchar(10),
	serviceId int,
    startSlotId int,
    empId int,
    invoiceId int,
    primary key(customerId, vinNumber, centerId, model, serviceId, startSlotId, empId, invoiceId),
     foreign key (vinNumber,customerId, centerId) references owns (vinNumber,customerId, centerId) on delete cascade,
 	foreign key (centerId, model, serviceId) references service (centerId, model, serviceId) on delete cascade,
 	foreign key (startSlotId, empId, centerId) references booked (slotId, empId, centerId),
     foreign key (invoiceId) references Invoice (invoiceId)
);






-- 1. Which service center has the most number of customers?
SELECT centerId
FROM(
    SELECT centerId, COUNT(customerId) as customerCount
    FROM Customer
    GROUP BY centerId
    )
WHERE customerCount = (
    SELECT MAX(customerCount)
    FROM(
    SELECT centerId, COUNT(customerId) as customerCount
    FROM Customer
    GROUP BY centerId
    )
);

-- 2. What is the average price of an Evaporator Repair for Hondas across all service centers?
SELECT AVG(S.cost)
FROM service S, ServiceListingIsARepairService R
WHERE S.serviceId = R.serviceId AND R.name = 'Evaporator Repair' AND S.model = 'Honda';

-- 3. Which customer(s) have unpaid invoices in Service Center 30003
SELECT s.customerId
FROM serviceEvent s, Invoice i
WHERE s.invoiceId = i.invoiceId AND i.paid = '0' AND s.centerId = 30003;

-- 4. List all services that are listed as both maintenance and repair services globally.
SELECT name
FROM ServiceListing
WHERE type = 'mr';

-- 5. What is the difference between the cost of doing a belt replacement + schedule A on a Toyota at center 30001 vs 30002?
SELECT ABS(
   ((SELECT cost
    FROM service S, ServiceListingIsARepairService R
    WHERE S.serviceId = R.serviceId AND R.name = 'Belt Replacement' AND S.model = 'Toyota' AND S.centerId = 30001
   ) +
   (SELECT cost
   FROM service S, Schedule S1
   WHERE S.serviceId = S1.serviceId AND S1.scheduleType = 'A' AND S.model = 'Toyota' AND S.centerId = 30001
   ))
   -
   ((SELECT cost
    FROM service S, ServiceListingIsARepairService R
    WHERE S.serviceId = R.serviceId AND R.name = 'Belt Replacement' AND S.model = 'Toyota' AND S.centerId = 30002
   ) +
   (SELECT cost
   FROM service S, Schedule S1
   WHERE S.serviceId = S1.serviceId AND S1.scheduleType = 'A' AND S.model = 'Toyota' AND S.centerId = 30002
   ))
) AS diff
FROM dual;

-- 6. What is the next eligible maintenance schedule service for the car with VIN 34KLE19D
SELECT lastMaintenanceService,
CASE
  WHEN lastMaintenanceService = 'A' THEN 'B'
  WHEN lastMaintenanceService = 'B' THEN 'C'
  WHEN lastMaintenanceService = 'C' THEN 'A'
END AS nextMaintenanceService
FROM Vehicle
WHERE vinNumber = '34KLE19D';

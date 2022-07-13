SELECT * FROM  employee;
SELECT * FROM  employee_job;
SELECT * FROM  job_responsibility;

SELECT * FROM  customer;

SELECT * FROM  visa;
SELECT * FROM  employee_visa;
SELECT * FROM  customer_visa;

SELECT * FROM  inoculation;
SELECT * FROM  employee_inoculation;
SELECT * FROM  customer_inoculation;

SELECT * FROM  destination;
SELECT * FROM  destination_inoculation;
SELECT * FROM  destination_visa;

SELECT * FROM  trip;
SELECT * FROM  trip_excursion;
SELECT * FROM  excursion;

SELECT * FROM  employee_trip;
SELECT * FROM  customer_trip;

SELECT * FROM  employee_order;
SELECT * FROM  customer_order;

SELECT * FROM  item_type;
SELECT * FROM  item;
SELECT * FROM  trip_item;



--Report of destinations and how many trips each has
select * from trip;
select * from destination;
select * from customer_trip;

--number of group trips to each region/destination
SELECT  D.region AS 'Region', COUNT(T.trip_id) AS 'Total Trips'
FROM trip AS T
RIGHT JOIN destination AS D 
    ON T.destination_id = D.destination_id
GROUP by D.region
ORDER by D.region;

--number of customer trips to each region/destination
SELECT D.region AS 'Region', COUNT(CT.customer_trip_id) AS 'Total Customer Trips'
FROM customer_trip AS CT 
RIGHT JOIN trip AS T
    ON CT.trip_id = T.trip_id
RIGHT JOIN destination AS D 
    ON T.destination_id = D.destination_id
GROUP by D.region
ORDER by D.region;

WHERE D.region='Africa' OR D.region='Asia' OR D.region='Southern Europe'
--END TRIPS PER REGION


--INVENTORY REPORTS--
--Items greater than 5 years old 20220711
SELECT * FROM item;
SELECT * FROM item_type;

--age of all items
SELECT I.item_id, IT.description,
    DATEDIFF(CURDATE(), I.date_acquired) AS 'Age in Days',
    DATEDIFF(CURDATE(), I.date_acquired)/365.25 AS 'Age in Years',
    DATE_FORMAT(I.date_acquired,'%m/%d/%Y') AS 'Date Acquired'
FROM item AS I
JOIN item_type AS IT 
    ON i.item_type_id = IT.item_type_id
ORDER BY I.date_acquired;

--age of items over X years old
SELECT I.item_id, IT.description,
    DATEDIFF(CURDATE(), I.date_acquired) AS 'Age in Days',
    DATEDIFF(CURDATE(), I.date_acquired)/365.25 AS 'Age in Years',
    DATE_FORMAT(I.date_acquired,'%m/%d/%Y') AS 'Date Acquired'
FROM item AS I
JOIN item_type AS IT 
    ON i.item_type_id = IT.item_type_id
WHERE (DATEDIFF(CURDATE(), I.date_acquired)/365.25) >= 4
ORDER BY I.date_acquired;

--create procedure
CREATE PROCEDURE OldItems (IN age int)
BEGIN
    SELECT I.item_id, IT.description,
        DATEDIFF(CURDATE(), I.date_acquired) AS 'Age in Days',
        DATEDIFF(CURDATE(), I.date_acquired)/365.25 AS 'Age in Years',
        DATE_FORMAT(I.date_acquired,'%m/%d/%Y') AS 'Date Acquired'
    FROM item AS I
    JOIN item_type AS IT 
        ON i.item_type_id = IT.item_type_id
    WHERE (DATEDIFF(CURDATE(), I.date_acquired)/365.25) >= age
    ORDER BY I.date_acquired;
END

CALL OldItems(4)



--equipment needed per trip
SELECT * FROM  item_type;
SELECT * FROM  trip_item;
SELECT * FROM  trip;

SELECT T.trip_id, D.region, IT.description
FROM trip AS T
JOIN destination AS D 
    ON T.destination_id = D.destination_id
JOIN trip_item AS TI 
    ON T.trip_id = TI.trip_id
JOIN item_type AS IT
    ON TI.item_type_id = IT.item_type_id

ORDER BY T.trip_id, IT.description

--END INVENTORY

--Mei Wong needs a report so potential customers can check on trip schedules--
SELECT T.trip_id, D.region,
    DATE_FORMAT(T.begin_date,'%m/%d/%Y') AS 'Begin Date',
    DATE_FORMAT(T.end_date,'%m/%d/%Y') AS 'End Date',
    DATE_FORMAT(TE.date,'%m/%d/%Y') AS 'Excursion Date',
    E.excursion_description
FROM trip AS T
JOIN destination AS D 
    ON T.destination_id = D.destination_id
JOIN trip_excursion AS TE
    ON TE.trip_id = T.trip_id
JOIN excursion AS E
    ON E.excursion_id = TE.excursion_id
ORDER BY T.begin_date, TE.date;



select employee.first_name, employee.last_name, employee.nick_name, employee.job_title, 
job_responsibility.responsibility, job_responsibility.description 
from employee
left outer join employee_job on employee.employee_id = employee_job.employee_id
left outer join job_responsibility on employee_job.job_responsibility_id = job_responsibility.job_responsibility_id
order by employee.employee_id, job_responsibility.job_responsibility_id;

select *
from trip
left outer join trip_excursion on trip_excursion.trip_id = trip.trip_id
left outer join excursion on excursion.excursion_id = trip_excursion.excursion_id
order by begin_date, date;


select * from employee
left outer join employee_visa on employee.employee_id = employee_visa.employee_id
left outer join visa on employee_visa.visa_id = visa.visa_id
order by employee.employee_id, visa.visa_id;


select * from customer
left outer join customer_visa on customer.customer_id = customer_visa.customer_id
left outer join visa on customer_visa.visa_id = visa.visa_id
where customer.customer_id = 1
order by customer.customer_id, visa.visa_id;


select * from customer
left outer join customer_trip on customer.customer_id = customer_trip.customer_id
left outer join trip on customer_trip.trip_id = trip.trip_id
left outer join destination on destination.destination_id = trip.destination_id
where customer.customer_id = 8
order by trip.destination_id;


select * from item
left outer join item_type on item.item_type_id = item_type.item_type_id
order by item.item_id;
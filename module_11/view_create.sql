CREATE VIEW customer_buy_report AS
SELECT C.first_name, C.last_name, IT.description, CO.is_rental, CO.out_date
FROM item AS I
INNER JOIN item_type AS IT
	ON I.item_type_id = IT.item_type_id
INNER JOIN customer_order AS CO
	ON I.item_id = CO.item_id
INNER JOIN customer AS C
	ON CO.customer_id = C.customer_id
WHERE CO.is_rental = false;

CREATE VIEW customer_buy_report AS SELECT C.first_name, C.last_name, IT.description, CO.is_rental, CO.out_date FROM item AS I INNER JOIN item_type AS IT ON I.item_type_id = IT.item_type_id INNER JOIN customer_order AS CO	ON I.item_id = CO.item_id INNER JOIN customer AS C ON CO.customer_id = C.customer_id WHERE CO.is_rental = false;


CREATE VIEW customer_rent_vs_buy_report AS
SELECT case when CO.is_rental = TRUE then 'Rent' else 'Buy' end AS 'RentVsBuy' , COUNT(*)
FROM item AS I
INNER JOIN item_type AS IT
	ON I.item_type_id = IT.item_type_id
INNER JOIN customer_order AS CO
	ON I.item_id = CO.item_id
INNER JOIN customer AS C
	ON CO.customer_id = C.customer_id
GROUP BY CO.is_rental

CREATE VIEW customer_buy_report AS SELECT C.first_name, C.last_name, IT.description, case when CO.is_rental = TRUE then 'Rent' else 'Buy' end AS 'Buy or Rent', CO.out_date  FROM item AS I  INNER JOIN item_type AS IT  ON I.item_type_id = IT.item_type_id  INNER JOIN customer_order AS CO  ON I.item_id = CO.item_id  INNER JOIN customer AS C  ON CO.customer_id = C.customer_id  WHERE CO.is_rental = false;


CREATE VIEW region_total_trips_report AS
SELECT  D.region AS 'Region', COUNT(T.trip_id) AS 'Total Trips'
FROM trip AS T
RIGHT JOIN destination AS D 
    ON T.destination_id = D.destination_id
GROUP by D.region
ORDER by D.region;

CREATE VIEW region_total_trips_report AS SELECT  D.region AS 'Region', COUNT(T.trip_id) AS 'Total Trips' FROM trip AS T RIGHT JOIN destination AS D ON T.destination_id = D.destination_id GROUP by D.region ORDER by D.region;


CREATE VIEW region_total_customers_report AS
SELECT D.region AS 'Region', COUNT(CT.customer_trip_id) AS 'Total Customer Trips'
FROM customer_trip AS CT 
RIGHT JOIN trip AS T
    ON CT.trip_id = T.trip_id
RIGHT JOIN destination AS D 
    ON T.destination_id = D.destination_id
GROUP by D.region
ORDER by D.region;

CREATE VIEW region_total_customers_report AS SELECT D.region AS 'Region', COUNT(CT.customer_trip_id) AS 'Total Customer Trips' FROM customer_trip AS CT RIGHT JOIN trip AS T ON CT.trip_id = T.trip_id RIGHT JOIN destination AS D ON T.Destination_id = D.destination_id GROUP by D.region ORDER by D.region;

CREATE VIEW item_by_age AS
SELECT I.item_id, IT.description,
    DATEDIFF(CURDATE(), I.date_acquired) AS 'Age in Days',
    DATEDIFF(CURDATE(), I.date_acquired)/365.25 AS 'Age in Years',
    DATE_FORMAT(I.date_acquired,'%m/%d/%Y') AS 'Date Acquired'
FROM item AS I
JOIN item_type AS IT 
    ON i.item_type_id = IT.item_type_id
ORDER BY I.date_acquired;

CREATE VIEW item_by_age AS SELECT I.item_id, IT.description, DATEDIFF(CURDATE(), I.date_acquired) AS 'Age in Days', DATEDIFF(CURDATE(), I.date_acquired)/365.25 AS 'Age in Years', DATE_FORMAT(I.date_acquired,'%m/%d/%Y') AS 'Date Acquired' FROM item AS I JOIN item_type AS IT ON i.item_type_id = IT.item_type_id ORDER BY I.date_acquired;


CREATE VIEW equipment_needed_per_trip AS
SELECT T.trip_id, D.region, IT.description
FROM trip AS T
JOIN destination AS D 
    ON T.destination_id = D.destination_id
JOIN trip_item AS TI 
    ON T.trip_id = TI.trip_id
JOIN item_type AS IT
    ON TI.item_type_id = IT.item_type_id
ORDER BY T.trip_id, IT.description;

CREATE VIEW equipment_needed_per_trip AS SELECT T.trip_id, D.region, IT.description FROM trip AS T JOIN destination AS D ON T.destination_id = D.destination_id JOIN trip_item AS TI ON T.trip_id = TI.trip_id JOIN item_type AS IT ON TI.item_type_id = IT.item_type_id ORDER BY T.trip_id, IT.description;


CREATE VIEW customer_visa_and_shot_records AS
SELECT abc.customer_trip_id,  abc.trip_id, a.begin_date, a.end_date, b.first_name, b.last_name, c.region, e.inoculation_type AS required_inoculation_type, report_data.has_inoculation_type, report_data.date_expires, visa_report.required_country_visa, visa_report.has_visa_in_country, visa_report.visa_number
FROM customer_trip AS abc
INNER JOIN trip AS a
ON abc.trip_id = a.trip_id
INNER JOIN customer AS b
ON abc.customer_id = b.customer_id
INNER JOIN destination AS c
ON a.destination_id = c.destination_id
INNER JOIN destination_inoculation AS d
ON c.destination_id = d.destination_id
INNER JOIN inoculation AS e
ON d.inoculation_id = e.inoculation_id
LEFT JOIN (
	SELECT a.customer_trip_id, g.first_name, c.inoculation_type AS has_inoculation_type, b.date_expires, b.inoculation_id, b.customer_inoculation_id
    FROM customer AS g
	INNER JOIN customer_inoculation AS b
	ON g.customer_id = b.customer_id
	INNER JOIN customer_trip AS a
	ON g.customer_id = a.customer_id
	INNER JOIN inoculation AS c
	ON b.inoculation_id = c.inoculation_id
) report_data ON abc.customer_trip_id = report_data.customer_trip_id AND e.inoculation_type = report_data.has_inoculation_type
INNER JOIN (
	SELECT abc.customer_trip_id, abc.trip_id, a.begin_date, a.end_date, b.first_name, b.last_name, c.region, e.country As required_country_visa, report_data.has_visa_in_country, report_data.visa_number
	FROM customer_trip AS abc
	INNER JOIN trip AS a
	ON abc.trip_id = a.trip_id
	INNER JOIN customer AS b
	ON abc.customer_id = b.customer_id
	INNER JOIN destination AS c
	ON a.destination_id = c.destination_id
	INNER JOIN destination_visa AS d
	ON c.destination_id = d.destination_id
	INNER JOIN visa AS E
	ON d.visa_id = e.visa_id
	LEFT JOIN (
		SELECT a.customer_trip_id, g.first_name, c.country AS has_visa_in_country, b.visa_number, b.visa_id
		FROM customer AS g
		INNER JOIN customer_visa AS b
		ON g.customer_id = b.customer_id
		INNER JOIN customer_trip AS a
		ON g.customer_id = a.customer_id
		INNER JOIN visa AS c
		ON b.visa_id = c.visa_id
	) report_data ON abc.customer_trip_id = report_data.customer_trip_id AND e.country = report_data.has_visa_in_country
) visa_report ON abc.customer_trip_id = visa_report.customer_trip_id;

CREATE VIEW customer_visa_and_shot_records AS SELECT abc.customer_trip_id,  abc.trip_id, a.begin_date, a.end_date, b.first_name, b.last_name, c.region, e.inoculation_type AS required_inoculation_type, report_data.has_inoculation_type, report_data.date_expires, visa_report.required_country_visa, visa_report.has_visa_in_country, visa_report.visa_number FROM customer_trip AS abc INNER JOIN trip AS a ON abc.trip_id = a.trip_id INNER JOIN customer AS b ON abc.customer_id = b.customer_id INNER JOIN destination AS c ON a.destination_id = c.destination_id INNER JOIN destination_inoculation AS d ON c.destination_id = d.destination_id INNER JOIN inoculation AS e ON d.inoculation_id = e.inoculation_id LEFT JOIN (    SELECT a.customer_trip_id, g.first_name, c.inoculation_type AS has_inoculation_type, b.date_expires, b.inoculation_id, b.customer_inoculation_id    FROM customer AS g    INNER JOIN customer_inoculation AS b    ON g.customer_id = b.customer_id    INNER JOIN customer_trip AS a    ON g.customer_id = a.customer_id    INNER JOIN inoculation AS c    ON b.inoculation_id = c.inoculation_id) report_data ON abc.customer_trip_id = report_data.customer_trip_id AND e.inoculation_type = report_data.has_inoculation_type INNER JOIN (    SELECT abc.customer_trip_id, abc.trip_id, a.begin_date, a.end_date, b.first_name, b.last_name, c.region, e.country As required_country_visa, report_data.has_visa_in_country, report_data.visa_number    FROM customer_trip AS abc    INNER JOIN trip AS a    ON abc.trip_id = a.trip_id    INNER JOIN customer AS b    ON abc.customer_id = b.customer_id    INNER JOIN destination AS c    ON a.destination_id = c.destination_id    INNER JOIN destination_visa AS d    ON c.destination_id = d.destination_id    INNER JOIN visa AS E    ON d.visa_id = e.visa_id    LEFT JOIN (        SELECT a.customer_trip_id, g.first_name, c.country AS has_visa_in_country, b.visa_number, b.visa_id        FROM customer AS g        INNER JOIN customer_visa AS b        ON g.customer_id = b.customer_id        INNER JOIN customer_trip AS a        ON g.customer_id = a.customer_id        INNER JOIN visa AS c        ON b.visa_id = c.visa_id    ) report_data ON abc.customer_trip_id = report_data.customer_trip_id AND e.country = report_data.has_visa_in_country) visa_report ON abc.customer_trip_id = visa_report.customer_trip_id;


CREATE VIEW trip_schedules AS
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

CREATE VIEW trip_schedules AS SELECT T.trip_id, D.region,    DATE_FORMAT(T.begin_date,'%m/%d/%Y') AS 'Begin Date',    DATE_FORMAT(T.end_date,'%m/%d/%Y') AS 'End Date',    DATE_FORMAT(TE.date,'%m/%d/%Y') AS 'Excursion Date',    E.excursion_description FROM trip AS T JOIN destination AS D     ON T.destination_id = D.destination_id JOIN trip_excursion AS TE    ON TE.trip_id = T.trip_id JOIN excursion AS E    ON E.excursion_id = TE.excursion_id ORDER BY T.begin_date, TE.date;


CREATE VIEW employee_visa_and_shot_records AS
SELECT abc.employee_trip_id,  abc.trip_id, a.begin_date, a.end_date, b.first_name, b.last_name, c.region, e.inoculation_type AS required_inoculation_type, report_data.has_inoculation_type, report_data.date_expires, visa_report.required_country_visa, visa_report.has_visa_in_country, visa_report.visa_number
FROM employee_trip AS abc
INNER JOIN trip AS a
ON abc.trip_id = a.trip_id
INNER JOIN employee AS b
ON abc.employee_id = b.employee_id
INNER JOIN destination AS c
ON a.destination_id = c.destination_id
INNER JOIN destination_inoculation AS d
ON c.destination_id = d.destination_id
INNER JOIN inoculation AS e
ON d.inoculation_id = e.inoculation_id
LEFT JOIN (
	SELECT a.employee_trip_id, g.first_name, c.inoculation_type AS has_inoculation_type, b.date_expires, b.inoculation_id, b.employee_inoculation_id
    FROM employee AS g
	INNER JOIN employee_inoculation AS b
	ON g.employee_id = b.employee_id
	INNER JOIN employee_trip AS a
	ON g.employee_id = a.employee_id
	INNER JOIN inoculation AS c
	ON b.inoculation_id = c.inoculation_id
) report_data ON abc.employee_trip_id = report_data.employee_trip_id AND e.inoculation_type = report_data.has_inoculation_type
INNER JOIN (
	SELECT abc.employee_trip_id, abc.trip_id, a.begin_date, a.end_date, b.first_name, b.last_name, c.region, e.country As required_country_visa, report_data.has_visa_in_country, report_data.visa_number
	FROM employee_trip AS abc
	INNER JOIN trip AS a
	ON abc.trip_id = a.trip_id
	INNER JOIN employee AS b
	ON abc.employee_id = b.employee_id
	INNER JOIN destination AS c
	ON a.destination_id = c.destination_id
	INNER JOIN destination_visa AS d
	ON c.destination_id = d.destination_id
	INNER JOIN visa AS E
	ON d.visa_id = e.visa_id
	LEFT JOIN (
		SELECT a.employee_trip_id, g.first_name, c.country AS has_visa_in_country, b.visa_number, b.visa_id
		FROM employee AS g
		INNER JOIN employee_visa AS b
		ON g.employee_id = b.employee_id
		INNER JOIN employee_trip AS a
		ON g.employee_id = a.employee_id
		INNER JOIN visa AS c
		ON b.visa_id = c.visa_id
	) report_data ON abc.employee_trip_id = report_data.employee_trip_id AND e.country = report_data.has_visa_in_country
) visa_report ON abc.employee_trip_id = visa_report.employee_trip_id;

CREATE VIEW employee_visa_and_shot_records AS SELECT abc.employee_trip_id,  abc.trip_id, a.begin_date, a.end_date, b.first_name, b.last_name, c.region, e.inoculation_type AS required_inoculation_type, report_data.has_inoculation_type, report_data.date_expires, visa_report.required_country_visa, visa_report.has_visa_in_country, visa_report.visa_number FROM employee_trip AS abc INNER JOIN trip AS a ON abc.trip_id = a.trip_id INNER JOIN employee AS b ON abc.employee_id = b.employee_id INNER JOIN destination AS c ON a.destination_id = c.destination_id INNER JOIN destination_inoculation AS d ON c.destination_id = d.destination_id INNER JOIN inoculation AS e ON d.inoculation_id = e.inoculation_id LEFT JOIN (    SELECT a.employee_trip_id, g.first_name, c.inoculation_type AS has_inoculation_type, b.date_expires, b.inoculation_id, b.employee_inoculation_id    FROM employee AS g    INNER JOIN employee_inoculation AS b    ON g.employee_id = b.employee_id    INNER JOIN employee_trip AS a    ON g.employee_id = a.employee_id    INNER JOIN inoculation AS c    ON b.inoculation_id = c.inoculation_id) report_data ON abc.employee_trip_id = report_data.employee_trip_id AND e.inoculation_type = report_data.has_inoculation_type INNER JOIN (    SELECT abc.employee_trip_id, abc.trip_id, a.begin_date, a.end_date, b.first_name, b.last_name, c.region, e.country As required_country_visa, report_data.has_visa_in_country, report_data.visa_number    FROM employee_trip AS abc    INNER JOIN trip AS a    ON abc.trip_id = a.trip_id    INNER JOIN employee AS b    ON abc.employee_id = b.employee_id    INNER JOIN destination AS c    ON a.destination_id = c.destination_id    INNER JOIN destination_visa AS d    ON c.destination_id = d.destination_id    INNER JOIN visa AS E    ON d.visa_id = e.visa_id    LEFT JOIN (        SELECT a.employee_trip_id, g.first_name, c.country AS has_visa_in_country, b.visa_number, b.visa_id        FROM employee AS g        INNER JOIN employee_visa AS b        ON g.employee_id = b.employee_id        INNER JOIN employee_trip AS a        ON g.employee_id = a.employee_id        INNER JOIN visa AS c        ON b.visa_id = c.visa_id    ) report_data ON abc.employee_trip_id = report_data.employee_trip_id AND e.country = report_data.has_visa_in_country) visa_report ON abc.employee_trip_id = visa_report.employee_trip_id;
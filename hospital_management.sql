-- ============================================================
-- HOSPITAL MANAGEMENT SYSTEM
-- SQL / MySQL Project
-- ============================================================
-- Purpose:
-- A relational hospital database for managing departments,
-- doctors, patients, appointments, admissions, treatments,
-- medicines, prescriptions and billing.
--
-- Database: MySQL
-- ============================================================


-- ============================================================
-- 1. DATABASE SETUP
-- ============================================================

DROP DATABASE IF EXISTS hospital_management;
CREATE DATABASE hospital_management;
USE hospital_management;


-- ============================================================
-- 2. TABLE CREATION
-- ============================================================

CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    dept_location VARCHAR(50)
);

CREATE TABLE doctor (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(50) NOT NULL,
    doctor_salary INT,
    doctor_experience INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(dept_id),
    CHECK (doctor_salary >= 0),
    CHECK (doctor_experience >= 0)
);

CREATE TABLE patient (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(20) NOT NULL,
    mobile_number VARCHAR(15) NOT NULL,
    gender VARCHAR(10),
    date_of_birth DATE,
    address VARCHAR(50) NOT NULL
);

CREATE TABLE appointment (
    appointment_id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    appointment_date DATE,
    appointment_status VARCHAR(20),
    reason VARCHAR(100) NOT NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE admission (
    admission_id INT PRIMARY KEY,
    patient_id INT,
    admission_date DATE,
    reason VARCHAR(100) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE treatment (
    treatment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    treatment_type VARCHAR(50) NOT NULL,
    treatment_date DATE,
    treatment_cost INT,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
    CHECK (treatment_cost >= 0)
);

CREATE TABLE medicine (
    medicine_id INT PRIMARY KEY,
    medicine_name VARCHAR(50),
    dosage VARCHAR(10) NOT NULL,
    price DECIMAL(10,2),
    stock_quantity INT,
    CHECK (price >= 0),
    CHECK (stock_quantity >= 0)
);

CREATE TABLE prescription (
    prescription_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    prescription_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

CREATE TABLE prescription_medicine (
    prescription_id INT,
    medicine_id INT,
    dosage VARCHAR(20),
    PRIMARY KEY (prescription_id, medicine_id),
    FOREIGN KEY (prescription_id) REFERENCES prescription(prescription_id),
    FOREIGN KEY (medicine_id) REFERENCES medicine(medicine_id)
);

CREATE TABLE bill (
    bill_id INT PRIMARY KEY,
    patient_id INT,
    amount DECIMAL(10,2),
    bill_date DATE,
    bill_paid BOOLEAN,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    CHECK (amount >= 0)
);


-- ============================================================
-- 3. SAMPLE DATA
-- ============================================================

INSERT INTO department (dept_id, dept_name, dept_location)
VALUES
(1, 'Cardiology', '1st Floor'),
(2, 'Neurology', '2nd Floor'),
(3, 'Orthopedics', '2nd Floor'),
(4, 'Pediatrics', '3rd Floor'),
(5, 'Dermatology', '3rd Floor'),
(6, 'General Medicine', 'Ground Floor');

INSERT INTO doctor
(doctor_id, doctor_name, doctor_salary, doctor_experience, department_id)
VALUES
(101, 'Arun Kumar', 120000, 12, 1),
(102, 'Priya Sharma', 110000, 10, 1),
(103, 'Rahul Verma', 105000, 9, 2),
(104, 'Sneha Rao', 95000, 7, 2),
(105, 'Vikram Singh', 100000, 8, 3),
(106, 'Anita Reddy', 90000, 6, 3),
(107, 'Meena Das', 85000, 5, 4),
(108, 'Kiran Patel', 80000, 4, 4),
(109, 'Neha Gupta', 88000, 6, 5),
(110, 'Rohit Nair', 92000, 7, 6);

INSERT INTO patient
(patient_id, patient_name, mobile_number, gender, date_of_birth, address)
VALUES
(201, 'Ravi Kumar', '9876543210', 'Male', '1990-05-12', 'Hyderabad'),
(202, 'Anjali Reddy', '9876543211', 'Female', '1985-08-21', 'Hyderabad'),
(203, 'Suresh Rao', '9876543212', 'Male', '1978-02-15', 'Warangal'),
(204, 'Priya Nair', '9876543213', 'Female', '1995-11-30', 'Vijayawada'),
(205, 'Karthik Sharma', '9876543214', 'Male', '1988-06-18', 'Hyderabad'),
(206, 'Lakshmi Devi', '9876543215', 'Female', '1972-09-10', 'Secunderabad'),
(207, 'Arjun Patel', '9876543216', 'Male', '2001-03-25', 'Hyderabad'),
(208, 'Divya Singh', '9876543217', 'Female', '1998-07-14', 'Warangal'),
(209, 'Manoj Kumar', '9876543218', 'Male', '1969-12-05', 'Hyderabad'),
(210, 'Pooja Rao', '9876543219', 'Female', '1992-04-22', 'Vijayawada'),
(211, 'Naveen Reddy', '9876543220', 'Male', '1982-10-17', 'Hyderabad'),
(212, 'Swathi Das', '9876543221', 'Female', '1996-01-09', 'Secunderabad'),
(213, 'Vishal Gupta', '9876543222', 'Male', '1975-05-27', 'Hyderabad'),
(214, 'Asha Patel', '9876543223', 'Female', '1989-09-19', 'Warangal'),
(215, 'Harish Nair', '9876543224', 'Male', '1993-12-11', 'Hyderabad');

INSERT INTO medicine
(medicine_id, medicine_name, dosage, price, stock_quantity)
VALUES
(301, 'Paracetamol', '500mg', 25.50, 200),
(302, 'Amoxicillin', '250mg', 80.00, 150),
(303, 'Azithromycin', '500mg', 120.00, 100),
(304, 'Cetirizine', '10mg', 35.00, 180),
(305, 'Ibuprofen', '400mg', 45.50, 160),
(306, 'Pantoprazole', '40mg', 60.00, 130),
(307, 'Metformin', '500mg', 55.00, 140),
(308, 'Atorvastatin', '20mg', 90.00, 120),
(309, 'Vitamin D3', '1000IU', 75.00, 90),
(310, 'Diclofenac', '50mg', 40.00, 110),
(311, 'Omeprazole', '20mg', 50.00, 125),
(312, 'Aspirin', '75mg', 30.00, 200);

INSERT INTO appointment
(appointment_id, doctor_id, patient_id, appointment_date, appointment_status, reason)
VALUES
(401, 101, 201, '2026-09-01', 'Completed', 'Chest pain'),
(402, 102, 202, '2026-09-02', 'Completed', 'Heart checkup'),
(403, 103, 203, '2026-09-03', 'Completed', 'Headache'),
(404, 104, 204, '2026-09-04', 'Completed', 'Migraine'),
(405, 105, 205, '2026-09-05', 'Completed', 'Knee pain'),
(406, 106, 206, '2026-09-06', 'Completed', 'Back pain'),
(407, 107, 207, '2026-09-07', 'Completed', 'Child fever'),
(408, 108, 208, '2026-09-08', 'Completed', 'Cold and fever'),
(409, 109, 209, '2026-09-09', 'Completed', 'Skin allergy'),
(410, 110, 210, '2026-09-10', 'Completed', 'General checkup'),
(411, 101, 211, '2026-09-11', 'Completed', 'Blood pressure'),
(412, 103, 212, '2026-09-12', 'Completed', 'Dizziness'),
(413, 105, 213, '2026-09-13', 'Scheduled', 'Joint pain'),
(414, 109, 214, '2026-09-14', 'Scheduled', 'Skin infection'),
(415, 110, 215, '2026-09-15', 'Cancelled', 'Routine checkup'),
(416, 102, 201, '2026-09-16', 'Completed', 'Follow-up'),
(417, 104, 203, '2026-09-17', 'Scheduled', 'Headache'),
(418, 106, 205, '2026-09-18', 'Completed', 'Back pain'),
(419, 107, 207, '2026-09-19', 'Scheduled', 'Fever'),
(420, 110, 209, '2026-09-20', 'Completed', 'General checkup');

INSERT INTO admission
(admission_id, patient_id, admission_date, reason)
VALUES
(501, 201, '2026-08-01', 'Chest pain'),
(502, 202, '2026-08-03', 'Heart monitoring'),
(503, 203, '2026-08-05', 'Severe headache'),
(504, 205, '2026-08-07', 'Knee injury'),
(505, 206, '2026-08-10', 'Back pain'),
(506, 209, '2026-08-12', 'High blood pressure'),
(507, 211, '2026-08-15', 'Blood pressure problem'),
(508, 213, '2026-08-18', 'Joint injury'),
(509, 214, '2026-08-20', 'Skin infection'),
(510, 215, '2026-08-22', 'General weakness');

INSERT INTO treatment
(treatment_id, patient_id, doctor_id, treatment_type, treatment_date, treatment_cost)
VALUES
(601, 201, 101, 'Cardiac Checkup', '2026-09-01', 5000),
(602, 202, 102, 'Heart Monitoring', '2026-09-02', 6500),
(603, 203, 103, 'Neurological Checkup', '2026-09-03', 4000),
(604, 204, 104, 'Migraine Treatment', '2026-09-04', 3500),
(605, 205, 105, 'Knee Treatment', '2026-09-05', 7000),
(606, 206, 106, 'Back Treatment', '2026-09-06', 5500),
(607, 207, 107, 'Fever Treatment', '2026-09-07', 2000),
(608, 208, 108, 'Cold Treatment', '2026-09-08', 1800),
(609, 209, 109, 'Skin Allergy Treatment', '2026-09-09', 3000),
(610, 210, 110, 'General Checkup', '2026-09-10', 1500),
(611, 211, 101, 'Blood Pressure Treatment', '2026-09-11', 4500),
(612, 212, 103, 'Dizziness Treatment', '2026-09-12', 3200),
(613, 213, 105, 'Joint Treatment', '2026-09-13', 6000),
(614, 214, 109, 'Skin Infection Treatment', '2026-09-14', 3500),
(615, 215, 110, 'General Treatment', '2026-09-15', 2200);

INSERT INTO prescription
(prescription_id, patient_id, doctor_id, prescription_date)
VALUES
(701, 201, 101, '2026-09-01'),
(702, 202, 102, '2026-09-02'),
(703, 203, 103, '2026-09-03'),
(704, 204, 104, '2026-09-04'),
(705, 205, 105, '2026-09-05'),
(706, 206, 106, '2026-09-06'),
(707, 207, 107, '2026-09-07'),
(708, 208, 108, '2026-09-08'),
(709, 209, 109, '2026-09-09'),
(710, 210, 110, '2026-09-10');

INSERT INTO prescription_medicine
(prescription_id, medicine_id, dosage)
VALUES
(701, 301, '1-0-1'),
(701, 306, '1-0-0'),
(702, 308, '0-0-1'),
(702, 312, '1-0-0'),
(703, 303, '1-0-1'),
(703, 304, '0-0-1'),
(704, 301, '1-1-1'),
(704, 305, '1-0-1'),
(705, 310, '1-0-1'),
(705, 306, '1-0-0'),
(706, 305, '1-0-1'),
(706, 311, '1-0-0'),
(707, 301, '1-1-1'),
(707, 304, '0-0-1'),
(708, 302, '1-0-1'),
(708, 301, '1-1-1'),
(709, 304, '0-0-1'),
(709, 303, '1-0-1'),
(710, 309, '1-0-0'),
(710, 301, '1-0-1');

INSERT INTO bill
(bill_id, patient_id, amount, bill_date, bill_paid)
VALUES
(801, 201, 5500.00, '2026-09-01', TRUE),
(802, 202, 7200.00, '2026-09-02', TRUE),
(803, 203, 4500.00, '2026-09-03', FALSE),
(804, 204, 3800.00, '2026-09-04', TRUE),
(805, 205, 8500.00, '2026-09-05', FALSE),
(806, 206, 6200.00, '2026-09-06', TRUE),
(807, 207, 2500.00, '2026-09-07', TRUE),
(808, 208, 2300.00, '2026-09-08', FALSE),
(809, 209, 3500.00, '2026-09-09', TRUE),
(810, 210, 1800.00, '2026-09-10', TRUE),
(811, 211, 5000.00, '2026-09-11', FALSE),
(812, 212, 3600.00, '2026-09-12', TRUE),
(813, 213, 7000.00, '2026-09-13', FALSE),
(814, 214, 4200.00, '2026-09-14', TRUE),
(815, 215, 2500.00, '2026-09-15', FALSE);


-- ============================================================
-- 4. BASIC SQL QUERIES
-- ============================================================

-- SELECT
SELECT doctor_name, doctor_salary FROM doctor;
SELECT patient_name, gender FROM patient;
SELECT medicine_name, price FROM medicine;
SELECT dept_name FROM department;

-- Display all doctors
SELECT * FROM doctor;


-- ============================================================
-- 5. WHERE
-- ============================================================

SELECT doctor_name
FROM doctor
WHERE doctor_salary > 100000;

SELECT patient_name
FROM patient
WHERE gender = 'Female';

SELECT medicine_name
FROM medicine
WHERE price < 50;

SELECT doctor_name
FROM doctor
WHERE doctor_experience > 7;

SELECT appointment_id
FROM appointment
WHERE appointment_status = 'Completed';


-- ============================================================
-- 6. AND / OR / NOT
-- ============================================================

SELECT doctor_name
FROM doctor
WHERE doctor_salary > 90000
  AND doctor_experience > 5;

SELECT patient_name
FROM patient
WHERE address = 'Hyderabad'
   OR address = 'Warangal';

SELECT medicine_name
FROM medicine
WHERE price > 50
  AND stock_quantity > 100;

SELECT appointment_id
FROM appointment
WHERE appointment_status = 'Completed'
  AND appointment_id > 410;

SELECT appointment_id
FROM appointment
WHERE appointment_status != 'Cancelled';


-- ============================================================
-- 7. ORDER BY
-- ============================================================

SELECT doctor_name, doctor_salary
FROM doctor
ORDER BY doctor_salary DESC;

SELECT patient_name
FROM patient
ORDER BY patient_name ASC;

SELECT medicine_name, price
FROM medicine
ORDER BY price ASC;

SELECT doctor_name, doctor_experience
FROM doctor
ORDER BY doctor_experience DESC;


-- ============================================================
-- 8. DISTINCT
-- ============================================================

SELECT DISTINCT address
FROM patient;

SELECT DISTINCT appointment_status
FROM appointment;

SELECT DISTINCT treatment_type
FROM treatment;

SELECT DISTINCT gender
FROM patient;


-- ============================================================
-- 9. LIKE
-- ============================================================

SELECT patient_name
FROM patient
WHERE patient_name LIKE 'A%';

SELECT doctor_name
FROM doctor
WHERE doctor_name LIKE '%a';

SELECT patient_name
FROM patient
WHERE patient_name LIKE '%ra%';

SELECT medicine_name
FROM medicine
WHERE medicine_name LIKE '%in%';


-- ============================================================
-- 10. BETWEEN / IN
-- ============================================================

SELECT doctor_name, doctor_salary
FROM doctor
WHERE doctor_salary BETWEEN 90000 AND 110000;

SELECT medicine_name, price
FROM medicine
WHERE price BETWEEN 40 AND 80;

SELECT patient_name, address
FROM patient
WHERE address IN ('Hyderabad', 'Warangal');

SELECT appointment_id, appointment_status
FROM appointment
WHERE appointment_status IN ('Completed', 'Scheduled');


-- ============================================================
-- 11. AGGREGATE FUNCTIONS
-- ============================================================

SELECT COUNT(*) AS total_doctors
FROM doctor;

SELECT MAX(doctor_salary) AS highest_salary
FROM doctor;

SELECT MIN(doctor_salary) AS lowest_salary
FROM doctor;

SELECT AVG(doctor_salary) AS average_salary
FROM doctor;

SELECT SUM(treatment_cost) AS total_treatment_cost
FROM treatment;

SELECT MAX(amount) AS highest_bill
FROM bill;

SELECT AVG(amount) AS average_bill
FROM bill;


-- ============================================================
-- 12. GROUP BY
-- ============================================================

SELECT department_id,
       COUNT(doctor_id) AS number_of_doctors
FROM doctor
GROUP BY department_id;

SELECT department_id,
       AVG(doctor_salary) AS average_salary
FROM doctor
GROUP BY department_id;

SELECT appointment_status,
       COUNT(appointment_id) AS appointment_count
FROM appointment
GROUP BY appointment_status;

SELECT gender,
       COUNT(patient_id) AS patient_count
FROM patient
GROUP BY gender;

SELECT doctor_id,
       SUM(treatment_cost) AS total_treatment_cost
FROM treatment
GROUP BY doctor_id;

SELECT patient_id,
       SUM(amount) AS total_bill_amount
FROM bill
GROUP BY patient_id;


-- ============================================================
-- 13. HAVING
-- ============================================================

SELECT department_id,
       COUNT(doctor_id) AS number_of_doctors
FROM doctor
GROUP BY department_id
HAVING COUNT(doctor_id) > 1;

SELECT doctor_id,
       COUNT(treatment_id) AS treatment_count
FROM treatment
GROUP BY doctor_id
HAVING COUNT(treatment_id) > 1;

SELECT patient_id,
       SUM(amount) AS total_bill_amount
FROM bill
GROUP BY patient_id
HAVING SUM(amount) > 5000;

SELECT appointment_status,
       COUNT(appointment_id) AS appointment_count
FROM appointment
GROUP BY appointment_status
HAVING COUNT(appointment_id) > 5;


-- ============================================================
-- 14. INNER JOINS
-- ============================================================

-- Doctors with departments
SELECT d.doctor_name,
       dp.dept_name
FROM doctor d
JOIN department dp
ON d.department_id = dp.dept_id;

-- Patients with appointment dates
SELECT p.patient_name,
       a.appointment_date
FROM patient p
JOIN appointment a
ON p.patient_id = a.patient_id;

-- Appointments with doctor and patient
SELECT d.doctor_name,
       p.patient_name
FROM appointment a
JOIN doctor d
ON a.doctor_id = d.doctor_id
JOIN patient p
ON a.patient_id = p.patient_id;

-- Patients with treatments
SELECT p.patient_name,
       t.treatment_type
FROM patient p
JOIN treatment t
ON p.patient_id = t.patient_id;

-- Patients with bills
SELECT p.patient_name,
       b.amount
FROM patient p
JOIN bill b
ON p.patient_id = b.patient_id;

-- Complete appointment details
SELECT d.doctor_name,
       dp.dept_name,
       p.patient_name,
       a.appointment_date
FROM appointment a
JOIN doctor d
ON a.doctor_id = d.doctor_id
JOIN department dp
ON d.department_id = dp.dept_id
JOIN patient p
ON a.patient_id = p.patient_id;

-- Doctor treatment details
SELECT d.doctor_name,
       p.patient_name,
       t.treatment_type,
       t.treatment_cost
FROM treatment t
JOIN doctor d
ON d.doctor_id = t.doctor_id
JOIN patient p
ON p.patient_id = t.patient_id;

-- Patient prescription and medicine details
SELECT p.patient_name,
       m.medicine_name,
       pm.dosage
FROM prescription_medicine pm
JOIN prescription pr
ON pm.prescription_id = pr.prescription_id
JOIN patient p
ON pr.patient_id = p.patient_id
JOIN medicine m
ON pm.medicine_id = m.medicine_id;


-- ============================================================
-- 15. LEFT JOINS
-- ============================================================

SELECT p.patient_name,
       a.appointment_id
FROM patient p
LEFT JOIN appointment a
ON p.patient_id = a.patient_id;

SELECT d.doctor_name,
       a.appointment_id
FROM doctor d
LEFT JOIN appointment a
ON d.doctor_id = a.doctor_id;

SELECT dp.dept_name,
       d.doctor_name
FROM department dp
LEFT JOIN doctor d
ON dp.dept_id = d.department_id;

SELECT p.patient_name,
       b.amount
FROM patient p
LEFT JOIN bill b
ON p.patient_id = b.patient_id;

SELECT m.medicine_name,
       pm.prescription_id
FROM medicine m
LEFT JOIN prescription_medicine pm
ON m.medicine_id = pm.medicine_id;


-- ============================================================
-- 16. SUBQUERIES
-- ============================================================

-- Doctors earning above average salary
SELECT doctor_name,
       doctor_salary
FROM doctor
WHERE doctor_salary > (
    SELECT AVG(doctor_salary)
    FROM doctor
);

-- Doctor with highest salary
SELECT doctor_name,
       doctor_salary
FROM doctor
WHERE doctor_salary = (
    SELECT MAX(doctor_salary)
    FROM doctor
);

-- Bills above average bill amount
SELECT patient_id,
       amount
FROM bill
WHERE amount > (
    SELECT AVG(amount)
    FROM bill
);

-- Medicines above average price
SELECT medicine_name,
       price
FROM medicine
WHERE price > (
    SELECT AVG(price)
    FROM medicine
);

-- Doctors who have performed at least one treatment
SELECT doctor_id
FROM doctor
WHERE doctor_id IN (
    SELECT doctor_id
    FROM treatment
);


-- ============================================================
-- 17. CASE EXPRESSIONS
-- ============================================================

-- Doctor salary category
SELECT doctor_name,
       doctor_salary,
       CASE
           WHEN doctor_salary >= 110000 THEN 'High'
           WHEN doctor_salary >= 90000 THEN 'Medium'
           ELSE 'Low'
       END AS salary_category
FROM doctor;

-- Patient gender category
SELECT patient_name,
       gender,
       CASE
           WHEN gender = 'Male' THEN 'M'
           WHEN gender = 'Female' THEN 'F'
           ELSE 'Others'
       END AS gender_category
FROM patient;

-- Bill category
SELECT p.patient_name,
       b.amount,
       CASE
           WHEN b.amount >= 7000 THEN 'High'
           WHEN b.amount >= 4000 THEN 'Medium'
           ELSE 'Low'
       END AS bill_category
FROM bill b
JOIN patient p
ON b.patient_id = p.patient_id;


-- ============================================================
-- 18. DATE FUNCTIONS
-- ============================================================

-- Patient age
SELECT patient_name,
       date_of_birth,
       TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS age
FROM patient;

-- Appointments in September 2026
SELECT appointment_id,
       appointment_date
FROM appointment
WHERE appointment_date BETWEEN '2026-09-01' AND '2026-09-30';

-- Bills after September 10, 2026
SELECT bill_id,
       bill_date,
       amount
FROM bill
WHERE bill_date > '2026-09-10';

-- Appointments between September 5 and September 15
SELECT appointment_id,
       appointment_date,
       appointment_status
FROM appointment
WHERE appointment_date BETWEEN '2026-09-05' AND '2026-09-15';

-- Appointment year
SELECT p.patient_name,
       YEAR(a.appointment_date) AS appointment_year
FROM patient p
JOIN appointment a
ON p.patient_id = a.patient_id;

-- Appointment month
SELECT appointment_id,
       MONTH(appointment_date) AS appointment_month
FROM appointment;

-- Appointment day
SELECT appointment_id,
       DAY(appointment_date) AS appointment_day
FROM appointment;


-- ============================================================
-- 19. COMMON TABLE EXPRESSIONS (CTEs)
-- ============================================================

-- Doctors earning above average salary
WITH avg_salary AS (
    SELECT AVG(doctor_salary) AS average_salary
    FROM doctor
)
SELECT d.doctor_name,
       d.doctor_salary
FROM doctor d
WHERE d.doctor_salary > (
    SELECT average_salary
    FROM avg_salary
);

-- Doctors with total treatment cost above 5000
WITH treatment_cost_summary AS (
    SELECT doctor_id,
           SUM(treatment_cost) AS total_treatment_cost
    FROM treatment
    GROUP BY doctor_id
)
SELECT doctor_id,
       total_treatment_cost
FROM treatment_cost_summary
WHERE total_treatment_cost > 5000;

-- Departments having more than one doctor
WITH doctor_count AS (
    SELECT department_id,
           COUNT(doctor_id) AS total_doctors
    FROM doctor
    GROUP BY department_id
)
SELECT dp.dept_name,
       dc.total_doctors
FROM department dp
JOIN doctor_count dc
ON dp.dept_id = dc.department_id
WHERE dc.total_doctors > 1;


-- ============================================================
-- 20. WINDOW FUNCTIONS
-- ============================================================

-- Rank doctors by salary
SELECT doctor_name,
       doctor_salary,
       RANK() OVER (
           ORDER BY doctor_salary DESC
       ) AS doctor_rank
FROM doctor;

-- Rank doctors within each department
SELECT doctor_name,
       department_id,
       doctor_salary,
       RANK() OVER (
           PARTITION BY department_id
           ORDER BY doctor_salary DESC
       ) AS department_rank
FROM doctor;

-- Highest-paid doctor in each department
WITH doctor_rank AS (
    SELECT doctor_name,
           department_id,
           doctor_salary,
           RANK() OVER (
               PARTITION BY department_id
               ORDER BY doctor_salary DESC
           ) AS salary_rank
    FROM doctor
)
SELECT doctor_name,
       department_id,
       doctor_salary
FROM doctor_rank
WHERE salary_rank = 1;

-- Overall average salary beside each doctor
SELECT doctor_name,
       doctor_salary,
       AVG(doctor_salary) OVER () AS average_salary
FROM doctor;

-- Difference from overall average salary
SELECT doctor_name,
       doctor_salary,
       doctor_salary - AVG(doctor_salary) OVER () AS salary_difference
FROM doctor;

-- Previous salary in descending salary order
SELECT doctor_name,
       doctor_salary,
       LAG(doctor_salary) OVER (
           ORDER BY doctor_salary DESC
       ) AS previous_salary
FROM doctor;


-- ============================================================
-- 21. VIEWS
-- ============================================================

CREATE VIEW doctor_department_view AS
SELECT d.doctor_name,
       dp.dept_name,
       d.doctor_salary
FROM doctor d
JOIN department dp
ON d.department_id = dp.dept_id;

CREATE VIEW patient_bill_view AS
SELECT p.patient_name,
       b.amount,
       b.bill_date,
       b.bill_paid
FROM patient p
JOIN bill b
ON p.patient_id = b.patient_id;

CREATE VIEW doctor_treatment_view AS
SELECT d.doctor_name,
       t.treatment_type,
       t.treatment_cost,
       t.treatment_date
FROM doctor d
JOIN treatment t
ON d.doctor_id = t.doctor_id;

CREATE VIEW patient_appointment_view AS
SELECT p.patient_name,
       d.doctor_name,
       a.appointment_date,
       a.appointment_status
FROM patient p
JOIN appointment a
ON p.patient_id = a.patient_id
JOIN doctor d
ON a.doctor_id = d.doctor_id;

CREATE VIEW prescription_details_view AS
SELECT p.patient_name,
       d.doctor_name,
       m.medicine_name,
       pm.dosage,
       pr.prescription_date
FROM prescription pr
JOIN patient p
ON pr.patient_id = p.patient_id
JOIN doctor d
ON pr.doctor_id = d.doctor_id
JOIN prescription_medicine pm
ON pr.prescription_id = pm.prescription_id
JOIN medicine m
ON pm.medicine_id = m.medicine_id;


-- View examples
SELECT * FROM doctor_department_view;
SELECT * FROM patient_bill_view;
SELECT * FROM doctor_treatment_view;
SELECT * FROM patient_appointment_view;
SELECT * FROM prescription_details_view;


-- ============================================================
-- 22. STORED PROCEDURES
-- ============================================================

DELIMITER //

-- Get all doctors
CREATE PROCEDURE get_all_doctors()
BEGIN
    SELECT doctor_id,
           doctor_name,
           doctor_salary
    FROM doctor;
END //

-- Get bills for a particular patient
CREATE PROCEDURE get_patient_bills(IN p_patient_id INT)
BEGIN
    SELECT p.patient_name,
           b.amount,
           b.bill_date,
           b.bill_paid
    FROM patient p
    JOIN bill b
    ON p.patient_id = b.patient_id
    WHERE p.patient_id = p_patient_id;
END //

-- Get treatments performed by a particular doctor
CREATE PROCEDURE get_doctor_treatments(IN p_doctor_id INT)
BEGIN
    SELECT d.doctor_name,
           t.treatment_type,
           t.treatment_cost,
           t.treatment_date
    FROM doctor d
    JOIN treatment t
    ON d.doctor_id = t.doctor_id
    WHERE d.doctor_id = p_doctor_id;
END //

-- Check bill payment status for a patient
CREATE PROCEDURE check_bill_status(IN p_patient_id INT)
BEGIN
    SELECT p.patient_name,
           b.amount,
           b.bill_paid,
           CASE
               WHEN b.bill_paid = TRUE THEN 'Paid'
               ELSE 'Pending'
           END AS payment_status
    FROM patient p
    JOIN bill b
    ON p.patient_id = b.patient_id
    WHERE p.patient_id = p_patient_id;
END //

-- Calculate total bill amount for a patient
CREATE PROCEDURE get_patient_total_bill(IN p_patient_id INT)
BEGIN
    SELECT p.patient_name,
           SUM(b.amount) AS total_bill_amount
    FROM patient p
    JOIN bill b
    ON p.patient_id = b.patient_id
    WHERE p.patient_id = p_patient_id
    GROUP BY p.patient_name;
END //

-- Appointment count for a given status
CREATE PROCEDURE get_appointment_summary(IN p_status VARCHAR(20))
BEGIN
    SELECT appointment_status,
           COUNT(appointment_id) AS appointment_count
    FROM appointment
    WHERE appointment_status = p_status
    GROUP BY appointment_status;
END //

DELIMITER ;


-- ============================================================
-- 23. STORED PROCEDURE EXECUTION EXAMPLES
-- ============================================================

CALL get_all_doctors();

CALL get_patient_bills(201);

CALL get_doctor_treatments(101);

CALL check_bill_status(205);

CALL get_patient_total_bill(201);

CALL get_appointment_summary('Completed');


-- ============================================================
-- END OF PROJECT
-- ============================================================

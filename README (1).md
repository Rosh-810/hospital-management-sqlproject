# Hospital Management System — MySQL

## 📌 Project Overview

The **Hospital Management System** is a relational database project built using **MySQL** to manage and organize hospital-related information.

The database stores information about departments, doctors, patients, appointments, admissions, treatments, medicines, prescriptions, and billing.

The project was designed to practice and demonstrate SQL concepts from basic queries through advanced SQL features such as CTEs, window functions, views, and stored procedures.

---

## 🛠️ Technologies Used

- **MySQL**
- SQL

---

## 🗂️ Database Structure

The project contains **10 interconnected tables**:

| Table | Purpose |
|---|---|
| `department` | Stores hospital department details |
| `doctor` | Stores doctor information and department assignment |
| `patient` | Stores patient information |
| `appointment` | Stores patient appointments with doctors |
| `admission` | Stores patient admission records |
| `treatment` | Stores treatments performed by doctors |
| `medicine` | Stores medicine details, prices, dosage, and stock |
| `prescription` | Stores prescriptions issued by doctors |
| `prescription_medicine` | Connects prescriptions with medicines |
| `bill` | Stores patient billing information and payment status |

---

## 🔗 Relationships

The database uses primary keys and foreign keys to maintain relationships between tables.

### Main relationships

- A **Department** can have multiple **Doctors**.
- A **Doctor** can have multiple **Appointments**.
- A **Patient** can have multiple **Appointments**.
- A **Patient** can have multiple **Admissions**.
- A **Doctor** can perform multiple **Treatments**.
- A **Patient** can have multiple **Treatments**.
- A **Doctor** can issue multiple **Prescriptions**.
- A **Patient** can have multiple **Prescriptions**.
- A **Prescription** can contain multiple **Medicines**.
- A **Medicine** can appear in multiple **Prescriptions**.
- `prescription_medicine` acts as the junction table for the many-to-many relationship between prescriptions and medicines.
- A **Patient** can have multiple **Bills**.

---

## 📚 SQL Concepts Implemented

### Basic SQL

- `SELECT`
- `WHERE`
- `AND`
- `OR`
- `NOT`
- `ORDER BY`
- `DISTINCT`
- `LIKE`
- `BETWEEN`
- `IN`

### Aggregate & Grouping

- `COUNT()`
- `SUM()`
- `AVG()`
- `MAX()`
- `MIN()`
- `GROUP BY`
- `HAVING`

### Data Relationships

- `INNER JOIN`
- `LEFT JOIN`
- Multiple-table joins

### Advanced SQL

- Subqueries
- `CASE`
- Date functions
- Common Table Expressions (CTEs)
- Window functions
- `RANK()`
- `LAG()`
- `PARTITION BY`

### Database Objects

- Views
- Stored Procedures
- Stored Procedures with `IN` parameters

---

## 👁️ Views Created

The project contains the following views:

1. `doctor_department_view`
2. `patient_bill_view`
3. `doctor_treatment_view`
4. `patient_appointment_view`
5. `prescription_details_view`

These views provide reusable query results for commonly needed hospital information.

---

## ⚙️ Stored Procedures

The following stored procedures were created:

| Procedure | Purpose |
|---|---|
| `get_all_doctors()` | Displays doctor details |
| `get_patient_bills(patient_id)` | Displays bills for a selected patient |
| `get_doctor_treatments(doctor_id)` | Displays treatments performed by a selected doctor |
| `check_bill_status(patient_id)` | Displays bill payment status |
| `get_patient_total_bill(patient_id)` | Calculates total bill amount for a patient |
| `get_appointment_summary(status)` | Returns appointment count for a selected status |

---

## 📊 Example SQL Operations

### Find doctors earning above the average salary

```sql
SELECT doctor_name,
       doctor_salary
FROM doctor
WHERE doctor_salary > (
    SELECT AVG(doctor_salary)
    FROM doctor
);
```

### Rank doctors by salary within each department

```sql
SELECT doctor_name,
       department_id,
       doctor_salary,
       RANK() OVER (
           PARTITION BY department_id
           ORDER BY doctor_salary DESC
       ) AS department_rank
FROM doctor;
```

### Calculate patient age

```sql
SELECT patient_name,
       date_of_birth,
       TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS age
FROM patient;
```

### Execute a stored procedure

```sql
CALL get_patient_bills(201);
```

---

## 🚀 How to Run the Project

### 1. Install MySQL

Use MySQL Server with a SQL client such as MySQL Workbench.

### 2. Download the SQL file

Download:

```text
hospital_management.sql
```

### 3. Open the SQL file

Open the file in MySQL Workbench or another MySQL-compatible SQL editor.

### 4. Run the script

Execute the complete script.

The script will:

1. Create the `hospital_management` database.
2. Create all 10 tables.
3. Insert sample data.
4. Run example SQL queries.
5. Create views.
6. Create stored procedures.
7. Execute stored procedure examples.

---

## 📁 Project Structure

```text
hospital-management-sql-project/
│
├── hospital_management.sql
└── README.md
```

---

## 🎯 Project Objectives

The main objectives of this project were to:

- Design a relational database for a hospital management scenario.
- Establish relationships using primary and foreign keys.
- Store and organize hospital-related data.
- Retrieve and analyze data using SQL.
- Practice advanced SQL concepts.
- Create reusable views and stored procedures.
- Develop practical SQL skills for database and data analysis roles.

---

## 💡 Key Learning Outcomes

Through this project, I practiced:

- Relational database design
- Data integrity using keys and constraints
- Multi-table data retrieval
- Data aggregation and grouping
- Advanced SQL analysis
- CTEs and window functions
- Reusable database views
- Parameterized stored procedures

---

## 👤 Author

**Roshini Apuri**

This project was created as part of my SQL and Data Analytics learning journey.

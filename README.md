# SQL Challenge: Employee Management System

## Overview

This project involves designing and querying a database schema for an Employee Management System. The project is divided into two parts: schema creation and querying the database.

### Schema Creation

I created the necessary tables for the database schema using SQL. The tables include:

- **Departments**: Stores department information such as department number and name.
- **Employees**: Contains employee data including employee number, name, birth date, sex, and hire date.
- **Salaries**: Holds salary information for employees.
- **Title**: Stores titles of employees.
- **Dept_Emp**: Establishes a many-to-many relationship between employees and departments.
- **Dept_Manager**: Specifies which employees are managers of which departments.

The SQL code for schema creation can be found in the file `tableschemata.sql`.

### Querying the Database

I wrote SQL queries to perform various tasks related to employee management. These queries cover tasks like retrieving employee information, calculating average salaries, and managing departments. The queries were written to solve specific tasks mentioned in the project brief.

The SQL queries are organized in the file `queries.sql`. The queries include tasks such as:
1. Retrieving employee details along with department names.
2. Finding the average salary of employees in each department.
3. Listing employees who have managed a department.
4. Updating the salary of a specific employee.
5. Deleting the record of an employee.

### ERD Diagram

An Entity-Relationship Diagram (ERD) was created to visualize the database schema. The ERD provides a clear representation of the relationships between different entities in the database.

The ERD diagram can be found in the project repository.

## Project Files

- **tableschemata.sql**: Contains SQL code to create the database schema.
- **employeesvalidquery.sql**: Includes SQL code for querying the database to perform various tasks.
- **queries.sql**: The file where queries are written to solve specific tasks.
- **ERD Diagram**: Uploaded to GitHub, providing a visual representation of the database schema.


Feel free to explore the files and the ERD diagram to understand the project better.

### Author
Bukola Fatile

## References
- Bryan, Andomar, & Raj. (1959, July 1). How to make a foreign key a primary key in SQL server. Stack Overflow. https://stackoverflow.com/questions/16686575/how-to-make-a-foreign-key-a-primary-key-in-sql-server

- GeeksforGeeks. (2023, October 31). SQL: Join (inner, left, right and full joins). https://www.geeksforgeeks.org/sql-join-set-1-inner-left-right-and-full-joins/

- PostgreSQL Documentation. (2023, November 9). https://www.postgresql.org/docs/current/index.html

- W3Schools. (n.d.). SQL Foreign Key Constraint. https://www.w3schools.com/sql/sql_foreignkey.asp

- Other ideas/insights gained from class discussions and interactions with classmates. 

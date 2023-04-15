# Airline Flight Management System

 

**Database Used :** Oracle 19c

**Language :** Oracle PL/SQL

 

**Problem Statement :**

The airline reservation system is a database project aimed at managing flight bookings and reservations for an airline company. The project involves designing a database schema, creating tables, defining relationships between tables, and implementing SQL queries to manage the booking process.

**Objectives :**

1. Design a system that will streamline the process of flight reservation in a centralized, real time accessible manner
2. The system should be able to handle multiple flights and routes offered by the airline
3. Customers should be able to book for their flights online for multiple passengers
4. Customers should be able to apply a promotion code per booking
5. The system should keep track of seat availability and ensure that double-booking does not occur
6. The system should allow airline staff to manage flight schedules, customer bookings, and other aspects of the booking process
7. The system should provide reports and analytics to help the airline company make data-driven decisions

 
**Roles:**

1. Airline Admin
2. Customer


**Proposed Solution:**

Our project is to develop a database dedicated to the Flight Reservation System component of an Airline company, say for example American Airlines.
The business requirement is restricted to the flights exclusive to the Airline company. 
Note that this is different than general ticketing systems like Kayak or Expedia which allows users to book flight tickets from multiple Airlines. 
This document outlines the problem statement and the objectives of the team.
We also provide the Entity Relationship diagram of our proposed database structure and a detailed listing of our entities along with the sql scripts to build the entire system. 

 # Entity Relationship Diagram:

![ER Diagram](/Project%20Files/ER_Diagram.png)

# List of scripts and their functionality

| Script Name | Description |
| ----------- | ----------- |
| **DDLandDML.sql** | Contains script to create all tables, views, grant privileges to Customer, creates sequence variable and inserts values into the tables|
| **Users.sql** | Grants permissions on tables and views to Admin and Customer | 
| **PKG_AIRLINE.sql** | Creates airline package with stored procedures for adding Flight Seat availability, Status, Flight Schedule, Promotion, Flight Type | 
| **PKG_CUSTOMER.sql** | Creates customer package with store procedure for customer signup |
| **PKG_BOOKING.sql** | Creates booking package with stored procedures for all cancellation scenarios |
| **PKG_GRANTS.sql** | Grants Execute on Booking, Customer, and Airline packages |
| **Functions.sql** | Creates functions to calculate passenger count, check if flight schedule, promotion, seat types, user exists and if promotion is active, the total number of seats available |
| **Functions_Grants.sql** | Grants Execute to the functions mentioned above |
| **Triggers.sql** | Has Triggers for inserting booking, inserting record into audit table, update passenger status, update route, insert flight schedule, insert routes audit record, insert flight type |
| **Package_Airline_Execute.sql** | Has execution queries for airline package |
| **Package_Booking_Execute.sql** | Has execution queries for booking package |
| **Package_Customer_Execute.sql** | Has execution queries for customer package |

# Steps to run the scripts

    1. Run DDLandDML.sql script as APP_ADMIN 

    2. Run Users.sql script as APP_ADMIN 

    3. Run Project Files/PKG_AIRLINE/PKG_AIRLINE.sql script as APP_ADMIN 

    4. Run Project Files/PKG_CUSTOMER/PKG_CUSTOMER.sql script as APP_ADMIN 

    5. Run Project Files/PKG_CUSTOMER/PKG_BOOKING.sql script as APP_ADMIN 

    6. Run PKG_GRANTS script as APP_ADMIN 

    7. Run Project Files/Functions/Functions.sql script as APP_ADMIN

    8. Run Project Files/Functions/Functions_Grants.sql script as APP_ADMIN 

    9. Run Project Files/Triggers/Triggers.sql script as APP_ADMIN 

    10. Run Project Files/Package_Airline_Execute.sql script as AIRLINE_ADMIN 

    11. Run Project Files/Package_Booking_Execute.sql script as CUSTOMER 

    12. Run Project Files/Package_Customer_Execute.sql script as CUSTOMER 

 # Graphs:

 ![Passenger Traffic by Destination States](/Project%20Files/Graphs/DMDD_1.png)

![Passenger Traffic by Source States](/Project%20Files/Graphs/DMDD_2.jpg)

![Passenger Traffic per Quarter](/Project%20Files/Graphs/DMDD_3.jpg)

![Promotions used count](/Project%20Files/Graphs/DMDD_4.jpg) 

![Seat distribution by Flight Type](/Project%20Files/Graphs/DMDD_5.jpg)

![Top routes this month](/Project%20Files/Graphs/DMDD_6.jpg)

![Top routes this Year](/Project%20Files/Graphs/DMDD_7.jpg)

![Top routes with vacant seats](/Project%20Files/Graphs/DMDD_8.jpg)

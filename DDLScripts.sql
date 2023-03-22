
-- Table Cusotmer
--------------------------------------------------------------------

CREATE TABLE CUSTOMER (
  CustomerID NUMBER NOT NULL,
  FirstName VARCHAR2(45) NOT NULL,
  LastName VARCHAR2(45) NOT NULL,
  Email VARCHAR2(45) NOT NULL,
  MobileNo VARCHAR2(45) NOT NULL,
  PRIMARY KEY (CustomerID));



-- Table FLIGHT_TYPE
--------------------------------------------------------------------

CREATE TABLE FLIGHT_TYPE (
  FlightTypeID NUMBER NOT NULL,
  FlightName VARCHAR2(45) NOT NULL,
  TotalNoOfSeats NUMBER NULL,
  PRIMARY KEY (FlightTypeID));

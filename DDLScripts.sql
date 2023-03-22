
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

  

-- Table Airports
--------------------------------------------------------------------
CREATE TABLE AIRPORTS (
  Airports_ID NUMBER NOT NULL,
  State VARCHAR2(45) NULL,
  City VARCHAR2(45) NULL,
  Airport_Code VARCHAR2(45) NOT NULL UNIQUE,
  Airport_LongName VARCHAR2(100) NOT NULL UNIQUE,
  PRIMARY KEY (Airports_ID));
-- Trigger: booking_insert_trigger
create or replace TRIGGER booking_insert_trigger
AFTER INSERT ON booking
FOR EACH ROW

BEGIN

  -- Insert a new record into the audit table
  INSERT INTO booking_audit (booking_id, operation_type, audit_timestamp)
  VALUES (:NEW.bookingid, 'INSERT', SYSTIMESTAMP);
END;
/

-- Trigger: passenger_status_update_trigger
CREATE OR REPLACE TRIGGER passenger_status_update_trigger
AFTER UPDATE ON PASSENGER
FOR EACH ROW
WHEN (new.Status_StatusID = 2)
BEGIN
  -- Insert a new record into the audit table
  INSERT INTO passenger_cancel_audit (PassengerID, operation_type, audit_timestamp)
  VALUES (:NEW.PassengerID, 'UPDATE', SYSTIMESTAMP);
END;
/

-- Trigger: ROUTE_UPDATE_TRIGGER
CREATE OR REPLACE TRIGGER ROUTE_UPDATE_TRIGGER 
AFTER INSERT ON Routes
for each row
BEGIN
    -- Insert a new record into the routes audit table
  INSERT INTO routes_audit (RouteID, operation_type, audit_timestamp)
  VALUES (:NEW.routeid, 'INSERT', SYSTIMESTAMP);
END;
/

-- Trigger: FLIGHT_SCHEDULE_INSERT_TRIGGER
CREATE OR REPLACE TRIGGER FLIGHT_SCHEDULE_INSERT_TRIGGER 
AFTER INSERT ON FLIGHT_SCHEDULES
for each row
BEGIN
    -- Insert a new record into the routes audit table
  INSERT INTO FLIGHT_SCHEDULES_audit (FLIGHT_SCHEDULE_ID, operation_type, audit_timestamp)
  VALUES (:NEW.FLIGHT_SCHEDULE_ID, 'INSERT', SYSTIMESTAMP);
END;
/

-- Trigger: FLIGHT_TYPE_INSERT_TRIGGER
CREATE OR REPLACE TRIGGER FLIGHT_TYPE_INSERT_TRIGGER 
AFTER INSERT ON FLIGHT_TYPE
for each row
BEGIN
    -- Insert a new record into the routes audit table
  INSERT INTO FLIGHT_TYPE_audit (FlightTypeID, operation_type, audit_timestamp)
  VALUES (:NEW.FlightTypeID, 'INSERT', SYSTIMESTAMP);
END;
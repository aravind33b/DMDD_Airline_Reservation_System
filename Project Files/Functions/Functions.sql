-- Function: calculate_passenger_count
create or replace FUNCTION calculate_passenger_count(p_booking_id IN NUMBER)
RETURN NUMBER
IS
    l_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO l_count
    FROM PASSENGER
    WHERE BOOKING_BookingID = p_booking_id;
    
    RETURN l_count;
END;
/

-- Function: Flight_Schedule_Exists
create or replace FUNCTION FLIGHT_SCHEDULE_EXISTS(FLIGHT_SCHEDULE_ID_IN IN NUMBER) RETURN VARCHAR2 AS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM FLIGHT_SCHEDULES
  WHERE FLIGHT_SCHEDULE_ID = FLIGHT_SCHEDULE_ID_IN;
  
  IF v_count = 0 THEN
    RETURN 'Flight schedule does not exist';
  ELSE
    RETURN 'Flight schedule exists';
  END IF;
END FLIGHT_SCHEDULE_EXISTS;
/

-- Function: Promotion_Exists
create or replace FUNCTION PROMOTION_EXISTS(PROMOTION_ID_IN IN NUMBER) RETURN VARCHAR2 AS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM PROMOTION
  WHERE PromotionID = PROMOTION_ID_IN;
  
  IF v_count = 0 THEN
    RETURN 'Promotion does not exist';
  ELSE
    RETURN 'Promotion exists';
  END IF;
END PROMOTION_EXISTS;
/

-- Function: Promotion_Is_Active
create or replace FUNCTION PROMOTION_IS_ACTIVE(PROMOTION_ID_IN IN NUMBER) RETURN VARCHAR2 AS
  v_active VARCHAR2(1);
BEGIN
  SELECT Active INTO v_active
  FROM PROMOTION
  WHERE PromotionID = PROMOTION_ID_IN;
  
  IF v_active = 'Y' THEN
    RETURN 'Promotion is active';
  ELSE
    RETURN 'Promotion is not active';
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'Promotion does not exist';
END PROMOTION_IS_ACTIVE;
/

-- Function: Seat_Type_Exists
create or replace FUNCTION SEAT_TYPE_EXISTS(SEAT_TYPE_ID_IN IN NUMBER) RETURN VARCHAR2 AS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM SEAT_TYPE
  WHERE SEATTYPEID = SEAT_TYPE_ID_IN;
  
  IF v_count = 0 THEN
    RETURN 'Seat type does not exist';
  ELSE
    RETURN 'Seat type exists';
  END IF;
END SEAT_TYPE_EXISTS;
/

-- Function: Total_Seats_Available
create or replace FUNCTION TOTAL_SEATS_AVAILABLE(FLIGHT_TYPE_ID IN NUMBER) RETURN NUMBER AS
  v_total_seats NUMBER;
BEGIN
  SELECT SUM(CAST(SeatsAvailable AS NUMBER)) INTO v_total_seats
  FROM FLIGHT_SCHEDULES FS
  INNER JOIN ROUTES R ON FS.ROUTES_RouteID = R.RouteID
  WHERE R.FlightType_FlightTypeID = FLIGHT_TYPE_ID;
  
  RETURN v_total_seats;
END TOTAL_SEATS_AVAILABLE;
/


-- Function: user_exists
create or replace FUNCTION user_exists(p_user_id IN NUMBER)
RETURN BOOLEAN
IS
    l_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO l_count
    FROM Customer
    WHERE Customerid = p_user_id;
    
    IF l_count > 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;

/
create or replace FUNCTION get_flight_Seat_availability(fs_id IN NUMBER)
RETURN NUMBER
IS
    seat_count NUMBER;
BEGIN
    SELECT SEATSAVAILABLE
    INTO seat_count
    FROM FLIGHT_SCHEDULES
    WHERE FLIGHT_SCHEDULE_ID = fs_id;
    
    RETURN seat_count;
END;
/
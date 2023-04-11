CREATE OR REPLACE PACKAGE pkg_airline AS
    PROCEDURE route_add (
        departuretime routes.departuretime%TYPE,
        durationmin   routes.durationoftravelinminutes%TYPE,
        inputftid     routes.flighttype_flighttypeid%TYPE,
        src           routes.sourceairport%TYPE,
        dest          routes.destinationairport%TYPE
    );

    invalid_data EXCEPTION;
END pkg_airline;
/

CREATE OR REPLACE PACKAGE BODY pkg_airline AS

    PROCEDURE route_add (
        departuretime routes.departuretime%TYPE,
        durationmin   routes.durationoftravelinminutes%TYPE,
        inputftid     routes.flighttype_flighttypeid%TYPE,
        src           routes.sourceairport%TYPE,
        dest          routes.destinationairport%TYPE
    ) IS
        cntflighttype NUMBER;
        routeno       VARCHAR(3);
    BEGIN
        SELECT
            COUNT(*)
        INTO cntflighttype
        FROM
            flight_type
        WHERE
            flighttypeid = inputftid;

        IF cntflighttype = 0 THEN
            RAISE invalid_data;
        ELSIF departuretime IS NULL OR length(departuretime) = 0 THEN
            RAISE invalid_data;
        ELSIF durationmin IS NULL OR durationmin = 0 THEN
            RAISE invalid_data;
        ELSIF src = dest THEN
            RAISE invalid_data;
        ELSE
            routeno := dbms_random.string('U', 3);
            INSERT INTO routes (
                routeid,
                routeno,
                departuretime,
                durationoftravelinminutes,
                flighttype_flighttypeid,
                sourceairport,
                destinationairport
            ) VALUES (
                seq_route.NEXTVAL,
                routeno,
                departuretime,
                durationmin,
                inputftid,
                src,
                dest
            );

            COMMIT;
            dbms_output.put_line('ROUTE ADDED SUCCCESSFULLY');
        END IF;

    EXCEPTION
        WHEN invalid_data THEN
            dbms_output.put_line('INVALID DATA ENTERED');
        WHEN OTHERS THEN
            dbms_output.put_line(sqlerrm);
    END;

END pkg_airline;
/
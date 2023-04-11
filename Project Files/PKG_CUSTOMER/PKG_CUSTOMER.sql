CREATE OR REPLACE PACKAGE pkg_customer AS 
   PROCEDURE customer_signup(firstName CUSTOMER.FIRSTNAME%TYPE, lastName CUSTOMER.LASTNAME%TYPE, inputEmail CUSTOMER.EMAIL%TYPE, mobileno CUSTOMER.MOBILENO%TYPE);
   INVALID_DATA EXCEPTION;
   ALREADY_EXISTS EXCEPTION;
END pkg_customer; 
/
CREATE OR REPLACE PACKAGE BODY pkg_customer AS
    PROCEDURE customer_signup(firstName CUSTOMER.FIRSTNAME%TYPE, lastName CUSTOMER.LASTNAME%TYPE, inputEmail CUSTOMER.EMAIL%TYPE, mobileno CUSTOMER.MOBILENO%TYPE) IS
        cntUser number;
        fn varchar(40);
    BEGIN
        SELECT COUNT(*) into cntUser from CUSTOMER  WHERE email = inputEmail;
        IF cntUser >= 1 THEN
            RAISE ALREADY_EXISTS;
        ELSIF firstName IS NULL OR LENGTH(firstName) = 0 then
            RAISE INVALID_DATA;
        ELSIF lastName IS NULL OR LENGTH(lastName) = 0 then
            RAISE INVALID_DATA;
        ELSIF inputEmail IS NULL OR LENGTH(inputEmail) = 0 then
            RAISE INVALID_DATA;
        ELSIF mobileno IS NULL OR LENGTH(mobileno) = 0 OR LENGTH(mobileno) < 10 then
            RAISE INVALID_DATA;
        ELSIF REGEXP_COUNT(mobileno,'^[0-9]+$') <> 1 then
            RAISE INVALID_DATA;
        ELSE
            INSERT INTO CUSTOMER (CUSTOMERID, FIRSTNAME, LASTNAME, EMAIL, MOBILENO) VALUES (seq_customer.nextval, firstName, lastName, inputEmail, mobileno);
            commit;
            dbms_output.put_line('USER ADDED SUCCCESSFULLY');
        END IF;
    EXCEPTION
        WHEN INVALID_DATA THEN
            dbms_output.put_line('INVALID DATA ENTERED');
        WHEN ALREADY_EXISTS THEN
            dbms_output.put_line('ACCOUNT ALREADY EXISTS');
        WHEN OTHERS THEN
            dbms_output.put_line(SQLERRM);
    END;
END pkg_customer;
/
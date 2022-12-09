-- 2b
-- generates a random integer from (1,10000) to be the orderID for CustOrder
DROP FUNCTION createCustOrderID;
CREATE FUNCTION createCustOrderID()
RETURN int IS	
	rand_id int;
BEGIN
	SELECT dbms_random.value(1,10000) INTO rand_id FROM dual;
	RETURN rand_id;
END;
/

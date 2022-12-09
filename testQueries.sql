SET PAGESIZE 20
SET LINESIZE 120

spool new_output.txt


-- ** THESE FILES MUST BE RAN BEFORE THE testQueries.sql **
-- 	@initialize.sql
-- 	@createOrderLineItem.sql
--	@upgradeGold.sql
--	@setShippingDate.sql
--	@computeTotal.sql

@initialize.sql;



COLUMN name                    HEADING 'NAME'
COLUMN email                   HEADING 'EMAIL'
COLUMN phoneNum                HEADING 'PHONENUM'
COLUMN address                 HEADING 'ADDRESS'
COLUMN orderDate               HEADING 'ORDER DATE'
COLUMN shippedDate             HEADING 'SHIPPED DATE'
COLUMN title                   HEADING 'TITLE'
COLUMN si.price                HEADING 'ITEM PRICE'
COLUMN total                   HEADING 'total'
COLUMN quantity                HEADING 'QUANTITY'
COLUMN tax                     HEADING 'TAX'
COLUMN shippingFee             HEADING 'SHIPPING FEE'
COLUMN discount                HEADING 'DISCOUNT'
COLUMN grandTotal              HEADING 'GRAND TOTAL'



SELECT lineID, orderID FROM OrderLineItem;
-- create an OrderLineItem
-- 	orderID = 1
--	itemID = 2
-- 	Quantity = 2
EXEC createOrderLineItem(1, 2, 8, 2);
SELECT lineID, orderID FROM OrderLineItem;
-- new object shown in DB

-- change customer 8 from Regular --> Gold
SELECT custid, custType FROM Customer WHERE custid = 8;
SELECT custid, shippingFee FROM CustOrder WHERE custid = 8;
EXEC upgradeGold(8);
SELECT custid, custType FROM Customer WHERE custid = 8;
SELECT custid, shippingFee FROM CustOrder WHERE custid = 8;

-- change shippedDate for CustOrder#1 from NULL --> '12/12/2022'
SELECT shippedDate FROM CustOrder WHERE orderID = 1;
EXEC setShippingDate(1, '08-08-2022');
SELECT shippedDate FROM CustOrder WHERE orderID = 1;


-- add more OrderLineItems to test computeTotal()
EXEC createOrderLineItem(1, 3, 8, 3); 
EXEC createOrderLineItem(1, 4, 8, 4);
EXEC createOrderLineItem(1, 5, 8, 2);
EXEC createOrderLineItem(1, 6, 8, 1);
SELECT * FROM OrderLineItem;

SELECT computeTotal(1) as TotalPrice FROM Dual;

spool off;

CLEAR COLUMNS
CLEAR BREAK
TTITLE OFF 
BTITLE OFF
SET VERIFY OFF 
SET FEEDBACK OFF
SET RECSEP OFF
SET ECHO OFF



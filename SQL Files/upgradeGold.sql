-- 2d
-- trigger to check orders and set shippingFee to 0
DROP PROCEDURE upgradeGold;
CREATE PROCEDURE upgradeGold(
	this_custID int )
IS
BEGIN
	UPDATE Customer
		SET Customer.custType = 'Gold' WHERE Customer.custID = this_custID;
	UPDATE CustOrder
		SET CustOrder.shippingFee = 0 WHERE CustOrder.custID = this_custID;
END;
/

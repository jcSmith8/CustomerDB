-- 2f
-- computes total for an order by calculating individual price per StoreItem * quantity ordered
DROP FUNCTION computeTotal;
CREATE FUNCTION computeTotal(
	this_orderID int )
RETURN NUMBER IS
	line_price number;
BEGIN
	SELECT sum(OrderLineItem.linePrice) INTO line_price FROM orderLineItem
	WHERE OrderLineItem.orderID = this_orderID;
	RETURN line_price;
END;
/

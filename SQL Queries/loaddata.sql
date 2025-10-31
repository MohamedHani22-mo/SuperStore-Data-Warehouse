insert into DimCustomer(
CustomerID,
CustomerName,
Segment
)
select
distinct
CustomerID,
CustomerName,
Segment
from SourceFile

insert into DimOrders(
OrderID,
OrderDate,
ShipDate,
ShipMode
)
Select
distinct
OrderID,
OrderDate,
ShipDate,
ShipMode
from SourceFile

insert into DimProducts(
ProductID,
ProductName,
Category,
SubCategory
)
select
distinct
ProductID,
ProductName,
Category,
SubCategory
from SourceFile

insert into DimAddress(
Country,
City,
State,
Region,
PostalCode
)
Select
distinct
Country,
City,
State,
Region,
PostalCode
from SourceFile

INSERT INTO FactTable (CustomerSK, OrderSK, ProductSK, AddressSK, Sales)
select
    dc.CustomerSK,
    do.OrderSK,
    dp.ProductSK,
    da.AddressSK,
    sf.Sales
FROM SourceFile sf
LEFT JOIN DimCustomer dc
    ON sf.CustomerID = dc.CustomerID
    AND sf.CustomerName = dc.CustomerName
    AND sf.Segment = dc.Segment
LEFT JOIN DimOrders do
    ON sf.OrderID = do.OrderID
    AND sf.OrderDate = do.OrderDate
    AND sf.ShipDate = do.ShipDate
    AND sf.ShipMode = do.ShipMode
LEFT JOIN DimProducts dp
    ON sf.ProductID = dp.ProductID
    AND sf.ProductName = dp.ProductName
    AND sf.Category = dp.Category
    AND sf.SubCategory = dp.SubCategory
LEFT JOIN DimAddress da
    ON sf.City = da.City 
    AND sf.State = da.State 
    AND sf.Country = da.Country
    AND sf.Region = da.Region
    AND sf.PostalCode = da.PostalCode;

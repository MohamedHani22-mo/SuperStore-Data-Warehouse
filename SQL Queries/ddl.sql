CREATE TABLE SourceFile (
    OrderID nvarchar(255),
    OrderDate Date,
    ShipDate Date,
    ShipMode nvarchar(255),
    CustomerID nvarchar(255),
    CustomerName nvarchar(255),
    Segment nvarchar(255),
    Country nvarchar(255),
    City nvarchar(255),
    State nvarchar(255),
    PostalCode int,
    Region nvarchar(255),
    ProductID nvarchar(255),
    Category nvarchar(255),
    SubCategory nvarchar(255),
    ProductName nvarchar(255),
    Sales float
)

Create Table DimCustomer(
CustomerSK int identity(1,1) primary Key,
CustomerID Nvarchar(255),
CustomerName  Nvarchar(255),
Segment  Nvarchar(255)
)

Create Table DimOrders(
OrderSK int identity(1,1) primary Key,
OrderID Nvarchar(255),
OrderDate Date,
ShipDate Date, 
ShipMode Nvarchar(255)
)

Create table DimProducts(
ProductSK int identity(1,1) primary Key,
ProductID Nvarchar(255),
ProductName Nvarchar(255),
Category Nvarchar(255),
SubCategory Nvarchar(255)
)

Create Table DimAddress(
AddressSK int identity(1,1) primary Key,
Country Nvarchar(255),
City Nvarchar(255),
State Nvarchar(255),
Region Nvarchar(255),
PostalCode int
)

Create Table FactTable(
CustomerSK int,
OrderSK int,
ProductSK int,
AddressSK int,
sales float,
Constraint fk1 foreign key (CustomerSk) references DimCustomer(CustomerSK),
Constraint fk2 foreign key (OrderSk) references DimOrders(OrderSk),
Constraint fk3 foreign key (ProductSk) references DimProducts(ProductSk),
Constraint fk4 foreign key (AddressSk) references DimAddress(AddressSk)
)



ALTER TABLE FactTable
ADD OrderDateSK INT,
    ShipDateSK INT;


ALTER TABLE FactTable
ADD CONSTRAINT fk_orderdate FOREIGN KEY (OrderDateSK) REFERENCES DimDate(DateKey),
    CONSTRAINT fk_shipdate FOREIGN KEY (ShipDateSK) REFERENCES DimDate(DateKey);


UPDATE f
SET 
f.OrderDateSK = CONVERT(INT, CONVERT(CHAR(8), s.OrderDate, 112)),
f.ShipDateSK = CONVERT(INT, CONVERT(CHAR(8), s.ShipDate, 112))
FROM FactTable f
JOIN SourceFile s 
    ON f.OrderSK = (
        SELECT TOP 1 o.OrderSK 
        FROM DimOrders o
        WHERE o.OrderID = s.OrderID
    );


select *from FactTable
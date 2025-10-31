--Total Customers
Select
COUNT(Distinct CustomerSk) as TotalCustomer
from FactTable 
----------------------------------------------------------------------------------
--Total Orders 
Select
COUNT(Orderid) as TotlaOrders
from DimOrders
------------------------------------------------------------------------------------
-- Average Sales By Customer
Select
round(SUM(Sales)/COUNT(Distinct CustomerSk),3) as AVGSales_BYCustomer
from facttable
-----------------------------------------------------------------------------------------
-- Average Sales By Orders
Select
round(SUM(Sales)/COUNT(Distinct OrderSK),3) as AVGSales_BYOrders
from facttable
--------------------------------------------------------------------------------------------
--Customer Segment
Select 
Segment,
Count(CustomerSk) as TotalCustomers
from DimCustomer
group by Segment
-------------------------------------------------------------------------------------------------
--Total Porducts
Select
Count(distinct ProductSK) as TotalProducts
from FactTable
-----------------------------------------------------------------------------------------------
-- Total Ctaegory
Select 
Category
from DimProducts
group By Category
--------------------------------------------------------------------------------------------------
-- Total SubCategory
Select 
SubCategory
from DimProducts
group By SubCategory
-------------------------------------------------------------------------------------------------------
--Products Count By Category & SubCategory
Select
Category,
SubCategory,
COUNT(ProductSk) TotalProducts
from DimProducts
Group By Category,Subcategory
order by Category , COUNT(ProductSk) desc
-----------------------------------------------------------------------------------------------------
--Sales By Category
Select
Category,
round(SUM(Sales),2) as TotalSales
from FactTable f inner join DimProducts dp
on f.ProductSK=dp.ProductSK
Group By Category
order by round(SUM(Sales),2) desc
------------------------------------------------------------------------------------------------------
--Sales By SubCategory
Select
SubCategory,
round(SUM(Sales),2) as TotalSales
from FactTable f inner join DimProducts dp
on f.ProductSK=dp.ProductSK
Group By SubCategory
order by round(SUM(Sales),2) desc
-------------------------------------------------------------------------------------------------------
--Sales By Segment
Select 
Segment,
round(Sum(Sales),2) as TotalSales
from DimCustomer c Left Join FactTable f
on c.CustomerSK=f.CustomerSK
group by Segment
------------------------------------------------------------------------------------------------------
--Top 10 Customers by Total Sales
Select
top(10)
CustomerID,
CustomerName,
SUM(Sales) as TotalSales
from DimCustomer c left join facttable f
on c.CustomerSK=f.CustomerSk 
 Left Join DimProducts p
on p.ProductSK=f.ProductSK
group by CustomerID,CustomerName
order by SUM(Sales)desc
-----------------------------------------------------------------------------------------------------
--Top 10 Customers by Count Of Orders
Select
top(10)
CustomerID,
CustomerName,
COUNT(distinct f.OrderSk) AS TotalOrders
from DimCustomer c left join facttable f
on c.CustomerSK=f.CustomerSk Left Join
DimOrders o on o.OrderSK=f.OrderSK
Group By CustomerID, CustomerName
order by COUNT(distinct f.OrderSk) desc
------------------------------------------------------------------------------------------------------
--Orders By SubCategory
Select
SubCategory,
COUNT(OrderSk) as TotalOrders
from DimProducts dp left join FactTable f
on dp.ProductSK=f.ProductSK
group by SubCategory
order by COUNT(OrderSk) desc
-----------------------------------------------------------------------------------------------------
--Orders By Category
Select
Category,
COUNT(OrderSk) as TotalOrders
from DimProducts dp left join FactTable f
on dp.ProductSK=f.ProductSK
group by Category
order by COUNT(OrderSk) desc
------------------------------------------------------------------------------------------------------
-- OrderShipped Type
Select 
ShipMode ,
COUNT(f.OrderSK) as TotalOrders
from DimOrders do left join FactTable f
on do.OrderSK=f.OrderSK
group by ShipMode
----------------------------------------------------------------------------------------------------
--Total Sales
Select 
SUM(Sales) as TotalSales
from FactTable
---------------------------------------------------------------------------------------------------
--Sales By Year
SELECT 
d1.Year AS OrderYear,
d2.Year AS ShipYear,
ROUND(SUM(f.Sales), 2) AS TotalSales
FROM FactTable f
LEFT JOIN DimDate d1 ON f.OrderDateSK = d1.DateKey
LEFT JOIN DimDate d2 ON f.ShipDateSK = d2.DateKey
GROUP BY d1.Year, d2.Year
ORDER BY d1.Year, d2.Year;
----------------------------------------------------------------------------------------------------
--Top 10 City Sales    **Country Column Have 1 Country USA**
Select 
top(10)
City,
SUM(sales) TotalSALES
from FactTable t left join DimAddress da
on t.AddressSK =da.AddressSK
group by city
order by SUM(sales) desc
---------------------------------------------------------------------------------------
--Sales By Products
Select
productname,
SUM(sales) as totalsales
from FactTable f left Join DimProducts pp
on f.ProductSK=pp.ProductSK
group by ProductName
order by SUM(sales)desc
-----------------------------------------------------------------------------------------
-- ShippMode Sales
Select 
ShipMode ,
round(sum(f.sales),2) as TotalOrders
from DimOrders do left join FactTable f
on do.OrderSK=f.OrderSK
group by ShipMode
order by sum(f.sales) desc



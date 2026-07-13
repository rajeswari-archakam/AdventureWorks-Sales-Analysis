create database saless;
use saless;
CREATE TABLE sales_data (
    ProductKey INT,
    OrderDateKey INT,
    DueDateKey INT,
    ShipDateKey INT,
    CustomerKey INT,
    PromotionKey INT,
    CurrencyKey INT,
    SalesTerritoryKey INT,
    SalesOrderNumber VARCHAR(20),
    SalesOrderLineNumber INT,
    RevisionNumber INT,
    OrderQuantity INT,
    UnitPrice DECIMAL(10,2),
    ExtendedAmount DECIMAL(12,2),
    UnitPriceDiscountPct DECIMAL(10,4),
    DiscountAmount DECIMAL(12,2),
    ProductStandardCost DECIMAL(12,4),
    TotalProductCost DECIMAL(12,4),
    SalesAmount DECIMAL(12,2),
    TaxAmt DECIMAL(12,4),
    Freight DECIMAL(12,4),
    CarrierTrackingNumber VARCHAR(50),
    CustomerPONumber VARCHAR(50),
    OrderDate DATE,
    DueDate DATE,
    ShipDate DATE,
    ProductSubcategoryKey INT,
    EnglishProductName VARCHAR(255),
    StandardCost DECIMAL(12,4),
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Gender CHAR(1),
    YearlyIncome INT,
    EnglishOccupation VARCHAR(100),
    CustomerFullName VARCHAR(255),
    ProductSubcategoryName VARCHAR(255),
    ProductCategoryKey INT,
    ProductCategoryName VARCHAR(100),
    Profit DECIMAL(12,4),
    EnglishDayNameOfWeek VARCHAR(20),
    MonthNumberOfYear INT,
    CalendarQuarter INT,
    CalendarYear INT,
    FiscalQuarter INT,
    FiscalYear INT,
    EnglishMonthName VARCHAR(20),
    SalesTerritoryRegion VARCHAR(100),
    SalesTerritoryCountry VARCHAR(100),
    SalesTerritoryGroup VARCHAR(100)
);
SET GLOBAL local_infile = 1;
SET sql_mode = '';
SHOW GLOBAL VARIABLES LIKE 'local_infile';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/final file sql.csv'
INTO TABLE sales_data
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
select * from sales_data;

#QNo.1

select distinct productcategoryname from sales_data;

#QNO.2

select customerfullname , sum(unitprice)
from sales_data
group by customerfullname ;
SELECT * FROM monthly_sales_summary;

#QNo.3 

CREATE TABLE date_dimension AS
SELECT
    OrderDateKey,
    OrderDate,
    YEAR(OrderDate) AS Year,
    MONTH(OrderDate) AS MonthNo,
    MONTHNAME(OrderDate) AS MonthFullName,
    CONCAT('Q', QUARTER(OrderDate)) AS Quarter,
    DATE_FORMAT(OrderDate,'%Y-%b') AS YearMonth,
    DAYOFWEEK(OrderDate) AS WeekdayNo,
    DAYNAME(OrderDate) AS WeekdayName,
    CASE
        WHEN MONTH(OrderDate) >= 4
        THEN MONTH(OrderDate) - 3
        ELSE MONTH(OrderDate) + 9
    END AS FinancialMonth,

    CASE
        WHEN MONTH(OrderDate) BETWEEN 4 AND 6 THEN 'Q1'
        WHEN MONTH(OrderDate) BETWEEN 7 AND 9 THEN 'Q2'
        WHEN MONTH(OrderDate) BETWEEN 10 AND 12 THEN 'Q3'
        ELSE 'Q4'
    END AS FinancialQuarter

FROM sales_data;

# QNo 4

SELECT
    CalendarYear,
    ROUND(SUM(SalesAmount), 4) AS TotalSalesAmount
FROM sales_data
GROUP BY CalendarYear
ORDER BY CalendarYear;

#QNo.5

SELECT CalendarYear,
ROUND(SUM(TotalProductCost), 4) AS TotalProductCost
FROM sales_data
GROUP BY CalendarYear
ORDER BY CalendarYear;

#QNo 6

SELECT
    ROUND(SUM(Profit), 2) AS TotalProfit
FROM sales_data;

# Q.NO 7

SELECT
    EnglishMonthName,
    SUM(SalesAmount) AS TotalSalesAmount
FROM sales_data
GROUP BY
    MonthNumberOfYear,
    EnglishMonthName
ORDER BY
    MonthNumberOfYear;
    
#Q.No 7

SELECT
    CalendarYear,
    SUM(SalesAmount) AS TotalSalesAmount
FROM sales_data
GROUP BY CalendarYear
ORDER BY CalendarYear;
SELECT * FROM yearly_sales_summary;
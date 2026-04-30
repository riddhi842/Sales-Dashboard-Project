USE ADVENTURE_WORKS_ANALYSIS;
SELECT * FROM DIMCUSTOMER;
SELECT * FROM DIMCUSTOMER WHERE FIRSTNAME IS NULL;
SELECT * FROM DIMDATE;
SELECT * FROM FACT_INTERNET_SALES_NEW;

# TOTAL SALES 
SELECT ROUND(SUM(SALESAMOUNT),2) AS TOTAL_SALES FROM FACT_INTERNET_SALES_NEW;

-- YEAR WISE SALES
SELECT 
    d.CalendarYear,
    ROUND(SUM(f.SalesAmount), 2) AS Total_Sales
FROM fact_internet_sales_new f
JOIN dimdate d 
    ON f.OrderDateKey = d.DateKey
GROUP BY d.CalendarYear
ORDER BY d.CalendarYear;
-- month wise sales trend
SELECT 
    d.MonthNumberOfYear,
    d.EnglishMonthName,
    ROUND(SUM(f.SalesAmount), 2) AS Monthly_Sales
FROM fact_internet_sales_new f
JOIN dimdate d 
    ON f.OrderDateKey = d.DateKey
GROUP BY d.MonthNumberOfYear, d.EnglishMonthName
ORDER BY d.MonthNumberOfYear;
-- sales by region
SELECT 
    t.SalesTerritoryRegion,
    ROUND(SUM(f.SalesAmount), 2) AS Total_Sales
FROM fact_internet_sales_new f
JOIN dimsalesterritory t 
    ON f.SalesTerritoryKey = t.SalesTerritoryKey
GROUP BY t.SalesTerritoryRegion
ORDER BY Total_Sales DESC;

-- Quater wise sales
SELECT 
    d.CalendarQuarter,
    ROUND(SUM(f.SalesAmount), 2) AS Total_Sales
FROM fact_internet_sales_new f
JOIN dimdate d 
    ON f.OrderDateKey = d.DateKey
GROUP BY d.CalendarQuarter
ORDER BY d.CalendarQuarter;

-- Total profit
SELECT * FROM FACT_INTERNET_SALES_NEW;
select round(sum(salesamount-ProductStandardCost),2) as profit from fact_internet_sales_new;

-- Profit margin
SELECT 
round((sum(salesamount-productstandardcost)
/sum(salesamount))*100,2) 
as profit_margin 
FROM FACT_INTERNET_SALES_NEW;

-- Total Order
SELECT * FROM FACT_INTERNET_SALES_NEW;

SELECT count(distinct(SalesOrderNumber)) as total_orders FROM FACT_INTERNET_SALES_NEW;

-- Sales vs cost
SELECT 
    d.EnglishMonthName,
    ROUND(SUM(f.SalesAmount), 2) AS Sales,
    ROUND(SUM(f.TotalProductCost), 2) AS Cost
FROM fact_internet_sales_new f
JOIN dimdate d 
    ON f.OrderDateKey = d.DateKey
GROUP BY d.MonthNumberOfYear, d.EnglishMonthName
ORDER BY d.MonthNumberOfYear;

-- Top region
SELECT 
    t.SalesTerritoryRegion,
    ROUND(SUM(f.SalesAmount), 2) AS Total_Sales
FROM fact_internet_sales_new f
JOIN dimsalesterritory t 
    ON f.SalesTerritoryKey = t.SalesTerritoryKey
GROUP BY t.SalesTerritoryRegion
ORDER BY Total_Sales DESC
LIMIT 1;
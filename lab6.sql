# Вывести на экран, для каждого продукта, количество его продаж, и соотношение числа покупателей этого продукта, к числу покупателей, купивших товары из категории, к которой относится данный товар

WITH 
    ProductSales AS (
        SELECT 
            p.ProductID,
            p.Name AS ProductName,
            psc.ProductCategoryID AS CategoryID,
            COUNT(sod.SalesOrderID) AS ProductSalesCount,
            COUNT(DISTINCT soh.CustomerID) AS ProductCustomerCount
        FROM 
            [AdventureWorks2017].[Sales].[SalesOrderHeader] AS soh
        JOIN 
            [AdventureWorks2017].[Sales].[SalesOrderDetail] AS sod 
            ON soh.SalesOrderId = sod.SalesOrderId
        JOIN 
            [AdventureWorks2017].[Production].[Product] AS p 
            ON sod.ProductID = p.ProductID
        JOIN 
            [AdventureWorks2017].[Production].[ProductSubcategory] AS psc 
            ON p.ProductSubcategoryID = psc.ProductSubcategoryID
        GROUP BY 
            p.ProductID, p.Name, psc.ProductCategoryID
    ),
    CategoryCustomerCounts AS (
        SELECT 
            psc.ProductCategoryID AS CategoryID,
            COUNT(DISTINCT soh.CustomerID) AS CategoryCustomerCount
        FROM 
            [AdventureWorks2017].[Sales].[SalesOrderHeader] AS soh
        JOIN 
            [AdventureWorks2017].[Sales].[SalesOrderDetail] AS sod 
            ON soh.SalesOrderId = sod.SalesOrderId
        JOIN 
            [AdventureWorks2017].[Production].[Product] AS p 
            ON sod.ProductID = p.ProductID
        JOIN 
            [AdventureWorks2017].[Production].[ProductSubcategory] AS psc 
            ON p.ProductSubcategoryID = psc.ProductSubcategoryID
        GROUP BY 
            psc.ProductCategoryID
    )

SELECT 
    ps.ProductName,
    ps.ProductSalesCount,
    ps.ProductCustomerCount,
    cc.CategoryCustomerCount,
    CAST(ps.ProductCustomerCount AS DECIMAL(10, 2)) / 
        NULLIF(cc.CategoryCustomerCount, 0) AS CustomerRatio
FROM 
    ProductSales AS ps
JOIN 
    CategoryCustomerCounts AS cc 
    ON ps.CategoryID = cc.CategoryID
ORDER BY 
    ps.ProductName;

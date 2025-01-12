# Вывести на экран список номеров категорий, ProductCategoryID, с наибольшим
количеством подкатегорий

SELECT ProductCategoryID, COUNT(*) as [Amount] FROM Production.ProductSubcategory
GROUP BY ProductCategoryID
ORDER BY [Amount] DESC

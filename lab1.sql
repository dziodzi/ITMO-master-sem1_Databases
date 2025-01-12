# Найти и вывести на экран названия продуктов, у которых цена лежит в диапазоне от 40 до 300, не включая границы диапазона

SELECT p.name from Production.Product as p
WHERE p.ListPrice > 40 AND p.ListPrice < 300

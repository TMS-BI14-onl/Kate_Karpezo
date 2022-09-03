/*
1.	Решите на базе данных AdventureWorks2017 следующие задачи:
a)	Извлечь все столбцы из таблицы Sales.SalesTerritory.
*/
	USE AdventureWorks2017
	SELECT *
	FROM Sales.SalesTerritory


-- b)	Извлечь столбцы TerritoryID и Name из таблицы Sales.SalesTerritory.
	
	USE AdventureWorks2017
	SELECT TerritoryID, Name
	FROM Sales.SalesTerritory

-- c)	Найдите все данные, которые существует для людей из Person.Person с LastName = ‘Norman’.

	USE AdventureWorks2017
	SELECT *
	FROM Person.Person
	WHERE LastName = 'Norman'


-- d)	Найдите все строки из Person.Person, где EmailPromotion не равен 2. 

	USE AdventureWorks2017
	SELECT *
	FROM Person.Person
	WHERE EmailPromotion != 2

/*
3. Какие ещё агрегатные функции существуют в языке T-SQL? Приведите несколько примеров.
Ответ:
/APPROX_COUNT_DISTINCT - возвращает приблизительное количество уникальных ненулевых значений в группе;
/CHECKSUM_AGG - возвращает контрольную сумму значений в группе;
/COUNT_BIG - возвращает количество элементов, найденных в группе;
/GROUPING - указывает, является ли указанное выражение столбца в списке GROUP BY агрегированным или нет;
/STDEV - возвращает статистическое стандартное отклонение;
/VAR - возвращает статистическую дисперсию всех значений. 
*/

/*
4.	Решите на базе данных AdventureWorks2017 следующие задачи:
a)	Сколько уникальных PersonType существует для людей из Person.Person с LastName начинающиеся с буквы М или не содержащий 1 в EmailPromotion.
Ответ: 6
*/
	USE AdventureWorks2017
	SELECT  COUNT(DISTINCT PersonType) AS DistinctCountPersonType
	FROM Person.Person
	WHERE LastName LIKE 'M%' OR EmailPromotion NOT LIKE '%1%'

-- b)	Вывести первых 3 специальных предложений из Sales.SpecialOffer с наибольшими DiscountPct, которые начинали действовать с 2013-01-01 по 2014-01-01

	USE AdventureWorks2017
	SELECT TOP 3 *
	FROM Sales.SpecialOffer
	WHERE ModifiedDate BETWEEN '2013-01-01' AND '2014-01-01'
	ORDER BY DiscountPct DESC

/*
c)	Найти самый минимальный вес и самый максимальный размер продукта из Production.Product.
Ответ: min вес 2.12; max размер XL; продукт с минимальным весом и максимальным размером 2.12/44 
*/

	USE AdventureWorks2017
	SELECT MIN(Weight) AS Weight
	FROM Production.Product

	USE AdventureWorks2017
	SELECT MAX(Size) AS Size
	FROM Production.Product

	USE AdventureWorks2017
	SELECT TOP 1 Weight, Size
	FROM Production.Product
	WHERE Weight IS NOT NULL AND Size IS NOT NULL	
	ORDER BY Weight ASC, Size DESC						-- интересно было совместить 2 условия, пока смогла только так найти :)


/*
d)	Найти самый минимальный вес и самый максимальный размер продукта для каждой подкатегории ProductSubcategoryID из Production.Product. 
*/

	USE AdventureWorks2017
	SELECT ProductSubcategoryID, MIN(Weight) AS 'Weight'
	FROM Production.Product
	GROUP BY ProductSubcategoryID

	USE AdventureWorks2017
	SELECT ProductSubcategoryID, MAX(Size) AS 'Size'
	FROM Production.Product
	GROUP BY ProductSubcategoryID


/*
e)	Найти самый минимальный вес и самый максимальный размер продукта для каждой подкатегории ProductSubcategoryID из Production.Product, где цвет продукта определен(Color).
*/

	USE AdventureWorks2017
	SELECT ProductSubcategoryID, MIN(Weight) AS 'Weight'
	FROM Production.Product
	WHERE Color IS NOT NULL	
	GROUP BY ProductSubcategoryID


	USE AdventureWorks2017
	SELECT ProductSubcategoryID, MAX(Size) AS 'Size'
	FROM Production.Product
	WHERE Color IS NOT NULL	
	GROUP BY ProductSubcategoryID


/*
3. При каких значениях оконные функции Row Number, Rank и Dense Rank вернут одинаковый результат?
Ответ: Одинаковые значения будут в 1-й строке
		OVER (ORDER BY первичный ключ)

4.	Решите на базе данных AdventureWorks2017 следующие задачи. 

a)	Изучите данные в таблице Production.UnitMeasure. Проверьте, есть ли здесь UnitMeasureCode, начинающиеся на букву ‘Т’. 
Ответ: нет

*/
	SELECT *
	FROM Production.UnitMeasure
	WHERE UnitMeasureCode LIKE 'T%'

/*
Сколько всего различных кодов здесь есть? 
Ответ: 38
*/
	SELECT COUNT (
					DISTINCT (UnitMeasureCode) )
	FROM Production.UnitMeasure
	
/*
Вставьте следующий набор данных в таблицу:
•	TT1, Test 1, 9 сентября 2020
•	TT2, Test 2, getdate()

Проверьте теперь, есть ли здесь UnitMeasureCode, начинающиеся на букву ‘Т’. 
Ответ: 2 строки
*/
	INSERT INTO Production.UnitMeasure ([UnitMeasureCode], [Name], [ModifiedDate])
	VALUES 
	('TT1', 'Test 1', CAST('2020-09-09' AS datetime)),
	('TT2', 'Test 2', getdate())
			

/*
b)	Теперь загрузите вставленный набор в новую, не существующую таблицу Production.UnitMeasureTest. Догрузите сюда информацию из Production.UnitMeasure по UnitMeasureCode = ‘CAN’. 
Посмотрите результат в отсортированном виде по коду. 
*/
	SELECT [UnitMeasureCode], [Name], [ModifiedDate]
	INTO Production.UnitMeasureTest
	FROM Production.UnitMeasure
	WHERE UnitMeasureCode LIKE 'T%'

	INSERT INTO Production.UnitMeasureTest ([UnitMeasureCode], [Name], [ModifiedDate])
	SELECT [UnitMeasureCode], [Name], [ModifiedDate]
	FROM Production.UnitMeasure
	WHERE UnitMeasureCode = 'CAN'

	SELECT *
	FROM Production.UnitMeasureTest
	ORDER BY UnitMeasureCode


--c)	Измените UnitMeasureCode для всего набора из Production.UnitMeasureTest на ‘TTT’.

	UPDATE Production.UnitMeasureTest
	SET UnitMeasureCode = 'TTT'
	

--d)	Удалите все строки из Production.UnitMeasureTest.

	DELETE
	FROM Production.UnitMeasureTest

--e)	Найдите информацию из Sales.SalesOrderDetail по заказам 43659,43664.  С помощью оконных функций MAX, MIN, AVG найдем агрегаты по LineTotal для каждого SalesOrderID.

	SELECT *,
	MAX(LineTotal) OVER (PARTITION BY SalesOrderID) AS "Max", 
	MIN(LineTotal) OVER (PARTITION BY SalesOrderID) AS "Min", 
	AVG(LineTotal) OVER (PARTITION BY SalesOrderID) AS "Avg"
	FROM Sales.SalesOrderDetail
	WHERE SalesOrderID IN (43659, 43664)
/*
f)	Изучите данные в объекте Sales.vSalesPerson. Создайте рейтинг cреди продавцов на основе годовых продаж SalesYTD, используя ранжирующую оконную функцию. 
Добавьте поле Login, состоящий из 3 первых букв фамилии в верхнем регистре + ‘login’ + TerritoryGroup (Null заменить на пустое значение). 
Кто возглавляет рейтинг? А кто возглавлял рейтинг в прошлом году (SalesLastYear). 
Ответ: YTD best seller Linds Mitchel; LY - Ranjit Varkey Chudukatil
*/
	
	SELECT CONCAT( UPPER(LEFT(LastName,3)), 'login', ISNULL(TerritoryGroup,'')) AS 'Login',
	BusinessEntityID, FirstName, LastName, JobTitle, City,SalesYTD, SalesLastYear,
	DENSE_RANK () OVER (ORDER BY SalesYTD DESC) AS 'Best Seller',
	DENSE_RANK () OVER (ORDER BY SalesLastYear DESC) AS 'Best Seller LY'
	FROM Sales.vSalesPerson
	ORDER BY SalesYTD DESC

--g)	Найдите первый будний день месяца (FROM не используем). Нужен стандартный код на все времена.


	SELECT  
	MONTH(GETDATE()) as the_month,
	CASE
		WHEN DATEPART(WEEKDAY, 
	DATEADD(day, 1, EOMONTH(DATEADD(month, -1, GETDATE())))
	)  = 6 
		THEN DATEADD(mm, DATEDIFF(MM, 0, GETDATE()), 0) + 2 
		WHEN DATEPART(WEEKDAY, 
	DATEADD(day, 1, EOMONTH(DATEADD(month, -1, GETDATE())))
	)  = 7 
		THEN DATEADD(mm, DATEDIFF(MM, 0, GETDATE()), 0) + 1
    ELSE DATEADD(mm, DATEDIFF(MM, 0, GETDATE()), 0)
	END as first_weekday
	
	


/*
5.	 Давайте еще раз остановимся и отточим понимание функции count. Найдите значения count(1), count(name), count(id), count(*) для следующей таблицы:
Id(PK)	Name		DepName
1		null		A
2		null		null
3		A			C
4		B			C
Ответ: 
count(1)=4
count(name)=2
count(id)=4
count(*)=4

*/
	
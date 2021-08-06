# postgresql

1. Вывести общее количество результатов

	select count(*) from exam_results;

2. Найти средний показатель финального результата для всех участников

	SELECT AVG(result) AS average_index FROM exam_results;

3. Найти минимальный и максимальный показатель. Вывести всю информацию о участниках, которые набрали соответсвующие максимальный или минимальный балл

	SELECT * FROM exam_results WHERE
	result = (SELECT MAX(RESULT) FROM exam_results)
	OR result = (SELECT MIN(RESULT) FROM exam_results);

4. Найти средний показатель финального результата для граждан РФ и для неграждан. Должно получиться: is_citizen, среднее

	SELECT is_citizen, AVG(result) AS average_index FROM exam_results
	GROUP BY is_citizen;

5. Найти минимальный, средний и максимальный показатель для каждого года рождения. В итоге должно получиться: год рождения, минимальный, средний, масимальный

	SELECT extract(year from date (birthday)) AS birth_year, MIN(result), AVG(result) AS average_index ,MAX(result) FROM exam_results
	GROUP BY extract(year from date (birthday));

6. Найти результаты для всех людей, которых зовут Олег или их полное имя длиннее 20 символов, отсортировав по возврасту: самые молодые вверху

	SELECT * FROM exam_results
	WHERE fullname LIKE 'Олег %' 
	OR LENGTH(fullname)>20
	ORDER BY birthday DESC;

7. Показать полную информацию о людях, чей результат выше среднего

	SELECT * FROM exam_results
	WHERE result>(SELECT AVG(result) AS average_index FROM exam_results);

8. Показать полную информацию о 3 людях с высшими результатами

	SELECT * FROM exam_results ORDER BY result DESC LIMIT 3;


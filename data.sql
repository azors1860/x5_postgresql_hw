CREATE TABLE "public"."exam_results" (
    "id" SERIAL,
    "fullname" TEXT NOT NULL,
    "result" INT4 NOT NULL,
    "birthday" DATE NOT NULL,
    "is_citizen" BOOLEAN NOT NULL,
    PRIMARY KEY ("id")
);

INSERT INTO "public"."exam_results" (
  "fullname",
  "result",
  "birthday",
  "is_citizen"
)
VALUES
  ('Олег Иванов', 95, '1989-01-08'::date, TRUE),
  ('Александр Конеприказчиков', 55, '1989-02-18'::date, TRUE),
  ('Олег Семенов', 40, '1989-05-05'::date, FALSE),
  ('Светлана Сакволетдинова', 90, '1980-08-01'::date, TRUE),
  ('Ольга Иванова', 75, '1980-02-09'::date, FALSE),
  ('Ольга Светлова', 70, '1990-10-08'::date, TRUE),
  ('Никита Соболев', 80, '1992-05-08'::date, TRUE),
  ('Кира Горева', 99, '1990-11-13'::date, TRUE),
  ('Олег Безруков', 30, '1995-08-03'::date, TRUE),
  ('Николай Вавилов', 44, '1985-03-08'::date, TRUE);
  
--Запрос 1
select count(*) from exam_results;
  
--Запрос 2
SELECT AVG(result) AS average_index FROM exam_results;
  
--Запрос 3
SELECT * FROM exam_results WHERE
result = (SELECT MAX(RESULT) FROM exam_results)
OR result = (SELECT MIN(RESULT) FROM exam_results);
  
--Запрос 4
SELECT is_citizen, AVG(result) AS average_index FROM exam_results
GROUP BY is_citizen;
  
--Запрос 5
SELECT extract(year from date (birthday)) AS birth_year, MIN(result), AVG(result) AS average_index ,MAX(result) FROM exam_results
GROUP BY extract(year from date (birthday));
  
--Запрос 6
SELECT * FROM exam_results
WHERE fullname LIKE 'Олег %' 
OR LENGTH(fullname)>20
ORDER BY birthday DESC;

--Запрос 7
SELECT * FROM exam_results
WHERE result>(SELECT AVG(result) AS average_index FROM exam_results);

--Запрос 8
SELECT * FROM exam_results ORDER BY result DESC LIMIT 3;

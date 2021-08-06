-- создаю таблицы
CREATE TABLE students (
"id" SERIAL PRIMARY KEY,
"name" TEXT NOT NULL,
"surname" TEXT NOT NULL,
"patronymic" TEXT NULL DEFAULT NULL,
"birthday" DATE NOT NULL,
"e-mail" TEXT NOT NULL);



CREATE TABLE courses (
"courses_id" SERIAL PRIMARY KEY,
"title" TEXT NOT NULL,
"start_date" DATE NOT NULL,
"end_date" DATE NOT NULL);



CREATE TABLE lectures (
  "id" SERIAL PRIMARY KEY,
  "title" TEXT NOT NULL,
  "date" DATE NOT NULL,
  "courses_id" INT4 NOT NULL,

  CONSTRAINT "course_fkey"
    FOREIGN KEY ("courses_id")
    REFERENCES "courses" ("courses_id")
    ON DELETE CASCADE);


CREATE TABLE student_courses (
  "students_id" INT4 NOT NULL,
  "courses_id" INT4 NOT NULL,

   CONSTRAINT "students_courses_pkey"
    PRIMARY KEY ("students_id","courses_id"),

  CONSTRAINT "student_fkey"
    FOREIGN KEY ("students_id")
    REFERENCES "students" ("id")
    ON DELETE CASCADE,
  CONSTRAINT "course_fkey"
    FOREIGN KEY ("courses_id")
    REFERENCES "courses" ("courses_id")
    ON DELETE CASCADE);
    
    
-- заполняю таблицы данными    
    INSERT INTO students (
  "name",
  "surname",
  "patronymic",
  "birthday",
  "e-mail"
)
VALUES
  ('Олег','Грушин','Михайлович','1989-05-05'::date,'grushin.o@x5.ru'),
  ('Константин','Лобанов','Валерьевич','1994-06-07'::date,'lobanov.k@x5.ru'),
  ('Валентин','Макрушин','Николаевич','1980-11-08'::date,'makrushin.v@x5.ru'),
  ('Елена','Великая','Леонидовна','1981-12-01'::date,'velikaya.e@x5.ru'),
  ('Григорий','Большой','Петрович','2000-01-01'::date,'bolshoj.g@x5.ru'),
  ('Всеволод','Всемогущий','Олегович','1975-02-15'::date,'vsemogushchij.v@x5.ru'),
  ('Егор','Краш','Иванович','1993-04-19'::date,'krash.e@x5.ru'),
  ('Тарас','Бульба','Михайлович','1999-08-15'::date,'bulba.t@x5.ru'),
  ('Виктория','Загребина','Сергеевна','1971-06-01'::date,'zagrebina.v@x5.ru'),
  ('Зинаида','Цой','Тарасовна','1969-09-15'::date,'tsoy.z@x5.ru');
  
INSERT INTO courses (
  "title",
  "start_date",
  "end_date"
)
VALUES
  ('basic_course', '2020-09-01'::date, '2020-11-05'::date),
  ('Python', '2020-11-05'::date, '2020-12-30'::date),
  ('Java', '2020-11-05'::date, '2020-12-29'::date),
  ('DevOps', '2020-11-05'::date, '2020-12-28'::date),
  ('Testing', '2020-11-05'::date, '2020-12-27'::date);
  

INSERT INTO lectures (
  "title",
  "date",
  "courses_id"
)
VALUES
  ('Git','2020-09-30'::date, 1),
  ('Основы линукса','2020-10-05'::date, 1),
  ('Основы докера','2020-10-10'::date, 1),
  ('Основы БД','2020-10-15'::date, 1),
  ('Python_1','2020-11-05'::date, 2),
  ('Python_2','2020-11-15'::date, 2),
  ('Python_3','2020-11-30'::date, 2),
  ('Python_4','2020-12-05'::date, 2),
  ('Java_1','2020-11-05'::date, 3),
  ('Java_2','2020-11-15'::date, 3),
  ('Java_3','2020-11-30'::date, 3),
  ('Java_4','2020-12-05'::date, 3),
  ('DevOps_1','2020-11-05'::date, 4),
  ('DevOps_2','2020-11-15'::date, 4),
  ('DevOps_3','2020-11-30'::date, 4),
  ('DevOps_4','2020-12-05'::date, 4),
  ('Testing_1','2020-11-05'::date, 5),
  ('Testing_2','2020-11-15'::date, 5),
  ('Testing_3','2020-11-30'::date, 5),
  ('Testing_4','2020-12-05'::date, 5);


INSERT INTO student_courses (
  "students_id",
  "courses_id"
)
VALUES
  (1,1),
  (1,2),
  (1,3),
  (1,4),
  (1,5),
  (2,1),
  (2,5),
  (3,3),
  (3,4),
  (3,5),
  (4,1),
  (4,2),
  (4,3),
  (4,4),
  (4,5),
  (5,1),
  (5,2),
  (6,1),
  (6,2),
  (6,3),
  (6,4),
  (7,1),
  (8,1),
  (9,1),
  (10,1);
  
  
  
  
  
-- 4. Сделать выборку: сколько всего лекций послушает каждый студент

SELECT 
  surname || ' ' || name AS fullname,
  COUNT(surname)
  FROM
    student_courses 
    LEFT JOIN "students"ON ("students_id" = "students"."id")
    FULL OUTER JOIN lectures USING (courses_id)
GROUP BY fullname;


-- 5. Найти самые популярные лекции, которые увидит больше всего студентов

SELECT 
  title,
  COUNT(title) as number_of_students
  FROM
    student_courses 
    LEFT JOIN "students"ON ("students_id" = "students"."id")
    FULL OUTER JOIN lectures USING (courses_id)
GROUP BY title
ORDER BY number_of_students DESC
LIMIT 5;

-- 6. Найти наименее популярные лекции, которые увидит меньше всего студентов

SELECT 
  title,
  COUNT(title) as number_of_students
  FROM
    student_courses 
    LEFT JOIN "students"ON ("students_id" = "students"."id")
    FULL OUTER JOIN lectures USING (courses_id)
GROUP BY title
ORDER BY number_of_students
LIMIT 5;

-- 7. Сделайте запрос с подзапросом, который выберет лекции, которые популярней среднего значения

SELECT 
  title,
  COUNT(title) as number_of_students
  FROM
    student_courses 
    LEFT JOIN "students"ON ("students_id" = "students"."id")
    FULL OUTER JOIN lectures USING (courses_id)
GROUP BY title
HAVING COUNT(title) > (SELECT
AVG(number_of_students) FROM (SELECT 
 COUNT(title) as number_of_students
  FROM
    student_courses 
    LEFT JOIN "students"ON ("students_id" = "students"."id")
    FULL OUTER JOIN lectures USING (courses_id)
GROUP BY title) AS nof);

-- 8. Выбрать все лекции, которые пройдут в рамках курсов, которые стартуют в текущем году

  SELECT
  DISTINCT lectures.title
  FROM
    student_courses 
    LEFT JOIN courses USING (courses_id)
    FULL OUTER JOIN lectures USING (courses_id)
  WHERE to_char(start_date, 'YYYY') = '2020';
  
-- 9. Выберете средний год рождения студентов для каждого курса  

SELECT
 title AS "course name",
 round(avg(EXTRACT(YEAR FROM birthday))) AS "average year of birth"
  FROM
    student_courses 
    LEFT JOIN "students"ON ("students_id" = "students"."id")
    LEFT JOIN courses USING (courses_id)
    GROUP BY title;
    
-- 10. Найдите все почты студентов для тех студентов, которые не зарегистрировались на самую непопулярную лекцию

CREATE VIEW viev_unpopular_course AS
SELECT
  "e-mail"
  FROM
    student_courses 
    LEFT JOIN "students"ON ("students_id" = "students"."id")
    LEFT JOIN courses USING (courses_id)
    WHERE title = (SELECT
  courses.title
  FROM
    student_courses 
    LEFT JOIN "students"ON ("students_id" = "students"."id")
    LEFT JOIN courses USING (courses_id)
    GROUP BY courses.title
    ORDER BY COUNT(courses.title)
    LIMIT 1);
    
SELECT
  "e-mail"
  FROM
    students
    LEFT JOIN viev_unpopular_course USING ("e-mail")
    WHERE viev_unpopular_course."e-mail" IS NULL;

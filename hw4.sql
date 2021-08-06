CREATE USER us SUPERUSER;

CREATE DATABASE "publications"
WITH OWNER "us"
ENCODING 'UTF8'
LC_COLLATE = 'en_US.UTF-8'
LC_CTYPE = 'en_US.UTF-8'
TEMPLATE template0;

\c publications

CREATE TABLE journals (
"journal_id" SERIAL PRIMARY KEY,
"title" TEXT NOT NULL,
year_foundation NUMERIC(4) NOT NULL
CONSTRAINT "correct_year" CHECK ("year_foundation" >=1800 AND "year_foundation" <=2100));

CREATE TABLE authors (
"author_id" SERIAL PRIMARY KEY,
"name" TEXT NOT NULL,
"surname" TEXT NOT NULL,
"patronymic" TEXT NULL DEFAULT NULL);



CREATE TABLE publications (
"publication_id" SERIAL PRIMARY KEY,
"title" TEXT NOT NULL,
"year_publication" NUMERIC(4) NOT NULL
CONSTRAINT "correct_year" CHECK ("year_publication" >=1800 AND "rating" <=2100),
"rating" INT NULL DEFAULT NULL
CONSTRAINT "normal_rating" CHECK ("rating" >=0 AND "rating" <=5),
"journal_id" INT4 NOT NULL,

CONSTRAINT "journal_fkey"
FOREIGN KEY ("journal_id")
REFERENCES "journals" ("journal_id")
ON DELETE CASCADE);



CREATE TABLE publication_authors (
"publication_id" INT4 NOT NULL,
"author_id" INT4 NOT NULL,

CONSTRAINT "publication_authors_pkey"
PRIMARY KEY ("publication_id","author_id"),

CONSTRAINT "publication_fkey"
FOREIGN KEY ("publication_id")
REFERENCES "publications" ("publication_id")
ON DELETE CASCADE,

CONSTRAINT "author_fkey"
FOREIGN KEY ("author_id")
REFERENCES "authors" ("author_id")
ON DELETE CASCADE);

CREATE INDEX "publications_year_publication_idx" ON "publications"
  USING HASH("year_publication");
  
CREATE INDEX "publications_rating_idx" ON "publications"
  USING HASH("rating");


--ЗАПОЛНЯЮ ТАБЛИЦЫ ДАННЫМИ

INSERT INTO authors (
  "name",
  "surname",
  "patronymic"
)
VALUES
  ('Олег','Грушин','Михайлович'),
  ('Константин','Лобанов','Валерьевич'),
  ('Валентин','Макрушин','Николаевич'),
  ('Елена','Великая','Леонидовна'),
  ('Григорий','Большой','Петрович'),
  ('Всеволод','Всемогущий','Олегович'),
  ('Егор','Иванов','Иванович'),
  ('Тарас','Иванов','Михайлович'),
  ('Виктория','Загребина','Сергеевна'),
  ('Михаил','Иванов', 'Михайлович'),
  ('Петр', 'Петров','Николаевич'),
  ('Василий','Иванов','Михайлович'),
  ('Евгений', 'Петров','Петрович'),
  ('Зинаида','Иванова','Тарасовна');
  
  
  
INSERT INTO journals (
  "title",
  "year_foundation"
)
VALUES
  ('Enter',2017),
  ('F1CD',1980),
  ('HARDWARE',2018),
  ('IT Manage',2000),
  ('Linux Format',2020),
  ('Open Source',1993),
  ('CNews',2000);



INSERT INTO publications (
  "title",
  "year_publication",
  "rating",
  "journal_id"
)
VALUES
  ('Introducing the DigitalOcean App Platform',2020,2,7),
  ('Lightstep Adds New GitHub Action',2019,3,2),
  ('MongoDB Atlas Adds MultiCloud Cluster Support',2018,4,2),
  ('Tesla Autopilot Easily Confused By Phantom Images',2017,5,2),
  ('Introducing The Android Kotlin Developer Nanodegree',2016,0,5),
  ('Google Data Studio Improves Analytics',2015,4,6),
  ('Developers Finally In Revolt Against Apple',2014,2,7);

  
  
INSERT INTO publications (
  "title",
  "year_publication",
  "journal_id"
)
VALUES
  ('The cat is the winner',2004,1),
  ('The loser Cat',2004,1),
  ('The biggest cat',2006,2),
  ('The story of a programmer',1999,3),
  
  ('publications 1',2020,4),
  ('publications 2',2020,4),
  ('publications 3',2020,4),
  ('publications 4',2020,4),
  
  ('publications 5',2020,4),
  ('publications 6',2020,4),
  ('publications 7',2020,5),
  ('publications 8',2020,5);
  
 
  
INSERT INTO publication_authors (
  "publication_id",
  "author_id"
)
VALUES

  (11,3),
  (11,4),
  (11,5),

  (2,7),
  (2,8),
  (4,10),
  (8,12),
  (9,12),
  (10,12),
  
  (1,1),
  (3,1),
  (2,1),
  (5,1),
  (6,1),
  (7,1),
  
  (7,2),
  (6,2),
  (5,2),
  (4,2),
  (3,2),
  (2,2),
  
  (12,5),
  (13,5),
  (14,5),
  (15,5),
  (16,5),
  (17,5),
  (18,6),
  (19,6);
  



--3. Выберите все публикации с Годом выхода не позже 2015, рейтингом 3 и более и автором с фамилией "Иванов".
SELECT 
  DISTINCT publication_id,
  title
  FROM
    publication_authors 
    INNER JOIN publications USING (publication_id)
    INNER JOIN authors USING (author_id)
WHERE year_publication > 2015 AND rating > 2 AND surname = 'Иванов';



--4. Выберите все публикации, в названии которых есть слово "cat" и год издания с 2000 по 2005.
SELECT 
  DISTINCT publication_id,
  title
  FROM
    publication_authors 
    LEFT JOIN publications USING (publication_id)
    LEFT JOIN authors USING (author_id)
WHERE year_publication > 1999 AND year_publication < 2005
      AND title ILIKE '%Cat%';
      
      
--5. Выберите все публикации, у которых в авторах есть человек, опубликовавший более 5 статей, и журнал основан более 5 лет назад.
SELECT 
DISTINCT publication_id,
  title
  FROM publication_authors 
    LEFT JOIN publications USING (publication_id)
    LEFT JOIN authors USING (author_id)
    WHERE journal_id IN 
       (SELECT journal_id FROM journals
        WHERE year_foundation < 2020-5)
    AND author_id IN
       (SELECT author_id FROM publication_authors 
       GROUP BY author_id
       HAVING COUNT(author_id)>5);
       
--6. Выберите все публикации, у которых в авторах есть человек, опубликовавший более 3 статей, И при этом в журнале, в котором они опубликованы, было опубликовано не менее 5 статей за последний год (любыми авторами).
SELECT DISTINCT title FROM publication_authors 
LEFT JOIN publications USING (publication_id)
WHERE author_id IN
(SELECT author_id FROM publication_authors
GROUP BY author_id
HAVING COUNT(author_id)>3)
AND journal_id IN
(SELECT journal_id FROM publication_authors 
LEFT JOIN publications USING (publication_id)
WHERE year_publication = 2020
GROUP BY journal_id
HAVING COUNT(journal_id)>=5);


--7. Выберите названия журналов, в которых опубликована хотя бы одна статьи с рейтингом 4.
SELECT DISTINCT "journals"."title" FROM publications
    LEFT JOIN journals USING (journal_id)
WHERE rating = 4;

--8. Выберите названия журналов, в которых была хотя бы одна публикация за последние 5 лет.
SELECT DISTINCT "journals"."title" FROM publications
    LEFT JOIN journals USING (journal_id)
WHERE year_publication > 2020-5;


--9. Выберите названия журналов, в которых опубликовано не менее 3 статей с рейтингом 3 и более.
SELECT journals.title FROM publications
    LEFT JOIN journals USING (journal_id)
    WHERE rating > 2
    GROUP BY journals.title
    HAVING COUNT(journal_id)>2;

--10. Выберите информацию: Название журнала, среднее количество авторов публикации. Выберите только те журналы, у которых среднее кол-во авторов публикации 3 и более. Отсортируйте в порядке уменьшения количества авторов.
SELECT DISTINCT journals.title, average_of_authors FROM publications
    LEFT JOIN journals USING (journal_id)
    LEFT JOIN (SELECT journal_id, AVG(co) AS average_of_authors
FROM publications
LEFT JOIN (SELECT publication_id, COUNT(publication_id) AS co
FROM publication_authors 
GROUP BY publication_id) AS T USING (publication_id)
GROUP BY journal_id) AS N USING (journal_id)
WHERE average_of_authors>=3
ORDER BY average_of_authors DESC;


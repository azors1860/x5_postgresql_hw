-- Задача 1
CREATE USER catperson SUPERUSER;

--Задачи 2-3
CREATE DATABASE "catproject"
WITH OWNER "catperson"
ENCODING 'UTF8'
LC_COLLATE = 'en_US.UTF-8'
LC_CTYPE = 'en_US.UTF-8'
TEMPLATE template0;

--Задачи 4-5
CREATE TABLE cats (
"id" SERIAL PRIMARY KEY,
"name" TEXT NOT NULL,
"birthday" DATE NOT NULL,
"gender" VARCHAR(1) NOT NULL,
"photo" TEXT,
"features" TEXT NOT NULL,
"owner_phone" VARCHAR(12) NOT NULL);

--Задача 6
INSERT INTO cats (
  "name",
  "birthday",
  "gender",
  "photo",
  "features",
  "owner_phone"
)
VALUES
  ('Олег','2019-01-08'::date,'m','https://lookw.ru/9/957/1566942116-92-2.jpg','спокойный характер','89998413344'),
  ('Александр','2018-02-18'::date,'m','https://demotivation.ru/wp-content/uploads/2020/04/100325-yana.jpg','очень чистоплотен','89998423244'),
  ('Олег','2009-05-05'::date,'m','https://vsthemes.ru/uploads/posts/2019-11/1581998028_cat_vsthemes_ru-19.jpg','высокий уровень интеллекта','89998813244'),
  ('Светлана','2010-08-01'::date,'f','https://cdn.fishki.net/upload/post/2016/09/01/2060650/tn/7-1.jpg','мало ест','89998413844'),
  ('Ольга','2011-02-09'::date,'f','https://i.pinimg.com/736x/6f/1c/1e/6f1c1eb654e6edb3b957463bcfdb788a.jpg','питается огурцами','89998413214'),
  ('Ольга','2011-10-08'::date,'f','https://img-fotki.yandex.ru/get/4300/127908635.bf3/0_174887_80c00eca_orig.jpg','густая шерсть','89996413244'),
  ('Никита','2015-05-08'::date,'m','https://moscow-oblast.sm-news.ru/wp-content/uploads/2020/08/07/1zoom.me_.jpg','вес 15кг','89998413243'),
  ('Кира','2020-10-13'::date,'f','https://bugaga.ru/uploads/posts/2017-03/1489051999_kotik-hosiko-23.jpg','вес 300гр','89998413224'),
  ('Олег','2016-08-03'::date, 'm','https://img2.goodfon.ru/wallpaper/nbig/0/b4/kotik-trava-kotenok-seryy.jpg','к еде не привередлив','89998413211'),
  ('Николай','2013-03-08'::date, 'm', 'https://img3.goodfon.ru/original/2048x1366/e/ca/kot-kotik-kote-kotenok-vzgliad-glaza-smotrit-korzina.jpg','борец за справедливость','89998413284');
  
--Задача 7
SELECT * FROM cats WHERE gender = 'm';
SELECT * FROM cats WHERE gender = 'f';

--Задача 8
SELECT * FROM cats WHERE photo LIKE '%.jpg' OR photo LIKE '%.jpeg';

--Задача 9
UPDATE cats 
SET
   "birthday" = '2019-05-01'::date
WHERE
   "id" = 4;
     
--Задача 10
DELETE FROM cats WHERE id = 5;

--Задача 11
INSERT INTO "public"."cats" ("name","birthday","gender","photo","features","owner_phone") 
VALUES 
('Михаил','2016-02-03'::date,'m','https://sun9-68.userapi.com/c636228/v636228255/201d6/36AssKcwye0.jpg','агресивный характер','89995553666');

--Задача 12
ALTER TABLE cats ADD COLUMN "chip" TEXT NULL DEFAULT NULL;
  
--Задача 13
UPDATE cats 
SET
   "chip" = 'W1465E684SF156S'
WHERE
   "id" = 2;
   
UPDATE cats 
SET
   "chip" = 'WADW84DAW494AW8'
WHERE
   "id" = 3;

-- Задания:
-- 1. Напишите запрос, который выводит список фильмов вместе с именами и фамилиями актеров, сыгравших в них. Отсортируйте результат по названию фильма и фамилии актера.
SELECT m.title as movie_name,
       a.first_name,
       a.last_name
FROM movie_actors ma
         JOIN public.actors a on ma.actor_id = a.actor_id
         JOIN public.movies m on m.movie_id = ma.movie_id
ORDER BY m.title, a.last_name;

-- 2. Напишите запрос, который выводит список всех клиентов и, если они совершали аренды, то укажите дату последней аренды. Если клиент не совершал аренды, дата аренды должна быть NULL.
SELECT c.first_name,
       c.last_name,
       m.title,
       r.rental_date,
       r.return_date
FROM customers c
         LEFT JOIN public.rentals r on c.customer_id = r.customer_id
         LEFT JOIN public.movies m on r.movie_id = m.movie_id;

-- 3. Напишите запрос, который выводит название фильмов, чья продолжительность больше средней продолжительности всех фильмов в базе данных.
SELECT *
FROM movies
WHERE duration > (SELECT avg(duration)
                  FROM movies);

-- Задание со звездочкой - выполняется по желанию
-- 1. Используя CTE, напишите запрос, который вычисляет количество аренд для каждого жанра и выводит жанры с общим количеством аренд, отсортированных по количеству аренд в порядке убывания.
WITH genre_rentals AS (SELECT movies.genre,
                              count(*) as total_rentails
                       FROM movies
                                JOIN public.rentals r on movies.movie_id = r.movie_id
                       GROUP BY movies.genre)
SELECT genre, total_rentails
FROM genre_rentals
ORDER BY total_rentails DESC;

-- 2. Напишите запрос, который выводит список всех уникальных имен актеров и клиентов в одном столбце. Укажите, что это за тип лица с помощью дополнительного столбца (например, ""Актер"" или ""Клиент"").

WITH person_name AS (SELECT first_name,
                            last_name,
                            'Актер' as persont_type
                     FROM actors
                     UNION
                     SELECT first_name,
                            last_name,
                            'Клиент' as persont_type
                     FROM customers)
SELECT pn.first_name,
       pn.last_name,
       pn.persont_type
FROM person_name pn;
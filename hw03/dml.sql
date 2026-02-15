-- 1. Напишите запрос, который выводит список фильмов, где рейтинг является NULL, и заменяет NULL на значение 0.
SELECT movie_id,
       title,
       release_year,
       genre,
       coalesce(rating, 0) as rating,
       duration,
       description,
       additional_info
FROM movies
WHERE rating IS NULL;

-- 2. Напишите запрос, который выводит название фильма и округленное вверх значение рейтинга до ближайшего целого числа.
SELECT title,
       ceil(rating) as rating
FROM movies;

-- 3. Выведите список клиентов, которые зарегистрировались в последний месяц.
WITH last_date AS (SELECT MAX(c.registration_date) as maxDate FROM customers c)

SELECT *
FROM customers c
         JOIN last_date ld
              ON c.registration_date >= date_trunc('month', ld.maxDate)
                  AND c.registration_date < date_trunc('month', ld.maxDate) + INTERVAL '1 month';


-- 4. Выведите количество дней, в течение которых каждый клиент держал у себя фильм.

-- P.S Написал 2 запроса)

-- 4.1. Для определения количества дней, сколько каждый клиент продержал каждый фильм
SELECT r.rental_id,
       m.title                                as movie_title,
       concat(c.first_name, ' ', c.last_name) as customer_name,
       r.rental_date,
       r.return_date,
       r.return_date - r.rental_date          as total_days
FROM rentals r
         JOIN public.movies m on r.movie_id = m.movie_id
         JOIN public.customers c on r.customer_id = c.customer_id;

-- 4.2 Для определения суммарного количества аренды фильмов каждым клиентом
SELECT concat(c.first_name, ' ', c.last_name) as customer_name,
       sum(r.return_date - r.rental_date)     as total_days
FROM rentals r
         JOIN public.movies m on r.movie_id = m.movie_id
         JOIN public.customers c on r.customer_id = c.customer_id
GROUP BY c.customer_id, customer_name;

-- 5. Напишите запрос, который выводит название фильма в верхнем регистре.
SELECT movie_id,
       upper(title),
       release_year,
       genre,
       rating,
       duration,
       description,
       additional_info
FROM movies;

-- Задания со звездочкой - выполняются по желанию:

-- 1. Выведите первые 50 символов описания фильма.
SELECT movie_id,
       title,
       release_year,
       genre,
       rating,
       duration,
       left(description, 50),
       additional_info
FROM movies;

-- 2. Напишите запрос, который выводит жанр и общее количество фильмов в каждом жанре.
SELECT genre, count(*)
FROM movies
GROUP BY genre;

-- 3. Напишите запрос, который выводит название фильма, его рейтинг и место в рейтинге по убыванию рейтинга.
SELECT title,
       rating,
       rank() OVER (ORDER BY rating DESC) as rank_position
FROM movies;

-- 4. Напишите запрос, который выводит название фильма, его рейтинг и рейтинг предыдущего фильма в списке по убыванию рейтинга.
SELECT title,
       rating,
       lag(rating) OVER (ORDER BY rating DESC) as rank_position
FROM movies;

-- 5. Напишите запрос, который для каждого жанра выводит средний рейтинг фильмов в этом жанре, округленный до двух знаков после запятой.
SELECT genre, round(avg(rating), 2) as avg_rating_genre
FROM movies
GROUP BY genre;

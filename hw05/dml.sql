-- Задания:
-- 1. Напишите запрос, который выводит название фильма и список языков, на которых доступен фильм. Используйте функции работы с JSON для извлечения массива языков из поля additional_info.
SELECT title, additional_info -> 'languages' as languages
FROM movies
;

-- 2. Напишите запрос, который выводит список фильмов, бюджет которых превышает 100 миллионов долларов. Бюджет хранится в поле additional_info внутри ключа budget.
SELECT title, additional_info -> 'budget' as budget
FROM movies
WHERE (additional_info ->> 'budget')::integer < 100_000_000
;

-- 3. Напишите запрос, который для каждого клиента создаёт JSON-объект с полями full_name (содержащим полное имя клиента) и contact (содержащим email и номер телефона). Выведите customer_id и созданный JSON-объект.
SELECT customer_id,
       jsonb_build_object(
               'full_name', concat(first_name, ' ', last_name),
               'contact_info', concat(email, ' ', phone_number)
       ) as json_customer_info
FROM customers
;

-- 4. Напишите запрос, который добавляет новый предпочитаемый жанр ""Drama"" в список preferred_genres для всех клиентов, которые подписаны на рассылку новостей (ключ newsletter имеет значение true).
SELECT *
FROM customers
WHERE (preferences ->> 'newsletter')::boolean IS TRUE
;

UPDATE customers
SET preferences = jsonb_set(
        preferences,
        '{preferred_genres}',
        (preferences -> 'preferred_genres') || '"Drama"'::jsonb
                  )
WHERE (preferences ->> 'newsletter')::boolean IS TRUE
  AND NOT (preferences -> 'preferred_genres') ? 'Drama'
;

-- 5. Напишите запрос, который вычисляет средний бюджет фильмов по жанрам. Учтите, что жанр хранится в поле genre таблицы Movie, а бюджет — внутри JSON-поля additional_info.
SELECT genre, avg((additional_info ->> 'budget')::integer) as budget
FROM movies
GROUP BY genre
;

-- Задание со звездочкой - выполняется по желанию.
-- 1. Напишите запрос, который выводит список клиентов, у которых в preferences указан предпочитаемый актёр ""Leonardo DiCaprio"".
SELECT customer_id,
       first_name,
       last_name,
       preferences -> 'preferred_actors' as preferred_actors
FROM customers
WHERE preferences -> 'preferred_actors' ? 'Leonardo DiCaprio'
;

-- 2. Напишите запрос, который выводит список фильмов, отсортированных по значению кассовых сборов box_office из поля additional_info в порядке убывания.
SELECT title,
       additional_info -> 'box_office'
FROM movies
ORDER BY (additional_info ->> 'box_office')::numeric DESC
;

-- 3. Напишите запрос, который выводит название фильма, его жанр и количество наград (awards) из additional_info.
SELECT title,
       genre,
       jsonb_array_length((additional_info -> 'awards')) as awards_count
FROM movies
;

-- 4. Напишите запрос, который подсчитывает количество фильмов, имеющих более чем одну награду в поле awards внутри additional_info.
SELECT count(*)
FROM movies
WHERE jsonb_array_length((additional_info -> 'awards')) > 1
;

-- 5. Напишите запрос, который удаляет ключ preferred_actors из поля preferences для всех клиентов.
SELECT preferences FROM customers;

UPDATE customers
SET preferences = preferences - 'preferred_actors';
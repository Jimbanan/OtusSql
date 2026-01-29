-- Наполнение данными
INSERT INTO directors (id, first_name, last_name, date_of_birth, nationality)
VALUES (1, 'Christopher', 'Nolan', '1970-07-30', 'British'),
       (2, 'Quentin', 'Tarantino', '1963-03-27', 'American'),
       (3, 'Steven', 'Spielberg', '1946-12-18', 'American'),
       (4, 'James', 'Cameron', '1954-08-16', 'Canadian'),
       (5, 'Ridley', 'Scott', '1937-11-30', 'British');

INSERT INTO actors (id, first_name, last_name, date_of_birth, nationality)
VALUES (1, 'Leonardo', 'DiCaprio', '1974-11-11', 'American'),
       (2, 'Brad', 'Pitt', '1963-12-18', 'American'),
       (3, 'Samuel', 'Jackson', '1948-12-21', 'American'),
       (4, 'Tom', 'Hanks', '1956-07-09', 'American'),
       (5, 'Christian', 'Bale', '1974-01-30', 'British'),
       (6, 'Morgan', 'Freeman', '1937-06-01', 'American'),
       (7, 'Russell', 'Crowe', '1964-04-07', 'New Zealand');

INSERT INTO movies (id, title, year_of_release, genre, rating, duration, description)
VALUES (1, 'Начало', 2010, 'Научная фантастика', 8.8, INTERVAL '2 hours 28 minutes',
        'Фантастический триллер о проникновении в сны и управлении сознанием'),
       (2, 'Криминальное чтиво', 1994, 'Криминал', 8.9, INTERVAL '2 hours 34 minutes',
        'Несколько переплетающихся криминальных историй в Лос-Анджелесе'),
       (3, 'Спасти рядового Райана', 1998, 'Военный', 8.6, INTERVAL '2 hours 49 minutes',
        'Военная драма о спасении солдата во время Второй мировой войны'),
       (4, 'Тёмный рыцарь', 2008, 'Боевик', 9.0, INTERVAL '2 hours 32 minutes',
        'История противостояния Бэтмена и Джокера'),
       (5, 'Гладиатор', 2000, 'Историческая драма', 8.5, INTERVAL '2 hours 35 minutes',
        'Римский генерал становится гладиатором'),
       (6, 'Аватар', 2009, 'Фантастика', 7.9, INTERVAL '2 hours 42 minutes',
        'Путешествие человека на планету Пандора'),
       (7, 'Интерстеллар', 2014, 'Научная фантастика', 8.7, INTERVAL '2 hours 49 minutes',
        'Космическая экспедиция ради спасения человечества'),
       (8, 'Бесславные ублюдки', 2009, 'Военный', 8.3, INTERVAL '2 hours 33 minutes',
        'Альтернативная история Второй мировой войны'),
       (9, 'Чужой', 1979, 'Ужасы', 8.1, INTERVAL '1 hour 57 minutes',
        'Столкновение экипажа космического корабля с инопланетным существом');

INSERT INTO movie_directors (movie_id, director_id)
VALUES (1, 1), -- Начало - Christopher Nolan
       (2, 2), -- Криминальное чтиво - Quentin Tarantino
       (3, 3), -- Спасти рядового Райана - Steven Spielberg
       (4, 1), -- Тёмный рыцарь — Christopher Nolan
       (7, 1), -- Интерстеллар — Christopher Nolan
       (5, 3), -- Гладиатор — Steven Spielberg
       (6, 4), -- Аватар — James Cameron
       (8, 2), -- Бесславные ублюдки — Quentin Tarantino
       (9, 5); -- Чужой — Ridley Scott

INSERT INTO movie_actors (movie_id, actor_id)
VALUES (1, 1), -- Начало - Leonardo DiCaprio
       (2, 2), -- Криминальное чтиво - Brad Pitt
       (2, 3), -- Криминальное чтиво - Samuel Jackson
       (3, 4), -- Спасти рядового Райана - Tom Hanks
       (4, 5), -- Тёмный рыцарь — Christian Bale
       (4, 6), -- Тёмный рыцарь — Morgan Freeman
       (5, 7), -- Гладиатор — Russell Crowe
       (6, 1), -- Аватар — Leonardo DiCaprio
       (7, 1), -- Интерстеллар — Leonardo DiCaprio
       (8, 2), -- Бесславные ублюдки — Brad Pitt
       (9, 6); -- Чужой — Morgan Freeman

INSERT INTO clients (id, first_name, last_name, email, phone, address)
VALUES (1, 'Иван', 'Иванов', 'ivan.ivanov@mail.ru', '+7-900-123-45-67', 'Москва'),
       (2, 'Пётр', 'Петров', 'petr.petrov@mail.ru', '+7-900-765-43-21', 'Санкт-Петербург'),
       (3, 'Алексей', 'Смирнов', 'alex.smirnov@mail.ru', '+7-900-555-11-22', 'Казань'),
       (4, 'Мария', 'Кузнецова', 'maria.k@mail.ru', '+7-900-777-33-44', 'Екатеринбург');

INSERT INTO orders (id, client_id, movie_id, rental_date, return_date)
VALUES (1, 1, 2, '2025-01-10', '2025-01-15'),
       (2, 1, 1, '2025-01-20', '2025-01-27'),
       (3, 2, 3, '2025-02-01', '2025-02-08'),
       (4, 3, 4, '2025-02-10', '2025-02-15'),
       (5, 3, 5, '2025-02-20', '2025-02-27'),
       (6, 4, 7, '2025-03-01', '2025-03-10'),
       (7, 2, 8, '2025-03-05', '2025-03-12');

-- Выборка данных
-- Напишите запрос, который выводит всех актеров.
SELECT *
FROM actors;

-- Напишите запрос, который выводит все фильмы жанра ""Научная фантастика"", выпущенные после 2010 года.
SELECT *
FROM movies
WHERE genre = 'Научная фантастика'
  AND year_of_release > 2010;

-- Напишите запрос, который выводит список актеров, отсортированных по фамилии в алфавитном порядке.
SELECT *
FROM actors
ORDER BY last_name;

-- Напишите запрос, который выводит топ 5 фильмов с самым высоким рейтингом.
SELECT *
FROM movies
ORDER BY rating desc
LIMIT 5;

-- Напишите запрос, который выводит следующую страницу (фильмы с 6 по 10) из отсортированного по рейтингу списка фильмов.
SELECT * FROM movies
ORDER BY rating desc
OFFSET 6
LIMIT 4;
-- Фильмы: информация о фильмах включает название, год выпуска, жанр, рейтинг, длительность и описание.
CREATE TABLE IF NOT EXISTS movies
(
    id              INTEGER PRIMARY KEY,
    title           VARCHAR NOT NULL,
    year_of_release SMALLINT CHECK ( year_of_release >= 1888),
    genre           VARCHAR NOT NULL,
    rating          DECIMAL CHECK ( rating BETWEEN 0 AND 10),
    duration        INTERVAL,
    description     VARCHAR NOT NULL
);

-- Режиссеры: информация о режиссерах включает имя, фамилию, дату рождения и национальность.
CREATE TABLE IF NOT EXISTS directors
(
    id            INTEGER PRIMARY KEY,
    first_name    VARCHAR(40) NOT NULL,
    last_name     VARCHAR(40),
    date_of_birth DATE        NOT NULL CHECK ( date_of_birth <= CURRENT_DATE - INTERVAL '14 years' ),
    nationality   VARCHAR(40) NOT NULL
);

-- Актеры: информация об актерах включает имя, фамилию, дату рождения и национальность.
CREATE TABLE IF NOT EXISTS actors
(
    id            INTEGER PRIMARY KEY,
    first_name    VARCHAR(40) NOT NULL,
    last_name     VARCHAR(40),
    date_of_birth DATE        NOT NULL CHECK ( date_of_birth <= CURRENT_DATE - INTERVAL '6 years' ),
    nationality   VARCHAR(40) NOT NULL
);

-- Клиенты: информация о клиентах включает имя, фамилию, email, номер телефона и адрес.
CREATE TABLE IF NOT EXISTS clients
(
    id         INTEGER PRIMARY KEY,
    first_name VARCHAR(40) NOT NULL,
    last_name  VARCHAR(40),
    email      VARCHAR(40) NOT NULL,
    phone      VARCHAR(17) NOT NULL,
    address    VARCHAR(40) NOT NULL
);

-- Заказы: клиенты могут арендовать фильмы. Информация о заказах включает клиента, фильм, дату аренды и дату возврата.
CREATE TABLE IF NOT EXISTS orders
(
    id          INTEGER PRIMARY KEY,
    client_id   INTEGER NOT NULL,
    movie_id    INTEGER NOT NULL,
    rental_date DATE    NOT NULL,
    return_date DATE    NOT NULL,

    FOREIGN KEY (client_id) REFERENCES clients (id),
    FOREIGN KEY (movie_id) REFERENCES movies (id)
);

-- Таблица связей Фильмы-Режиссеры
CREATE TABLE movie_directors
(
    movie_id    INTEGER NOT NULL,
    director_id INTEGER NOT NULL,
    PRIMARY KEY (movie_id, director_id),
    FOREIGN KEY (movie_id) REFERENCES movies (id),
    FOREIGN KEY (director_id) REFERENCES directors (id)
);

-- Таблица связей Фильмы-Актеры
CREATE TABLE movie_actors
(
    movie_id INTEGER NOT NULL,
    actor_id INTEGER NOT NULL,
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES movies (id),
    FOREIGN KEY (actor_id) REFERENCES actors (id)
);


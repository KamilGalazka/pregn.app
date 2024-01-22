DROP TABLE IF EXISTS users;

CREATE TABLE users
(
    id                   SERIAL PRIMARY KEY,
    name                 VARCHAR(255),
    lastname             VARCHAR(255),
    email                VARCHAR(255) UNIQUE,
    password_hash        VARCHAR(255),
    role                 VARCHAR(50),
    refresh_token        VARCHAR(255),
    reset_password_token VARCHAR(255),
    created_at           TIMESTAMP DEFAULT NOW(),
    updated_at           TIMESTAMP DEFAULT NOW()
);


DROP TABLE IF EXISTS refresh_tokens;

CREATE TABLE refresh_tokens
(
    id            SERIAL PRIMARY KEY,
    user_id       INT REFERENCES "users" (id),
    refresh_token VARCHAR
);


DROP TABLE IF EXISTS calendar;

CREATE TABLE calendar
(
    id       SERIAL PRIMARY KEY,
    user_id  INT REFERENCES "users" (id),
    title    VARCHAR NOT NULL,
    content  VARCHAR NOT NULL,
    priority INT     NOT NULL,
    date     VARCHAR NOT NULL
);


DROP TABLE IF EXISTS navigation;

CREATE TABLE navigation
(
    id        SERIAL PRIMARY KEY,
    name_pl   VARCHAR NOT NULL,
    name_en   VARCHAR NOT NULL,
    route     VARCHAR NOT NULL,
    published BOOLEAN NOT NULL DEFAULT TRUE,
    user_only BOOLEAN NOT NULL DEFAULT FALSE
);


DROP TABLE IF EXISTS pregnancy_stages;

CREATE TABLE pregnancy_stages
(
    id              SERIAL PRIMARY KEY,
    week            INT NOT NULL UNIQUE,
    description_pl  VARCHAR,
    description_en  VARCHAR,
    image_header_pl VARCHAR,
    image_header_en VARCHAR,
    length_cm       VARCHAR DEFAULT '',
    weight_kg       VARCHAR DEFAULT ''
);


DROP TABLE IF EXISTS article;

CREATE TABLE article
(
    id             SERIAL PRIMARY KEY,
    category       VARCHAR,
    title_pl       VARCHAR,
    title_en       VARCHAR,
    description_pl VARCHAR,
    description_en VARCHAR,
    image_name     VARCHAR,
    content_pl     VARCHAR,
    content_en     VARCHAR,
    published      BOOLEAN DEFAULT TRUE,
    published_date VARCHAR
);


DROP TABLE IF EXISTS user_images;

CREATE TABLE user_images
(
    id         SERIAL PRIMARY KEY,
    user_id    INT REFERENCES "users" (id),
    name       VARCHAR NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);


DROP TABLE IF EXISTS pages;

CREATE TABLE pages
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR NOT NULL,
    content_pl VARCHAR,
    content_en VARCHAR,
    published  BOOLEAN   DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

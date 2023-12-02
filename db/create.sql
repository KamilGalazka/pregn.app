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

INSERT INTO users (name, lastname, email, password_hash, role)
VALUES ('Test', 'Testowy', 'admin@admin.com', '$2b$10$j1yPpwKj7Qilx6ycaHf2A.U.sNOK6lcnU61KyEGmkFuDx9uugiTXK', 'admin');


DROP TABLE IF EXISTS navigation;

CREATE TABLE navigation
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    route VARCHAR(50) NOT NULL,
    published BOOLEAN NOT NULL DEFAULT TRUE
);

INSERT INTO navigation (name, route)
VALUES ('Etapy ciąży', '/stages'),
       ('Zdrowie', '/health'),
       ('Wyprawka', '/layette');
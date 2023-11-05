CREATE TABLE users
(
    id                   SERIAL PRIMARY KEY,
    name                 VARCHAR(255),
    lastname             VARCHAR(255),
    email                VARCHAR(255) UNIQUE,
    password_hash        VARCHAR(255),
    created_at           TIMESTAMP DEFAULT NOW(),
    updated_at           TIMESTAMP DEFAULT NOW(),
    role                 VARCHAR(50),
    verification_token   VARCHAR(255),
    reset_password_token VARCHAR(255)
);

INSERT INTO users (name, lastname, email, password_hash, role, verification_token, reset_password_token)
VALUES ('NOWY', 'Testowy', 'test@example.com', 'hashed_password_0', 'admin', 'verification_token_0', 'reset_token_0'),
       ('John', 'Doe', 'john@example.com', 'hashed_password_1', 'user', 'verification_token_1', 'reset_token_1'),
       ('Jane', 'Smith', 'jane@example.com', 'hashed_password_2', 'admin', 'verification_token_2', 'reset_token_2'),
       ('Bob', 'Johnson', 'bob@example.com', 'hashed_password_3', 'user', 'verification_token_3', 'reset_token_3');

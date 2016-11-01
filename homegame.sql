CREATE DATABASE homegame;

-- \c homegame;

CREATE TABLE user_types (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

INSERT INTO user_types (name) VALUES
('host');
INSERT INTO user_types (name) VALUES
('player');

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  email VARCHAR(100) NOT NULL,
  name VARCHAR(100) NOT NULL,
  password_digest VARCHAR (500) NOT NULL
);

CREATE TABLE reservations (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  game_id INTEGER,
  rsvp BOOLEAN
);

CREATE TABLE games (
  id SERIAL4 PRIMARY KEY,
  game_id INTEGER,
  game_date VARCHAR(100),
  buy_in INTEGER,
  game_type VARCHAR(100),
  address VARCHAR(200),
  city VARCHAR(50),
  description VARCHAR(500),
  image TEXT
);

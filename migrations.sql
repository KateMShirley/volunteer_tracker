CREATE DATABASE volunteers;

\c volunteers

CREATE TABLE users(id SERIAL PRIMARY KEY, first_name VARCHAR(255), last_name VARCHAR(255), username VARCHAR(255), email VARCHAR(255), password_salt VARCHAR(255), password_hash VARCHAR(255), goal INT);

CREATE TABLE opps(id SERIAL PRIMARY KEY, user_id INT references users(id), title VARCHAR(255), org VARCHAR(255), hours INT, description TEXT, location VARCHAR(255), category VARCHAR(255), completed BOOLEAN)

INSERT INTO users (first_name, last_name, username, email, password_salt, password_hash, goal) VALUES ('Kate', 'Shirley', 'kateTEST', 'kate.m.shirley@gmail.com', 1234, 1234, 50);

INSERT INTO opps (user_id, title, org, hours, description, location, category, completed) VALUES (1, 'Mentoring', 'Chicago Lights', 5, 'Mentor a middle school student on Saturday from 10-3', 'Chicago, IL', 'Education', false)

CREATE TABLE properties(id SERIAL PRIMARY KEY, name VARCHAR(60), description VARCHAR(500), price_per_night DECIMAL, letter_id INTEGER REFERENCES users (id));

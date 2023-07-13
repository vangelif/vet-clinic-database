/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
    name VARCHAR(50), 
    date_of_birth DATE, 
    escape_attempts INTEGER, 
    neutered BOOLEAN, 
    weight_kg DECIMAL
    );

ALTER TABLE animals
ADD COLUMN species VARCHAR(20);

CREATE TABLE owners (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(50),
    age INT
)

CREATE TABLE species (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50)
)

ALTER TABLE animals
DROP COLUMN species; 
SELECT * FROM animals;

ALTER TABLE animals
ADD COLUMN species_id int,
ADD COLUMN owner_id int;
SELECT * FROM animals

ALTER TABLE animals
ADD FOREIGN KEY(species_id)
REFERENCES species(id),
ADD FOREIGN KEY(owner_id)
REFERENCES owners(id);

CREATE TABLE vets (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    age INT,
    date_of_graduation DATE
);


CREATE TABLE specializations (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    species_id INT REFERENCES species(id),
    vet_id INT REFERENCES vets(id)
);

CREATE TABLE visits (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    animal_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    date DATE
);


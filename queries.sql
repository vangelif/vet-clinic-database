/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name like '%mon';
SElECT * from animals WHERE date_of_birth between '2016-01-01' and '2019-12-31';
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Pikachu', 'Agumon'); 
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.50;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg BETWEEN 10.40 and 17.30;

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species is NULL;
SELECT * FROM animals;
COMMIT;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals
ROLLBACK;
SELECT * FROM animals;
BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2021-01-01';
SELECT * FROM animals;
SAVEPOINT sp1;
UPDATE animals
SET weight_kg = weight_kg * (-1);
SELECT * FROM animals;
ROLLBACK TO sp1;
SELECT * FROM animals;
UPDATE animals
SET weight_kg = weight_kg * (-1)
WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;

SELECT count(*) FROM animals;
SELECT count(*) FROM animals WHERE escape_attempts = 0;
SELECT avg(weight_kg) from animals;
SELECT * FROM animals WHERE neutered = true ORDER BY escape_attempts DESC LIMIT 1;
SELECT * FROM animals WHERE neutered = false ORDER BY escape_attempts DESC LIMIT 1;
SELECT MAX(weight_kg) FROM animals WHERE species = 'pokemon';
SELECT MIN(weight_kg) FROM animals WHERE species = 'pokemon';
SELECT MAX(weight_kg) FROM animals WHERE species = 'digimon';
SELECT MIN(weight_kg) FROM animals WHERE species = 'digimon';
SELECT AVG(escape_attempts) FROM animals WHERE species = 'pokemon' and date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';
SELECT AVG(escape_attempts) FROM animals WHERE species = 'digimon' and date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';

SELECT * FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody Pond';
SELECT * FROM animals JOIN species ON animals.species_id = species.id WHERE species_id = 1;
SELECT owners.full_name, animals.name FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;
SELECT species.name, count(animals.species_id) FROM animals JOIN species ON species.id = animals.species_id GROUP BY species.name;
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id JOIN species ON species.id = animals.species_id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
SELECT animals.name FROM animals JOIN owners ON owners.id = animals.owner_id and owners.full_name = 'Dean Winchester' WHERE animals.escape_attempts = 0;
SELECT owners.full_name FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY count(*) DESC LIMIT 1;
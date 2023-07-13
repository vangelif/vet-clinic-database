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

-- Who was the last animal seen by William Tatcher?
SELECT animals.name 
FROM animals JOIN visits 
ON animals.id = visits.animal_id 
JOIN vets ON visits.vet_id = vets.id 
WHERE vets.name = 'William Tatcher' 
ORDER BY visits.date DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT count(*)
FROM animals JOIN visits
ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.

SELECT vets.name, species.name
FROM vets LEFT JOIN specializations
ON vets.id = specializations.vet_id
LEFT JOIN species
ON species.id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT animals.name
FROM animals JOIN visits
ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
AND visits.date BETWEEN '2020-04-01' and '2020-08-30';

-- What animal has the most visits to vets?

SELECT animals.name
FROM animals JOIN visits
ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
GROUP BY animals.name
ORDER BY count(*) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?

SELECT animals.name, visits.date
FROM animals JOIN visits
ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY animals.name, visits.date ORDER BY count(*) DESC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, vets.name, vets.age, vets.date_of_graduation, species.name, visits.date
FROM animals, species, vets, visits
WHERE animals.id = visits.animal_id
AND vets.id = visits.vet_id
AND animals.species_id = species.id
ORDER BY visits.date DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT count(*) FROM visits
JOIN vets ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id
LEFT JOIN specializations
ON specializations.species_id = animals.species_id
AND specializations.vet_id = vets.id
WHERE specializations.species_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT max(species.name) FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN species ON animals.species_id = species.id
WHERE visits.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
ORDER BY count(*) DESC LIMIT 1;
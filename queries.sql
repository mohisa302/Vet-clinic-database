/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth between '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT escape_attempts, name FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animals
SET species = 'unspecified';  
ROLLBACK;

BEGIN;
  UPDATE animals
  SET species = 'digimon'
  WHERE name LIKE '%mon';
  UPDATE animals
  SET species = 'pokemon'
  WHERE species IS NULL;  
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals
  WHERE date_of_birth > '1-1-2022';
SAVEPOINT Po1;
UPDATE animals  
  SET weight_kg = weight_kg * -1;
ROLLBACK TO Po1;  
UPDATE animals
  SET weight_kg = weight_kg * -1
  WHERE weight_kg < 0;
COMMIT;  

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals
  WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT MAX(escape_attempts), neutered
  FROM animals
  GROUP BY neutered;

SELECT MAX(weight_kg), MIN(weight_kg), species
  FROM animals
  GROUP BY species;

SELECT AVG(escape_attempts), species
  FROM animals
  WHERE date_of_birth between '1990-01-01' AND '2000-12-31'
  GROUP BY species;

SELECT animals.name, owners.full_name
FROM animals 
INNER JOIN owners
ON owner_id = owners.id 
WHERE owners.id = 4;

SELECT animals.name, animals.date_of_birth, animals.weight_kg, animals.neutered, animals.escape_attempts, species.name
  FROM animals 
  INNER JOIN species
  ON species_id = species.id 
  WHERE species.id = 1;

SELECT owners.full_name, animals.name 
  FROM owners
  LEFT JOIN animals 
  ON owner_id = owners.id;

SELECT COUNT(*),  species.name 
 FROM animals
 JOIN species ON species_id = species.id
 GROUP BY species.name;

SELECT animals.name, species.name, owners.full_name FROM animals
JOIN species ON species_id = species.id
JOIN owners ON owner_id = owners.id 
WHERE owner_id = 2 AND species_id = 2;

SELECT animals.name, owners.full_name, animals.escape_attempts FROM animals
JOIN owners ON owner_id = owners.id 
WHERE owner_id = 5 AND escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.name) FROM animals
FROM animals
JOIN owners ON owner_id = owners.id 
GROUP BY owners.full_name;
ORDER BY COUNT(animals.name) DESC
LIMIT 1;

--Who was the last animal seen by William Tatcher?
SELECT animals.name AS animal_name, MAX(visits.date_of_visit) AS latest_date
FROM animals
JOIN visits ON animals.id = visits.animals_id
GROUP BY animals.name
ORDER BY latest_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT count(animals.name), visits.vets_id AS vet_id
FROM animals
JOIN visits ON animals.id = visits.animals_id
WHERE visits.vets_id = 3
GROUP BY vet_id;

--List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations ON specializations.vets_id = vets.id
LEFT JOIN species ON specializations.species_id = species.id
GROUP BY  vets.name, species.name;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, visits.date_of_visit AS visit_date, vets.name 
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON visits.vets_id = vets.id
WHERE visits.date_of_visit between '2020-4-1' AND '2020-8-30' AND visits.vets_id = 3
GROUP BY animals.name, visit_date, vets.name;

-- What animal has the most visits to vets?
SELECT animals.name AS animal_name, COUNT(visits.date_of_visit) AS num_visit
FROM animals
JOIN visits ON animals.id = visits.animals_id
GROUP BY animals.name
ORDER BY num_visit DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT vets.name AS vet_name, animals.name AS animal_name, MIN(visits.date_of_visit) AS first_visit
FROM visits
JOIN vets ON vets.id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id
WHERE vets.name = 'Maisy Smith'
GROUP BY vets.name, animal_name
ORDER BY first_visit
LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT visits.date_of_visit AS date_visit, vets.name AS vet_name, vets.age, animals.name AS animal_name, animals.weight_kg
FROM visits
JOIN vets ON vets.id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id
GROUP BY date_visit, vet_name, vets.age, animals.name, animals.weight_kg
ORDER BY date_visit DESC
LIMIT 1;

--How many visits were with a vet that did not specialize in that animal's species?

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
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

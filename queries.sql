/* Populate database with sample data. */

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '01-01-2016' AND '01-01-2019';

SELECT name FROM animals WHERE neutered =true  AND  escape_attempts <3;

SELECT date_of_birth
FROM animals WHERE name ='Agumon' OR name ='Pikachu';

SELECT name, escape_attempts from animals WHERE weight_kg >10.5

SELECT * FROM animals WHERE neutered =true;

SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* -- Transaction update the animals table -- */
BEGIN;
UPDATE animals SET species ='unspecified';  --made update on species column
SELECT species FROM animals; --verify the change was made
ROLLBACK;
SELECT species FROM animals; --verify roll back the change

/*-- Update animals table and Commit --*/ 

BEGIN;
UPDATE animals SET species ='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species ='pokemon' WHERE species IS NULL;
SELECT name,species from animals; --verify update
COMMIT;
SELECT name,species from animals; --verify update made after commit

/*-- Delete all animals data inside transaction and undo deletion --*/
BEGIN;
DELETE FROM animals;
SELECT COUNT(*) FROM animals; --check the count of animals 
SELECT * FROM animals; -- check after deletion
ROLLBACK;

/*-- Check the count of animals after Rollback --*/
SELECT COUNT(*) FROM animals; 

/*-- Delete all animals data inside transaction and undo deletion end --*/

/*-- Delete all animals born after jan 1st,2022 --*/

BEGIN;
DELETE FROM animals WHERE date_of_birth >='01/01/2022';
SELECT name, date_of_birth FROM animals;

--Create savepoint 
SAVEPOINT sp1;
UPDATE animals SET weight_kg =weight_kg * -1;
SELECT name, weight_kg FROM animals;
 ROLLBACK TO sp1;
 SELECT name, weight_kg FROM animals; -- Check the result after rollback

 UPDATE animals SET weight_kg =weight_kg * -1
   WHERE weight_kg < 0;
 SELECT name, weight_kg 
   FROM animals;  --Check the change made
 COMMIT;

/*-- Aggreigate --*/
 /*-- How many animals are there --*/
 
 SELECT COUNT(*) from animals;
 
 /*-- Count animals never tried to escape --*/
 
  SELECT COUNT(*) from animals WHERE escape_attempts =0;
  
  /*-- Calculate the average weight of all animals --*/
  
  SELECT AVG(weight_kg) from animals;
  
 /*-- Find the max escape attemps ,neutered or not neutered animals --*/
 
 SELECT neutered, 
  MAX(escape_attempts) AS max_escap_attempts
   FROM animals 
   GROUP BY neutered;
   
/*-- Find the max weight of animals --*/
 
-- SELECT MAX(weight_kg) FROM animals;

/*-- Find the min weight of animals --*/

-- SELECT MIN(weight_kg) FROM animals;

SELECT species, 
MAX(weight_kg) AS "Max Weight", 
MIN(weight_kg) AS "Min Weight" 
FROM animals 
GROUP BY species;

/*-- Calculate the average escape attemps of animals born between 1990 and 2000 --*/

-- SELECT AVG(escape_attempts) FROM animals WHERE
-- date_of_birth BETWEEN '01/01/1990' AND '01/01/2000'

SELECT species, 
AVG(escape_attempts)
FROM animals 
Where date_of_birth BETWEEN '01/01/1990' AND '01/01/2000'
GROUP BY species;

/*-- Verify animals belong to Melody Pond --*/

-- SELECT animals.name AS "Animals Name" FROM animals 
-- INNER JOIN owners 
-- ON animals.owner_id = owners.id
-- WHERE owners.full_name = 'Melody Pond';

SELECT full_name, name  FROM  animals a JOIN owners o
  ON  a.owner_id = o.id WHERE o.full_name ='Melody Pond';
  
/*-- List of all animals that are pokemon --*/

SELECT s.name as species,a.name FROM animals a 
 JOIN species s ON a.species_id = s.id WHERE
 s.name = ' Pokemon';
 
/*-- List all owners and their animals, and include those that don't own any animal --*/

SELECT o.full_name as owner_full_name, 
 a.name as animal_name FROM animals a JOIN owners o
  ON a.owner_id =o.id WHERE a.owner_id =o.id;
  
/**-- How many animals are there per species --*/

SELECT COUNT(*) as num_of_animals, s.name 
  FROM animals a JOIN species s ON a.species_id = s.id
     GROUP BY s.name;
	 
/*-- List all Digimon owned by Jennifer Orwell --*/

SELECT a.name AS "Vet Name", s.name AS "Species Name", o.full_name AS "Owners Full_Name" 
FROM animals a
JOIN species s ON a.species_id =s.id 
JOIN owners o
ON a.owner_id= o.id 
WHERE o.full_name ='Jennifer Orwell'
AND s.name='  Digimon';

/*-- List all animals owned by Dean Winchester that haven't tried to escape --*/

SELECT animals.name AS "Animals Name" FROM animals 
INNER JOIN owners 
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester'
AND animals.escape_attempts = 0;

/*-- -- Who owns the most animals --*/

SELECT owners.full_name AS "Owners Name",
COUNT(animals.id) AS "Animals Count" 
FROM animals 
INNER JOIN owners 
ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY COUNT(animals.id) DESC LIMIT 1;

/*-- Many-to-many relationships and write more complex queries --*/

/*-- Who was the last animal seen by William Tatcher? --*/

SELECT a.name As "Animal Name", vet.name As "Vet Name", visit.date_of_visit 
FROM animals a JOIN visits visit on a.id =visit.animal_id
JOIN vets vet ON vet.id =visit.vet_id WHERE vet.name ='William Tatcher'
ORDER BY date_of_visit DESC LIMIT 1;

/**-- How many different animals did Stephanie Mendez see? --*/

SELECT vet.name AS "Vet Name", COUNT(DISTINCT animal_id)FROM
vets vet JOIN visits visit on vet.id =visit.vet_id 
WHERE vet.name ='Stephanie Mendez' GROUP BY vet.name;

/*-- List all vets and their specialties, including vets with no specialties --*/

SELECT vet.name AS "Vet Name" ,s.name As "Specialization" FROM vets vet LEFT JOIN 
specializations spec ON vet.id =spec.vet_id LEFT JOIN species s 
ON  s.id =spec.species_id;

/*-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020--*/

SELECT a.name AS "Animal Name", vet.name AS "Vet Name" ,visit.date_of_visit
FROM visits visit JOIN  animals a ON a.id =visit.animal_id 
JOIN vets vet ON vet.id =visit.vet_id
WHERE vet.name ='Stephanie Mendez'AND visit.date_of_visit 
BETWEEN '2020-04-01' AND '2020-08-30';

/**-- What animal has the most visits to vets? --*/

SELECT animals.name, COUNT(*) AS "Visits" 
FROM visits JOIN animals ON visits.animal_id = animals.id 
GROUP BY animals.name ORDER BY "Visits" DESC;

/*-- Who was Maisy Smith's first visit --*/

SELECT animal_id AS "Animal ID", animals.name AS "Animal Name", visits.date_of_visit AS "Date of Visist", vets.name 
FROM visits JOIN animals ON visits.animal_id = animals.id 
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith' 
ORDER by  "Date of Visist" ASC LIMIT 1;
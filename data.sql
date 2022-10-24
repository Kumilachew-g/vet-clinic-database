/* Populate database with sample data. */

INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Agumon', '03-02-2020', 10.23, 0,true);

INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Gabumon', '11-15-2018', 8, 2,true);

INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Pikachu', '7-01-2021', 15.04, 1,false);

INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Davimon', '12-05-2017', 11, 2,true);

/*-- Insert new data--*/

INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Charmander', '08-02-2020', -11, 0,false);


INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Plantmon', '11-15-2021', -5.7, 2,true);

INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Squirtle', '02-04-1993', -12.13, 3, false);


INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Angemon', '12-06-2005', -45, 1, true);

INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Boarmon', '07-06-2005', 20.4, 7, true);

INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Blossom', '10-10-1998', 17, 3, true);

INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Ditto', '05-14-2022', 22, 4, true);

/*-- Query multiple tables --*/

/*-- Insert the following data into the owners table --*/

INSERT INTO owners (full_name, age) VALUES ('Sam Smith',34),('Jennifer Orwell',19),
('Bob', 45),('Melody Pond',77),('Dean Winchester',14),('Jodie Whittaker',38);

/*-- Insert the following data into the species table --*/

INSERT INTO species (name) VALUES (' Pokemon'),('  Digimon');

/*-- Modify your inserted animals so it includes the species_id value --*/

 UPDATE animals SET species_id =2 WHERE name LIKE '%mon';
 
/*-- All other animals are Pokemon --*/

UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';

/*-- Modify your inserted animals to include owner information (owner_id) --*/

/*-- Sam Smith own Agumon --*/

UPDATE animals SET owner_id = 1 WHERE name = 'Agumon'; 

/*-- Jennifer Orwell owns Gabumon and Pikachu --*/

UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';

/*-- Bob owns Devimon and Plantmon --*/

UPDATE animals SET owner_id = 3 WHERE name = 'Devimon'OR name = 'Plantmon';

/*-- Melody Pond owns Charmander, Squirtle, and Blossom --*/

UPDATE animals SET owner_id = 4 WHERE name = 'Charmander' 
OR name = 'Squirtle' OR name = 'Blossom';

/*-- Dean Winchester owns Angemon and Boarmon --*/

UPDATE animals SET owner_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';

/*-- End of query multiple tables --*/
 
/*-- Many-to-many relationships --*/
 
/**- Insert the following data into vets table --*/

INSERT INTO vets (name,age,date_of_graduation)
    VALUES
	      ('William Tatcher',45,'04-23-2000'),
	      ('Maisy Smith',26,'01-17-2019'),
	      ('Stephanie Mendez',64,'04-05-1981'),
		  ('Jack Harkness',38,'08-06-2008');
 
/*-- Insert the following data for specialties --*/

INSERT INTO specializations(vet_id,species_id)
VALUES (1,1),(3,1),(3,2),(4,2);

/*-- Insert the following data for visits --*/

INSERT INTO visits (animal_id,vet_id,date_of_visit) 
VALUES
	((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-5-24'),
	((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-7-22'),
	((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-2-2'),
	((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-1-5'),
	((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-3-8'),
	((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-3-14'),
	((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021-3-4'),
	((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-2-24'),
	((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21'),
	((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-8-10'),
	((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-4-7'),
	((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2019-9-29'),
	((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-10-3'),
	((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-11-4'),
	((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-1-24'),
	((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-5-15'),
	((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-2-27'),
	((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-8-3'),
	((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-8-24'),
	((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-1-11');

-- Database Performance Audit

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
   SELECT * FROM (SELECT id FROM animals) animal_ids, 
  (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

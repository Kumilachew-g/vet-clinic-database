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
 


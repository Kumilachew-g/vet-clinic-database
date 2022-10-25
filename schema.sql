/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
 id INT GENERATED BY DEFAULT AS IDENTITY (START WITH 100 INCREMENT BY 1),
 name VARCHAR(40),
	date_of_birth DATE,
	weight_kg Decimal,
	escape_attempts INT,
	neutered BOOLEAN
);

ALTER TABLE animals ADD species VARCHAR(45);

/*-- Create owners table --*/

CREATE TABLE owners (
id INT GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR(255) NOT NULL,
	age INT,
	CONSTRAINT pk_owners PRIMARY KEY(id)
);

/*-- Create species table --*/

CREATE TABLE species(
 id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(40), 
	 CONSTRAINT pk_species PRIMARY KEY(id)
);

/*-- Set id autoincrementedPRIMARY KEY --*/

ALTER  TABLE animals ALTER COLUMN id SET GENERATED BY DEFAULT;

/* -- Remove column species --*/

ALTER TABLE animals DROP COLUMN species;

/* -- Add column species_id which is a foreign key referencing species table --*/

ALTER TABLE animals ADD species_id INT, 
  ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id);

/*-- Add column owner_id which is a foreign key referencing the owners table --*/

ALTER TABLE animals ADD owner_id INT, 
  ADD CONSTRAINT fk_owners FOREIGN KEY(owner_id) REFERENCES owners(id);
  
/*-- Add "join table" for visits --*/
/**-- Create vets table --*/

CREATE TABLE vets (
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(255),
	age INT,
	date_of_graduation DATE
);
  

/*-- Create a "join table" called specializations to handle this relationship --*/

CREATE TABLE specializations (
     vet_id INT, species_id INT,
     CONSTRAINT pk_specializations PRIMARY KEY(vet_id,species_id),
     CONSTRAINT fk_vets FOREIGN KEY(vet_id) REFERENCES vets(id),
     CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id)
);

/*-- Create a "join table" called visits to handle this relationship --*/

CREATE TABLE visits (
    animal_id INT, vet_id INT,
    date_of_visit DATE,
    CONSTRAINT fk_animals FOREIGN KEY(animal_id) REFERENCES animals(id),
    CONSTRAINT fk_vets FOREIGN KEY(vet_id) REFERENCES vets(id)
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Create  index to minimaze performance issue 
	CREATE INDEX  visit_animal_id_index  ON visits(animal_id);
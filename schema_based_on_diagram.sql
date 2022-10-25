-- Create database from the diagram
CREATE DATABASE medical_clinic;

CREATE TABLE patients (
	ID INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	NAME VARCHAR(255),
	date_of_birth date
);
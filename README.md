# Sistema de Reserva de Áreas Comunes - Condominio

Este proyecto consiste en el desarrollo de un sistema web para la gestión y reserva de espacios comunes dentro de un condominio, solucionando problemas de duplicación de horarios.

## Integrantes del Equipo:
* Wendy Carol Hernández Pérez - Product Owner
* Yeudiel Sebastian Cabrera Licea - Scrum Master
* Valeria Zapata Cruz - Desarrolladora
CREATE DATABASE condominio_db;
USE condominio_db;

CREATE TABLE roles (id INT PRIMARY KEY, nombre VARCHAR(50));
CREATE TABLE usuarios (id INT PRIMARY KEY, user VARCHAR(50), pass VARCHAR(100), rol_id INT);
CREATE TABLE residentes (id INT PRIMARY KEY, nombre VARCHAR(100), departamento VARCHAR(20));

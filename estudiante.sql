CREATE DATABASE estudiante CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE estudiante;
drop table asesorias;
create table asesorias(
	idDocente int(5) not null,
    idMaterias bigint(5) not null,
    Nombre VARCHAR(45) NOT NULL,
    Nombre_materia VARCHAR(45) NOT NULL,
    Estado boolean not null default true,
    Hora int (5) not null,
    FOREIGN KEY (idDocente) REFERENCES Docentes(idDocente), 
    FOREIGN KEY (idMateria) REFERENCES Materias(idMaterias)
);
insert into asesorias (idDocente,Nombre,Nombre_materia,Hora)
values();

describe Docentes;
drop table Docentes;
 create table  Docentes(
	idDocente int auto_increment primary key,
	Matricula VARCHAR(15) NOT NULL,
	Nombre VARCHAR(45) NOT NULL,
	Apellido VARCHAR(45) not NULL,
	Contraseña varbinary(45) NOT NULL,
	CorreoElectronico VARCHAR(45) NOT NULL,
    estatus boolean not null default true,
    admission boolean not null default false
);
ALTER TABLE docentes ADD estatus BOOLEAN NOT NULL DEFAULT TRUE;
Alter table docentes add admision boolean not null default false;

insert into Docentes (Matricula,Nombre,Apellido,Contraseña,CorreoElectronico)
values ("20233tn070","Pilar","Higareda","1234","20233tn070@utez.edu.mx");
insert into Docentes (Matricula,Nombre,Apellido,Contraseña,CorreoElectronico)
values ("20233tn080","Fernando","Garrido","1234","20233tn080@utez.edu.mx");



select * from docentes;

 insert into docentes (matricula,nombre,apellido,contraseña,correoelectronico) values ('20233tn070','Jafet','Bahena','pepe','holi');
 insert into docentes (matricula,nombre,apellido,contraseña,correoelectronico) values ('20233tn189','fer','Bahena','123','holi');

 create table Estudiantes (
  idEstudiante int auto_increment primary key,
  Matricula VARCHAR(15) NOT NULL,
  Nombre VARCHAR(45) NOT NULL,
  Apellido VARCHAR(45) NOT NULL,
  Grupo VARCHAR(4) NOT NULL,
  Cuatrimestre numeric(2) NOT NULL,
  Contraseña VARCHAR(45) NOT NULL,
  CorreoElectronico VARCHAR(45) NOT NULL
 );
 ALTER TABLE estudiantes ADD estatus BOOLEAN NOT NULL DEFAULT TRUE;

insert into Estudiantes (Matricula,Nombre,Apellido,Grupo,Cuatrimestre,Contraseña,CorreoElectronico)
values("20233tn070", "Pilar","Higareda","C",3,"1234","20233tn070@utez.edu.mx");
insert into Estudiantes (Matricula,Nombre,Apellido,Grupo,Cuatrimestre,Contraseña,CorreoElectronico)
values("20233tn080", "Katia","Hernandez","C",3,"1234","20233tn080@utez.edu.mx");
insert into Estudiantes (Matricula,Nombre,Apellido,Grupo,Cuatrimestre,Contraseña,CorreoElectronico)
values("20233tn60", "Daniel","Leon","C",3,"1234","20233tn60@utez.edu.mx");
insert into Estudiantes (Matricula,Nombre,Apellido,Grupo,Cuatrimestre,Contraseña,CorreoElectronico)
values("20233tn111", "Anguel","Aguilar","C",3,"1234","20233tn111@utez.edu.mx");


 DROP TABLE materias;
 select* from Estudiantes;
 
 drop table Materias;
 select * from Materias;
 CREATE TABLE Materias (
  idMateria bigint auto_increment primary key,
  Nombre_materia VARCHAR(45) NOT NULL,
  materia_estado boolean default 1
);
describe materias;
insert into Materias (Nombre_materia)values("Matematicas");
insert into Materias (Nombre_materia)values("Historia");
insert into Materias (Nombre_materia)values("Progracion");
insert into Materias (Nombre_materia)values("Geografia");

SELECT* FROM MATERIAS;
insert into MATERIAS (Nombre_materia)values("Historia");
insert into MATERIAS (Nombre_materia)values("Calculo");
insert into MATERIAS (Nombre_materia)values("Español");

CREATE TABLE materias_deshabilitadas (
  idMateria int primary key,
  Nombre_materia VARCHAR(45) NOT NULL,
  materia_estado boolean default 0
);

CREATE TABLE IF NOT EXISTS `estudiante`.`Asesorias` (
  idAsesoria int auto_increment primary key,
  Fecha_Asesoria DATE NOT NULL,
  Hora_inicio TIME NOT NULL,
  Hora_Fin TIME NOT NULL
);
CREATE TABLE IF NOT EXISTS `estudiante`.`Historial_asesorias` (
  id_Asesoria numeric (100) NOT NULL,
  id_Materia numeric (4) NOT NULL,
  id_Docente numeric(10) NOT NULL,
  id_Estudiante numeric (10) NOT NULL);
  
  CREATE TABLE IF NOT EXISTS Estudiante_deshabilitado (
    id INT PRIMARY KEY,
    Matricula VARCHAR(15) NOT NULL,
	Nombre VARCHAR(45) NOT NULL,
	Apellido VARCHAR(45) NOT NULL,
	Grupo VARCHAR(4) NOT NULL,
	Cuatrimestre numeric(2) NOT NULL,
	Contraseña VARCHAR(45) NOT NULL,
	CorreoElectronico VARCHAR(45) NOT NULL,
	Estatus boolean not null,
    fecha_deshabilitado TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from Estudiante_deshabilitado;

create table if not exists docente_deshabilitado(
	id int primary key,
    Matricula VARCHAR(15) NOT NULL,
	Nombre VARCHAR(45) NOT NULL,
	Apellido VARCHAR(45) not NULL,
	id_Materia INT(3) NULL,
	Contraseña VARCHAR(45) NOT NULL,
	CorreoElectronico VARCHAR(45) NOT NULL,
	Estatus boolean NOT NULL,
    fecha_deshabilitado TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from docente_deshabilitado;

create table admins(
	id_admin int auto_increment primary key,
    matricula varchar(30),
    contraseña varbinary (30)
);
select * from admins where contraseña = ? and matricula = ?;
select * from admins;
insert into admins (matricula,contraseña)values("20233tn191",1234);
CREATE TABLE IF NOT EXISTS `estudiante`.`Docentes_Materias` (
  idDocente INT NOT NULL,
  idMateria INT NOT NULL,
  PRIMARY KEY (idDocente, idMateria),
  FOREIGN KEY (idDocente) REFERENCES Docentes(idDocente),
  FOREIGN KEY (idMateria) REFERENCES Materias(idMaterias)
);

-- join para saber el nombre del profesor y que materia da
SELECT D.Nombre, D.Apellido, M.Nombre_materia
FROM Docentes D
JOIN Docentes_Materias DM ON D.idDocente = DM.idDocente
JOIN Materias M ON DM.idMateria = M.idMaterias
WHERE M.Nombre_materia = 'Nombre de la materia';
















-- By Qi Chen


-- Create Department Table with Id as primary key
CREATE TABLE Department (
    Id INT NOT NULL PRIMARY KEY,
    Name VARCHAR(30) NOT NULL
);

-- Create Student Table with foreign key references with Id as primary key
CREATE TABLE Student (
    Id INT NOT NULL PRIMARY KEY,
    Firstname VARCHAR(30) NOT NULL,
    Lastname VARCHAR(50) NOT NULL,
    Street VARCHAR(50) NOT NULL,
    StreetDetail VARCHAR(30),
    City VARCHAR(30) NOT NULL,
    State VARCHAR(30) NOT NULL,
    PostalCode CHAR(5) NOT NULL,
    MajorId INT,
    FOREIGN KEY (MajorId)
        REFERENCES Department (Id)
);

-- Create Couse Table with foreign key references and Id as primary key
CREATE TABLE Course (
    Id INT NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    DeptId INT,
    FOREIGN KEY (DeptId)
        REFERENCES Department (Id)
);

-- Create Faculty Table with id as Primary key
CREATE TABLE Faculty (
    Id INT NOT NULL PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DeptId INT,
    FOREIGN KEY (DeptId)
        REFERENCES Department (Id)
);

-- Create StudentCourse Table with foreign key references
CREATE TABLE StudentCourse (
    StudentId INT,
    CourseId INT,
    Progress INT NOT NULL,
    StartDate DATE NOT NULL,
    CONSTRAINT Pk_Scourse PRIMARY KEY (StudentId , CourseId),
    FOREIGN KEY (StudentId)
        REFERENCES Student (Id),
    FOREIGN KEY (CourseId)
        REFERENCES Course (Id)
);

-- Create FacultyCourse Table with foreign key references
CREATE TABLE FacultyCourse (
    FacultyId INT,
    CourseId INT,
    CONSTRAINT Pk_Fcourse PRIMARY KEY (FacultyId , CourseId),
    FOREIGN KEY (FacultyId)
        REFERENCES Faculty (Id),
    FOREIGN KEY (CourseId)
        REFERENCES Course (Id)
);










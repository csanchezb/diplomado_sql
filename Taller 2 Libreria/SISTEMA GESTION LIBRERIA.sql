----  EJERCICIO PR�CTICO : SISTEMA DE GESTI�N DE UNA LIBRERIA

--- validar cambios en el repositorio

CREATE DATABASE LIBRERIA
GO

USE LIBRERIA
GO

CREATE SCHEMA CATALOGO
GO

CREATE SCHEMA VENTAS
GO

CREATE TABLE CATALOGO.AUTORES (
	AutorID INT IDENTITY(1,1) PRIMARY KEY,
	Nombre VARCHAR(60),
	Apellido VARCHAR(100)
)
GO

CREATE TABLE CATALOGO.CATEGORIAS (
	CategoriaID INT IDENTITY(1,1),
	Nombre VARCHAR(50) UNIQUE,
	CONSTRAINT PK_CATEGORIA_ID PRIMARY KEY ([CategoriaID]),
)
GO

CREATE TABLE CATALOGO.LIBROS (
	LibroID INT IDENTITY(1,1) PRIMARY KEY,
	Titulo VARCHAR(100),
	AutorID INT, --FK por definir
	CategoriaID INT, --FK por definir
	Precio MONEY,
	CONSTRAINT FK_AUTORID_CON_AUTORES_AUTORID FOREIGN KEY(AutorID)
	REFERENCES CATALOGO.AUTORES(AutorID),    ---- c�mo especif�co que esta relaci�n es uno a uno????
	--CONSTRAINT FK_CATEGORIAID_CON_CATEORIAS_CATEGORIAID FOREIGN KEY (CategoriaID)
	--REFERENCES CATALOGO.CATEGORIAS(CategoriaID)
)
GO


CREATE TABLE VENTAS.CLIENTES (
	ClienteID INT IDENTITY(1,1) PRIMARY KEY,
	Nombre VARCHAR(60),
	Apellido VARCHAR(100),
	Correo NVARCHAR(100) UNIQUE
)
GO


CREATE TABLE VENTAS.VENTAS (
	VentasID INT IDENTITY(1,1) PRIMARY KEY,
	ClienteID INT, --FK POR DEFINIR
	FechaVenta DATE,
	CONSTRAINT FK_CLIENTESID_CON_CLIENTES_CLIENTESID FOREIGN KEY (ClienteID)
	REFERENCES VENTAS.CLIENTES(ClienteID)
)
GO

CREATE TABLE VENTAS.DETALLEVENTAS (
	DetalleID INT IDENTITY(1,1) PRIMARY KEY,
	VentaID INT, --FK POR DEFINIR
	LibroID INT,--FK POR DEFINIR
	Cantidad INT,
	PrecioVenta MONEY,
	CONSTRAINT FK_VENTAID_CON_VENTAS_VENTASID FOREIGN KEY (VentaID)
	REFERENCES VENTAS.VENTAS(VentasID),
	--CONSTRAINT FK_LIBROID_CON_LIBROS_LIBROID FOREIGN KEY (LibroID)
	--REFERENCES CATALOGO.LIBROS(LibroID)
)
GO

---- A�ADIR RESTRICCI�N

ALTER TABLE VENTAS.DETALLEVENTAS
ADD CONSTRAINT FK_LIBROID_CON_LIBROS_LIBROID FOREIGN KEY (LibroID)
REFERENCES CATALOGO.LIBROS(LibroID)

ALTER TABLE CATALOGO.LIBROS
ADD CONSTRAINT FK_CATEGORIAID_CON_CATEORIAS_CATEGORIAID FOREIGN KEY (CategoriaID)
REFERENCES CATALOGO.CATEGORIAS(CategoriaID)


---- MODIFICAR NOMBRE COLUMNAS
EXEC sp_rename 'CATALOGO.AUTORES.Autor', 'Nombre_Autor', 'COLUMN';
SELECT * FROM CATALOGO.AUTORES

EXEC sp_rename 'VENTAS.CLIENTES.Nombre', 'Nombre_Cliente', 'COLUMN';
SELECT * FROM VENTAS.CLIENTES

---- A�ADIR COLUMNAS

ALTER TABLE CATALOGO.AUTORES
ADD CodigoPostal NVARCHAR(50)

SELECT * FROM CATALOGO.AUTORES

ALTER TABLE VENTAS.CLIENTES
ADD DireccionCliente NVARCHAR(100)

SELECT * FROM VENTAS.CLIENTES

---- A�ADIR AL MENOS 10 REGISTROS A LAS TABLAS

INSERT INTO CATALOGO.AUTORES (Nombre_Autor, Apellido, CodigoPostal)
VALUES	('Juan', 'Gonz�lez', '12345'),
		('Mar�a', 'L�pez', '23456'),
		('Pedro', 'Mart�nez', '34567'),
		('Ana', 'S�nchez', '45678'),
		('Carlos', 'Rodr�guez', '56789'),
		('Laura', 'P�rez', '67890'),
		('Miguel', 'Hern�ndez', '78901'),
		('Sof�a', 'G�mez', '89012'),
		('Diego', 'D�az', '90123'),
		('Elena', 'Ruiz', '01234')
		GO

INSERT INTO CAT�LOGO CATEGORIAS

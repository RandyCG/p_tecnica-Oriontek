---CREACION DE BD
CREATE DATABASE PRUEBAORIONTEK;

USE PRUEBAORIONTEK;

---TABLE [DBO].[CLIENTES]
GO
CREATE TABLE [DBO].[CLIENTES](
	[ID] [INT] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[P_DOCUMENTO] [NVARCHAR](11) NOT NULL UNIQUE,
	[NOMBRE] [NVARCHAR](20) NOT NULL,
	[APELLIDO] [NVARCHAR](20) NOT NULL,
	[FECHA_INGRESO] [DATETIME] NULL,
	[SEXO] [NVARCHAR](1) NOT NULL);

	
---TABLE [DBO].[DIRECCIONES]

GO
CREATE TABLE [DBO].[DIRECCIONES](
	[ID] [INT] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[DIRECCION] [NVARCHAR](60) NOT NULL,
	[PAIS] [NVARCHAR](50) NOT NULL,
	[CIUDAD] [NVARCHAR](50) NOT NULL,
	[CODIGO_POSTAL] [NVARCHAR](10) NOT NULL,
	[CLIENTE] [INT] NOT NULL);
	
---TABLE [DBO].[FAVORITOS]

GO
CREATE TABLE [DBO].[FAVORITOS](
	[ID] [INT] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CLIENTE] [INT] NOT NULL,
	[PRODUCTO] [INT] NOT NULL,
);

---TABLE [DBO].[PRODUCTOS]

GO
CREATE TABLE [DBO].[PRODUCTOS](
	[ID] [INT] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[PRODUCTO] [NVARCHAR](20) NOT NULL UNIQUE,
	[VALOR] [DECIMAL](10, 2) NOT NULL,
);


GO
ALTER TABLE [DBO].[DIRECCIONES]  WITH CHECK ADD  CONSTRAINT [FK_DIRECCIONES_CLIENTES] FOREIGN KEY([CLIENTE])
REFERENCES [DBO].[CLIENTES] ([ID])
GO
ALTER TABLE [DBO].[DIRECCIONES] CHECK CONSTRAINT [FK_DIRECCIONES_CLIENTES]
GO
ALTER TABLE [DBO].[FAVORITOS]  WITH CHECK ADD  CONSTRAINT [FK_FAVORITOS_CLIENTES] FOREIGN KEY([CLIENTE])
REFERENCES [DBO].[CLIENTES] ([ID])
GO
ALTER TABLE [DBO].[FAVORITOS] CHECK CONSTRAINT [FK_FAVORITOS_CLIENTES]
GO
ALTER TABLE [DBO].[FAVORITOS]  WITH CHECK ADD  CONSTRAINT [FK_FAVORITOS_PRODUCTOS] FOREIGN KEY([PRODUCTO])
REFERENCES [DBO].[PRODUCTOS] ([ID])
GO
ALTER TABLE [DBO].[FAVORITOS] CHECK CONSTRAINT [FK_FAVORITOS_PRODUCTOS]
GO

--INDEX
CREATE INDEX DOCUMENTO_CLIENTE
ON CLIENTES (P_DOCUMENTO);
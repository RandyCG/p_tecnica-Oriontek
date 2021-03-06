--PROCEDIMIENTO PARA CREACION DE CLIENTE, SE INSERTAN LOS PARAMETROS AL EJECUTAR EL PROCEDIMIENTO--
/* consultas
SELECT * FROM CLIENTES;

SELECT * FROM DIRECCIONES;
*/

CREATE PROCEDURE DBO.SP_CREAR_CLIENTES  
	@P_DOCUMENTO NVARCHAR(10) =NULL,
	@NOMBRE NVARCHAR(20) =NULL,
	@APELLIDO NVARCHAR(20) =NULL,
	@FECHA_INGRESO DATETIME =NULL,
	@SEXO NVARCHAR(1) = NULL,
	@DIRECCION NVARCHAR(60),
	@PAIS NVARCHAR(50),
	@CIUDAD NVARCHAR(50),
	@CODIGO_POSTAL NVARCHAR(10)
AS 
BEGIN TRY
    BEGIN TRANSACTION
	 DECLARE @ID_CLIENTE INT;
	 SET NOCOUNT ON 

	 INSERT INTO DBO.CLIENTES
		  (                    
			P_DOCUMENTO            ,
			NOMBRE                 ,
			APELLIDO			   ,
			FECHA_INGRESO          ,
			SEXO
		  ) 
	 VALUES 
		  ( 
			@P_DOCUMENTO,
			@NOMBRE,
			@APELLIDO,
			@FECHA_INGRESO,
			@SEXO
		  ) 
		  
SET @ID_CLIENTE=SCOPE_IDENTITY()
INSERT INTO DIRECCIONES (DIRECCION,PAIS,CIUDAD,CODIGO_POSTAL,CLIENTE)
VALUES (@DIRECCION,@PAIS,@CIUDAD,@CODIGO_POSTAL,@ID_CLIENTE);

    COMMIT TRAN -- Transaction Success!
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRAN --RollBack in case of Error

    -- error messages as follows:
    DECLARE @ErrorMessage NVARCHAR(4000);  
    DECLARE @ErrorSeverity INT;  
    DECLARE @ErrorState INT;  

    SELECT   
       @ErrorMessage = ERROR_MESSAGE(),  
       @ErrorSeverity = ERROR_SEVERITY(),  
       @ErrorState = ERROR_STATE();  

    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);  
    -- error messages
END CATCH




---TEST	PROCEDIMIENTO CREAR CLIENTE
EXEC DBO.SP_CREAR_CLIENTES   
	@P_DOCUMENTO    = '0011111111'               ,
	@NOMBRE   = 'PRU1'      ,
	@APELLIDO         = 'PRUEBA1'          ,
	@FECHA_INGRESO = '2022-04-06' ,
	@SEXO = 'M',
	@DIRECCION='CHARLES',
	@PAIS ='REP. DOM.',
	@CIUDAD ='SANTO DOMINGO',
	@CODIGO_POSTAL=15801


	
		
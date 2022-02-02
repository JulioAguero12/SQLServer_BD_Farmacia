CREATE OR ALTER PROCEDURE dbo.AddFarmacia
				@farmnomb   varchar(50),
                   @farmdire   varchar(100),
				   @farmtele   varchar(9)
AS
  BEGIN TRY
    INSERT INTO dbo.Farmacia (Farmacia_nombre,Farmacia_direccion,Farmacia_telefono) 
         VALUES(@farmnomb,@farmdire,@farmtele)  
		 print('Farmacia Insertado Correctamente')
  END TRY
  BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES
  (SUSER_SNAME(),
   ERROR_NUMBER(),
   ERROR_STATE(),
   ERROR_SEVERITY(),
   ERROR_LINE(),
   ERROR_PROCEDURE(),
   ERROR_MESSAGE(),
   GETDATE());
   DECLARE @Message varchar(MAX) = ERROR_MESSAGE(),
        @Severity int = ERROR_SEVERITY(),
        @State smallint = ERROR_STATE()
 
   RAISERROR (@Message, @Severity, @State)
  END CATCH
GO
------------------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.DeleteFarmacia
			@farmssn   int
AS
BEGIN
  if @farmssn = (SELECT Farmacia_ssn from Farmacia WHERE Farmacia_ssn = @farmssn) 
	begin
		DELETE FROM dbo.Farmacia where Farmacia_ssn = @farmssn
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Farmacia Eliminado Correctamente!', 16, 1)
	end
  else 
	begin
		Raiserror('Farmacia No Eliminado!', 16,1)
	end
  end 
GO
------------------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.ModifyFarmacia
				@farmssn   int,
                   @farmnomb   varchar(50),
                   @farmdire   varchar(100),
				   @farmtele   varchar(9)
AS
BEGIN
  if @farmssn = (SELECT Farmacia_ssn from Farmacia WHERE Farmacia_ssn = @farmssn) 
	begin
		UPDATE Farmacia 
            SET Farmacia_nombre = @farmnomb, 
            Farmacia_direccion = @farmdire,
            Farmacia_telefono = @farmtele
            WHERE Farmacia_ssn = @farmssn; 
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Farmacia Modificado Correctamente!', 16, 1)
	end
  else 
	begin
		Raiserror('No Se Pudo Modificar!', 16,1)
	end
  end 
GO
 


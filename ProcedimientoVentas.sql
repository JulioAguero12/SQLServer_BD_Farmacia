CREATE OR ALTER PROCEDURE dbo.AddVentas
		@farmaciaID int,   
		@pacienteID int
AS
  BEGIN TRY
    INSERT INTO venta(Farmacia_ssn,Paciente_id,Venta_fecha)
            VALUES (@farmaciaID, @pacienteID, GETDATE());
		 print('Ventas Insertado Correctamente')
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
CREATE OR ALTER PROCEDURE dbo.DeleteVentas
		@ventaID  int
AS
BEGIN
  if @ventaID = (SELECT Venta_codigo from venta WHERE Venta_codigo=@ventaID)
	begin
		DELETE FROM VENTA
            WHERE Venta_codigo=@ventaID;
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Venta Eliminado Correctamente!', 16, 1)
	end
  else 
	begin
		Raiserror('Venta No Eliminado!', 16,1)
	end
  end 
GO


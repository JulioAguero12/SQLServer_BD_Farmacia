CREATE OR ALTER PROCEDURE dbo.AddContrato
				 @compf_id   int,
        @farm_id    int,
        @fechai     date,
        @fechaf     date,
        @text       varchar(1000),
        @supv       varchar(50)
AS
  BEGIN TRY
    INSERT INTO dbo.Contrato(Compania_ssn,Farmacia_ssn,Contrato_fechaIni,Contrato_fechaFin,Contrato_texto,Contrato_nomSupervisor) 
         VALUES(@compf_id,@farm_id,@fechai,@fechaf,@text,@supv)  
		 print('Contrato Insertado Correctamente')
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
CREATE OR ALTER PROCEDURE dbo.DeleteContrato
							 @compf_id   int,
        @farm_id    int
AS
BEGIN
  if @compf_id = (SELECT compania_ssn from Contrato WHERE compania_ssn=@compf_id AND Farmacia_ssn=@farm_id) 
	begin
		DELETE FROM dbo.Contrato where compania_ssn=@compf_id
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Contrato Eliminado Correctamente!', 16, 1)
	end
  else 
	begin
		Raiserror('Contrato No Eliminado!', 16,1)
	end
  end 
GO
------------------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.ModifyContrato
				 @compf_id   int,
        @farm_id    int,
        @supv       varchar(50)
AS
BEGIN
  if @compf_id = (SELECT compania_ssn from Contrato WHERE compania_ssn=@compf_id AND Farmacia_ssn=@farm_id) 
	begin
		UPDATE contrato
        SET
            Contrato_nomSupervisor = @supv
        WHERE
            Compania_ssn = @compf_id
            AND Farmacia_ssn = @farm_id;
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Contrato Modificado Correctamente!', 16, 1)
	end
  else 
	begin
		Raiserror('No Se Pudo Modificar!', 16,1)
	end
  end 
GO
 

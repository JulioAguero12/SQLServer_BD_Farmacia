CREATE OR ALTER PROCEDURE dbo.AddMedico
                   @mednombre   varchar(50),
                   @medesoe		varchar(50),
				   @medexp		int
AS
  BEGIN TRY
    INSERT INTO dbo.Medico (Medico_nombre,Medico_especialidad,Medico_aniosExp) 
         VALUES(@mednombre,@medesoe,@medexp)    
		 print('Insertado Correctamente')
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
--------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.DeleteMedico
                   @medid   int
AS
BEGIN
  if @medid = (SELECT @medid from Medico WHERE Medico_id = @medid) 
	begin
		DELETE FROM dbo.Medico where Medico_id = @medid
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Medico Eliminado!', 16, 1)
	end
  else 
	begin
		Raiserror('Medico No Eliminado!', 16,1)
	end
  end 
GO
---------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.ModifyMedico
				   @medid   int,
                   @medesoe		varchar(50),
				@medexp		int
AS
BEGIN
  if @medid = (SELECT @medid from Medico WHERE Medico_id = @medid) 
	begin
		UPDATE Medico 
            SET Medico_especialidad = @medesoe,
				Medico_aniosExp = @medexp
            WHERE Medico_id = @medid;
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Medico Modificado Correctamente!', 16, 1)
	end
  else 
	begin
		Raiserror('No Se Pudo Modificar!', 16,1)
	end
  end 
GO



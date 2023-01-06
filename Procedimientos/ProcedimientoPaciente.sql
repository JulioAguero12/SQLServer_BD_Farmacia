CREATE OR ALTER PROCEDURE dbo.AddPaciente
                   @med_id   INTEGER,
					@nom      VARCHAR(50),
					@edad     INTEGER,
					@dir      VARCHAR(100)
AS
  BEGIN TRY
    INSERT INTO dbo.Paciente (Medico_id,Paciente_nombre,Paciente_edad,Paciente_direccion) 
         VALUES(@med_id,@nom,@edad,@dir)    
		 print('Paciente Insertado Correctamente')
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
CREATE OR ALTER PROCEDURE dbo.DeletePaciente
                   @pac_id   INTEGER
AS
BEGIN
  if @pac_id = (SELECT @pac_id from Paciente WHERE Paciente_id = @pac_id) 
	begin
		DELETE FROM dbo.Paciente where Paciente_id = @pac_id
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Paciente Eliminado Correctamente!', 16, 1)
	end
  else 
	begin
		Raiserror('Paciente No Eliminado!', 16,1)
	end
  end 
GO
------------------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.ModifyPaciente
				   @pac_id   INTEGER,
        @med_id   INTEGER,
        @dir      VARCHAR(100)
AS
BEGIN
  if @pac_id = (SELECT @pac_id from Paciente WHERE Paciente_id = @pac_id) 
	begin
		UPDATE Paciente 
            SET medico_id = @med_id, paciente_direccion = @dir
            WHERE paciente_id = @pac_id;
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
 
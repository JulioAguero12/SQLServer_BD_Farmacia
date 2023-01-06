CREATE OR ALTER PROCEDURE dbo.AddReceta
		@medicoID int,
        @pacienteID int,
        @nombreComercial varchar(50), 
        @compañiaID int,
        @cant int
AS
  BEGIN TRY
    insert into receta(MEDICO_ID,PACIENTE_ID,Medicam_nombre,Compania_ssn,receta_fecha,receta_cantidad)
            values(@medicoID, @pacienteID, @nombreComercial, @compañiaID,GETDATE(), @cant);
		 print('Receta Insertado Correctamente')
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
CREATE OR ALTER PROCEDURE dbo.DeleteReceta
		@medicoID int,
        @pacienteID int,
        @nombreComercial varchar(50), 
        @compañiaID int
AS
BEGIN
  if @medicoID = (SELECT Medico_id from Receta WHERE Medico_id=@medicoID) and
	@pacienteID = (SELECT Paciente_id from Receta WHERE Paciente_id=@pacienteID) and
	@nombreComercial = (SELECT Medicam_nombre from Receta WHERE Medicam_nombre=@nombreComercial) and
	@compañiaID = (SELECT Compania_ssn from Receta WHERE Compania_ssn=@compañiaID) 
	begin
		DELETE FROM RECETA
        WHERE medico_id=@medicoID and paciente_id=@pacienteID and medicam_nombre=@nombreComercial and compania_ssn=@compañiaID;    
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Receta Eliminado Correctamente!', 16, 1)
	end
  else 
	begin
		Raiserror('Receta No Eliminado!', 16,1)
	end
  end 
GO
------------------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.ModifyReceta
		@medicoID int,
        @pacienteID int,
        @nombreComercial varchar(50), 
        @compañiaID int,
        @cant int
AS
BEGIN
  if @medicoID = (SELECT Medico_id from Receta WHERE Medico_id=@medicoID) and
	@pacienteID = (SELECT Paciente_id from Receta WHERE Paciente_id=@pacienteID) and
	@nombreComercial = (SELECT Medicam_nombre from Receta WHERE Medicam_nombre=@nombreComercial) and
	@compañiaID = (SELECT Compania_ssn from Receta WHERE Compania_ssn=@compañiaID) 
	 begin
			UPDATE RECETA
            SET receta_CANTIDAD = @cant
			WHERE medico_id=@medicoID and paciente_id=@pacienteID and medicam_nombre=@nombreComercial and compania_ssn=@compañiaID;   		
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Receta Modificado Correctamente!', 16, 1)
	end
  else 
	begin
		Raiserror('No Se Pudo Modificar!', 16,1)
	end
  end 
GO
 
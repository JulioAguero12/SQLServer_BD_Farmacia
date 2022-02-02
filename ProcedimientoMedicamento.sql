CREATE OR ALTER PROCEDURE dbo.AddMedicamento
				@f_medComp_id int,
        @f_nomCom varchar(50),
        @f_formula varchar(50)
AS
  BEGIN TRY
    INSERT INTO Medicamento(Compania_ssn,Medicam_nombre,Medicam_formula)
            VALUES(@f_medComp_id,@f_nomCom,@f_formula);  
		 print('Medicamento Insertado Correctamente')
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
CREATE OR ALTER PROCEDURE dbo.DeleteMedicamento
        @f_medComp_id int,
        @f_nomCom varchar(50)
AS
BEGIN
  if @f_medComp_id = (SELECT Compania_ssn from Medicamento WHERE Compania_ssn = @f_medComp_id and Medicam_nombre = @f_nomCom) 
  --and @f_nomCom = (SELECT Medicam_nombre from Medicamento WHERE Medicam_nombre = @f_nomCom) 
	begin
		DELETE FROM dbo.Medicamento where Compania_ssn = @f_medComp_id and Medicam_nombre = @f_nomCom
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Medicamento Eliminado Correctamente!', 16, 1)
	end
  else 
	begin
		Raiserror('Medicamento No Eliminado!', 16,1)
	end
  end 
GO
------------------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.ModifyMedicamento
				@f_medComp_id int,
        @f_nomCom varchar(50),
        @f_formula varchar(50)
AS
BEGIN
  if @f_medComp_id = (SELECT Compania_ssn from Medicamento WHERE Compania_ssn = @f_medComp_id and Medicam_nombre = @f_nomCom) 
  --and @f_nomCom = (SELECT Medicam_nombre from Medicamento WHERE Medicam_nombre = @f_nomCom) 
	begin
		UPDATE medicamento
            SET Medicam_formula = @f_formula
            WHERE Medicam_nombre = @f_nomCom AND Compania_ssn = @f_medComp_id;
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Medicamento Modificado Correctamente!', 16, 1)
	end
  else 
	begin
		Raiserror('No Se Pudo Modificar!', 16,1)
	end
  end 
GO
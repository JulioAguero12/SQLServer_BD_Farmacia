CREATE OR ALTER PROCEDURE dbo.AddCompFarm
				@f_compNombre VARCHAR(50),
				@f_compTelf VARCHAR(9)
AS
  BEGIN TRY
    INSERT INTO dbo.CompaniaF(Compania_nombre,Compania_telefono) 
         VALUES(@f_compNombre,@f_compTelf)    
		 print('Compania Farmaceutica Insertado Correctamente')
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
-------------------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.DeleteCompFarm
                   @f_comp_id  INTEGER
AS
BEGIN
  if @f_comp_id = (SELECT @f_comp_id from CompaniaF WHERE Compania_ssn = @f_comp_id) 
	begin
		DELETE FROM dbo.CompaniaF where Compania_ssn = @f_comp_id
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Compania Farmaceutica Eliminado Correctamente!', 16, 1)
	end
  else 
	begin
		Raiserror('Compania Farmaceutica No Eliminado!', 16,1)
	end
  end 
GO
------------------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.ModifyCompFarm
				@f_comp_id int,
				@f_compNombre VARCHAR(50),
				@f_compTelf VARCHAR(9)
AS
BEGIN
  if @f_comp_id = (SELECT @f_comp_id from CompaniaF WHERE Compania_ssn = @f_comp_id) 
	begin
		UPDATE CompaniaF 
            SET Compania_nombre = @f_compNombre, 
                Compania_telefono = @f_compTelf
            WHERE Compania_ssn = @f_comp_id; 
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Compania Farmaceutica Modificado Correctamente!', 16, 1)
	end
  else 
	begin
		Raiserror('No Se Pudo Modificar!', 16,1)
	end
  end 
GO
 

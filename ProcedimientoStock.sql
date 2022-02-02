CREATE OR ALTER PROCEDURE dbo.AddStock
		 @s_farmid int,
        @s_compid int,
        @s_nomCom varchar(50),
        @s_cantidad int,
        @s_precio numeric(4,2)
AS
  BEGIN TRY
    INSERT INTO stock(Farmacia_ssn,Compania_ssn,Medicam_nombre,Stock_cant,stock_precio)
            VALUES(@s_farmid, @s_compid, @s_nomCom,@s_cantidad,@s_precio); 
		 print('Stock Insertado Correctamente')
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
CREATE OR ALTER PROCEDURE dbo.DeleteStock
		@s_stockid int
AS
BEGIN
  if @s_stockid = (SELECT Stock_id from Stock WHERE Stock_id=@s_stockid) 	 
	begin
		DELETE FROM STOCK
            WHERE Stock_id=@s_stockid;
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Stock Eliminado Correctamente!', 16, 1)
	end
  else 
	begin
		Raiserror('Stock No Eliminado!', 16,1)
	end
  end 
GO
------------------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.ModifyStock
		@s_stockid int,
@s_precio int,
        @s_cantidad int      
AS
BEGIN
if @s_stockid = (SELECT Stock_id from Stock WHERE Stock_id=@s_stockid) 	 
	begin
		UPDATE STOCK
            SET Stock_cant = @s_cantidad, Stock_precio = @s_precio
            WHERE Stock_id=@s_stockid;
            
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Stock Modificado Correctamente!', 16, 1)
	end
  else 
	begin
		Raiserror('No Se Pudo Modificar!', 16,1)
	end
  end 
GO
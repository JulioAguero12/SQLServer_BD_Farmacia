CREATE OR ALTER PROCEDURE dbo.AddLineaVentas
        @ventaID int,
		@farmaciaID int,
        @companiaID int,
        @nombreComercial varchar(50),
		@stockid int,
        @preciolv numeric(4,2),
        @cant int   
AS
  BEGIN TRY
    insert into lineaventa(venta_codigo,Farmacia_ssn, compania_ssn, medicam_nombre,Stock_id, lineaventa_precio, lineaventa_cantidadv)
            values(@ventaID,@farmaciaID,@companiaID, @nombreComercial,@stockid,@preciolv, @cant);
		 print('Linea Ventas Insertado Correctamente')
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
CREATE OR ALTER PROCEDURE dbo.DeleteLineaVentas
		@num_lineav int, 
        @ventaID int
AS
BEGIN
  if @num_lineav = (SELECT Num_LineaVenta from LineaVenta WHERE Num_LineaVenta=@num_lineav  and Venta_codigo=@ventaID) 
	begin
		DELETE FROM LINEAVENTA
            WHERE num_lineaventa = @num_lineav and venta_codigo = @ventaID;
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Linea Ventas Eliminado Correctamente!', 16, 1)
	end
  else 
	begin
		Raiserror('Linea Ventas No Eliminado!', 16,1)
	end
  end 
GO
------------------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.ModifyLineaVentas
		@num_lineav int, 
        @ventaID int,
		@cant int
AS
BEGIN
   if @num_lineav = (SELECT Num_LineaVenta from LineaVenta WHERE Num_LineaVenta=@num_lineav) and
	@ventaID = (SELECT Venta_codigo from LineaVenta WHERE Venta_codigo=@ventaID) 
	 begin
		UPDATE LINEAVENTA
            SET Lineaventa_cantidadv = @cant
            WHERE num_lineaventa = @num_lineav and venta_codigo = @ventaID;            
		--16 -> Severity.  
        --1 -> State. 
		Raiserror('Linea Ventas Modificado Correctamente!', 16, 1)
	end
  else 
	begin
		Raiserror('No Se Pudo Modificar!', 16,1)
	end
  end 
GO
 
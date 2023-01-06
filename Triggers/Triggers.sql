create or alter trigger DIS_ventas_insertar
on LINEAVENTA for insert
as
declare @stockS int
	select @stockS= Stock_cant 
	from Stock s
	inner join inserted i on i.Stock_id=s.Stock_id
if (@stockS>=(select LineaVenta_cantidadV from inserted))
	update Stock 
	set Stock_cant=Stock_cant - i.LineaVenta_cantidadV
	from Stock s
	inner join inserted i on i.Stock_id=s.Stock_id
else
	begin
		raiserror ('Hay menos libros en stock de los solicitados para la venta', 16, 1)
		rollback transaction
	end
GO

--Insertamos 
EXEC addLineaVentas 2,2,1,'Fluoruro de sodio',4,12,1;
--------------------------------------------------------------------
create or alter trigger DIS_ventas_eliminar
on LINEAVENTA for delete
as
declare @stockS int
	select @stockS= Stock_cant 
	from Stock s
	inner join deleted d on d.Stock_id=s.Stock_id
if (@stockS>=(select LineaVenta_cantidadV from deleted))
	update Stock 
	set Stock_cant=Stock_cant + d.LineaVenta_cantidadV
	from Stock s
	inner join deleted d on d.Stock_id=s.Stock_id
else
	begin
		raiserror ('Hay menos libros en stock de los solicitados para la venta', 16, 1)
		rollback transaction
	end
GO
--eliminamos
EXEC deleteLineaVentas 13,2;
--------------------------------------------------------------------
create or alter trigger LineaVentas_Stock
on LINEAVENTA
for insert,delete
as
declare @stockS int
IF EXISTS(SELECT * FROM inserted)
BEGIN
	select @stockS= Stock_cant 
	from Stock s
	inner join inserted i on i.Stock_id=s.Stock_id
	if (@stockS>=(select LineaVenta_cantidadV from inserted))
		update Stock 
		set Stock_cant=Stock_cant - i.LineaVenta_cantidadV
		from Stock s
		inner join inserted i on i.Stock_id=s.Stock_id
END
else IF EXISTS(SELECT * FROM deleted)
BEGIN
	select @stockS= Stock_cant 
	from Stock s
	inner join deleted d on d.Stock_id=s.Stock_id
	if (@stockS>=(select LineaVenta_cantidadV from deleted))
		update Stock 
		set Stock_cant=Stock_cant + d.LineaVenta_cantidadV
		from Stock s
		inner join deleted d on d.Stock_id=s.Stock_id
END
else
	begin
		raiserror ('Hay menos libros en stock de los solicitados para la venta', 16, 1)
		rollback transaction
	end
GO
---------------------------------------------------------------------



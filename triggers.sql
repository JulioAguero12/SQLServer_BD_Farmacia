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
--------------------------------------------------------------------




--Solo se puede insertar una linea de venta si el stock del medicamento al decrementarse 
--quedase con un valor >= 0. 

--Al eliminar una linea de venta el stock se incrementa con la cantidad de la linea de venta eliminada.

CREATE OR REPLACE TRIGGER lineaventas_trigger 
BEFORE INSERT OR DELETE 
ON LINEAVENTA 
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    UPDATE STOCK
    SET Stock_cant = Stock_cant - :NEW.LineaVenta_cantidadV
    WHERE Medicam_nombre = :NEW.Medicam_nombre and Compania_ssn = :NEW.Compania_ssn;  --faltaría el farmacia_ssn, pero LineaVenta no está relacionado con farmacia
  ELSIF DELETING THEN
    UPDATE STOCK
    SET Stock_cant = Stock_cant + :OLD.LineaVenta_cantidadV
    WHERE Medicam_nombre = :OLD.Medicam_nombre and Compania_ssn = :OLD.Compania_ssn;
  END IF;
END;

EXECUTE lineaventa_ops.ingresa_lv(9,16,1,'Sucralfato',2,15,2);

EXECUTE lineaventa_ops.elimina_lv(23)

--------------------------------------------------------------------
--Modificar una linea de venta equivale a primero eliminar la linea de venta y despues
--insertar la linea de venta modificada como si fuese una nueva linea de venta. 

create OR REPLACE trigger MODIFICAR_LINEAVENTAS
after update on LINEAVENTA
for each row
declare
PRAGMA AUTONOMOUS_TRANSACTION;
begin
  insert into LINEAVENTA(Num_LineaVenta,Venta_codigo,Compania_ssn,Medicam_nombre,LineaVenta_precio,LineaVenta_cantidadv)
            values (:old.Num_LineaVenta,:old.Venta_codigo,:old.Compania_ssn,:old.Medicam_nombre,:old.LineaVenta_precio,:NEW.LineaVenta_cantidadv); 
            COMMIT;
    
end;


EXECUTE lineaventa_ops.modifica_lv(42,4,5)



/*create or replace trigger MODIFICAR_LINEAVENTAS
before update on LINEAVENTA
for each row
declare
PRAGMA AUTONOMOUS_TRANSACTION;
begin
   DELETE LINEAVENTA
   WHERE NROLINEAVENTA = :OLD.NROLINEAVENTA;
            --COMMIT; 
end;*/
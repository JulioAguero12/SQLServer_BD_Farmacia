--EJEMPLO BASE
--Declarando el cursor
Declare Cursor1 Cursor scroll
	for select *from dbo.Medico
--abrir el cursor
open Cursor1
--y navegar
--se puede usar 'prior' para retroceder
--ademas de 'last' y 'first'
fetch next from Cursor1
--cerrar el cursor
close Cursor1
--liberar la memoria
deallocate Cursor1

---------------------------------------------------------------

--MOSTRANDO TODOS LOS DATOS DE LA TABLA FARMACIA
go
Declare
	@farmnomb   varchar(50),
	@farmdire   varchar(100),
	@farmtele   varchar(9)
Declare mostrarFarmacia cursor GLOBAL
	for Select Farmacia_nombre,Farmacia_direccion,Farmacia_telefono
		from Farmacia
Open mostrarFarmacia
fetch mostrarFarmacia into @farmnomb,@farmdire,@farmtele
while(@@FETCH_STATUS=0)
begin
	print 'Farmacia ->' + @farmnomb + '  //Direccion ->' + @farmdire + '  //Telefono ->' + @farmtele
	fetch mostrarFarmacia into @farmnomb,@farmdire,@farmtele
end
close mostrarFarmacia
deallocate mostrarFarmacia 

---------------------------------------------------------------

--COPIAR TODOS LOS DATOS DE LA TABLA FARMACIA A TABLA FARMACIA 2
go
Declare
	@farmnomb   varchar(50),
	@farmdire   varchar(100),
	@farmtele   varchar(9)
Declare mostrarFarmacia cursor GLOBAL
	for Select Farmacia_nombre,Farmacia_direccion,Farmacia_telefono
		from Farmacia
Open mostrarFarmacia
fetch mostrarFarmacia into @farmnomb,@farmdire,@farmtele
while(@@FETCH_STATUS=0)
begin
	INSERT INTO Farmacia2 VALUES (@farmnomb,@farmdire,@farmtele)
	fetch mostrarFarmacia into @farmnomb,@farmdire,@farmtele
end
close mostrarFarmacia
deallocate mostrarFarmacia 

---------------------------------------------------------------

--ACTUAIZANDO TODOS LOS DATOS DE LA TABLA FARMACIA
Declare
	@farmnomb   varchar(50),
	@farmdire   varchar(100),
	@farmtele   varchar(9)
Declare mostrarFarmacia cursor GLOBAL
	for Select Farmacia_nombre,Farmacia_direccion,Farmacia_telefono
		from Farmacia for UPDATE
Open mostrarFarmacia
fetch mostrarFarmacia into @farmnomb,@farmdire,@farmtele
while(@@FETCH_STATUS=0)
begin
	update Farmacia set Farmacia_direccion = @farmdire + '-xd'
	fetch mostrarFarmacia into @farmnomb,@farmdire,@farmtele
end
close mostrarFarmacia
deallocate mostrarFarmacia 

---------------------------------------------------------------

--MOSTRAR una farmacia, mostrar la información de sus contratos. 

Declare
	@conttext   varchar(1000),
	@contnomS   varchar(50)
Declare mostrarcontratosfarmacia cursor GLOBAL
	for SELECT t.contrato_texto           AS text,
				t.contrato_nomsupervisor   AS super
        FROM Contrato t
		INNER JOIN Farmacia f ON t.Farmacia_ssn = f.Farmacia_ssn
        INNER JOIN Companiaf c ON t.Compania_ssn = c.Compania_ssn;
Open mostrarcontratosfarmacia
fetch mostrarcontratosfarmacia into @conttext,@contnomS
while(@@FETCH_STATUS=0)
begin
	print 'Farmacia ->' + @conttext + '  //Direccion ->' + @contnomS
	fetch mostrarcontratosfarmacia into @conttext,@contnomS
end
close mostrarcontratosfarmacia
deallocate mostrarcontratosfarmacia 

---------------------------------------------------------------

create or replace PACKAGE BODY mostrarDatos_ops AS

    --Dada una farmacia, mostrar la información de sus contratos. 
    PROCEDURE mostrarcontratosfarmacia (
        m_farmaid contrato.farmacia_ssn%TYPE
    ) AS
        CURSOR farma_contrato IS
        SELECT
            f.farmacia_nombre          AS farma,
            c.compania_nombre          AS compañia,
            t.contrato_fechaini        AS inicio,
            t.contrato_fechafin        AS fin,
            t.contrato_texto           AS text,
            t.contrato_nomsupervisor   AS super
        FROM
            Farmacia                f,
            Companiaf               c,
            Contrato                t
        WHERE
            t.farmacia_ssn = m_farmaid
            AND f.farmacia_ssn = t.farmacia_ssn
            AND c.compania_ssn = t.compania_ssn;

    BEGIN
        FOR fc IN farma_contrato LOOP
            dbms_output.put_line('la farmacia '
                                 || fc.farma
                                 || ' tiene contrato la compañia '
                                 || fc.compañia
                                 || ', Fecha Inicial-> '
                                 || fc.inicio
                                 || ', Fecha Final-> '
                                 || fc.fin
                                 || ', Descripcion-> '
                                 || fc.text
                                 || ', Supervisor-> '
                                 || fc.super);
        END LOOP;
    END mostrarcontratosfarmacia;
    

    --Dada una compañia farmaceutica, mostrar la información de sus contratos. (tabla contratos)
    PROCEDURE mostrarcontratoscompañia (
        m_compaid contrato.compania_ssn%TYPE
    ) AS
        CURSOR compa_contrato IS
        SELECT
            f.farmacia_nombre              AS farma,
            c.compania_nombre              AS compañia,
            t.contrato_fechaini            AS inicio,
            t.contrato_fechafin            AS fin,
            t.contrato_texto               AS text,
            t.contrato_nomsupervisor       AS super
        FROM
            Farmacia                f,
            Companiaf               c,
            Contrato                t
        WHERE
            c.compania_ssn = m_compaid
            AND f.farmacia_ssn = t.farmacia_ssn
            AND c.compania_ssn = t.compania_ssn;

    BEGIN
        FOR fc IN compa_contrato LOOP
            dbms_output.put_line('La Compañia Farmaceutica '
                                 || fc.compañia
                                 || ' tiene contrato la Farmacia '
                                 || fc.farma
                                 || ', Fecha Inicial-> '
                                 || fc.inicio
                                 || ', Fecha Final-> '
                                 || fc.fin
                                 || ', Descripcion-> '
                                 || fc.text
                                 || ', Supervisor-> '
                                 || fc.super);
        END LOOP;
    END mostrarcontratoscompañia;
    

    --Dada una compañía farmacéutica, mostrar la lista sus medicamentos.(tabla medicamento)
    PROCEDURE mostrarmedicamentoscompañia (
        s_compid medicamento.compania_ssn%TYPE
    ) AS

        CURSOR compañia_medicamento IS
        SELECT
            c.compania_nombre   AS nombre,
            m.medicam_nombre    AS nombrecomercial
        FROM
            companiaf     c,
            medicamento   m
        WHERE
            m.compania_ssn = s_compid
            AND c.compania_ssn = m.compania_ssn;
    BEGIN
        FOR a IN compañia_medicamento LOOP
            dbms_output.put_line('La Compañia Farmaceutica '
                                 || a.nombre
                                 || ' produce el medicamento-> '
                                 || a.nombrecomercial);
        END LOOP;
    END mostrarmedicamentoscompañia;


    --Dada una farmacia, mostrar la lista de sus medicamentos junto con la compañía farmacéutica a la que pertenecen. (tabla stock)
    PROCEDURE mostrarfmc (
        s_farmaid stock.farmacia_ssn%TYPE
    ) AS

        CURSOR farmamedicomp IS
        SELECT
            f.farmacia_nombre  AS farma,
            c.compania_nombre  AS compañia,
            s.medicam_nombre   AS ncomer
        FROM
            farmacia                f,
            companiaf               c,
            stock                   s
        WHERE
            s.farmacia_ssn = s_farmaid
            AND f.farmacia_ssn = s.farmacia_ssn
            AND c.compania_ssn = s.compania_ssn;

    BEGIN
        FOR a IN farmamedicomp LOOP
            dbms_output.put_line('La Farmacia '
                                 || a.farma
                                 || ' tiene el medicamento '
                                 || a.ncomer
                                 || ' de la Compañia Farmaceutica '
                                 || a.compañia);
        END LOOP;
    END mostrarfmc;


    --Dada una farmacia, mostrar sus ventas y sus totales por cada venta (por periodo de tiempo). (tabla ventas)

    PROCEDURE mostrarventasfarmacia (
        v_farmaid venta.farmacia_ssn%TYPE
    ) AS

        CURSOR venta_farmacia IS
        SELECT
            l.Venta_codigo               AS nrovntas,
            SUM (l.lineaventa_cantidadv) AS totalvntas,
            v.venta_fecha                AS fecha
        FROM
            venta        v,
            lineaventa   l
        WHERE
            v.farmacia_ssn= v_farmaid
            AND v.venta_codigo = l.venta_codigo
            GROUP BY l.venta_codigo,v.venta_fecha;
    BEGIN
        FOR con IN venta_farmacia LOOP
            dbms_output.put_line('IdVenta-> '
                                 || con.nrovntas
                                 || ' Total de Ventas-> '
                                 || con.totalvntas
                                 || ' Fecha-> '
                                 || con.fecha);
        END LOOP;
    END mostrarventasfarmacia;


    --Dado un paciente, mostrar sus recetas registradas. (tabla recetas)
    PROCEDURE mostrarrecetaspaciente (
        r_pacid receta.paciente_id%TYPE
    ) AS

        CURSOR recetas_paciente IS
        SELECT
            p.paciente_nombre   AS pnombre,
            r.medicam_nombre    AS noc,
            r.receta_fecha      AS fechacompra,
            r.receta_cantidad   AS cant
        FROM
            paciente   p,
            receta     r
        WHERE
            r.paciente_id = r_pacid
            AND p.paciente_id = r.paciente_id;

    BEGIN
        FOR pac IN recetas_paciente LOOP
            dbms_output.put_line('el paciente  '
                                 || pac.pnombre
                                 || ' compro '
                                 || pac.cant
                                 || ' unidades del medicamento '
                                 || pac.noc
                                 || ' Fecha-> '
                                 || pac.fechacompra);
        END LOOP;
    END mostrarrecetaspaciente;

END mostrarDatos_ops;
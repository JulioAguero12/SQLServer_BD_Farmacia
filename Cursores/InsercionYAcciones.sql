-- MEDICO
EXEC dbo.addMedico 'Filino de Cos', 'Neurologia',5;
EXEC dbo.addMedico 'Calcideo', 'Traumatologia',4;
EXEC dbo.addMedico 'Calímaco', 'Neurologia',7;
EXEC dbo.addMedico 'Cares de Atenas', 'Neumologia',8;
EXEC dbo.addMedico 'Fainarate', 'Odontología',2;
EXEC dbo.addMedico 'Hercules', 'Psicologia',3;

--Si el medico con id 6 quiere cambiar su especialidad y actualizar sus años de experiencia
EXEC dbo.ModifyMedico 6,'Odontología',12;
--Medico con id erroneo
EXEC dbo.ModifyMedico 100,'Odontología',12;

--Eliminar medico con id 6
EXEC dbo.DeleteMedico 6;
--Eliminar medico con id erroneo
EXEC dbo.DeleteMedico 100;

SELECT * FROM medico; 



-- PACIENTE 
--Ingresar (medico_id, nombre, edad, direccion)
EXEC dbo.AddPaciente 2,'JuaN Gonzales',14,'Apdo.:163-7179 Imperdiet Avenida';
EXEC dbo.AddPaciente 2,'Daniel Perez',17,'496-3649 Nec Av.';
EXEC dbo.AddPaciente 4,'Maria Casas',25,'331-5216 Nonummy C/';
EXEC dbo.AddPaciente 5,'Juan Cazani',58,'9893 Lorem, C.';
EXEC dbo.AddPaciente 5,'Luis Guillen',42,'Apartado núm.: 155, 6615 Quam. C/';
EXEC dbo.AddPaciente 5,'Jose Giraldo',52,'452-3649 Nec Av.';

-- PACIENTE (paciente_id, medico_id, direccion)
--Si el paciente con id 5 quiero cambiar al medico con id 3 ademas de una nueva direccion
EXEC dbo.ModifyPaciente 5,3,'8003 Pellentesque';
--Modificar Paciente con id erroneo 
EXEC dbo.ModifyPaciente 50,3,'8003 Pellentesque';

--Eliminar paciente con id 5
EXEC dbo.DeletePaciente 6;
--Eliminar paciente con id erroneo
EXEC dbo.DeletePaciente 50;

SELECT * FROM paciente;




-- COMPAÑIA FARMACEUTICA 
--ingresar (nombre, telefono)
EXEC AddCompFarm 'Química Suiza S.A.',2114000;
EXEC AddCompFarm'Lansier',3328302;
EXEC AddCompFarm 'Hersil S.A',7133333;
EXEC AddCompFarm 'Hospira',2114034;
EXEC AddCompFarm 'Grünenthal Peruana',2241727;
EXEC AddCompFarm 'DUBONP S.A.',2211588;
EXEC AddCompFarm 'Bayer S.A.',2113800;
EXEC AddCompFarm 'TECNOFARMA',70003000;
EXEC AddCompFarm 'Genomma Lab',554300;

--Si la compañia Farmaceutica con id 9 quiere cambiar de nombre y actualizar su numero de telefono
EXEC ModifyCompFarm 9,'Laboratorio Genomma',927395123;
--Modificar compañia Farmaceutica con id erronero
EXEC ModifyCompFarm 50,'Química Suiza S.A.',927395123;

--eliminar compañia Farmaceutica con id 10
EXEC DeleteCompFarm 10;
--eliminar compañia Farmaceutica con id erroneo
EXEC DeleteCompFarm 90;

SELECT * FROM companiaF;




-- MEDICAMENTO (compania_ssn,nombrecomercial,formula)
--Ingresar (compania_ssn,nombrecomercial,formula)
EXEC AddMedicamento 1, 'Fluoruro de sodio','Comprimido';
EXEC AddMedicamento 1, 'Ranitidina','Inyectable';
EXEC AddMedicamento 2, 'Sucralfato','Liquido oral';
EXEC AddMedicamento 2, 'Atropina','Inyectable';
EXEC AddMedicamento 2, 'Omeprazol','Inyectable';
EXEC AddMedicamento 3, 'Domperidona','Inyectable';
EXEC AddMedicamento 4, 'Metformina','Comprimido';
EXEC AddMedicamento 5, 'Glimepirida','Comprimido';
EXEC AddMedicamento 5, 'Metformina + rosiglitazona','Comprimido';
EXEC AddMedicamento 6, 'Repaglinida','Comprimido';
EXEC AddMedicamento 7, 'Tocoferol','Cápsula blanda';
EXEC AddMedicamento 7, 'Retinol','Cápsula blanda';
EXEC AddMedicamento 7, 'Warfarina','Comprimido';
EXEC AddMedicamento 8, 'Heparina sódica','Inyectable';
EXEC AddMedicamento 3, 'Metoclopramida','Líquido oral';
EXEC AddMedicamento 9, 'Paracetamol','Capsula Blanda';

--id compañia, nombre, nueva formula
EXEC ModifyMedicamento 3,'Metoclopramida','Inyectable';
--Modificando un medicamento de una compañia que no existe
EXEC ModifyMedicamento 50,'Metoclopramida','Meta','Inyectable';

--Eliminando un medicamento con id compañia 3 y nombrecomercial Meta
EXEC DeleteMedicamento 3,'Meta';
--Eliminando un medicamento con id compañia inexistente
EXEC DeleteMedicamento 30,'Meta';

SELECT * FROM MEDICAMENTO;




-- FARMACIA 
--Ingresar nombre, direccion, telefono)
EXEC AddFarmacia 'Boticas Peru','Jr. Baltazar Grados Nro. 794',2744207;
EXEC AddFarmacia 'Famifarma', 'Mza. B Lote. 13 Asc. los Topacios',6152100;
EXEC AddFarmacia'Boticas la Merced', 'Mza. T5 Lote. 10 Sec. 3er Sector Angamos',2193300;
EXEC AddFarmacia'Farmacias Vida Sana', 'Av. Leandra Torres Nro. 276',2155300;
EXEC AddFarmacia 'Farmacias Unidas', 'Av. Guardia Civil Nro. 498',2652200;
EXEC AddFarmacia 'Farmacias Santa Ana', 'Av. 13 de Enero Nro. 2282',7984500;
EXEC AddFarmacia 'Farmacias Kalyfar', 'Av. Armando Filomeno Nro. 219',4523100;
EXEC AddFarmacia 'Farmacias Inkafarma', 'Av. Los Proces',5223200;
EXEC AddFarmacia 'Farmacias Salud', 'Av. Los Angeles',6793200;

--Modificar nombre de la farmacia ,direccion , telefono
EXEC ModifyFarmacia 9,'Farmacias Covid','Av. Universitaria 550','924613998';
--Modificar con farmacia id erroneo
EXEC ModifyFarmacia 90,'Farmacias Covid','Av. Universitaria 550','924613998';

--Eliminar farmacia con id 9
EXEC DeleteFarmacia 9;
--Eliminar farmacia con id erroneo
EXEC DeleteFarmacia 90;

SELECT * FROM farmacia;



-- CONTRATO (compañiaf_id,farmacia_id,fechainicio,fechafin,texto, nombresupervisor)
EXEC AddContrato 4, 2, '01-03-2015', '01-01-2021', 'TextoA','Flynn D. Silva';
EXEC AddContrato 5, 1, '01-06-2013', '05-12-2021', 'TextoA','Mona Wilkins';
EXEC AddContrato 7, 5, '02-12-2015', '04-01-2024', 'TextoC','Jade H. Bray';
EXEC AddContrato 8, 7, '05-05-2012', '05-10-2025', 'TextoD','April Y. Wagner';
EXEC AddContrato 2, 1, '02-12-2017', '04-01-2023', 'TextoE','Kyle K. Mitchell';
EXEC AddContrato 8, 1, '05-05-2018', '05-10-2021', 'TextoF','Troy G. Cotton';
EXEC AddContrato 4, 8, '01-03-2015', '01-01-2021', 'TextoA','Flynn D. Silva';
EXEC AddContrato 5, 5, '01-06-2013', '05-12-2021', 'TextoB','Mona Wilkins';
EXEC AddContrato 1, 5, '02-12-2015', '04-01-2024', 'TextoC','Jade H. Bray';
EXEC AddContrato 2, 7, '05-05-2012', '05-10-2025', 'TextoD','April Y. Wagner';
EXEC AddContrato 6, 1, '02-12-2017', '04-01-2023', 'TextoE','Kyle K. Mitchell';
EXEC AddContrato 3, 1, '01-03-2015', '01-01-2021', 'TextoA','Flynn D. Silva';
EXEC AddContrato 4, 1, '01-06-2013', '05-12-2021', 'TextoB','Mona Wilkins';
EXEC AddContrato 7, 1, '05-05-2012', '05-10-2025', 'TextoD','April Y. Wagner';
EXEC AddContrato 1,2, '05-05-2018', '05-10-2021', 'TextoF','Troy G. Cotton';
EXEC AddContrato 1,3, '01-03-2015', '01-01-2021', 'TextoA','Flynn D. Silva';
EXEC AddContrato 1,4, '01-06-2013', '05-12-2021', 'TextoB','Mona Wilkins';
EXEC AddContrato 1,6, '02-12-2015', '04-01-2024', 'TextoC','Jade H. Bray';
EXEC AddContrato 1,7, '05-05-2012', '05-10-2025', 'TextoD','April Y. Wagner';


EXECUTE contrato_ops.modifica_contrato(4, 2, 'Chupetin');

EXECUTE contrato_ops.elimina_contrato(4, 2);

SELECT * FROM contrato;




-- STOCK 
-- Ingresar FARMACIA_ssn,COMPANIA_SSN,Medicam_nombre,CANTIDAD,PRECIO
EXEC AddStock 1,5,'Glimepirida',600,5;
EXEC AddStock 5,7,'Retinol',100,15;
EXEC AddStock 7,8,'Heparina sódica',180,5;
EXEC AddStock 2,1,'Fluoruro de sodio',100,12;
EXEC AddStock 3,1,'Fluoruro de sodio',200,15;
EXEC AddStock 4,1,'Fluoruro de sodio',900,15;
EXEC AddStock 5,1,'Fluoruro de sodio',800,18;
EXEC AddStock 6,1,'Fluoruro de sodio',820,20;
EXEC AddStock 1,2,'Sucralfato',15,10;
EXEC AddStock 1,6,'Repaglinida',100,1;
EXEC AddStock 1,3,'Domperidona',900,17;
EXEC AddStock 1,4,'Metformina',800,18;
EXEC AddStock 1,8,'Heparina sódica',800,20;

--Ingresando un nuevo stock a una farmacia y compañia farmaceutica que no tienen contrato
EXEC AddStock 7,5,'Glimepirida',100,15;

--Modificando el STOCK 
EXEC ModifyStock 1,500,17;
--Modificando el STOCK erroneo
EXEC ModifyStock 10,700,12;

--Eliminando el STOCK 
EXEC DeleteStock 13;


SELECT * FROM stock;



-- VENTA 
--Ingresar FARMACIA SNN, PACIENTE ID
EXEC AddVentas 1,1;
EXEC AddVentas 2,2;
EXEC AddVentas 5,4;
EXEC AddVentas 2,5;
EXEC AddVentas 1,5;
EXEC AddVentas 1,2;
EXEC AddVentas 1,1;
EXEC AddVentas 5,4;
EXEC AddVentas 1,4;
EXEC AddVentas 2,5;
EXEC AddVentas 1,5;
EXEC AddVentas 1,2;
EXEC AddVentas 1,1;
EXEC AddVentas 4,NULL;
EXEC AddVentas 1,NULL;


--Eliminar venta con ventaID igual a 13 y farmaciaID igual a 1
EXEC DeleteVentas 13;
--Eliminar venta con ventaID igual a 15 y farmaciaID igual a null
EXEC DeleteVentas 15;
--Eliminar venta con ventaID que no existe
EXEC DeleteVentas 50;


SELECT *FROM VENTA;




-- LINEA DE VENTA 
--Ingresar
--ventaID,farmaciaID,CompañiaID,NombreComercial,stockID, PrecioLV, cannt
EXEC addLineaVentas 9,1,2,'Sucralfato',9,10,2;
EXEC addLineaVentas 1,1,6,'Repaglinida',11,17,2;
EXEC addLineaVentas 2,2,1,'Fluoruro de sodio',4,12,2;
--EXEC addLineaVentas 3,5,1,'Fluoruro de sodio',12,2;
--EXEC addLineaVentas 4,2,1,'Fluoruro de sodio',18,2;
--EXEC addLineaVentas 5,1,6,'Repaglinida',1,2;
--EXEC addLineaVentas 6,1,1,'Fluoruro de sodio',12,2;
--EXEC addLineaVentas 7,1,5,'Glimepirida',15,2;
--EXEC addLineaVentas 8,5,2,'Sucralfato',15,2;
--EXEC addLineaVentas 10,2,6,'Repaglinida',1,2;
--EXEC addLineaVentas 11,1,1,'Fluoruro de sodio',12,2;
--EXEC addLineaVentas 12,1,6,'Repaglinida',1,2;
--EXEC addLineaVentas 14,4,5,'Glimepirida',15,2;

--Actualizar
--numlineaventa,venta_id, cantidad
EXEC ModifyLineaVentas 8,2,44;

--Eliminar
--numLineaVEnta, ventaid
EXEC DeleteLineaVentas 8,2;

select *from LineaVenta;





-- RECETA (medico_id, paciente_id, nombrecomercial, compañiaf_id, fecha, cantidad)
--Registar Receta
EXEC AddReceta 2,1,'Glimepirida',5, 2;
EXEC AddReceta 3,2,'Tocoferol',7, 1;

--Actualizar receta
--medicoid.pacienteid,nombrecomercial,companiassn, cantidad
EXEC ModifyReceta 2,1,'Glimepirida',5,20;

--Eliminar
--medicoid,pacienteid,nombrecomercia,companiassn
EXECUTE DeleteReceta 2,1,'Glimepirida',5;

SELECT * FROM receta;



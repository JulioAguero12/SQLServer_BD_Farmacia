CREATE TABLE Farmacia( 
  Farmacia_ssn INTEGER IDENTITY CHECK(Farmacia_ssn>0),
  Farmacia_nombre VARCHAR(50) NOT NULL,
  Farmacia_direccion VARCHAR(100)NOT NULL,
  Farmacia_telefono VARCHAR(9),
  CONSTRAINT Farmacia_PK PRIMARY KEY(Farmacia_ssn)
);
GO 
ALTER TABLE Farmacia ADD CONSTRAINT FARMACIA_UX_FARM_NOMBRE UNIQUE (Farmacia_nombre);
ALTER TABLE Farmacia ADD CONSTRAINT FARMACIA_UX_FARM_DIRECCION UNIQUE (Farmacia_direccion);
ALTER TABLE Farmacia ADD CONSTRAINT FARMACIA_UX_FARM_TELEFONO UNIQUE (Farmacia_telefono);
GO
CREATE TABLE Medico(
  Medico_id INTEGER IDENTITY CHECK(Medico_id>0),
  Medico_nombre VARCHAR(50) NOT NULL,
  Medico_especialidad VARCHAR(50) NOT NULL,
  Medico_aniosExp INTEGER NOT NULL CHECK(Medico_aniosExp>0),
  CONSTRAINT Medico_PK PRIMARY KEY(Medico_id)
);
GO
CREATE TABLE Paciente(
  Paciente_id INTEGER IDENTITY CHECK(Paciente_id>0),
  Medico_id INTEGER NOT NULL,
  Paciente_nombre VARCHAR(50) NOT NULL,
  Paciente_edad INTEGER NOT NULL CHECK(Paciente_edad BETWEEN 1 AND 100),
  Paciente_direccion VARCHAR(100) NOT NULL,
  CONSTRAINT Paciente_PK PRIMARY KEY(Paciente_id),
  CONSTRAINT Medico_FK FOREIGN KEY(Medico_id) REFERENCES Medico(Medico_id) ON DELETE CASCADE
);
GO
CREATE TABLE CompaniaF(
  Compania_ssn INTEGER IDENTITY CHECK(Compania_ssn>0),
  Compania_nombre VARCHAR(50) NOT NULL,
  Compania_telefono VARCHAR(9) NOT NULL,
  CONSTRAINT Compania_PK PRIMARY KEY(Compania_ssn)
);
GO
ALTER TABLE CompaniaF ADD CONSTRAINT CompaniaF_UX_Compania_nombre UNIQUE (Compania_nombre);
ALTER TABLE CompaniaF ADD CONSTRAINT CompaniaF_UX_Compania_telefono UNIQUE (Compania_telefono);
GO
CREATE TABLE Medicamento(
  Compania_ssn INTEGER NOT NULL,
  Medicam_nombre VARCHAR(50) NOT NULL,
  Medicam_formula VARCHAR(50) NOT NULL,
  CONSTRAINT Medicamento_PK PRIMARY KEY(Compania_ssn,Medicam_nombre),
  CONSTRAINT Medicamento_FK FOREIGN KEY(Compania_ssn) REFERENCES CompaniaF(Compania_ssn) ON DELETE CASCADE
);
GO
ALTER TABLE Medicamento ADD CONSTRAINT MEDICAMENTOS_UX_MEDICAMENTO_NOMBRE UNIQUE (Medicam_nombre);
GO
CREATE TABLE Contrato(
  Compania_ssn INTEGER NOT NULL,
  Farmacia_ssn INTEGER NOT NULL,
  Contrato_fechaIni DATE NOT NULL,
  Contrato_fechaFin DATE NOT NULL,
  Contrato_texto VARCHAR(1000) NOT NULL,
  Contrato_nomSupervisor VARCHAR(50) NOT NULL,
  CONSTRAINT Contrato_PK PRIMARY KEY(Compania_ssn,Farmacia_ssn),
  CONSTRAINT CompaniaFK FOREIGN KEY(Compania_ssn) REFERENCES CompaniaF(Compania_ssn) ON DELETE CASCADE,
  CONSTRAINT FarmaciaFK FOREIGN KEY(Farmacia_ssn) REFERENCES Farmacia(Farmacia_ssn) ON DELETE CASCADE
);
GO
CREATE TABLE Venta(
  Venta_codigo INTEGER IDENTITY,
  Paciente_id INTEGER,
  Farmacia_ssn INTEGER NOT NULL,
  Venta_fecha DATE NOT NULL,
  CONSTRAINT Venta_PK PRIMARY KEY(Venta_codigo,Farmacia_ssn),
  CONSTRAINT PacientePK FOREIGN KEY(Paciente_id) REFERENCES Paciente(Paciente_id) ON DELETE CASCADE,
  CONSTRAINT FarmaciaPK FOREIGN KEY(Farmacia_ssn) REFERENCES Farmacia(Farmacia_ssn) ON DELETE CASCADE
);
GO
CREATE TABLE Receta(
  Medico_id INTEGER NOT NULL,
  Paciente_id INTEGER NOT NULL,
  Medicam_nombre VARCHAR(50) NOT NULL,
  Compania_ssn INTEGER NOT NULL,
  Receta_fecha DATE NOT NULL,
  Receta_cantidad INTEGER NOT NULL,
  CONSTRAINT Receta_PK PRIMARY KEY(Medico_id,Paciente_id,Medicam_nombre,Compania_ssn),
  CONSTRAINT MedicoFK FOREIGN KEY(Medico_id) REFERENCES Medico(Medico_id) ON DELETE CASCADE,
  CONSTRAINT PacienteFK FOREIGN KEY(Paciente_id) REFERENCES Paciente(Paciente_id) ON DELETE NO ACTION,
  CONSTRAINT MedicamentoFK FOREIGN KEY(Compania_ssn,Medicam_nombre) REFERENCES Medicamento(Compania_ssn,Medicam_nombre) ON DELETE CASCADE
);
GO
CREATE TABLE Stock(
  Stock_id INTEGER IDENTITY CHECK(Stock_id>0),
  Stock_precio INTEGER NOT NULL,
  Farmacia_ssn INTEGER NOT NULL,
  Compania_ssn INTEGER NOT NULL,
  Medicam_nombre VARCHAR(50) NOT NULL,
  Stock_cant INTEGER NOT NULL CHECK(Stock_cant>-1),
  CONSTRAINT Stock_PK PRIMARY KEY(Stock_id,Stock_precio),
  CONSTRAINT ContratoPK FOREIGN KEY(Compania_ssn,Farmacia_ssn) REFERENCES Contrato(Compania_ssn,Farmacia_ssn) ON DELETE NO ACTION,
  CONSTRAINT MedicamFK FOREIGN KEY(Compania_ssn,Medicam_nombre) REFERENCES Medicamento(Compania_ssn,Medicam_nombre) ON DELETE CASCADE,
  CONSTRAINT FarmaciaStockFK FOREIGN KEY(Farmacia_ssn) REFERENCES Farmacia(Farmacia_ssn) ON DELETE CASCADE
);
GO
CREATE TABLE LineaVenta(
   Num_LineaVenta INTEGER IDENTITY,
   Venta_codigo INTEGER NOT NULL,
   Farmacia_ssn INTEGER NOT NULL,
   Compania_ssn INTEGER NOT NULL,
   Medicam_nombre VARCHAR(50) NOT NULL,
   Stock_id INTEGER NOT NULL,
   LineaVenta_precio INTEGER NOT NULL,
   LineaVenta_cantidadV INTEGER NOT NULL CHECK(LineaVenta_cantidadV>0),
   CONSTRAINT LineaVenta_PK PRIMARY KEY(Num_LineaVenta,Venta_codigo,Farmacia_ssn),
   CONSTRAINT VentaFK FOREIGN KEY(Venta_codigo,Farmacia_ssn) REFERENCES Venta(Venta_codigo,Farmacia_ssn) ON DELETE CASCADE,
   CONSTRAINT MedicamentFK FOREIGN KEY(Compania_ssn,Medicam_nombre) REFERENCES Medicamento(Compania_ssn,Medicam_nombre) ON DELETE CASCADE,
   CONSTRAINT StockFK FOREIGN KEY(Stock_id,LineaVenta_precio) REFERENCES Stock(Stock_id,Stock_precio) ON DELETE NO ACTION
);


-- factura(creado)
CREATE OR REPLACE TYPE tFactura AS OBJECT (
    idFactura VARCHAR (5), -- Numero de factura
    FechaEmision DATE, -- Fecha de emision de la factura
    MEMBER FUNCTION obtenerNumeroFactura RETURN NUMBER
);

-- Implementacion del m?todo del tipo de objeto "tFactura"
CREATE OR REPLACE TYPE BODY tFactura AS
    -- Metodo para obtener el numero de factura
    MEMBER FUNCTION obtenerNumeroFactura RETURN NUMBER IS
    BEGIN
        RETURN 'El n? de factura es: '||idFactura;
    END;
END;

-- Crear la tabla "factura" que utiliza el tipo de objeto "tFactura"
CREATE TABLE Factura OF tFactura;

alter table Factura add primary key (idFactura);


-- Cliente(creado)
CREATE OR REPLACE TYPE tCliente AS OBJECT (
    idCliente NUMBER, 
    nombre varchar(50),
    correoElectronico varchar(50),
    direccion varchar(50),
    CuentaBancaria varchar(30),
    MEMBER FUNCTION obtenerDetalleCliente RETURN NUMBER
);

CREATE OR REPLACE TYPE BODY tCliente AS
    -- Metodo para obtener el n?mero de factura
    MEMBER FUNCTION obtenerDetalleCliente RETURN NUMBER IS
    BEGIN
        RETURN 'El n? de cliente es: '||idCliente || 'Nombre: '||nombre || 'Correo: '||correoElectronico || 'Direccion: '||direccion;
    END;
END;

CREATE TABLE Cliente OF tCliente;

alter table Cliente add primary key (idCliente);

-- Producto(creado)

CREATE OR REPLACE TYPE tProducto AS OBJECT (
    idProducto VARCHAR (5), 
    nombre varchar(50),
    precio int,
    dimensiones varchar(50),
    MEMBER FUNCTION obtenerDetalleProducto RETURN NUMBER
);

CREATE OR REPLACE TYPE BODY tProducto AS
    -- Metodo para obtener el numero de factura
    MEMBER FUNCTION obtenerDetalleProducto RETURN NUMBER IS
    BEGIN
        RETURN 'El n? de producto es: '||idProducto || 'Nombre: '||nombre || 'Precio: '||precio;
    END;
END;

CREATE TABLE Producto OF tProducto;

alter table Producto add primary key (idProducto);

-- Transportista(creado)
CREATE OR REPLACE TYPE tTransport AS OBJECT (
    idTransport varchar (5), 
    nombre varchar(50),
    vehiculo varchar(40),
    telefono varchar(15),
    MEMBER FUNCTION obtenerDetalleTransportista RETURN NUMBER
);

CREATE OR REPLACE TYPE BODY tTransport AS
    -- M?todo para obtener el n?mero de factura
    MEMBER FUNCTION obtenerDetalleTransportista RETURN NUMBER IS
    BEGIN
        RETURN 'El n? de transportista es: '||idTransport||'Nombre: '||nombre || 'Vehiculo: '||vehiculo || 'Telefono: '||telefono;
    END;
END;

CREATE TABLE Transportista OF tTransport;

alter table Transportista add primary key (idTransport);

-- Pedido(creada)


CREATE OR REPLACE TYPE tPedido AS OBJECT (
    idPedido VARCHAR(5),
    FechaEntrega DATE,
    FechaRecogida DATE,
    idFactura VARCHAR (5),
    idCliente NUMBER,
    idProducto VARCHAR (5),
    idTransport_recogida varchar (5), 
    idTransport_entrega varchar (5),
    MEMBER FUNCTION obtenerDetallePedido RETURN NUMBER
);

CREATE OR REPLACE TYPE BODY tPedido AS
    -- Método para obtener el detalle del pedido
    MEMBER FUNCTION obtenerDetallePedido RETURN NUMBER IS
    BEGIN
        RETURN 'El número de pedido es: ' || idPedido || 'Fecha de entrega: ' || FechaEntrega || 'Fecha de recogida: ' || FechaRecogida;
    END;
END;

CREATE TABLE Pedido OF tPedido;

alter table Pedido add primary key (idPedido);

-- Agregar las restricciones de clave externa a la tabla Pedido
ALTER TABLE Pedido ADD CONSTRAINT fk_idCliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente);
ALTER TABLE Pedido ADD CONSTRAINT fk_idFactura FOREIGN KEY (idFactura) REFERENCES Factura(idFactura);
ALTER TABLE Pedido ADD CONSTRAINT fk_idTransport_entrega FOREIGN KEY (idTransport_entrega) REFERENCES Transportista(idTransport);
ALTER TABLE Pedido ADD CONSTRAINT fk_idTransport_recogida FOREIGN KEY (idTransport_recogida) REFERENCES Transportista(idTransport);


    
-- Alquuiler(creado)

CREATE OR REPLACE TYPE tAlquiler AS OBJECT (
    idProducto varchar (5), 
    idPedido varchar (5),
    idAlquiler varchar (5),
    precio INT ,
    MEMBER FUNCTION obtenerDetalleAlquiler RETURN NUMBER
);

CREATE OR REPLACE TYPE BODY tAlquiler AS
    -- M?todo para obtener el n?mero de factura
    MEMBER FUNCTION obtenerDetalleAlquiler RETURN NUMBER IS
    BEGIN
        RETURN 'El n? de alquiler es: '||idAlquiler||'precio: '||precio;
    END;
END;

CREATE TABLE Alquiler OF tAlquiler;
alter table Alquiler add primary key (idAlquiler);

ALTER TABLE Alquiler ADD CONSTRAINT fk_idProducto FOREIGN KEY (idProducto) REFERENCES Producto(idProducto);
ALTER TABLE Alquiler ADD CONSTRAINT fk_idPedido FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido);


-- insert into

-- Insert into en la tabla "Factura"
-- Ejemplo 1
INSERT INTO Factura VALUES ('1', TO_DATE('2023-05-19', 'YYYY-MM-DD'));
-- Ejemplo 2
INSERT INTO Factura VALUES ('2', TO_DATE('2023-05-20', 'YYYY-MM-DD'));
-- Ejemplo 3
INSERT INTO Factura VALUES ('3', TO_DATE('2023-05-21', 'YYYY-MM-DD'));
-- Ejemplo 4
INSERT INTO Factura VALUES ('4', TO_DATE('2023-05-22', 'YYYY-MM-DD'));
-- Ejemplo 5
INSERT INTO Factura VALUES ('5', TO_DATE('2023-05-23', 'YYYY-MM-DD'));
-- ejemplo malo
INSERT INTO Factura VALUES ('5', TO_DATE('23-05-2023', 'YYYY-MM-DD'));
-- este insert no funciona por el formato de la fecha
-- Insert into en la tabla "Cliente"
-- Ejemplo 1
INSERT INTO Cliente VALUES (1, 'Juan Pérez', 'juan@example.com', 'Calle Principal 123', 'ES1234567890');
-- Ejemplo 2
INSERT INTO Cliente VALUES (2, 'María Rodríguez', 'maria@example.com', 'Avenida Central 456', 'ES9876543210');
-- Ejemplo 3
INSERT INTO Cliente VALUES (3, 'Pedro Gómez', 'pedro@example.com', 'Plaza Mayor 789', 'ES4567890123');
-- Ejemplo 4
INSERT INTO Cliente VALUES (4, 'Ana López', 'ana@example.com', 'Calle Secundaria 234', 'ES3210987654');
-- Ejemplo 5
INSERT INTO Cliente VALUES (5, 'Luisa Fernández', 'luisa@example.com', 'Avenida Norte 567', 'ES6789012345');
-- ejemplo malo
INSERT INTO Cliente VALUES ('Luisa Fernández', 'luisa@example.com', 'Avenida Norte 567', 'ES6789012345');
-- no funciona porque hay que meter un id ya que no se actualiza automaticamente
-- Insert into en la tabla "Producto"
-- Ejemplo 1
INSERT INTO Producto VALUES ('1', 'Camiseta', 20, 'M');
-- Ejemplo 2
INSERT INTO Producto VALUES ('2', 'Pantalón', 30, 'L');
-- Ejemplo 3
INSERT INTO Producto VALUES ('3', 'Zapatos', 50, 'XL');
-- Ejemplo 4
INSERT INTO Producto VALUES ('4', 'Gorra', 10, 'S');
-- Ejemplo 5
INSERT INTO Producto VALUES ('5', 'Bufanda', 15, 'M');
-- ejemplo malo
INSERT INTO Producto VALUES ('5', 'Bufanda', '22', 'M');
-- da error porque el numero tiene que ir sin comillas ya que es un 'int'
-- Insert into en la tabla "Transportista"
-- Ejemplo 1
INSERT INTO Transportista VALUES ('1', 'Juan', 'Automóvil', '123456789');
-- Ejemplo 2
INSERT INTO Transportista VALUES ('2', 'María', 'Camión', '987654321');
-- Ejemplo 3
INSERT INTO Transportista VALUES ('3', 'Pedro', 'Motocicleta', '567890123');
-- Ejemplo 4
INSERT INTO Transportista VALUES ('4', 'Laura', 'Bicicleta', '321098765');
-- Ejemplo 5
INSERT INTO Transportista VALUES ('5', 'Carlos', 'Furgoneta', '789012345');
-- ejemplo malo
INSERT INTO Transportista VALUES ('5', 'Carlos', 'Furgoneta', 7890123451);
-- da error porque es un varchar y le hemos quitado las comillas como si fuera un int
-- Insert into en la tabla "Pedido"
-- Ejemplo 1
INSERT INTO Pedido VALUES ('1', TO_DATE('2023-05-19', 'YYYY-MM-DD'), TO_DATE('2023-05-21', 'YYYY-MM-DD'), '1', 1, '1', '1', '1');
-- Ejemplo 2
INSERT INTO Pedido VALUES ('2', TO_DATE('2023-05-20', 'YYYY-MM-DD'), TO_DATE('2023-05-22', 'YYYY-MM-DD'), '2', 2, '2', '3', '2');
-- Ejemplo 3
INSERT INTO Pedido VALUES ('3', TO_DATE('2023-05-21', 'YYYY-MM-DD'), TO_DATE('2023-05-23', 'YYYY-MM-DD'), '3', 3, '3', '1', '3');
-- Ejemplo 4
INSERT INTO Pedido VALUES ('4', TO_DATE('2023-05-22', 'YYYY-MM-DD'), TO_DATE('2023-05-24', 'YYYY-MM-DD'), '4', 4, '4', '2', '4');
-- Ejemplo 5
INSERT INTO Pedido VALUES ('5', TO_DATE('2023-05-23', 'YYYY-MM-DD'), TO_DATE('2023-05-25', 'YYYY-MM-DD'), '5', 5, '5', '4', '5');
-- ejemplo malo
INSERT INTO Pedido VALUES ('5', TO_DATE('2023-05-23', 'YYYY-MM-DD'), TO_DATE('2023-05-25', 'YYYY-MM-DD'), '6', 5, '5', '4', '5');
-- da error porque el id 6 de factura no existe
-- Insert into en la tabla "Alquuiler"
-- Ejemplo 1
INSERT INTO Alquiler VALUES ('1', '1', '1', 50);
-- Ejemplo 2
INSERT INTO Alquiler VALUES ('2', '2', '2', 70);
-- Ejemplo 3
INSERT INTO Alquiler VALUES ('3', '3', '3', 60);
-- Ejemplo 4
INSERT INTO Alquiler VALUES ('4', '4', '4', 80);
-- Ejemplo 5
INSERT INTO Alquiler VALUES ('5', '5', '5', 90);
-- ejemplo malo
INSERT INTO Alquiler VALUES ('5', '5', '5', 90,4);
--da error porque el precio es un int y no un float


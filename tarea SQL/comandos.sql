CREATE TABLE asistencia (
    id_asistencia INT IDENTITY(1,1) PRIMARY KEY, -- ID autoincrementable
    Carnet VARCHAR(20) NOT NULL, -- Llave foránea del estudiante
    fecha DATE NOT NULL, -- Fecha de la asistencia
    presente CHAR(1) NOT NULL CHECK (presente IN ('S', 'N')), -- 'S' = Sí, 'N' = No
    CONSTRAINT FK_asistencia_alumno FOREIGN KEY (Carnet) REFERENCES Tb_alumnos(carnet)
);


CREATE TABLE notas_finales (
    id_nota_final INT IDENTITY(1,1) PRIMARY KEY, -- ID autoincrementable
    Carnet VARCHAR(20) NOT NULL, -- Llave foránea del estudiante
    nota_final DECIMAL(5,2) NOT NULL, -- Nota final (ej. 87.50)
    CONSTRAINT FK_notaFinal_alumno FOREIGN KEY (Carnet) REFERENCES Tb_alumnos(carnet)
);

INSERT INTO asistencia (Carnet, fecha, presente) VALUES
('0905-10-1279', '2025-04-01', 'S'),
('0905-15-9622', '2025-04-01', 'N'),
('0905-15-14297', '2025-04-01', 'S'),
('0905-18-4689', '2025-04-01', 'S'),
('0905-19-6478', '2025-04-01', 'N');

INSERT INTO notas_finales (Carnet, nota_final) VALUES
('0905-10-1279', 88.75),
('0905-15-9622', 74.50),
('0905-15-14297', 91.00),
('0905-18-4689', 83.25),
('0905-19-6478', 69.00);

select *from tb_alumnos
update Tb_alumnos set seccion = 'C' where seccion = 'A'
update Tb_alumnos set seccion = 'A' where seccion = 'B'
update Tb_alumnos set seccion = 'B' where seccion = 'C'
select *from Tb_alumnos where seccion = 'A'

SELECT a.Estudiante, t.nota1, t.nota2, t.nota3, t.nota4
FROM Tb_alumnos a INNER JOIN tareas t ON a.carnet = t.carnet;

update notas_finales set nota_final = '89.99' where Carnet = '0905-19-6478'

delete from asistencia where id_asistencia = '4'



SELECT a.Estudiante, asi.fecha AS asistencia_mas_reciente,
       nf.nota_final
FROM Tb_alumnos a
LEFT JOIN (
    SELECT Carnet, MAX(fecha) AS fecha
    FROM asistencia
    GROUP BY Carnet
) ult_asi ON a.carnet = ult_asi.Carnet
LEFT JOIN asistencia asi ON a.carnet = asi.Carnet AND asi.fecha = ult_asi.fecha
LEFT JOIN notas_finales nf ON a.carnet = nf.Carnet;
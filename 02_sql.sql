
-- Eliminación previa de tablas para reconstruir


DROP TABLE IF EXISTS fact_incidencias;
DROP TABLE IF EXISTS fact_mantenimiento;
DROP TABLE IF EXISTS fact_viajes;

DROP TABLE IF EXISTS dim_conductor;
DROP TABLE IF EXISTS dim_vehiculo;
DROP TABLE IF EXISTS dim_parada;
DROP TABLE IF EXISTS dim_tarifa;
DROP TABLE IF EXISTS dim_linea;
DROP TABLE IF EXISTS dim_depot;


-- TABLAS DE DIMENSIÓN


CREATE TABLE dim_depot (
depot_id INTEGER PRIMARY KEY,
nombre VARCHAR(100),
barrio VARCHAR(100),
latitud DECIMAL(10,6),
longitud DECIMAL(10,6),
capacidad_vehiculos INTEGER
);

CREATE TABLE dim_linea (
linea_id INTEGER PRIMARY KEY,
codigo VARCHAR(20),
nombre VARCHAR(100),
tipo VARCHAR(50),
km_recorrido DECIMAL(10,2),
n_paradas INTEGER,
frecuencia_min INTEGER
);

CREATE TABLE dim_tarifa (
tarifa_id INTEGER PRIMARY KEY,
tipo_titulo VARCHAR(100),
categoria VARCHAR(100),
precio_eur DECIMAL(10,2),
es_abono BOOLEAN,
bonificado BOOLEAN
);

CREATE TABLE dim_parada (
parada_id INTEGER PRIMARY KEY,
nombre_parada VARCHAR(150),
barrio VARCHAR(100),
tipo VARCHAR(50),
latitud DECIMAL(10,6),
longitud DECIMAL(10,6),
accesible_silla BOOLEAN,
marquesina BOOLEAN,
panel_informacion BOOLEAN,
activa BOOLEAN
);

CREATE TABLE dim_vehiculo (
vehiculo_id INTEGER PRIMARY KEY,
matricula VARCHAR(20),
modelo VARCHAR(100),
combustible VARCHAR(50),
capacidad_sentados INTEGER,
capacidad_total INTEGER,
anno_fabricacion INTEGER,
anno_incorporacion INTEGER,
km_totales INTEGER,
depot_id INTEGER,
emisiones_co2_gkm DECIMAL(10,2),
en_servicio BOOLEAN,

```
FOREIGN KEY (depot_id)
    REFERENCES dim_depot(depot_id)
```

);

CREATE TABLE dim_conductor (
conductor_id INTEGER PRIMARY KEY,
nombre VARCHAR(100),
anno_incorporacion INTEGER,
antiguedad_anos DECIMAL(5,2),
turno_habitual VARCHAR(50),
depot_id INTEGER,
formacion VARCHAR(100),
licencia_tipo VARCHAR(50),
activo BOOLEAN,
ausencias_2024 INTEGER,

```
FOREIGN KEY (depot_id)
    REFERENCES dim_depot(depot_id)
```

);

-- TABLAS DE HECHOS

CREATE TABLE fact_viajes (

```
viaje_id INTEGER PRIMARY KEY,

linea_id INTEGER,
vehiculo_id INTEGER,
conductor_id INTEGER,

parada_origen_id INTEGER,
parada_destino_id INTEGER,

fecha DATE,
anno INTEGER,
mes INTEGER,

dia_semana VARCHAR(20),
es_festivo BOOLEAN,
franja_horaria VARCHAR(50),

hora_salida_prog TIME,
hora_salida_real TIME,
hora_llegada_real TIME,

retraso_salida_min INTEGER,
duracion_real_min INTEGER,

pasajeros_subidos INTEGER,
ocupacion_pct DECIMAL(6,3),

km_programados DECIMAL(10,2),
km_recorridos DECIMAL(10,2),

viaje_completado BOOLEAN,

consumo DECIMAL(10,2),

tarifa_predominante_id INTEGER,

FOREIGN KEY (linea_id)
    REFERENCES dim_linea(linea_id),

FOREIGN KEY (vehiculo_id)
    REFERENCES dim_vehiculo(vehiculo_id),

FOREIGN KEY (conductor_id)
    REFERENCES dim_conductor(conductor_id),

FOREIGN KEY (parada_origen_id)
    REFERENCES dim_parada(parada_id),

FOREIGN KEY (parada_destino_id)
    REFERENCES dim_parada(parada_id),

FOREIGN KEY (tarifa_predominante_id)
    REFERENCES dim_tarifa(tarifa_id)
```

);

CREATE TABLE fact_incidencias (

```
incidencia_id INTEGER PRIMARY KEY,

viaje_id INTEGER,
vehiculo_id INTEGER,
conductor_id INTEGER,
linea_id INTEGER,

fecha DATE,
anno INTEGER,
mes INTEGER,

hora_incidencia TIME,

tipo_incidencia VARCHAR(100),
categoria VARCHAR(100),
severidad VARCHAR(50),

requiere_retirada BOOLEAN,

duracion_resolucion_min INTEGER,

vehiculo_sustituto BOOLEAN,

coste_estimado_eur DECIMAL(12,2),

FOREIGN KEY (viaje_id)
    REFERENCES fact_viajes(viaje_id),

FOREIGN KEY (vehiculo_id)
    REFERENCES dim_vehiculo(vehiculo_id),

FOREIGN KEY (conductor_id)
    REFERENCES dim_conductor(conductor_id),

FOREIGN KEY (linea_id)
    REFERENCES dim_linea(linea_id)
```

);

CREATE TABLE fact_mantenimiento (

```
mantenimiento_id INTEGER PRIMARY KEY,

vehiculo_id INTEGER,
depot_id INTEGER,

fecha_entrada DATE,
fecha_salida DATE,

anno INTEGER,
mes INTEGER,

tipo_mantenimiento VARCHAR(100),
categoria VARCHAR(100),

es_correctivo BOOLEAN,

dias_fuera_servicio INTEGER,

km_en_revision INTEGER,

coste_eur DECIMAL(12,2),

proveedor VARCHAR(150),

garantia_meses INTEGER,

FOREIGN KEY (vehiculo_id)
    REFERENCES dim_vehiculo(vehiculo_id),

FOREIGN KEY (depot_id)
    REFERENCES dim_depot(depot_id)
```

);

-- CONSULTAS DE NEGOCIO


-- 1. ¿Qué líneas presentan mayor ocupación media?

SELECT
l.codigo,
l.nombre,
ROUND(AVG(v.ocupacion_pct) * 100,2) AS ocupacion_media_pct
FROM fact_viajes v
JOIN dim_linea l
ON v.linea_id = l.linea_id
GROUP BY l.codigo, l.nombre
ORDER BY ocupacion_media_pct DESC;

-- 2. ¿En qué franjas horarias se producen más retrasos?

SELECT
franja_horaria,
ROUND(AVG(retraso_salida_min),2) AS retraso_medio
FROM fact_viajes
WHERE retraso_salida_min <> -99
GROUP BY franja_horaria
ORDER BY retraso_medio DESC;

-- 3. ¿Qué líneas acumulan más viajes no completados?

SELECT
l.codigo,
l.nombre,
COUNT(*) AS viajes_no_completados
FROM fact_viajes v
JOIN dim_linea l
ON v.linea_id = l.linea_id
WHERE viaje_completado = FALSE
GROUP BY l.codigo, l.nombre
ORDER BY viajes_no_completados DESC;

-- 4. ¿Cuál es el consumo medio por tipo de combustible?

SELECT
ve.combustible,
ROUND(AVG(v.consumo),2) AS consumo_medio
FROM fact_viajes v
JOIN dim_vehiculo ve
ON v.vehiculo_id = ve.vehiculo_id
WHERE v.consumo IS NOT NULL
GROUP BY ve.combustible
ORDER BY consumo_medio DESC;

-- 5. ¿Qué severicios generan mayor coste económico?

SELECT
severidad,
COUNT(*) AS numero_incidencias,
ROUND(SUM(coste_estimado_eur),2) AS coste_total
FROM fact_incidencias
GROUP BY severidad
ORDER BY coste_total DESC;

-- 6. ¿Qué vehículos registran más incidencias?

SELECT
vehiculo_id,
COUNT(*) AS total_incidencias
FROM fact_incidencias
GROUP BY vehiculo_id
ORDER BY total_incidencias DESC;

-- 7. ¿Qué vehículos generan mayor coste de mantenimiento?

SELECT
vehiculo_id,
ROUND(SUM(coste_eur),2) AS coste_total_mantenimiento
FROM fact_mantenimiento
GROUP BY vehiculo_id
ORDER BY coste_total_mantenimiento DESC;

-- 8. ¿Cómo evoluciona el volumen de viajes por año?

SELECT
anno,
COUNT(*) AS total_viajes,
ROUND(AVG(ocupacion_pct) * 100,2) AS ocupacion_media
FROM fact_viajes
GROUP BY anno
ORDER BY anno;

# 03 Gobierno del dato - MetroBus Analytics

## 1. Diccionario de datos

En esta sección se documentan las tablas utilizadas en el modelo analítico, indicando el tipo de dato, descripción funcional, valores esperados y observaciones de calidad detectadas.

### Tabla: `fact_viajes`

| Campo                  | Tipo de dato | Descripción                                               | Valores válidos o rango esperado                           | Observaciones de calidad         |
| ---------------------- | ------------ | --------------------------------------------------------- | ---------------------------------------------------------- | -------------------------------- |
| viaje_id               | int64        | Identificador único del viaje.                            | 1 - 50000                                                  | Sin incidencias destacadas.      |
| linea_id               | int64        | Identificador de la línea asociada.                       | 1 - 10                                                     | Sin incidencias destacadas.      |
| vehiculo_id            | int64        | Identificador del vehículo.                               | 1 - 42                                                     | Sin incidencias destacadas.      |
| conductor_id           | int64        | Identificador del conductor.                              | 1 - 28                                                     | Sin incidencias destacadas.      |
| parada_origen_id       | int64        | Campo `parada_origen_id` de la tabla `fact_viajes`.       | 1 - 40                                                     | Sin incidencias destacadas.      |
| parada_destino_id      | int64        | Campo `parada_destino_id` de la tabla `fact_viajes`.      | 41 - 120                                                   | Sin incidencias destacadas.      |
| fecha                  | str          | Fecha del registro.                                       | 2023-08-14, 2024-05-20, 2023-08-15, 2022-03-23, 2022-03-24 | Sin incidencias destacadas.      |
| anno                   | int64        | Año del registro.                                         | 2022 - 2024                                                | Sin incidencias destacadas.      |
| mes                    | int64        | Mes del registro.                                         | 1 - 12                                                     | Sin incidencias destacadas.      |
| dia_semana             | str          | Campo `dia_semana` de la tabla `fact_viajes`.             | Monday, Tuesday, Wednesday, Thursday, Friday               | Sin incidencias destacadas.      |
| es_festivo             | bool         | Campo `es_festivo` de la tabla `fact_viajes`.             | False - True                                               | Sin incidencias destacadas.      |
| franja_horaria         | str          | Campo `franja_horaria` de la tabla `fact_viajes`.         | Tarde punta, Manana punta, Valle manana, Tarde, Noche      | Sin incidencias destacadas.      |
| hora_salida_prog       | str          | Campo `hora_salida_prog` de la tabla `fact_viajes`.       | 17:50, 07:10, 12:30, 20:50, 18:10                          | Sin incidencias destacadas.      |
| hora_salida_real       | str          | Campo `hora_salida_real` de la tabla `fact_viajes`.       | 18:09, 07:23, 12:30, 20:50, 18:18                          | Sin incidencias destacadas.      |
| hora_llegada_real      | str          | Campo `hora_llegada_real` de la tabla `fact_viajes`.      | 19:22, 08:30, 13:05, 21:36, 18:50                          | Sin incidencias destacadas.      |
| retraso_salida_min     | int64        | Minutos de retraso en la salida.                          | -99 - 50                                                   | Se detectó el valor atípico -99. |
| duracion_real_min      | int64        | Campo `duracion_real_min` de la tabla `fact_viajes`.      | 25 - 129                                                   | Sin incidencias destacadas.      |
| pasajeros_subidos      | float64      | Campo `pasajeros_subidos` de la tabla `fact_viajes`.      | 1.0 - 184.0                                                | Contiene 40 valores nulos.       |
| ocupacion_pct          | float64      | Porcentaje de ocupación del vehículo.                     | 0.005 - 0.995                                              | Sin incidencias destacadas.      |
| km_programados         | float64      | Campo `km_programados` de la tabla `fact_viajes`.         | 7.3 - 23.5                                                 | Sin incidencias destacadas.      |
| km_recorridos          | float64      | Campo `km_recorridos` de la tabla `fact_viajes`.          | 2.2 - 23.5                                                 | Sin incidencias destacadas.      |
| viaje_completado       | bool         | Campo `viaje_completado` de la tabla `fact_viajes`.       | False - True                                               | Sin incidencias destacadas.      |
| consumo                | float64      | Consumo registrado durante el viaje.                      | 0.55 - 32.86                                               | Contiene 1065 valores nulos.     |
| tarifa_predominante_id | int64        | Campo `tarifa_predominante_id` de la tabla `fact_viajes`. | 1 - 9                                                      | Sin incidencias destacadas.      |

### Tabla: `fact_incidencias`

| Campo                   | Tipo de dato | Descripción                                                     | Valores válidos o rango esperado                                               | Observaciones de calidad    |
| ----------------------- | ------------ | --------------------------------------------------------------- | ------------------------------------------------------------------------------ | --------------------------- |
| incidencia_id           | int64        | Campo `incidencia_id` de la tabla `fact_incidencias`.           | 1 - 4000                                                                       | Sin incidencias destacadas. |
| viaje_id                | int64        | Identificador único del viaje.                                  | 5 - 49989                                                                      | Sin incidencias destacadas. |
| vehiculo_id             | int64        | Identificador del vehículo.                                     | 1 - 42                                                                         | Sin incidencias destacadas. |
| conductor_id            | int64        | Identificador del conductor.                                    | 1 - 28                                                                         | Sin incidencias destacadas. |
| linea_id                | int64        | Identificador de la línea asociada.                             | 1 - 10                                                                         | Sin incidencias destacadas. |
| fecha                   | str          | Fecha del registro.                                             | 2022-06-01, 2023-02-16, 2022-01-20, 2023-01-16, 2023-01-08                     | Sin incidencias destacadas. |
| anno                    | int64        | Año del registro.                                               | 2022 - 2024                                                                    | Sin incidencias destacadas. |
| mes                     | int64        | Mes del registro.                                               | 1 - 12                                                                         | Sin incidencias destacadas. |
| hora_incidencia         | str          | Campo `hora_incidencia` de la tabla `fact_incidencias`.         | 19:11, 20:42, 06:21, 02:30, 14:51                                              | Sin incidencias destacadas. |
| tipo_incidencia         | str          | Campo `tipo_incidencia` de la tabla `fact_incidencias`.         | Huelga parcial, Fallo electrico, Accidente leve, Vandalismo, Retencion trafico | Sin incidencias destacadas. |
| categoria               | str          | Categoría del registro.                                         | Operacional, Vehiculo, Seguridad, Externo, Servicio                            | Sin incidencias destacadas. |
| severidad               | str          | Campo `severidad` de la tabla `fact_incidencias`.               | Alta, Media, Baja, Critica                                                     | Sin incidencias destacadas. |
| requiere_retirada       | bool         | Campo `requiere_retirada` de la tabla `fact_incidencias`.       | False - True                                                                   | Sin incidencias destacadas. |
| duracion_resolucion_min | int64        | Campo `duracion_resolucion_min` de la tabla `fact_incidencias`. | 5 - 333                                                                        | Sin incidencias destacadas. |
| vehiculo_sustituto      | bool         | Campo `vehiculo_sustituto` de la tabla `fact_incidencias`.      | False - True                                                                   | Sin incidencias destacadas. |
| coste_estimado_eur      | float64      | Coste estimado de la incidencia.                                | 0.0 - 14985.58                                                                 | Sin incidencias destacadas. |

### Tabla: `fact_mantenimiento`

| Campo               | Tipo de dato | Descripción                                                   | Valores válidos o rango esperado                                                           | Observaciones de calidad    |
| ------------------- | ------------ | ------------------------------------------------------------- | ------------------------------------------------------------------------------------------ | --------------------------- |
| mantenimiento_id    | int64        | Campo `mantenimiento_id` de la tabla `fact_mantenimiento`.    | 1 - 876                                                                                    | Sin incidencias destacadas. |
| vehiculo_id         | int64        | Identificador del vehículo.                                   | 1 - 45                                                                                     | Sin incidencias destacadas. |
| depot_id            | int64        | Campo `depot_id` de la tabla `fact_mantenimiento`.            | 1 - 3                                                                                      | Sin incidencias destacadas. |
| fecha_entrada       | str          | Campo `fecha_entrada` de la tabla `fact_mantenimiento`.       | 2024-07-24, 2023-02-08, 2024-10-28, 2022-08-01, 2024-12-09                                 | Sin incidencias destacadas. |
| fecha_salida        | str          | Campo `fecha_salida` de la tabla `fact_mantenimiento`.        | 2024-07-25, 2023-02-09, 2024-10-29, 2022-08-03, 2024-12-10                                 | Sin incidencias destacadas. |
| anno                | int64        | Año del registro.                                             | 2022 - 2025                                                                                | Sin incidencias destacadas. |
| mes                 | int64        | Mes del registro.                                             | 1 - 12                                                                                     | Sin incidencias destacadas. |
| tipo_mantenimiento  | str          | Campo `tipo_mantenimiento` de la tabla `fact_mantenimiento`.  | Cambio aceite, Cambio neumaticos, Reparacion clima, Revision bateria, ITV e Inspeccion     | Sin incidencias destacadas. |
| categoria           | str          | Categoría del registro.                                       | Preventivo, Correctivo, Legal, Estetico                                                    | Contiene 15 valores nulos.  |
| es_correctivo       | bool         | Campo `es_correctivo` de la tabla `fact_mantenimiento`.       | False - True                                                                               | Sin incidencias destacadas. |
| dias_fuera_servicio | int64        | Campo `dias_fuera_servicio` de la tabla `fact_mantenimiento`. | 0 - 10                                                                                     | Sin incidencias destacadas. |
| km_en_revision      | int64        | Campo `km_en_revision` de la tabla `fact_mantenimiento`.      | 10222 - 549625                                                                             | Sin incidencias destacadas. |
| coste_eur           | float64      | Coste asociado al mantenimiento.                              | -4083.03 - 4987.72                                                                         | Sin incidencias destacadas. |
| proveedor           | str          | Campo `proveedor` de la tabla `fact_mantenimiento`.           | TallerBus Norte, Taller Oficial Mercedes, FlotaService, ManteAuto S.L., Taller Oficial MAN | Sin incidencias destacadas. |
| garantia_meses      | int64        | Campo `garantia_meses` de la tabla `fact_mantenimiento`.      | 0 - 12                                                                                     | Sin incidencias destacadas. |

### Tabla: `dim_conductor`

| Campo              | Tipo de dato | Descripción                                             | Valores válidos o rango esperado                                        | Observaciones de calidad    |
| ------------------ | ------------ | ------------------------------------------------------- | ----------------------------------------------------------------------- | --------------------------- |
| conductor_id       | int64        | Identificador del conductor.                            | 1 - 30                                                                  | Sin incidencias destacadas. |
| nombre             | str          | Campo `nombre` de la tabla `dim_conductor`.             | Carlos Garcia, Maria Lopez, Juan Martinez, Ana Fernandez, Pedro Sanchez | Sin incidencias destacadas. |
| anno_incorporacion | int64        | Campo `anno_incorporacion` de la tabla `dim_conductor`. | 2005 - 2023                                                             | Sin incidencias destacadas. |
| antiguedad_anos    | float64      | Campo `antiguedad_anos` de la tabla `dim_conductor`.    | 1.0 - 19.0                                                              | Contiene 1 valores nulos.   |
| turno_habitual     | str          | Campo `turno_habitual` de la tabla `dim_conductor`.     | Partido, Noche (22-06h), Manana (06-14h), manana, Tarde (14-22h)        | Sin incidencias destacadas. |
| depot_id           | int64        | Campo `depot_id` de la tabla `dim_conductor`.           | 1 - 3                                                                   | Sin incidencias destacadas. |
| formacion          | str          | Campo `formacion` de la tabla `dim_conductor`.          | Basica, Completa, Basica + Articulado, Basica + Electrico               | Sin incidencias destacadas. |
| licencia_tipo      | str          | Campo `licencia_tipo` de la tabla `dim_conductor`.      | D, D+E                                                                  | Sin incidencias destacadas. |
| activo             | bool         | Campo `activo` de la tabla `dim_conductor`.             | False - True                                                            | Sin incidencias destacadas. |
| ausencias_2024     | int64        | Campo `ausencias_2024` de la tabla `dim_conductor`.     | 0 - 15                                                                  | Sin incidencias destacadas. |

### Tabla: `dim_depot`

| Campo               | Tipo de dato | Descripción                                          | Valores válidos o rango esperado            | Observaciones de calidad    |
| ------------------- | ------------ | ---------------------------------------------------- | ------------------------------------------- | --------------------------- |
| depot_id            | int64        | Campo `depot_id` de la tabla `dim_depot`.            | 1 - 3                                       | Sin incidencias destacadas. |
| nombre              | str          | Campo `nombre` de la tabla `dim_depot`.              | Cochera Norte, Cochera Central, Cochera Sur | Sin incidencias destacadas. |
| barrio              | str          | Campo `barrio` de la tabla `dim_depot`.              | Barrio Norte, Centro, Barrio Sur            | Sin incidencias destacadas. |
| latitud             | float64      | Campo `latitud` de la tabla `dim_depot`.             | 40.395 - 40.44                              | Sin incidencias destacadas. |
| longitud            | float64      | Campo `longitud` de la tabla `dim_depot`.            | -3.72 - -3.695                              | Sin incidencias destacadas. |
| capacidad_vehiculos | int64        | Campo `capacidad_vehiculos` de la tabla `dim_depot`. | 12 - 20                                     | Sin incidencias destacadas. |

### Tabla: `dim_linea`

| Campo          | Tipo de dato | Descripción                                     | Valores válidos o rango esperado                                                                                    | Observaciones de calidad    |
| -------------- | ------------ | ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | --------------------------- |
| linea_id       | int64        | Identificador de la línea asociada.             | 1 - 10                                                                                                              | Sin incidencias destacadas. |
| codigo         | str          | Campo `codigo` de la tabla `dim_linea`.         | L1, L2, L3, L4, L5                                                                                                  | Sin incidencias destacadas. |
| nombre         | str          | Campo `nombre` de la tabla `dim_linea`.         | Centro - Aeropuerto, Universidad - Hospital, Barrio Norte - Estacion, Poligono Industrial - Centro, Circular Centro | Sin incidencias destacadas. |
| tipo           | str          | Campo `tipo` de la tabla `dim_linea`.           | Urbana, Interurbana, Nocturna                                                                                       | Sin incidencias destacadas. |
| km_recorrido   | float64      | Campo `km_recorrido` de la tabla `dim_linea`.   | 7.3 - 23.5                                                                                                          | Sin incidencias destacadas. |
| n_paradas      | int64        | Campo `n_paradas` de la tabla `dim_linea`.      | 10 - 32                                                                                                             | Sin incidencias destacadas. |
| frecuencia_min | int64        | Campo `frecuencia_min` de la tabla `dim_linea`. | 6 - 45                                                                                                              | Sin incidencias destacadas. |

### Tabla: `dim_parada`

| Campo             | Tipo de dato | Descripción                                         | Valores válidos o rango esperado                                                                       | Observaciones de calidad    |
| ----------------- | ------------ | --------------------------------------------------- | ------------------------------------------------------------------------------------------------------ | --------------------------- |
| parada_id         | int64        | Campo `parada_id` de la tabla `dim_parada`.         | 1 - 120                                                                                                | Sin incidencias destacadas. |
| nombre_parada     | str          | Campo `nombre_parada` de la tabla `dim_parada`.     | Parada Barrio Norte 1, Parada Barrio Sur 2, Parada Universidad 3, Parada Hospital 4, Parada Poligono 5 | Sin incidencias destacadas. |
| barrio            | str          | Campo `barrio` de la tabla `dim_parada`.            | Barrio Norte, Barrio Sur, Universidad, Hospital, centro                                                | Sin incidencias destacadas. |
| tipo              | str          | Campo `tipo` de la tabla `dim_parada`.              | Intermedia, Intercambiador, Cabecera                                                                   | Sin incidencias destacadas. |
| latitud           | float64      | Campo `latitud` de la tabla `dim_parada`.           | 40.387789 - 999.0                                                                                      | Contiene 1 valores nulos.   |
| longitud          | float64      | Campo `longitud` de la tabla `dim_parada`.          | -3.751602 - -3.658867                                                                                  | Sin incidencias destacadas. |
| accesible_silla   | object       | Campo `accesible_silla` de la tabla `dim_parada`.   | True, False                                                                                            | Contiene 1 valores nulos.   |
| marquesina        | bool         | Campo `marquesina` de la tabla `dim_parada`.        | False - True                                                                                           | Sin incidencias destacadas. |
| panel_informacion | bool         | Campo `panel_informacion` de la tabla `dim_parada`. | False - True                                                                                           | Sin incidencias destacadas. |
| activa            | bool         | Campo `activa` de la tabla `dim_parada`.            | False - True                                                                                           | Sin incidencias destacadas. |

### Tabla: `dim_tarifa`

| Campo       | Tipo de dato | Descripción                                   | Valores válidos o rango esperado                                      | Observaciones de calidad    |
| ----------- | ------------ | --------------------------------------------- | --------------------------------------------------------------------- | --------------------------- |
| tarifa_id   | int64        | Campo `tarifa_id` de la tabla `dim_tarifa`.   | 1 - 9                                                                 | Sin incidencias destacadas. |
| tipo_titulo | str          | Campo `tipo_titulo` de la tabla `dim_tarifa`. | Ordinario, Bono 10 Viajes, Abono Mensual, Abono Joven, Abono Jubilado | Sin incidencias destacadas. |
| categoria   | str          | Categoría del registro.                       | Adulto, Joven, Jubilado, Social, Turista                              | Sin incidencias destacadas. |
| precio_eur  | float64      | Campo `precio_eur` de la tabla `dim_tarifa`.  | 0.0 - 10.0                                                            | Sin incidencias destacadas. |
| es_abono    | bool         | Campo `es_abono` de la tabla `dim_tarifa`.    | False - True                                                          | Sin incidencias destacadas. |
| bonificado  | bool         | Campo `bonificado` de la tabla `dim_tarifa`.  | False - True                                                          | Sin incidencias destacadas. |

### Tabla: `dim_vehiculo`

| Campo              | Tipo de dato | Descripción                                            | Valores válidos o rango esperado                                                        | Observaciones de calidad    |
| ------------------ | ------------ | ------------------------------------------------------ | --------------------------------------------------------------------------------------- | --------------------------- |
| vehiculo_id        | int64        | Identificador del vehículo.                            | 1 - 45                                                                                  | Sin incidencias destacadas. |
| matricula          | str          | Campo `matricula` de la tabla `dim_vehiculo`.          | 6001 BUS, 6002 BUS, 6003 BUS, 6004 BUS, 6005 BUS                                        | Sin incidencias destacadas. |
| modelo             | str          | Campo `modelo` de la tabla `dim_vehiculo`.             | Mercedes-Benz Citaro, Iveco Urbanway, Solaris Urbino 12, Solaris Urbino 18, BYD eBus-12 | Sin incidencias destacadas. |
| combustible        | str          | Tipo de combustible del vehículo.                      | Diesel, diesel, Electrico, Hibrido                                                      | Contiene 1 valores nulos.   |
| capacidad_sentados | int64        | Campo `capacidad_sentados` de la tabla `dim_vehiculo`. | 85 - 145                                                                                | Sin incidencias destacadas. |
| capacidad_total    | int64        | Campo `capacidad_total` de la tabla `dim_vehiculo`.    | 125 - 185                                                                               | Sin incidencias destacadas. |
| anno_fabricacion   | int64        | Campo `anno_fabricacion` de la tabla `dim_vehiculo`.   | 2014 - 2099                                                                             | Sin incidencias destacadas. |
| anno_incorporacion | int64        | Campo `anno_incorporacion` de la tabla `dim_vehiculo`. | 2015 - 2025                                                                             | Sin incidencias destacadas. |
| km_totales         | int64        | Campo `km_totales` de la tabla `dim_vehiculo`.         | -500 - 596622                                                                           | Sin incidencias destacadas. |
| depot_id           | int64        | Campo `depot_id` de la tabla `dim_vehiculo`.           | 1 - 3                                                                                   | Sin incidencias destacadas. |
| emisiones_co2_gkm  | int64        | Campo `emisiones_co2_gkm` de la tabla `dim_vehiculo`.  | 0 - 140                                                                                 | Sin incidencias destacadas. |
| en_servicio        | bool         | Campo `en_servicio` de la tabla `dim_vehiculo`.        | False - True                                                                            | Sin incidencias destacadas. |

## 2. Registro de decisiones de limpieza - Data Quality Log

| Tabla              | Campo              | Tipo de problema  | Frecuencia | Decisión tomada                                       | Justificación                                                                     |
| ------------------ | ------------------ | ----------------- | ---------: | ----------------------------------------------------- | --------------------------------------------------------------------------------- |
| fact_viajes        | consumo            | Valores nulos     |       1065 | Mantener como nulo y excluir de cálculos de consumo   | No es posible imputar el consumo sin información adicional fiable.                |
| fact_viajes        | pasajeros_subidos  | Valores nulos     |         40 | Mantener como nulo o excluir en análisis de pasajeros | El porcentaje es muy reducido y no compromete el análisis global.                 |
| fact_viajes        | retraso_salida_min | Valor atípico -99 |         80 | Excluir de indicadores de puntualidad                 | Se considera un código de error o valor no operativo.                             |
| fact_mantenimiento | categoria          | Valores nulos     |         15 | Clasificar como Sin categoría                         | Permite conservar los registros históricos.                                       |
| dim_conductor      | antiguedad_anos    | Valor nulo        |          1 | Recalcular desde anno_incorporacion si es posible     | Mantiene la coherencia temporal del dato.                                         |
| dim_parada         | latitud            | Valor nulo        |          1 | Mantener como nulo                                    | No afecta al análisis operativo principal.                                        |
| dim_parada         | accesible_silla    | Valor nulo        |          1 | Clasificar como Desconocido                           | Evita confundir dato faltante con valor falso.                                    |
| dim_vehiculo       | combustible        | Valor nulo        |          1 | Clasificar como Desconocido                           | Es necesario para no perder trazabilidad en análisis de consumo y sostenibilidad. |

## 3. Definición formal de KPIs

| KPI                              | Fórmula exacta                                   | Fuente de datos                     | Criterios de exclusión           | Responsable de negocio               |
| -------------------------------- | ------------------------------------------------ | ----------------------------------- | -------------------------------- | ------------------------------------ |
| Ocupación media (%)              | AVG(ocupacion_pct) \* 100                        | fact_viajes.ocupacion_pct           | Ninguna                          | Responsable de Operaciones           |
| Retraso medio de salida          | AVG(retraso_salida_min)                          | fact_viajes.retraso_salida_min      | Excluir retraso_salida_min = -99 | Responsable de Explotación           |
| Tasa de viajes completados (%)   | SUM(viaje_completado) / COUNT(viaje_id) \* 100   | fact_viajes.viaje_completado        | Ninguna                          | Responsable de Operaciones           |
| Coste total de incidencias (€)   | SUM(coste_estimado_eur)                          | fact_incidencias.coste_estimado_eur | Ninguna                          | Dirección de Operaciones             |
| Coste total de mantenimiento (€) | SUM(coste_eur)                                   | fact_mantenimiento.coste_eur        | Ninguna                          | Responsable de Flota                 |
| Consumo medio                    | AVG(consumo)                                     | fact_viajes.consumo                 | Excluir valores nulos            | Responsable de Sostenibilidad        |
| Incidencias críticas             | COUNT(incidencia_id) WHERE severidad = 'Critica' | fact_incidencias.severidad          | Ninguna                          | Responsable de Seguridad Operacional |
| Viajes no completados            | COUNT(viaje_id) WHERE viaje_completado = 0       | fact_viajes.viaje_completado        | Ninguna                          | Responsable de Operaciones           |

Explicación de los resultados obtenidos.

Consulta 1:Ocupación media por línea
la ocupación es muy similiar en casi todas las líneas diurnas, entorno al 45%. Las líneas con más ocupación son L4 Y L9.
La línea con menos ocupación es la nocuturna N1, existe una menor ocupación y podría realizarse un anális más detallado para adecuar las franjas horarias y frecuencias.

Consulta2: Retrasos medios por franja horaria
Los mayores retrasos se producen las horas puntas de la mañana y la tarde. En cambio se observa que si se disminuye la demanda, el retraso también se dismminuye.
Durante la madrugada apenas existen los retrasos, cosa lógica por la menor demanda, por lo que se puede determinar que el volumen de viajeros influye en la puntualidad.

Consulta 3: Líneas con más viajes no completados
Existen viajes no completados entre diferentes líneas. Las que presetan valores un poco mas superiores son las siguientes:
La línea Barrio Sur - Universidad registra el mayor número de interrupciones, seguida por Barrio Norte - Estación y Universidad - Hospital.

Consulta 4: Consumo medio por combustible
Los vehículos híbridos presentan el consumo mas reducido, mientras que los eléctricos lo tienen mas elevado.
Aunque estos resultados pueden estar influidos por que la unidad de medida no sea la misma y por lo cual no pueda ser comparable.
Además se encontraron registros sin información de combustible.

Consulta 5: Coste económico por incidencia
las incidencias críticas tienen mayor impacto económico, superando con gran diferencia al resto de las categorías. Aunque se producen menos.

Consulta 6:Vehículos con más incidencias
Se producen incidencias en casi todos los vehiculos, aunque algunos registran un poco más no existe ningun vehiculo que presente valores muy superiores. El vehículo 9 encabeza la clasificación, seguido por los vehículos 10 y 30, pero las diferencias respecto al resto son pequeñas.

Consulta 7: Vehículo con mas coste de mantenimiento.
El vehículo 14 destaca como el más costoso, superando los 30.000 euros en mantenimiento . Esto podría deberse a factores como la antigüedad, el kilometraje o la intensidad de uso. Identificar estos casos permite priorizar revisiones más detalladas y apoyar futuras decisiones de renovación de flota.

Consulta 8: Evolución anual de los viajes
El número de viajes es muy estable, sin apenas variaciones importantes. Se observa un menor número en 2023.

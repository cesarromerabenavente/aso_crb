$muestrasCPU = @()

$muestrasCPU = @(15, 12, 18, 20, 45, 88, 95, 99, 100, 98, 55, 22, 15, 10, 12, 14, 95, 99, 100, 10)

$suma = 0

$count = $muestrasCPU.Count

for ($i = 0; $i -lt $count; $i++) {

    $suma = $suma + $muestrasCPU[$i]

    Write-Host "Paso $i : Suma total momentanea: $suma"


}

$media = ($suma / $count)

$suma

$media

Write-Host "
=== INFORME DE RENDIMIENTO ===
Muestras analizadas: $Count

RESULTADOS DEL ANALISIS:
- Carga Promedio: 46.1 %
- Pico Maximo: 100 %
- Incidentes Criticos (>90%): 6

DIAGNOSTICO:
[RECOMENDACION] NECESARIO UPGRADE DE HARDWARE
"
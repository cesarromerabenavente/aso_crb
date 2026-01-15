$muestrasCPU = @()

$muestrasCPU = @(15, 12, 18, 20, 45, 88, 95, 99, 100, 98, 55, 22, 15, 10, 12, 14, 95, 99, 100, 10)

$suma = 0

$count = $muestrasCPU.Count

$max = 0

$reco = ""

$contador = 0

for ($i = 0; $i -lt $count; $i++) {

    $suma = $suma + $muestrasCPU[$i]

}

$media = ($suma / $count)

for ($i = 0; $i -lt $count; $i++) {

    for ($j = 0; $j -lt $count; $j++) {

        if ($muestrasCPU[$i] -gt $muestrasCPU[$j]) {
            $max = $muestrasCPU[$i]
        }

    }   

}

for ($i = 0; $i -lt $count; $i++) {

    if ($muestrasCPU[$i] -gt 90) {
            $contador++
    }

}

if ($media -gt 70) {
    $reco = "NECESARIO UPGRADE DE HARDWARE."
} elseif ($contador -gt 3) {
    $reco = "NECESARIO UPGRADE DE HARDWARE."
} else {
    $reco = "FALSA ALARMA. EL SERVIDOR AGUANTA."
}

Write-Host "
=== INFORME DE RENDIMIENTO ===
Muestras analizadas: $count

RESULTADOS DEL ANALISIS:
- Carga Promedio: $media %
- Pico Maximo: $max %
- Incidentes Criticos (>90%): $contador

DIAGNOSTICO:
[RECOMENDACION] $reco
"
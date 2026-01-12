$kbsRequeridos = @("KB500123", "KB409999", "KB890830", "KB500556", "KB500321", "KB999999")

$kbsInstalados = @("KB100000", "KB500556", "KB409999", "KB100001", "KB890830", "KB200022")

$kbsFaltantes = @()

$kbsExtra = @()

$contadorReq = 0

$contadorIns = 0

$contadorYaInstalados = 0

foreach ($itemReq in $kbsRequeridos) {

    if ($itemReq -notin $kbsInstalados) {
        $kbsFaltantes += $itemReq
    } 

    $contadorReq = $contadorReq + 1

}

foreach ($itemIns in $kbsInstalados) {

    if ($itemIns -in $kbsRequeridos) {
        $contadorYaInstalados = $contadorYaInstalados + 1
    } else {
        $kbsExtra += $itemIns
    }

    $contadorIns = $contadorIns +1

}

$porcentaje = ($contadorYaInstalados / $contadorReq) * 100

Write-Host "
=== AUDITORIA DE SEGURIDAD ===
Total Requeridos: $contadorReq
Total Instalados: $contadorIns

ESTADO DE CUMPLIMIENTO: $porcentaje%

[URGENTE] Parches Faltantes:
$($kbsFaltantes -join ', ')

[INFO] Parches 'Extra' instalados (No criticos):
$($kbsExtra -join ' - ')
"
$kbsRequeridos = @("KB500123", "KB409999", "KB890830", "KB500556", "KB500321", "KB999999")

$kbsInstalados = @("KB100000", "KB500556", "KB409999", "KB100001", "KB890830", "KB200022")

$kbsFaltantes = @()

$kbsExtra = @()

$contadorReq = 0

$contadorIns = 0

foreach ($itemReq in $kbsRequeridos) {

    if ($itemReq -in $kbsInstalados) {
        $contadorIns = $contadorIns +1
    } else {
        $kbsFaltantes += $itemReq
    }

    $contadorReq = $contadorReq + 1

}

foreach ($itemIns in $kbsInstalados) {

    if ($itemIns -notin $kbsRequeridos) {
        $kbsExtra += $itemIns
    } 

}

$porcentaje = ($contadorIns / $contadorReq) * 100

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
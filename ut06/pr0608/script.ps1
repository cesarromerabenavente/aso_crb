$kbsRequeridos = @("KB500123", "KB409999", "KB890830", "KB500556", "KB500321", "KB999999")

$kbsInstalados = @("KB100000", "KB500556", "KB409999", "KB100001", "KB890830", "KB200022")

$kbsFaltantes = @()

$kbsExtra = @()

foreach ($itemReq in $kbsRequeridos) {

    if ($itemReq -in $kbsInstalados) {
        Write-Host "El parche $itemReq ya esta instalado"
    } else {
        Write-Host "El parche $itemReq NO esta instalado"
        $kbsFaltantes += $itemReq
    }

}

foreach ($itemIns in $kbsInstalados) {

    if ($itemIns -in $kbsRequeridos) {
        Write-Host "El parche previamente instalado $itemIns era requerido"
    } else {
        Write-Host "El parche previamente instalado $itemIns NO era requerido"
        $kbsExtra += $itemIns
    }

}


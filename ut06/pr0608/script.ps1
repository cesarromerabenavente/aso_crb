$kbsRequeridos = @("KB500123", "KB409999", "KB890830", "KB500556", "KB500321", "KB999999")

$kbsInstalados = @("KB100000", "KB500556", "KB409999", "KB100001", "KB890830", "KB200022")

$kbsFaltantes = @()

foreach ($itemReq in $kbsRequeridos) {

    if ($itemReq -in $kbsInstalados) {
        Write-Host "El parche $itemReq ya esta instalado"
    } else {
        Write-Host "El parche $itemReq no esta instalado"
        $kbsFaltantes += $itemReq
    }

}
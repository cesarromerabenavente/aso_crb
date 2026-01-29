# Un acceso es sospechoso si el usuario intenta conectarse a la VPN pero su estado en RRHH es "BAJA" o "SUSPENDIDO"

# usuario de red: primera letra del nombre + primer apellido, todo en minuscula

$rrhhRaw = Get-Content -Path C:\ASO\EXAMENCESAR\hr_status_raw.txt

$rrhhProcesado = foreach ($linea in $rrhhRaw){

    $partes = $linea -split '\|'

    $nombrerrhh = $partes[1].Split(" ")[0].ToLower().Trim()
    $apellidorrhh = $partes[1].Split(" ")[1].ToLower().Trim()

    $usuarioNormalizado = $nombrerrhh.Substring(0,1) + $apellidorrhh

    $estadorrhh = $partes[2].Trim()


    [PSCustomObject]@{
        NombreUsuariorrhh  = $usuarioNormalizado
    }
}

$rrhhProcesado | Format-Table -Autosize




$vpnRaw = Get-Content -Path C:\ASO\EXAMENCESAR\vpn_logs_raw.txt

$vpnProcesado = foreach ($linea in $vpnRaw){

    $partes = $linea -split '#'

    if ($partes[2].Contains("invitado_externo")) { continue }


    $usuarioVpn = $partes[2].Replace('@', '\')

    if ($partes[2].Contains("m.smith")) { 
        $usuarioVpn = $partes[2].Split('@')[0]
    }
    else {$usuarioVpn = $partes[2].Split('\')[1]}

    $usuarioVpnFinal = $usuarioVpn.Replace('.','')


    $fechaLimpia = $partes[1].Replace('_', ' ').Replace('-', '/')
    $timeStamp   = (Get-Date $fechaLimpia).ToString("yyyy-MM-dd HH:mm")


    [PSCustomObject]@{
        NombreUsuariovpn  = $usuarioVpnFinal
        Fechavpn = $timeStamp
    }


}

$vpnProcesado | Format-Table -Autosize


$vpnComparar = foreach ($linea in $vpnProcesado){ 

    [PSCustomObject]@{
        FechaHora_ISO         = 1
        UsuarioIP_Origen     = 2
        Estado_RRHH          = 3
        Tipo_Incidente       = 4

}

}

$vpnComparar | Export-Csv -Path "Reporte_Incidentes.csv"
$vpnComparar | Format-Table -Autosize

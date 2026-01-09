$nuevosempleadosraw = Get-Content -Path C:\ASO\ut06\pr0607\nuevos_empleados_raw.txt

$nuevosEmpleadosProcesados = foreach ($linea in $nuevosempleadosraw){

    $partes = $linea -split '\|'

    # Nombre y apellidos

    $nombre = $partes[0].split(",")[1]
    $apellidos = $partes[0].split(",")[0]

    $nombreApellidos = (Get-Culture).TextInfo.ToTitleCase("$nombre $apellidos".ToLower())

    # Usuario

    $parteNombre = $nombre.Trim().Substring(0,1).ToLower()

    $apellidoLimpio = $apellidos.Split(" ")[0].Replace("'","").Trim()

    $largoCorte = [Math]::Min(6, $apellidoLimpio.Length)
    $parteApellido = $apellidoLimpio.Substring(0, $largoCorte).ToLower()

    $nombreUsuario = $parteNombre + $parteApellido

    # Correo Electrónico

    $nombreCorreo = ($nombre.Trim() + "." + $apellidos).ToLower().Replace(" ",".")

    $nombreCorreoFinal = ($nombreCorreo + "@techiberia.com")

    # Departamento

    $departamentoRaw = $partes[1].Split("-")[1].Replace("_"," ").ToLower()

    $departamentoFinal = (Get-Culture).TextInfo.ToTitleCase("$departamentoRaw")

    # Password

    $anio = $partes[2].Split("/")[0]

    $PasswordFinal = ("ChangeMe" + $anio + "!")

    [PSCustomObject]@{
        NombreCompleto  = $nombreApellidos
        Usuario         = $nombreUsuario
        Email           = $nombreCorreoFinal
        Departamento    = $departamentoFinal
        PasswordInicial = $PasswordFinal
    }
}

$nuevosEmpleadosProcesados | Export-Csv -Path "usuarios_importar.csv"
$nuevosEmpleadosProcesados | Format-Table -Autosize
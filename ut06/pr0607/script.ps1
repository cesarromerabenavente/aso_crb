$nuevosempleadosraw = Get-Content -Path C:\ASO\ut06\pr0607\nuevos_empleados_raw.txt

$nuevosEmpleadosProcesados = foreach ($linea in $nuevosempleadosraw){

$partes = $linea -split '\|'

$nombre = $partes[0].split(",")[1]
$apellidos = $partes[0].split(",")[0]

$nombreApellidos = (Get-Culture).TextInfo.ToTitleCase("$nombre $apellidos".ToLower())

$nombreApellidos

}

$nuevosEmpleadosProcesados
$movimientosCrudos = @"
[LOG-OK] SKU:A199 :: 2024.01.10_08:00 :: Item:Smartphone_X :: Qty:50 :: Status:In_Stock
[LOG-ALERT] SKU:B250 :: 10-01-2024 09:15 :: Item:LAPTOP-PRO :: Qty:-5 :: Status:Damaged
[LOG-OK] SKU:C312 :: 2024/01/10_10:30 :: Item:tablet_air :: Qty:120 :: Status:In_Stock
[LOG-CRIT] SKU:D400 :: 11/01/2024_11:45 :: Item:UNKNOWN_ITEM :: Qty:0 :: Status:Out_Of_Order
"@ -split "`r`n"

$movimientosProcesados = foreach ($linea in $movimientosCrudos){

    if ($linea.StartsWith("[LOG-OK]")) { continue }

    $partes = $linea -split ' :: '

    $log = $partes[0].Split(']')[0].Trim('[')
    $sku = $partes[0].Split(':')[1].Trim()

    $fechaLimpia = $partes[1] -replace '[.-]', '/' -replace '_', ' '
    $timeStamp = (Get-Date $fechaLimpia).ToString("yyyy-MM-dd HH:mm")

    $item = $partes[2].Split(':')[1].ToUpper()
    if ($item -eq "UNKNOWN_ITEM") { $item = "PENDING_REVIEW" }

    $qty = $partes[3].Split(':')[1].Trim()

    $action = "None"
    $status = $partes[4].Split(':')[1].Trim()
    if ($status -eq "Damaged") { $action = "Repair" }
    elseif ($status -eq "Out_Of_Order") { $action = "Replace" }

    [PSCustomObject]@{
        Log            = $log
        Sku            = $sku
        Fecha          = $timeStamp
        Item           = $item
        Qty            = $qty
        Status         = $status
        ActionRequired = $action
    }
}

$movimientosProcesados | Export-Csv -Path "reporte_inventario.csv"
$movimientosProcesados | Format-Table -Autosize
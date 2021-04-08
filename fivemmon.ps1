import-module SimplySql

Open-MySqlConnection -UserName "username" -Password "password"

$request = Invoke-RestMethod -Method Get -Uri 12.34.56.789:30120/players.json

$object_get = @()
$Fivemcash = "FiveM_Cash"

foreach ($req in $request) {
    $object_get += [pscustomobject]@{
    Name = $req.name
    Identifier = $req.identifiers[0]
    Ping = $req.ping
    }
}

foreach ($1 in $object_get) {

$2 = $1.identifier

 $neededshit = Invoke-SqlQuery -query "SELECT  identifier, money, bank, firstname FROM essentialmode.users WHERE identifier LIKE '$2';"
 

$need = $neededshit | Select-Object id, identifier, money, bank, firstname

foreach ($line in $need){

#$id = $line | Select id -ExpandProperty id
$identify = $line.identifier #| select identifier -ExpandProperty identifier
$money = $line.money #| select money -ExpandProperty money
$bank = $line.bank # | select bank -ExpandProperty bank
#$firstname = $line | select firstname -ExpandProperty firstname

#$id2 = "ID=" + $id
$steam = "Steam_ID=" + $identify.substring(6)
$money2 = "Money=" + $money
$bank2 = "Bank=" + $bank
$steamname1= "Steamname=" + $1.name
$pping = "Ping=" + $1.Ping

$steamname1 = $steamname1 -replace " ", "_"

$post11 = "$Fivemcash,$steam,$steamname1 $money2,$bank2,$pping"

#write-host $post11

Invoke-WebRequest 'http://12.34.56.789:8086/write?db=londonrp1' -method post  -body "$post11"
}
}

#use suas credenciais
$credential = Get-Credential

#importa a session do exchange online
$exchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $credential -Authentication "Basic" -AllowRedirection
Import-PSSession $exchangeSession -DisableNameChecking

#lista todos os grupos de distribuição
Get-DistributionGroup

#criar multiplos listas de distribuição com CSV
$arquivo = Import-Csv “C:\Temp\useraddinglist.csv” -Delimiter ";"
foreach ($item in $arquivo) {

    $name = $item.name
    $type = $item.type
    New-DistributionGroup -Name $name -Type $type
    Write-Host "Result:$name"

}

#adiciona multiplos usuários na lista pelo CSV
$arquivo = Import-Csv D:\Temp\useraddinglist.csv -Delimiter ";"
foreach ($item in $arquivo) {

    $grupos = $item.grupos
    $user = $item.user
    Add-DistributionGroupMember -Identity $grupos -Member $user
    Write-Host "Result:$user"

}

#adiciona um único usuário
Add-DistributionGroupMember -Identity "Name for Group" -Member "email for user" -BypassSecurityGroupManagerCheck

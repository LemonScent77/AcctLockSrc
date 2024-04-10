
$filter = @{LogName = "Security"; Id = 4625; StartTime = (Get-Date).AddDays(-5)}

$lockouts = Get-WinEvent -ComputerName 'Name Of PC' -FilterHashTable $filter -MaxEvents 1 -ErrorAction 0

$lockouts| Select-Object @{Name = "LockedUserName"; Expression = {$_.Properties[5].Value}}, `
@{Name = "LogonType"; Expression = {$_.Properties[10].Value}}, `
@{Name = "LogonProcessName"; Expression = {$_.Properties[11].Value}}, `
@{Name = "ProcessName"; Expression = {$_.Properties[18].Value}}

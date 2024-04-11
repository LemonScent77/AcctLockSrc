# Function to retrieve computer name
function Get-ComputerName {
    $computerName = $env:COMPUTERNAME
    return $computerName
}

# Retrieve computer name
$computerName = Get-ComputerName

# Set filter for Get-WinEvent
$filter = @{
    LogName = "Security"
    Id = 4625
    StartTime = (Get-Date).AddDays(-5)
}

# Retrieve security events related to account lockouts
$lockouts = Get-WinEvent -ComputerName $computerName -FilterHashTable $filter -MaxEvents 1 -ErrorAction 0

# Display relevant information about the lockout event
$lockouts | Select-Object @{
    Name = "LockedUserName"
    Expression = {$_.Properties[5].Value}
}, @{
    Name = "LogonType"
    Expression = {$_.Properties[10].Value}
}, @{
    Name = "LogonProcessName"
    Expression = {$_.Properties[11].Value}
}, @{
    Name = "ProcessName"
    Expression = {$_.Properties[18].Value}
}

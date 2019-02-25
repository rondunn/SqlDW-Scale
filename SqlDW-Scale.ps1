# Stop on error

$ErrorActionPreference = "Stop"

# Get RunAs connection from Automation

Write-Output "Get Connection"
$con = Get-AutomationConnection -Name "AzureRunAsConnection"
$con

# Login to Azure

Write-Output "Login"
$login = Login-AzureRmAccount -ServicePrincipal -TenantId $con.TenantId -ApplicationId $con.ApplicationId -CertificateThumbprint $con.CertificateThumbprint
$login

# Select the subscription

Write-Output "Set subscription"
$sub = Select-AzureRmSubscription -SubscriptionID $con.SubscriptionId
$sub

# Get runbook variables

Write-Output "Get DW variables"
$ResourceGroupName = Get-AutomationVariable -Name 'ResourceGroupName'
$ServerName = Get-AutomationVariable -Name 'ServerName'
$DatabaseName = Get-AutomationVariable -Name 'DatabaseName'
$ScaleObjective = Get-AutomationVariable -Name 'ScaleObjective'
 
# Resume DW
 
Write-Output "Scale $($DatabaseName)" 
Set-AzureRmSqlDatabase -DatabaseName $DatabaseName -ServerName $ServerName -RequestedServiceObjectiveName $ScaleObjective


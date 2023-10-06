[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $ResourceGroupName,
    [Parameter()]
    [string]
    $SubscriptionId
)

Set-AzContext -SubscriptionId $subscriptionId | Out-Null

foreach ($resource in Get-AzResource -ResourceGroupName $ResourceGroupName) {
    try {
        Write-Verbose "Removing resource $($resource.ResourceName)"
        Remove-AzResource -ResourceId $resource.ResourceId -Force -Verbose
        Write-Verbose "Resource $($resource.ResourceName) removed"
    }
    catch {
        Write-Warning "Resource $($resource.ResourceName) could not be removed"
        Write-Verbose $_.Exception.Message
    }
}
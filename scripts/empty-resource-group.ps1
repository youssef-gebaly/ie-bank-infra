[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $ResourceGroupName
)

foreach ($resource in Get-AzResource -ResourceGroupName $ResourceGroupName) {
    try {
        Write-Verbose "Removing resource $($resource.ResourceName)"
        Remove-AzResource -ResourceId $resource.ResourceId -Force -
        Write-Verbose "Resource $($resource.ResourceName) removed"
    }
    catch {
        Write-Warning "Resource $($resource.ResourceName) could not be removed"
        Write-Verbose $_.Exception.Message
    }
}
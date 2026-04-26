# TO run it
# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# setaffinity.ps1 -ProcessName "notepad" -AffinityValue 0x0FFF

param (
    [Parameter(Mandatory=$true)]
    [string]$ProcessName,
    [Parameter(Mandatory=$true)]
    [int]$AffinityValue
)

$processes = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue

if ($processes) {
    foreach ($process in $processes) {
        try {
            $process.ProcessorAffinity = $AffinityValue
#            Write-Host "Set affinity for process $($process.Name) (PID: $($process.Id)) to $AffinityValue"
        } catch {
            Write-Host "Failed to set affinity for process $($process.Name) (PID: $($process.Id)): $_" -ForegroundColor Red
        }
    }
} else {
    Write-Host "No processes found with name: $ProcessName" -ForegroundColor Yellow
}

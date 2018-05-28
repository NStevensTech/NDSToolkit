$Module = @(Get-ChildItem -Path $PSScriptRoot\cmdlets\*.ps1 -ErrorAction SilentlyContinue)

foreach ($item in $Module) {
    Try{
        .$item.fullname
    } Catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function *
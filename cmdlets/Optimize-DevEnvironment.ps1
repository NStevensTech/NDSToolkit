# Optimize-DevEnvironment.ps1
# Author: Nathan D. Stevens
# Last Update: 05/26/2018

Function Optimize-DevEnvironment {
    <#
    .SYNOPSIS
    This script will optimize a device for low-resource .NET Development without VisualStudio.

    .DESCRIPTION
    Optimize-DevEnvironment will check for a 64-bit version of .NET Framework to be added to 
    the Path environment variable. It will then find the most recent version of the Framework
    and try to add it to the Path if it is not already on the path.

    .NOTES
    Author: Nathan D. Stevens
    Last Update: 05/26/2018
    
    Requires PowerShell 3.0 or greater!!!
    Requires Admin access!!!

    .LINK
    http://www.nathanstevens.tech
    #>

    Param ()

    # Define file path for 64-bit and 32-bit .NET Framework.
    $Framework64 = "C:\Windows\Microsoft.NET\Framework64"
    $Framework = "C:\Windows\Microsoft.NET\Framework"
    # Check for 64-bit .NET Framework.
    $64Bit = test-path $Framework64

    # Get file path to latest version of .NET Framework.
    If ($64Bit) {
        $filepath = $(Get-ChildItem $Framework64 | Where-Object {$_.Name -like "v*"} | Sort-Object -Descending | Select-Object -First 1)
        Write-Output "Device has a 64-bit version of .NET Framework."
        Write-Output "Version: $filepath"
    } Else {
        $filepath = $(Get-ChildItem $Framework | Where-Object {$_.Name -like "v*"} | Sort-Object -Descending | Select-Object -First 1)
        Write-Output "Device has a 32-bit version of .NET Framework."
        Write-Output "Version: $filepath"
    }

    # Check if the .NET Framework is added to the Path.
    $Path = Get-Item ENV:Path
    $InPath = ($Path.Value -like "*$filepath*")

    # Add .NET Framework to the Path if not currently added.
    If ($InPath) {
        Write-Output ""
        Write-Warning "The current version of .NET Framework is already in the Path."
    } Else {
        [Environment]::SetEnvironmentVariable("Path", $Env:Path + ";" + $filepath.FullName, [System.EnvironmentVariableTarget]::Machine)
        Write-Output ""
        Write-Output "The .NET Framework has been added to the Path."
    }
    
}

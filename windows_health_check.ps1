Write-Host "🖥️ System Info"
Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, OsArchitecture

Write-Host "`n💽 Disk Info"
Get-PSDrive -PSProvider 'FileSystem'

Write-Host "`n🧠 Memory Info"
Get-WmiObject Win32_OperatingSystem | Select-Object TotalVisibleMemorySize, FreePhysicalMemory

Write-Host "`n📦 Installed Hotfixes (Patches)"
Get-HotFix | Select-Object Description, HotFixID, InstalledOn

Write-Host "`n🚀 Running Services"
Get-Service | Where-Object {$_.Status -eq "Running"} | Select-Object DisplayName, Status
Function GetOrCreate-ResourceGroup([string]$name = "", [string]$location = "")
{
   If($name -eq "" -Or $location -eq "") {
      Write-Host "USAGE:\n\tPS > . [script_location]\create_environment.ps1; GetOrCreateResoureGroup -name [NameOfResourceGroup] -location [LocationToInstall e.g. "Central US"]"
      return
   }
   
   try {
      return Get-AzureRmResourceGroup -name $name
   }
   catch {
      Write-Host "I WOULD DO: New-AzureRmResourceGroup -Name $name -Location $location"
      return $result
   }
}



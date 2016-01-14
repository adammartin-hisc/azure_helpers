Function AuthenticateToSubscription([string]$username = "", [string]$password = "", [string]$subscriptionName = "", [string]$tenantId = "") {
     $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
     $cred = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)
     Login-AzureRmAccount -Credential $cred -SubscriptionName $subscriptionName -TenantId $tenantId
     $sub = Get-AzureRmSubscription -subscriptionName $subscriptionName -TenantId $tenantId
     Select-AzureRmSubscription -SubscriptionId $sub.SubscriptionId -TenantId $tenantId
}

Function GetOrCreate-ResourceGroup([string]$name = "", [string]$location = "") {
   If($name -eq "" -Or $location -eq "") {
      Write-Host "USAGE:\n\tPS > . [script_location]\create_environment.ps1; GetOrCreate-ResoureGroup -name [NameOfResourceGroup] -location [LocationToInstall e.g. 'Central US']"
      return
   }

   try {
      $result = Get-AzureRmResourceGroup -name $name
      return $result.ResourceGroupName
   }
   catch {
      $result = New-AzureRmResourceGroup -Name $name -Location $location
      return $result.ResourceGroupName
   }
}

Function Create-SqlServer([string]$group = "", [string]$serverName = "", [string]$databaseName = "", [string]$administratorLogin = "", [string]$administratorLoginPassword = "", [string]$serverVersion="12.0") {
   If($group -eq "" -Or $serverName -eq "" -Or $databaseName -eq "" -Or $administratorLogin -eq "" -Or $administratorLoginPassword -eq "") {
      Write-Host "USAGE:\n\tPS > . [script_location]\create_environment.ps1; Create-SqlServer -group [group from GetOrCreate-ResourceGroup] -serverName [NameOfSQLServer] -databaseName [NameOfDatabase] -administratorLogin [AdminLogin] -administratorLoginPassword [AdminPassword]"
      return
   }

   $secpasswd = ConvertTo-SecureString $administratorLoginPassword -AsPlainText -Force
   New-AzureRmResourceGroupDeployment -ResourceGroupName $group -TemplateFile .\sqlServerDeploy.json -serverName $serverName -serverVersion $serverVersion -databaseName $databaseName -administratorLogin $administratorLogin -administratorLoginPassword $secpasswd
}

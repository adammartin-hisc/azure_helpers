# Helper Scripts for Azure

This is an example azure spike on how you might specifically spin up an SQL Server using powershell.  This is not TDD'd but should be if it was to be converted to real production code.

I know that the scripting style is badly done and should be done as a powershell module instead of it's current format.

# Usage

First you must authenticate to use this example.  Assuming that you will be operating in the same directory as this script here is an example of how you might use it and some of the gotcha's I have encountered.

* First Login (In an idealized world this would use a subscription file instead of user_id and password): ` . .\create_environment.ps1; AuthenticateToSubscription -username [YOUR_AZURE_USER_ID] -password [YOUR_AZURE_PASSWORD] -subscriptionName [SUBSCRIPTION_NAME]`
* Create the resource group:  `. .\create_environment.ps1; GetOrCreate-ResourceGroup -name [GROUP_NAME] -location [REGION e.g. 'Central US']`
* Create the DB Server and Instance: `. .\create_environment.ps1; Create-SqlServer -group [GROUP_NAME_FROM_PREVIOUS_STEP] -serverName [DB_SERVER_NAME] -databaseName [DB_NAME] -administratorLogin [ADMIN_ID] -administratorLoginPassword [ADMIN_PASSWORD]`

## Lessons:

* Script should precheck password for sufficient complexity (i.e. it is long enough, has a upper case, numbers, etc.) or it will result in a partial failure and an odd state.
* DB Server Name should all be in lower cases ... this should also be prechecked.

# Dependencies:

[Install Azure Powershell 1.0 or greater](https://azure.microsoft.com/en-us/documentation/articles/powershell-install-configure/)

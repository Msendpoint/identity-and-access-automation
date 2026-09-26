### FILE: index.php
<?php 
// Logic to fetch data from Graph and call render_premium_card multiple times to build the dashboard...
$accessToken = $_SESSION['ms_access_token'];
$userEndpoint = 'https://graph.microsoft.com/v1.0/users';
$response = $ms->graphCall($userEndpoint, $accessToken);
// Render cards based on response data
render_premium_card('User Creation', count($response['value']), 'Up', 'up', '👤', 70);
?>

### FILE: scripts/Automation.ps1
<#
.SYNOPSIS
Automates user creation and role assignment using Microsoft Graph API.
.DESCRIPTION
This script creates a user in Azure AD with the given UserPrincipalName, DisplayName, and assigns a role if specified using the Microsoft Graph PowerShell module.
.EXAMPLE
.
param (
    [string]$UserPrincipalName = 'jdoe@example.com',
    [string]$DisplayName = 'John Doe',
    [string]$Role = 'User'
)
.NOTES
    Author:      Souhaiel Morhag
    Company:     MSEndpoint.com
    Blog:        https://msendpoint.com
    Academy:     https://app.msendpoint.com/academy
    LinkedIn:    https://linkedin.com/in/souhaiel-morhag
    GitHub:      https://github.com/Msendpoint
    License:     MIT
#>

param (
    [string]$UserPrincipalName,
    [string]$DisplayName,
    [string]$Role
)

Try {
    Write-Output "Creating user $UserPrincipalName"
    $user = @{
        "UserPrincipalName" = $UserPrincipalName
        "DisplayName" = $DisplayName
        "MailNickname" = $UserPrincipalName.Split('@')[0]
        "AccountEnabled" = $true
    }
    New-MgUser -BodyParameter $user
    Write-Output "User $UserPrincipalName created successfully"
    
    If ($Role) {
        Write-Output "Assigning role $Role to $UserPrincipalName"
        # Add role assignment logic here
    }
} Catch {
    Write-Output "Failed to create user: $_"
    exit 1
}

exit 0
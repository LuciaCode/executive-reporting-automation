# Automated Deployment Setup Guide

This guide describes how to programmatically upload and sync the generated Excel data to a OneDrive for Business account using the **Microsoft Graph PowerShell SDK**.

## Prerequisites

1.  **PowerShell 7+** installed.
2.  **Microsoft Graph PowerShell SDK** installed:
    ```powershell
    Install-Module Microsoft.Graph -Scope CurrentUser -Force
    ```
3.  **App Registration/Permissions:** Ensure the user has `Files.ReadWrite` permissions.

## Automated Deployment Steps

### 1. Generate the Excel Table
Run the Python script to transform raw CSV data into a Copilot-ready Excel file:
```bash
python scripts/prepare_data.py data/sales_data_2024.csv Sales_2024_Formatted.xlsx
```

### 2. Authenticate and Upload
Use the following PowerShell script to upload the file to Juan Perez's OneDrive:

```powershell
# 1. Sign in to Microsoft Graph
Connect-MgGraph -Scopes "Files.ReadWrite, User.Read"
```
This will open a browser window. Log in with Juan Perez's credentials and accept the requested permissions. Once it says “Authentication complete,” you can close the browser and return to the terminal.

```powershell
# 2. Get the current authenticated user
$currentUser = (Get-MgContext).Account

# 3. Define the local file path
$localFilePath = ".\Sales_2024_Formatted.xlsx"

# 3. Define the exact Graph API URI (Notice the "root:/" syntax to target OneDrive)
$uri = "https://graph.microsoft.com/v1.0/users/$currentUser/drive/root:/SalesReports/Sales_2024_Formatted.xlsx:/content"

# 4. Execute the upload via REST API
Write-Host "Starting direct API upload to OneDrive for $currentUser..."
Invoke-MgGraphRequest -Method PUT -Uri $uri -InputFilePath $localFilePath -ContentType "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
Write-Host "File successfully uploaded! The Semantic Index will begin processing it."
```

### 3. Verify Cloud Sync
Ensure the file appears in the web version of OneDrive. Microsoft Graph will automatically start indexing the file into the **Semantic Index**, making it available for Copilot prompts within 1-5 minutes.

## Why This Matters for Copilot
Copilot for Excel *requires* the file to be stored in the cloud (OneDrive/SharePoint) and formatted as an Excel Table. This automation ensures both requirements are met without manual intervention.

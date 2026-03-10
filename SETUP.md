# Automated Deployment Setup Guide

This guide describes how to programmatically upload and sync the generated Excel data to a OneDrive for Business account using the **Microsoft Graph PowerShell SDK**.

## Prerequisites

1.  **PowerShell 7+** installed.
2.  **Microsoft Graph PowerShell SDK** installed:
    ```powershell
    Install-Module Microsoft.Graph -Scope CurrentUser
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
Connect-MgGraph -Scopes "Files.ReadWrite"

# 2. Define File Paths
$localFilePath = ".\Sales_2024_Formatted.xlsx"
$driveItemPath = "/SalesReports/Sales_2024_Formatted.xlsx"

# 3. Upload the file to OneDrive
$fileStream = [System.IO.File]::OpenRead($localFilePath)
$uploadParams = @{
    DriveId = (Get-MgUserDrive -UserId "juan.perez@tenant.onmicrosoft.com").Id
    Path = $driveItemPath
    InputStream = $fileStream
}
Set-MgDriveItemContent @uploadParams

Write-Host "File successfully uploaded to OneDrive. Copilot indexing will begin shortly."
```

### 3. Verify Cloud Sync
Ensure the file appears in the web version of OneDrive. Microsoft Graph will automatically start indexing the file into the **Semantic Index**, making it available for Copilot prompts within 1-5 minutes.

## Why This Matters for Copilot
Copilot for Excel *requires* the file to be stored in the cloud (OneDrive/SharePoint) and formatted as an Excel Table. This automation ensures both requirements are met without manual intervention.

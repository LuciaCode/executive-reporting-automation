# 🛡️ Infrastructure as Code (IaC): Automated Environment Provisioning

This guide provides a one-click deployment path using **PowerShell Desired State Configuration (DSC)**. Instead of manual steps, we use a declarative approach to ensure the Azure VM is in the perfect state for AI orchestration.

---

## 🚀 Why use DSC for this POC?

1. **Drift Prevention:** If a dependency (like Python or the Graph SDK) is accidentally removed, DSC will automatically detect and reinstall it.
2. **Consistency:** Guarantees that the environment is identical every time it is deployed.
3. **Auditability:** The infrastructure is defined as code, making it easy to track changes in GitHub.

---

## 🛠️ Prerequisites

* **OS:** Windows 10/11 or Windows Server (Azure VM).
* **Permissions:** Administrator access to the PowerShell terminal.
* **Execution Policy:** Must be set to `RemoteSigned`.
```powershell
  Set-ExecutionPolicy RemoteSigned -Scope Process -Force
```

## 📖 Deployment Steps
### Step 1: Initialize the Configuration
Navigate to the root of the repository and dot-source the configuration script:
```powershell
. .\infrastructure\VMConfiguration.ps1
```

### Step 2: Compile the MOF File
Run the configuration function to generate the localhost.mof file:
```powershell
ExecutiveReportingConfig
```

### Step 3: Apply the Desired State
Push the configuration to the local machine. This will trigger the silent installation of Python, Git, and all necessary modules:
```powershell
Start-DscConfiguration -Path .\ExecutiveReportingConfig -Wait -Verbose -Force
```

## 🔍 What the DSC Ensures:
*Prerequisites*: Git and Python 3.12 presence.
*PowerShell Modules*: Microsoft.Graph.
*Directory Structure*: Ensures C:\executive-reporting-automation is ready for data processing.
*Python Packages*: Automatically runs pip install -r requirements.txt.


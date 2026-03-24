Configuration ExecutiveReportingConfig {
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node "localhost" {
        # 1. Garantizar que Git esté instalado (vía Winget/Package)
        Package Git {
            Ensure    = "Present"
            Path      = "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe"
            Name      = "Git version 2.44.0"
            ProductId = "117A94AD-93A9-4977-862D-E714F7DE85B0" # Ejemplo de GUID
            Arguments = "/VERYSILENT /NORESTART"
        }

        # 2. Instalación de Python 3.12
        Package Python {
            Ensure    = "Present"
            Name      = "Python 3.12.2 (64-bit)"
            Path      = "C:\Installers\python-3.12.exe"
            ProductId = "{Python-GUID-Here}"
            Arguments = "/quiet InstallAllUsers=1 PrependPath=1"
        }

        # 3. Instalación del Módulo Microsoft Graph
        Script InstallGraphModule {
            SetScript  = { Install-Module -Name Microsoft.Graph -Force -AllowClobber -Scope AllUsers }
            TestScript = { (Get-Module -ListAvailable -Name Microsoft.Graph) -ne $null }
            GetScript  = { return @{ Result = "Microsoft.Graph Module Status" } }
        }

        # 4. Asegurar que el directorio del proyecto exista
        File ProjectFolder {
            Ensure          = "Present"
            Type            = "Directory"
            DestinationPath = "C:\executive-reporting-automation"
        }

        # 5. Instalación de dependencias de Python (requirements.txt)
        Script InstallPythonRequirements {
            SetScript  = { & pip install -r "C:\executive-reporting-automation\requirements.txt" }
            TestScript = { 
                # Verifica si una de tus librerías clave (ej. pandas) está instalada
                $pipList = & pip list
                return $pipList -like "*pandas*" 
            }
            GetScript  = { return @{ Result = "Python Requirements Status" } }
            DependsOn  = "[Package]Python"
        }
    }
}

# Generar el archivo .mof
ExecutiveReportingConfig

# Executive-Reporting-Automation: AI-Driven M365 Orchestration

[![Project Status: Active](https://img.shields.io/badge/Project%20Status-Active-brightgreen)](STATUS.md)
[![Platform: M365 Copilot](https://img.shields.io/badge/Platform-M365%20Copilot-blue)](https://www.microsoft.com/en-us/microsoft-365/copilot)
[![Tech: Python & PowerShell](https://img.shields.io/badge/Tech-Python%20%26%20PowerShell-yellow)](scripts/)

## 🚀 Overview
This proof-of-concept demonstrates the seamless transformation of raw sales data into high-impact executive presentations using Microsoft 365 Copilot's orchestration capabilities. This project highlights an end-to-end automated workflow from a virtualized infrastructure to an AI-driven business intelligence output.

This project specifically solves the challenge of data grounding for LLMs by programmatically structuring Excel data into a format that Copilot can reliably index and analyze.

## 🏗️ Technical Architecture & Retrieval-Augmented Generation (RAG)
The orchestration of this solution relies on the **Microsoft 365 Copilot Architecture**, which integrates with organizational data via **Microsoft Graph**.

```mermaid
graph TD
    A[User Prompt: Analyze Sales] --> B[Copilot Orchestrator]
    B --> C{Grounding Phase}
    C --> D[Microsoft Graph API]
    C --> E[Semantic Index]
    D --> F[Retrieval: Ventas_2024 Table]
    E --> G[Contextual Understanding]
    F --> H[Aggregated Context]
    G --> H
    H --> I[LLM: GPT-4]
    I --> J[Actionable Response/Generated Deck]
```

### Key Components
- **Data Layer:** Automated conversion of CSV to Copilot-ready Excel Tables (`Ventas_2024`) with metadata grounding.
- **Intelligence Layer:** M365 Copilot utilizing the **Semantic Index** to perform deep-tissue analysis of sales trends.
- **Presentation Layer:** A "Bridge" strategy using Word to synthesize raw data into a narrative before generating the final PowerPoint deck.

## 📂 Repository Structure
```text
├── scripts/                # Data transformation (Python) and Sync (PowerShell)
├── docs/                   # Deep-dive POC documentation and RAG architecture
├── data/                   # Raw sales datasets (CSV)
├── README.md               # Main project entry point
├── SETUP.md                # Environment & Deployment guide
├── STATUS.md               # Real-time project milestones
└── requirements.txt        # Python dependency manifest
```

## 🛠️ Environment Setup & Prerequisites
This solution was designed and tested on an Azure Virtual Machine.

### 1. Install Core Dependencies (Windows Package Manager):
Ensure Git and Python are installed at the system level:

```bash
winget install --id Git.Git -e --source winget
winget install --id Python.Python.3.12 -e --source winget
```
(Note: Restart PowerShell after installation to refresh the system Path).

### 2. Isolate the Environment (Best Practice):
Create and activate a Python Virtual Environment to prevent global package conflicts:

```bash
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
```
### 3. Install Microsoft Graph PowerShell SDK:

```bash
Install-Module Microsoft.Graph -Scope CurrentUser -Force
```

### Automated Deployment
Follow the instructions in [SETUP.md](SETUP.md) to upload your file to OneDrive using the **Microsoft Graph PowerShell SDK**.

### AI Orchestration
Once synced, use the specialized prompts found in [POC_Documentation.md](docs/POC_Documentation.md) within Excel, Word, and PowerPoint.

## 📈 Success Metrics (KPIs)
- **Efficiency:** 85% reduction in manual deck creation time.
- **Accuracy:** Zero-hallucination grounding via the `Ventas_2024` Table structure.
- **Consistency:** Unified corporate branding and narrative across all generated slides.

## 👤 Author
**Your company user**  
Project Lead for Juan Perez (Azure VM Environment)

## The Value Proposition
By programmatically converting raw CSVs into formatted Excel Tables and deploying them via the Microsoft Graph API, we bridge the gap between "Raw Information" and "AI Understanding." This workflow doesn't just save time—it establishes a secure Source of Truth, enabling high-value AI capabilities while maintaining strict corporate data governance.

---
*Disclaimer: This project requires an active Microsoft 365 Copilot license and appropriate tenant permissions for Microsoft Graph API access.*

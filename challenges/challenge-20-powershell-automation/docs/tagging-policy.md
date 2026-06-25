# Contoso IT -- Azure Resource Tagging Policy

> This stub is used in Stage 3 (Copilot-assisted compliance documentation).

## Required Tags

All Azure resources must carry the following tags before they are considered compliant:

| Tag          | Allowed values              | Required |
|--------------|-----------------------------|----------|
| Environment  | dev, staging, prod          | yes      |
| CostCenter   | 4-digit cost center code    | yes      |
| Owner        | UPN of the owning team lead | yes      |
| CreatedDate  | yyyy-MM-dd                  | yes      |

## Enforcement

Resources without all four required tags will be flagged by the weekly compliance report.
Tags applied after creation are acceptable but must be applied within 48 hours.

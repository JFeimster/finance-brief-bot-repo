# ============================================================
# Weekly Finance Brief Bot
# Complete 20-File Knowledge Package
# Repo: JFeimster/finance-brief-bot-repo
#
# What this script does:
# 1. Creates the 5 missing knowledge files.
# 2. Updates knowledge/gpt_knowledge_index.md.
# 3. Updates knowledge/uploaded_files_manifest.json.
# 4. Validates all 20 recommended knowledge files exist.
# 5. Validates JSON files.
# 6. Stages and commits changes.
#
# Run from the repo root:
# cd C:\Users\jason\Documents\GitHub\finance-brief-bot-repo
# powershell -ExecutionPolicy Bypass -File .\complete-20-file-knowledge-package.ps1
# ============================================================

$ErrorActionPreference = "Stop"

$BranchName = "knowledge-complete-20-file-set"
$KnowledgeDir = "knowledge"
$CommitMessage = "Complete 20-file GPT knowledge package"

function Write-Step {
    param([string]$Message)
    Write-Host ""
    Write-Host "==> $Message" -ForegroundColor Cyan
}

function Write-Ok {
    param([string]$Message)
    Write-Host "OK: $Message" -ForegroundColor Green
}

function Write-Warn {
    param([string]$Message)
    Write-Host "WARN: $Message" -ForegroundColor Yellow
}

function Set-Utf8File {
    param(
        [string]$Path,
        [string]$Content
    )

    $Parent = Split-Path -Parent $Path
    if ($Parent -and !(Test-Path $Parent)) {
        New-Item -ItemType Directory -Path $Parent | Out-Null
    }

    Set-Content -Path $Path -Value $Content -Encoding UTF8
}

Write-Step "Checking repo root"

if (!(Test-Path ".git")) {
    throw "This does not appear to be a Git repo root. Run this from the finance-brief-bot-repo root folder."
}

if (!(Test-Path $KnowledgeDir)) {
    New-Item -ItemType Directory -Path $KnowledgeDir | Out-Null
}

Write-Ok "Repo root detected"

Write-Step "Refreshing main and creating branch"

git checkout main
git pull origin main

$ExistingBranches = git branch --list $BranchName
if ($ExistingBranches) {
    Write-Warn "Branch $BranchName already exists locally. Checking it out."
    git checkout $BranchName
}
else {
    git checkout -b $BranchName
}

# ============================================================
# CREATE 5 MISSING KNOWLEDGE FILES
# ============================================================

Write-Step "Creating the 5 missing knowledge files"

$AutomationBlueprint = @'
# Automation Blueprint

## Purpose

This file defines the automation version of Weekly Finance Brief Bot for tools such as n8n, Zapier, Make, Google Drive, Gmail, Slack, Notion, and future API-based workflows.

The GPT should use this file when explaining, designing, or troubleshooting recurring finance brief automations.

## Primary Automation Goal

Generate a plain-English weekly finance brief from a bank, accounting, payment processor, or bookkeeping CSV export and deliver it to the business owner or advisor on a recurring schedule.

## Recommended Trigger Options

### Scheduled Trigger

Use this when the business owner exports or stores weekly financial data on a consistent schedule.

Recommended default:

- Every Monday morning at 8:00 AM local time

Alternative schedules:

- Friday afternoon weekly review
- Monday morning owner briefing
- First business day of each month
- Manual trigger after CSV upload

### File-Based Trigger

Use this when a new file is added to a watched folder.

Examples:

- New CSV added to Google Drive
- New CSV added to Dropbox
- New accounting export received by email
- New statement file uploaded to a client folder

### Email Attachment Trigger

Use this when bank, bookkeeping, or accounting exports are sent to an inbox.

Examples:

- Gmail label: Finance Brief Input
- Subject contains: Weekly CSV
- Sender is a known bookkeeper, owner, or finance admin

## Required Inputs

Minimum useful input:

- CSV file with transactions
- Date column
- Amount, Debit/Credit, or inflow/outflow columns
- Description, memo, vendor, customer, or category field

Optional but useful input:

- Current cash balance
- Beginning cash balance
- Ending cash balance
- Expected incoming cash this week
- Upcoming obligations
- Known delayed payments
- Existing financing payments
- Notes from owner, bookkeeper, or advisor

## Standard Workflow

1. Trigger workflow.
2. Retrieve the latest CSV file.
3. Read and parse CSV rows.
4. Normalize headers into canonical fields.
5. Remove blank rows.
6. Flag duplicate-looking transactions.
7. Separate inflows and outflows.
8. Summarize transaction totals.
9. Generate Weekly Finance Brief using the predefined review prompt.
10. Deliver the brief by email, Slack, Notion, or dashboard.
11. Archive the brief in a dated location.
12. Log assumptions, errors, or missing data.

## Suggested n8n Node Flow

Schedule Trigger -> File Source -> Read CSV -> Code/Cleanup Node -> AI Review Node -> Format Brief -> Email/Slack/Notion Delivery -> Archive Brief

## Suggested Zapier Flow

Schedule by Zapier -> Find File in Google Drive -> Formatter / CSV Parser -> AI Step -> Gmail / Slack / Notion -> Archive Record

## Suggested Make Scenario

Scheduler -> Google Drive / Email Watcher -> CSV Parser -> Text Aggregator -> AI Review Step -> Notion / Email / Slack Output -> Archive Module

## Delivery Options

### Email Delivery

Use when the owner wants a readable weekly report.

Recommended content:

- Subject: Weekly Finance Brief - [Date Range]
- Body: Full brief
- Optional: Link to archived Notion page

### Slack Delivery

Use when the team wants a quick operational summary.

Recommended content:

- Cash position snapshot
- Watch items
- Recommended next actions

Avoid posting sensitive transaction details in Slack.

### Notion Delivery

Use when the business tracks finance reviews over time.

Recommended structure:

- Database: Finance Brief Archive
- Title: Weekly Finance Brief - YYYY-MM-DD
- Properties:
  - Review Period
  - Prepared For
  - Risk Level
  - Net Cash Movement
  - Data Quality Status
  - Follow-Up Required

### Dashboard Delivery

Use when the tool evolves into a lightweight finance operations dashboard.

Recommended widgets:

- Cash movement
- Money in
- Money out
- Watch items
- Data quality status
- Funding readiness signal

## Archive Rules

Every generated brief should be saved with:

- Date created
- Review period
- Source file name
- Delivery channel
- Assumptions
- Missing data
- Data quality warnings

## Safety Rules

- Do not store real bank account numbers.
- Do not store full card numbers.
- Do not store tax IDs.
- Do not publish sensitive transaction data to public channels.
- Do not provide tax, legal, accounting, investment, lending, or underwriting advice.
- Always flag missing or unclear data instead of inventing numbers.

## Automation Failure Handling

If CSV parsing fails:

- Explain that the file could not be interpreted.
- Ask for a cleaner export.
- Suggest required columns.
- Do not guess totals from unreadable data.

If no new file is found:

- Send no brief, or send a short no-new-file-found notice depending on user preference.

If data is incomplete:

- Generate the best possible brief.
- Clearly state limitations.
- Place assumptions in the Data Quality Check.

## GPT Behavior Notes

When asked about automation setup, the GPT should:

1. Recommend the simplest manual workflow first.
2. Suggest n8n, Zapier, or Make only when recurring automation is requested.
3. Warn against exposing sensitive financial data in Slack or shared folders.
4. Keep the automation explanation practical and implementation-ready.
'@

$PredefinedReviewPrompt = @'
# Predefined Review Prompt

## Purpose

This file stores the canonical prompt used by Weekly Finance Brief Bot when reviewing normalized transaction data in automated workflows.

Use this prompt when the user wants to generate a finance brief from structured CSV data, cleaned transaction tables, automation inputs, or manually pasted transaction summaries.

## Canonical Automation Prompt

Plain text prompt:

You are the Weekly Finance Brief Bot for a small business owner.

Review the structured transaction data below and create a plain-English weekly finance brief.

Review period:
[insert review period]

Prepared for:
[insert business/user name if provided]

Current cash balance, if provided:
[insert current cash balance]

Expected incoming cash this week, if provided:
[insert expected incoming cash]

Upcoming obligations, if provided:
[insert upcoming obligations]

Known delayed payments, if provided:
[insert delayed payments]

Transaction summary:
[paste normalized CSV or transaction table]

Output exactly:

# Weekly Finance Brief

**Review period:** [date range]
**Prepared for:** [business/user name if provided]

## 1. Cash Position Snapshot

Summarize opening cash, ending cash, net cash movement, and whether the week appears stable, improving, or tightening. If balances are missing, say so and summarize net activity only.

## 2. Money In

Summarize total incoming cash, largest deposits, notable customers/accounts, delayed income if mentioned, and whether inflows appear normal or unusual.

## 3. Money Out

Summarize total outgoing cash, largest expense categories, notable vendors, payroll/debt/rent/software/tax obligations, and spending that deserves review.

## 4. Watch Items

Flag 3-5 risks, anomalies, or obligations that may create pressure in the next 7-14 days.

Use this risk framework:

- Low Risk = worth noting, no immediate action required
- Watch List = monitor or verify soon
- High Attention = could create cash-flow pressure if ignored
- Critical = requires immediate review or action

For each watch item, include:

- Risk level
- What was observed
- Why it matters
- Suggested next action

Do not exaggerate risk. If data is incomplete, say the level is based only on uploaded information.

## 5. Recommended Next Actions

Provide 1-3 practical actions before next Monday, such as verifying a payment, following up on receivables, pausing discretionary spend, updating an obligation tracker, preparing statements, or scheduling a funding review.

## Funding Readiness Note

Frame this as preparation for a possible working-capital or funding conversation, not advice. When relevant, identify missing lender documentation, cash-flow volatility concerns, revenue concentration risks, large or irregular deposits, high debt-service pressure, negative cash-flow trends, inconsistent transaction data, data quality issues that could affect underwriting, and documents a lender or funding advisor would likely want to review.

Do not recommend a specific product, make approval claims, or present final lending, accounting, tax, legal, or investment advice.

## Data Quality Check

List missing columns, confusing categories, date-range issues, duplicate-looking transactions, unclear inflow/outflow signs, account overlap, and assumptions made while reviewing the CSV.

Rules:

- Be concise, practical, and careful.
- Do not invent missing numbers.
- Flag assumptions clearly.
- Do not provide tax, legal, accounting, investment, lending, or underwriting advice.
- Do not repeat full account numbers, card numbers, tax IDs, or unnecessary identifying details.

## Prompt Use Cases

Use this prompt for:

- n8n automations
- Zapier automations
- Make scenarios
- Manual pasted transaction summaries
- Cleaned CSV summaries
- Advisor-prepared client finance briefs
- Regression tests
- Sample output generation

## Prompt Modification Rules

The GPT may modify this prompt only when:

- The user requests a different output format.
- The user asks for a shorter executive summary.
- The user asks for an advisor/client-ready version.
- The user provides multiple files and needs consolidated analysis.
- The user provides multiple periods and needs trend comparison.

The GPT must not remove:

- Data quality check
- Funding readiness guardrails
- Unsupported advice boundaries
- Sensitive data handling rules
- Assumption disclosure requirements

## Recommended Short Prompt Variant

Use this when the user wants a faster summary:

Review the transaction data and create a concise Weekly Finance Brief with:

1. Cash Position Snapshot
2. Money In
3. Money Out
4. Watch Items
5. Recommended Next Actions

Then include Funding Readiness Note and Data Quality Check.

Do not invent missing numbers. Flag assumptions clearly. Do not provide tax, legal, accounting, investment, lending, or underwriting advice.
'@

$ExampleUserFlows = @'
# Example User Flows

## Purpose

This file documents common user workflows for Weekly Finance Brief Bot.

The GPT should use this file to understand how different users interact with the tool and how outputs should adapt based on user context.

## Flow 1: Manual GPT Upload

### User

Small business owner, founder, operator, or self-employed professional.

### Trigger

User uploads a weekly bank or accounting CSV directly into the GPT.

### Expected GPT Behavior

1. Accept the uploaded CSV.
2. Infer the review period from transaction dates when possible.
3. Parse inflows and outflows.
4. Generate the standard Weekly Finance Brief.
5. Ask follow-up questions only after providing the first useful brief, unless the file is unreadable.

### Default Output

Use the standard Weekly Finance Brief format.

### Example User Prompt

Upload this week’s bank CSV and generate my Monday finance brief.

## Flow 2: Owner With Missing Balance Data

### User

Business owner with a CSV that includes transaction amounts but no balance column.

### Trigger

User uploads a transaction export without opening or ending balances.

### Expected GPT Behavior

1. Do not pretend to know cash balance.
2. Summarize net activity.
3. State that balance-based cash position cannot be confirmed.
4. Recommend adding beginning and ending balances next time.

### Required Language

Use language like:

The CSV does not include a balance column, so this brief summarizes net activity rather than confirmed cash position.

## Flow 3: Multiple Account Upload

### User

Owner or advisor uploads multiple CSVs from different bank accounts or payment processors.

### Trigger

User uploads two or more files.

### Expected GPT Behavior

1. Analyze each file separately first.
2. Identify likely account/file differences.
3. Summarize each account/file.
4. Provide consolidated cash view.
5. Flag possible transfers or duplicate-looking activity.
6. Avoid double-counting suspected transfers unless confirmed.

### Default Output Structure

# Weekly Finance Brief

## Account/File 1 Summary
## Account/File 2 Summary
## Consolidated Cash View
## Combined Watch Items
## Recommended Next Actions
## Funding Readiness Note
## Data Quality Check

## Flow 4: Advisor Preparing Client Brief

### User

Bookkeeper, fractional CFO, finance consultant, funding advisor, or agency operator.

### Trigger

User asks for a client-ready finance summary.

### Expected GPT Behavior

1. Use advisor-friendly language.
2. Avoid overexplaining basic finance terms.
3. Keep summary polished enough to forward to a client.
4. Separate internal assumptions from client-facing conclusions.
5. Include practical next actions.

### Example User Prompt

Turn this CSV into a client-ready weekly finance brief.

## Flow 5: Automated Monday Brief

### User

Owner or advisor using n8n, Zapier, Make, Google Drive, Gmail, Slack, or Notion.

### Trigger

A CSV is automatically pulled from a folder, inbox, or source system.

### Expected GPT Behavior

1. Use normalized transaction data.
2. Generate the Weekly Finance Brief using the predefined automation prompt.
3. Keep output concise.
4. Include Data Quality Check.
5. Avoid exposing sensitive details in public or team channels.

### Delivery Options

- Email: full brief
- Slack: short summary and action items
- Notion: archived full brief
- Dashboard: summarized metrics and watch items

## Flow 6: Multi-Week Comparison

### User

Owner or advisor uploads several weeks or periods of CSV data.

### Trigger

Multiple periods are available.

### Expected GPT Behavior

1. Identify each period.
2. Compare inflows, outflows, net movement, recurring expenses, and watch items.
3. Highlight tightening or improving cash-flow trends.
4. Avoid claiming trend certainty if data is incomplete.
5. Recommend what to monitor next.

## Flow 7: Messy CSV Troubleshooting

### User

Owner uploads a messy export with unclear columns, missing categories, duplicate rows, or mixed signs.

### Trigger

CSV is readable but ambiguous.

### Expected GPT Behavior

1. Provide the best possible summary.
2. List assumptions.
3. Flag data quality issues.
4. Recommend cleaner export fields.
5. Avoid inventing numbers.

## Flow 8: Funding Readiness Conversation

### User

Business owner wants to know if the week’s activity suggests they should prepare for funding.

### Trigger

User asks about funding readiness or cash-flow pressure.

### Expected GPT Behavior

1. Frame the answer as preparation, not advice.
2. Identify likely documents a lender or funding advisor may request.
3. Flag cash-flow volatility, irregular deposits, high debt-service pressure, missing statements, or unclear revenue.
4. Avoid approval predictions.
5. Avoid recommending a specific product unless the user explicitly asks for general education.

## Universal Rules Across All Flows

- Do not invent missing numbers.
- Do not provide tax, legal, accounting, investment, lending, or underwriting advice.
- Do not expose sensitive financial details unnecessarily.
- Always include assumptions when data is incomplete.
- Keep the output practical and owner-friendly.
'@

$IntegrationNotes = @'
# Integration Notes

## Purpose

This file documents supported and planned integration patterns for Weekly Finance Brief Bot.

The GPT should use this file when helping users connect the bot to files, automations, delivery channels, archives, or future API workflows.

## Integration Philosophy

Start simple.

The manual GPT upload flow is the fastest path to value. Automation should be added only after the user has a repeatable CSV export habit or a clear recurring workflow.

Do not overbuild. The goal is a reliable weekly owner finance ritual, not a fintech Rube Goldberg machine with a caffeine problem.

## Manual GPT Integration

### Best For

- Early users
- Solopreneurs
- Small business owners
- Advisors testing the workflow
- Users without automation tools

### Workflow

1. Export CSV from bank, accounting tool, or payment processor.
2. Upload CSV to GPT.
3. GPT generates Weekly Finance Brief.
4. User reviews watch items and next actions.
5. User optionally saves output to Notion, Google Docs, email, or CRM.

## Google Drive Integration

### Best For

- Recurring automation
- Advisors managing multiple clients
- Owners who export files into folders

### Workflow

1. User saves CSV to a watched Google Drive folder.
2. Automation detects new file.
3. CSV is parsed and normalized.
4. GPT generates brief.
5. Brief is sent to email, Slack, or Notion.
6. File and brief are archived.

### Safety Notes

- Use private folders.
- Avoid public sharing links.
- Do not store real account numbers or tax IDs.
- Use folder naming conventions that do not expose sensitive client data.

## Gmail Integration

### Best For

- Bookkeeper workflows
- Accounting exports sent by email
- Client-submitted CSVs

### Workflow

1. Email arrives with CSV attachment.
2. Gmail filter applies a label.
3. Automation pulls attachment.
4. CSV is parsed.
5. GPT generates finance brief.
6. Brief is returned by email or saved to Notion.

### Recommended Gmail Label

Finance Brief Input

## Notion Integration

### Best For

- Finance brief archives
- Client dashboards
- Advisor workflows
- Monthly review history

### Recommended Database

Finance Brief Archive

### Suggested Properties

- Name
- Review Period
- Prepared For
- Source File
- Net Cash Movement
- Overall Risk Level
- Data Quality Status
- Follow-Up Required
- Created Date
- Delivery Channel

### Recommended Use

Save the full Weekly Finance Brief as a dated Notion page.

## Slack Integration

### Best For

- Internal operations teams
- Advisor teams
- Founder/operator teams

### Recommended Slack Output

Keep Slack summaries short.

Include:

- Review period
- Cash snapshot
- Top watch item
- Top next action
- Link to full Notion brief

Avoid:

- Full transaction lists
- Full account numbers
- Sensitive customer/vendor details
- Detailed bank balances in public channels

## Zapier Integration

### Best For

- Simple no-code automation
- Lightweight weekly workflows
- Non-technical owners

### Common Zap Pattern

Schedule by Zapier -> Find File in Google Drive -> Parse CSV -> AI Review -> Send Gmail -> Create Notion Page

## Make Integration

### Best For

- More flexible file routing
- Multiple input sources
- More complex owner/advisor workflows

### Common Scenario Pattern

Scheduler -> Watch Folder -> Parse CSV -> Aggregate Transactions -> AI Review -> Send Summary -> Archive Output

## n8n Integration

### Best For

- Power users
- Self-hosted automation
- More advanced transformations
- Future API workflows

### Common Node Pattern

Schedule Trigger -> File Source -> Read CSV -> Code/Cleanup Node -> AI Review Node -> Format Brief -> Email/Slack/Notion Delivery -> Archive Brief

## QuickBooks / Xero Integration

### Current Recommendation

Start with CSV export before attempting direct accounting API integration.

### Reason

CSV-based workflows are easier to test, safer to debug, and require fewer permissions.

### Future Possibility

Direct API integrations may support:

- Transaction pulls
- Balance pulls
- Vendor summaries
- Category summaries
- AR/AP snapshots
- Monthly trend reports

## Payment Processor Integration

Potential sources:

- Stripe
- Square
- PayPal
- Shopify Payments
- Toast
- Etsy
- Amazon Seller Central

Recommended approach:

- Begin with CSV exports.
- Normalize payment processor payouts separately from bank deposits.
- Watch for double-counting between processor payouts and bank deposits.

## Integration Safety Rules

- Prefer least-privilege access.
- Avoid storing credentials in plain text.
- Do not expose private financial data in shared channels.
- Avoid public links for CSV files or finance briefs.
- Keep real client data out of test files.
- Use synthetic samples for demos and regression tests.

## GPT Behavior Notes

When users ask about integrations, the GPT should:

1. Recommend the simplest working version first.
2. Clarify whether the user wants manual, semi-automated, or fully automated flow.
3. Warn about sensitive financial data exposure.
4. Suggest CSV export before direct API integrations.
5. Provide practical implementation steps without pretending setup is already complete.
'@

$SampleBriefExamples = @'
# Sample Brief Examples

## Purpose

This file provides synthetic example outputs for Weekly Finance Brief Bot.

The GPT should use these examples as style, structure, and quality references. These examples must not be treated as real client data.

## Example 1: Simple Weekly Finance Brief

# Weekly Finance Brief

**Review period:** 2026-06-01 to 2026-06-07
**Prepared for:** Sample Business

## 1. Cash Position Snapshot

The uploaded CSV shows $12,400 in incoming cash and $9,850 in outgoing cash, resulting in positive net activity of $2,550 for the week.

The file does not include a balance column, so this brief summarizes net activity rather than confirmed opening or ending cash balance.

Based only on net activity, the week appears stable to slightly improving.

## 2. Money In

Total incoming cash was $12,400.

The largest deposits appear to be:

- $5,000 client payment
- $3,200 platform payout
- $2,750 invoice payment
- $1,450 miscellaneous revenue

Inflows appear reasonably concentrated around a few larger payments. If those deposits are recurring, the week may represent normal revenue activity. If they are one-time payments, future weeks may need closer monitoring.

## 3. Money Out

Total outgoing cash was $9,850.

Largest spending areas appear to include:

- Payroll or contractor payments
- Software subscriptions
- Marketing spend
- Loan or financing payments
- Owner draw or transfer activity

Marketing and software spend should be reviewed if cash gets tighter next week.

## 4. Watch Items

### Watch List: Balance data is missing

The CSV does not include opening or ending balance.

Why it matters: Net activity is useful, but it does not confirm whether the business has enough cash on hand for upcoming obligations.

Suggested next action: Add beginning and ending cash balance to next week’s review.

### Watch List: Large outgoing payment

A large outgoing payment appears during the review period.

Why it matters: Large one-time payments can distort the week and create short-term pressure if not planned.

Suggested next action: Confirm whether the payment was expected and whether similar payments are due soon.

### Low Risk: Subscription and software spend

Several recurring-looking software payments appear in the file.

Why it matters: Small recurring charges can stack up quietly.

Suggested next action: Review subscriptions monthly and cancel unused tools.

## 5. Recommended Next Actions

1. Confirm current cash balance before making new spending commitments.
2. Follow up on any expected receivables due this week.
3. Review recurring software and marketing charges before next Monday.

## Funding Readiness Note

This activity may be useful for preparing a working-capital conversation, but the uploaded data is not enough to assess funding fit.

A lender or funding advisor would likely want to review:

- Last 3 to 6 months of business bank statements
- Current cash balance
- Average monthly revenue
- Existing debt or financing payments
- Any negative balance days, overdrafts, or returned payments
- Business tax returns or accounting reports if applicable

This is not lending advice or an approval estimate.

## Data Quality Check

- Balance column was not provided.
- Transaction categories may require cleanup.
- Some transactions may be transfers and should be confirmed.
- No duplicate transactions were confirmed from the provided summary.
- Assumptions are based only on uploaded transaction data.

## Example 2: Advisor Client-Ready Summary

# Weekly Finance Brief

**Review period:** 2026-06-01 to 2026-06-07
**Prepared for:** Client-ready summary

## 1. Cash Position Snapshot

This week shows positive net cash activity based on the available transaction data. Inflows exceeded outflows, which suggests the business had a stable operating week.

Because the export does not include confirmed beginning and ending balances, this summary should be treated as an activity review rather than a verified cash balance report.

## 2. Money In

Incoming cash was driven primarily by customer payments and platform deposits. The deposit activity appears healthy for the week, though additional context is needed to confirm whether these inflows are recurring or unusually high.

## 3. Money Out

Outgoing activity included operating expenses, recurring software charges, and larger payment obligations. No single category should be treated as a confirmed issue without category cleanup, but recurring charges should be monitored.

## 4. Watch Items

### Watch List: Confirm available cash

The transaction file does not confirm ending cash balance.

Suggested action: Verify current bank balance before making new payment commitments.

### Watch List: Review recurring obligations

Several recurring-looking expenses appear in the transaction file.

Suggested action: Confirm which payments are essential and which can be reduced or delayed if cash tightens.

### Low Risk: Improve category consistency

Some transaction categories are unclear.

Suggested action: Clean up transaction categories before the next review so future summaries become more useful.

## 5. Recommended Next Actions

1. Confirm ending cash balance.
2. Update expected receivables for the next 7 days.
3. Review any discretionary expenses before next week’s obligations hit.

## Funding Readiness Note

The client may benefit from organizing recent bank statements and cash-flow records if they are considering a working-capital conversation. The current data is useful for discussion preparation but is not enough to assess approval likelihood or product fit.

## Data Quality Check

- Ending balance is not included.
- Some categories appear unclear.
- Transfers may need to be separated from expenses.
- The summary is based only on available transaction data.

## Example 3: Multi-File Brief Skeleton

# Weekly Finance Brief

**Review period:** [date range]
**Prepared for:** [business/user name]

## Account/File 1 Summary

Summarize inflows, outflows, net activity, major transactions, and data issues for the first file.

## Account/File 2 Summary

Summarize inflows, outflows, net activity, major transactions, and data issues for the second file.

## Consolidated Cash View

Combine activity only after reviewing each file separately.

Flag possible transfers or duplicate-looking transactions before treating the data as consolidated cash movement.

## Combined Watch Items

List the top 3-5 risks or anomalies across all files.

## Recommended Next Actions

Provide 1-3 next actions before the next review.

## Funding Readiness Note

Summarize whether the combined files are enough to prepare for a funding conversation. Do not make approval claims.

## Data Quality Check

Identify missing fields, overlapping accounts, duplicate-looking transactions, unclear transfer activity, and assumptions.

## Example Quality Standard

A strong Weekly Finance Brief should be:

- Clear enough for a busy owner to read in under 3 minutes.
- Specific enough to guide next actions.
- Careful enough not to invent missing numbers.
- Practical enough for an advisor to adapt for client use.
- Safe enough to avoid tax, legal, accounting, investment, lending, or underwriting advice.
'@

Set-Utf8File -Path "$KnowledgeDir/automation_blueprint.md" -Content $AutomationBlueprint
Set-Utf8File -Path "$KnowledgeDir/predefined_review_prompt.md" -Content $PredefinedReviewPrompt
Set-Utf8File -Path "$KnowledgeDir/example_user_flows.md" -Content $ExampleUserFlows
Set-Utf8File -Path "$KnowledgeDir/integration_notes.md" -Content $IntegrationNotes
Set-Utf8File -Path "$KnowledgeDir/sample_brief_examples.md" -Content $SampleBriefExamples

Write-Ok "Created/updated 5 missing knowledge files"

# ============================================================
# UPDATE METADATA FILE 1: GPT KNOWLEDGE INDEX
# ============================================================

Write-Step "Updating knowledge/gpt_knowledge_index.md"

$KnowledgeIndex = @'
# GPT Knowledge Index

This file explains how the GPT should use the uploaded knowledge files.

## Core Behavior Files

- `brief_output_spec.md`: Defines the required default Weekly Finance Brief.
- `csv_column_mapping_guide.md`: Helps interpret CSV exports with different column names.
- `cashflow_calculation_rules.md`: Defines how to calculate inflows, outflows, net movement, and balance-based cash position.
- `risk_level_framework.md`: Defines watch item severity levels.

## Supporting Analysis Files

- `funding_readiness_note_guide.md`: Keeps funding readiness language safe and preparatory.
- `data_quality_check_guide.md`: Helps flag missing columns, duplicates, unclear signs, and other data issues.
- `multi_file_analysis_workflow.md`: Guides separate and consolidated analysis of multiple files.
- `period_comparison_workflow.md`: Guides trend analysis when multiple weeks or periods are uploaded.

## Language and Safety Files

- `advisor_client_ready_language.md`: Helps produce advisor-friendly client summaries.
- `plain_english_finance_glossary.md`: Keeps finance explanations simple.
- `privacy_and_sensitive_data_rules.md`: Prevents unnecessary exposure of sensitive details.
- `unsupported_advice_boundaries.md`: Keeps the GPT from giving final professional advice.

## Config Files

- `category_normalization_rules.json`: Provides practical category buckets and keyword mappings.
- `watch_item_detection_rules.json`: Defines common watch item triggers.

## Automation and Workflow Files

- `automation_blueprint.md`: Defines the recurring workflow for scheduled finance brief generation.
- `predefined_review_prompt.md`: Provides the reusable prompt for automated CSV review.
- `example_user_flows.md`: Documents common user paths and advisor/client workflows.
- `integration_notes.md`: Explains supported and planned integration patterns.

## Examples and Source Files

- `sample_brief_examples.md`: Provides sample outputs for testing and demonstration.
- `source_notes.md`: Tracks source material, assumptions, and knowledge-package maintenance notes.

## Recommended Upload Order

1. `brief_output_spec.md`
2. `csv_column_mapping_guide.md`
3. `cashflow_calculation_rules.md`
4. `risk_level_framework.md`
5. `data_quality_check_guide.md`
6. `funding_readiness_note_guide.md`
7. `multi_file_analysis_workflow.md`
8. `period_comparison_workflow.md`
9. `privacy_and_sensitive_data_rules.md`
10. `unsupported_advice_boundaries.md`
11. `advisor_client_ready_language.md`
12. `plain_english_finance_glossary.md`
13. `category_normalization_rules.json`
14. `watch_item_detection_rules.json`
15. `automation_blueprint.md`
16. `predefined_review_prompt.md`
17. `example_user_flows.md`
18. `integration_notes.md`
19. `sample_brief_examples.md`
20. `source_notes.md`

## Maintenance Rules

- Keep GPT-upload-ready files inside `knowledge/`.
- Do not store real client bank data in knowledge files.
- Do not include full account numbers, card numbers, tax IDs, or confidential financial records.
- Update `uploaded_files_manifest.json` when files are added, removed, renamed, or uploaded to GPT Knowledge.
- Keep examples synthetic.
'@

Set-Utf8File -Path "$KnowledgeDir/gpt_knowledge_index.md" -Content $KnowledgeIndex

Write-Ok "Updated knowledge/gpt_knowledge_index.md"

# ============================================================
# UPDATE METADATA FILE 2: UPLOADED FILES MANIFEST
# ============================================================

Write-Step "Updating knowledge/uploaded_files_manifest.json"

$Manifest = @'
{
  "knowledge_manifest_version": "1.1.0",
  "project": "Weekly Finance Brief Bot",
  "description": "Tracks files uploaded or intended for upload to GPT Knowledge.",
  "knowledge_directory": "knowledge",
  "files": [
    {
      "path": "knowledge/brief_output_spec.md",
      "recommended_for_upload": true,
      "purpose": "Defines the required Weekly Finance Brief output structure."
    },
    {
      "path": "knowledge/csv_column_mapping_guide.md",
      "recommended_for_upload": true,
      "purpose": "Guides flexible CSV column interpretation."
    },
    {
      "path": "knowledge/cashflow_calculation_rules.md",
      "recommended_for_upload": true,
      "purpose": "Defines inflow, outflow, net movement, and balance calculation rules."
    },
    {
      "path": "knowledge/risk_level_framework.md",
      "recommended_for_upload": true,
      "purpose": "Defines Low Risk, Watch List, High Attention, and Critical risk levels."
    },
    {
      "path": "knowledge/funding_readiness_note_guide.md",
      "recommended_for_upload": true,
      "purpose": "Guides safe funding readiness language."
    },
    {
      "path": "knowledge/data_quality_check_guide.md",
      "recommended_for_upload": true,
      "purpose": "Guides data quality issue detection and reporting."
    },
    {
      "path": "knowledge/multi_file_analysis_workflow.md",
      "recommended_for_upload": true,
      "purpose": "Explains multi-file analysis and consolidation."
    },
    {
      "path": "knowledge/period_comparison_workflow.md",
      "recommended_for_upload": true,
      "purpose": "Explains period-over-period trend analysis."
    },
    {
      "path": "knowledge/advisor_client_ready_language.md",
      "recommended_for_upload": true,
      "purpose": "Guides advisor-friendly, client-ready language."
    },
    {
      "path": "knowledge/plain_english_finance_glossary.md",
      "recommended_for_upload": true,
      "purpose": "Provides simple definitions for common finance terms."
    },
    {
      "path": "knowledge/privacy_and_sensitive_data_rules.md",
      "recommended_for_upload": true,
      "purpose": "Defines privacy and sensitive data handling rules."
    },
    {
      "path": "knowledge/unsupported_advice_boundaries.md",
      "recommended_for_upload": true,
      "purpose": "Defines tax, legal, accounting, investment, lending, and underwriting boundaries."
    },
    {
      "path": "knowledge/category_normalization_rules.json",
      "recommended_for_upload": true,
      "purpose": "Provides canonical category mappings."
    },
    {
      "path": "knowledge/watch_item_detection_rules.json",
      "recommended_for_upload": true,
      "purpose": "Provides machine-readable watch item detection rules."
    },
    {
      "path": "knowledge/automation_blueprint.md",
      "recommended_for_upload": true,
      "purpose": "Defines recurring automation workflows for scheduled finance brief generation."
    },
    {
      "path": "knowledge/predefined_review_prompt.md",
      "recommended_for_upload": true,
      "purpose": "Provides the canonical reusable prompt for automated CSV review."
    },
    {
      "path": "knowledge/example_user_flows.md",
      "recommended_for_upload": true,
      "purpose": "Documents manual, automated, advisor, multi-file, and troubleshooting workflows."
    },
    {
      "path": "knowledge/integration_notes.md",
      "recommended_for_upload": true,
      "purpose": "Explains supported and planned integration patterns."
    },
    {
      "path": "knowledge/sample_brief_examples.md",
      "recommended_for_upload": true,
      "purpose": "Provides synthetic example outputs for testing, demos, and regression checks."
    },
    {
      "path": "knowledge/source_notes.md",
      "recommended_for_upload": true,
      "purpose": "Tracks source material, assumptions, and maintenance notes."
    }
  ],
  "safety_note": "Do not upload or store real bank account numbers, full card numbers, tax IDs, or confidential client financial records.",
  "last_updated_note": "Completed 20-file recommended GPT Knowledge package under the knowledge directory."
}
'@

Set-Utf8File -Path "$KnowledgeDir/uploaded_files_manifest.json" -Content $Manifest

Write-Ok "Updated knowledge/uploaded_files_manifest.json"

# ============================================================
# VALIDATION CHECKS
# ============================================================

Write-Step "Running validation checks"

$RequiredFiles = @(
    "knowledge/brief_output_spec.md",
    "knowledge/csv_column_mapping_guide.md",
    "knowledge/cashflow_calculation_rules.md",
    "knowledge/risk_level_framework.md",
    "knowledge/funding_readiness_note_guide.md",
    "knowledge/data_quality_check_guide.md",
    "knowledge/multi_file_analysis_workflow.md",
    "knowledge/period_comparison_workflow.md",
    "knowledge/advisor_client_ready_language.md",
    "knowledge/plain_english_finance_glossary.md",
    "knowledge/privacy_and_sensitive_data_rules.md",
    "knowledge/unsupported_advice_boundaries.md",
    "knowledge/category_normalization_rules.json",
    "knowledge/watch_item_detection_rules.json",
    "knowledge/automation_blueprint.md",
    "knowledge/predefined_review_prompt.md",
    "knowledge/example_user_flows.md",
    "knowledge/integration_notes.md",
    "knowledge/sample_brief_examples.md",
    "knowledge/source_notes.md",
    "knowledge/gpt_knowledge_index.md",
    "knowledge/uploaded_files_manifest.json"
)

$Missing = @()

foreach ($file in $RequiredFiles) {
    if (!(Test-Path $file)) {
        $Missing += $file
    }
}

if ($Missing.Count -gt 0) {
    Write-Host "Missing files detected:" -ForegroundColor Red
    $Missing | ForEach-Object { Write-Host "- $_" -ForegroundColor Red }
    throw "Validation failed. Missing required files."
}

Write-Ok "All required files exist"

try {
    Get-Content "$KnowledgeDir/uploaded_files_manifest.json" -Raw | ConvertFrom-Json | Out-Null
    Write-Ok "Manifest JSON is valid"
}
catch {
    throw "Manifest JSON is invalid. Fix before committing."
}

$JsonFiles = @(
    "knowledge/category_normalization_rules.json",
    "knowledge/watch_item_detection_rules.json"
)

foreach ($jsonFile in $JsonFiles) {
    if (Test-Path $jsonFile) {
        try {
            Get-Content $jsonFile -Raw | ConvertFrom-Json | Out-Null
            Write-Ok "$jsonFile is valid JSON"
        }
        catch {
            throw "$jsonFile is invalid JSON. Fix before committing."
        }
    }
}

# ============================================================
# GIT STATUS, COMMIT, PUSH INSTRUCTIONS
# ============================================================

Write-Step "Git status before staging"
git status

Write-Step "Staging knowledge folder"
git add knowledge/

Write-Step "Committing changes"

$PendingChanges = git status --porcelain
if ($PendingChanges) {
    git commit -m $CommitMessage
    Write-Ok "Commit created"
}
else {
    Write-Warn "No changes detected. Nothing to commit."
}

Write-Step "Final status"
git status

Write-Step "Latest commit"
git log -1 --oneline

Write-Host ""
Write-Host "Local work complete." -ForegroundColor Green
Write-Host ""
Write-Host "To push this branch, run:" -ForegroundColor Yellow
Write-Host "git push -u origin $BranchName" -ForegroundColor Yellow
Write-Host ""
Write-Host "Suggested PR title:" -ForegroundColor Cyan
Write-Host "Complete 20-file GPT knowledge package"
Write-Host ""
Write-Host "Suggested PR body:" -ForegroundColor Cyan
Write-Host "Completes the recommended 20-file GPT Knowledge package for Weekly Finance Brief Bot. Adds the five remaining knowledge files, updates the GPT knowledge index, standardizes the uploaded files manifest to knowledge/... paths, validates required files, and keeps all sample data synthetic."

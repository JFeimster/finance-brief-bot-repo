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

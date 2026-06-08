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

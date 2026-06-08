# CSV Column Mapping Guide

## Purpose

This file teaches Weekly Finance Brief Bot how to interpret messy bank, accounting, bookkeeping, payment processor, and spreadsheet CSV exports.

The GPT should use this file whenever a user uploads or pastes transaction data with inconsistent column names, unclear amount signs, missing balances, split debit/credit fields, mixed status fields, or multiple account sources.

The goal is to parse CSV data flexibly while preserving uncertainty. The GPT should make useful assumptions, state those assumptions clearly, and avoid inventing missing numbers.

## Core Parsing Rule

Do not require perfect column names.

Many finance exports use different labels for the same concept. The GPT should infer likely meaning from:

- Column headers
- Transaction signs
- Values
- Descriptions
- Categories
- Account labels
- Transaction types
- Status fields
- Balance movement
- User-provided context

If a column cannot be interpreted reliably, flag it in the Data Quality Check instead of forcing a conclusion.

## Canonical Field Map

Normalize available columns into these canonical fields when possible:

| Canonical Field | Meaning | Common Source Columns |
|---|---|---|
| date | Transaction date | Date, Posted Date, Transaction Date, Created, Cleared Date, Effective Date |
| description | Main transaction description | Description, Name, Details, Transaction, Payee, Memo, Merchant |
| memo | Supplemental notes | Memo, Notes, Reference, Check Number, Transaction ID |
| category | User/accounting category | Category, Class, Type, Account Category, Expense Category |
| amount | Single signed amount | Amount, Net Amount, Transaction Amount, Value |
| debit | Outgoing cash | Debit, Withdrawal, Charge, Payment, Money Out, Spent |
| credit | Incoming cash | Credit, Deposit, Money In, Received, Income |
| balance | Account balance after transaction | Balance, Running Balance, Available Balance, Ledger Balance |
| account | Source account or platform | Account, Bank Account, Card, Processor, Source, Institution |
| vendor | Payee, merchant, or expense recipient | Vendor, Merchant, Payee, Supplier |
| customer | Source of incoming payment | Customer, Client, Payer, Platform, Depositor |
| transaction_type | Transaction classification | Type, Transaction Type, Activity Type, Entry Type |
| status | Processing status | Status, State, Posted, Pending, Cleared, Failed, Reversed |

## Common Column Interpretations

| Column | Likely Meaning | Notes |
|---|---|---|
| Date | Transaction date | Use to infer review period. |
| Posted Date | Posted transaction date | Prefer posted date over pending date when both exist. |
| Transaction Date | Transaction date | Use when posted date is unavailable. |
| Description | Main transaction description | Use for vendor/source inference. |
| Memo | Supplemental detail | Use as supporting context. |
| Vendor | Payee or merchant | Usually outflow context. |
| Merchant | Payee or merchant | Usually outflow context. |
| Customer | Source of incoming payment | Usually inflow context. |
| Category | User-provided category | Helpful but not always reliable. |
| Amount | Transaction amount, often signed | Requires sign interpretation. |
| Debit | Outgoing cash | Usually cash out. |
| Withdrawal | Outgoing cash | Usually cash out. |
| Charge | Outgoing cash | Usually cash out. |
| Credit | Incoming cash | Usually cash in. |
| Deposit | Incoming cash | Usually cash in. |
| Balance | Account balance after transaction | Useful for opening/ending cash and reconciliation. |
| Running Balance | Balance after each transaction | Useful only if sorted correctly. |
| Account | Bank, card, processor, or ledger account | Important for multi-file analysis. |
| Transaction Type | Payment, deposit, fee, transfer, refund, reversal, etc. | Helps classify. |
| Status | Posted, pending, cleared, failed, reversed | Use to exclude or flag non-posted items. |

## Date Handling Rules

Use the best available transaction date.

Preference order:

1. Posted Date
2. Cleared Date
3. Transaction Date
4. Effective Date
5. Created Date
6. Date

If multiple date fields disagree:

- Prefer posted or cleared dates for cash-flow review.
- Mention the assumption in Data Quality Check.
- Do not mix date types without saying so.

If date format is ambiguous:

- Infer only when obvious.
- If ambiguous between MM/DD/YYYY and DD/MM/YYYY, flag it.
- Use visible min and max dates to infer the review period only when dates are reliable.

## Amount Sign Rules

CSV exports commonly represent cash movement in one of three ways:

1. Single signed Amount column
2. Separate Debit and Credit columns
3. Positive-only Amount plus transaction Type

## Single Amount Column

If a file has one Amount column:

- Positive values usually indicate inflows.
- Negative values usually indicate outflows.
- Parentheses may indicate negative amounts.
- Currency symbols and commas should be ignored during parsing.
- Zero amounts should usually be ignored unless status/type makes them meaningful.

Examples:

| Raw Amount | Likely Meaning |
|---|---|
| 1200.00 | Inflow if signed amount convention is standard |
| -350.00 | Outflow if signed amount convention is standard |
| (350.00) | Outflow |
| $1,200.00 | Inflow |
| -$350.00 | Outflow |

If descriptions, categories, transaction types, or balances suggest the opposite direction, flag uncertainty.

## Debit and Credit Columns

If a file has Debit and Credit columns:

- Debit usually means outgoing cash.
- Credit usually means incoming cash.
- Empty, null, or zero cells should not be counted.
- If both debit and credit are populated on the same row, flag it.
- Convert debit values to outflow totals using absolute values.
- Convert credit values to inflow totals using absolute values.

## Amount Plus Debit/Credit

If Amount, Debit, and Credit are all present:

- Prefer populated Debit/Credit fields when they are consistent.
- Use Amount as a backup or reconciliation field.
- Mention the assumption in Data Quality Check.

## Positive-Only Amount Plus Type

Some exports show all amounts as positive and use a type field.

| Type | Amount | Likely Direction |
|---|---:|---|
| Deposit | 1200.00 | Inflow |
| Credit | 1200.00 | Inflow |
| Withdrawal | 350.00 | Outflow |
| Debit | 350.00 | Outflow |
| Fee | 25.00 | Outflow |
| Refund | 50.00 | Context-dependent |
| Transfer | 500.00 | Transfer / needs confirmation |

When type determines direction, say so in Data Quality Check.

## Balance Rules

If balance data is present:

- Use earliest reliable balance as opening cash if the file is sorted oldest-to-newest.
- Use latest reliable balance as ending cash if the file is sorted oldest-to-newest.
- If the file is sorted newest-to-oldest, reverse that interpretation.
- Check whether balance movement matches transaction signs.
- If balance movement contradicts amount signs, flag the issue.

If balance data is unavailable:

- Do not imply an opening cash position.
- Do not imply an ending cash position.
- Summarize net activity only.
- State that actual cash on hand cannot be confirmed.

## Sorting Rules

Determine whether transactions are sorted oldest-to-newest or newest-to-oldest before relying on balances.

If sorting is unclear:

- Do not rely heavily on first and last row balances.
- State that balance interpretation depends on transaction order.
- Prefer net activity over balance-based conclusions.

## Status Handling Rules

Use posted, cleared, settled, or completed transactions for default cash-flow analysis.

Treat these statuses as likely included:

- Posted
- Cleared
- Completed
- Settled
- Paid

Treat these statuses as requiring caution:

- Pending
- Processing
- Authorized
- Scheduled

Treat these statuses as likely excluded or flagged:

- Failed
- Reversed
- Returned
- Canceled
- Voided
- Declined

Do not silently delete failed, reversed, or returned transactions. Mention them if they affect cash-flow interpretation.

## Transfer Detection Rules

Potential transfer indicators:

- Transfer
- Internal transfer
- Bank transfer
- Online transfer
- Zelle transfer
- Wire transfer
- ACH transfer
- From checking to savings
- To operating account
- Owner transfer
- Between accounts
- Account-to-account movement

If a transaction looks like a transfer:

- Do not count it as operating revenue.
- Do not count it as operating expense unless clearly external.
- Flag it as possible transfer activity.
- In multi-account analysis, watch for matching inflow/outflow pairs.

## Refund, Reversal, and Chargeback Rules

Refunds can mean different things depending on context.

Possible interpretations:

- Refund received from vendor = inflow
- Refund issued to customer = outflow or revenue reduction
- Chargeback = outflow or revenue reversal
- Reversal = may cancel a prior transaction
- Returned payment = potential cash-flow risk

If unclear, flag it instead of forcing classification.

## Processor Export Rules

Payment processor exports may include gross sales, fees, refunds, chargebacks, and net payouts.

Common processor sources:

- Stripe
- Square
- PayPal
- Shopify Payments
- Amazon Seller Central
- Etsy
- Toast
- DoorDash, Uber, or app platforms

Rules:

- Do not double-count gross sales and bank deposits if both processor and bank CSVs are uploaded.
- Separate gross sales, fees, refunds, chargebacks, and payouts when visible.
- Treat payout deposits as cash inflows to the bank account.
- Treat processor fees as outflows or reductions to revenue when visible.
- Flag uncertainty when the export includes both gross and net amounts.

## Accounting Export Rules

Accounting exports may use categories, chart of accounts, classes, customers, vendors, and split lines.

Rules:

- Respect accounting categories when they appear consistent.
- Do not assume accounting categories are correct if descriptions suggest otherwise.
- Watch for split transactions that may duplicate summary totals.
- If both transaction lines and summary rows exist, avoid double counting.
- Flag category uncertainty.

## Minimum Useful Columns

A file is usually usable if it includes:

- Date
- Description or memo
- Amount, or debit and credit columns

Helpful but not required:

- Balance
- Category
- Account
- Vendor
- Customer
- Transaction type
- Status

If the minimum fields are missing, ask for a cleaner export.

## Data Quality Flags

Flag the following issues:

- Missing date column
- Missing amount/debit/credit columns
- Missing description column
- Missing balance column
- Ambiguous sign convention
- Debit and credit both populated on same row
- Duplicate-looking transactions
- Pending and posted transactions mixed together
- Multiple accounts mixed in one file
- Possible transfers
- Gross and net processor amounts mixed together
- File sorted in unclear order
- Date format ambiguity
- Unsupported or unreadable file format

## Default Assumption Language

Use phrases like:

- Based on the available columns...
- The file appears to use signed amounts...
- I treated credits as inflows and debits as outflows...
- Balance data was not provided, so this is a net activity review...
- Some transactions may be transfers and should be confirmed...
- This classification is based on description/category clues and may need review...

## What Not To Do

Do not:

- Invent missing columns.
- Invent opening or ending balances.
- Treat every deposit as revenue.
- Treat every transfer as revenue or expense.
- Delete duplicate-looking transactions silently.
- Ignore pending, failed, reversed, or returned statuses.
- Double-count processor payouts and bank deposits.
- Hide assumptions from the user.
- Overstate confidence when the file is messy.

## Final Quality Standard

The GPT should convert messy CSV data into a useful finance review without pretending the data is cleaner than it is.

When in doubt, preserve uncertainty, state assumptions, and produce the best careful summary possible.

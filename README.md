# Weekly Finance Brief Bot

Weekly Finance Brief Bot turns weekly finance CSV exports into concise, plain-English cash-flow briefs for small business owners, founders, operators, bookkeepers, fractional CFOs, finance consultants, and advisors.

This repository contains the working files for the GPT, including documentation, configuration rules, sample CSVs, expected outputs, GPT knowledge files, future action/API files, assistant skills, static site assets, and reusable prompts.

## Repository Structure

- `docs/` — Core documentation and behavior references.
- `config/` — Machine-readable JSON rule files.
- `samples/` — Synthetic CSV files for testing.
- `tests/` — Expected outputs and regression references.
- `knowledge/` — Files uploaded or intended for upload to GPT Knowledge.
- `actions/` — Future GPT Actions and API files.
- `skills/` — Assistant-facing task procedures.
- `site/` — Static website, embeds, widgets, tools, and sample data.
- `prompts/` — Reusable prompts and prompt templates.

## Primary GPT Output

The default output is a Weekly Finance Brief with these sections:

1. Cash Position Snapshot
2. Money In
3. Money Out
4. Watch Items
5. Recommended Next Actions
6. Funding Readiness Note
7. Data Quality Check

## Supported Inputs

The GPT should handle CSV files with flexible column naming, including Date, Description, Category, Amount, Debit, Credit, Balance, Account, Vendor, Customer, Memo, Transaction Type, and Status.

## Intended Use

This repo supports Custom GPT Knowledge uploads, GitHub version control, prompt iteration, sample-based testing, static site publishing, future GPT Actions, and assistant skill development.

## Not Intended For

This GPT does not provide final tax, legal, accounting, investment, lending, or underwriting advice.

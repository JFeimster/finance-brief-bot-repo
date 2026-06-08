# Weekly Finance Brief Bot

Weekly Finance Brief Bot turns weekly finance CSV exports into concise, plain-English cash-flow briefs for small business owners, founders, operators, bookkeepers, fractional CFOs, finance consultants, and advisors.

This repository contains the working files for the GPT, including documentation, configuration rules, sample CSVs, expected outputs, GPT knowledge files, future action/API files, assistant skills, static site assets, and reusable prompts.

## Repository Structure

- `AGENTS.md` — Primary repo-level guidance for AI coding agents working on this project.
- `agents.json` — Machine-readable index of agent/tooling files and safety settings.
- `AI_CONTEXT.md` — Plain-English project context for AI assistants and coding tools.
- `TASKS.md` — Agent-friendly backlog of future documentation, site, prompt, API, and testing tasks.
- `README.md` — Main project overview and repository guide.
- `.gitignore` — Local, OS, editor, cache, environment, and build files to exclude from Git.
- `CHANGELOG.md` — Running log of notable repo updates.
- `CONTRIBUTING.md` — Guidelines for safely updating files and maintaining naming conventions.
- `LICENSE` — Project license.
- `repo_manifest.json` — Machine-readable overview of the repo purpose, folders, and safety notes.

---

- `docs/` — Core documentation and GPT behavior references.
  - Includes brief output rules, CSV column mapping, cash-flow calculations, risk framework, data quality checks, privacy rules, funding readiness guidance, and advice boundaries.

- `config/` — Machine-readable JSON rule files.
  - Includes category normalization rules and watch item detection rules.

- `samples/` — Synthetic CSV files for testing.
  - Includes single-account, multi-account, and messy-export sample CSVs.

- `tests/` — Expected outputs and regression references.
  - Includes example Weekly Finance Brief outputs for sample CSV files.

- `knowledge/` — Files uploaded or intended for upload to GPT Knowledge.
  - Includes the knowledge README, uploaded files manifest, GPT knowledge index, and source notes.

- `actions/` — Future GPT Actions and API planning files.
  - `actions/api/` includes placeholder OpenAPI schema files, authentication notes, endpoint design notes, and sample API request/response files.

- `skills/` — Assistant-facing task procedures and repeatable operating guides.
  - Includes CSV analysis, weekly brief generation, anomaly detection, funding readiness, data quality review, static site updates, prompt library maintenance, GitHub repo maintenance, and GPT Knowledge update skills.

- `site/` — Static HTML website files, embeds, widgets, tools, and sample data.
  - Includes `index.html`, `styles.css`, `script.js`, supporting pages, embed placeholders, widgets, and sample JSON data.

- `prompts/` — Reusable prompts, prompt templates, and testing prompts.
  - Includes ChatGPT prompts, testing prompts, advisor prompts, coding-agent prompts, and prompt manifests.

- `tooling/` — Tool-specific guidance for AI coding assistants and development workflows.
  - `tooling/codex/` — Codex and ChatGPT coding workflow instructions and tasks.
  - `tooling/jules/` — Jules-style GitHub task instructions and task ideas.
  - `tooling/vercel/` — Vercel deployment notes, deploy checklist, and v0 prompt templates.
  - `tooling/github/` — GitHub issue and pull request template references.
  - `tooling/cursor/` — Cursor-oriented repo editing rules.
  - `tooling/replit/` — Replit Agent and app-builder notes.

 ---

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

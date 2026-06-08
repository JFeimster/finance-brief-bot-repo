# AGENTS.md

This file provides repo-level guidance for AI coding agents working on Weekly Finance Brief Bot.

## Project Purpose

Weekly Finance Brief Bot turns weekly finance CSV exports into concise, plain-English cash-flow briefs for small business owners, founders, operators, bookkeepers, fractional CFOs, finance consultants, and advisors.

The repository supports:

- Custom GPT Knowledge files
- Documentation
- Prompt templates
- Sample CSVs
- Expected output tests
- Static website files
- Assistant skills
- Future GPT Actions and API files
- Agent/tooling instructions

## High-Level Repo Map

- `docs/` — Core documentation and behavior references.
- `config/` — Machine-readable JSON rules.
- `samples/` — Synthetic CSV test files.
- `tests/` — Expected outputs and regression references.
- `knowledge/` — Files uploaded or intended for GPT Knowledge.
- `actions/` — Future GPT Actions and API design.
- `skills/` — Assistant-facing operating procedures.
- `site/` — Static website files, embeds, widgets, and sample data.
- `prompts/` — Reusable prompts and templates.
- `tooling/` — Tool-specific instructions for Codex, Jules, Vercel, Cursor, Replit, GitHub, and similar agents.

## Editing Rules

1. Preserve the GPT’s required Weekly Finance Brief structure unless explicitly asked to revise it.
2. Do not delete existing files unless the task specifically requests deletion.
3. Do not overwrite sample or expected-output files without explaining why.
4. Do not introduce real customer, bank, card, tax, or confidential financial data.
5. Use synthetic data for samples, tests, and examples.
6. Keep Markdown files readable and practical.
7. Keep JSON files valid and machine-readable.
8. Use lowercase filenames with underscores or hyphens.
9. Keep site files framework-free unless the task explicitly asks for a framework.
10. When making behavior changes, update related files such as `CHANGELOG.md`, `repo_manifest.json`, or relevant manifests.

## Safety Rules

Do not provide final tax, legal, accounting, investment, lending, or underwriting advice.

When discussing funding readiness, frame it as preparation for a possible working-capital conversation, not as a recommendation or approval prediction.

Do not repeat full account numbers, full card numbers, routing numbers, tax IDs, Social Security numbers, or authentication codes.

## Expected Checks

Before completing a task, review:

- Whether Markdown formatting is clean.
- Whether JSON is valid.
- Whether links and relative paths make sense.
- Whether new files fit the existing folder structure.
- Whether no sensitive data was added.

## Preferred Output Style for Agent Summaries

When summarizing changes, include:

1. Files changed.
2. What changed.
3. Any assumptions.
4. Any follow-up recommendations.

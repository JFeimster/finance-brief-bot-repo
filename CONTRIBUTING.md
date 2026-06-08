# Contributing

This repository supports the Weekly Finance Brief Bot custom GPT.

## Updating Files

When updating behavior, prompts, or rules:

1. Update the relevant file in `docs/`, `config/`, `knowledge/`, `skills/`, or `prompts/`.
2. Add a note to `CHANGELOG.md`.
3. If the change affects output quality, update or add a sample file in `samples/`.
4. If the change affects expected output, update or add a file in `tests/`.

## File Naming

Use lowercase filenames with underscores or hyphens.

Preferred examples:

- `cashflow_calculation_rules.md`
- `category_normalization_rules.json`
- `weekly_finance_brief_prompt.md`

Avoid spaces in filenames.

## Safety Notes

Do not add files containing real account numbers, card numbers, tax IDs, private customer data, or confidential client financial records.

Use synthetic sample data for tests and examples.

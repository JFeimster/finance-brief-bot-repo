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

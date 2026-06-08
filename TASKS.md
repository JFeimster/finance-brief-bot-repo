# Tasks

This file tracks agent-friendly tasks for the Weekly Finance Brief Bot repo.

## Backlog

### Documentation

- Review `docs/` files for consistency.
- Add examples to `brief_output_spec.md`.
- Add more column mapping examples to `csv_column_mapping_guide.md`.
- Add a guide for payment processor CSV exports.

### Knowledge

- Decide which files should be uploaded to GPT Knowledge.
- Update `knowledge/uploaded_files_manifest.json` after each upload.
- Create a versioned GPT Knowledge bundle.

### Site

- Improve the static landing page.
- Add a sample brief viewer.
- Add a CSV readiness checklist widget.
- Add an examples page using files from `tests/`.
- Add a simple FAQ page.

### Prompts

- Add prompts for monthly finance summaries.
- Add prompts for advisor-to-client summaries.
- Add prompts for board/investor updates.
- Add prompts for messy CSV troubleshooting.

### Actions / API

- Expand `actions/api/openapi.yaml`.
- Add a CSV validation endpoint design.
- Add normalized transaction schema.
- Add example API errors.

### Testing

- Add expected output for multi-account sample.
- Add expected output for missing-balance CSV.
- Add expected output for multi-week comparison.
- Add regression prompt examples.

### Tooling

- Add GitHub issue templates to `.github/ISSUE_TEMPLATE/` if needed.
- Add a standard pull request template to `.github/`.
- Add tool-specific instructions for any new coding assistant used.

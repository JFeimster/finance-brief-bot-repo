# Multi-File Analysis Workflow

When multiple CSV files are uploaded, analyze each file or account separately first.

Then provide a consolidated view.

## Required Flow

1. Account/File 1 Summary
2. Account/File 2 Summary
3. Account/File 3 Summary, if applicable
4. Consolidated Cash View
5. Combined Watch Items
6. Recommended Next Actions

## Treatment Rules

If files appear to represent different accounts:

- Analyze separately.
- Consolidate inflows, outflows, and net activity.
- Avoid double-counting clear transfers.

If files appear to represent different time periods:

- Explain the date ranges before combining.
- Do not compare periods unless enough data exists.

If files appear to come from different systems:

- Explain likely source differences.
- Flag overlapping or duplicate-looking transactions.

## Consolidation Rules

When consolidating:

- Remove nothing silently.
- Flag possible overlap.
- Treat transfers carefully.
- State assumptions clearly.

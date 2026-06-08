# Data Quality Check Guide

The Data Quality Check should clearly state issues that may affect interpretation.

## Common Issues

- Missing Date column
- Missing Amount, Debit, or Credit columns
- Missing Balance column
- Mixed positive and negative conventions
- Unclear transaction descriptions
- Missing categories
- Duplicate-looking transactions
- Pending and posted transactions mixed together
- Transfers not clearly identified
- Multiple accounts combined without account labels
- Date gaps
- Overlapping periods
- Reversed or failed transactions
- Inconsistent currency formatting

## Duplicate Handling

Do not delete possible duplicates silently.

Flag duplicate-looking rows based on:

- Same date
- Same amount
- Similar description
- Same vendor
- Same account

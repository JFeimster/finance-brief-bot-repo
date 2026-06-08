# CSV Column Mapping Guide

The GPT should parse finance CSV files flexibly and infer meaning from common columns.

## Common Column Interpretations

| Column | Meaning |
|---|---|
| Date | Transaction date |
| Description | Main transaction description |
| Memo | Supplemental transaction details |
| Vendor | Payee or merchant |
| Customer | Source of incoming payment |
| Category | User-provided accounting or bookkeeping category |
| Amount | Transaction amount, often signed |
| Debit | Outgoing cash |
| Credit | Incoming cash |
| Balance | Account balance after transaction |
| Account | Bank, card, processor, or ledger account |
| Transaction Type | Payment, deposit, fee, transfer, refund, etc. |
| Status | Posted, pending, cleared, failed, reversed, etc. |

## Amount Sign Rules

If a file has a single Amount column:

- Positive values usually indicate inflows.
- Negative values usually indicate outflows.
- If descriptions or categories suggest the opposite, flag uncertainty in the Data Quality Check.

If a file has Debit and Credit columns:

- Debit usually means outgoing cash.
- Credit usually means incoming cash.
- Empty or zero values should be ignored.

If both Amount and Debit/Credit are present:

- Prefer Debit/Credit when they are populated consistently.
- Mention this assumption in the Data Quality Check.

## Balance Rules

If balance data is present:

- Use earliest balance as opening cash if appropriate.
- Use latest balance as ending cash if appropriate.
- Check whether balance direction matches transaction signs.

If balance data is unavailable:

- Do not imply an opening or ending cash position.
- Summarize net activity only.

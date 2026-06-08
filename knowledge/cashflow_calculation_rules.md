# Cash Flow Calculation Rules

## Purpose

This file defines how Weekly Finance Brief Bot should calculate and explain core cash-flow metrics from uploaded CSVs, pasted transaction data, or normalized transaction summaries.

The GPT should use this file together with:

- csv_column_mapping_guide.md
- category_normalization_rules.json
- brief_output_spec.md
- data_quality_check_guide.md

The goal is to produce useful cash-flow analysis without inventing missing numbers or overstating confidence.

## Core Metrics

When data supports it, calculate:

- Total inflows
- Total outflows
- Net cash movement
- Opening cash balance
- Ending cash balance
- Balance change
- Largest incoming transactions
- Largest outgoing transactions
- Major spending categories
- Possible recurring obligations
- Possible transfers
- Potential duplicate-looking transactions
- Data quality limitations

## Calculation Priority

Use this order when calculating:

1. Identify date range.
2. Determine transaction direction.
3. Separate inflows, outflows, and transfers.
4. Exclude or flag pending/failed/reversed transactions.
5. Calculate totals.
6. Reconcile with balances when possible.
7. Identify large or unusual items.
8. Categorize practical buckets.
9. Flag data quality limitations.

## Inflow Definition

Inflows are cash movements into the account or business.

Common inflows include:

- Customer payments
- Invoice payments
- Sales deposits
- ACH credits
- Platform payouts
- Merchant processor deposits
- Refunds received from vendors
- Owner contributions, if clearly labeled
- Loan proceeds, if clearly identified
- Tax refunds, if clearly identified
- Insurance reimbursements, if clearly identified

## Operating vs Non-Operating Inflows

Separate operating revenue from non-operating inflows when possible.

Operating inflows include:

- Customer payments
- Sales deposits
- Invoice payments
- Platform payouts
- Marketplace payouts
- Subscription revenue

Non-operating inflows include:

- Loan proceeds
- Owner contributions
- Transfers from another business account
- Refunds
- Insurance reimbursements
- Tax refunds

If the distinction is unclear, summarize total inflows and flag classification uncertainty.

## Outflow Definition

Outflows are cash movements out of the account or business.

Common outflows include:

- Payroll
- Contractor payments
- Rent or facilities
- Utilities
- Software subscriptions
- Marketing and advertising
- Debt service
- Taxes
- Inventory or cost of goods sold
- Insurance
- Professional services
- Travel and meals
- Owner draws or distributions
- Fees
- Refunds issued
- Chargebacks
- Transfers out, if external or unclear

## Transfer Treatment

Transfers should not be treated as operating revenue or operating expense when they clearly move cash between accounts belonging to the same business.

If transfer status is clear:

- Exclude from operating inflow/outflow commentary.
- Mention transfer activity separately if material.

If transfer status is unclear:

- Include in net cash movement only if the file represents one account and cash actually moved in or out of that account.
- Do not describe it as revenue or expense.
- Flag it in Data Quality Check.

If multiple account files are uploaded:

- Look for matching transfer pairs.
- Avoid double-counting internal movement.
- Explain assumptions before consolidating.

## Net Cash Movement

Formula:

Total Inflows - Total Outflows = Net Cash Movement

Use absolute values for outflows.

Example:

Total inflows: $10,000  
Total outflows: $7,500  
Net cash movement: $2,500

If outflows exceed inflows:

Total inflows: $10,000  
Total outflows: $12,500  
Net cash movement: -$2,500

## Balance-Based Cash Position

If reliable balances exist:

- Opening cash = balance at or near the beginning of the review period
- Ending cash = balance at or near the end of the review period
- Balance change = ending cash - opening cash

Then compare balance change against net cash movement.

If they match or are close:

- Confidence is higher.

If they do not match:

- Flag a reconciliation issue.
- Possible causes may include missing transactions, pending items, sort order, excluded transfers, fees, or export limitations.

## Balance Reliability Rules

Balance data is more reliable when:

- There is a clear balance column.
- Transactions are sorted consistently.
- Statuses are posted or cleared.
- The balance changes align with transaction signs.
- The date range is complete.

Balance data is less reliable when:

- The file includes pending transactions.
- The file is sorted ambiguously.
- Balance values are missing on some rows.
- Multiple accounts are mixed.
- Balance movement contradicts transaction signs.
- The file is a processor or accounting export rather than a bank statement.

If balance reliability is questionable, say so.

## Missing Balance Rules

If reliable balances do not exist:

- Do not calculate opening cash.
- Do not calculate ending cash.
- Do not claim actual cash on hand.
- Summarize net activity only.
- Recommend providing beginning and ending balances next time.

Required language:

The file does not include reliable balance data, so this brief summarizes net activity rather than confirmed cash position.

## Largest Transaction Rules

Identify largest inflows and outflows when useful.

Rules:

- Use absolute value for ranking outflows.
- Do not expose full account numbers or sensitive identifiers.
- Group obviously related repeated transactions when more useful than listing each one.
- Avoid overwhelming the user with too many transaction details.
- Prefer top 3 to 5 items unless the user asks for more.

## Category Summary Rules

Use practical categories rather than overfitting.

Default buckets:

- Revenue / Inflows
- Payroll
- Contractors
- Rent / Facilities
- Software / Subscriptions
- Marketing / Advertising
- Debt Service
- Taxes
- Inventory / COGS
- Professional Services
- Insurance
- Travel / Meals
- Owner Draws / Distributions
- Transfers
- Refunds / Reversals / Chargebacks
- Bank Fees
- Other / Uncategorized

If the CSV includes categories:

- Use them when they appear reliable.
- Normalize overly specific labels into practical buckets.
- Preserve uncertainty for unclear categories.

## Recurring Obligation Rules

Flag possible recurring obligations when descriptions, vendors, or timing suggest repeat payments.

Examples:

- Payroll provider payments
- Rent
- Utilities
- Software subscriptions
- Insurance premiums
- Debt payments
- Merchant cash advance debits
- Loan repayments
- Contractor retainers

If the file covers only one week, do not claim a transaction is definitely recurring unless the description or user context supports it.

Use cautious language:

This appears recurring, but confirmation would require prior-period data.

## Debt-Service Rules

Debt-service activity can create cash-flow pressure.

Potential indicators:

- Loan payment
- Financing repayment
- Advance repayment
- MCA
- Daily ACH
- Weekly ACH
- Line of credit payment
- Interest payment
- Principal payment

Rules:

- Do not identify a specific product unless the description clearly says it.
- Do not advise the user to stop paying debt.
- Do not make refinancing recommendations.
- Flag heavy or frequent payments as a watch item when supported by data.
- Keep language preparatory and operational.

## Processor Payout Rules

When processor data and bank data are both present:

- Do not double-count gross processor sales and bank payout deposits.
- Treat processor payouts as cash deposits into the bank account.
- Treat processor fees as reductions or outflows when visible.
- Treat refunds and chargebacks carefully.
- If both gross sales and net payouts exist, explain which number is being used.

## Refund and Chargeback Rules

Classify carefully:

- Refund received from vendor = inflow
- Refund issued to customer = outflow or revenue reduction
- Chargeback = outflow or revenue reversal
- Reversal = may offset prior transaction
- Returned payment = possible risk item

If context is unclear, flag it.

## Pending, Failed, and Reversed Transactions

Default analysis should focus on posted, cleared, completed, or settled transactions.

Pending transactions:

- May be mentioned as upcoming or not-yet-final.
- Should not be mixed into confirmed totals unless clearly requested.

Failed, reversed, or returned transactions:

- Should be flagged.
- Should not be treated as successful inflows or outflows without qualification.

## Duplicate-Looking Transaction Rules

Possible duplicate indicators:

- Same date
- Same amount
- Same description/vendor
- Same account
- Repeated transaction ID
- Multiple identical rows

Rules:

- Do not delete duplicates silently.
- Do not automatically exclude them.
- Flag them in Data Quality Check.
- If duplicates materially affect totals, state that totals may be overstated.

## Negative Cash Movement Interpretation

If net cash movement is negative:

- State the amount.
- Explain that outflows exceeded inflows for the period.
- Identify the main drivers.
- Avoid panic language.
- Add a watch item if material.
- Recommend practical review steps.

Do not say the business is failing or insolvent based on one period.

## Positive Cash Movement Interpretation

If net cash movement is positive:

- State the amount.
- Explain that inflows exceeded outflows for the period.
- Identify main drivers.
- Watch for one-time deposits.
- Avoid overconfidence.

Do not say the business is healthy or safe based only on one period.

## Multi-File Calculation Rules

If multiple files are uploaded:

1. Calculate each file separately.
2. Identify account/source type.
3. Flag likely overlap or transfers.
4. Consolidate only after separate review.
5. Explain consolidation assumptions.
6. Avoid double-counting processor deposits, transfers, or duplicate exports.

## Multi-Period Calculation Rules

If multiple periods are available, compare:

- Total inflows by period
- Total outflows by period
- Net cash movement by period
- Major category changes
- Debt-service frequency
- Revenue concentration
- Recurring obligations
- Data quality changes

Do not infer trends from a single period.

## Rounding Rules

Use readable financial formatting.

Recommended:

- $1,250
- $1,250.75 when cents matter
- -$850
- about $1.2K only when summarizing casually

Do not overstate precision if the source data is messy.

## Assumption Rules

Always state assumptions when:

- Sign convention is inferred.
- Debit/Credit mapping is inferred.
- Balances are missing.
- Transfers are unclear.
- Categories are normalized.
- Processor gross/net amounts are unclear.
- Multiple files are consolidated.
- Pending transactions are included or excluded.

## What Not To Do

Do not:

- Invent totals.
- Invent balances.
- Treat transfers as revenue without confirmation.
- Double-count processor and bank data.
- Ignore failed or reversed transactions.
- Delete duplicate-looking rows silently.
- Make profitability claims from cash movement alone.
- Make funding approval claims.
- Provide tax, legal, accounting, investment, lending, or underwriting advice.

## Final Quality Standard

A good cash-flow calculation should make the owner understand:

1. What came in.
2. What went out.
3. Whether cash movement was positive or negative.
4. Whether actual balance data supports the conclusion.
5. What assumptions limit confidence.
6. What deserves review before next Monday.

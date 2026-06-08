# Endpoint Design Notes

Potential future endpoints:

## `GET /health`

Confirms the API is reachable.

## `POST /brief/generate`

Accepts normalized transaction data and returns a Weekly Finance Brief in Markdown.

## `POST /csv/validate`

Checks whether a CSV has usable finance columns.

## `POST /transactions/normalize`

Maps source columns and categories into a normalized transaction format.

## `POST /watch-items/detect`

Returns watch items based on cash-flow and transaction patterns.

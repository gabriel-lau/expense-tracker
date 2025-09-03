-- SQL initialization for Expense Tracker
-- Table: Expenses

CREATE TABLE IF NOT EXISTS "Expenses" (
    "Id" UUID PRIMARY KEY,
    "Description" TEXT NOT NULL,
    "Amount" NUMERIC NOT NULL,
    "Date" TIMESTAMPTZ NOT NULL
);

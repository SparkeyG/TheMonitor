-- Revert TheMonitor:appschema from pg

BEGIN;
DROP SCHEMA rebekah;
-- XXX Add DDLs here.

COMMIT;

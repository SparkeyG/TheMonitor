-- Revert TheMonitor:chronicles from pg

BEGIN;

-- XXX Add DDLs here.
DROP TABLE rebekah.chronicles;
COMMIT;

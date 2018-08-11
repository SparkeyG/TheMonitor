-- Revert TheMonitor:insert_chronicle from pg

BEGIN;

DROP FUNCTION rebekah.insert_chronicle(TEXT, TEXT, TEXT, TEXT);
COMMIT;

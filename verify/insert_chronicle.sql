-- Verify TheMonitor:insert_chronicle on pg

BEGIN;

SELECT has_function_privilege('rebekah.insert_chronicle(text,text,text,text)', 'execute');
ROLLBACK;

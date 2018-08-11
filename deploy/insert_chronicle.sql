-- Deploy TheMonitor:insert_chronicle to pg
-- requires: chronicles
-- requires: appschema

BEGIN;

CREATE OR REPLACE FUNCTION rebekah.insert_chronicle(
    name TEXT,
    ic_location TEXT,
    ooc_location TEXT,
    genre TEXT
) RETURNS VOID LANGUAGE SQL SECURITY DEFINER AS $$
    INSERT INTO rebekah.chronicles VALUES ($1, $2, $3, $4);
$$;

COMMIT;

-- Deploy TheMonitor:chronicles to pg
-- requires: appschema

BEGIN;

-- XXX Add DDLs here.
SET client_min_messages = 'warning';

CREATE TABLE rebekah.chronicles (
    name  TEXT        PRIMARY KEY,
    ic_location  TEXT        NOT NULL,
    ooc_location  TEXT        NOT NULL,
    genre  TEXT        NOT NULL,
    timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMIT;

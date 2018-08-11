-- Verify TheMonitor:chronicles on pg

BEGIN;

-- XXX Add verifications here.
SELECT name, ic_location, ooc_location, genre, timestamp
  FROM rebekah.chronicles
 WHERE false;
ROLLBACK;

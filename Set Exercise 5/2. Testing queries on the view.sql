-- Query tests on the CW1.TrailView

-- Output all Easy trails
SELECT * FROM CW1.TrailView
WHERE difficulty = 'Easy';

-- Output all Circular trails
SELECT * FROM CW1.TrailView
WHERE trail_type = 'circular';

-- Output all Plymouth trails
SELECT * FROM CW1.TrailView
WHERE town = 'Plymouth';
-- OR ---
SELECT * FROM CW1.TrailView
WHERE location_id = 0;

-- Output all Kid-friendly trails
SELECT * FROM CW1.TrailView
WHERE features LIKE '%Kid-friendly%'; -- Contains pattern 'Kid-friendly'

-- % Wildcard
-- https://learn.microsoft.com/en-us/sql/t-sql/language-elements/percent-character-wildcard-character-s-to-match-transact-sql?view=sql-server-ver16
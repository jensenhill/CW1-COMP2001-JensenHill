--SELECT * FROM CW1.TrailView;
--DROP VIEW CW1.TrailView;

-- Create the view under the CW1 schema
CREATE VIEW CW1.TrailView AS
SELECT
    t.trail_id,
    t.trail_name,
    t.location_id,
    l.town,
    l.county,
    l.country,
    t.difficulty,
    t.distance,
    t.elevation_gain,
    t.estimated_time,
    t.trail_type,
    t.last_updated,
    STRING_AGG(f.feature_name, ', ') AS features
FROM CW1.Trail t
INNER JOIN CW1.Location l ON t.location_id = l.location_id
INNER JOIN CW1.Trail_Feature tf ON t.trail_id = tf.trail_id
INNER JOIN CW1.Feature f ON tf.feature_id = f.feature_id
GROUP BY
    t.trail_id,
    t.trail_name,
    t.location_id,
    l.town,
    l.county,
    l.country,
    t.difficulty,
    t.distance,
    t.elevation_gain,
    t.estimated_time,
    t.trail_type,
    t.last_updated;

-- String Aggregation
-- https://learn.microsoft.com/en-us/sql/t-sql/functions/string-agg-transact-sql?view=sql-server-ver16
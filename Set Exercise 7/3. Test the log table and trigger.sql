-- The following tests are for the trigger that creates a log entry after the insertion of a new trail.
-- log_id is to remain sequential, so this would be reflected in any 'update' or 'delete' procedures for trails. Similar theory to the CRUD procedures handling location_id in the Location table.

-- 1. Test adding new records to the Trail table.
--    Notice how, when the table is empty, the log_id automatically begins from 0.
SELECT * FROM CW1.TrailLog; -- See that table begins empty
EXEC CW1.CreateTrail @trail_name = 'Plymouth Gin Walk', @owner_id = 6, @difficulty = 'Easy', @location_id = 0, @distance = 1.1, @elevation_gain = 0.24, @estimated_time = 30, @trail_type = 'Loop', @last_updated = '2024-03-01 10:00:00';
EXEC CW1.CreateTrail @trail_name = 'Meadow Views', @owner_id = 4, @difficulty = 'Hard', @location_id = 6, @distance = 5.1, @elevation_gain = 12, @estimated_time = 300, @trail_type = 'Circular', @last_updated = '2020-06-06 23:15:00';
EXEC CW1.CreateTrail @trail_name = 'Cambridge University', @owner_id = 2, @difficulty = 'Moderate', @location_id = 9, @distance = 3.5, @elevation_gain = 67, @estimated_time = 70, @trail_type = 'Loop', @last_updated = '2010-12-12 13:45:00';
SELECT * FROM CW1.TrailLog; -- See that table is populated

-- 2. We can take it one step further and create a view to see the forename and surname of the creator.
CREATE VIEW CW1.TrailLogView AS
SELECT l.trail_id,l.trail_name,o.owner_forename,o.owner_surname,l.creation_date
FROM CW1.TrailLog l INNER JOIN CW1.Owner o ON l.owner_id = o.owner_id;
SELECT * FROM CW1.TrailLogView;
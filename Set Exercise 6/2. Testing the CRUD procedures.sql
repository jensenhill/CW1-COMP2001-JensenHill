-- The following queries test the (CRUD) procedures for the Location table.
-- Execute the tests one at a time, e.g. Section 1 (Testing the CreateLocation procedure) and then Section 2 (Testing the ReadLocation procedure), etc.
-- It is recommended that you undo the actions performed by the test, provided in the comments beneath the applicable tests.

---------------------------------------------
-- 1. Testing the CreateLocation procedure --
---------------------------------------------

-- a. Creating a NEW town called Trowbridge in Wiltshire, England
SELECT * FROM CW1.Location WHERE county = 'Wiltshire'; -- Table BEFORE creating new location
EXEC CW1.CreateLocation @town = 'Trowbridge', @county = 'Wiltshire', @country = 'England';
SELECT * FROM CW1.Location WHERE county = 'Wiltshire'; -- Table AFTER creating new location
-- Undo: DELETE FROM CW1.Location WHERE town = 'Trowbridge' AND county = 'Wiltshire' AND country = 'England';

-- b. Attempting to create an invalid location (place name that includes digits)
EXEC CW1.CreateLocation @town = 'Tr0wbr1dg3', @county = 'Wiltshire', @country = 'England';
EXEC CW1.CreateLocation @town = 'Trowbridge', @county = 'W1ltsh1r3', @country = 'England';
EXEC CW1.CreateLocation @town = 'Trowbridge', @county = 'Wiltshire', @country = '3ngland';

-- c. Attempting to create a location that already exists
EXEC CW1.CreateLocation @town = 'Plymouth', @county = 'Devon', @country = 'England';


---------------------------------------------
--- 2. Testing the ReadLocation procedure ---
---------------------------------------------

-- a. Reading all locations in Devon
EXEC CW1.ReadLocation @county = 'Devon';

-- b. Reading the record of Location ID 4
EXEC CW1.ReadLocation @location_id = 5;

-- c. Attempting to read the record of an invalid place name
EXEC CW1.ReadLocation @country = '3ngland';


---------------------------------------------
-- 3. Testing the UpdateLocation procedure --
---------------------------------------------

-- a. Replacing the name of Plymouth with Exeter
SELECT * FROM CW1.Location WHERE location_id = 0; -- Before update
EXEC CW1.UpdateLocation @location_id = 0, @town = 'Exeter';
SELECT * FROM CW1.Location WHERE location_id = 0; -- After update
-- Undo: EXEC CW1.UpdateLocation @location_id = 0, @town = 'Plymouth';

-- b. Replacing the county and country of the UK's Plymouth to become the USA's Plymouth
SELECT * FROM CW1.Location WHERE location_id = 0; -- Before update
EXEC CW1.UpdateLocation @location_id = 0, @county = 'Massachusetts', @country = 'United States of America';
SELECT * FROM CW1.Location WHERE location_id = 0; -- After update
-- Undo: EXEC CW1.UpdateLocation @location_id = 0, @county = 'Devon', @country = 'England';

-- c. Attempting to make changes that would duplicate a record
EXEC CW1.UpdateLocation @location_id = 2, @town = 'Bath', @county = 'Somerset', @country = 'England';

-- d. Attempting to update a location to an invalid place name
EXEC CW1.UpdateLocation @location_id = 9, @town = 'Cambr1dg3', @county = 'Cambr1dg3sh1r3', @country = 'England';

-- e. Attempting to update a location that does not exist
EXEC CW1.UpdateLocation @location_id = -1, @town = 'Bude', @county = 'Devon', @country = 'England';


---------------------------------------------
-- 4. Testing the DeleteLocation procedure --
---------------------------------------------

-- a. Deleting the Yeovil location (first we must add it)
EXEC CW1.CreateLocation @town = 'Yeovil', @county = 'Somerset', @country = 'England';
EXEC CW1.CreateLocation @town = 'Truro', @county = 'Cornwall', @country = 'England';
SELECT * FROM CW1.Location; -- Before update

DECLARE @max_id INT;
SELECT @max_id = MAX(location_id) - 1 FROM CW1.Location; -- (Yeovil is penultimate record)

EXEC CW1.DeleteLocation @location_id = @max_id;
SELECT * FROM CW1.Location; -- After update -> Notice how the Location ID of the next record, Truro, has its Location ID adjusted to remain sequential.
-- Undo: DELETE FROM CW1.Location WHERE town = 'Truro' AND county = 'Cornwall' AND country = 'England';

-- b. Attempting to delete a location that does not exist
EXEC CW1.DeleteLocation @location_id = -1;
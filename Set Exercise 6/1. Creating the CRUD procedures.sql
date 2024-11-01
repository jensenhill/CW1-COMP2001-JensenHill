-- Coursework Set Exercise 6 states CRUD functionality is to be added for one of the tables.
-- The following procedures handle CRUD functionality for the Location table.

-- 1. Create a location record
-- EXEC CW1.CreateLocation [@town = 'town', @county = 'county', @country = 'country'];
GO
CREATE PROCEDURE CW1.CreateLocation(
   @town VARCHAR(50),
   @county VARCHAR(50),
   @country VARCHAR(50))
AS
BEGIN
    -- Type Check (not-numeric)
    IF @town LIKE '%[0-9]%' OR @county LIKE '%[0-9]%' OR @country LIKE '%[0-9]%'
    BEGIN
        RAISERROR('Error creating record. Place name must not contain numbers.',16,1);
        RETURN;
    END

    -- Check if the location is new
    IF EXISTS (SELECT 1 FROM CW1.Location WHERE town = @town AND county = @county AND country = @country)
    BEGIN
        RAISERROR('Error creating record. The location already exists.',16,1);
        RETURN;
    END

    -- Find last Location ID + 1
    DECLARE @max_id INT;
    SELECT @max_id = ISNULL(MAX(location_id),-1) + 1 FROM CW1.Location; -- Handle if the table is empty (ID starts from 0)

    INSERT INTO CW1.Location(location_id,town,county,country)
    VALUES (@max_id, @town, @county, @country);
END;

-- 2. Read for location records
-- EXEC CW1.ReadLocation [@location_id = 'location_id' | @town = 'town' | @county = 'county' | @country = 'country'];
GO
CREATE PROCEDURE CW1.ReadLocation(
    @location_id INT = NULL,
    @town VARCHAR(50) = NULL,
    @county VARCHAR(50) = NULL,
    @country VARCHAR(50) = NULL)
AS
BEGIN
    
    -- Type Check (not-numeric)
    IF @town LIKE '%[0-9]%' OR @county LIKE '%[0-9]%' OR @country LIKE '%[0-9]%'
    BEGIN
        RAISERROR('Error reading record. Place name must not contain numbers.',16,1);
        RETURN;
    END
    
    -- Consider user may not provide a town, county, etc.
    SELECT location_id,town,county,country FROM CW1.Location WHERE
        (@location_id IS NULL OR location_id = @location_id)
        AND (@town IS NULL OR town = @town)
        AND (@county IS NULL OR county = @county)
        AND (@country IS NULL OR country = @country);
END;

-- 3. Update a location record
-- EXEC CW1.UpdateLocation [@location_id = 'location_id', @town = 'town' | @county = 'county' | @country = 'country'];
GO
CREATE PROCEDURE CW1.UpdateLocation(
    @location_id INT = NULL,
    @town VARCHAR(50) = NULL,
    @county VARCHAR(50) = NULL,
    @country VARCHAR(50) = NULL)
AS
BEGIN
    -- Check if the location (by ID) exists
    IF NOT EXISTS (SELECT 1 FROM CW1.Location WHERE location_id = @location_id)
    BEGIN
        RAISERROR('Error updating record. The provided Location ID does not exist.',16,1);
        RETURN;
    END

    -- Type Check (not-numeric)
    IF @town LIKE '%[0-9]%' OR @county LIKE '%[0-9]%' OR @country LIKE '%[0-9]%'
    BEGIN
        RAISERROR('Error updating record. Place name must not contain numbers.',16,1);
        RETURN;
    END

    -- Consider user may not provide a town, county, etc.
    -- Where a place name remains null (no update provided), use existing place name
    -- COALESCE() - https://learn.microsoft.com/en-us/sql/t-sql/language-elements/coalesce-transact-sql?view=sql-server-ver16
    
    -- Check if the location is new
    IF EXISTS (SELECT 1 FROM CW1.Location WHERE COALESCE(@town, town) = town AND COALESCE(@county,county) = county AND COALESCE(@country,country) = country)
    BEGIN
        RAISERROR('Error updating record. You are trying to update a record into one that already exists.',16,1);
        RETURN;
    END

    UPDATE CW1.Location
    SET
        town = COALESCE(@town, town),
        county = COALESCE(@county,county),
        country = COALESCE(@country,country)
    WHERE location_id = @location_id;
END;

-- 4. Delete a location record
-- EXEC CW1.DeleteLocation [@location_id = 'location_id'];
GO
CREATE PROCEDURE CW1.DeleteLocation(@location_id INT)
AS
BEGIN
    -- Check location of location ID exists
    IF NOT EXISTS (SELECT 1 FROM CW1.Location WHERE @location_id = location_id)
    BEGIN
        RAISERROR('Error deleting record. A location of that Location ID does not exist.',16,1);
        RETURN;
    END

    DELETE FROM CW1.Location WHERE location_id = @location_id;

    -- Update all following Location IDs to keep them sequential
    UPDATE CW1.Location
    SET location_id = location_id - 1
    WHERE @location_id < location_id;

END;

--DROP PROCEDURE CW1.CreateLocation;
--DROP PROCEDURE CW1.UpdateLocation;
--DROP PROCEDURE CW1.ReadLocation;
--DROP PROCEDURE CW1.DeleteLocation;

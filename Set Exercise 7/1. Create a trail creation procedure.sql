-- Trigger will execute, adding a new log record, when a new trail is added.
-- You can do this using a mannual SQL insertion or the stored procedure provided below...

-- 1. Create a Trail record
-- EXEC CW1.CreateTrail [@trail_name = 'name', @owner_id = owner id, @difficulty = 'difficulty', @location_id = location_id, @distance = distance, @elevation_gain = elevation, @estimated_time = time, @trail_type = 'type', @last_updated = 'last updated'];
GO
CREATE PROCEDURE CW1.CreateTrail(
   @trail_name VARCHAR(60),
   @owner_id INT,
   @difficulty VARCHAR(10),
   @location_id INT,
   @distance DECIMAL(5,2),
   @elevation_gain DECIMAL (6,2),
   @estimated_time INT,
   @trail_type VARCHAR(15),
   @last_updated SMALLDATETIME)
AS
BEGIN

    -- Some validation is already handled, e.g. error is thrown if trail_id is not an integer.
    -- Remaining validation is performed below.

    -- Type Check (not-numeric)
    IF @difficulty LIKE '%[0-9]%' OR @trail_type LIKE '%[0-9]%'
    BEGIN
        RAISERROR('Error creating trail. Trail name, difficulty and trail type must not contain digits.',16,1);
        RETURN;
    END

    -- Check if estimated time is less than 10000
    IF @estimated_time > 10000
    BEGIN
        RAISERROR('Error creating trail. Estimated time (mins) must be less than or equal to 10,0000.',16,1);
        RETURN;
    END

    -- Check if date of last update is not in the future
    IF @last_updated > GETDATE()
    BEGIN
        RAISERROR('Error creating trail. Date of last update cannot be in the future.',16,1);
        RETURN;
    END

    --Trail ID should automatically be assigned; the user does not need to assign a trail_id.
    -- Find last Trail ID + 1 (similar to Location, it assumes trail_id(s) are sequential)
    DECLARE @max_id INT;
    SELECT @max_id = ISNULL(MAX(trail_id),-1) + 1 FROM CW1.Trail; -- Handle if table is empty

    INSERT INTO CW1.Trail(trail_id,trail_name,owner_id,difficulty,location_id,distance,elevation_gain,estimated_time,trail_type,last_updated)
    VALUES (@max_id, @trail_name,@owner_id, @difficulty, @location_id, @distance, @elevation_gain, @estimated_time, @trail_type, @last_updated);
END;
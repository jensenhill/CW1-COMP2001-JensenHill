-- Create the log table for all new trails created
CREATE TABLE CW1.TrailLog(
    log_id INT NOT NULL,
    trail_id INT NOT NULL,
    owner_id INT NOT NULL,
    trail_name VARCHAR(60) NOT NULL,
    creation_date SMALLDATETIME,

    CONSTRAINT PK_TrailLog PRIMARY KEY (log_id)
);

-- Create the trigger to log addition of trails
GO
CREATE TRIGGER CW1.LogTrail ON CW1.Trail
AFTER INSERT
AS
BEGIN

    DECLARE @current_date SMALLDATETIME = GETDATE(); --Get the current SMALLDATETIME
    DECLARE @max_id INT; -- Get next log_id
    SELECT @max_id = ISNULL(MAX(log_id),-1) + 1 FROM CW1.TrailLog; -- Handle if the table is empty
    INSERT INTO CW1.TrailLog(log_id,trail_id,owner_id,trail_name,creation_date)
    SELECT @max_id,trail_id,owner_id,trail_name, @current_date
    FROM inserted;
END;
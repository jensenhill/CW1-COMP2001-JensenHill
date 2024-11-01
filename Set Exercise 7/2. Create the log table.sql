-- Create the log table for all new trails created
CREATE TABLE CW1.TrailLog(
    trail_id INT NOT NULL,
    trail_name VARCHAR(60) NOT NULL,
    creator VARCHAR(40) NOT NULL,
    creation_date SMALLDATETIME,

    CONSTRAINT PK_TrailLog PRIMARY KEY (trail_id)
);

-- Create the trigger to log addition of trails
GO
CREATE TRIGGER CW1.LogTrail ON CW1.Trail
AFTER INSERT
AS
BEGIN

    INSERT INTO CW1.TrailLog(trail_id, trail_name, creator,creation_date)
    VALUES(trail_id,@variable_creator, )



END;
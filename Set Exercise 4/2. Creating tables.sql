--DROP TABLE CW1.Trail
--DROP TABLE CW1.Location
--DROP TABLE CW1.Trail_Feature
--DROP TABLE CW1.Feature
--DROP TABLE CW1.Owner

-- Create the Owner table in the CW1 schema
CREATE TABLE CW1.Owner (
    owner_id INT NOT NULL, --PK
    owner_forename VARCHAR(50) NOT NULL,
    owner_surname VARCHAR(100) NOT NULL,

    CONSTRAINT PK_Owner PRIMARY KEY (owner_id)
    -- Validation would be performed by stored procedure
);

-- Create the Location table in the CW1 schema
CREATE TABLE CW1.Location (
    location_id INT NOT NULL,
    town VARCHAR(50) NOT NULL,
    county VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,

    CONSTRAINT PK_Location PRIMARY KEY (location_id)
    -- Validation has be performed by stored procedure (Set Exercise 6)
);

-- Create the Trail table in the CW1 schema
CREATE TABLE CW1.Trail (
    trail_id INT NOT NULL, --PK
    trail_name VARCHAR(60) NOT NULL,
    owner_id INT NOT NULL, --FK
    difficulty VARCHAR(10) NOT NULL,
    location_id INT NOT NULL, --FK
    distance DECIMAL(5,2) NOT NULL,
    elevation_gain DECIMAL(6,2) NOT NULL,
    estimated_time INT NOT NULL,
    trail_type VARCHAR(15) NOT NULL,
    last_updated SMALLDATETIME,

    CONSTRAINT PK_Trail PRIMARY KEY (trail_id),
    CONSTRAINT FK_TrailLocation FOREIGN KEY (location_id) REFERENCES CW1.Location(location_id),
    CONSTRAINT FK_Owner FOREIGN KEY (owner_id) REFERENCES CW1.Owner(owner_id)
    -- Validation has be performed by stored procedure (Set Exercise 7)
);

-- Create the Feature table in the CW1 schema
CREATE TABLE CW1.Feature (
    feature_id INT NOT NULL, --PK
    feature_name VARCHAR(20),

    CONSTRAINT PK_Feature PRIMARY KEY (feature_id)
    -- Validation would be performed by stored procedure
);

-- Create the Trail_Feature (link) table in the CW1 schema
CREATE TABLE CW1.Trail_Feature (
    trail_id INT NOT NULL, --PK
    feature_id INT NOT NULL, --FK

    CONSTRAINT PK_Trail_Feature PRIMARY KEY (trail_id, feature_id),
    -- Validation would be performed by stored procedure
);
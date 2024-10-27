--DELETE FROM CW1.Feature;
--DELETE FROM CW1.Trail;
--DELETE FROM CW1.Trail_Feature;
--DELETE FROM CW1.Location;

-- Fill the Feature table with trail features
INSERT INTO CW1.Feature(feature_id,feature_name)
VALUES
(0, 'Partially paved'),
(1, 'Kid-friendly'),
(2, 'Dog-friendly'),
(3, 'Rail trails'),
(4, 'Wildlife'),
(5, 'Wildflowers'),
(6, 'Views'),
(7, 'Rivers'),
(8, 'Forests'),
(9, 'Caves');


-- Create sample data for the Location table
INSERT INTO CW1.Location(location_id,town,county,country)
VALUES
(0,'Plymouth','Devon','England'),
(1,'Liskeard','Cornwall','England'),
(2,'Dulverton','Somerset','England'),
(3,'Porlock','Devon','England'),
(4,'Devizes','Wiltshire','England');


-- Create sample data for the Trail table
INSERT INTO CW1.Trail(trail_id,trail_name,difficulty,location_id,distance,elevation_gain,estimated_time,trail_type,last_updated)
VALUES
(0,'Plymouth Barbican Walk','Easy',0,0.5,2.2,20,'Loop',CONVERT(SMALLDATETIME, '2023-02-03 12:30:00')),
(1,'Plymouth Marathon [2024]','Hard',0,42.2,60.12,270,'Circular',CONVERT(SMALLDATETIME, '2024-01-10 17:49:00')),
(2,'Liskeard Centre','Medium',1,2.9,14.8,38,'Out-and-back',CONVERT(SMALLDATETIME, '2018-12-11 10:00:00')),
(3,'Exmoor Hike','Hard',2,28.14,105,650,'Loop',CONVERT(SMALLDATETIME, '2019-01-31 08:40:00')),
(4,'Porlock Marsh Historic Walk','Medium',3,16.05,19.50,120,'Circular',CONVERT(SMALLDATETIME, '2022-04-15 18:10:00')),
(5,'Historic Buildings of Devizes','Easy',4,2.75,3.10,28,'Out-and-back',CONVERT(SMALLDATETIME, '2021-12-07 21:55:00'));

-- Create sample data for the Trail_Feature table
INSERT INTO CW1.Trail_Feature(trail_id,feature_id)
VALUES
(0,0), --Trail 0
(0,1), --Trail 0
(1,2), --Trail 1
(1,3), --Trail 1
(2,4), --Trail 2
(2,5), --Trail 2
(3,6), --Trail 3
(3,7), --Trail 3
(4,8), --Trail 4
(4,9), --Trail 4
(5,1), --Trail 5
(5,2); --Trail 5
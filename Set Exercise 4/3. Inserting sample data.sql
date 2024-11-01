--DELETE FROM CW1.Feature;
--DELETE FROM CW1.Trail;
--DELETE FROM CW1.Trail_Feature;
--DELETE FROM CW1.Location;
--DELETE FROM CW1.Owner;

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
(3,'Lynmouth','Devon','England'),
(4,'Devizes','Wiltshire','England'),
(5,'Cheltenham','Gloucestershire','England'),
(6,'Cricklade','Wiltshire','England'),
(7, 'Bath','Somerset','England'),
(8, 'Brighton','Sussex','England'),
(9, 'Cambridge','Cambridgeshire','England'),
(10, 'Cheddar','Somerset','England');

-- Create sample data for the Owner table
INSERT INTO CW1.Owner(owner_id,owner_forename,owner_surname)
VALUES
(0,'William','Hartnell'),
(1,'Patrick','Troughton'),
(2,'Jon','Pertwee'),
(3,'Tom','Baker'),
(4,'Peter','Davison'),
(5,'Colin','Baker'),
(6,'Sylvester','McCoy');

-- Create sample data for the Trail table
INSERT INTO CW1.Trail(trail_id,trail_name,owner_id,difficulty,location_id,distance,elevation_gain,estimated_time,trail_type,last_updated)
VALUES
(0,'Plymouth Barbican Walk',0,'Easy',0,0.5,2.2,20,'Loop',CONVERT(SMALLDATETIME, '2023-02-03 12:30:00')),
(1,'Plymouth Marathon [2024]',1,'Hard',0,42.2,60.12,270,'Circular',CONVERT(SMALLDATETIME, '2024-01-10 17:49:00')),
(2,'Liskeard Centre',2,'Medium',1,2.9,14.8,38,'Out-and-back',CONVERT(SMALLDATETIME, '2018-12-11 10:00:00')),
(3,'Exmoor Hike',3,'Hard',2,28.14,105,650,'Loop',CONVERT(SMALLDATETIME, '2019-01-31 08:40:00')),
(4,'Porlock Marsh Historic Walk',4,'Medium',3,16.05,19.50,120,'Circular',CONVERT(SMALLDATETIME, '2022-04-15 18:10:00')),
(5,'Historic Buildings of Devizes',5,'Easy',4,2.75,3.10,28,'Out-and-back',CONVERT(SMALLDATETIME, '2021-12-07 21:55:00')),
(6,'Welcome to Bourton-on-the-Water',6,'Easy',5,0.90,0,13,'Circular',CONVERT(SMALLDATETIME, '2024-02-28 15:50:00')),
(7,'Cricklade to South Cerney',0,'Medium',6,22.5,15,210,'Out-and-back',CONVERT(SMALLDATETIME, '2015-06-06 13:11:00')),
(8,'Cleeve Hill Circular',1,'Hard',5,7.2,42,90,'Circular',CONVERT(SMALLDATETIME, '2011-05-30 09:25:00')),
(9,'Bath Skyline Walk',2,'Medium', 7, 6.0, 300, 120,'Loop',CONVERT(SMALLDATETIME, '2023-05-15 10:00:00')),
(10,'Brighton Seafront Stroll',3,'Easy', 8, 4.3, 0, 68,'Circular',CONVERT(SMALLDATETIME, '2009-06-20 23:05:00')),
(11,'Cambridge Historical Route',4,'Medium', 9, 5.1, 20, 80,'Out-and-back',CONVERT(SMALLDATETIME, '2024-07-10 05:00:00')),
(12,'Cheddar Gorge Caving',5,'Hard', 10, 7, 270, 148,'Loop',CONVERT(SMALLDATETIME, '2019-08-18 06:43:00'));


-- Create sample data for the Trail_Feature table
INSERT INTO CW1.Trail_Feature(trail_id,feature_id)
VALUES
(0,1), --Trail 0
(0,2), --Trail 0
(1,6), --Trail 1
(1,0), --Trail 1
(2,6), --Trail 2
(2,2), --Trail 2
(3,7), --Trail 3
(3,8), --Trail 3
(4,4), --Trail 4
(4,5), --Trail 4
(5,0), --Trail 5
(5,2), --Trail 5
(6,7), --Trail 6
(6,1), --Trail 6
(6,2), --Trail 6
(7,3), --Trail 7
(7,2), --Trail 7
(8,9), --Trail 8
(8,6), --Trail 8
(8,5), --Trail 8
(9,6), --Trail 9
(9,8), --Trail 9
(10,1), --Trail 10
(10,2), --Trail 10
(11, 4),--Trail 11
(11,5), --Trail 11
(12,9); --Trail 12
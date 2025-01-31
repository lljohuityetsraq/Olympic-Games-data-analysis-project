--Print Data Set
SELECT * FROM [OlympicsDB].[dbo].[ OlympicHistory]
--Print Column Names
SELECT name
FROM sys.columns
WHERE object_id = OBJECT_ID('[dbo].[ OlympicHistory]');
 
--Delete NULL values from all columns
DELETE FROM [OlympicsDB].[dbo].[ OlympicHistory]
WHERE ID IS NULL OR Name IS NULL OR Sex IS NULL OR Age IS NULL OR Height IS NULL OR Weight IS NULL OR Team IS NULL OR NOC IS NULL OR Games IS NULL OR Year IS NULL OR Season IS NULL OR City IS NULL OR Sport IS NULL OR Event IS NULL OR Medal IS NULL;
 
--Check Duplicates
SELECT
COUNT(*) AS DuplicateCount
FROM
(
SELECT ID, Name, Sex, Age, Height, Weight, Team, NOC, Games, Year, Season, City, Sport, Event, Medal,
ROW_NUMBER() OVER (PARTITION BY ID, Name, Sex, Age, Height, Weight, Team, NOC, Games, Year, Season, City, Sport, Event, Medal ORDER BY ID) AS RowNum
FROM
[dbo].[ OlympicHistory]
) AS DuplicateRows
WHERE
RowNum > 1;
 
--Remove Duplicates
WITH DuplicateRows AS
(
SELECT ID, Name, Sex, Age, Height, Weight, Team, NOC, Games, Year, Season, City, Sport, Event, Medal,
ROW_NUMBER() OVER (PARTITION BY ID, Name, Sex, Age, Height, Weight, Team, NOC, Games, Year, Season, City, Sport, Event, Medal ORDER BY ID) AS RowNum
FROM
[dbo].[ OlympicHistory]
)
DELETE FROM DuplicateRows
WHERE
RowNum > 1;
 
--Replace Values
UPDATE [dbo].[ OlympicHistory]
SET Medal = 'No Medal'
WHERE Medal = 'NA';
 
DELETE FROM [dbo].[ OlympicHistory]
WHERE season = 'Winter';

DELETE FROM [dbo].[ OlympicHistory]
WHERE YEAR < '1948';
 
SELECT * FROM [OlympicsDB].[dbo].[ OlympicHistory]




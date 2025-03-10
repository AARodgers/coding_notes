Problem 1
Find the total number of crimes recorded in the CRIME table.¶
%sql SELECT name,type,length(type) FROM PRAGMA_TABLE_INFO('CHICAGO_CRIME_DATA');
Ans: 533

Problem 2
List community area names and numbers with per capita income less than 11000.
%%sql
SELECT community_area_number, community_area_name
FROM CENSUS_DATA
WHERE per_capita_income < 11000;
COMMUNITY_AREA_NUMBER	COMMUNITY_AREA_NAME
26.0	West Garfield Park
30.0	South Lawndale
37.0	Fuller Park
54.0	Riverdale

Problem 3
List all case numbers for crimes involving minors?(children are not considered minors for the purposes of crime analysis)
%sql SELECT DISTINCT CASE_NUMBER FROM CHICAGO_CRIME_DATA WHERE DESCRIPTION LIKE '%MINOR%'
Done.
case_number
HK238408
HL266884

Problem 4
List all kidnapping crimes involving a child?
%sql SELECT DISTINCT CASE_NUMBER, PRIMARY_TYPE, DATE, DESCRIPTION FROM CHICAGO_CRIME_DATA \
WHERE PRIMARY_TYPE='KIDNAPPING'
Done.
case_number	primary_type	DATE	description
HN144152	KIDNAPPING	2007-01-26	CHILD ABDUCTION/STRANGER

Problem 5
What kinds of crimes were recorded at schools?
%sql SELECT DISTINCT(PRIMARY_TYPE), LOCATION_DESCRIPTION FROM CHICAGO_CRIME_DATA \
WHERE LOCATION_DESCRIPTION LIKE '%SCHOOL%'
Done.
primary_type	location_description
PUBLIC PEACE VI	SCHOOL, PRIVATE, BUILDING
BATTERY	SCHOOL, PUBLIC, BUILDING
NARCOTICS	SCHOOL, PUBLIC, BUILDING
PUBLIC PEACE VI	SCHOOL, PUBLIC, BUILDING
ASSAULT	SCHOOL, PUBLIC, GROUNDS
BATTERY	SCHOOL, PUBLIC, GROUNDS
CRIMINAL DAMAGE	SCHOOL, PUBLIC, GROUNDS
CRIMINAL TRESPA	SCHOOL, PUBLIC, GROUNDS
NARCOTICS	SCHOOL, PUBLIC, GROUNDS

Problem 6
List the average safety score for all types of schools.
%sql SELECT "Elementary, Middle, or High School", AVG(SAFETY_SCORE) AVERAGE_SAFETY_SCORE FROM CHICAGO_PUBLIC_SCHOOLS GROUP BY "Elementary, Middle, or High School";
Done.
Elementary, Middle, or High School	average_safety_score
ES	49
HS	49
MS	48

Problem 7
List 5 community areas with highest % of households below poverty line
%sql SELECT COMMUNITY_AREA_NAME, PERCENT_HOUSEHOLDS_BELOW_POVERTY FROM CENSUS_DATA ORDER BY PERCENT_HOUSEHOLDS_BELOW_POVERTY DESC LIMIT 5 ;
Done.
community_area_name	percent_households_below_poverty
Riverdale	56.5
Fuller Park	51.2
Englewood	46.6
North Lawndale	43.1
East Garfield Park	42.4

Problem 8
Which community area is most crime prone?
%%sql
SELECT COMMUNITY_AREA_NUMBER ,COUNT(COMMUNITY_AREA_NUMBER) AS FREQUENCY
FROM CHICAGO_CRIME_DATA
GROUP BY COMMUNITY_AREA_NUMBER
ORDER BY COUNT(COMMUNITY_AREA_NUMBER) DESC
LIMIT 1;
Done.
community_area_number	frequency
25	43

Problem 9
Use a sub-query to find the name of the community area with highest hardship index
%sql SELECT COMMUNITY_AREA_NAME FROM  CENSUS_DATA WHERE HARDSHIP_INDEX = (SELECT MAX(HARDSHIP_INDEX) FROM CENSUS_DATA);
Done.
community_area_name
Riverdale

Problem 10
Use a sub-query to determine the Community Area Name with most number of crimes?
%%sql
SELECT community_area_name FROM CENSUS_DATA
WHERE COMMUNITY_AREA_NUMBER = (SELECT COMMUNITY_AREA_NUMBER FROM CHICAGO_CRIME_DATA
    GROUP BY COMMUNITY_AREA_NUMBER
    ORDER BY COUNT(COMMUNITY_AREA_NUMBER) DESC
    LIMIT 1)
LIMIT 1;

Ans: Austin

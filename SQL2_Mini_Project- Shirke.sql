create database SQL2_Mini_Project;
use SQL2_Mini_Project;

## Q] 1. Import the csv file to a table in the database.
select * from `icc test batting figures`;

## Q] 2. Remove the column 'Player Profile' from the table.
alter table `icc test batting figures` drop column `Player Profile`;
desc `icc test batting figures`;

## Q] 3. Extract the country name and player names from the given data and store it in seperate columns for further usage.

#Player_name and Country columns from player

alter table `icc test batting figures` add column player_name varchar(25) ;
update`icc test batting figures` set Player_name = substr(player,1,position('(' in player)-1 ) where Player_name is null;
select player_name from `icc test batting figures`;
alter table `icc test batting figures` modify column player_name varchar(25) after player;

alter table `icc test batting figures` add column Country varchar(10) ;
update`icc test batting figures` set Country = substr(player,position('(' in player)+1,length(player)-position('(' in player)-2)
where Country is null;
select Country from `icc test batting figures`;
alter table `icc test batting figures` modify column Country varchar(25) after player_name;

## Q] 4. From the column 'Span' extract the start_year and end_year and store them in seperate columns for further usage.

#start_year , end_year columns from span 

Alter table `icc test batting figures` add column Start_Year int after span;
Update `icc test batting figures` set start_year= substr(span,1,4) where start_year is null;
select start_year from `icc test batting figures`;

Alter table `icc test batting figures` add column End_Year int after start_year;
Update `icc test batting figures` set end_year= substr(span,6) where end_year is null;
select end_year from `icc test batting figures`;

## Q] 5. The column 'HS' has the highest score scored by the player so far in any given match. The column also has details if the player had completed the match in a NOT OUT status. Extract the data and store the highest runs and the NOT OUT status in different columns.

#Highest_Runs and Not_Out_status

alter table `icc test batting figures` add column Highest_Runs int after HS;
Update `icc test batting figures` set Highest_Runs=(
case when substr(HS,length(HS))='*'
then substr(HS,1,length(HS)-1)
else HS
end) where highest_runs is null;
select highest_runs from `icc test batting figures`;

alter table `icc test batting figures` modify column Not_Out_Status varchar(3) after Highest_runs;
Update `icc test batting figures` set Not_Out_status=(
case when substr(HS,length(HS))='*'
then 'YES'
else 'NO'
end) where Not_Out_status is null;
select Not_Out_status from `icc test batting figures`;

## Q] 6. Using the data given, considering the players who were active in the year of 2019, create a set of batting order of best 6 players using the selection criteria of those who have a good average score across all matches for India.

##batting order criteria-highest avg runs

select player_name,span,avg,row_number() over(order by avg desc) Batting_Order
from `icc test batting figures`
where 2019 between start_year and end_year and country='INDIA' 
limit 6;

## Q] 7. Using the data given, considering the players who were active in the year of 2019, create a set of batting order of best 6 players using the selection criteria of those who have highest number of 100s across all matches for India.

## batting order criteria- most 100s
select player_name,span,`100`,row_number() over(order by `100` desc) Batting_Order
from `icc test batting figures`
where 2019 between start_year and end_year and country='INDIA' 
limit 6;

## Q] 8. Using the data given, considering the players who were active in the year of 2019, create a set of batting order of best 6 players using 2 selection criterias of your own for India.

## batting order criteria-highest runs and not out
select player_name,span,highest_runs,not_out_status,row_number() over(order by highest_runs desc) Batting_Order
from `icc test batting figures`
where 2019 between start_year and end_year and country='INDIA' and not_out_status='yes'
limit 6;

## Q] 9. Create a View named ‘Batting_Order_GoodAvgScorers_SA’ using the data given, considering the players who were active in the year of 2019, create a set of batting order of best 6 players using the selection criteria of those who have a good average score across all matches for South Africa.

## batting order-South Africa(avg)

create view Batting_Order_GoodAvgScorers_SA as 
select player_name,span,avg,row_number() over(order by avg desc) Batting_Order
from `icc test batting figures`
where 2019 between start_year and end_year and country='SA'
limit 6;
select * from Batting_Order_GoodAvgScorers_SA;

## Q] 10. Create a View named ‘Batting_Order_HighestCenturyScorers_SA’ Using the data given, considering the players who were active in the year of 2019, create a set of batting order of best 6 players using the selection criteria of those who have highest number of 100s across all matches for South Africa.

## batting order-South Africa (100s)

create view Batting_Order_HighestCenturyScorers_SA as 
select player_name,span,`100`,row_number() over(order by `100` desc) Batting_Order
from `icc test batting figures`
where 2019 between start_year and end_year and country='SA'
limit 6;
select * from Batting_Order_HighestCenturyScorers_SA;
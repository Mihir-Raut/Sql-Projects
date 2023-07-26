Use mcdonalds;

-- ---Data Exploration--- --

#Counting the number of rows in dataset
select count(*) as total_rows
from mcdonaldata;

#Finding Total Menu Items
select count(item) as 'Total Menu Items'
from mcdonaldata;

#Checking unique items in menu
select distinct menu
from mcdonaldata
group by menu;

#Finding total items based on category
select menu as 'Category', count(item) as 'Total Items'
from mcdonaldata
group by menu;

#Identifing missing values in specific columns:
select count(*) as 'Missing value count'
from mcdonaldata
where item is null;  

#Check Calorie values of all menu items
select min(calories) as 'Min calories', max(calories) as 'Max Calories', round(avg(calories)) as 'Avg calories'
from mcdonaldata
where calories is not null;

#food item with the highest calorie
select item, calories as 'Max Calories'
from mcdonaldata
order by calories desc
limit 1;

#check cholestrol value of all items
select min(cholestrol) as 'Min cholestrol', max(cholestrol) as 'Max cholestrol', Round(avg(cholestrol)) as 'Avg cholestrol'
from mcdonaldata
where cholestrol is not null;

# food item with the highest cholestrol
select item, cholestrol as 'Max Cholestrol'
from mcdonaldata
order by calories desc
limit 1;

#check Sugar value of all items
select min(sugar) as 'Min sugar', max(sugar) as 'Max sugar', Round(avg(sugar)) as 'Avg sugar'
from mcdonaldata
where sugar is not null;

# food item with the highest Sugar
select item, sugar as 'Max Sugar'
from mcdonaldata
order by sugar desc
limit 1;

#Finding Avg Nutrients in all categories
select  menu, Round(avg(protien),2) as 'Avg Protien',
Round(avg(carbs),2) as 'Avg Carbs',
Round(avg(sodium),2) as 'Avg Sodium',
Round(avg(totalfat),2) as 'Avg Totalfat'
from mcdonaldata
group by menu;

-- ---Statistical Analysis of Sugar--- --

Select distinct menu,
max(servesize) over (Partition by menu) as 'Max Size',
max(sugar+addedsugar) over (partition by menu) as 'Max Sugar',
min(sugar+addedsugar) over (partition by menu) as 'Min Sugar',
avg(sugar+addedsugar) over (partition by menu) as 'Avg Sugar',
stddev(sugar+addedsugar) over (partition by menu) as 'Std Dev Sugar'
from mcdonaldata;

-- ----Nutritional Analysis---- --
-- Finding information from trusted sources across the web to perform analysis using sql queries.

#Sugar level analysis
-- The AHA suggests a stricter added-sugar limit of no more than 100 calories per day (about 6 teaspoons or 24 grams) 
-- for most adult women and no more than 150 calories per day (about 9 teaspoons or 36 grams of sugar) for most men.

#Menu Items with acceptable level of Sugar
select menu, avg(sugar+addedsugar) as 'Average Sugar'
from mcdonaldata
group by menu
having 'average Sugar' < 24;

# Food Items with excess sugar
select item, menu, sugar, addedsugar
from mcdonaldata
where (sugar+addedsugar) > 24;

#Trans Fat Analysis
-- International expert groups and public health authorities recommend limiting consumption of trans fat (industrially-produced and ruminant)
-- to less than 1% of total energy intake, which translates to less than 2.2 g/day for a 2,000-calorie diet. 

select item, transfat
from mcdonaldata
where transfat>2.2;

#Nutritional Analysis By Item

Select item,
avg(calories) as 'Avg Cal',
avg(Sugar) as 'Avg Sugar',
avg(addedsugar) as 'Avg Added Sugar',
avg(protien) as 'Avg Protien',
avg(sodium) as 'Avg Sodium'
from mcdonaldata
Where item like '%Burger%'
group by item
order by 'Avg Cal' desc;



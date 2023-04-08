select count(*) from zomato;

use ops;

delete from zomato;

# For a high-level overview of the hotels, provide us the top 5 most voted hotels in the delivery category.
select name ,votes, rating from zomato where type='Delivery' order by votes desc limit 5;

# The rating of a hotel is a key identifier in determining a restaurant’s performance. Hence for a particular location called Banashankari find out the top 5 highly rated hotels in the delivery category.
select name, rating, location, type from zomato where location="Banashankari" and type="Delivery" order by rating desc limit 5;

# compare the ratings of the cheapest and most expensive hotels in Indiranagar.
with
r1 as (select rating as rating1 from zomato where approx_cost = all (select min(approx_cost)
from zomato ) limit 1),
r2 as (select rating as rating2 from zomato where approx_cost = all (select max(approx_cost)
from zomato ) limit 1)
select rating1, rating2 from r1, r2;

# Online ordering of food has exponentially increased over time. Compare the total votes of restaurants that provide online ordering services and those who don’t provide online ordering service.
select sum(votes), online_order from zomato group by online_order;

# Number of votes defines how much the customers are involved with the service provided by the restaurants For each Restaurant
# type, find out the number of restaurants, total votes, and average rating. Display the data with the highest votes on the 
#top( if the first row of output is NA display the remaining rows).
select type, count(name), sum(votes), avg(rating) from zomato where type!='NA' group by type order by sum(votes) desc;

# What is the most liked dish of the most-voted restaurant on Zomato(as the restaurant has a tie-up with Zomato, the restaurant 
#compulsorily provides online ordering and delivery facilities.
select name, dish_liked, max(rating), max(votes) from zomato group by dish_liked order by votes desc,rating desc limit 1;


# To increase the maximum profit, Zomato is in need to expand its business. For doing so Zomato wants the list
# of the top 15 restaurants which have min 150 votes, have a rating greater than 3, and is currently not 
#providing online ordering. Display the restaurants with highest votes on the top.
select distinct name from zomato where votes>=150 and rating>3 and online_order!='Yes' order by votes desc limit 15;
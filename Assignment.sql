
-- 1.Which Actor has the most distinct films in our inventory?
use sakila

select
	concat(a2.first_name,' ',a2.last_name) ,
	count(*)
from
	film a
join film_actor f on
	a.film_id = f.film_id
join actor a2 on
	a2.actor_id =f.actor_id 
group by
	f.film_id
order by
	count(*) desc
	
-- 2.Which Genre films are the most rented in our inventory?

select
	c.name,count(*) rented_times 
from
	rental r
join inventory i on
	i.inventory_id = r.inventory_id
join film_category fc on
	fc.film_id =i.film_id 
join category c on
	c.category_id = fc.category_id 
group by
	c.name 
	
	
-- 3.Which actors have the first name ‘Scarlett’
	
select * from actor a where first_name ='Scarlett'

-- Which actors have the last name ‘Johansson’

select * from actor a where last_name ='Johansson'

-- Which last names are not repeated?

select
	last_name
from
	actor a
group by
	a.last_name
having
	count(last_name)= 1
	
-- Which last names appear more than once?
select
	last_name,count(last_name) freq
from
	actor a
group by
	a.last_name
having
	count(last_name)>1
order by freq desc
	
	
-- Which actor has appeared in the most films?

select
	concat(a.first_name, ' ', a.last_name) ,
	count(fa.film_id) as total_films
from
	actor a
join film_actor fa on
	a.actor_id = fa.actor_id
group by
	a.actor_id 
order by
	total_films desc
limit 1
	
	
-- select
-- 	actor.actor_id,
-- 	actor.first_name,
-- 	actor.last_name,
-- 	count(actor_id) as film_count
-- from
-- 	actor
-- join film_actor
-- 		using (actor_id)
-- group by
-- 	actor_id
-- order by
-- 	film_count desc
-- limit 1;
	
-- Is ‘Academy Dinosaur’ available for rent from Store 1?

select
	distinct f.title ,i.store_id 
from
	store s
join inventory i on
	i.store_id = s.store_id
join film f on
	f.film_id = i.film_id
where i.store_id =1 and f.title ='ACADEMY DINOSAUR'


-- Insert a record to represent Mary Smith renting ‘Academy Dinosaur’ from Mike Hillyer at Store 1 today .


-- What is that average running time of all the films in the sakila DB?

select concat(avg(`length`),' sec') avg_len_in_seconds from film f 

-- What is the average running time of films by category?

select
	c.name,avg(f.`length` ) avg_duration
from
	film f
join film_category fc on
	f.film_id = fc.film_id
join category c on
	fc.category_id = c.category_id
group by
	fc.category_id 	
order by avg_duration desc

-- Why does this query return the empty set?
select * from film natural join inventory;

-- How many distinct actors last names are there?
select count(distinct last_name) from actor;


-- The actor HARPO WILLIAMS was accidentally entered in the actor table as  WILLIAMS. Write a query to fix the record.

update
	actor
set
	first_name = 'GROUCHO'
where
	first_name = 'HARPO'
	
	
	SHOW CREATE TABLE address;


--  Use subqueries to display all actors who appear in the film Alone Trip.
select
	concat(first_name, ' ', last_name)
from
	actor a
where
	actor_id in (
	select
		actor_id
	from
		film_actor fa
	where
		film_id in
(
		select
			film_id
		from
			film
		where
			title like '%Alone Trip%'))
			

-- Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

use sakila;
select title, length, rank() over (order by length) as length_ranking
from film
where length is not null and length > 0;

-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.

select title, length, rating, rank() over (partition by rating order by length) as length_ranking_with_ratings
from film
where length is not null and length > 0;

-- 3. How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".

select category.category_id, category.name as category_name, count(film_category.film_id) as film_count
from category
left join film_category on category.category_id = film_category.category_id
group by category.category_id, category.name;

-- 4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

select actor.actor_id, actor.first_name, actor.last_name, count(film_actor.actor_id) as films_count
from actor
join film_actor on actor.actor_id = film_actor.actor_id
group by actor.actor_id, actor.first_name, actor.last_name
order by films_count desc
limit 3;

-- 5. Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer

select customer.customer_id, customer.first_name, customer.last_name, count(rental.rental_id) as times_rented
from customer
join rental on customer.customer_id = rental.customer_id
group by customer.customer_id, customer.first_name, customer.last_name
order by times_rented desc
limit 3;

-- BONUS
select film.film_id, film.title, count(rental.rental_id) as times_rented
from film
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by film.film_id, film.title
order by times_rented desc
limit 1;
use testtest22;
select * from `clicks`;
select * from `listings`;
select * from `users`;

/*Select users whose id is either 3,2 or 4
- Please return at least: all user fields */
select * from users where id in (3,2,4);

/*Count how many basic and premium listings each active user has
- Please return at least: first_name, last_name, basic, premium */
Select u.first_name, u.last_name, COUNT(IF(l.status = 2, 1, NULL)) as basic , COUNT(IF(l.status = 3, 1, NULL)) as premium 
 from users u , listings l  where u.id = l.user_id and u.status = 2 group by l.user_id;

/*Show the same count as before but only if they have at least ONE premium listing
- Please return at least: first_name, last_name, basic, premium*/ 
 Select u.first_name, u.last_name, COUNT(IF(l.status = 2, 1, NULL)) as basic , 
 COUNT(IF(l.status = 3, 1, NULL)) as premium 
 from users u , listings l  where u.id = l.user_id and u.status = 2 
 group by l.user_id having premium > 0;

/*How much revenue has each active vendor made in 2013
- Please return at least: first_name, last_name, currency, revenue*/
select u.first_name, u.last_name, c.currency, SUM(c.price) as revenue
from users u , listings l , clicks c where u.id = l.user_id and l.id =c.listing_id
and u.status = 2 and year(c.created) in ('2013') group by u.id;

/*Insert a new click for listing id 3, at $4.00
- Find out the id of this new click. Please return at least: id */

insert into clicks( listing_id, price, currency, created ) 
values(3, 4.00, 'USD' , sysdate());
SELECT id FROM clicks ORDER BY id DESC LIMIT 1;

/*Show listings that have not received a click in 2013
- Please return at least: listing_name*/

Select l.name from listings l , clicks c where l.id = c.listing_id and year(c.created) NOT IN (2013)
group by c.listing_id;

/*For each year show number of listings clicked and number of vendors who owned these listings
- Please return at least: date, total_listings_clicked, total_vendors_affected*/

Select year(c.created) as date , count(distinct user_id) as total_vendors_affected , count(c.listing_id) as total_listings_clicked from clicks c, listings l , users u 
where l.id = c.listing_id and u.id = l.user_id group by year(c.created);

/*Return a comma separated string of listing names for all active vendors
- Please return at least: first_name, last_name, listing_names */

Select u.first_name, u.last_name, group_concat(l.name) as listing_names from users u , listings l 
where u.id = l.user_id and u.status = 2 group by l.user_id ;
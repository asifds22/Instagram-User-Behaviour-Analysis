-- Project: Instagram Clone Database Analysis
-- Author: ASIF IQBAL

-- Project Introduction:
-- In this project, we will be analyzing the Instagram Clone database ('ig_clone') to extract valuable insights
-- and answer specific questions related to user activity, content engagement, and more. Our goal is to provide
-- meaningful data-driven recommendations to support decision-making for marketing, user engagement, and overall
-- platform improvement.

-- Database Schema:
-- The 'ig_clone' database consists of tables such as 'users', 'photos', 'likes', 'comments', 'tags', and 'photo_tags'.
-- We will be utilizing SQL queries to extract and analyze data from these tables.

-- Queries:
-- The following SQL queries are designed to answer various questions and provide insights into the Instagram Clone
-- platform's user behavior, content popularity, and more.

-- Let's get started!


-- Use the ig_clone database
USE ig_clone;

-- Q.1) Create an ER diagram or draw a schema for the given database.

-- Q.2) We want to reward the user who has been around the longest. Find the 5 oldest users.
SELECT *
FROM users
ORDER BY created_at ASC
LIMIT 5;

-- Q.3) To understand when to run the ad campaign, figure out the day of the week most users register on?
SELECT DAYNAME(created_at) AS Day_Name, COUNT(*) AS Day_count
FROM users
GROUP BY Day_Name
LIMIT 2;

-- Q.4) To target inactive users in an email ad campaign, find the users who have never posted a photo.
SELECT *
FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- Q.5) Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
SELECT username, COUNT(*) AS liked
FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY user_id
ORDER BY liked DESC;

-- Q.6) The investors want to know how many times does the average user post.
SELECT ROUND((SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users), 2) AS avg_user_post;

-- Q.7) A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
SELECT tags.tag_name, COUNT(*) AS tag_count
FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY tag_count DESC
LIMIT 5;

-- Q.8) To find out if there are bots, find users who have liked every single photo on the site.
SELECT username, COUNT(*)
FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY user_id
ORDER BY COUNT(*) DESC;

-- Q.9) To know who the celebrities are, find users who have never commented on a photo.
SELECT *
FROM users
LEFT JOIN comments ON users.id = comments.user_id
WHERE comments.id IS NULL;

-- Q.10) Now it's time to find both of them together, find the users who have never commented on any photo or have commented on every photo.
SELECT *
FROM users
LEFT JOIN comments ON users.id = comments.user_id
WHERE comments.id IS NULL
UNION ALL
SELECT *
FROM users
LEFT JOIN comments ON users.id = comments.user_id;

-- Q.11) Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.
SELECT u.username, COUNT(p.id) as post_count
FROM users u
JOIN photos p ON u.id = p.user_id
GROUP BY p.user_id
HAVING post_count BETWEEN 3 AND 5
ORDER BY post_count DESC
LIMIT 30;

-- Q.12) Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?
SELECT DISTINCT username, users.id
FROM users
JOIN photos ON photos.user_id = users.id
JOIN likes ON likes.photo_id = photos.id
WHERE username REGEXP '^c' AND username REGEXP '[0-9]$';

-- Q.13) Find the users who have created instagramid in may and select top 5 newest joinees from it?
SELECT username, created_at
FROM users
WHERE MONTH(created_at) = 5
ORDER BY created_at DESC
LIMIT 5;




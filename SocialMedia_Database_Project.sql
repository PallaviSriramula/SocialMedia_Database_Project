use projects;
-- Tables creation --
create table users(user_id int primary key, username varchar(100) not null,
email varchar(100) unique, phone varchar(15),bio varchar(255), registration_date date);
create table posts(post_id int primary key, user_id int, content text, post_date date,
foreign key(user_id) references users(user_id));
create table comments(comment_id int primary key, post_id int, user_id int,
comment_text text, comment_date date, foreign key(post_id) references posts(post_id),
foreign key(user_id) references users(user_id));
create table likes(like_id int primary key, post_id int, user_id int, like_date date,
foreign key(post_id) references posts(post_id),
foreign key(user_id) references users(user_id));
create table followers(follower_id int primary key, user_id int, following_user_id int,
follow_date date, foreign key (user_id) references users(user_id),
foreign key(following_user_id) references users(user_id));

-- Inserting Data --
INSERT INTO Users VALUES
(1, 'pallavi', 'pallavi@gmail.com', '9876543210', 'Optimist', '2023-01-15'),
(2, 'rahul', 'rahul@gmail.com', '9876543211', 'Food Blogger Hyderabad', '2024-02-10'),
(3, 'sneha', 'sneha@gmail.com', '9876543212', 'Travel Enthusiast Hyderabad', '2022-11-25'),
(4, 'arjun', 'arjun@gmail.com', '9876543213', 'Fitness Trainer', '2024-05-18'),
(5, 'priya', 'priya@gmail.com', '9876543214', 'Photographer', '2023-07-20'),
(6, 'kiran', 'kiran@gmail.com', '9876543215', 'Software Developer Hyderabad', '2025-01-12'),
(7, 'meena', 'meena@gmail.com', '9876543216', 'Music Lover', '2024-09-15'),
(8, 'vijay', 'vijay@gmail.com', '9876543217', 'Movie Reviewer Hyderabad', '2022-06-30'),
(9, 'deepak', 'deepak@gmail.com', '9876543218', 'Cricket Fan', '2025-03-21'),
(10, 'anitha', 'anitha@gmail.com', '9876543219', 'Content Creator', '2023-12-05');

INSERT INTO Posts VALUES
(101, 1, 'Learning SQL joins and subqueries', '2024-01-10'),
(102, 2, 'Hyderabad food festival was amazing', '2024-03-15'),
(103, 3, 'Travelled to Goa this weekend', '2024-04-20'),
(104, 2, 'Best food places in Hyderabad', '2025-01-05'),
(105, 4, 'Morning workout routine', '2025-02-12'),
(106, 5, 'Captured beautiful sunset pictures', '2024-11-15'),
(107, 6, 'Started learning machine learning', '2025-03-01'),
(108, 8, 'Review of latest action movie', '2025-04-18'),
(109, 10, 'Content creation tips for beginners', '2025-05-10');

INSERT INTO Comments VALUES
(201, 101, 2, 'Great post on SQL!', '2024-01-11'),
(202, 102, 3, 'I love food festivals too.', '2024-03-16'),
(203, 102, 5, 'Looks delicious.', '2024-03-17'),
(204, 104, 1, 'Will definitely visit these places.', '2025-01-06'),
(205, 105, 6, 'Nice fitness tips.', '2025-02-13'),
(206, 107, 4, 'Machine learning is exciting.', '2025-03-02'),
(207, 107, 10, 'Good luck with your learning.', '2025-03-03'),
(208, 108, 2, 'Thanks for the review.', '2025-04-19');

INSERT INTO Likes VALUES
(301, 101, 2, '2024-01-11'),
(302, 101, 3, '2024-01-11'),
(303, 102, 1, '2024-03-16'),
(304, 102, 4, '2024-03-16'),
(305, 102, 5, '2024-03-17'),
(306, 104, 1, '2025-01-06'),
(307, 104, 3, '2025-01-06'),
(308, 104, 6, '2025-01-07'),
(309, 105, 2, '2025-02-13'),
(310, 107, 4, '2025-03-02'),
(311, 107, 5, '2025-03-02'),
(312, 107, 8, '2025-03-03'),
(313, 108, 1, '2025-04-19'),
(314, 108, 3, '2025-04-19'),
(315, 108, 5, '2025-04-20'),
(316, 108, 7, '2025-04-20');

INSERT INTO Followers VALUES
(401, 1, 2, '2024-01-01'),
(402, 1, 3, '2024-01-02'),
(403, 2, 1, '2024-01-03'),
(404, 3, 2, '2024-01-05'),
(405, 4, 2, '2024-01-06'),
(406, 5, 2, '2024-01-07'),
(407, 6, 1, '2025-01-15'),
(408, 7, 6, '2025-01-20'),
(409, 8, 2, '2025-02-10'),
(410, 9, 8, '2025-03-15'),
(411, 10, 1, '2025-04-01'),
(412, 3, 1, '2025-04-05');

-- 2. Display posts created after 2024.
select * from posts where post_date > '2024-12-31';

-- 3. Show all users from Hyderabad.
ALTER TABLE Users ADD city VARCHAR(50);
UPDATE Users SET city='Hyderabad' WHERE user_id IN (1,3,6,8);
UPDATE Users SET city='Vijayawada' WHERE user_id=2;
UPDATE Users SET city='Chennai' WHERE user_id=4;
UPDATE Users SET city='Bangalore' WHERE user_id=5;
UPDATE Users SET city='Mumbai' WHERE user_id=7;
UPDATE Users SET city='Delhi' WHERE user_id=9;
UPDATE Users SET city='Pune' WHERE user_id=10;
select * from users where city = 'Hyderabad';

-- 4. List posts containing a specific keyword (e.g., 'food').
select * from posts where content like '%food%';

-- 5. Display users registered after 2023.
select * from users where registration_date > '2023-12-31';

-- JIONS

-- 1. Show username with their posts.
select u.username, p.content
from users u inner join posts p
on u.user_id = p.user_id;
-- 2. Display comments with post content.
select p.content, p.user_id, c.comment_text
from posts p inner join comments c 
on p.post_id = c.post_id;

select u.username, p.content, c.comment_text
from users u, posts p, comments c 
where u.user_id = p.user_id and
p.post_id = c.post_id;

-- 3.Show post details with user information.
select u.username, p.*
from users u ,posts p 
where u.user_id = p.user_id;

-- 4. List posts with number of likes.
 SELECT p.post_id,
       p.content,
       COUNT(l.like_id) AS total_likes
FROM Posts p
LEFT JOIN Likes l
ON p.post_id = l.post_id
GROUP BY p.post_id, p.content;

-- 5. Show users with their followers.
SELECT u.username,
       COUNT(f.user_id) AS total_followers
FROM Users u
LEFT JOIN Followers f
ON u.user_id = f.following_user_id
GROUP BY u.user_id, u.username;

SELECT u1.username AS follower,
       u2.username AS following
FROM Followers f
JOIN Users u1
ON f.user_id = u1.user_id
JOIN Users u2
ON f.following_user_id = u2.user_id;

-- 1. Count total number of posts
select count(*) as total_posts from posts;
-- 2. Find average number of likes per post.
SELECT AVG(like_count) AS average_likes_per_post
FROM (
    SELECT post_id, COUNT(*) AS like_count
    FROM Likes
    GROUP BY post_id
) AS post_likes;
-- 3.	Calculate total number of comments.
SELECT COUNT(*) AS total_comments
FROM Comments;
-- 4.	Count total users.
SELECT COUNT(*) AS total_users
FROM Users;
-- 5.	Find most liked post.
SELECT p.post_id,
       p.content,
       COUNT(l.like_id) AS total_likes
FROM Posts p
JOIN Likes l
ON p.post_id = l.post_id
GROUP BY p.post_id, p.content
ORDER BY total_likes DESC
LIMIT 1;

-- 1.	Find users who never posted anything.
SELECT *
FROM Users
WHERE user_id NOT IN (
    SELECT user_id
    FROM Posts
);
-- 2.	Find posts with no comments.
SELECT *
FROM Posts
WHERE post_id NOT IN (
    SELECT post_id
    FROM Comments
);
-- 3.	Show posts with likes greater than average likes.
SELECT p.post_id,
       p.content,
       COUNT(l.like_id) AS total_likes
FROM Posts p
JOIN Likes l
ON p.post_id = l.post_id
GROUP BY p.post_id, p.content
HAVING COUNT(l.like_id) >
(
    SELECT AVG(like_count)
    FROM (
        SELECT COUNT(*) AS like_count
        FROM Likes
        GROUP BY post_id
    ) AS avg_likes
);
-- 4.	Find users who have more followers than average.
SELECT u.user_id,
       u.username,
       COUNT(f.user_id) AS follower_count
FROM Users u
JOIN Followers f
ON u.user_id = f.following_user_id
GROUP BY u.user_id, u.username
HAVING COUNT(f.user_id) >
(
    SELECT AVG(follower_count)
    FROM (
        SELECT COUNT(*) AS follower_count
        FROM Followers
        GROUP BY following_user_id
    ) AS avg_followers
);
-- 5.	Show posts with highest number of comments.
SELECT p.post_id,
       p.content,
       COUNT(c.comment_id) AS total_comments
FROM Posts p
JOIN Comments c
ON p.post_id = c.post_id
GROUP BY p.post_id, p.content
HAVING COUNT(c.comment_id) =
(
    SELECT MAX(comment_count)
    FROM (
        SELECT COUNT(*) AS comment_count
        FROM Comments
        GROUP BY post_id
    ) AS max_comments
);

-- 1.	Update user bio.
UPDATE Users
SET bio = 'Stay calm and be happy'
WHERE user_id = 3;
-- 2.	Change user email.
UPDATE Users
SET email = 'rahul_new@gmail.com'
WHERE user_id = 2;
-- 3.	Update post content.
UPDATE Posts
SET content = 'Learning SQL joins, subqueries and views'
WHERE post_id = 101;
-- 4.	Delete posts with no likes.
DELETE FROM Posts
WHERE post_id NOT IN (
    SELECT post_id
    FROM Likes
);
-- 5.	Delete users with no posts.
DELETE FROM Users
WHERE user_id NOT IN (
    SELECT user_id
    FROM Posts
);

-- VIEWS
-- 1. Create a view to display user posts.
CREATE VIEW user_posts AS
SELECT u.user_id,
       u.username,
       p.post_id,
       p.content,
       p.post_date
FROM Users u
JOIN Posts p
ON u.user_id = p.user_id;
SELECT * FROM user_posts;
-- 2.	Create a view for post details with user name.
CREATE VIEW post_details AS
SELECT p.post_id,
       p.content,
       p.post_date,
       u.username
FROM Posts p
JOIN Users u
ON p.user_id = u.user_id;
SELECT * FROM post_details;
-- 3.	Create a view showing comments with post and user.
CREATE VIEW comment_details AS
SELECT c.comment_id,
       u.username,
       p.content AS post_content,
       c.comment_text,
       c.comment_date
FROM Comments c
JOIN Users u
ON c.user_id = u.user_id
JOIN Posts p
ON c.post_id = p.post_id;
SELECT * FROM comment_details;
-- 4.	Create a view to display total likes per post.
CREATE VIEW post_likes AS
SELECT p.post_id,
       p.content,
       COUNT(l.like_id) AS total_likes
FROM Posts p
LEFT JOIN Likes l
ON p.post_id = l.post_id
GROUP BY p.post_id, p.content;
SELECT * FROM post_likes;
-- 5.	Create a view showing most active users.
CREATE VIEW active_users AS
SELECT u.user_id,
       u.username,
       COUNT(p.post_id) AS total_posts
FROM Users u
LEFT JOIN Posts p
ON u.user_id = p.user_id
GROUP BY u.user_id, u.username
ORDER BY total_posts DESC;
SELECT * FROM active_users;

-- Stored Procedures
desc users;

-- Insert a New User
DELIMITER //
CREATE PROCEDURE InsertNewUser3(
    IN p_username VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(15),
    IN p_bio VARCHAR(255),
    IN p_registration_date DATE
)
BEGIN
    DECLARE new_id INT;
    SELECT IFNULL(MAX(user_id),0) + 1
    INTO new_id
    FROM Users;
    INSERT INTO Users(
        user_id,
        username,
        email,
        phone,
        bio,
        registration_date
    )
    VALUES(
        new_id,
        p_username,
        p_email,
        p_phone,
        p_bio,
        p_registration_date
    );
END //
DELIMITER ;

CALL InsertNewUser3(
    'rohit',
    'rohit@gmail.com',
    '9876543220',
    'Tech Enthusiast',
    '2025-06-01'
);

-- Add a New Post
DELIMITER //
CREATE PROCEDURE AddNewPost1(
    IN p_user_id INT,
    IN p_content TEXT,
    IN p_post_date DATE
)
BEGIN
    DECLARE new_post_id INT;
    SELECT IFNULL(MAX(post_id),0) + 1
    INTO new_post_id
    FROM Posts;
    INSERT INTO Posts(
        post_id,
        user_id,
        content,
        post_date
    )
    VALUES(
        new_post_id,
        p_user_id,
        p_content,
        p_post_date
    );
END //
DELIMITER ;

CALL AddNewPost1(
    1,
    'Learning MySQL Stored Procedures',
    '2025-07-14'
);

-- Display Posts of a User
DELIMITER //
CREATE PROCEDURE DisplayPostsOfUser(
    IN p_user_id INT
)
BEGIN
    SELECT post_id,
           content,
           post_date
    FROM Posts
    WHERE user_id = p_user_id;
END //
DELIMITER ;

CALL DisplayPostsOfUser(2);

-- Calculate Total Likes

DELIMITER //

CREATE PROCEDURE CalculateTotalLikes()
BEGIN
    SELECT COUNT(*) AS total_likes
    FROM Likes;
END //
DELIMITER ;

CALL CalculateTotalLikes();

-- List Followers of a User

DELIMITER //
CREATE PROCEDURE ListFollowersOfUser(
    IN p_user_id INT
)
BEGIN
    SELECT u.username AS follower_name,
           f.follow_date
    FROM Followers f
    JOIN Users u
    ON f.user_id = u.user_id
    WHERE f.following_user_id = p_user_id;
END //
DELIMITER ;

CALL ListFollowersOfUser(2);

-- REPORTS

-- 1. Top 5 most liked posts.
SELECT p.post_id,
       p.content,
       COUNT(l.like_id) AS total_likes
FROM Posts p
LEFT JOIN Likes l
ON p.post_id = l.post_id
GROUP BY p.post_id, p.content
ORDER BY total_likes DESC
LIMIT 5;

-- 2. Most active users (users with most posts).
SELECT u.user_id,
       u.username,
       COUNT(p.post_id) AS total_posts
FROM Users u
JOIN Posts p
ON u.user_id = p.user_id
GROUP BY u.user_id, u.username
ORDER BY total_posts DESC;

-- To get only the top user
SELECT u.user_id,
       u.username,
       COUNT(p.post_id) AS total_posts
FROM Users u
JOIN Posts p
ON u.user_id = p.user_id
GROUP BY u.user_id, u.username
ORDER BY total_posts DESC
LIMIT 1;

-- 3. Monthly post activity report.
SELECT YEAR(post_date) AS year,
       MONTH(post_date) AS month,
       COUNT(*) AS total_posts
FROM Posts
GROUP BY YEAR(post_date), MONTH(post_date)
ORDER BY year, month;

-- 4. User with highest followers.
SELECT u.user_id,
       u.username,
       COUNT(f.user_id) AS total_followers
FROM Users u
JOIN Followers f
ON u.user_id = f.following_user_id
GROUP BY u.user_id, u.username
ORDER BY total_followers DESC
LIMIT 1;

-- 5. Post engagement analysis (likes + comments).
SELECT p.post_id,
       p.content,
       COUNT(DISTINCT l.like_id) AS total_likes,
       COUNT(DISTINCT c.comment_id) AS total_comments,
       COUNT(DISTINCT l.like_id) + COUNT(DISTINCT c.comment_id) AS engagement_score
FROM Posts p
LEFT JOIN Likes l
ON p.post_id = l.post_id
LEFT JOIN Comments c
ON p.post_id = c.post_id
GROUP BY p.post_id, p.content
ORDER BY engagement_score DESC;

-- 6. Users who follow many but have fewer followers.
SELECT u.user_id,
       u.username,
       COUNT(DISTINCT f1.following_user_id) AS following_count,
       COUNT(DISTINCT f2.user_id) AS follower_count
FROM Users u
LEFT JOIN Followers f1
ON u.user_id = f1.user_id
LEFT JOIN Followers f2
ON u.user_id = f2.following_user_id
GROUP BY u.user_id, u.username
HAVING following_count > follower_count;
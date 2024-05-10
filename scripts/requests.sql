--Узнаем, сколько денег принёс нам каждый из тарифов (даже если NULL покупок). Отсортируем результат по убыванию.
SELECT SUM(real_cost) AS revenue, tariff_id
FROM users_tariffs
GROUP BY tariff_id
UNION ALL
SELECT tariff_id, NULL AS revenue
FROM tariffs
WHERE NOT EXISTS (
    SELECT
    FROM users_tariffs
    WHERE users_tariffs.tariff_id = tariffs.tariff_id)
ORDER BY revenue DESC NULLS LAST, tariff_id;


--Вычислим выручку за каждый месяца "учебного" год. В конец добавим сумму за весь период.
WITH rev_month AS (
    SELECT year, name_month, revenue
    FROM (
        SELECT EXTRACT(MONTH FROM date_start) AS month, TO_CHAR(date_start, 'Month') AS name_month, EXTRACT(YEAR FROM date_start) AS YEAR, SUM(real_cost) AS revenue
        FROM Users_Tariffs
        WHERE date_start >= '2022-07-01' AND date_start <= '2023-06-30'
        GROUP BY month, name_month, year
    ) AS CRUTCH
    ORDER BY year, month
)
SELECT * FROM rev_month
UNION ALL
SELECT NULL AS year, NULL AS name_month, SUM(revenue) AS total_revenue
FROM rev_month
ORDER BY year;


--Узнаем данные пользователей из топ 5 по количеству потраченных денег, чтобы подарить им мерч. 11-классников не рассматриваем.
WITH total_revenue AS (
    SELECT SUM(real_cost) AS total_revenue
    FROM Users_Tariffs
)
SELECT u.first_name, u.last_name, u.vk_account,
    SUM(ut.real_cost) AS user_revenue,
    ROUND(100.0 * SUM(ut.real_cost) / (SELECT total_revenue FROM total_revenue), 2) AS revenue_percentage
FROM Users u JOIN Users_Tariffs ut ON u.user_id = ut.user_id
WHERE grade != 11
GROUP BY u.first_name, u.last_name, u.vk_account
ORDER BY user_revenue DESC
LIMIT 5;


--Найдём тариф с самым большим количеством курсов и опишем его.
SELECT t.tariff_id, t.title, t.cost, t.duration, max_tariff.count
FROM tariffs t
JOIN (
SELECT tariff_id, COUNT(DISTINCT course_id)
FROM Tariffs_Courses
GROUP BY tariff_id
ORDER BY count DESC
LIMIT 1) max_tariff ON t.tariff_id = max_tariff.tariff_id;


--Найдём количество топиков в каждом курсе. Добавим rank.
SELECT course_id, title, count_topics, RANK() OVER (ORDER BY count_topics DESC) AS rank
FROM(SELECT c.course_id, c.title, COUNT(DISTINCT ct.topic_id) AS count_topics
        FROM Courses c JOIN Courses_Topics ct ON c.course_id = ct.course_id
        GROUP BY c.course_id, c.title
) AS Crutch
ORDER BY count_topics DESC;


--Найдём количество топиков в каждом тарифе и отсортируем по убыванию.
WITH number_of_topics_in_courses AS (
    SELECT COUNT(DISTINCT topic_id), course_id
    FROM courses_topics
    GROUP BY course_id
    ORDER BY count DESC
)
SELECT tc.tariff_id, SUM(count) AS count_of_topics
FROM tariffs_courses tc
RIGHT JOIN number_of_topics_in_courses notic ON tc.course_id = notic.course_id
GROUP BY tc.tariff_id
ORDER BY count_of_topics DESC;


--Найдём среднюю длительность вебинаров и их количество в каждом топике.
SELECT Topics.topic_id, Topics.title, COUNT(Webinars.webinar_id),
AVG(COALESCE(EXTRACT(HOUR FROM Webinars.duration) * 60 + EXTRACT(MINUTE FROM Webinars.duration), 0)) AS avg_duration_minutes
FROM Topics 
LEFT JOIN Webinars ON Topics.topic_id = Webinars.topic_id
GROUP BY Topics.topic_id, Topics.title
ORDER BY topic_id;


--Вывести все самые времязатратные задания, то есть времязатратность которых не меньше половины от максимальной.
SELECT *
FROM Tasks
WHERE time_consuming >= (SELECT MAX(time_consuming) / 2 FROM Tasks)
ORDER BY time_consuming DESC;


--Вычислим, сколько задач в каждой домашке, включая нулевые (хотя их нет, я перепитонил).
SELECT h.homework_id, h.title, h.topic_id, COALESCE(cnt, 0) AS task_count
FROM Homeworks h
LEFT JOIN (
        SELECT homework_id, COUNT(*) AS cnt
        FROM Homeworks_Tasks
        GROUP BY homework_id
) ht ON h.homework_id = ht.homework_id
ORDER BY h.homework_id;


--Используем having! Так даже короче, не нужен подзапрос.
--Выведем всех пользователей, которые оплатили не менее 4 раличных тарифов
SELECT Users.user_id, first_name, last_name FROM Users
LEFT JOIN Users_Tariffs ON Users.user_id = Users_Tariffs.user_id
GROUP BY Users.user_id 
HAVING COUNT(DISTINCT tariff_id) >= 4;


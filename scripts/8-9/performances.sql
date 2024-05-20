CREATE OR REPLACE VIEW project.view_active_users_tariffs AS
SELECT user_id, tariff_id
FROM project.users_tariffs
WHERE date_start <= CURRENT_TIMESTAMP AND date_expiration > CURRENT_TIMESTAMP;

CREATE OR REPLACE VIEW project.view_courses_details AS
SELECT tc.tariff_id, tc.course_id, c.title, c.description
FROM project.tariffs_courses tc
JOIN project.courses c ON tc.course_id = c.course_id;

CREATE OR REPLACE VIEW project.view_tariffs_details AS
SELECT tc.tariff_id, tc.course_id, t.title, t.description, t.cost, t.duration
FROM project.tariffs_courses tc
JOIN project.tariffs t ON tc.tariff_id = t.tariff_id;

CREATE VIEW project.view_upcoming_webinars AS
SELECT w.webinar_id, t.topic_id, t.title AS title_topic, w.title AS webinar_title, w.date_start 
FROM project.webinars w
RIGHT JOIN project.topics t ON w.topic_id = t.topic_id
WHERE w.date_start BETWEEN CURRENT_TIMESTAMP AND (CURRENT_DATE + INTERVAL '1MONTH');

CREATE VIEW project.view_deadlines AS
SELECT h.homework_id, t.topic_id, t.title AS title_topic, h.title AS title_homework, h.description, h.date_start, h.date_expiration, h.time_consuming  
FROM project.homeworks h
RIGHT JOIN project.topics t ON h.topic_id = t.topic_id
WHERE h.date_start <= CURRENT_TIMESTAMP AND h.date_expiration > CURRENT_TIMESTAMP

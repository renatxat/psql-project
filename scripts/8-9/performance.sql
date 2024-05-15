CREATE OR REPLACE VIEW project.active_users_tariffs AS
SELECT user_id, tariff_id
FROM project.users_tariffs
WHERE date_start <= CURRENT_TIMESTAMP AND date_expiration > CURRENT_TIMESTAMP;

CREATE OR REPLACE VIEW project.courses_details AS
SELECT tc.tariff_id, tc.course_id, c.title, c.description
FROM project.tariffs_courses tc
JOIN project.courses c ON tc.course_id = c.course_id;

CREATE OR REPLACE VIEW project.tariffs_details AS
SELECT tc.tariff_id, tc.course_id, t.title, t.description, t.cost, t.duration
FROM project.tariffs_courses tc
JOIN project.tariffs t ON tc.tariff_id = t.tariff_id;

CREATE INDEX users_name_idx ON project.users(first_name, last_name);
CREATE INDEX users_tariffs_idx ON project.users_tariffs(tariff_id, user_id);
CREATE INDEX courses_title_idx ON project.courses(title);
CREATE INDEX tariffs_courses_idx ON project.tariffs_courses(tariff_id, course_id);
CREATE INDEX webinars_topic_idx ON project.webinars(topic_id);
CREATE INDEX webinars_date_start_idx ON project.webinars(date_start);
CREATE INDEX homeworks_topic_idx ON project.homeworks(topic_id);
CREATE INDEX homeworks_date_idx ON project.homeworks(date_start, date_expiration);

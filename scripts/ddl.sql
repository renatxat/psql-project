
--DROP TABLE project.users, project.tariffs, project.users_tariffs, project.courses, project.tariffs_courses, project.topics,
--project.courses_topics, project.homeworks, project.webinars, project.tasks, project.homeworks_tasks 
--CASCADE;

CREATE SCHEMA IF NOT EXISTS  project;

-- Создание таблицы project.users
CREATE TABLE IF NOT EXISTS project.users (
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    surname VARCHAR(30),
    gender_is_male BOOL NOT NULL,
    joindate TIMESTAMP NOT NULL,
    grade SMALLINT NOT NULL,
    vk_account VARCHAR(50) NOT NULL
);

-- Создание таблицы project.tariffs
CREATE TABLE IF NOT EXISTS project.tariffs (
    tariff_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    cost INTEGER NOT NULL,
    duration INTERVAL NOT NULL,
    comment TEXT
);

-- Создание таблицы project.users × project.tariffs
CREATE TABLE IF NOT EXISTS project.users_tariffs (
    user_id INTEGER NOT NULL,
    tariff_id INTEGER NOT NULL,
    date_start TIMESTAMP NOT NULL,
    date_expiration TIMESTAMP NOT NULL,
    real_cost INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES project.users(user_id),
    FOREIGN KEY (tariff_id) REFERENCES project.tariffs(tariff_id)
);

-- Создание таблицы project.courses
CREATE TABLE IF NOT EXISTS project.courses (
    course_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    date_start TIMESTAMP NOT NULL,
    date_expiration TIMESTAMP NOT NULL
);

-- Создание таблицы project.tariffs × project.courses
CREATE TABLE IF NOT EXISTS project.tariffs_courses (
    tariff_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    duration_of_access INTERVAL NOT NULL,
    comment TEXT,
    FOREIGN KEY (tariff_id) REFERENCES project.tariffs(tariff_id),
    FOREIGN KEY (course_id) REFERENCES project.courses(course_id)
);

-- Создание таблицы project.topics
CREATE TABLE IF NOT EXISTS project.topics (
    topic_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT
);

-- Создание таблицы project.courses × project.topics
CREATE TABLE IF NOT EXISTS project.courses_topics (
    course_id INTEGER NOT NULL,
    topic_id INTEGER NOT NULL,
    order_number SMALLINT NOT NULL,
    FOREIGN KEY (course_id) REFERENCES project.courses(course_id),
    FOREIGN KEY (topic_id) REFERENCES project.topics(topic_id)
);

-- Создание таблицы project.homeworks
CREATE TABLE IF NOT EXISTS project.homeworks (
    homework_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    date_start TIMESTAMP NOT NULL,
    date_expiration TIMESTAMP NOT NULL,
    time_consuming SMALLINT NOT NULL,
    topic_id INTEGER NOT NULL,
    FOREIGN KEY (topic_id) REFERENCES project.topics(topic_id)
);

-- Создание таблицы project.webinars
CREATE TABLE IF NOT EXISTS project.webinars (
    webinar_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    path_file TEXT NOT NULL,
    date_start TIMESTAMP,
    duration INTERVAL NOT NULL,
    topic_id INTEGER NOT NULL,
    FOREIGN KEY (topic_id) REFERENCES project.topics(topic_id)
);

-- Создание таблицы project.tasks
CREATE TABLE IF NOT EXISTS project.tasks (
    task_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    wording TEXT NOT NULL,
    answer VARCHAR(150),
    solution TEXT,
    source TEXT,
    time_consuming SMALLINT NOT NULL
);

-- Создание таблицы project.homeworks_tasks
CREATE TABLE IF NOT EXISTS project.homeworks_tasks (
    homework_id INTEGER NOT NULL,
    task_id INTEGER NOT NULL,
    index_number SMALLINT NOT NULL,
    FOREIGN KEY (homework_id) REFERENCES project.homeworks(homework_id),
    FOREIGN KEY (task_id) REFERENCES project.tasks(task_id)
);


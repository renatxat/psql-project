
--DROP TABLE USERS, TARIFFS, users_tariffs, courses, tariffs_courses, topics , courses_topics , homeworks, webinars, tasks, homeworks_tasks CASCADE;

-- Создание таблицы Users
CREATE TABLE IF NOT EXISTS Users (
    user_id INTEGER PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    surname VARCHAR(30),
    gender_is_male BOOL NOT NULL,
    joindate TIMESTAMP NOT NULL,
    grade SMALLINT NOT NULL,
    vk_account VARCHAR(50) NOT NULL
);

-- Создание таблицы Tariffs
CREATE TABLE IF NOT EXISTS Tariffs (
    tariff_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    cost INTEGER NOT NULL,
    duration INTERVAL NOT NULL,
    comment TEXT
);

-- Создание таблицы Users × Tariffs
CREATE TABLE IF NOT EXISTS Users_Tariffs (
    user_id INTEGER NOT NULL,
    tariff_id INTEGER NOT NULL,
    date_start TIMESTAMP NOT NULL,
    date_expiration TIMESTAMP NOT NULL,
    real_cost INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (tariff_id) REFERENCES Tariffs(tariff_id)
);

-- Создание таблицы Courses
CREATE TABLE IF NOT EXISTS Courses (
    course_id INTEGER PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    date_start TIMESTAMP NOT NULL,
    date_expiration TIMESTAMP NOT NULL
);

-- Создание таблицы Tariffs × Courses
CREATE TABLE IF NOT EXISTS Tariffs_Courses (
    tariff_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    duration_of_access INTERVAL NOT NULL,
    comment TEXT,
    FOREIGN KEY (tariff_id) REFERENCES Tariffs(tariff_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Создание таблицы Topics
CREATE TABLE IF NOT EXISTS Topics (
    topic_id INTEGER PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT
);

-- Создание таблицы Courses × Topics
CREATE TABLE IF NOT EXISTS Courses_Topics (
    course_id INTEGER NOT NULL,
    topic_id INTEGER NOT NULL,
    order_number SMALLINT NOT NULL,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (topic_id) REFERENCES Topics(topic_id)
);

-- Создание таблицы Homeworks
CREATE TABLE IF NOT EXISTS Homeworks (
    homework_id INTEGER PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    date_start TIMESTAMP NOT NULL,
    date_expiration TIMESTAMP NOT NULL,
    time_consuming SMALLINT NOT NULL,
    topic_id INTEGER NOT NULL,
    FOREIGN KEY (topic_id) REFERENCES Topics(topic_id)
);

-- Создание таблицы Webinars
CREATE TABLE IF NOT EXISTS Webinars (
    webinar_id INTEGER PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    path_file TEXT NOT NULL,
    date_start TIMESTAMP,
    duration INTERVAL NOT NULL,
    topic_id INTEGER NOT NULL,
    FOREIGN KEY (topic_id) REFERENCES Topics(topic_id)
);

-- Создание таблицы Tasks
CREATE TABLE IF NOT EXISTS Tasks (
    task_id INTEGER PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    wording TEXT NOT NULL,
    answer VARCHAR(150),
    solution TEXT,
    source TEXT,
    time_consuming SMALLINT NOT NULL
);

-- Создание таблицы Homeworks_Tasks
CREATE TABLE IF NOT EXISTS Homeworks_Tasks (
    homework_id INTEGER NOT NULL,
    task_id INTEGER NOT NULL,
    index_number SMALLINT NOT NULL,
    FOREIGN KEY (homework_id) REFERENCES Homeworks(homework_id),
    FOREIGN KEY (task_id) REFERENCES Tasks(task_id)
);


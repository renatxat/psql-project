## 8. Представления

1) Представление для всех тарифов, действующих для юзеров в данный момент.
```sql
CREATE OR REPLACE VIEW project.view_active_users_tariffs AS
SELECT user_id, tariff_id
FROM project.users_tariffs
WHERE date_start <= CURRENT_TIMESTAMP AND date_expiration > CURRENT_TIMESTAMP;
```
2) Представление того, в каких тарифах содержится определённый курс, для отображения на сайте.
```sql
CREATE OR REPLACE VIEW project.view_courses_details AS
SELECT tc.tariff_id, tc.course_id, c.title, c.description
FROM project.tariffs_courses tc
JOIN project.courses c ON tc.course_id = c.course_id;
```
3) Представление того, какие курсы содержит определённый тариф, для отображения на сайте.
```sql
CREATE OR REPLACE VIEW project.view_tariffs_details AS
SELECT tc.tariff_id, tc.course_id, t.title, t.description, t.cost, t.duration
FROM project.tariffs_courses tc
JOIN project.tariffs t ON tc.tariff_id = t.tariff_id;
```
4) Представление того, какие вебы будут в ближайшем месяце, для составления расписания.
```sql
CREATE VIEW project.view_upcoming_webinars AS
SELECT w.webinar_id, t.topic_id, t.title AS title_topic, w.title AS webinar_title, w.date_start 
FROM project.webinars w
RIGHT JOIN project.topics t ON w.topic_id = t.topic_id
WHERE w.date_start BETWEEN CURRENT_TIMESTAMP AND (CURRENT_DATE + INTERVAL '1MONTH');
```
5) Представление того, какие домашние задания доступны для выполнения.
```sql
CREATE VIEW project.view_deadlines AS
SELECT h.homework_id, t.topic_id, t.title AS title_topic, h.title AS title_homework, h.description, h.date_start, h.date_expiration, h.time_consuming  
FROM project.homeworks h
RIGHT JOIN project.topics t ON h.topic_id = t.topic_id
WHERE h.date_start <= CURRENT_TIMESTAMP AND h.date_expiration > CURRENT_TIMESTAMP
```

## 9. Индексы
Cоздадим индексы для ускорения выполнения запросов:
1) Для быстрого поиска юзеров по фамилии и имени.
    ```sql
    CREATE INDEX users_name_idx ON project.users(first_name, last_name);
    ```
2) Для быстрого поиска, какие тарифы есть у определённого пользователя в данный момент.
   Помогает в первом представлении.
   ```sql
   CREATE INDEX users_tariffs_idx ON project.users_tariffs(tariff_id, user_id);
   ```
3) Для быстрого поиска курсов по названию на сайте.
    ```sql
    CREATE INDEX courses_title_idx ON project.courses(title);
    ```
4) Для быстрого поиска, какие тарифы содержат определённый курс, и наоборот.
   Помогает во втором и третьем представлениях.
   ```sql
   CREATE INDEX tariffs_courses_idx ON project.tariffs_courses(tariff_id, course_id);
   ```
5) Для быстрого поиска, какие вебинары входят в определённый топик.
   ```sql
   CREATE INDEX webinars_topic_idx ON project.webinars(topic_id);
   ```
   Для быстрого составления расписания вебинаров у пользователя.
   Помогает в четвертом представлении.
   ```sql
   CREATE INDEX webinars_date_start_idx ON project.webinars(date_start);
   ```
6) Для быстрого поиска дз по определённому топику.
   ```sql
   CREATE INDEX homeworks_topic_idx ON project.homeworks(topic_id);
   ```
   Для быстрого составления расписания вебинаров у пользователя.
   Помогает в пятом представлении.
   ```sql
   CREATE INDEX homeworks_date_idx ON project.homeworks(date_start, date_expiration);
   ```

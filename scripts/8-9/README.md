## 8. Представления

1) Представление для всех тарифов, действующих для юзеров в данный момент.
```sql
CREATE OR REPLACE VIEW project.active_users_tariffs AS
SELECT user_id, tariff_id
FROM project.users_tariffs
WHERE date_start <= CURRENT_TIMESTAMP AND date_expiration > CURRENT_TIMESTAMP;
```
2) Представление того, в каких тарифах содержится курс  для отображения на сайте.
```sql
CREATE OR REPLACE VIEW project.tariffs_courses_details AS
SELECT tc.tariff_id, tc.course_id, c.title, c.description
FROM project.tariffs_courses tc
JOIN project.courses c ON tc.course_id = c.course_id;
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
   Помогает во втором представлении.
   ```sql
   CREATE INDEX tariffs_courses_idx ON project.tariffs_courses(tariff_id, course_id);
   ```
5) Для быстрого поиска, какие вебинары входят в определённый топик.
   ```sql
   CREATE INDEX webinars_topic_idx ON project.webinars(topic_id);
   ```
   Для быстрого составления расписания вебинаров у пользователя. 
   ```sql
   CREATE INDEX webinars_date_start_idx ON project.webinars(date_start);
   ```
6) Для быстрого поиска дз по определённому топику и его дедлайна.
   ```sql
   CREATE INDEX homeworks_topic_idx ON project.homeworks(topic_id);
   ```
   Для быстрого составления расписания вебинаров у пользователя. 
   ```sql
   CREATE INDEX homeworks_date_idx ON project.homeworks(date_start, date_expiration);
   ```
CREATE OR REPLACE VIEW project.active_users_tariffs AS
SELECT user_id, tariff_id
FROM project.users_tariffs
WHERE date_start <= CURRENT_TIMESTAMP AND date_expiration > CURRENT_TIMESTAMP;

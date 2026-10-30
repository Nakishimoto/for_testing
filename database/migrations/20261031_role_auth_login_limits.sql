-- Run after 20261030_attendance_integrity.sql.

CREATE TABLE login_rate_limits (
    scope_hash CHAR(64) NOT NULL,
    attempts INT UNSIGNED NOT NULL DEFAULT 0,
    window_started_at DATETIME NOT NULL,
    blocked_until DATETIME NULL,
    PRIMARY KEY (scope_hash),
    KEY idx_login_rate_limit_blocked (blocked_until)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

UPDATE users u
INNER JOIN roles r ON r.role_id = u.role_id
SET u.role = r.role_name
WHERE u.role <> r.role_name;

ALTER TABLE users
    DROP COLUMN role;

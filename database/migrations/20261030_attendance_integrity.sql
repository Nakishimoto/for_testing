-- Apply once after the existing 20261021 migration.

ALTER TABLE attendance_appeals
    MODIFY evidence_path VARCHAR(500) NULL;

ALTER TABLE event_attendance
    MODIFY record_source ENUM('barcode', 'department_head', 'appeal', 'system')
        NOT NULL DEFAULT 'barcode';

CREATE TABLE event_attendance_roster (
    event_id BIGINT(20) UNSIGNED NOT NULL,
    student_id BIGINT(20) UNSIGNED NOT NULL,
    department_id BIGINT(20) UNSIGNED NOT NULL,
    student_number VARCHAR(50) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100) NULL,
    last_name VARCHAR(100) NOT NULL,
    year_level VARCHAR(50) NULL,
    section VARCHAR(100) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (event_id, student_id),
    KEY idx_attendance_roster_student (student_id, event_id),
    CONSTRAINT fk_attendance_roster_event
        FOREIGN KEY (event_id) REFERENCES events (event_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_attendance_roster_student
        FOREIGN KEY (student_id) REFERENCES students (student_id)
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Preserve the current interpretation of historical events at upgrade time.
INSERT IGNORE INTO event_attendance_roster
    (event_id, student_id, department_id, student_number, first_name,
     middle_name, last_name, year_level, section)
SELECT e.event_id, s.student_id, s.department_id, s.student_number,
       s.first_name, s.middle_name, s.last_name, s.year_level, s.section
FROM events e
INNER JOIN students s ON s.department_id = e.department_id
WHERE (
      s.enrollment_status = 'enrolled'
      OR EXISTS (
          SELECT 1 FROM event_attendance ea_existing
          WHERE ea_existing.event_id = e.event_id
            AND ea_existing.student_id = s.student_id
      )
  )
  AND (
      e.event_status IN ('approved', 'completed', 'cancelled', 'cancellation_requested')
      OR EXISTS (
          SELECT 1 FROM event_attendance ea_existing
          WHERE ea_existing.event_id = e.event_id
      )
  )
  AND (
      NOT EXISTS (
          SELECT 1 FROM event_participants ep_any
          WHERE ep_any.event_id = e.event_id
      )
      OR EXISTS (
          SELECT 1 FROM event_participants ep
          WHERE ep.event_id = e.event_id
            AND (
                (ep.participant_type = 'student' AND ep.student_id = s.student_id)
                OR (ep.participant_type = 'year_level' AND ep.year_level = s.year_level)
                OR (ep.participant_type = 'section'
                    AND ep.year_level = s.year_level AND ep.section = s.section)
            )
      )
  );

-- `role_id` is the authoritative role used by authentication.  Repair old
-- denormalized values and require it for all future accounts.
UPDATE users u
INNER JOIN roles r ON r.role_id = u.role_id
SET u.role = r.role_name
WHERE u.role <> r.role_name;

ALTER TABLE users
    MODIFY role_id INT(11) NOT NULL;

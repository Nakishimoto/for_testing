-- Demonstration-only sample data. Do not import this file into production.
SET time_zone = '+08:00';
SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO `academic_periods` (`academic_period_id`, `academic_year`, `semester`, `start_date`, `end_date`, `is_current`, `created_at`) VALUES
(1, '2026-2027', '1st', '2026-08-01', '2026-12-31', 1, '2026-10-17 07:00:40');

INSERT INTO `attendance_appeals` (`appeal_id`, `attendance_id`, `student_id`, `appeal_reason`, `evidence_path`, `appeal_status`, `reviewed_by_department_head_id`, `reviewed_at`, `reviewer_remarks`, `submitted_at`, `updated_at`) VALUES
(1, 4, 1, 'I was unable to attend the workshop due to an unexpected emergency. Please review my attendance record.', 'uploads/appeals/sample-emergency.pdf', 'pending', NULL, NULL, NULL, '2026-10-19 11:51:55', '2026-10-19 11:51:55');

INSERT INTO `attendance_settings` (`attendance_setting_id`, `event_id`, `present_until`, `late_until`, `absent_after`, `updated_by`, `updated_at`) VALUES
(1, 1, '2026-11-10 08:15:00', '2026-11-10 09:00:00', '2026-11-10 09:00:00', 1, '2026-10-17 07:00:40'),
(2, 3, '2026-10-22 09:10:00', '2026-10-22 09:30:00', '2026-10-22 09:30:00', 1, '2026-10-19 11:51:55'),
(3, 4, '2026-11-18 13:15:00', '2026-11-18 14:00:00', '2026-11-18 14:00:00', 1, '2026-10-19 11:51:55');

INSERT INTO `departments` (`department_id`, `department_code`, `department_name`, `description`, `is_active`, `department_head_can_edit`, `department_head_can_edit_attendance`, `created_at`) VALUES
(1, 'SHS', 'Senior High School', 'Senior high school department', 0, 0, 0, '2026-10-14 13:33:41'),
(2, 'JHS', 'Junior High School', 'Junior high school department', 0, 0, 0, '2026-10-14 13:33:41'),
(3, 'COLLEGE', 'College', 'College department', 0, 0, 0, '2026-10-14 13:33:41'),
(11, 'CITCS', 'College of Information Technology and Computer Studies', 'Information technology and computer studies', 1, 0, 0, '2026-10-17 07:00:40'),
(12, 'CAS', 'College of Arts and Sciences', 'Arts and sciences programs', 1, 0, 0, '2026-10-17 07:00:40'),
(13, 'SEBA', 'School of Economics, Business and Accountancy', 'Business and entrepreneurship programs', 1, 0, 0, '2026-10-17 07:00:40'),
(14, 'CITHM', 'College of Tourism and Hospitality Management', 'Tourism and hospitality programs', 1, 0, 0, '2026-10-17 07:00:40'),
(15, 'SOC', 'School of Criminology', 'Criminology programs', 1, 0, 0, '2026-10-17 07:00:40'),
(16, 'COE', 'College of Engineering', 'Engineering programs', 1, 0, 0, '2026-10-17 07:00:40'),
(17, 'CTE', 'College of Teacher Education', 'Teacher education programs', 1, 0, 0, '2026-10-17 07:00:40');

INSERT INTO `department_heads` (`department_head_id`, `user_id`, `department_id`, `employee_number`, `first_name`, `middle_name`, `last_name`, `created_at`) VALUES
(1, 2, 11, 'EMP-0001', 'Sample', NULL, 'Department Head', '2026-10-17 07:00:40');

INSERT INTO `events` (`event_id`, `department_id`, `requested_by`, `academic_period_id`, `event_title`, `event_description`, `venue`, `start_at`, `end_at`, `attendance_opens_at`, `attendance_closes_at`, `event_status`, `admin_reviewed_by`, `admin_reviewed_at`, `admin_remarks`, `cancellation_requested_at`, `cancellation_requested_by`, `cancellation_request_remarks`, `created_at`, `updated_at`) VALUES
(1, 11, 1, 1, 'CITCS Orientation', 'Sample event for testing attendance.', 'School Campus', '2026-11-10 08:00:00', '2026-11-10 12:00:00', '2026-11-10 07:30:00', '2026-11-10 12:00:00', 'approved', 1, '2026-10-17 15:00:40', 'Approved sample event', NULL, NULL, NULL, '2026-10-17 07:00:40', '2026-10-17 07:00:40'),
(2, 11, 1, 1, 'IT Week Opening Program', 'Department-wide IT Week opening program.', 'Main Auditorium', '2026-09-15 08:00:00', '2026-09-15 12:00:00', '2026-09-15 07:30:00', '2026-09-15 12:00:00', 'completed', 1, '2026-09-10 10:00:00', 'Approved', NULL, NULL, NULL, '2026-10-19 11:51:55', '2026-10-19 11:51:55'),
(3, 11, 1, 1, 'Cybersecurity Awareness Seminar', 'Introductory cybersecurity awareness seminar.', 'Computer Laboratory 1', '2026-10-22 09:00:00', '2026-10-22 11:30:00', '2026-10-22 08:30:00', '2026-10-22 11:30:00', 'approved', 1, '2026-10-18 10:00:00', 'Approved', NULL, NULL, NULL, '2026-10-19 11:51:55', '2026-10-19 11:51:55'),
(4, 11, 1, 1, 'Web Development Workshop', 'Hands-on HTML, CSS, and PHP workshop.', 'Computer Laboratory 2', '2026-11-18 13:00:00', '2026-11-18 16:00:00', '2026-11-18 12:30:00', '2026-11-18 16:00:00', 'approved', 1, '2026-10-18 10:00:00', 'Approved', NULL, NULL, NULL, '2026-10-19 11:51:55', '2026-10-19 11:51:55'),
(5, 11, 1, 1, 'Student Research Forum', 'Student project and research presentations.', 'WIS Function Hall', '2026-12-05 08:00:00', '2026-12-05 15:00:00', '2026-12-05 07:30:00', '2026-12-05 15:00:00', 'pending', NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-19 11:51:55', '2026-10-19 11:51:55');

INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `account_status`, `last_login_at`, `created_at`, `updated_at`, `role_id`) VALUES
(1, 'admin', 'admin001@wis.local', '$2y$10$wA6YQNMv0qxqbRv/LS.BBOJ3vGLU4lt2gZm7PwCCzi7N8bgJqlj3O', 'active', '2026-10-24 00:22:29', '2026-10-17 07:00:40', '2026-10-23 16:22:29', 1),
(2, 'depthead', 'head001@wis.local', '$2y$10$zxdfz0.V.JeaC.dfd1KixOF3dMEP/xp3O427Fcz72paRZcpqUX3ci', 'active', '2026-10-20 13:24:46', '2026-10-17 07:00:40', '2026-10-20 05:24:46', 2),
(3, 'student', 'student001@wis.local', '$2y$10$RGoHbrLihD8iWwjgE7QO4.CluTXWlamPkkrAc8Y82enYy7Mt9Vohy', 'active', '2026-10-24 11:52:07', '2026-10-17 07:00:40', '2026-10-24 03:52:07', 3),
(4, 'student02', 'student002@wis.local', '$2y$10$RGoHbrLihD8iWwjgE7QO4.CluTXWlamPkkrAc8Y82enYy7Mt9Vohy', 'active', NULL, '2026-10-19 11:51:55', '2026-10-19 11:51:55', 3),
(5, 'student03', 'student003@wis.local', '$2y$10$RGoHbrLihD8iWwjgE7QO4.CluTXWlamPkkrAc8Y82enYy7Mt9Vohy', 'active', NULL, '2026-10-19 11:51:55', '2026-10-19 11:51:55', 3),
(6, 'student04', 'student004@wis.local', '$2y$10$RGoHbrLihD8iWwjgE7QO4.CluTXWlamPkkrAc8Y82enYy7Mt9Vohy', 'active', NULL, '2026-10-19 11:51:55', '2026-10-19 11:51:55', 3),
(7, 'student05', 'student005@wis.local', '$2y$10$RGoHbrLihD8iWwjgE7QO4.CluTXWlamPkkrAc8Y82enYy7Mt9Vohy', 'active', NULL, '2026-10-19 11:51:55', '2026-10-19 11:51:55', 3),
(8, 'student06', 'student006@wis.local', '$2y$10$RGoHbrLihD8iWwjgE7QO4.CluTXWlamPkkrAc8Y82enYy7Mt9Vohy', 'active', NULL, '2026-10-19 11:51:55', '2026-10-19 11:51:55', 3);

INSERT INTO `event_attendance` (`attendance_id`, `event_id`, `student_id`, `attendance_status`, `check_in_at`, `recorded_by_user_id`, `record_source`, `remarks`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'present', '2026-11-10 08:00:00', 2, 'department_head', 'Sample attendance record', '2026-10-17 07:00:40', '2026-10-17 07:00:40'),
(2, 2, 1, 'present', '2026-09-15 08:05:00', 2, 'barcode', 'Checked in on time', '2026-10-19 11:51:55', '2026-10-19 11:51:55'),
(3, 3, 1, 'late', '2026-10-22 09:18:00', 2, 'department_head', 'Arrived after the present cutoff', '2026-10-19 11:51:55', '2026-10-19 11:51:55'),
(4, 4, 1, 'absent', NULL, 2, 'department_head', 'No check-in recorded', '2026-10-19 11:51:55', '2026-10-19 11:51:55'),
(5, 2, 2, 'late', '2026-09-15 08:25:00', 2, 'barcode', 'Late arrival', '2026-10-19 11:51:55', '2026-10-19 11:51:55'),
(6, 2, 3, 'absent', NULL, 2, 'department_head', 'No check-in recorded', '2026-10-19 11:51:55', '2026-10-19 11:51:55'),
(7, 2, 4, 'present', '2026-09-15 07:55:00', 2, 'barcode', 'Checked in on time', '2026-10-19 11:51:55', '2026-10-19 11:51:55'),
(8, 2, 5, 'excused', NULL, 2, 'department_head', 'Excuse documented', '2026-10-19 11:51:55', '2026-10-19 11:51:55'),
(9, 2, 6, 'present', '2026-09-15 08:02:00', 2, 'barcode', 'Checked in on time', '2026-10-19 11:51:55', '2026-10-19 11:51:55');

INSERT INTO `students` (`student_id`, `user_id`, `student_number`, `barcode_token`, `department_id`, `section`, `year_level`, `first_name`, `middle_name`, `last_name`, `enrollment_status`, `created_at`, `updated_at`) VALUES
(1, 3, 'STU-0001', '2153505580c8014ccb3f3fd2b3d4a9f8e15a717fe0e67d6b3effe657af064c52', 11, 'BSIT-1A', '1st Year', 'Sample', NULL, 'Student', 'enrolled', '2026-10-17 07:00:40', '2026-10-17 07:00:40'),
(2, 4, 'STU-0002', '946b8b2312a38ddd52f9dcf896a87f22527bbc1152ecefd2115151c0a3400ffe', 11, 'BSIT-1A', '1st Year', 'Alex', NULL, 'Reyes', 'enrolled', '2026-10-19 11:51:55', '2026-10-19 11:51:55'),
(3, 5, 'STU-0003', '2d9b32bd46925b092f22d27a6667175bae5605ec3d310d1ea1da996ad05fa88a', 11, 'BSIT-1A', '1st Year', 'Jamie', NULL, 'Santos', 'enrolled', '2026-10-19 11:51:55', '2026-10-19 11:51:55'),
(4, 6, 'STU-0004', 'd1b8f83cb6e039e11e20acc55aeeba271760b15524ce3bce404da859e1239f77', 11, 'BSIT-2A', '2nd Year', 'Taylor', NULL, 'Cruz', 'enrolled', '2026-10-19 11:51:55', '2026-10-19 11:51:55'),
(5, 7, 'STU-0005', '4b1097846633437532310f75bf2a8e2edbecf88885b49a5d991f4d25c9a6dbd3', 11, 'BSIT-2A', '2nd Year', 'Morgan', NULL, 'Garcia', 'enrolled', '2026-10-19 11:51:55', '2026-10-19 11:51:55'),
(6, 8, 'STU-0006', '51d3f49cd932506a71d8355a0c012795869970075e68e952965f1c04a23c5234', 11, 'BSIT-3A', '3rd Year', 'Casey', NULL, 'Dela Cruz', 'enrolled', '2026-10-19 11:51:55', '2026-10-19 11:51:55');

INSERT IGNORE INTO `event_attendance_roster`
  (`event_id`, `student_id`, `department_id`, `student_number`, `first_name`,
   `middle_name`, `last_name`, `year_level`, `section`)
SELECT e.event_id, s.student_id, s.department_id, s.student_number,
       s.first_name, s.middle_name, s.last_name, s.year_level, s.section
FROM events e
INNER JOIN students s ON s.department_id = e.department_id
WHERE s.enrollment_status = 'enrolled'
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

SET FOREIGN_KEY_CHECKS = 1;

<?php

require_once __DIR__ . '/../config/session.php';

require_once __DIR__ . '/../config/app.php';
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/event_lifecycle.php';

$adminRole = strtolower(trim($_SESSION['role_name'] ?? $_SESSION['role'] ?? ''));
$adminRole = str_replace([' ', '-'], '_', $adminRole);
if (empty($_SESSION['user_id']) || $adminRole !== 'admin') {
    header('Location: ' . BASE_URL . '/auth/admin-login.php');
    exit;
}

$adminAccountStmt = $pdo->prepare(
    "SELECT 1
     FROM users u
     INNER JOIN roles r ON r.role_id = u.role_id
     WHERE u.user_id = ? AND u.account_status = 'active' AND r.role_name = 'admin'"
);
$adminAccountStmt->execute([(int) $_SESSION['user_id']]);
if ($adminAccountStmt->fetchColumn() === false) {
    $_SESSION = [];
    session_destroy();
    header('Location: ' . BASE_URL . '/auth/admin-login.php');
    exit;
}

synchronizeEventLifecycle($pdo);

if (empty($_SESSION['admin_csrf_token'])) {
    $_SESSION['admin_csrf_token'] = bin2hex(random_bytes(32));
}

function adminEscape(mixed $value): string
{
    return htmlspecialchars((string) $value, ENT_QUOTES, 'UTF-8');
}

function adminVerifyCsrf(mixed $token): bool
{
    return is_string($token)
        && isset($_SESSION['admin_csrf_token'])
        && hash_equals($_SESSION['admin_csrf_token'], $token);
}

function adminLogActivity(
    PDO $pdo,
    string $action,
    string $entity,
    ?int $entityId = null,
    ?string $details = null
): void {
    $stmt = $pdo->prepare(
        'INSERT INTO admin_activity_logs
            (actor_user_id, action_type, entity_type, entity_id, details)
         VALUES (?, ?, ?, ?, ?)'
    );
    $stmt->execute([
        (int) $_SESSION['user_id'],
        $action,
        $entity,
        $entityId,
        $details,
    ]);
}

function adminRedirect(string $path, array $query = []): void
{
    $url = BASE_URL . $path;
    if ($query !== []) {
        $url .= '?' . http_build_query($query);
    }
    header('Location: ' . $url);
    exit;
}

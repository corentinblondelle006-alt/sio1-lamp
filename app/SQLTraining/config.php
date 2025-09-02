<?php
// config.php - Configuration de la base de données

// Configuration de la base de données
define('DB_HOST', 'database');
define('DB_NAME', 'librairie');
define('DB_USER', 'app_SqlTrainingUser');
define('DB_PASS', '€tudiantsSio@2027');
define('DB_CHARSET', 'utf8mb4');

// Configuration de sécurité
define('MAX_EXECUTION_TIME', 30); // Temps maximum d'exécution en secondes
define('MAX_RESULTS', 1000); // Nombre maximum de résultats à retourner

// Requêtes autorisées (whitelist)
$allowed_query_types = [
    'SELECT', 'INSERT', 'UPDATE', 'DELETE', 
    'CREATE', 'ALTER', 'DROP', 'SHOW', 'DESCRIBE', 'DESC'
];

// Tables autorisées (optionnel - pour plus de sécurité)
/* $allowed_tables = [
    'etudiants', 'cours', 'notes', 'professeurs'
]; */

// Fonction pour créer une connexion PDO
function getDbConnection() {
    try {
        $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET;
        $options = [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
            PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES " . DB_CHARSET
        ];
        
        return new PDO($dsn, DB_USER, DB_PASS, $options);
    } catch (PDOException $e) {
        throw new Exception("Erreur de connexion à la base de données : " . $e->getMessage());
    }
}

// Fonction pour valider le type de requête
function isAllowedQueryType($query) {
    global $allowed_query_types;
    $query = trim($query);
    $firstWord = strtoupper(explode(' ', $query)[0]);
    return in_array($firstWord, $allowed_query_types);
}

// Fonction pour extraire les noms de tables d'une requête
function extractTableNames($query) {
    $tables = [];
    $query = strtolower($query);
    
    // Patterns pour différents types de requêtes
    $patterns = [
        '/from\s+([a-zA-Z_][a-zA-Z0-9_]*)/i',
        '/into\s+([a-zA-Z_][a-zA-Z0-9_]*)/i',
        '/update\s+([a-zA-Z_][a-zA-Z0-9_]*)/i',
        '/table\s+([a-zA-Z_][a-zA-Z0-9_]*)/i',
        '/join\s+([a-zA-Z_][a-zA-Z0-9_]*)/i'
    ];
    
    foreach ($patterns as $pattern) {
        if (preg_match_all($pattern, $query, $matches)) {
            $tables = array_merge($tables, $matches[1]);
        }
    }
    
    return array_unique($tables);
}

// Fonction pour valider les tables utilisées
function areTablesAllowed($query) {
    global $allowed_tables;
    
    // Si aucune restriction sur les tables n'est définie, autoriser toutes les tables
    if (empty($allowed_tables)) {
        return true;
    }
    
    $usedTables = extractTableNames($query);
    
    foreach ($usedTables as $table) {
        if (!in_array($table, $allowed_tables)) {
            return false;
        }
    }
    
    return true;
}
?>
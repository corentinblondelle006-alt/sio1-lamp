<?php
// table_info.php - API pour obtenir les informations des tables

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Gérer les requêtes OPTIONS (CORS preflight)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once 'config.php';

// Fonction pour envoyer une réponse JSON
function sendResponse($success, $data = null, $message = '') {
    $response = [
        'success' => $success,
        'message' => $message,
        'data' => $data,
        'timestamp' => date('Y-m-d H:i:s')
    ];
    
    echo json_encode($response, JSON_UNESCAPED_UNICODE);
    exit;
}

try {
    // Créer la connexion à la base de données
    $pdo = getDbConnection();
    
    $action = $_GET['action'] ?? 'list_tables';
    
    switch ($action) {
        case 'list_tables':
            // Lister toutes les tables de la base de données
            $stmt = $pdo->query("SHOW TABLES");
            $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
            
            // Filtrer selon les tables autorisées si configuré
            global $allowed_tables;
            if (!empty($allowed_tables)) {
                $tables = array_intersect($tables, $allowed_tables);
            }
            
            sendResponse(true, array_values($tables), count($tables) . " table(s) trouvée(s).");
            break;
            
        case 'table_structure':
            // Obtenir la structure d'une table spécifique
            $tableName = $_GET['table'] ?? '';
            
            if (empty($tableName)) {
                sendResponse(false, null, 'Nom de table manquant.');
            }
            
            // Vérifier si la table est autorisée
            global $allowed_tables;
            if (!empty($allowed_tables) && !in_array($tableName, $allowed_tables)) {
                sendResponse(false, null, 'Table non autorisée.');
            }
            
            // Obtenir la structure de la table
            $stmt = $pdo->prepare("DESCRIBE `$tableName`");
            $stmt->execute();
            $structure = $stmt->fetchAll();
            
            // Obtenir aussi quelques exemples de données
            $stmt = $pdo->prepare("SELECT * FROM `$tableName` LIMIT 5");
            $stmt->execute();
            $samples = $stmt->fetchAll();
            
            $data = [
                'structure' => $structure,
                'samples' => $samples,
                'tableName' => $tableName
            ];
            
            sendResponse(true, $data, "Structure de la table '$tableName' récupérée.");
            break;
            
        case 'table_count':
            // Obtenir le nombre d'enregistrements pour chaque table
            $stmt = $pdo->query("SHOW TABLES");
            $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
            
            // Filtrer selon les tables autorisées si configuré
            global $allowed_tables;
            if (!empty($allowed_tables)) {
                $tables = array_intersect($tables, $allowed_tables);
            }
            
            $counts = [];
            foreach ($tables as $table) {
                try {
                    $stmt = $pdo->prepare("SELECT COUNT(*) as count FROM `$table`");
                    $stmt->execute();
                    $result = $stmt->fetch();
                    $counts[$table] = $result['count'];
                } catch (Exception $e) {
                    $counts[$table] = 'Erreur';
                }
            }
            
            sendResponse(true, $counts, "Nombre d'enregistrements récupéré pour " . count($counts) . " table(s).");
            break;
            
        default:
            sendResponse(false, null, 'Action non reconnue.');
    }
    
} catch (Exception $e) {
    sendResponse(false, null, 'Erreur : ' . $e->getMessage());
}
?>
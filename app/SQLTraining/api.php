<?php
// api.php - API pour exécuter les requêtes SQL


// Configuration CORS complète - à placer AVANT tout autre code
header('Access-Control-Allow-Origin: *'); // Ou spécifiez votre domaine : 'https://votredomaine.com'
header('Access-Control-Allow-Methods: POST, GET, OPTIONS, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With, Accept, Origin');
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Max-Age: 86400'); // Cache preflight pendant 24h
header('Content-Type: application/json; charset=utf-8');



// Gérer les requêtes OPTIONS (CORS preflight)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once 'config.php';

// Fonction pour nettoyer et valider l'entrée
function sanitizeInput($input) {
    return trim(stripslashes($input));
}

// Fonction pour envoyer une réponse JSON
function sendResponse($success, $data = null, $message = '', $rowCount = 0) {
    $response = [
        'success' => $success,
        'message' => $message,
        'data' => $data,
        'rowCount' => $rowCount,
        'timestamp' => date('Y-m-d H:i:s')
    ];
    
    echo json_encode($response, JSON_UNESCAPED_UNICODE);
    exit;
}

// Vérifier que la requête est en POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendResponse(false, null, 'Méthode non autorisée. Utilisez POST.');
}

// Récupérer les données JSON
$input = json_decode(file_get_contents('php://input'), true);

// Vérifier que la requête SQL est fournie
if (!isset($input['query']) || empty(trim($input['query']))) {
    sendResponse(false, null, 'Requête SQL manquante.');
}

$query = sanitizeInput($input['query']);

try {
    // Valider le type de requête
    if (!isAllowedQueryType($query)) {
        sendResponse(false, null, 'Type de requête non autorisé.');
    }
    
    // Valider les tables utilisées (si restriction activée)
    if (!areTablesAllowed($query)) {
        sendResponse(false, null, 'Une ou plusieurs tables utilisées ne sont pas autorisées.');
    }
    
    // Créer la connexion à la base de données
    $pdo = getDbConnection();
    
    // Définir le temps maximum d'exécution
    set_time_limit(MAX_EXECUTION_TIME);
    
    // Préparer et exécuter la requête
    $stmt = $pdo->prepare($query);
    $stmt->execute();
    
    // Déterminer le type de requête pour traiter la réponse
    $queryType = strtoupper(explode(' ', trim($query))[0]);
    
    switch ($queryType) {
        case 'SELECT':
        case 'SHOW':
        case 'DESCRIBE':
        case 'DESC':
            // Requêtes qui retournent des données
            $results = $stmt->fetchAll();
            $rowCount = count($results);
            
            // Limiter le nombre de résultats si nécessaire
            if ($rowCount > MAX_RESULTS) {
                $results = array_slice($results, 0, MAX_RESULTS);
                $message = "Résultats limités à " . MAX_RESULTS . " lignes sur " . $rowCount . " trouvées.";
            } else {
                $message = $rowCount . " ligne(s) trouvée(s).";
            }
            
            sendResponse(true, $results, $message, $rowCount);
            break;
            
        case 'INSERT':
        case 'UPDATE':
        case 'DELETE':
            // Requêtes de modification
            $rowCount = $stmt->rowCount();
            $message = "Requête $queryType exécutée avec succès. $rowCount ligne(s) affectée(s).";
            
            // Pour INSERT, inclure l'ID du dernier enregistrement inséré si disponible
            $data = null;
            if ($queryType === 'INSERT') {
                $lastInsertId = $pdo->lastInsertId();
                if ($lastInsertId) {
                    $data = ['lastInsertId' => $lastInsertId];
                }
            }
            
            sendResponse(true, $data, $message, $rowCount);
            break;
            
        case 'CREATE':
        case 'ALTER':
        case 'DROP':
            // Requêtes de structure
            $message = "Requête $queryType exécutée avec succès.";
            sendResponse(true, null, $message, 0);
            break;
            
        default:
            sendResponse(true, null, "Requête exécutée avec succès.", 0);
    }
    
} catch (PDOException $e) {
    // Erreurs SQL
    $errorMessage = "Erreur SQL : " . $e->getMessage();
    sendResponse(false, null, $errorMessage);
    
} catch (Exception $e) {
    // Autres erreurs
    $errorMessage = "Erreur : " . $e->getMessage();
    sendResponse(false, null, $errorMessage);
}
?>
<?php
header('Content-Type: application/json');

$servername = "localhost";
$username = "root"; // Default username for XAMPP
$password = ""; // Default password for XAMPP
$dbname = "hemanth"; // Replace with your actual database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(['error' => 'Connection failed: ' . $conn->connect_error]));
}

// Query to fetch all patient records
$sql = "SELECT * FROM patients";
$result = $conn->query($sql);

$patients = [];
if ($result->num_rows > 0) {
    // Fetch each row as an associative array
    while($row = $result->fetch_assoc()) {
        $patients[] = $row;
    }
}

// Return the patient data as JSON
echo json_encode(['patients' => $patients]);

$conn->close();
?>

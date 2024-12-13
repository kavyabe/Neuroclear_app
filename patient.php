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

// Get data from POST request
$name = $_POST['name'];
$age = $_POST['age'];
$gender = $_POST['gender'];
$clinicalHistory = $_POST['clinicalHistory']; // Include clinicalHistory field

// Prepare SQL statement to insert data into database, including clinicalHistory
$sql = "INSERT INTO patients (name, age, gender, clinical_history) VALUES ('$name', '$age', '$gender', '$clinicalHistory')";

if ($conn->query($sql) === TRUE) {
    echo json_encode(['status' => 'success']);
} else {
    echo json_encode(['error' => 'Error: ' . $sql . '<br>' . $conn->error]);
}

$conn->close();
?>

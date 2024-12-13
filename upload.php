<?php
$servername = "localhost";
$username = "root"; // Change if you have a different username
$password = ""; // Change if you have a password set
$dbname = "hemanth"; // Your database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} else {
    file_put_contents('debug.log', "Database connected successfully.\n", FILE_APPEND);
}

// Handle the uploaded file
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['image'])) {
    // Debugging output
    file_put_contents('debug.log', print_r($_POST, true), FILE_APPEND);
    file_put_contents('debug.log', print_r($_FILES, true), FILE_APPEND);

    $targetDir = "uploads/"; // Directory where images will be stored
    $imagePath = $targetDir . basename($_FILES['image']['name']);

    // Move uploaded file to the target directory
    if (move_uploaded_file($_FILES['image']['tmp_name'], $imagePath)) {
        // Retrieve class name and confidence score from POST data
        $className = $_POST['class_name'] ?? '';
        $confidenceScore = $_POST['confidence_score'] ?? 0.0;

        // Debugging output
        file_put_contents('debug.log', "Class Name: $className, Confidence Score: $confidenceScore\n", FILE_APPEND);

        // Prepare SQL query to insert data into the database
        $stmt = $conn->prepare("INSERT INTO predictions (image_path, class_name, confidence_score) VALUES (?, ?, ?)");
        $stmt->bind_param("ssd", $imagePath, $className, $confidenceScore);

        if ($stmt->execute()) {
            echo json_encode(['status' => 'success', 'message' => 'Image uploaded and data saved.']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Database error: ' . $stmt->error]);
        }

        $stmt->close();
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Failed to upload image.']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request.']);
}

$conn->close();
?>

<?php
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_FILES['file'])) {
    $targetDir = "uploads/";
    $targetFile = $targetDir . basename($_FILES["file"]["name"]);
    $imageFileType = strtolower(pathinfo($targetFile, PATHINFO_EXTENSION));

    // Check if image file is an actual image or fake image
    $check = getimagesize($_FILES["file"]["tmp_name"]);
    if ($check === false) {
        echo json_encode(["success" => false, "message" => "File is not an image."]);
        exit;
    }

    // Check if file already exists
    if (file_exists($targetFile)) {
        echo json_encode(["success" => false, "message" => "File already exists."]);
        exit;
    }

    // Check file size (5MB limit)
    if ($_FILES["file"]["size"] > 5000000) {
        echo json_encode(["success" => false, "message" => "File is too large."]);
        exit;
    }

    // Allow certain file formats
    if ($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
        && $imageFileType != "gif") {
        echo json_encode(["success" => false, "message" => "Only JPG, JPEG, PNG & GIF files are allowed."]);
        exit;
    }

    // Check if $uploadOk is set to 0 by an error
    if (move_uploaded_file($_FILES["file"]["tmp_name"], $targetFile)) {
        echo json_encode(["success" => true, "message" => "The file " . htmlspecialchars(basename($_FILES["file"]["name"])) . " has been uploaded."]);
    } else {
        echo json_encode(["success" => false, "message" => "There was an error uploading your file."]);
    }
} else {
    echo json_encode(["success" => false, "message" => "No file was uploaded."]);
}
?>

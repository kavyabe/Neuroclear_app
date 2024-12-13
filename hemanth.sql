-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 21, 2024 at 06:09 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hemanth`
--

-- --------------------------------------------------------

--
-- Table structure for table `login1`
--

CREATE TABLE `login1` (
  `id` int(100) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login1`
--

INSERT INTO `login1` (`id`, `Email`, `username`, `password`) VALUES
(20, '', 'Kavya', 'Hi'),
(24, '', 'Harsha bandaru', 'P@ss1ord'),
(25, '', 'hi', 'hi'),
(26, '', 'navya', 'nav'),
(27, '', 'plm', 'lm'),
(28, '', 'bf', 'mm'),
(29, '', 'bf', 'mm');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `id` int(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  `age` int(90) NOT NULL,
  `gender` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`id`, `name`, `age`, `gender`) VALUES
(20, 'Krishna ', 21, 'Male'),
(26, 'Kk', 21, 'Female'),
(31, 'Kk', 21, 'Male'),
(32, 'Kk', 21, 'Male'),
(33, 'Jaya', 12, 'Male'),
(37, 'Kk', 36, 'Female'),
(38, 'Kk', 36, 'Female'),
(39, 'Kk', 21, 'Female'),
(40, 'Kk', 21, 'Female'),
(41, 'Kk', 21, 'Female'),
(42, 'Jj', 34, 'Female'),
(43, 'Kk', 21, 'Female'),
(44, 'Kk', 21, 'Female'),
(45, 'Kk', 21, 'Female'),
(46, 'Kk', 21, 'Female'),
(47, 'Kk', 21, 'Female'),
(48, 'Kavya', 12, 'Female'),
(49, 'Kavya', 12, 'Female'),
(50, 'Xy6v', 539, 'Female'),
(51, 'Sh', 64, 'Female'),
(52, 'Ka', 36, 'Female'),
(53, 'Kavya', 12, 'Female'),
(54, '', 0, ''),
(55, 'Jwk', 94, 'Female'),
(56, 'Jg', 54, 'Female'),
(57, 'Ka', 6, 'Female'),
(58, '7r', 56, 'Female'),
(59, '7r', 56, 'Female'),
(60, '7r', 56, 'Female'),
(61, '7r', 56, 'Female'),
(62, 'Shs', 94, 'Female'),
(63, 'Shs', 94, 'Female'),
(64, 'Shs', 94, 'Female'),
(65, 'Shs', 94, 'Female'),
(66, 'Shs', 94, 'Female'),
(67, 'Shs', 94, 'Female'),
(68, 'Harsha', 5692, 'Male'),
(69, 'Kaviya', 8001, 'Other'),
(70, 'Kaviya', 8001, 'Other'),
(71, 'Ha', 364, 'Female'),
(72, 'Ai', 354, 'Female'),
(73, 'Ig', 35465, 'Female'),
(74, 'Jj', 53, 'Female'),
(75, 'Gv', 66, 'Female'),
(76, 'Kavya', 61, 'Female'),
(77, 'Uf', 8, 'Female'),
(78, 'Uf', 8, 'Female'),
(79, 'Iw', -1, 'Female'),
(80, 'Iw', -1, 'Female'),
(81, 'Her', 2622, 'Female'),
(82, 'Hqj', 96, 'Female'),
(83, 'Kavya', 649, 'Female'),
(84, 'Kavya', 649, 'Female'),
(85, 'Kavya', 649, 'Female'),
(86, 'Yqq', 21, 'Female'),
(87, 'Yqq', 21, 'Female'),
(88, 'Jk', 6, 'Female'),
(89, 'Oh', -64, 'Female'),
(90, '9y', 631, 'Female'),
(91, 'Xb', 86, 'Female'),
(92, 'Bkvx', 58, 'Female'),
(93, 'Ss', 69, 'Female'),
(94, 'Ss', 69, 'Female'),
(95, 'Kk', 25, 'Female'),
(96, 'Kk', 25, 'Female'),
(97, 'Kk', 25, 'Female'),
(98, 'Kk', 25, 'Female'),
(99, 'Kk', 25, 'Female'),
(100, 'Kk', 25, 'Female'),
(101, 'Hi', 36, 'Female'),
(102, 'Tu', 23, 'Female'),
(103, 'Tu', 23, 'Female'),
(104, 'Us', 344, 'Female'),
(105, 'Y9', 33, 'Female'),
(106, 'Kavya', 36, 'Female'),
(107, 'Kavya', 36, 'Female'),
(108, 'Kavya', 36, 'Female'),
(109, 'Kavya', 36, 'Female'),
(110, 'Kavya', 36, 'Female'),
(111, 'Kavya', 36, 'Female'),
(112, 'Iga8', 6, 'Female'),
(113, 'Jahs', 64, 'Female'),
(114, 'Jahs', 64, 'Female'),
(115, 'Biisi', 9, 'Female'),
(116, 'Biisi', 9, 'Female'),
(117, 'kk', 21, 'Female'),
(118, 'kk', 21, 'Male'),
(119, 'kkavyya', 28, 'Female'),
(120, 'admin', 28, 'Female'),
(121, 'admin', 28, 'Female'),
(122, 'admin', 28, 'Female'),
(123, 'admin', 28, 'Female'),
(124, 'admin', 28, 'Female'),
(125, 'admin', 28, 'Female'),
(126, 'kk', 11, 'Female'),
(127, 'kk', 12, 'Female'),
(128, 'kk', 12, 'Female'),
(129, 'kk', 12, 'Female'),
(130, 'kk', 12, 'Female'),
(131, 'kk', 56, 'Female'),
(132, 'kk', 56, 'Female'),
(133, 'kk', 65, 'Female'),
(134, 'kk', 65, 'Female'),
(135, 'kk', 65, 'Female'),
(136, 'kk', 65, 'Female'),
(137, 'kk', 12, 'Female'),
(138, 'hi', 21, 'Female'),
(139, 'hi', 21, 'Female'),
(140, 'hi', 21, 'Female'),
(141, 'kk', 22, 'Female'),
(142, 'kk', 12, 'Female'),
(143, 'kk', 12, 'Female'),
(144, 'kk', 12, 'Female'),
(145, 'kk', 12, 'Female'),
(146, 'kk', 44, 'Female'),
(147, 'kk', 44, 'Female'),
(148, 'kk', 44, 'Female'),
(149, 'll', 11, 'Female'),
(150, 'll', 11, 'Female'),
(151, 'll', 11, 'Female'),
(152, 'hi', 24, 'Male'),
(153, 'sa', 32, 'Female'),
(154, 'jkj', 12, 'Female'),
(155, 'js', 89, 'Female'),
(156, 's', 37, 'Female'),
(157, 'jy', 67, 'Female'),
(158, 'u', 8, 'Male'),
(159, 'hsj', 2, 'Male'),
(160, 'xjs', 22, 'Female'),
(161, 'usg', 21, 'Female'),
(162, 'h', 54, 'Male'),
(163, 'hh', 78, 'Female'),
(164, 'ska', 43, 'Female'),
(165, 'hi', 21, 'Female'),
(166, 'ja', 21, 'Male'),
(167, 'ka', 56, 'Male'),
(168, 'ka', 89, 'Male'),
(169, 'jej', 25, 'Female'),
(170, 'ik', 89, 'Female'),
(171, 'ha', 32, 'Male'),
(172, 'ma', 78, 'Female'),
(173, 'uiew', 23, 'Female'),
(174, 'jw', 35, 'Female'),
(175, 'kavha', 23, 'Female'),
(176, 'gy', 56, 'Female'),
(177, 'jaj', 12, 'Female'),
(178, 'vzt', 54, 'Female'),
(179, 'yqbw', 21, 'Female'),
(180, 'yj', 25, 'Male'),
(181, 'gqja', 21, 'Female'),
(182, 'hww', 21, 'Female'),
(183, 'qyqh', 12, 'Female'),
(184, '7wj', 13, 'Female'),
(185, 'hiw', 68, 'Male'),
(186, 'yqj', 58, 'Female'),
(187, 'jaa', 54, 'Male'),
(188, 'vaia', 84, 'Female'),
(189, 'kavya', 21, 'Female'),
(190, 'kavya', 67, 'Female'),
(191, 'kavya', 64, 'Female'),
(192, 'uqhw', 84, 'Female'),
(193, '6igu', 64, 'Female'),
(194, 'pooj', 45, 'Female'),
(195, 'pooj', 45, 'Female'),
(196, 'pooj', 45, 'Female'),
(197, 'pooj', 45, 'Female'),
(198, 'pooj', 45, 'Female'),
(199, 'pooj', 45, 'Female'),
(200, 'pooj', 45, 'Female'),
(201, 'kd', 78, 'Female'),
(202, 'kd', 78, 'Female'),
(203, 'kd', 78, 'Female'),
(204, 'kd', 78, 'Female'),
(205, 'lwd', 32, 'Female'),
(206, 'kavya', 12, 'Female'),
(207, ' jzv', 31, 'Female'),
(208, ' zk', 67, 'Female'),
(209, 'hk', 54, 'Male'),
(210, 'ahna', 64, 'Female'),
(211, 'jah', 54, 'Female'),
(212, 'kavya ', 64, 'Female'),
(213, 'kavay', 54, 'Female'),
(214, 'kavya ', 12, 'Female'),
(215, 'kavya ', 21, 'Female'),
(216, 'jan', 25, 'Female'),
(217, 'haaj', 25, 'Female'),
(218, 'haaj', 25, 'Female'),
(219, 'jaj', 55, 'Male'),
(220, 'hah', 12, 'Male'),
(221, 'gaja', 12, 'Female'),
(222, 'kavy ', 69, 'Female'),
(223, 'nav', 56, 'Female'),
(224, 'nav', 56, 'Female'),
(225, 'kavya', 24, 'Female'),
(226, 'jans', 94, 'Male'),
(227, 'ham', 58, 'Female'),
(228, 'kavay', 12, 'Female'),
(229, 'gsi', 21, 'Female'),
(230, 'kav', 54, 'Female'),
(231, 'kavha', 243, 'Female'),
(232, 'kavya', 56, 'Female'),
(233, 'kavya', 56, 'Female'),
(234, 'kavya', 56, 'Female'),
(235, 'huia', 687, 'Male'),
(236, 'huia', 687, 'Male'),
(237, 'huia', 687, 'Male'),
(238, 'huia', 687, 'Male'),
(239, 'kk', 36, 'Female'),
(240, 'ko', 56, 'Male'),
(241, 'jaya', 25, 'Female'),
(242, 'gh', 36, 'Female'),
(243, 'gu', 25, 'Male'),
(244, 'kk', 89, 'Female'),
(245, 'hk', 25, 'Male'),
(246, 'jsa', 89, 'Female'),
(247, 'ko', 78, 'Male'),
(248, 'kkl', 56, 'Female'),
(249, 'hh', 67, 'Female'),
(250, 'pp', 89, 'Female'),
(251, 'yu', 89, 'Female'),
(252, 'hjha', 67, 'Female'),
(253, 'ha', 89, 'Female'),
(254, 'jkam', 78, 'Female'),
(255, 'kavya', 45, 'Female'),
(256, 'jan', 21, 'Female'),
(257, 'jaya', 34, 'Male'),
(258, 'hii', 45, 'Female'),
(259, 'pp', 33, 'Male'),
(260, 'kavga', 23, 'Female'),
(261, 'kavga', 23, 'Female'),
(262, 'kk', 13, 'Female'),
(263, 'kavya', 12, 'Female'),
(264, 'kavya', 25, 'Female');

-- --------------------------------------------------------

--
-- Table structure for table `predictions`
--

CREATE TABLE `predictions` (
  `id` int(200) NOT NULL,
  `image_path` varchar(225) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `class_name` varchar(100) NOT NULL,
  `confidence_score` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `predictions`
--

INSERT INTO `predictions` (`id`, `image_path`, `timestamp`, `class_name`, `confidence_score`) VALUES
(1, 'uploads/SAVE_20240927_115711.jpg', '2024-09-27 13:54:36', '', 0),
(2, 'uploads/SAVE_20240927_115711.jpg', '2024-09-27 13:58:05', 'glioblastoma\n', 0.96955),
(3, 'uploads/SAVE_20240927_102857.jpg', '2024-09-27 13:58:22', ' astrocytoma\n', 0.988308),
(4, 'uploads/SAVE_20240927_102857.jpg', '2024-09-27 14:03:20', ' astrocytoma\n', 0.988308),
(5, 'uploads/SAVE_20240927_115711.jpg', '2024-09-27 14:22:16', 'glioblastoma\n', 0.96955),
(6, 'uploads/Screenshot_2024-10-08-11-03-23-341_com.miui.securitycenter.jpg', '2024-10-08 11:25:38', 'hemangioblastoma\n', 0.826598),
(7, 'uploads/SAVE_20241008_114107.jpg', '2024-10-08 11:57:58', 'schwannoma\n', 0.965708),
(8, 'uploads/1000110896.jpg', '2024-10-21 08:41:32', 'marcoadenoma\n', 0.356833);

-- --------------------------------------------------------

--
-- Table structure for table `uploaded_files`
--

CREATE TABLE `uploaded_files` (
  `id` int(100) NOT NULL,
  `file_name` varchar(300) NOT NULL,
  `file_path` varchar(300) NOT NULL,
  `upload_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `uploaded_files`
--

INSERT INTO `uploaded_files` (`id`, `file_name`, `file_path`, `upload_time`) VALUES
(1, 'p.jpg', 'uploads/p.jpg', '2024-09-18 07:07:47'),
(2, 'education.png', 'uploads/education.png', '2024-09-18 07:08:15'),
(3, 'IMG-20240918-WA0016.jpg', 'uploads/IMG-20240918-WA0016.jpg', '2024-09-18 17:35:11'),
(4, 'linke.png', 'uploads/linke.png', '2024-09-19 11:51:09'),
(5, 'IMG-20240920-WA0042.jpg', 'uploads/IMG-20240920-WA0042.jpg', '2024-09-20 17:30:03'),
(6, 'IMG-20240920-WA0046.jpg', 'uploads/IMG-20240920-WA0046.jpg', '2024-09-20 17:30:52'),
(7, 'IMG-20240914-WA0000.jpg', 'uploads/IMG-20240914-WA0000.jpg', '2024-09-20 18:00:03'),
(8, 'profil.jpg', 'uploads/profil.jpg', '2024-09-21 04:37:50'),
(9, 'IMG-20240914-WA0005.jpg', 'uploads/IMG-20240914-WA0005.jpg', '2024-09-21 04:48:20'),
(10, 'IMG-20240913-WA0008.jpg', 'uploads/IMG-20240913-WA0008.jpg', '2024-09-21 04:50:06'),
(11, 'IMG-20240921-WA0000.jpg', 'uploads/IMG-20240921-WA0000.jpg', '2024-09-21 05:01:23'),
(12, 'Snapchat-1048572169.jpg', 'uploads/Snapchat-1048572169.jpg', '2024-09-21 05:20:10'),
(13, 'Screenshot_2024-09-22-15-35-25-944_com.instagram.android.jpg', 'uploads/Screenshot_2024-09-22-15-35-25-944_com.instagram.android.jpg', '2024-09-23 04:53:24'),
(14, 'IMG_20240923_084850.jpg', 'uploads/IMG_20240923_084850.jpg', '2024-09-23 04:54:15'),
(15, 'Snapchat-2058662250.jpg', 'uploads/Snapchat-2058662250.jpg', '2024-09-23 04:55:16'),
(16, 'IMG-20240923-WA0004.jpg', 'uploads/IMG-20240923-WA0004.jpg', '2024-09-23 07:41:18'),
(17, 'IMG_20240913_210429.jpg', 'uploads/IMG_20240913_210429.jpg', '2024-09-23 07:43:56'),
(18, 'IMG_20240913_210659.jpg', 'uploads/IMG_20240913_210659.jpg', '2024-09-23 07:47:25'),
(19, 'IMG_20240913_210503.jpg', 'uploads/IMG_20240913_210503.jpg', '2024-09-23 07:50:13'),
(20, 'IMG-20240913-WA0000.jpg', 'uploads/IMG-20240913-WA0000.jpg', '2024-09-23 07:52:11'),
(21, 'Snapchat-58928719.jpg', 'uploads/Snapchat-58928719.jpg', '2024-09-23 08:07:02'),
(22, 'Ilavarasan karuppan 1.JPG', 'uploads/Ilavarasan karuppan 1.JPG', '2024-09-27 07:19:01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `login1`
--
ALTER TABLE `login1`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `predictions`
--
ALTER TABLE `predictions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uploaded_files`
--
ALTER TABLE `uploaded_files`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `login1`
--
ALTER TABLE `login1`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=265;

--
-- AUTO_INCREMENT for table `predictions`
--
ALTER TABLE `predictions`
  MODIFY `id` int(200) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `uploaded_files`
--
ALTER TABLE `uploaded_files`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

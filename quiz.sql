-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 10, 2024 at 09:02 AM
-- Server version: 8.0.31
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quiz`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
CREATE TABLE IF NOT EXISTS `admins` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(19, '0001_01_01_000000_create_users_table', 1),
(20, '0001_01_01_000001_create_cache_table', 1),
(21, '0001_01_01_000002_create_jobs_table', 1),
(22, '2024_05_21_105926_password_reset_admin', 1),
(23, '2024_10_07_170156_create_quizzes_table', 1),
(24, '2024_10_07_185557_create_admins_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_admins`
--

DROP TABLE IF EXISTS `password_reset_admins`;
CREATE TABLE IF NOT EXISTS `password_reset_admins` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

DROP TABLE IF EXISTS `quizzes`;
CREATE TABLE IF NOT EXISTS `quizzes` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `quiz_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `test_length` int NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quiz_name` (`quiz_name`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quizzes`
--

INSERT INTO `quizzes` (`id`, `created_at`, `updated_at`, `quiz_name`, `test_length`, `start_time`, `end_time`) VALUES
(1, NULL, NULL, 'Samsung', 3, '2024-10-10 06:08:00', '2024-10-10 06:12:00'),
(2, NULL, NULL, 'Zer01coded Quiz', 20, '2024-10-10 06:17:00', '2024-10-10 09:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `samsung_participants`
--

DROP TABLE IF EXISTS `samsung_participants`;
CREATE TABLE IF NOT EXISTS `samsung_participants` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `application_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dob` date DEFAULT NULL,
  `attempted` tinyint(1) DEFAULT '0',
  `score` int DEFAULT NULL,
  `endtime` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `samsung_participants_application_id_unique` (`application_id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `samsung_participants`
--

INSERT INTO `samsung_participants` (`id`, `application_id`, `dob`, `attempted`, `score`, `endtime`, `created_at`, `updated_at`) VALUES
(1, 'CS21B1001', '2003-10-10', 1, 4, '2024-10-10 11:41:01', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(2, 'CS21B1002', '2003-10-11', NULL, NULL, '2024-10-10 11:44:08', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(3, 'CS21B1003', '2003-10-12', NULL, NULL, NULL, '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(4, 'CS21B1004', '2003-10-13', NULL, NULL, NULL, '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(5, 'CS21B1005', '2003-10-14', NULL, NULL, NULL, '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(6, 'CS21B1006', '2003-10-15', NULL, NULL, NULL, '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(7, 'CS21B1007', '2003-10-16', NULL, NULL, NULL, '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(8, 'CS21B1008', '2003-10-17', NULL, NULL, NULL, '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(9, 'CS21B1009', '2003-10-18', NULL, NULL, NULL, '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(10, 'CS21B1010', '2003-10-19', NULL, NULL, NULL, '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(11, 'CS21B1011', '2003-10-20', NULL, NULL, NULL, '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(12, 'CS21B1012', '2003-10-21', NULL, NULL, NULL, '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(13, 'CS21B1013', '2003-10-22', NULL, NULL, NULL, '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(14, 'CS21B1014', '2003-10-23', NULL, NULL, NULL, '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(15, 'CS21B1015', '2003-10-24', NULL, NULL, NULL, '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(16, 'CS21B1016', '2003-10-25', NULL, NULL, NULL, '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(17, 'CS21B1017', '2003-10-26', NULL, NULL, NULL, '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(18, 'CS21B1018', '2003-10-27', NULL, NULL, NULL, '2024-10-10 00:36:07', '2024-10-10 00:36:07');

-- --------------------------------------------------------

--
-- Table structure for table `samsung_questions`
--

DROP TABLE IF EXISTS `samsung_questions`;
CREATE TABLE IF NOT EXISTS `samsung_questions` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `op1` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `op2` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `op3` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `op4` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ans` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `samsung_questions`
--

INSERT INTO `samsung_questions` (`id`, `question`, `op1`, `op2`, `op3`, `op4`, `ans`, `created_at`, `updated_at`) VALUES
(1, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(2, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(3, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(4, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(5, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(6, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(7, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(8, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(9, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(10, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(11, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(12, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(13, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(14, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(15, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(16, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(17, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(18, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(19, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(20, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(21, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(22, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(23, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(24, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(25, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(26, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(27, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(28, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(29, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(30, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(31, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(32, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(33, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(34, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(35, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(36, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(37, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(38, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(39, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(40, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(41, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(42, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(43, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(44, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(45, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(46, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(47, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(48, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(49, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(50, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(51, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(52, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(53, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(54, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(55, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(56, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(57, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(58, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(59, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(60, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(61, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(62, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(63, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(64, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(65, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(66, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(67, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(68, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(69, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(70, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(71, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(72, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(73, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(74, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(75, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(76, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(77, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(78, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(79, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(80, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(81, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(82, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(83, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(84, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(85, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(86, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(87, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(88, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(89, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(90, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(91, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(92, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(93, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(94, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(95, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(96, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(97, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(98, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(99, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06'),
(100, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:36:06', '2024-10-10 00:36:06');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('L9ZuSVcl3uKx1QI6Za5BPR5qEltVV14rFWFEbwEC', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjY6Il90b2tlbiI7czo0MDoicUZSNXNnVHVmVFhnREQzdThOZmdSeXdLVzdDZFFzdmlXSXlvR3poNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fX0=', 1728548189),
('3qhBOeynGN2xZSjW0yfIWWSkwCmpbtwawebu7VC8', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT052ZGpHNnVZRGxVMjJwR1JVMmxwaGxQUGNSRTBmS1dQTFB1N2NQOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tYW5pZmVzdC5qc29uIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1728545708),
('bCybO4QMrnQvg9BBH1S1Kzx6axYhhWAvwDtfRYfL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUUllMjRTV29hUUhDQjRtSzhsZGprMW8zYUdmVUNkNmxZdW04RExtbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tYW5pZmVzdC5qc29uIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1728546208),
('haWT9ND3XGR71TVai93vkwmPywDm8sUs0LypPK3w', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOU5LQlhrNkpackJnWmN6bXhRbE1RVzk3NXpWNjdTenNWbnZGaGI0TCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1728548245),
('ycxMHxD64JhnhZsR4I1XosSb9EdhbjpPm18IgGiZ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:131.0) Gecko/20100101 Firefox/131.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZkFtZzhMOEZRcnQ2U3hVc1VOWDFkaGgwbW4wakg2Qms2c2hBWE9FWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NToiYWRtaW4iO086ODoic3RkQ2xhc3MiOjg6e3M6MjoiaWQiO2k6MTtzOjQ6Im5hbWUiO3M6MTM6Ikt1bmFsIEJpbGxhZGUiO3M6NToiZW1haWwiO3M6MjM6ImNhcHRhaW5iYXJuczFAZ21haWwuY29tIjtzOjE3OiJlbWFpbF92ZXJpZmllZF9hdCI7czoxOToiMDAwMC0wMC0wMCAwMDowMDowMCI7czo4OiJwYXNzd29yZCI7czo2MDoiJDJ5JDEyJFRGaDcvOVZkbTNqcW81dVVjVGhma09ueWk2TTFIeEN2aE93c2gwZ1VZRlE2UTFkSHZyWEwyIjtzOjE0OiJyZW1lbWJlcl90b2tlbiI7czowOiIiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjAwMDAtMDAtMDAgMDA6MDA6MDAiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjAwMDAtMDAtMDAgMDA6MDA6MDAiO319', 1728548220),
('TlH8jo182HlfCfWp71a88QXqmm6uev9W3T8pLhmr', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:131.0) Gecko/20100101 Firefox/131.0', 'YTozOntzOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjY6Il90b2tlbiI7czo0MDoiUFlwU3JUSmludU5Yb2tNYkxtd3VLd3kyM0dQSHh6SjdBQ2pVTHhGUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fX0=', 1728548213),
('bpLxScxw92972FkhZFc5A1byGCXO4GhsF0Rh1E84', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYVFZMVN0a294aFA3NGFQNW5NMENMaEhTUU9qbDh4NEd0anF2WGpzQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tYW5pZmVzdC5qc29uIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1728546241),
('zltiU92bV7sCr1wjxfs87H8h3lNyiGrOhIQSyuJx', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiak1EUXdCVkc0M1dMajNobm9vcWV2bEhsbjR3M0VEcks3WEM0Q2FXMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tYW5pZmVzdC5qc29uIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1728546279),
('WcMyDgtTM2qqX5IkHq7wYzSkAch28WAOJ2v6mRdt', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:131.0) Gecko/20100101 Firefox/131.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWGdnQjR3djJpUVhBdlRCMlhGUE1UUXpOdTkxSDhOWjZxUVFuTzZIMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9tYW5pZmVzdC5qc29uIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1728548082),
('jNPjq11rUnMLOq8JbBHVbKidefe74cLaJnXDzOVe', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:131.0) Gecko/20100101 Firefox/131.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieldnd0k3N3NEQWdNQkdLWXhwY0hrRHdnM0NXR0lXdG4zeUhDZ3JLRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9tYW5pZmVzdC5qc29uIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1728548153),
('f7psJ5Xmfu3eFcve1Ve5YbttrLC0PsfQquK8a3IV', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ1B2WmgzZ0dMZVA2UDlnRzZvVkJWSUE2STJVSVpvVEZ3Q2QxWTZVcyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tYW5pZmVzdC5qc29uIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1728548170),
('RxTzg4yu66YkLNX0IIU82lSQYaG95MkrBwdo2Mck', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTXZHeGhUeUxqbXllbEJ3Z0FvUHFVc3JTVmVCeVg2QWdvMjVNcEtQYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tYW5pZmVzdC5qc29uIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1728548181),
('bAAm8QQ7LmqNriHlMwxLHFMNXNhQYL2etLI4lGGu', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaXFrN1FrS3ZHQUtuN0Q0VTk5SWFiZjNiUlhXTFN0VUhLMmNuVnpDbiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tYW5pZmVzdC5qc29uIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1728548186),
('xkvcPtOFgcYmLHEv7sAbdpBlre9NzIksAgrsl3Tl', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZEcxUFdNeUpteG9INkhpcVZ6REs4TTlSYTZsOTNRc1ZvakIzR1JxbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tYW5pZmVzdC5qc29uIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1728548188),
('p0lj8cSFh8cnKNNMppXLxfUFyYMGkUBoSSxKSwRN', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSFU3YTFrY3c3OExYQVNmSDZEZG9TUVJVT0p6clNLQ2lRMk1SNTNxciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tYW5pZmVzdC5qc29uIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1728548190),
('Sbjh9LnpGWd2WpJaI6E4jX3Ts2DE0KKx8Cqd6mg2', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiakZmRFNiVzY5dUJSSXdmWDlSa0J0c2gwa2RlOWozTmlsTDJsVHB4QiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tYW5pZmVzdC5qc29uIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1728548244),
('W0MOW0EhQldrVgKvKsnjVbUGBb6WI8ne8AwauhJL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiak9iWUhNU0JDQmh2dWR1WTZtSlNKRlVPN01oVVFhUVdtY201VzR1byI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tYW5pZmVzdC5qc29uIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1728548246);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Kunal Billade', 'captainbarns1@gmail.com', '0000-00-00 00:00:00', '$2y$12$TFh7/9Vdm3jqo5uUcThfkOnyi6M1HxCvhOwsh0gUYFQ6Q1dHvrXL2', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `zer01coded quiz_participants`
--

DROP TABLE IF EXISTS `zer01coded quiz_participants`;
CREATE TABLE IF NOT EXISTS `zer01coded quiz_participants` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `application_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dob` date DEFAULT NULL,
  `attempted` tinyint(1) DEFAULT '0',
  `score` int DEFAULT NULL,
  `endtime` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `zer01coded quiz_participants_application_id_unique` (`application_id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `zer01coded quiz_participants`
--

INSERT INTO `zer01coded quiz_participants` (`id`, `application_id`, `dob`, `attempted`, `score`, `endtime`, `created_at`, `updated_at`) VALUES
(1, 'CS21B1001', '2003-10-10', 1, 5, '2024-10-10 12:07:02', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(2, 'CS21B1002', '2003-10-11', 1, 3, '2024-10-10 12:24:37', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(3, 'CS21B1003', '2003-10-12', 1, 0, '2024-10-10 12:16:29', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(4, 'CS21B1004', '2003-10-13', 1, 4, '2024-10-10 12:26:48', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(5, 'CS21B1005', '2003-10-14', NULL, NULL, NULL, '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(6, 'CS21B1006', '2003-10-15', NULL, NULL, NULL, '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(7, 'CS21B1007', '2003-10-16', NULL, NULL, NULL, '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(8, 'CS21B1008', '2003-10-17', NULL, NULL, NULL, '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(9, 'CS21B1009', '2003-10-18', 1, 4, '2024-10-10 13:21:34', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(10, 'CS21B1010', '2003-10-19', NULL, NULL, NULL, '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(11, 'CS21B1011', '2003-10-20', NULL, NULL, NULL, '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(12, 'CS21B1012', '2003-10-21', NULL, NULL, NULL, '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(13, 'CS21B1013', '2003-10-22', NULL, NULL, NULL, '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(14, 'CS21B1014', '2003-10-23', NULL, NULL, NULL, '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(15, 'CS21B1015', '2003-10-24', NULL, NULL, NULL, '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(16, 'CS21B1016', '2003-10-25', NULL, NULL, NULL, '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(17, 'CS21B1017', '2003-10-26', NULL, NULL, NULL, '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(18, 'CS21B1018', '2003-10-27', NULL, NULL, NULL, '2024-10-10 00:46:18', '2024-10-10 00:46:18');

-- --------------------------------------------------------

--
-- Table structure for table `zer01coded quiz_questions`
--

DROP TABLE IF EXISTS `zer01coded quiz_questions`;
CREATE TABLE IF NOT EXISTS `zer01coded quiz_questions` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `op1` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `op2` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `op3` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `op4` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ans` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `zer01coded quiz_questions`
--

INSERT INTO `zer01coded quiz_questions` (`id`, `question`, `op1`, `op2`, `op3`, `op4`, `ans`, `created_at`, `updated_at`) VALUES
(1, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(2, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(3, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(4, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(5, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(6, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(7, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(8, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(9, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(10, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(11, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(12, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(13, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(14, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(15, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(16, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(17, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(18, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(19, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(20, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(21, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(22, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(23, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(24, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(25, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(26, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(27, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(28, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(29, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(30, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(31, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(32, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(33, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(34, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(35, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(36, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(37, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(38, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(39, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(40, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(41, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(42, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(43, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(44, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(45, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(46, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(47, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(48, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(49, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(50, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(51, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(52, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(53, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(54, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(55, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(56, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(57, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(58, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(59, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(60, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(61, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(62, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(63, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(64, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(65, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(66, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(67, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(68, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(69, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(70, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(71, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(72, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(73, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(74, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(75, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(76, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(77, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(78, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(79, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(80, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(81, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(82, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(83, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(84, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(85, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(86, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(87, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(88, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(89, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(90, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(91, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(92, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(93, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(94, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(95, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(96, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(97, 'If A + B means A is the mother of B; A - B means A is the brother B; A % B means A is the father of B and A x B means A is the sister of B, which of the following shows that P is the maternal uncle of Q?', 'Q - N + M x P', 'P + S x N - Q', 'P - M + N x Q', 'Q - S % P', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(98, 'Pointing towards a girl, Akash says, \"This girl is the daughter of only a child of my father.\" What is the relation of Akash\'s wife to that girl?', 'Daughter', 'Mother', 'Aunt', 'Sister', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(99, 'Anupam said to a lady sitting in a car, \"The only daughter of the brother of my wife is the sister-in-law of the brother of your sister.\" How the husband of the lady is related to Anupam?', 'Maternal Uncle', 'Uncle', 'Father', 'Son-In-Law', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18'),
(100, 'From his house, Laksh went 15 km to the North. Then he turned west and covered 10 km. Then he turned south and covered 5 km. Finally turning to the east, he covered 10 km. In which direction is he from his house?', 'East', 'West', 'North', 'South', '1', '2024-10-10 00:46:18', '2024-10-10 00:46:18');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

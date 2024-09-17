-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql-db
-- Generation Time: Sep 14, 2024 at 04:21 PM
-- Server version: 8.0.37
-- PHP Version: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `afriqom`
--

-- --------------------------------------------------------

--
-- Table structure for table `blobs`
--

CREATE TABLE `blobs` (
  `id` varchar(36) NOT NULL COMMENT 'Unique identifier for each blob',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The original name of the blob',
  `mime_type` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Mime type of blob resource',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Blob resource',
  `size` double NOT NULL COMMENT 'The size of the blob resource',
  `user_id` varchar(36) NOT NULL COMMENT 'The identifier for the user',
  `status` enum('active','pending','deleted') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'active' COMMENT 'Different states of the blob (default is active)',
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The date this entry was made (auto generated)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT;


--
-- Table structure for table `databoards`
--

CREATE TABLE `databoards` (
  `id` varchar(36) NOT NULL,
  `country` varchar(255) NOT NULL,
  `standard_rate` decimal(10,2) NOT NULL,
  `standard_light_databoard_url` varchar(255) NOT NULL,
  `standard_dark_databoard_url` varchar(255) NOT NULL,
  `advanced_rate` decimal(10,2) NOT NULL,
  `advanced_light_databoard_url` varchar(255) NOT NULL,
  `advanced_dark_databoard_url` varchar(255) NOT NULL,
  `premium_rate` decimal(10,2) NOT NULL,
  `premium_light_databoard_url` varchar(255) NOT NULL,
  `premium_dark_databoard_url` varchar(255) NOT NULL,
  `last_updated` date DEFAULT NULL,
  `newly_launched` enum('Yes','No') DEFAULT NULL,
  `tags` text,
  `status` enum('active','pending','deleted') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'active',
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `databoards`
--

INSERT INTO `databoards` (`id`, `country`, `standard_rate`, `standard_light_databoard_url`, `standard_dark_databoard_url`, `advanced_rate`, `advanced_light_databoard_url`, `advanced_dark_databoard_url`, `premium_rate`, `premium_light_databoard_url`, `premium_dark_databoard_url`, `last_updated`, `newly_launched`, `tags`, `status`, `date_created`, `created_by_id`) VALUES
('0e3f843c-4c2b-4742-915d-30efa625403a', 'CI', 44.00, 'https://app.powerbi.com/view?r=eyJrIjoiOWQ5YWMxOGUtZjRjYy00YjM0LTkzNzYtNTMwMTRhNzQ5NTgxIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiZWZhMWQzY2YtZDFlMy00Mjk5LWI3N2UtMzJiMDgxNjZkYWM2IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 54.00, 'https://app.powerbi.com/view?r=eyJrIjoiOWQ5YWMxOGUtZjRjYy00YjM0LTkzNzYtNTMwMTRhNzQ5NTgxIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiZWZhMWQzY2YtZDFlMy00Mjk5LWI3N2UtMzJiMDgxNjZkYWM2IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 64.00, 'https://app.powerbi.com/view?r=eyJrIjoiOWQ5YWMxOGUtZjRjYy00YjM0LTkzNzYtNTMwMTRhNzQ5NTgxIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiZWZhMWQzY2YtZDFlMy00Mjk5LWI3N2UtMzJiMDgxNjZkYWM2IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', '2024-07-11', 'Yes', 'Vessel Traking,     Tenders', 'active', '2024-07-03 15:21:35', '13635a25-0d5b-4e6a-92ef-6c929444440e'),
('30294846-e6c9-4dc5-8d50-8e906274c026', 'GH', 44.00, 'https://app.powerbi.com/view?r=eyJrIjoiMzliNmViYjEtMDA5NS00NDM2LTlkYjQtMzRlZDk1YWJjMmNlIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiYzEyZWY4ODQtMTBmMS00MGM3LTg2MjUtNGUwZmQzZTQ5MDExIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 125.00, 'https://app.powerbi.com/view?r=eyJrIjoiMzliNmViYjEtMDA5NS00NDM2LTlkYjQtMzRlZDk1YWJjMmNlIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiYzEyZWY4ODQtMTBmMS00MGM3LTg2MjUtNGUwZmQzZTQ5MDExIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 150.00, 'https://app.powerbi.com/view?r=eyJrIjoiMzliNmViYjEtMDA5NS00NDM2LTlkYjQtMzRlZDk1YWJjMmNlIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiYzEyZWY4ODQtMTBmMS00MGM3LTg2MjUtNGUwZmQzZTQ5MDExIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', '2024-06-21', 'No', 'Imports,      Vessel Tracking,   Tenders', 'active', '2024-06-21 19:04:14', '13635a25-0d5b-4e6a-92ef-6c929444440e'),
('5547cb6a-99e7-41c4-84cb-ec2dca956c50', 'TZ', 45.00, 'https://app.powerbi.com/groups/c12c30ce-34c7-45bd-bfbb-c7261d3c67b0/reports/1e7e6b6f-3fb2-4ead-91f7-8df38f6f1891/d3966763a943562fec93?experience=power-bi', 'https://app.powerbi.com/view?r=eyJrIjoiMWQ4MmRkZGYtNjMzYy00MTNmLWJjYmQtY2ViZTU1Y2FhNjIwIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 99.00, 'https://app.powerbi.com/groups/c12c30ce-34c7-45bd-bfbb-c7261d3c67b0/reports/1e7e6b6f-3fb2-4ead-91f7-8df38f6f1891/d3966763a943562fec93?experience=power-bi', 'https://app.powerbi.com/view?r=eyJrIjoiMWQ4MmRkZGYtNjMzYy00MTNmLWJjYmQtY2ViZTU1Y2FhNjIwIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 150.00, 'https://app.powerbi.com/groups/c12c30ce-34c7-45bd-bfbb-c7261d3c67b0/reports/1e7e6b6f-3fb2-4ead-91f7-8df38f6f1891/d3966763a943562fec93?experience=power-bi', 'https://app.powerbi.com/view?r=eyJrIjoiMWQ4MmRkZGYtNjMzYy00MTNmLWJjYmQtY2ViZTU1Y2FhNjIwIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', '2024-06-21', 'Yes', 'Imports,        Vessel Traking,        Tenders', 'active', '2024-07-03 18:00:28', '13635a25-0d5b-4e6a-92ef-6c929444440e'),
('67604e0c-e34c-417d-be65-c5a19f7670b9', 'KE', 53.00, 'https://app.powerbi.com/view?r=eyJrIjoiNGI4MzEwMmItNjM3ZC00Nzk5LTljZTctYTE4MGZmYTdlODVkIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiMjJkOTI3YTQtNzBmNi00MDFhLWI2MDItOWExOTllOWY0ZmY0IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 106.00, 'https://app.powerbi.com/view?r=eyJrIjoiNGI4MzEwMmItNjM3ZC00Nzk5LTljZTctYTE4MGZmYTdlODVkIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiMjJkOTI3YTQtNzBmNi00MDFhLWI2MDItOWExOTllOWY0ZmY0IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 179.00, 'https://app.powerbi.com/view?r=eyJrIjoiNGI4MzEwMmItNjM3ZC00Nzk5LTljZTctYTE4MGZmYTdlODVkIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiMjJkOTI3YTQtNzBmNi00MDFhLWI2MDItOWExOTllOWY0ZmY0IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', '2024-06-21', 'Yes', 'Imports,     Vessel Tracking,     Tenders', 'active', '2024-06-21 19:04:14', '13635a25-0d5b-4e6a-92ef-6c929444440e'),
('67ecaac0-3091-4079-8b26-1dc086499662', 'ZM', 400.00, 'https://app.powerbi.com/view?r=eyJrIjoiM2E3YjRkMTgtNTRjOC00ZjRlLWIzOGUtNGFkODc3ZTJmNTJiIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiZDM1N2ZiYjItNzM0ZC00MzhmLTllODgtZGU0YjRkYjMxMDc1IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 96.00, 'https://app.powerbi.com/view?r=eyJrIjoiM2E3YjRkMTgtNTRjOC00ZjRlLWIzOGUtNGFkODc3ZTJmNTJiIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiZDM1N2ZiYjItNzM0ZC00MzhmLTllODgtZGU0YjRkYjMxMDc1IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 121.00, 'https://app.powerbi.com/view?r=eyJrIjoiM2E3YjRkMTgtNTRjOC00ZjRlLWIzOGUtNGFkODc3ZTJmNTJiIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiZDM1N2ZiYjItNzM0ZC00MzhmLTllODgtZGU0YjRkYjMxMDc1IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', '2024-06-21', 'No', 'Imports,        Vessel Tracking,      Tenders', 'active', '2024-06-21 19:04:14', '13635a25-0d5b-4e6a-92ef-6c929444440e'),
('86401695-9a5d-443f-b0d4-c13428cf8a5b', 'MA', 45.00, 'https://app.powerbi.com/view?r=eyJrIjoiZTg0ZTgxYTItNWMzOC00ZTMwLWE2N2YtZjdlNTM5MGUwNDE0IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiNGYyMmY0ZTMtZTBmZi00N2Q5LTlmZDEtN2E2YThlMTBjNjUyIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 99.00, 'https://app.powerbi.com/view?r=eyJrIjoiZTg0ZTgxYTItNWMzOC00ZTMwLWE2N2YtZjdlNTM5MGUwNDE0IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiNGYyMmY0ZTMtZTBmZi00N2Q5LTlmZDEtN2E2YThlMTBjNjUyIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 150.00, 'https://app.powerbi.com/view?r=eyJrIjoiZTg0ZTgxYTItNWMzOC00ZTMwLWE2N2YtZjdlNTM5MGUwNDE0IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiNGYyMmY0ZTMtZTBmZi00N2Q5LTlmZDEtN2E2YThlMTBjNjUyIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', '2024-06-21', 'Yes', 'Imports,      Vessel Tracking,      Tenders', 'active', '2024-07-02 16:10:47', '13635a25-0d5b-4e6a-92ef-6c929444440e'),
('ddd4de41-dd77-4284-aaba-5a4521ca55be', 'NG', 33.00, 'https://app.powerbi.com/view?r=eyJrIjoiMjBmNGQ5NmEtMGI5ZC00ZDRhLWI4MjEtYWI3YzYxZDJmMjhmIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiY2UzOWYzZTAtMzMxMy00NDAxLTk5ZTMtZWU2MTA1NzY3ZWNkIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 44.00, 'https://app.powerbi.com/view?r=eyJrIjoiMjBmNGQ5NmEtMGI5ZC00ZDRhLWI4MjEtYWI3YzYxZDJmMjhmIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiY2UzOWYzZTAtMzMxMy00NDAxLTk5ZTMtZWU2MTA1NzY3ZWNkIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 54.00, 'https://app.powerbi.com/view?r=eyJrIjoiMjBmNGQ5NmEtMGI5ZC00ZDRhLWI4MjEtYWI3YzYxZDJmMjhmIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiY2UzOWYzZTAtMzMxMy00NDAxLTk5ZTMtZWU2MTA1NzY3ZWNkIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', '2024-07-04', 'No', 'Imports,       Tenders,       Vessel Traking', 'active', '2024-07-03 10:59:37', '13635a25-0d5b-4e6a-92ef-6c929444440e');

-- --------------------------------------------------------

--
-- Table structure for table `organisations`
--

CREATE TABLE `organisations` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `industry` varchar(255) DEFAULT NULL,
  `about` text,
  `logo` varchar(255) DEFAULT NULL,
  `subscription` enum('Individual Access','Full Access','Custom') DEFAULT NULL,
  `status` enum('active','pending','approval request','deleted') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `regions`
--

CREATE TABLE `regions` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `standard_rate` decimal(10,2) NOT NULL,
  `advanced_rate` decimal(10,2) NOT NULL,
  `premium_rate` decimal(10,2) NOT NULL,
  `status` enum('active','pending','deleted') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'active',
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `regions`
--

INSERT INTO `regions` (`id`, `name`, `standard_rate`, `advanced_rate`, `premium_rate`, `status`, `date_created`, `created_by_id`) VALUES
('c86a9b5f-520b-4b09-ae6d-ca7ed2996548', 'All Countries', 1300.00, 1800.00, 1900.00, 'active', '2024-07-09 22:13:39', '13635a25-0d5b-4e6a-92ef-6c929444440e');

-- --------------------------------------------------------

--
-- Table structure for table `region_databoards`
--

CREATE TABLE `region_databoards` (
  `id` varchar(36) NOT NULL,
  `region_id` varchar(36) NOT NULL,
  `databoard_id` varchar(36) NOT NULL,
  `status` enum('active','pending','deleted') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `region_databoards`
--

INSERT INTO `region_databoards` (`id`, `region_id`, `databoard_id`, `status`) VALUES
('5c2d2a5b-b5a4-4274-9dc8-2c82a2232624', 'c86a9b5f-520b-4b09-ae6d-ca7ed2996548', '0e3f843c-4c2b-4742-915d-30efa625403a', 'active'),
('6c10a114-eeeb-417f-be21-1e12641b72a2', 'c86a9b5f-520b-4b09-ae6d-ca7ed2996548', '67ecaac0-3091-4079-8b26-1dc086499662', 'active'),
('762792b9-2e4f-463d-987e-fa0db0a5093b', 'c86a9b5f-520b-4b09-ae6d-ca7ed2996548', '5547cb6a-99e7-41c4-84cb-ec2dca956c50', 'active'),
('bd91cc64-7b3a-492f-a08e-cc1bc9ef69f8', 'c86a9b5f-520b-4b09-ae6d-ca7ed2996548', '67604e0c-e34c-417d-be65-c5a19f7670b9', 'active'),
('c4788a92-4d30-4f7b-a12a-9e5b59ba5ee8', 'c86a9b5f-520b-4b09-ae6d-ca7ed2996548', '86401695-9a5d-443f-b0d4-c13428cf8a5b', 'active'),
('ceb86bec-df02-48dc-a1e2-8a65507eab22', 'c86a9b5f-520b-4b09-ae6d-ca7ed2996548', '30294846-e6c9-4dc5-8d50-8e906274c026', 'active'),
('e136b530-7e31-4cff-81cf-d3b86d5937af', 'c86a9b5f-520b-4b09-ae6d-ca7ed2996548', 'ddd4de41-dd77-4284-aaba-5a4521ca55be', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` varchar(36) NOT NULL,
  `organisation_id` varchar(36) NOT NULL,
  `databoard_id` varchar(36) DEFAULT NULL,
  `region_id` varchar(36) DEFAULT NULL,
  `license` enum('Standard','Advanced','Premium','Custom') NOT NULL,
  `rate_paid` decimal(10,2) NOT NULL,
  `start_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `custom_subscription_light_databoard_url` varchar(255) DEFAULT NULL,
  `custom_subscription_dark_databoard_url` varchar(255) DEFAULT NULL,
  `package` enum('Individual Access','Full Access') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Individual Access',
  `status` enum('active','pending','approval request','deleted') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(36) NOT NULL COMMENT 'Unique identifier for each user account',
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The user''s full name',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The user''s email address',
  `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The user''s phone number',
  `whatsapp_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'The user''s whatsapp number',
  `access_country_restriction` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The country the user is restricted to access the databoards from',
  `account_type` enum('Super Administrator','Sales Administrator','Data Administrator','Administrator','User') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The user''s account type',
  `main_contact` enum('Yes','No') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'No' COMMENT 'Is this user the main contact?',
  `light_preference` enum('Yes','No') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Yes' COMMENT 'Does the user prefer light or dark mode',
  `organisation_id` varchar(36) DEFAULT NULL COMMENT 'The user''s organisation id',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The user''s username',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The user''s login password',
  `access_portal` enum('backend','client') NOT NULL DEFAULT 'client',
  `status` enum('active','pending','approval request','deleted') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'active' COMMENT 'The different states of a user (default is active)',
  `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'The user agent or browser used for during last login',
  `ip_address` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'The IP Address of last login',
  `x_forwarded_for_ip_address` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'The XForwaredIP Address of last login',
  `last_login_date` datetime DEFAULT NULL COMMENT 'The user''s last login date and time',
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The date this entry was made (auto generated)',
  `auth_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT 'Token for user verification',
  `yubico_auth` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT 'The yubico auth string',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `phone_number`, `whatsapp_number`, `access_country_restriction`, `account_type`, `main_contact`, `light_preference`, `organisation_id`, `username`, `password`, `access_portal`, `status`, `user_agent`, `ip_address`, `x_forwarded_for_ip_address`, `last_login_date`, `created_date`, `auth_token`, `yubico_auth`) VALUES
('13635a25-0d5b-4e6a-92ef-6c929444440e', 'System Admin', 'admin@afriqom.com', '233240000000', '233240000000', '', 'Super Administrator', 'No', 'Yes', NULL, 'admin@afriqom.com', '7ece99e593ff5dd200e2b9233d9ba654', 'backend', 'active', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '102.176.75.170', NULL, '2024-09-12 09:34:19', '2024-05-02 00:16:27', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_databoards`
--

CREATE TABLE `user_databoards` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `databoard_id` varchar(36) NOT NULL,
  `status` enum('active','pending','deleted') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------


CREATE VIEW `vw_expired_subscriptions`  AS SELECT `subscriptions`.`id` AS `id`, `subscriptions`.`organisation_id` AS `organisation_id`, `subscriptions`.`databoard_id` AS `databoard_id`, `subscriptions`.`region_id` AS `region_id`, `subscriptions`.`license` AS `license`, `subscriptions`.`rate_paid` AS `rate_paid`, `subscriptions`.`start_date` AS `start_date`, `subscriptions`.`expiry_date` AS `expiry_date`, `subscriptions`.`custom_subscription_light_databoard_url` AS `custom_subscription_light_databoard_url`, `subscriptions`.`custom_subscription_dark_databoard_url` AS `custom_subscription_dark_databoard_url`, `subscriptions`.`package` AS `package`, `subscriptions`.`status` AS `status` FROM `subscriptions` WHERE ((`subscriptions`.`expiry_date` < now()) AND (`subscriptions`.`status` = 'active')) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_region_databoards`
--

CREATE VIEW `vw_region_databoards`  AS SELECT `a`.`id` AS `id`, `a`.`region_id` AS `region_id`, `b`.`name` AS `region_name`, `a`.`databoard_id` AS `databoard_id`, `c`.`country` AS `country`, `c`.`tags` AS `tags`, `c`.`status` AS `status` FROM ((`region_databoards` `a` join `regions` `b`) join `databoards` `c`) WHERE ((`a`.`region_id` = `b`.`id`) AND (`c`.`id` = `a`.`databoard_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_subscriptions`
--

CREATE VIEW `vw_subscriptions`  AS SELECT `a`.`id` AS `id`, `a`.`organisation_id` AS `organisation_id`, `b`.`name` AS `organisation_name`, `a`.`databoard_id` AS `databoard_id`, `c`.`country` AS `country`, `a`.`region_id` AS `region_id`, `a`.`license` AS `license`, `a`.`rate_paid` AS `rate_paid`, `a`.`start_date` AS `start_date`, `a`.`expiry_date` AS `expiry_date`, `a`.`custom_subscription_light_databoard_url` AS `custom_subscription_light_databoard_url`, `a`.`custom_subscription_dark_databoard_url` AS `custom_subscription_dark_databoard_url`, `a`.`package` AS `package`, `a`.`status` AS `status` FROM ((`subscriptions` `a` join `organisations` `b` on((`a`.`organisation_id` = `b`.`id`))) left join `databoards` `c` on((`a`.`databoard_id` = `c`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_user_databoards`
--

CREATE VIEW `vw_user_databoards`  AS SELECT `a`.`id` AS `id`, `a`.`databoard_id` AS `databoard_id`, `a`.`user_id` AS `user_id`, `b`.`country` AS `country`, `b`.`standard_rate` AS `standard_rate`, `b`.`standard_light_databoard_url` AS `standard_light_databoard_url`, `b`.`standard_dark_databoard_url` AS `standard_dark_databoard_url`, `b`.`advanced_rate` AS `advanced_rate`, `b`.`advanced_light_databoard_url` AS `advanced_light_databoard_url`, `b`.`advanced_dark_databoard_url` AS `advanced_dark_databoard_url`, `b`.`premium_rate` AS `premium_rate`, `b`.`premium_light_databoard_url` AS `premium_light_databoard_url`, `b`.`premium_dark_databoard_url` AS `premium_dark_databoard_url`, `b`.`last_updated` AS `last_updated`, `b`.`newly_launched` AS `newly_launched`, `b`.`tags` AS `tags`, `b`.`status` AS `status`, `b`.`date_created` AS `date_created`, `b`.`created_by_id` AS `created_by_id` FROM ((`user_databoards` `a` join `databoards` `b` on((`a`.`databoard_id` = `b`.`id`))) join `users` `c` on((`a`.`user_id` = `c`.`id`))) WHERE ((`b`.`status` = 'active') AND `a`.`databoard_id` in (select `d`.`databoard_id` from `subscriptions` `d` where ((`a`.`databoard_id` = `d`.`databoard_id`) AND (`d`.`status` in ('active','pending')) AND (`d`.`expiry_date` >= now())))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blobs`
--
ALTER TABLE `blobs`
  ADD KEY `status` (`status`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `databoards`
--
ALTER TABLE `databoards`
  ADD UNIQUE KEY `country` (`country`),
  ADD KEY `status` (`status`),
  ADD KEY `created_by_id` (`created_by_id`);

--
-- Indexes for table `organisations`
--
ALTER TABLE `organisations`
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `regions`
--
ALTER TABLE `regions`
  ADD KEY `status` (`status`),
  ADD KEY `created_by_id` (`created_by_id`);

--
-- Indexes for table `region_databoards`
--
ALTER TABLE `region_databoards`
  ADD UNIQUE KEY `unique_region_databoard` (`region_id`,`databoard_id`) USING BTREE,
  ADD KEY `status` (`status`),
  ADD KEY `databoard_id` (`databoard_id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD UNIQUE KEY `organisation_id_2` (`organisation_id`,`databoard_id`,`region_id`),
  ADD KEY `organisation_id` (`organisation_id`),
  ADD KEY `databoard_id` (`databoard_id`),
  ADD KEY `status` (`status`),
  ADD KEY `region_id` (`region_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone_number` (`phone_number`),
  ADD KEY `status` (`status`),
  ADD KEY `organisation_id` (`organisation_id`);

--
-- Indexes for table `user_databoards`
--
ALTER TABLE `user_databoards`
  ADD UNIQUE KEY `user_id` (`user_id`,`databoard_id`),
  ADD KEY `databoard_id` (`databoard_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `blobs`
--
ALTER TABLE `blobs`
  ADD CONSTRAINT `blobs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `databoards`
--
ALTER TABLE `databoards`
  ADD CONSTRAINT `databoards_ibfk_1` FOREIGN KEY (`created_by_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `regions`
--
ALTER TABLE `regions`
  ADD CONSTRAINT `regions_ibfk_1` FOREIGN KEY (`created_by_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `region_databoards`
--
ALTER TABLE `region_databoards`
  ADD CONSTRAINT `region_databoards_ibfk_1` FOREIGN KEY (`databoard_id`) REFERENCES `databoards` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `region_databoards_ibfk_2` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`databoard_id`) REFERENCES `databoards` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `subscriptions_ibfk_2` FOREIGN KEY (`organisation_id`) REFERENCES `organisations` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `subscriptions_ibfk_3` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`organisation_id`) REFERENCES `organisations` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `user_databoards`
--
ALTER TABLE `user_databoards`
  ADD CONSTRAINT `user_databoards_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `user_databoards_ibfk_2` FOREIGN KEY (`databoard_id`) REFERENCES `databoards` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
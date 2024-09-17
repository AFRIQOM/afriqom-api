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
  `id` varchar(36) NOT NULL COMMENT 'Unique identifier for each blob (auto incremented)',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The original name of the blob',
  `mime_type` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Mime type of blob resource',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Blob resource',
  `size` double NOT NULL COMMENT 'The size of the blob resource',
  `user_id` varchar(36) NOT NULL COMMENT 'The identifier for the user',
  `status` enum('active','pending','deleted') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'active' COMMENT 'Different states of the blob (default is active)',
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The date this entry was made (auto generated)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `blobs`
--

INSERT INTO `blobs` (`id`, `name`, `mime_type`, `url`, `size`, `user_id`, `status`, `created_date`) VALUES
('5e2bcd6c-618e-4b29-aa2c-fe1e90e7ed28', 'file_example_MP3_700KB.mp3', 'audio/mpeg', '1724928655_file_example_MP3_700KB.mp3', 733645, '13635a25-0d5b-4e6a-92ef-6c929444440e', 'active', '2024-08-29 10:50:55'),
('5e3aab2c-b4fa-44b5-ae9a-01fdaef178e4', '647deb38f8e12e7a4bea48c7_newheroimage.webp', 'image/webp', '1724931159_647deb38f8e12e7a4bea48c7_newheroimage.webp', 63384, 'e8e9e522-de1b-4d39-8ca3-3861f5ccdb08', 'active', '2024-08-29 11:32:39'),
('6c7950bc-a5fb-410b-a55f-befa105f3405', 'Screenshot 2024-08-27 153714.png', 'image/png', '1725292596_Screenshot 2024-08-27 153714.png', 61337, '13635a25-0d5b-4e6a-92ef-6c929444440e', 'active', '2024-09-02 15:56:36'),
('934ffd8f-2c53-460b-a47c-b97cc5a3187f', '0b43eae0-096c-4ae1-8882-3e95ffce0528.jpeg', 'image/jpeg', '1724962729_0b43eae0-096c-4ae1-8882-3e95ffce0528.jpeg', 40362, '13635a25-0d5b-4e6a-92ef-6c929444440e', 'active', '2024-08-29 20:18:49'),
('9d833a74-4923-44b0-ab4a-eebe41259c2e', 'marcus-loke-xXJ6utyoSw0-unsplash.jpg', 'image/jpeg', '1725429360_marcus-loke-xXJ6utyoSw0-unsplash.jpg', 109648, '13635a25-0d5b-4e6a-92ef-6c929444440e', 'active', '2024-09-04 05:56:00'),
('9f937319-24d9-442d-b97f-e8f77102c546', 'Africa v2.png', 'image/png', '1725289297_Africa v2.png', 45533, '13635a25-0d5b-4e6a-92ef-6c929444440e', 'active', '2024-09-02 15:01:37'),
('a6f049b3-4eba-4225-957e-5b75268a9d6e', 'mohammad-rahmani-LrxSl4ZxoRs-unsplash.jpg', 'image/jpeg', '1724951037_mohammad-rahmani-LrxSl4ZxoRs-unsplash.jpg', 41330, '13635a25-0d5b-4e6a-92ef-6c929444440e', 'active', '2024-08-29 17:03:57'),
('a7cc1c03-611a-4425-a4a8-d92338c08d1f', '0b43eae0-096c-4ae1-8882-3e95ffce0528.jpeg', 'image/jpeg', '1724971783_0b43eae0-096c-4ae1-8882-3e95ffce0528.jpeg', 40362, '1ea4ecd0-6e1d-476a-8a99-7e2c09131222', 'active', '2024-08-29 22:49:43'),
('b4ece664-ba94-4a5a-9020-59e1e6cf3690', 'emile-perron-xrVDYZRGdw4-unsplash (1).jpg', 'image/jpeg', '1724940034_emile-perron-xrVDYZRGdw4-unsplash (1).jpg', 35486, '13635a25-0d5b-4e6a-92ef-6c929444440e', 'active', '2024-08-29 14:00:34'),
('c8be2f85-3934-4fc9-9404-357c1938cdae', 'emile-perron-xrVDYZRGdw4-unsplash (1).jpg', 'image/jpeg', '1724941787_emile-perron-xrVDYZRGdw4-unsplash (1).jpg', 35486, '13635a25-0d5b-4e6a-92ef-6c929444440e', 'active', '2024-08-29 14:29:47'),
('d9792314-33dc-426c-adcf-7c30a6943ad1', 'mohammad-rahmani-LrxSl4ZxoRs-unsplash.jpg', 'image/jpeg', '1724925936_mohammad-rahmani-LrxSl4ZxoRs-unsplash.jpg', 41330, '13635a25-0d5b-4e6a-92ef-6c929444440e', 'active', '2024-08-29 10:05:36'),
('dcbf1f0a-fba7-43b2-9095-89dcf53ef94a', 'mohammad-rahmani-LrxSl4ZxoRs-unsplash.jpg', 'image/jpeg', '1724925564_mohammad-rahmani-LrxSl4ZxoRs-unsplash.jpg', 41330, '13635a25-0d5b-4e6a-92ef-6c929444440e', 'active', '2024-08-29 09:59:24'),
('e36a6897-f19d-44cf-b7d8-5564a0120d56', 'emile-perron-xrVDYZRGdw4-unsplash (1).jpg', 'image/jpeg', '1724930026_emile-perron-xrVDYZRGdw4-unsplash (1).jpg', 35486, '13635a25-0d5b-4e6a-92ef-6c929444440e', 'active', '2024-08-29 11:13:46'),
('e5811134-d807-443d-be1f-23e96279dab3', 'mohammad-rahmani-LrxSl4ZxoRs-unsplash.jpg', 'image/jpeg', '1724962738_mohammad-rahmani-LrxSl4ZxoRs-unsplash.jpg', 41330, '13635a25-0d5b-4e6a-92ef-6c929444440e', 'active', '2024-08-29 20:18:58');

-- --------------------------------------------------------

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
  `created_by_id` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `databoards`
--

INSERT INTO `databoards` (`id`, `country`, `standard_rate`, `standard_light_databoard_url`, `standard_dark_databoard_url`, `advanced_rate`, `advanced_light_databoard_url`, `advanced_dark_databoard_url`, `premium_rate`, `premium_light_databoard_url`, `premium_dark_databoard_url`, `last_updated`, `newly_launched`, `tags`, `status`, `date_created`, `created_by_id`) VALUES
('0e3f843c-4c2b-4742-915d-30efa625403a', 'CI', 44.00, 'https://app.powerbi.com/view?r=eyJrIjoiOWQ5YWMxOGUtZjRjYy00YjM0LTkzNzYtNTMwMTRhNzQ5NTgxIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiZWZhMWQzY2YtZDFlMy00Mjk5LWI3N2UtMzJiMDgxNjZkYWM2IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 54.00, 'https://app.powerbi.com/view?r=eyJrIjoiOWQ5YWMxOGUtZjRjYy00YjM0LTkzNzYtNTMwMTRhNzQ5NTgxIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiZWZhMWQzY2YtZDFlMy00Mjk5LWI3N2UtMzJiMDgxNjZkYWM2IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 64.00, 'https://app.powerbi.com/view?r=eyJrIjoiOWQ5YWMxOGUtZjRjYy00YjM0LTkzNzYtNTMwMTRhNzQ5NTgxIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiZWZhMWQzY2YtZDFlMy00Mjk5LWI3N2UtMzJiMDgxNjZkYWM2IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', '2024-07-11', 'Yes', 'Vessel Traking,     Tenders', 'active', '2024-07-03 15:21:35', 'e8e9e522-de1b-4d39-8ca3-3861f5ccdb08'),
('30294846-e6c9-4dc5-8d50-8e906274c026', 'GH', 44.00, 'https://app.powerbi.com/view?r=eyJrIjoiMzliNmViYjEtMDA5NS00NDM2LTlkYjQtMzRlZDk1YWJjMmNlIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiYzEyZWY4ODQtMTBmMS00MGM3LTg2MjUtNGUwZmQzZTQ5MDExIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 125.00, 'https://app.powerbi.com/view?r=eyJrIjoiMzliNmViYjEtMDA5NS00NDM2LTlkYjQtMzRlZDk1YWJjMmNlIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiYzEyZWY4ODQtMTBmMS00MGM3LTg2MjUtNGUwZmQzZTQ5MDExIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 150.00, 'https://app.powerbi.com/view?r=eyJrIjoiMzliNmViYjEtMDA5NS00NDM2LTlkYjQtMzRlZDk1YWJjMmNlIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiYzEyZWY4ODQtMTBmMS00MGM3LTg2MjUtNGUwZmQzZTQ5MDExIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', '2024-06-21', 'No', 'Imports,      Vessel Tracking,   Tenders', 'active', '2024-06-21 19:04:14', 'e8e9e522-de1b-4d39-8ca3-3861f5ccdb08'),
('5547cb6a-99e7-41c4-84cb-ec2dca956c50', 'TZ', 45.00, 'https://app.powerbi.com/groups/c12c30ce-34c7-45bd-bfbb-c7261d3c67b0/reports/1e7e6b6f-3fb2-4ead-91f7-8df38f6f1891/d3966763a943562fec93?experience=power-bi', 'https://app.powerbi.com/view?r=eyJrIjoiMWQ4MmRkZGYtNjMzYy00MTNmLWJjYmQtY2ViZTU1Y2FhNjIwIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 99.00, 'https://app.powerbi.com/groups/c12c30ce-34c7-45bd-bfbb-c7261d3c67b0/reports/1e7e6b6f-3fb2-4ead-91f7-8df38f6f1891/d3966763a943562fec93?experience=power-bi', 'https://app.powerbi.com/view?r=eyJrIjoiMWQ4MmRkZGYtNjMzYy00MTNmLWJjYmQtY2ViZTU1Y2FhNjIwIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 150.00, 'https://app.powerbi.com/groups/c12c30ce-34c7-45bd-bfbb-c7261d3c67b0/reports/1e7e6b6f-3fb2-4ead-91f7-8df38f6f1891/d3966763a943562fec93?experience=power-bi', 'https://app.powerbi.com/view?r=eyJrIjoiMWQ4MmRkZGYtNjMzYy00MTNmLWJjYmQtY2ViZTU1Y2FhNjIwIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', '2024-06-21', 'Yes', 'Imports,        Vessel Traking,        Tenders', 'active', '2024-07-03 18:00:28', 'e8e9e522-de1b-4d39-8ca3-3861f5ccdb08'),
('67604e0c-e34c-417d-be65-c5a19f7670b9', 'KE', 53.00, 'https://app.powerbi.com/view?r=eyJrIjoiNGI4MzEwMmItNjM3ZC00Nzk5LTljZTctYTE4MGZmYTdlODVkIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiMjJkOTI3YTQtNzBmNi00MDFhLWI2MDItOWExOTllOWY0ZmY0IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 106.00, 'https://app.powerbi.com/view?r=eyJrIjoiNGI4MzEwMmItNjM3ZC00Nzk5LTljZTctYTE4MGZmYTdlODVkIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiMjJkOTI3YTQtNzBmNi00MDFhLWI2MDItOWExOTllOWY0ZmY0IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 179.00, 'https://app.powerbi.com/view?r=eyJrIjoiNGI4MzEwMmItNjM3ZC00Nzk5LTljZTctYTE4MGZmYTdlODVkIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiMjJkOTI3YTQtNzBmNi00MDFhLWI2MDItOWExOTllOWY0ZmY0IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', '2024-06-21', 'Yes', 'Imports,     Vessel Tracking,     Tenders', 'active', '2024-06-21 19:04:14', '13635a25-0d5b-4e6a-92ef-6c929444440e'),
('67ecaac0-3091-4079-8b26-1dc086499662', 'ZM', 400.00, 'https://app.powerbi.com/view?r=eyJrIjoiM2E3YjRkMTgtNTRjOC00ZjRlLWIzOGUtNGFkODc3ZTJmNTJiIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiZDM1N2ZiYjItNzM0ZC00MzhmLTllODgtZGU0YjRkYjMxMDc1IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 96.00, 'https://app.powerbi.com/view?r=eyJrIjoiM2E3YjRkMTgtNTRjOC00ZjRlLWIzOGUtNGFkODc3ZTJmNTJiIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiZDM1N2ZiYjItNzM0ZC00MzhmLTllODgtZGU0YjRkYjMxMDc1IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 121.00, 'https://app.powerbi.com/view?r=eyJrIjoiM2E3YjRkMTgtNTRjOC00ZjRlLWIzOGUtNGFkODc3ZTJmNTJiIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiZDM1N2ZiYjItNzM0ZC00MzhmLTllODgtZGU0YjRkYjMxMDc1IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', '2024-06-21', 'No', 'Imports,        Vessel Tracking,      Tenders', 'active', '2024-06-21 19:04:14', '13635a25-0d5b-4e6a-92ef-6c929444440e'),
('86401695-9a5d-443f-b0d4-c13428cf8a5b', 'MA', 45.00, 'https://app.powerbi.com/view?r=eyJrIjoiZTg0ZTgxYTItNWMzOC00ZTMwLWE2N2YtZjdlNTM5MGUwNDE0IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiNGYyMmY0ZTMtZTBmZi00N2Q5LTlmZDEtN2E2YThlMTBjNjUyIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 99.00, 'https://app.powerbi.com/view?r=eyJrIjoiZTg0ZTgxYTItNWMzOC00ZTMwLWE2N2YtZjdlNTM5MGUwNDE0IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiNGYyMmY0ZTMtZTBmZi00N2Q5LTlmZDEtN2E2YThlMTBjNjUyIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 150.00, 'https://app.powerbi.com/view?r=eyJrIjoiZTg0ZTgxYTItNWMzOC00ZTMwLWE2N2YtZjdlNTM5MGUwNDE0IiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiNGYyMmY0ZTMtZTBmZi00N2Q5LTlmZDEtN2E2YThlMTBjNjUyIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', '2024-06-21', 'Yes', 'Imports,      Vessel Tracking,      Tenders', 'active', '2024-07-02 16:10:47', 'e8e9e522-de1b-4d39-8ca3-3861f5ccdb08'),
('ddd4de41-dd77-4284-aaba-5a4521ca55be', 'NG', 33.00, 'https://app.powerbi.com/view?r=eyJrIjoiMjBmNGQ5NmEtMGI5ZC00ZDRhLWI4MjEtYWI3YzYxZDJmMjhmIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiY2UzOWYzZTAtMzMxMy00NDAxLTk5ZTMtZWU2MTA1NzY3ZWNkIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 44.00, 'https://app.powerbi.com/view?r=eyJrIjoiMjBmNGQ5NmEtMGI5ZC00ZDRhLWI4MjEtYWI3YzYxZDJmMjhmIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiY2UzOWYzZTAtMzMxMy00NDAxLTk5ZTMtZWU2MTA1NzY3ZWNkIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 54.00, 'https://app.powerbi.com/view?r=eyJrIjoiMjBmNGQ5NmEtMGI5ZC00ZDRhLWI4MjEtYWI3YzYxZDJmMjhmIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', 'https://app.powerbi.com/view?r=eyJrIjoiY2UzOWYzZTAtMzMxMy00NDAxLTk5ZTMtZWU2MTA1NzY3ZWNkIiwidCI6IjkyMmQzOTExLTBkZDUtNGEwZi04OTk3LTVmMGI4YjMwM2FiYiJ9', '2024-07-04', 'No', 'Imports,       Tenders,       Vessel Traking', 'active', '2024-07-03 10:59:37', 'e8e9e522-de1b-4d39-8ca3-3861f5ccdb08');

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
  `status` enum('active','pending','approval request','deleted') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `organisations`
--

INSERT INTO `organisations` (`id`, `name`, `email`, `country`, `industry`, `about`, `logo`, `subscription`, `status`) VALUES
('2488fdd6-d01e-44a4-865f-d03fe00f6443', 'test demo', 'demo@afriqom.coms', 'MA', 'Data Analyst', 'hhh', '1725292596_Screenshot 2024-08-27 153714.png', 'Full Access', 'active'),
('295aed25-c82e-4ca8-97aa-d39764afc7e2', 'Demo Limit', 'demo@afriqom.com', 'HU', 'Research', 'Demo is the leading fictitious research lab on the globeshhhhhhhhhhhhhhhhhhhhh hhhhhhhhhhhhhhhhhhhhhhhh hhhhhhhhhhhhhhhhhhhhhhhhhhhh hhhhhhhhhhhhhhhhhhhhhhhhhhhh hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh', '1724962738_mohammad-rahmani-LrxSl4ZxoRs-unsplash.jpg', 'Individual Access', 'active'),
('2af11eed-f5d1-4d7a-b3e3-5eca654ea96f', 'Individual Org', 'test06@afriqom.com', 'GH', 'Data Analyst', 'Individual Org', '1725429360_marcus-loke-xXJ6utyoSw0-unsplash.jpg', 'Individual Access', 'active'),
('63c588f3-e311-4fdb-9baf-bff1b409da67', 'Pagination 3', 'philipsrack5@gmail.com', 'MA', 'Project Manager', '', NULL, 'Individual Access', 'pending'),
('76b7d76c-6557-4f78-9bec-c3cf03cd2052', 'ABC Limited', 'test05@afriqom.com', 'GH', 'Data Analyst', 'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh hhhhhhhhhhhhhhhhhhhhhhhhhhhhh hhhhhhhhhhhhhhhhhhhh hhhhhhhhh hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh hhhhhhhhhhhhh hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh hhhhhhh', '', 'Full Access', 'active'),
('7bb16a10-504e-4913-9cdf-90887c350b63', 'FB', 'p@afriqom.com', 'MA', 'Data Analyst', '', '', 'Individual Access', 'active'),
('8201c5c1-9e8f-418a-96f1-0f9232148917', 'XYZ Limited', 'jdoe@mailinator.com', 'GH', 'Operations Manager', 'We are all about XYZ', '1724971783_0b43eae0-096c-4ae1-8882-3e95ffce0528.jpeg', 'Individual Access', 'active'),
('87fed284-8660-4496-9b4e-ddc7e9c2ed61', 'Jet Stones Ltd', 'test04@afriqom.com', 'GH', 'Project Manager', '', '', 'Full Access', 'approval request'),
('a1198832-6bf4-4d4d-b5aa-199db815d373', 'Moonlite Trade', 'test0311@afriqom.com', 'GH', 'Data Analyst', 'ok', '1724925936_mohammad-rahmani-LrxSl4ZxoRs-unsplash.jpg', 'Full Access', 'active'),
('a7b70d59-7403-45c5-8c13-a7226e8ac617', 'john', 'jpiper@mailinator.com', 'MA', 'Software Engineer', 'hhh', '1725289297_Africa v2.png', 'Individual Access', 'active'),
('b6812fdf-5131-400e-9de5-0b87a297de02', 'Pagination 7', 'philipshedra5@gmail.com', 'MA', 'Data Analyst', '', NULL, 'Individual Access', 'pending'),
('ccce36e3-818f-4209-92f9-e4402f639ab3', 'Pagination 2', 'p2@gmail.com', 'MA', 'Data Analyst', '', NULL, 'Individual Access', 'pending'),
('de551dcd-90f2-458e-9947-9a58b4ca59e5', 'Crunch Consults', 'test031@afriqom.com', 'GH', 'Software Engineer', '', NULL, 'Full Access', 'pending'),
('e068f084-1fa9-491f-9d6b-cd594b8d974b', 'dansco', 'philipshedrack5@gmail.com', 'MA', 'Human Resources Specialist', '', NULL, 'Full Access', 'pending'),
('efd917ef-5c49-4b6d-a0db-87710305df8f', 'Pagination 4', 'phil@gmail.com', 'MA', 'Marketing Coordinator', '', NULL, 'Individual Access', 'pending'),
('f64bbc9a-6e71-4370-a8fc-8ba2f9fe227b', 'Pagination 1', 'p@gmail.com', 'MA', 'Data Analyst', '', NULL, 'Individual Access', 'pending'),
('fd1c03f9-bac6-4fd2-a33f-ed0977b76b25', 'Full Access Limited', 'full@afriqom.com', 'MA', 'Research', 'Full is the leading fictitious research lab on the globe have full access to databoard ok i am just trying to test something from the UAT, and the aim is to see if the UAT wuill habe a text wrap or just continue moving on the screen or thydt from the UAT, and the aim is to see if the UAT wuill habe a text wrap or just continue moving on the screen or thydtfrom the UAT, and the aim is to see if the UAT wuill habe a text wrap or just continue moving on the screen or thydtfrom the UAT, and the aim is to see if the UAT wuill habe a text wrap or just continue moving on the screen or thydtfrom the UAT, and the aim is to see if the UAT wuill habe a text wrap or just continue moving on the screen or thydtfrom the UAT, and the aim is to see if the UAT wuill habe a text wrap or just continue moving on the screen or thydtfrom the UAT, and the aim is to see if the UAT wuill habe a text wrap or just continue moving on the screen or thydtfrom the UAT, and the aim is to see if the UAT wuill habe a text wrap or just continue moving on the screen or thydtfrom the UAT, and the aim is to see if the UAT wuill habe a text wrap or just continue moving on the screen or thydt thanks', '', 'Full Access', 'active');

-- --------------------------------------------------------

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
  `created_by_id` varchar(36) NOT NULL
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
  `status` enum('active','pending','deleted') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'active'
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
  `status` enum('active','pending','approval request','deleted') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `organisation_id`, `databoard_id`, `region_id`, `license`, `rate_paid`, `start_date`, `expiry_date`, `custom_subscription_light_databoard_url`, `custom_subscription_dark_databoard_url`, `package`, `status`) VALUES
('06c36538-e41f-4ca7-ace8-5e3809b2941b', 'a7b70d59-7403-45c5-8c13-a7226e8ac617', '67604e0c-e34c-417d-be65-c5a19f7670b9', NULL, 'Advanced', 105.00, '2024-08-18', '2025-08-18', NULL, NULL, 'Individual Access', 'pending'),
('3ccd2714-ec95-4ffd-9397-153edbb48037', '76b7d76c-6557-4f78-9bec-c3cf03cd2052', NULL, 'c86a9b5f-520b-4b09-ae6d-ca7ed2996548', 'Standard', 1300.00, '2024-08-14', '2024-08-21', NULL, NULL, 'Full Access', 'pending'),
('46c01b3d-511a-41e0-b695-61a858bd9f6a', '87fed284-8660-4496-9b4e-ddc7e9c2ed61', NULL, 'c86a9b5f-520b-4b09-ae6d-ca7ed2996548', 'Premium', 1900.00, '2024-08-07', '2024-08-06', NULL, NULL, 'Full Access', 'active'),
('53e664f4-3e46-4356-ac12-5d0173d87032', '295aed25-c82e-4ca8-97aa-d39764afc7e2', '0e3f843c-4c2b-4742-915d-30efa625403a', NULL, 'Premium', 64.00, '2024-09-09', '2025-09-09', NULL, NULL, 'Individual Access', 'pending'),
('73b7aef4-640d-440b-9172-f263052ddb29', '2af11eed-f5d1-4d7a-b3e3-5eca654ea96f', '67604e0c-e34c-417d-be65-c5a19f7670b9', NULL, 'Premium', 179.00, '2024-09-04', '2025-09-04', NULL, NULL, 'Individual Access', 'active'),
('917f9e23-be41-4436-a48f-69e094785cb2', '7bb16a10-504e-4913-9cdf-90887c350b63', '67604e0c-e34c-417d-be65-c5a19f7670b9', NULL, 'Premium', 179.00, '2024-09-03', '2025-09-03', NULL, NULL, 'Individual Access', 'active'),
('96820a4d-dc9d-4114-9912-f10906ed55e4', 'a1198832-6bf4-4d4d-b5aa-199db815d373', NULL, 'c86a9b5f-520b-4b09-ae6d-ca7ed2996548', 'Premium', 1900.00, '2024-08-15', '2024-08-14', NULL, NULL, 'Full Access', 'approval request'),
('a2daa8ad-6f89-42b5-9835-8f524d1da05f', 'a7b70d59-7403-45c5-8c13-a7226e8ac617', '30294846-e6c9-4dc5-8d50-8e906274c026', NULL, 'Standard', 45.00, '2024-08-18', '2024-08-31', NULL, NULL, 'Individual Access', 'active'),
('a3e176f5-579f-420e-a3f4-b7d1f17c8f9f', '2488fdd6-d01e-44a4-865f-d03fe00f6443', NULL, 'c86a9b5f-520b-4b09-ae6d-ca7ed2996548', 'Advanced', 1800.00, '2024-09-03', '2024-09-25', NULL, NULL, 'Full Access', 'active'),
('a915f306-bfcc-433d-8aa6-5b47b8ac3ef4', '2af11eed-f5d1-4d7a-b3e3-5eca654ea96f', '0e3f843c-4c2b-4742-915d-30efa625403a', NULL, 'Standard', 44.00, '2024-09-04', '2025-09-04', NULL, NULL, 'Individual Access', 'active'),
('b6f5003c-a598-4c13-85e6-97644aad9074', 'de551dcd-90f2-458e-9947-9a58b4ca59e5', NULL, 'c86a9b5f-520b-4b09-ae6d-ca7ed2996548', 'Premium', 1900.00, '2024-08-22', '2024-08-23', NULL, NULL, 'Full Access', 'approval request'),
('d220ffec-6b2b-4044-86e9-c835bdd815ff', 'fd1c03f9-bac6-4fd2-a33f-ed0977b76b25', NULL, 'c86a9b5f-520b-4b09-ae6d-ca7ed2996548', 'Premium', 1900.00, '2024-09-09', '2025-09-09', NULL, NULL, 'Full Access', 'active'),
('e92abf23-7bce-4751-b5e6-89143ba5fdaf', '2af11eed-f5d1-4d7a-b3e3-5eca654ea96f', '30294846-e6c9-4dc5-8d50-8e906274c026', NULL, 'Standard', 44.00, '2024-09-04', '2025-09-04', NULL, NULL, 'Individual Access', 'pending'),
('f7595ad6-3e7b-4012-8147-8f5908647c05', '7bb16a10-504e-4913-9cdf-90887c350b63', '0e3f843c-4c2b-4742-915d-30efa625403a', NULL, 'Premium', 64.00, '2024-09-03', '2025-09-03', NULL, NULL, 'Individual Access', 'pending'),
('fbc56edd-f072-4468-99c7-62b25a9e2a40', '295aed25-c82e-4ca8-97aa-d39764afc7e2', '30294846-e6c9-4dc5-8d50-8e906274c026', NULL, 'Premium', 150.00, '2024-09-09', '2025-09-09', NULL, NULL, 'Individual Access', 'pending'),
('fcbf992e-f819-49f0-8a00-0399800df6a9', '2af11eed-f5d1-4d7a-b3e3-5eca654ea96f', '5547cb6a-99e7-41c4-84cb-ec2dca956c50', NULL, 'Advanced', 99.00, '2024-09-04', '2025-09-04', NULL, NULL, 'Individual Access', 'pending'),
('fde3eb82-b688-4010-ba0d-74912d4209d0', '8201c5c1-9e8f-418a-96f1-0f9232148917', '30294846-e6c9-4dc5-8d50-8e906274c026', NULL, 'Advanced', 125.00, '2024-08-29', '2025-08-29', NULL, NULL, 'Individual Access', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(36) NOT NULL COMMENT 'Unique identifier for each user account (auto incremented)',
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
  `yubico_auth` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT 'The yubico auth string'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `phone_number`, `whatsapp_number`, `access_country_restriction`, `account_type`, `main_contact`, `light_preference`, `organisation_id`, `username`, `password`, `access_portal`, `status`, `user_agent`, `ip_address`, `x_forwarded_for_ip_address`, `last_login_date`, `created_date`, `auth_token`, `yubico_auth`) VALUES
('027d43b6-46cf-47ae-8b31-a55a904f2972', 'Data guy User', 'data@afriqom.com', '233240000003', '233240000003', '', 'Data Administrator', 'Yes', 'Yes', NULL, 'data@afriqom.com', '889c7dca3bf23073f9b31f541b67d9cb', 'backend', 'active', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '196.200.95.85', NULL, '2024-08-29 17:43:39', '2024-06-21 19:35:42', NULL, NULL),
('0ddd96af-f233-44e7-a6e7-b47096990990', 'Henry Doe', 'henrry@doe.com', '02000000223', '02000000223', 'GH', 'User', 'No', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 'henrry@doe.com', 'e10adc3949ba59abbe56e057f20f883e', 'client', 'pending', NULL, NULL, NULL, NULL, '2024-08-29 20:23:36', NULL, NULL),
('13635a25-0d5b-4e6a-92ef-6c929444440e', 'System Admin', 'admin@afriqom.com', '233240000000', '233240000000', '', 'Super Administrator', 'No', 'Yes', NULL, 'admin@afriqom.com', '7ece99e593ff5dd200e2b9233d9ba654', 'backend', 'active', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '102.176.75.170', NULL, '2024-09-12 09:34:19', '2024-05-02 00:16:27', NULL, NULL),
('15ee0ad6-03af-453e-950d-d504909251ec', 'philip shedrack', 'philip.danladie@afriqom.com', '777711111222', '777711111222', 'CI,MA', 'User', 'No', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 'philip.danladie@afriqom.com', '098f6bcd4621d373cade4e832627b4f6', 'client', 'active', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36', '196.127.38.127', NULL, '2024-08-22 05:57:27', '2024-07-24 16:36:06', NULL, NULL),
('1b170ab8-7a03-456b-81d5-69b7e41adca6', 'Pagination 1', 'p@gmail.com', '1111111111', '1111111111', 'Ghana', 'Administrator', 'Yes', 'Yes', 'f64bbc9a-6e71-4370-a8fc-8ba2f9fe227b', 'p@gmail.com', '033bd94b1168d7e4f0d644c3c95e35bf', 'client', 'active', NULL, NULL, NULL, NULL, '2024-09-02 15:25:10', NULL, NULL),
('1ea4ecd0-6e1d-476a-8a99-7e2c09131222', 'Joe One', 'joe1@afriqom.com', '+233200000000', '+233200000000', 'ZA,GH', 'Administrator', 'Yes', 'Yes', '8201c5c1-9e8f-418a-96f1-0f9232148917', 'joe1@afriqom.com', 'e10adc3949ba59abbe56e057f20f883e', 'client', 'active', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '154.160.30.208', NULL, '2024-08-29 22:48:46', '2024-08-14 06:45:03', NULL, NULL),
('23b3e164-6f45-4aed-baa9-a090747de04b', 'Pagination 2', 'p2@gmail.com', '07066309312', '07066309312', 'Ghana', 'Administrator', 'Yes', 'Yes', 'ccce36e3-818f-4209-92f9-e4402f639ab3', 'p2@gmail.com', '098f6bcd4621d373cade4e832627b4f6', 'client', 'active', NULL, NULL, NULL, NULL, '2024-09-02 15:26:35', NULL, NULL),
('2a90f0df-9c66-4927-8d13-1ea19fffa34a', 'Adam Smith', 'full@afriqom.com', '233240000005', '233240000005', 'All Countries', 'Administrator', 'Yes', 'Yes', 'fd1c03f9-bac6-4fd2-a33f-ed0977b76b25', 'full@afriqom.com', 'fbed219a94340275aff3e335ccb6bc29', 'client', 'active', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '102.176.75.170', NULL, '2024-09-12 09:36:11', '2024-06-21 19:35:42', NULL, NULL),
('2d2df15f-6a9e-4445-84a3-2a2674427330', 'dan test', 'ddd@gmail.com', '1414141', '5151515', 'MA', 'User', 'No', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 'ddd@gmail.com', '098f6bcd4621d373cade4e832627b4f6', 'client', 'pending', NULL, NULL, NULL, NULL, '2024-09-03 09:21:57', NULL, NULL),
('2f0671ea-1881-45db-84b9-3b80b77691b3', 'philip1 ddd', 'p@afriqom.com', '05787788888', '05787788888', 'Ghana,MA', 'Administrator', 'Yes', 'Yes', '7bb16a10-504e-4913-9cdf-90887c350b63', 'p@afriqom.com', '033bd94b1168d7e4f0d644c3c95e35bf', 'client', 'active', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '196.117.40.20', NULL, '2024-09-03 11:35:30', '2024-09-02 15:22:41', NULL, NULL),
('30924601-5f68-45b1-b2a9-e9560f534c26', 'test06@gmail.com', 'test06@gmail.com', 'test06@gmail.com', 'test06@gmail.com', 'GH', 'Administrator', 'Yes', 'Yes', '2af11eed-f5d1-4d7a-b3e3-5eca654ea96f', 'test06@gmail.com', 'c35548a4214d7c47ec25158ccb11cd61', 'client', 'active', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', '196.250.103.80', NULL, '2024-07-18 21:38:59', '2024-07-16 07:59:58', NULL, NULL),
('3250a0f5-7d72-4b38-ae9d-76ff8aadad0d', 'Client User', 'user@afriqom.com', '233240000004', '233241000004', 'GH,CD,MA,KE,ML,FR', 'User', 'No', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 'user@afriqom.com', 'c6e06f6073a29fa6ab311e425ac449a6', 'client', 'active', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '102.222.203.38', NULL, '2024-09-10 10:31:18', '2024-06-21 19:35:42', NULL, NULL),
('355a9023-f2c8-4462-a302-baecc2579755', 'dany doso', 'daso@gm.com', 'test', '........è8_', 'MA', 'User', 'No', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 'daso@gm.com', '098f6bcd4621d373cade4e832627b4f6', 'client', 'pending', NULL, NULL, NULL, NULL, '2024-08-22 10:13:41', NULL, NULL),
('3d953d2c-c9b6-48a3-999f-81c50028b28e', 'philip shedrack', 'philip.danladi@afriqom.com', '0877776654', '0877776654', '', 'Data Administrator', 'No', 'Yes', NULL, 'philip.danladi@afriqom.com', '5a105e8b9d40e1329780d62ea2265d8a', 'backend', 'approval request', NULL, NULL, NULL, NULL, '2024-07-24 14:21:09', NULL, NULL),
('5dbffba3-0a42-4bdc-970a-0b01d980cd30', 'test04@afriqom.com', 'test04@afriqom.com', 'test04@afriqom.com', 'test04@afriqom.com', 'GH', 'Administrator', 'Yes', 'Yes', '87fed284-8660-4496-9b4e-ddc7e9c2ed61', 'test04@afriqom.com', '3c8948dbc922050170782e04a5c3b46a', 'client', 'active', NULL, NULL, NULL, NULL, '2024-07-15 23:47:44', NULL, NULL),
('627c57bc-27a3-4e7a-84ff-4e6dd86f70c7', 'Shedrack Danladi Philip', 'phil@gmail.com', '0701110931', '0701110931', 'GH', 'Administrator', 'Yes', 'Yes', 'efd917ef-5c49-4b6d-a0db-87710305df8f', 'phil@gmail.com', '098f6bcd4621d373cade4e832627b4f6', 'client', 'active', NULL, NULL, NULL, NULL, '2024-09-02 15:28:33', NULL, NULL),
('68b25a69-3347-4f35-97b4-6e627e68e44a', 'John Piper', 'jpiper@mailinator.com', '233240000011', '233240000011', 'GH', 'Administrator', 'Yes', 'Yes', 'a7b70d59-7403-45c5-8c13-a7226e8ac617', 'jpiper@mailinator.com', 'e10adc3949ba59abbe56e057f20f883e', 'client', 'active', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36', '154.160.30.60', NULL, '2024-08-18 13:19:36', '2024-08-18 09:27:26', NULL, NULL),
('79d7312b-3727-4024-927b-5e71cf0afbb4', 'Data guyddd test', 'd@gmail.com', '1234567722', '1111111111111', 'MA', 'User', 'No', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 'd@gmail.com', '098f6bcd4621d373cade4e832627b4f6', 'client', 'pending', NULL, NULL, NULL, NULL, '2024-09-03 09:16:06', NULL, NULL),
('800fe833-ed50-477a-aa26-5e01ddbfc600', 'Don Flamingo', 'donflamingo@gmail.com', '777777778', '777777778', 'KE,MA', 'Administrator', 'No', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 'donflamingo@gmail.com', '098f6bcd4621d373cade4e832627b4f6', 'client', 'active', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '41.250.156.63', NULL, '2024-09-03 14:18:23', '2024-07-13 16:33:02', NULL, NULL),
('899339a4-61a0-4c74-b1d1-15f1319d3ea0', 'Sam Son', 'sam@son.com', '233240000123', '233240000123', 'All Countries', 'User', 'No', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 'sam@son.com', 'e10adc3949ba59abbe56e057f20f883e', 'client', 'active', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '102.221.28.6', NULL, '2024-09-04 16:33:19', '2024-08-28 16:16:36', NULL, NULL),
('8ec405ee-fa1c-459e-b795-ca15f64af79d', 'Asmae Asmae', 'a@gmail.com', '0706630932', '05787788888', '', 'Super Administrator', 'No', 'Yes', NULL, 'a@gmail.com', '098f6bcd4621d373cade4e832627b4f6', 'backend', 'active', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '196.217.79.215', NULL, '2024-09-09 11:29:58', '2024-09-09 11:28:58', NULL, NULL),
('94789646-deb0-4950-83e1-35bd579b6f05', 'key bonzali', 'test031@afriqom.com', '0201914916', '0201914916', 'GH', 'Administrator', 'Yes', 'Yes', 'de551dcd-90f2-458e-9947-9a58b4ca59e5', 'test031@afriqom.com', 'f74243da49688c3b91e0cfa298e70ca4', 'client', 'active', NULL, NULL, NULL, NULL, '2024-07-16 18:51:30', NULL, NULL),
('94d150c8-6347-403e-9076-6eff0a7e334a', 'Joe Two', 'joe2@afriqom.com', '02000000111', '02000000111', 'GH', 'User', 'No', 'Yes', '8201c5c1-9e8f-418a-96f1-0f9232148917', 'joe2@afriqom.com', 'e10adc3949ba59abbe56e057f20f883e', 'client', 'pending', NULL, NULL, NULL, NULL, '2024-08-29 22:57:17', NULL, NULL),
('9d48a5d0-b338-4718-8adb-cae23f9c624b', 'Shedrack Danladi Philip', 'philipsrack5@gmail.com', '0706631131', '0706631131', 'GH', 'Administrator', 'Yes', 'Yes', '63c588f3-e311-4fdb-9baf-bff1b409da67', 'philipsrack5@gmail.com', '098f6bcd4621d373cade4e832627b4f6', 'client', 'active', NULL, NULL, NULL, NULL, '2024-09-02 15:27:42', NULL, NULL),
('a062d0f5-f166-4ef4-a352-475538a5e03b', 'philip shedrack', 'philip.danladi@afriqomé.com', '8777771', '122333444', 'TZ', 'User', 'No', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 'philip.danladi@afriqomé.com', '098f6bcd4621d373cade4e832627b4f6', 'client', 'pending', NULL, NULL, NULL, NULL, '2024-07-24 15:58:41', NULL, NULL),
('a1a68e62-5018-4956-9924-01f230ee0e03', 'test05@gmail.com testing', 'test05@gmail.com', '0201994916', '0201994916', 'GH,MA', 'Administrator', 'Yes', 'Yes', '76b7d76c-6557-4f78-9bec-c3cf03cd2052', 'test05@gmail.com', '098f6bcd4621d373cade4e832627b4f6', 'client', 'active', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', '196.117.47.10', NULL, '2024-07-22 13:58:33', '2024-07-15 23:54:53', NULL, NULL),
('a3c76ecd-1ed3-4ee7-a479-92a3ca11bd66', 'Sam Son', 'sam@sonx.com', '233240000124', '233240000124', 'All Countries', 'User', 'No', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 'sam@sonx.com', 'e10adc3949ba59abbe56e057f20f883e', 'client', 'pending', NULL, NULL, NULL, NULL, '2024-08-28 16:19:34', NULL, NULL),
('a5f7543f-e3cd-426a-955f-4a89de4abbfa', 'Sales User', 'sales@afriqom.com', '233240000002', '233240000002', '', 'Sales Administrator', 'Yes', 'Yes', NULL, 'sales@afriqom.com', '8abb97ea8fd24af278a5171a33efdba9', 'backend', 'active', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '196.117.40.20', NULL, '2024-09-09 14:44:30', '2024-06-21 19:35:42', NULL, NULL),
('a66b2fff-0035-4d87-b647-adbff1d83836', 'key bonzali', 'jnn@gmail.com', '0201994910', '0201994910', 'CD', 'User', 'No', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 'jnn@gmail.com', '010a85b5425041d294cb7d6a730e15ee', 'client', 'pending', NULL, NULL, NULL, NULL, '2024-07-23 21:54:21', NULL, NULL),
('a6a54345-00de-4b6e-9f64-cc104699378f', 'key bonzali', 'josh@gmail.com', '233241009004', '233241009004', 'AL', 'User', 'No', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 'josh@gmail.com', 'e058451bfbd1eb85e6b95b83accb7c3c', 'client', 'pending', NULL, NULL, NULL, NULL, '2024-08-29 12:11:37', NULL, NULL),
('c2105c13-1c47-47fc-be36-039377bde788', 'lead oneeee', 'lead@gmail.com', '12345677', '12345677', '', 'Sales Administrator', 'No', 'Yes', NULL, 'lead@gmail.com', 'e358efa489f58062f10dd7316b65649e', 'backend', 'active', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36', '196.127.38.127', NULL, '2024-08-28 06:41:29', '2024-08-28 06:34:54', NULL, NULL),
('c4f1c8e0-7fb6-44bb-a45d-0a8350519573', 'dan test', 't@gmail.com', '25252525225', '25252525', 'MA', 'User', 'No', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 't@gmail.com', '098f6bcd4621d373cade4e832627b4f6', 'client', 'pending', NULL, NULL, NULL, NULL, '2024-09-03 09:19:59', NULL, NULL),
('ce932e5f-8f1f-410e-bf8a-b41088b517f5', 'dan test', 'DD@GMAIL.COM', '1212122212', '121212121212', 'MA', 'User', 'No', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 'DD@GMAIL.COM', '033bd94b1168d7e4f0d644c3c95e35bf', 'client', 'pending', NULL, NULL, NULL, NULL, '2024-09-03 09:17:27', NULL, NULL),
('cee7a00e-182f-4a9d-8401-4b8bb7334243', 'Shedrack Danladi Philip', 'philipshedra5@gmail.com', '0706630988', '0706630988', 'Ghana', 'Administrator', 'Yes', 'Yes', 'b6812fdf-5131-400e-9de5-0b87a297de02', 'philipshedra5@gmail.com', '098f6bcd4621d373cade4e832627b4f6', 'client', 'active', NULL, NULL, NULL, NULL, '2024-09-02 15:30:18', NULL, NULL),
('d13e8d2d-f08e-48a6-b73c-78b5bdb53ac1', 'Henry Doe', 'henry@doe.com', '02000000123', '02000000123', 'GH', 'User', 'No', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 'henry@doe.com', 'e10adc3949ba59abbe56e057f20f883e', 'client', 'pending', NULL, NULL, NULL, NULL, '2024-08-29 20:22:27', NULL, NULL),
('d28f856d-9d9f-4faa-8e55-0961d6276462', 'test0311@afriqom.com', 'test0311@afriqom.com', '0201904916', '0201904916', 'GH', 'Administrator', 'Yes', 'Yes', 'a1198832-6bf4-4d4d-b5aa-199db815d373', 'test0311@afriqom.com', '2af04e41e3f4307ee9d1de813f0284fc', 'client', 'active', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', '196.250.103.80', NULL, '2024-07-16 18:54:29', '2024-07-16 18:54:21', NULL, NULL),
('d72b242c-c901-4641-ac74-6afd29f28ca1', 'Individual Admin', 'individual@afriqom.com', '0901994910', '0201994989', 'All Countries,CD', 'Administrator', 'No', 'Yes', '2af11eed-f5d1-4d7a-b3e3-5eca654ea96f', 'individual@afriqom.com', '9c72f3a68cac2af21b1a4d6a45e0c7b9', 'client', 'active', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '102.208.123.80', NULL, '2024-09-04 06:21:35', '2024-09-04 05:59:33', NULL, NULL),
('e021c523-4ea2-402b-8fb4-86c736bfcd53', 'Shedrack Danladi Philip', 'philipshedrack5@gmail.com', '0706630931', '0706630931', 'Ghana', 'Administrator', 'Yes', 'Yes', 'e068f084-1fa9-491f-9d6b-cd594b8d974b', 'philipshedrack5@gmail.com', '098f6bcd4621d373cade4e832627b4f6', 'client', 'active', NULL, NULL, NULL, NULL, '2024-08-20 07:45:23', NULL, NULL),
('e8e9e522-de1b-4d39-8ca3-3861f5ccdb08', 'John Doey', 'demo@afriqom.com', '66366363636', '23324000', 'KE,GH,MA,FR,CD', 'Administrator', 'Yes', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 'demo@afriqom.com', '14f4b2fc501ab14a296b1e8f621dffd6', 'client', 'active', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '154.160.30.127', NULL, '2024-09-09 20:33:19', '2024-06-21 19:35:42', NULL, NULL),
('eb08b912-e777-41c0-a9d0-8acd72224635', 'Shedrack Danladi', 'demo@afriqom.coms', '0706630931ssss', '0706630931ssss', 'MA', 'Administrator', 'Yes', 'Yes', '2488fdd6-d01e-44a4-865f-d03fe00f6443', 'demo@afriqom.coms', '098f6bcd4621d373cade4e832627b4f6', 'client', 'active', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '196.117.40.20', NULL, '2024-09-03 14:22:45', '2024-08-20 08:23:23', NULL, NULL),
('f5022768-c6ec-47a0-8fc1-00096886e838', 'Thaura Bennasser', 'thaura.bennasser@afriqom.com', '0203', '0303', 'MA', 'User', 'No', 'Yes', '2488fdd6-d01e-44a4-865f-d03fe00f6443', 'thaura.bennasser@afriqom.com', '16d95cb4272d40d98e28d165a1c159a4', 'client', 'approval request', NULL, NULL, NULL, NULL, '2024-09-09 14:51:26', NULL, NULL),
('f60937fe-05f3-479d-ba74-4e5568b21914', 'Mister Lovermoove', 'user02@gmail.com', '657377774', '657377774', 'KE,AO,MA', 'User', 'No', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 'user02@gmail.com', '098f6bcd4621d373cade4e832627b4f6', 'client', 'approval request', NULL, NULL, NULL, NULL, '2024-07-15 15:26:22', NULL, NULL),
('fbe96bcf-23de-434f-906a-ad62069437cb', 'key bonzali', 'ok@gmail.com', '0201984910', '0201994916', 'AS', 'User', 'No', 'Yes', '295aed25-c82e-4ca8-97aa-d39764afc7e2', 'ok@gmail.com', '35f4bd18346f9321d3c6041a6f7a3d04', 'client', 'pending', NULL, NULL, NULL, NULL, '2024-08-29 12:15:50', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_databoards`
--

CREATE TABLE `user_databoards` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `databoard_id` varchar(36) NOT NULL,
  `status` enum('active','pending','deleted') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_databoards`
--

INSERT INTO `user_databoards` (`id`, `user_id`, `databoard_id`, `status`) VALUES
('6066a43c-ed92-4881-8241-efea9994be8a', 'f5022768-c6ec-47a0-8fc1-00096886e838', '0e3f843c-4c2b-4742-915d-30efa625403a', 'active');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_expired_subscriptions`
-- (See below for the actual view)
--
CREATE TABLE `vw_expired_subscriptions` (
`custom_subscription_dark_databoard_url` varchar(255)
,`custom_subscription_light_databoard_url` varchar(255)
,`databoard_id` varchar(36)
,`expiry_date` date
,`id` varchar(36)
,`license` enum('Standard','Advanced','Premium','Custom')
,`organisation_id` varchar(36)
,`package` enum('Individual Access','Full Access')
,`rate_paid` decimal(10,2)
,`region_id` varchar(36)
,`start_date` date
,`status` enum('active','pending','approval request','deleted')
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_region_databoards`
-- (See below for the actual view)
--
CREATE TABLE `vw_region_databoards` (
`country` varchar(255)
,`databoard_id` varchar(36)
,`id` varchar(36)
,`region_id` varchar(36)
,`region_name` varchar(255)
,`status` enum('active','pending','deleted')
,`tags` text
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_subscriptions`
-- (See below for the actual view)
--
CREATE TABLE `vw_subscriptions` (
`country` varchar(255)
,`custom_subscription_dark_databoard_url` varchar(255)
,`custom_subscription_light_databoard_url` varchar(255)
,`databoard_id` varchar(36)
,`expiry_date` date
,`id` varchar(36)
,`license` enum('Standard','Advanced','Premium','Custom')
,`organisation_id` varchar(36)
,`organisation_name` varchar(255)
,`package` enum('Individual Access','Full Access')
,`rate_paid` decimal(10,2)
,`region_id` varchar(36)
,`start_date` date
,`status` enum('active','pending','approval request','deleted')
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_user_databoards`
-- (See below for the actual view)
--
CREATE TABLE `vw_user_databoards` (
`advanced_dark_databoard_url` varchar(255)
,`advanced_light_databoard_url` varchar(255)
,`advanced_rate` decimal(10,2)
,`country` varchar(255)
,`created_by_id` varchar(36)
,`databoard_id` varchar(36)
,`date_created` datetime
,`id` varchar(36)
,`last_updated` date
,`newly_launched` enum('Yes','No')
,`premium_dark_databoard_url` varchar(255)
,`premium_light_databoard_url` varchar(255)
,`premium_rate` decimal(10,2)
,`standard_dark_databoard_url` varchar(255)
,`standard_light_databoard_url` varchar(255)
,`standard_rate` decimal(10,2)
,`status` enum('active','pending','deleted')
,`tags` text
,`user_id` varchar(36)
);

-- --------------------------------------------------------

--
-- Structure for view `vw_expired_subscriptions`
--
DROP TABLE IF EXISTS `vw_expired_subscriptions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_expired_subscriptions`  AS SELECT `subscriptions`.`id` AS `id`, `subscriptions`.`organisation_id` AS `organisation_id`, `subscriptions`.`databoard_id` AS `databoard_id`, `subscriptions`.`region_id` AS `region_id`, `subscriptions`.`license` AS `license`, `subscriptions`.`rate_paid` AS `rate_paid`, `subscriptions`.`start_date` AS `start_date`, `subscriptions`.`expiry_date` AS `expiry_date`, `subscriptions`.`custom_subscription_light_databoard_url` AS `custom_subscription_light_databoard_url`, `subscriptions`.`custom_subscription_dark_databoard_url` AS `custom_subscription_dark_databoard_url`, `subscriptions`.`package` AS `package`, `subscriptions`.`status` AS `status` FROM `subscriptions` WHERE ((`subscriptions`.`expiry_date` < now()) AND (`subscriptions`.`status` = 'active')) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_region_databoards`
--
DROP TABLE IF EXISTS `vw_region_databoards`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_region_databoards`  AS SELECT `a`.`id` AS `id`, `a`.`region_id` AS `region_id`, `b`.`name` AS `region_name`, `a`.`databoard_id` AS `databoard_id`, `c`.`country` AS `country`, `c`.`tags` AS `tags`, `c`.`status` AS `status` FROM ((`region_databoards` `a` join `regions` `b`) join `databoards` `c`) WHERE ((`a`.`region_id` = `b`.`id`) AND (`c`.`id` = `a`.`databoard_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_subscriptions`
--
DROP TABLE IF EXISTS `vw_subscriptions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_subscriptions`  AS SELECT `a`.`id` AS `id`, `a`.`organisation_id` AS `organisation_id`, `b`.`name` AS `organisation_name`, `a`.`databoard_id` AS `databoard_id`, `c`.`country` AS `country`, `a`.`region_id` AS `region_id`, `a`.`license` AS `license`, `a`.`rate_paid` AS `rate_paid`, `a`.`start_date` AS `start_date`, `a`.`expiry_date` AS `expiry_date`, `a`.`custom_subscription_light_databoard_url` AS `custom_subscription_light_databoard_url`, `a`.`custom_subscription_dark_databoard_url` AS `custom_subscription_dark_databoard_url`, `a`.`package` AS `package`, `a`.`status` AS `status` FROM ((`subscriptions` `a` join `organisations` `b` on((`a`.`organisation_id` = `b`.`id`))) left join `databoards` `c` on((`a`.`databoard_id` = `c`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_user_databoards`
--
DROP TABLE IF EXISTS `vw_user_databoards`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_user_databoards`  AS SELECT `a`.`id` AS `id`, `a`.`databoard_id` AS `databoard_id`, `a`.`user_id` AS `user_id`, `b`.`country` AS `country`, `b`.`standard_rate` AS `standard_rate`, `b`.`standard_light_databoard_url` AS `standard_light_databoard_url`, `b`.`standard_dark_databoard_url` AS `standard_dark_databoard_url`, `b`.`advanced_rate` AS `advanced_rate`, `b`.`advanced_light_databoard_url` AS `advanced_light_databoard_url`, `b`.`advanced_dark_databoard_url` AS `advanced_dark_databoard_url`, `b`.`premium_rate` AS `premium_rate`, `b`.`premium_light_databoard_url` AS `premium_light_databoard_url`, `b`.`premium_dark_databoard_url` AS `premium_dark_databoard_url`, `b`.`last_updated` AS `last_updated`, `b`.`newly_launched` AS `newly_launched`, `b`.`tags` AS `tags`, `b`.`status` AS `status`, `b`.`date_created` AS `date_created`, `b`.`created_by_id` AS `created_by_id` FROM ((`user_databoards` `a` join `databoards` `b` on((`a`.`databoard_id` = `b`.`id`))) join `users` `c` on((`a`.`user_id` = `c`.`id`))) WHERE ((`b`.`status` = 'active') AND `a`.`databoard_id` in (select `d`.`databoard_id` from `subscriptions` `d` where ((`a`.`databoard_id` = `d`.`databoard_id`) AND (`d`.`status` in ('active','pending')) AND (`d`.`expiry_date` >= now())))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blobs`
--
ALTER TABLE `blobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `databoards`
--
ALTER TABLE `databoards`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `country` (`country`),
  ADD KEY `status` (`status`),
  ADD KEY `created_by_id` (`created_by_id`);

--
-- Indexes for table `organisations`
--
ALTER TABLE `organisations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `regions`
--
ALTER TABLE `regions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`),
  ADD KEY `created_by_id` (`created_by_id`);

--
-- Indexes for table `region_databoards`
--
ALTER TABLE `region_databoards`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_region_databoard` (`region_id`,`databoard_id`) USING BTREE,
  ADD KEY `status` (`status`),
  ADD KEY `databoard_id` (`databoard_id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `organisation_id_2` (`organisation_id`,`databoard_id`,`region_id`),
  ADD KEY `organisation_id` (`organisation_id`),
  ADD KEY `databoard_id` (`databoard_id`),
  ADD KEY `status` (`status`),
  ADD KEY `region_id` (`region_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone_number` (`phone_number`),
  ADD KEY `status` (`status`),
  ADD KEY `organisation_id` (`organisation_id`);

--
-- Indexes for table `user_databoards`
--
ALTER TABLE `user_databoards`
  ADD PRIMARY KEY (`id`),
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

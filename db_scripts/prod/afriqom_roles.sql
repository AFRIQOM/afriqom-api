-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql-db
-- Generation Time: Sep 14, 2024 at 04:22 PM
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
-- Database: `afriqom_roles`
--

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Unique identifier for each permission',
  `role_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The role identifier for the permission',
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The model name',
  `permissions` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Allowed permissions',
  `status` enum('active','inactive','deleted') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'active' COMMENT 'Different states of a permission (default is active)',
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The date this entry was made (auto generated)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `role_id`, `model`, `permissions`, `status`, `created_date`) VALUES
('03bfda22-2a3f-4195-b6ff-863370513bb1', '33743732-4151-47a9-84c5-3344dd05778e', 'api.roles.permissions', 'VSDE', 'active', '2024-05-02 00:26:01'),
('12d94da7-d90c-4fa5-bdbb-720a05c6ac4d', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.ext.signup.Accounts', 'VSDE', 'active', '2024-09-14 15:41:56'),
('14538de9-8ae0-441c-8510-235e007b03ce', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.primary.full_subscriptions', 'VSDE', 'active', '2024-09-14 15:41:55'),
('180516a8-3e36-4105-8553-2c271e7b9c72', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.users.user_roles_lookup', 'VSDE', 'active', '2024-09-14 15:41:56'),
('1a3e4b61-4a9d-4c83-b3c5-432b1a631cdf', '33743732-4151-47a9-84c5-3344dd05778e', 'api.ext.push.AdvancedEmail', 'VSDE', 'active', '2024-05-02 00:01:42'),
('1adf6bda-9994-41fb-a9e3-2a05a37145e8', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.primary.region_databoards', 'VSDE', 'active', '2024-09-14 15:41:56'),
('1b2abad6-84bc-4063-9b04-b37b8d2d6a70', '33743732-4151-47a9-84c5-3344dd05778e', 'api.ext.generate.Hash', 'VSDE', 'active', '2024-05-02 00:01:42'),
('1be02025-2b2d-4de0-af09-c39e71a49078', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.primary.vw_region_databoards', 'VSDE', 'active', '2024-09-14 15:41:56'),
('1d6e2a17-9464-4e3b-b644-74c61ecc2afc', '33743732-4151-47a9-84c5-3344dd05778e', 'api.ext.generate.Pin', 'VSDE', 'active', '2024-05-02 00:01:42'),
('22d7c1c9-9da9-485d-906c-3cf1d0c1749f', '33743732-4151-47a9-84c5-3344dd05778e', 'api.roles.user_roles_lookup', 'VSDE', 'active', '2024-05-02 00:26:01'),
('24697845-1ed8-4a3b-b3cb-5ef2f4f1fe5a', '33743732-4151-47a9-84c5-3344dd05778e', 'api.users.user_roles_lookup', 'VSDE', 'active', '2024-05-02 00:01:42'),
('338b55ba-e7d1-4981-a187-1b7ca642c26e', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.ext.push.AdvancedEmail', 'VSDE', 'active', '2024-09-14 15:41:56'),
('3481dd46-3b85-4556-b157-8635a756e1d9', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.primary.organisations', 'VSDE', 'active', '2024-09-14 15:41:56'),
('3c559f51-77e0-4945-9d79-d73882e53b98', '33743732-4151-47a9-84c5-3344dd05778e', 'api.roles.preferences', 'VSDE', 'active', '2024-05-02 00:26:01'),
('40c68a57-3e9a-4fbb-9e28-1447074739dc', '33743732-4151-47a9-84c5-3344dd05778e', 'api.users.permissions', 'VSDE', 'active', '2024-05-02 00:01:42'),
('41d71f2a-a261-4d0f-b31b-cb35f1fa90bc', '33743732-4151-47a9-84c5-3344dd05778e', 'api.users.roles', 'VSDE', 'active', '2024-05-02 00:01:42'),
('4e218b5c-088d-47a0-886b-0f33c3345104', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.primary.vw_user_subscriptions', 'VSDE', 'active', '2024-09-14 15:41:56'),
('585b36f1-380a-4df3-beac-ef36d0e06b6d', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.primary.users', 'VSDE', 'active', '2024-09-14 15:41:56'),
('5c701006-4655-47c3-99f8-38f76a2cfa75', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.ext.create.Subscriptions', 'VSDE', 'active', '2024-09-14 15:41:56'),
('5eb49c9a-1129-41c6-a1be-e88495ddebb8', '33743732-4151-47a9-84c5-3344dd05778e', 'api.primary.blobs', 'VSDE', 'active', '2024-05-02 00:01:42'),
('63438d3f-82f0-40cd-88b3-6c0c43827e31', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.primary.databoards', 'VSDE', 'active', '2024-09-14 15:41:55'),
('639e3fad-074a-44a5-ac7a-cdfd48701259', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.primary.user_databoards', 'VSDE', 'active', '2024-09-14 15:41:56'),
('699a0661-1a03-4798-81cb-7f350b59d2cf', '33743732-4151-47a9-84c5-3344dd05778e', 'api.roles.vw_permissions', 'VSDE', 'active', '2024-05-02 00:26:01'),
('6d74d2b5-621c-4629-9c9a-5fbd56dfccc8', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.ext.cancel.Subscription', 'VSDE', 'active', '2024-09-14 15:41:56'),
('76cb6542-1485-454c-a6d9-61a37508108f', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.primary.vw_expired_subscriptions', 'VSDE', 'active', '2024-09-14 15:41:56'),
('7712d29c-f409-4f7e-ba49-a19d1b0dec9c', '33743732-4151-47a9-84c5-3344dd05778e', 'api.primary.users', 'VSDE', 'active', '2024-05-02 00:01:42'),
('7e597fe0-bef4-4ec4-86de-c6bef0d7accf', '33743732-4151-47a9-84c5-3344dd05778e', 'api.users.preferences', 'VSDE', 'active', '2024-05-02 00:01:42'),
('80bfec73-6856-4e7b-9d3c-973a641bbefb', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.ext.update.Users', 'VSDE', 'active', '2024-09-14 15:41:56'),
('8f1acddc-a9ff-4796-a167-b44cf5166208', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.primary.vw_user_databoards', 'VSDE', 'active', '2024-09-14 15:41:56'),
('91128427-f46e-47fb-839f-9d2d14df0b0d', '33743732-4151-47a9-84c5-3344dd05778e', 'api.primary.subscriptions', 'VSDE', 'active', '2024-05-02 00:01:42'),
('a386f942-671b-463c-911e-dceb714a6cd0', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.ext.push.SMS', 'VSDE', 'active', '2024-09-14 15:41:56'),
('a76b1856-9b94-4325-a9f4-cf790b231633', '33743732-4151-47a9-84c5-3344dd05778e', 'api.primary.user_subscriptions', 'VSDE', 'active', '2024-05-02 00:01:42'),
('a8471a39-0eba-4983-ad87-a4c55a73913d', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.primary.subscriptions', 'VSDE', 'active', '2024-09-14 15:41:56'),
('b09c5fba-4e97-4bd2-b16a-35e35e3f0d06', '33743732-4151-47a9-84c5-3344dd05778e', 'api.primary.databoards', 'VSDE', 'active', '2024-05-02 00:01:42'),
('b3dcc0a9-34d4-47fd-80d7-dd4f74e57365', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.ext.cancel.License', 'VSDE', 'active', '2024-09-14 15:41:56'),
('bbbad920-668f-4e89-b71f-abce2ae1bba7', '33743732-4151-47a9-84c5-3344dd05778e', 'api.ext.push.Email', 'VSDE', 'active', '2024-05-02 00:01:42'),
('c19eef08-9d1f-49d6-b708-d18c773f5c8e', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.users.roles', 'VSDE', 'active', '2024-09-14 15:41:56'),
('c3394691-d16b-4e97-a14c-ae3fbc70186b', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.primary.sessions', 'VSDE', 'active', '2024-09-14 15:41:56'),
('c7d0f604-ef47-4515-89dc-069d25e8827f', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.primary.user_subscriptions', 'VSDE', 'active', '2024-09-14 15:41:56'),
('c8fe9d1b-4875-4cc2-8779-9774f7b57238', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.users.vw_permissions', 'VSDE', 'active', '2024-09-14 15:41:56'),
('cadf5f9c-65ab-4c51-b8f3-98294597634a', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.ext.generate.Hash', 'VSDE', 'active', '2024-09-14 15:41:56'),
('caf4e3d9-a460-4d6f-a2b9-e2b739012cd0', '33743732-4151-47a9-84c5-3344dd05778e', 'api.roles.roles', 'VSDE', 'active', '2024-05-02 00:26:01'),
('cb9642f4-4559-4dfc-b78a-e1fb1eabb88e', '33743732-4151-47a9-84c5-3344dd05778e', 'api.primary.sessions', 'VSDE', 'active', '2024-05-02 00:01:42'),
('d061df00-8e0c-4d22-8428-d2518695769b', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.ext.generate.Pin', 'VSDE', 'active', '2024-09-14 15:41:56'),
('d2c017e2-ac3c-43d5-9598-4b3cf5f198bd', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.primary.vw_subscriptions', 'VSDE', 'active', '2024-09-14 15:41:56'),
('e7f2deaf-dc89-4065-86f0-6b263f995ea2', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.ext.push.Email', 'VSDE', 'active', '2024-09-14 15:41:56'),
('e94a6190-6ba6-4577-9fb2-266d897c9245', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.users.permissions', 'VSDE', 'active', '2024-09-14 15:41:56'),
('ec3f5e2b-c4df-4e67-9117-2c44ee18fb33', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.primary.regions', 'VSDE', 'active', '2024-09-14 15:41:56'),
('f00a91d0-13d8-4e1a-8a17-6ce2472a2fdd', '33743732-4151-47a9-84c5-3344dd05778e', 'api.users.vw_permissions', 'VSDE', 'active', '2024-05-02 00:01:42'),
('f1bee3a6-2ddd-4900-93cb-3f8b5904be9f', '33743732-4151-47a9-84c5-3344dd05778e', 'api.ext.push.SMS', 'VSDE', 'active', '2024-05-02 00:01:42'),
('f3b68e20-75ca-4fd5-9dc4-8c1c3f0feccf', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.users.preferences', 'VSDE', 'active', '2024-09-14 15:41:56'),
('f7b5b862-584d-47a9-a242-b915590d7eac', '33743732-4151-47a9-84c5-3344dd05778e', 'api.primary.organisations', 'VSDE', 'active', '2024-05-02 00:01:42'),
('f8d21e71-8b41-48e7-8260-745802711085', '46ac4095-e81f-416f-ae3f-a10168e77f9c', 'api.primary.blobs', 'VSDE', 'active', '2024-09-14 15:41:55');

-- --------------------------------------------------------

--
-- Table structure for table `preferences`
--

CREATE TABLE `preferences` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Unique identifier for each preference',
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The identifier for the user',
  `identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Unique name for each preference',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The content for a given preference',
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The date this entry was made (auto generated)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` varchar(36) COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Unique identifier for each role',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The name of the role',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'A description of the role',
  `status` enum('active','inactive','deleted') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'active' COMMENT 'Different states of a user role (default is active)',
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The date this entry was made (auto generated)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `status`, `created_date`) VALUES
('33743732-4151-47a9-84c5-3344dd05778e', 'System Administrator', 'This is the System Administrator role', 'active', '2024-05-01 23:59:53'),
('46ac4095-e81f-416f-ae3f-a10168e77f9c', 'Administrator', 'This is the Administrator role', 'active', '2024-09-14 15:41:55');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles_lookup`
--

CREATE TABLE `user_roles_lookup` (
  `id` varchar(36) COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` varchar(36) COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The identifier for the user',
  `role_id` varchar(36) COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The identifier for the user role',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_roles_lookup`
--

INSERT INTO `user_roles_lookup` (`id`, `user_id`, `role_id`) VALUES
('425503cc-3bca-42ed-8550-17cdda5ea43b', '13635a25-0d5b-4e6a-92ef-6c929444440e', '33743732-4151-47a9-84c5-3344dd05778e');

-- --------------------------------------------------------

CREATE VIEW `vw_permissions`  AS SELECT `a`.`id` AS `id`, `a`.`role_id` AS `role_id`, `b`.`name` AS `name`, `a`.`model` AS `model`, `a`.`permissions` AS `permissions`, `a`.`status` AS `status`, `a`.`created_date` AS `created_date` FROM (`permissions` `a` join `roles` `b` on((`a`.`role_id` = `b`.`id`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD UNIQUE KEY `role_model` (`role_id`,`model`) COMMENT 'The unique indentifier for each role model pair',
  ADD KEY `status` (`status`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `preferences`
--
ALTER TABLE `preferences`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `identifier` (`identifier`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `user_roles_lookup`
--
ALTER TABLE `user_roles_lookup`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `role_id` (`role_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 05, 2026 at 11:05 AM
-- Server version: 8.0.30
-- PHP Version: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `world_vision_enterprice`
--

-- --------------------------------------------------------

--
-- Table structure for table `acc_account_balances`
--

CREATE TABLE `acc_account_balances` (
  `id` bigint UNSIGNED NOT NULL,
  `account_head_id` bigint UNSIGNED NOT NULL,
  `debit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `credit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `as_of_date` date DEFAULT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `acc_account_balances`
--

INSERT INTO `acc_account_balances` (`id`, `account_head_id`, `debit`, `credit`, `balance`, `as_of_date`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 78, 1050.00, 0.00, 1050.00, '2026-09-05', 1, '2026-09-05 03:24:25', '2026-09-05 03:59:04'),
(2, 80, 61.53, 0.00, 61.53, '2026-09-05', 1, '2026-09-05 03:24:25', '2026-09-05 03:59:04'),
(3, 87, 42.00, 0.00, 42.00, '2026-09-05', 1, '2026-09-05 03:24:25', '2026-09-05 04:57:23'),
(4, 91, 0.00, 39.50, 39.50, '2026-09-05', 1, '2026-09-05 03:24:25', '2026-09-05 03:59:04'),
(5, 53, 1500.00, 900.00, 600.00, '2026-09-05', 1, '2026-09-05 03:24:25', '2026-09-05 04:57:23'),
(6, 63, 0.00, 164.03, 0.00, '2026-09-05', 1, '2026-09-05 03:24:25', '2026-09-05 03:59:04'),
(7, 92, 0.00, 10.00, 10.00, '2026-09-05', 1, '2026-09-05 03:59:04', '2026-09-05 03:59:04'),
(8, 55, 200.00, 0.00, 200.00, '2026-09-05', 1, '2026-09-05 04:57:23', '2026-09-05 04:57:23'),
(9, 86, 60.00, 0.00, 60.00, '2026-09-05', 1, '2026-09-05 04:57:23', '2026-09-05 04:57:23'),
(10, 77, 0.00, 1600.00, 1600.00, '2026-09-05', 1, '2026-09-05 04:57:23', '2026-09-05 04:57:23'),
(11, 96, 0.00, 200.00, 0.00, '2026-09-05', 1, '2026-09-05 04:57:23', '2026-09-05 04:57:23');

-- --------------------------------------------------------

--
-- Table structure for table `acc_account_heads`
--

CREATE TABLE `acc_account_heads` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `type` enum('asset','equity_liability','income','expense') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_debit` tinyint(1) NOT NULL DEFAULT '1',
  `is_transaction` tinyint(1) DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `acc_account_heads`
--

INSERT INTO `acc_account_heads` (`id`, `name`, `code`, `parent_id`, `type`, `is_debit`, `is_transaction`, `remarks`, `branch_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Assets', '100000', NULL, 'asset', 1, NULL, 'System generated Assets account', NULL, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(2, 'Funds & Liabilities', '200000', NULL, 'equity_liability', 0, NULL, 'System generated Equity & Liabilities account', NULL, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(3, 'Income/Revenue ', '300000', NULL, 'income', 0, NULL, 'System generated Income account', NULL, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(4, 'Expenditure', '400000', NULL, 'expense', 1, NULL, 'System generated Expenditure account', NULL, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(5, 'Fixed Assets', '110000', 1, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:01:38', '2026-09-05 00:01:38'),
(6, 'Current Assets', '120000', 1, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:01:47', '2026-09-05 00:01:47'),
(7, 'Funds', '210000', 2, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:02:01', '2026-09-05 00:15:37'),
(8, 'Liabilities', '220000', 2, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:02:12', '2026-09-05 00:02:12'),
(9, 'General Income', '310000', 3, 'income', 0, NULL, NULL, NULL, 1, '2026-09-05 00:02:24', '2026-09-05 00:02:24'),
(10, 'Financial Income', '320000', 3, 'income', 0, NULL, NULL, NULL, 1, '2026-09-05 00:02:36', '2026-09-05 00:02:36'),
(11, 'General Expense', '410000', 4, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 00:02:52', '2026-09-05 00:02:52'),
(12, 'Financial Expense', '420000', 4, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 00:03:06', '2026-09-05 00:03:06'),
(13, 'Land Purchase & Developments', '111000', 5, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:05:46', '2026-09-05 00:08:38'),
(14, 'Furniture & Fixtures', '112000', 5, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:07:21', '2026-09-05 00:07:21'),
(15, 'Electrical & Electronics', '113000', 5, 'asset', 1, NULL, 'Electrical & Electronics', NULL, 1, '2026-09-05 00:08:17', '2026-09-05 00:09:48'),
(16, 'Computer & Accesories', '114000', 5, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:09:38', '2026-09-05 00:09:38'),
(17, 'Cash in Hand & Bank', '121000', 6, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:10:35', '2026-09-05 00:10:35'),
(18, 'Receivcbles', '122000', 6, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:12:06', '2026-09-05 00:12:06'),
(19, 'Advance & Pre Payments', '123000', 6, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:12:35', '2026-09-05 00:12:35'),
(20, 'Other Current Assets', '124000', 6, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:12:54', '2026-09-05 00:12:54'),
(21, 'General Fund', '211000', 7, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:16:12', '2026-09-05 00:16:12'),
(22, 'Capital Fund', '212000', 7, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:16:21', '2026-09-05 00:16:21'),
(23, 'Payables', '221000', 8, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:17:16', '2026-09-05 00:17:16'),
(24, 'Other Liabilities', '222000', 8, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:20:18', '2026-09-05 00:20:18'),
(25, 'Sales', '311000', 9, 'income', 0, NULL, NULL, NULL, 1, '2026-09-05 00:21:03', '2026-09-05 00:21:03'),
(26, 'Interest & Commisions', '321000', 10, 'income', 0, NULL, NULL, NULL, 1, '2026-09-05 00:21:29', '2026-09-05 00:21:29'),
(27, 'Purchase', '411000', 11, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 00:21:52', '2026-09-05 00:21:52'),
(28, 'Interest & Charges', '421000', 12, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 00:22:33', '2026-09-05 00:22:33'),
(29, 'Land Purchase', '111100', 13, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:26:49', '2026-09-05 00:26:49'),
(30, 'Land Developments', '111200', 13, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:27:08', '2026-09-05 00:27:08'),
(31, 'Furniture & Fixtures', '112100', 14, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:28:10', '2026-09-05 00:28:10'),
(32, 'Electrical Equipments', '113100', 15, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:28:37', '2026-09-05 00:28:37'),
(33, 'Electronics Equepments', '113200', 15, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:28:50', '2026-09-05 00:28:50'),
(34, 'Computers & Laptop', '114100', 16, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:29:27', '2026-09-05 00:29:27'),
(35, 'Computer Accessories', '114200', 16, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:29:44', '2026-09-05 00:29:44'),
(36, 'Cash in Hand', '121100', 17, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:29:55', '2026-09-05 00:29:55'),
(37, 'Cash at Bank', '121200', 17, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:30:17', '2026-09-05 00:30:17'),
(38, 'Customer Dues', '122100', 18, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:31:09', '2026-09-05 00:31:09'),
(39, 'Advance', '123100', 19, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:31:38', '2026-09-05 00:51:36'),
(40, 'Inventory', '124100', 20, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:31:47', '2026-09-05 01:23:28'),
(41, 'General Fund', '211100', 21, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:32:00', '2026-09-05 00:32:00'),
(42, 'Capital Fund', '212100', 22, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:32:12', '2026-09-05 00:32:12'),
(43, 'Supplier Dues', '221100', 23, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:33:13', '2026-09-05 00:33:13'),
(44, 'Other Liabilities', '222100', 24, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:33:25', '2026-09-05 00:33:25'),
(45, 'Land Purchase', '111101', 29, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:44:06', '2026-09-05 00:44:06'),
(46, 'Land Developments', '111201', 30, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:44:17', '2026-09-05 00:44:17'),
(47, 'Furniture & Fixtures', '112101', 31, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:44:30', '2026-09-05 00:44:30'),
(48, 'Electrical Equipments', '113101', 32, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:44:47', '2026-09-05 00:44:47'),
(49, 'Electronics Equepments', '113201', 33, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:44:59', '2026-09-05 00:44:59'),
(50, 'Computers', '114101', 34, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:45:11', '2026-09-05 00:45:11'),
(51, 'Laptop', '114102', 34, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:45:27', '2026-09-05 00:45:27'),
(52, 'Computer Accessories', '114201', 35, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:45:35', '2026-09-05 00:45:35'),
(53, 'Cash', '121101', 36, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:45:49', '2026-09-05 00:45:49'),
(54, 'Test Bank STD-123', '121201', 37, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:46:14', '2026-09-05 00:46:14'),
(55, 'Due Sales', '122101', 38, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:46:59', '2026-09-05 00:46:59'),
(56, 'Supplier Advance', '123101', 39, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:47:23', '2026-09-05 02:13:40'),
(57, 'Others', '124200', 20, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:47:32', '2026-09-05 01:23:53'),
(58, 'Income Over Expenditure', '213000', 7, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:48:30', '2026-09-05 00:48:30'),
(59, 'Income Over Expenditure', '213100', 58, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:48:35', '2026-09-05 00:48:35'),
(60, 'Income Over Expenditure', '213101', 59, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:48:39', '2026-09-05 00:48:39'),
(61, 'General Fund', '211101', 41, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:48:53', '2026-09-05 00:48:53'),
(62, 'Capital Fund', '212101', 42, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:49:00', '2026-09-05 00:49:00'),
(63, 'Due Purchase', '221101', 43, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:49:31', '2026-09-05 00:49:31'),
(64, 'Other Liabilities', '222101', 44, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:49:41', '2026-09-05 00:49:41'),
(65, 'Sales', '311100', 25, 'income', 0, NULL, NULL, NULL, 1, '2026-09-05 00:49:51', '2026-09-05 00:49:51'),
(66, 'Interest & Commisions', '321100', 26, 'income', 0, NULL, NULL, NULL, 1, '2026-09-05 00:50:03', '2026-09-05 00:50:03'),
(67, 'Purchase', '411100', 27, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 00:50:21', '2026-09-05 00:50:21'),
(68, 'Interest & Charges', '421100', 28, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 00:50:28', '2026-09-05 00:50:28'),
(69, 'Pre Payments', '123200', 19, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:51:58', '2026-09-05 00:51:58'),
(70, 'Advance Againts Salary', '123201', 69, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 00:52:30', '2026-09-05 00:52:30'),
(71, 'Customer Advance', '221200', 23, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:56:28', '2026-09-05 00:56:28'),
(72, 'Customer Advance', '221201', 71, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 00:56:40', '2026-09-05 00:56:40'),
(73, 'Depreciation', '430000', 4, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 01:05:10', '2026-09-05 01:05:10'),
(74, 'Depreciation', '431000', 73, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 01:05:16', '2026-09-05 01:05:16'),
(75, 'Depreciation', '431100', 74, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 01:05:20', '2026-09-05 01:05:20'),
(76, 'Depreciation', '431101', 75, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 01:05:25', '2026-09-05 01:05:25'),
(77, 'Sales', '311101', 65, 'income', 0, NULL, NULL, NULL, 1, '2026-09-05 01:17:59', '2026-09-05 01:17:59'),
(78, 'Purchase', '411101', 67, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 01:20:25', '2026-09-05 01:20:25'),
(79, 'Cost of Goods Sold (COGS)', '124101', 40, 'asset', 1, NULL, NULL, NULL, 1, '2026-09-05 01:23:59', '2026-09-05 01:24:34'),
(80, 'Tax', '421101', 68, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 01:29:11', '2026-09-05 01:29:11'),
(81, 'Vat', '421102', 68, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 01:29:43', '2026-09-05 01:29:43'),
(82, 'Miscellaneous Expense', '440000', 4, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 01:36:16', '2026-09-05 01:36:16'),
(83, 'Miscellaneous Expense', '441000', 82, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 01:36:22', '2026-09-05 01:36:22'),
(84, 'Miscellaneous Expense', '441100', 83, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 01:36:26', '2026-09-05 01:36:26'),
(85, 'Wastage Expense', '441101', 84, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 01:36:31', '2026-09-05 01:47:43'),
(86, 'Sales Discount', '441102', 84, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 01:51:00', '2026-09-05 01:51:00'),
(87, 'Sales Adjustment', '441103', 84, 'expense', 1, NULL, NULL, NULL, 1, '2026-09-05 01:56:12', '2026-09-05 03:42:47'),
(88, 'Others Income', '330000', 3, 'income', 0, NULL, NULL, NULL, 1, '2026-09-05 02:08:39', '2026-09-05 02:08:39'),
(89, 'Others Income', '331000', 88, 'income', 0, NULL, NULL, NULL, 1, '2026-09-05 02:08:58', '2026-09-05 02:08:58'),
(90, 'Others Income', '331100', 89, 'income', 0, NULL, NULL, NULL, 1, '2026-09-05 02:09:11', '2026-09-05 02:09:11'),
(91, 'Purchase Discount', '331101', 90, 'income', 0, NULL, NULL, NULL, 1, '2026-09-05 02:09:17', '2026-09-05 02:09:17'),
(92, 'Purchase Adjustments', '331102', 90, 'income', 0, NULL, NULL, NULL, 1, '2026-09-05 03:42:35', '2026-09-05 03:42:35'),
(93, 'Bank Interest', '321101', 66, 'income', 0, NULL, NULL, NULL, 1, '2026-09-05 04:09:51', '2026-09-05 04:09:51'),
(94, 'Others', '222102', 44, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 04:10:51', '2026-09-05 04:11:07'),
(95, 'Tax & Vat', '222200', 24, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 04:11:17', '2026-09-05 04:11:17'),
(96, 'Tax', '222201', 95, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 04:11:24', '2026-09-05 04:11:24'),
(97, 'Vat', '222202', 95, 'equity_liability', 0, NULL, NULL, NULL, 1, '2026-09-05 04:11:33', '2026-09-05 04:11:33');

-- --------------------------------------------------------

--
-- Table structure for table `acc_account_settings`
--

CREATE TABLE `acc_account_settings` (
  `id` bigint UNSIGNED NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `acc_account_users`
--

CREATE TABLE `acc_account_users` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `module` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `can_create` tinyint(1) NOT NULL DEFAULT '0',
  `can_approve` tinyint(1) NOT NULL DEFAULT '0',
  `can_view_reports` tinyint(1) NOT NULL DEFAULT '0',
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `acc_audit_logs`
--

CREATE TABLE `acc_audit_logs` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_ref` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` json DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `acc_audit_logs`
--

INSERT INTO `acc_audit_logs` (`id`, `user_id`, `action`, `source_ref`, `details`, `created_at`) VALUES
(1, 1, 'Created Chart Of Account', '110000', '{\"data\": {\"id\": 5, \"code\": 110000, \"name\": \"Fixed Assets\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 1, \"created_at\": \"2026-09-05T05:49:48.000000Z\", \"updated_at\": \"2026-09-05T05:49:48.000000Z\"}}', '2026-09-04 23:49:48'),
(2, 1, 'Created Chart Of Account', '120000', '{\"data\": {\"id\": 6, \"code\": 120000, \"name\": \"Current Assets\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 1, \"created_at\": \"2026-09-05T05:50:12.000000Z\", \"updated_at\": \"2026-09-05T05:50:12.000000Z\"}}', '2026-09-04 23:50:12'),
(3, 1, 'Created Chart Of Account', '110000', '{\"data\": {\"id\": 5, \"code\": 110000, \"name\": \"Fixed Assets\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 1, \"created_at\": \"2026-09-05T06:01:38.000000Z\", \"updated_at\": \"2026-09-05T06:01:38.000000Z\"}}', '2026-09-05 00:01:38'),
(4, 1, 'Created Chart Of Account', '120000', '{\"data\": {\"id\": 6, \"code\": 120000, \"name\": \"Current Assets\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 1, \"created_at\": \"2026-09-05T06:01:47.000000Z\", \"updated_at\": \"2026-09-05T06:01:47.000000Z\"}}', '2026-09-05 00:01:48'),
(5, 1, 'Created Chart Of Account', '210000', '{\"data\": {\"id\": 7, \"code\": 210000, \"name\": \"Equity\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 2, \"created_at\": \"2026-09-05T06:02:01.000000Z\", \"updated_at\": \"2026-09-05T06:02:01.000000Z\"}}', '2026-09-05 00:02:01'),
(6, 1, 'Created Chart Of Account', '220000', '{\"data\": {\"id\": 8, \"code\": 220000, \"name\": \"Liabilities\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 2, \"created_at\": \"2026-09-05T06:02:12.000000Z\", \"updated_at\": \"2026-09-05T06:02:12.000000Z\"}}', '2026-09-05 00:02:12'),
(7, 1, 'Created Chart Of Account', '310000', '{\"data\": {\"id\": 9, \"code\": 310000, \"name\": \"General Income\", \"type\": \"income\", \"status\": true, \"is_debit\": false, \"parent_id\": 3, \"created_at\": \"2026-09-05T06:02:24.000000Z\", \"updated_at\": \"2026-09-05T06:02:24.000000Z\"}}', '2026-09-05 00:02:24'),
(8, 1, 'Created Chart Of Account', '320000', '{\"data\": {\"id\": 10, \"code\": 320000, \"name\": \"Financial Income\", \"type\": \"income\", \"status\": true, \"is_debit\": false, \"parent_id\": 3, \"created_at\": \"2026-09-05T06:02:36.000000Z\", \"updated_at\": \"2026-09-05T06:02:36.000000Z\"}}', '2026-09-05 00:02:36'),
(9, 1, 'Created Chart Of Account', '410000', '{\"data\": {\"id\": 11, \"code\": 410000, \"name\": \"General Expense\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 4, \"created_at\": \"2026-09-05T06:02:52.000000Z\", \"updated_at\": \"2026-09-05T06:02:52.000000Z\"}}', '2026-09-05 00:02:52'),
(10, 1, 'Created Chart Of Account', '420000', '{\"data\": {\"id\": 12, \"code\": 420000, \"name\": \"Financial Expense\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 4, \"created_at\": \"2026-09-05T06:03:06.000000Z\", \"updated_at\": \"2026-09-05T06:03:06.000000Z\"}}', '2026-09-05 00:03:06'),
(11, 1, 'Created Chart Of Account', '111000', '{\"data\": {\"id\": 13, \"code\": 111000, \"name\": \"Land Purchase & Land Developments\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 5, \"created_at\": \"2026-09-05T06:05:46.000000Z\", \"updated_at\": \"2026-09-05T06:05:46.000000Z\"}}', '2026-09-05 00:05:46'),
(12, 1, 'Created Chart Of Account', '112000', '{\"data\": {\"id\": 14, \"code\": 112000, \"name\": \"Furniture & Fixtures\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 5, \"created_at\": \"2026-09-05T06:07:21.000000Z\", \"updated_at\": \"2026-09-05T06:07:21.000000Z\"}}', '2026-09-05 00:07:21'),
(13, 1, 'Created Chart Of Account', '113000', '{\"data\": {\"id\": 15, \"code\": 113000, \"name\": \"Electrical & Electronics Equepments\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 5, \"created_at\": \"2026-09-05T06:08:17.000000Z\", \"updated_at\": \"2026-09-05T06:08:17.000000Z\"}}', '2026-09-05 00:08:17'),
(14, 1, 'Updated Chart Of Account', '113000', '{\"id\": \"15\", \"new\": {\"id\": 15, \"code\": 113000, \"name\": \"Electrical & Electronics\", \"type\": \"asset\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 5, \"created_at\": \"2026-09-05T06:08:17.000000Z\", \"updated_at\": \"2026-09-05T06:08:25.000000Z\", \"is_transaction\": null}, \"old\": {\"id\": 15, \"code\": 113000, \"name\": \"Electrical & Electronics Equepments\", \"type\": \"asset\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 5, \"created_at\": \"2026-09-05T06:08:17.000000Z\", \"updated_at\": \"2026-09-05T06:08:17.000000Z\", \"is_transaction\": null}}', '2026-09-05 00:08:25'),
(15, 1, 'Updated Chart Of Account', '111000', '{\"id\": \"13\", \"new\": {\"id\": 13, \"code\": 111000, \"name\": \"Land Purchase & Developments\", \"type\": \"asset\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 5, \"created_at\": \"2026-09-05T06:05:46.000000Z\", \"updated_at\": \"2026-09-05T06:08:38.000000Z\", \"is_transaction\": null}, \"old\": {\"id\": 13, \"code\": 111000, \"name\": \"Land Purchase & Land Developments\", \"type\": \"asset\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 5, \"created_at\": \"2026-09-05T06:05:46.000000Z\", \"updated_at\": \"2026-09-05T06:05:46.000000Z\", \"is_transaction\": null}}', '2026-09-05 00:08:38'),
(16, 1, 'Created Chart Of Account', '114000', '{\"data\": {\"id\": 16, \"code\": 114000, \"name\": \"Computer & Accesories\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 5, \"created_at\": \"2026-09-05T06:09:38.000000Z\", \"updated_at\": \"2026-09-05T06:09:38.000000Z\"}}', '2026-09-05 00:09:38'),
(17, 1, 'Updated Chart Of Account', '113000', '{\"id\": \"15\", \"new\": {\"id\": 15, \"code\": 113000, \"name\": \"Electrical & Electronics\", \"type\": \"asset\", \"status\": true, \"remarks\": \"Electrical & Electronics\", \"is_debit\": true, \"branch_id\": null, \"parent_id\": 5, \"created_at\": \"2026-09-05T06:08:17.000000Z\", \"updated_at\": \"2026-09-05T06:09:48.000000Z\", \"is_transaction\": null}, \"old\": {\"id\": 15, \"code\": 113000, \"name\": \"Electrical & Electronics\", \"type\": \"asset\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 5, \"created_at\": \"2026-09-05T06:08:17.000000Z\", \"updated_at\": \"2026-09-05T06:08:25.000000Z\", \"is_transaction\": null}}', '2026-09-05 00:09:48'),
(18, 1, 'Created Chart Of Account', '121000', '{\"data\": {\"id\": 17, \"code\": 121000, \"name\": \"Cash in Hand & Bank\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 6, \"created_at\": \"2026-09-05T06:10:35.000000Z\", \"updated_at\": \"2026-09-05T06:10:35.000000Z\"}}', '2026-09-05 00:10:35'),
(19, 1, 'Created Chart Of Account', '122000', '{\"data\": {\"id\": 18, \"code\": 122000, \"name\": \"Receivcbles\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 6, \"created_at\": \"2026-09-05T06:12:06.000000Z\", \"updated_at\": \"2026-09-05T06:12:06.000000Z\"}}', '2026-09-05 00:12:06'),
(20, 1, 'Created Chart Of Account', '123000', '{\"data\": {\"id\": 19, \"code\": 123000, \"name\": \"Advance & Pre Payments\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 6, \"created_at\": \"2026-09-05T06:12:35.000000Z\", \"updated_at\": \"2026-09-05T06:12:35.000000Z\"}}', '2026-09-05 00:12:35'),
(21, 1, 'Created Chart Of Account', '124000', '{\"data\": {\"id\": 20, \"code\": 124000, \"name\": \"Other Current Assets\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 6, \"created_at\": \"2026-09-05T06:12:54.000000Z\", \"updated_at\": \"2026-09-05T06:12:54.000000Z\"}}', '2026-09-05 00:12:54'),
(22, 1, 'Updated Chart Of Account', '210000', '{\"id\": \"7\", \"new\": {\"id\": 7, \"code\": 210000, \"name\": \"Funds\", \"type\": \"equity_liability\", \"status\": true, \"remarks\": null, \"is_debit\": false, \"branch_id\": null, \"parent_id\": 2, \"created_at\": \"2026-09-05T06:02:01.000000Z\", \"updated_at\": \"2026-09-05T06:15:37.000000Z\", \"is_transaction\": null}, \"old\": {\"id\": 7, \"code\": 210000, \"name\": \"Equity\", \"type\": \"equity_liability\", \"status\": true, \"remarks\": null, \"is_debit\": false, \"branch_id\": null, \"parent_id\": 2, \"created_at\": \"2026-09-05T06:02:01.000000Z\", \"updated_at\": \"2026-09-05T06:02:01.000000Z\", \"is_transaction\": null}}', '2026-09-05 00:15:37'),
(23, 1, 'Created Chart Of Account', '211000', '{\"data\": {\"id\": 21, \"code\": 211000, \"name\": \"General Fund\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 7, \"created_at\": \"2026-09-05T06:16:12.000000Z\", \"updated_at\": \"2026-09-05T06:16:12.000000Z\"}}', '2026-09-05 00:16:12'),
(24, 1, 'Created Chart Of Account', '212000', '{\"data\": {\"id\": 22, \"code\": 212000, \"name\": \"Capital Fund\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 7, \"created_at\": \"2026-09-05T06:16:21.000000Z\", \"updated_at\": \"2026-09-05T06:16:21.000000Z\"}}', '2026-09-05 00:16:21'),
(25, 1, 'Created Chart Of Account', '221000', '{\"data\": {\"id\": 23, \"code\": 221000, \"name\": \"Payables\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 8, \"created_at\": \"2026-09-05T06:17:16.000000Z\", \"updated_at\": \"2026-09-05T06:17:16.000000Z\"}}', '2026-09-05 00:17:16'),
(26, 1, 'Created Chart Of Account', '222000', '{\"data\": {\"id\": 24, \"code\": 222000, \"name\": \"Other Liabilities\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 8, \"created_at\": \"2026-09-05T06:20:18.000000Z\", \"updated_at\": \"2026-09-05T06:20:18.000000Z\"}}', '2026-09-05 00:20:18'),
(27, 1, 'Created Chart Of Account', '311000', '{\"data\": {\"id\": 25, \"code\": 311000, \"name\": \"Sales\", \"type\": \"income\", \"status\": true, \"is_debit\": false, \"parent_id\": 9, \"created_at\": \"2026-09-05T06:21:03.000000Z\", \"updated_at\": \"2026-09-05T06:21:03.000000Z\"}}', '2026-09-05 00:21:03'),
(28, 1, 'Created Chart Of Account', '321000', '{\"data\": {\"id\": 26, \"code\": 321000, \"name\": \"Interest & Commisions\", \"type\": \"income\", \"status\": true, \"is_debit\": false, \"parent_id\": 10, \"created_at\": \"2026-09-05T06:21:29.000000Z\", \"updated_at\": \"2026-09-05T06:21:29.000000Z\"}}', '2026-09-05 00:21:29'),
(29, 1, 'Created Chart Of Account', '411000', '{\"data\": {\"id\": 27, \"code\": 411000, \"name\": \"Purchase\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 11, \"created_at\": \"2026-09-05T06:21:52.000000Z\", \"updated_at\": \"2026-09-05T06:21:52.000000Z\"}}', '2026-09-05 00:21:52'),
(30, 1, 'Created Chart Of Account', '421000', '{\"data\": {\"id\": 28, \"code\": 421000, \"name\": \"Interest & Charges\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 12, \"created_at\": \"2026-09-05T06:22:33.000000Z\", \"updated_at\": \"2026-09-05T06:22:33.000000Z\"}}', '2026-09-05 00:22:33'),
(31, 1, 'Created Chart Of Account', '111100', '{\"data\": {\"id\": 29, \"code\": 111100, \"name\": \"Land Purchase\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 13, \"created_at\": \"2026-09-05T06:26:49.000000Z\", \"updated_at\": \"2026-09-05T06:26:49.000000Z\"}}', '2026-09-05 00:26:49'),
(32, 1, 'Created Chart Of Account', '111200', '{\"data\": {\"id\": 30, \"code\": 111200, \"name\": \"Land Developments\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 13, \"created_at\": \"2026-09-05T06:27:08.000000Z\", \"updated_at\": \"2026-09-05T06:27:08.000000Z\"}}', '2026-09-05 00:27:08'),
(33, 1, 'Created Chart Of Account', '112100', '{\"data\": {\"id\": 31, \"code\": 112100, \"name\": \"Furniture & Fixtures\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 14, \"created_at\": \"2026-09-05T06:28:10.000000Z\", \"updated_at\": \"2026-09-05T06:28:10.000000Z\"}}', '2026-09-05 00:28:10'),
(34, 1, 'Created Chart Of Account', '113100', '{\"data\": {\"id\": 32, \"code\": 113100, \"name\": \"Electrical Equipments\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 15, \"created_at\": \"2026-09-05T06:28:37.000000Z\", \"updated_at\": \"2026-09-05T06:28:37.000000Z\"}}', '2026-09-05 00:28:37'),
(35, 1, 'Created Chart Of Account', '113200', '{\"data\": {\"id\": 33, \"code\": 113200, \"name\": \"Electronics Equepments\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 15, \"created_at\": \"2026-09-05T06:28:50.000000Z\", \"updated_at\": \"2026-09-05T06:28:50.000000Z\"}}', '2026-09-05 00:28:50'),
(36, 1, 'Created Chart Of Account', '114100', '{\"data\": {\"id\": 34, \"code\": 114100, \"name\": \"Computers & Laptop\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 16, \"created_at\": \"2026-09-05T06:29:27.000000Z\", \"updated_at\": \"2026-09-05T06:29:27.000000Z\"}}', '2026-09-05 00:29:27'),
(37, 1, 'Created Chart Of Account', '114200', '{\"data\": {\"id\": 35, \"code\": 114200, \"name\": \"Computer Accessories\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 16, \"created_at\": \"2026-09-05T06:29:44.000000Z\", \"updated_at\": \"2026-09-05T06:29:44.000000Z\"}}', '2026-09-05 00:29:44'),
(38, 1, 'Created Chart Of Account', '121100', '{\"data\": {\"id\": 36, \"code\": 121100, \"name\": \"Cash in Hand\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 17, \"created_at\": \"2026-09-05T06:29:55.000000Z\", \"updated_at\": \"2026-09-05T06:29:55.000000Z\"}}', '2026-09-05 00:29:55'),
(39, 1, 'Created Chart Of Account', '121200', '{\"data\": {\"id\": 37, \"code\": 121200, \"name\": \"Cash at Bank\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 17, \"created_at\": \"2026-09-05T06:30:17.000000Z\", \"updated_at\": \"2026-09-05T06:30:17.000000Z\"}}', '2026-09-05 00:30:17'),
(40, 1, 'Created Chart Of Account', '122100', '{\"data\": {\"id\": 38, \"code\": 122100, \"name\": \"Customer Dues\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 18, \"created_at\": \"2026-09-05T06:31:09.000000Z\", \"updated_at\": \"2026-09-05T06:31:09.000000Z\"}}', '2026-09-05 00:31:09'),
(41, 1, 'Created Chart Of Account', '123100', '{\"data\": {\"id\": 39, \"code\": 123100, \"name\": \"Advance to Suppliers\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 19, \"created_at\": \"2026-09-05T06:31:38.000000Z\", \"updated_at\": \"2026-09-05T06:31:38.000000Z\"}}', '2026-09-05 00:31:38'),
(42, 1, 'Created Chart Of Account', '124100', '{\"data\": {\"id\": 40, \"code\": 124100, \"name\": \"Other Current Assets\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 20, \"created_at\": \"2026-09-05T06:31:47.000000Z\", \"updated_at\": \"2026-09-05T06:31:47.000000Z\"}}', '2026-09-05 00:31:47'),
(43, 1, 'Created Chart Of Account', '211100', '{\"data\": {\"id\": 41, \"code\": 211100, \"name\": \"General Fund\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 21, \"created_at\": \"2026-09-05T06:32:00.000000Z\", \"updated_at\": \"2026-09-05T06:32:00.000000Z\"}}', '2026-09-05 00:32:00'),
(44, 1, 'Created Chart Of Account', '212100', '{\"data\": {\"id\": 42, \"code\": 212100, \"name\": \"Capital Fund\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 22, \"created_at\": \"2026-09-05T06:32:12.000000Z\", \"updated_at\": \"2026-09-05T06:32:12.000000Z\"}}', '2026-09-05 00:32:12'),
(45, 1, 'Created Chart Of Account', '221100', '{\"data\": {\"id\": 43, \"code\": 221100, \"name\": \"Supplier Dues\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 23, \"created_at\": \"2026-09-05T06:33:13.000000Z\", \"updated_at\": \"2026-09-05T06:33:13.000000Z\"}}', '2026-09-05 00:33:13'),
(46, 1, 'Created Chart Of Account', '222100', '{\"data\": {\"id\": 44, \"code\": 222100, \"name\": \"Other Liabilities\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 24, \"created_at\": \"2026-09-05T06:33:25.000000Z\", \"updated_at\": \"2026-09-05T06:33:25.000000Z\"}}', '2026-09-05 00:33:25'),
(47, 1, 'Created Chart Of Account', '111101', '{\"data\": {\"id\": 45, \"code\": 111101, \"name\": \"Land Purchase\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 29, \"created_at\": \"2026-09-05T06:44:06.000000Z\", \"updated_at\": \"2026-09-05T06:44:06.000000Z\"}}', '2026-09-05 00:44:06'),
(48, 1, 'Created Chart Of Account', '111201', '{\"data\": {\"id\": 46, \"code\": 111201, \"name\": \"Land Developments\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 30, \"created_at\": \"2026-09-05T06:44:17.000000Z\", \"updated_at\": \"2026-09-05T06:44:17.000000Z\"}}', '2026-09-05 00:44:17'),
(49, 1, 'Created Chart Of Account', '112101', '{\"data\": {\"id\": 47, \"code\": 112101, \"name\": \"Furniture & Fixtures\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 31, \"created_at\": \"2026-09-05T06:44:30.000000Z\", \"updated_at\": \"2026-09-05T06:44:30.000000Z\"}}', '2026-09-05 00:44:30'),
(50, 1, 'Created Chart Of Account', '113101', '{\"data\": {\"id\": 48, \"code\": 113101, \"name\": \"Electrical Equipments\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 32, \"created_at\": \"2026-09-05T06:44:47.000000Z\", \"updated_at\": \"2026-09-05T06:44:47.000000Z\"}}', '2026-09-05 00:44:47'),
(51, 1, 'Created Chart Of Account', '113201', '{\"data\": {\"id\": 49, \"code\": 113201, \"name\": \"Electronics Equepments\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 33, \"created_at\": \"2026-09-05T06:44:59.000000Z\", \"updated_at\": \"2026-09-05T06:44:59.000000Z\"}}', '2026-09-05 00:44:59'),
(52, 1, 'Created Chart Of Account', '114101', '{\"data\": {\"id\": 50, \"code\": 114101, \"name\": \"Computers\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 34, \"created_at\": \"2026-09-05T06:45:11.000000Z\", \"updated_at\": \"2026-09-05T06:45:11.000000Z\"}}', '2026-09-05 00:45:11'),
(53, 1, 'Created Chart Of Account', '114102', '{\"data\": {\"id\": 51, \"code\": 114102, \"name\": \"Laptop\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 34, \"created_at\": \"2026-09-05T06:45:27.000000Z\", \"updated_at\": \"2026-09-05T06:45:27.000000Z\"}}', '2026-09-05 00:45:27'),
(54, 1, 'Created Chart Of Account', '114201', '{\"data\": {\"id\": 52, \"code\": 114201, \"name\": \"Computer Accessories\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 35, \"created_at\": \"2026-09-05T06:45:35.000000Z\", \"updated_at\": \"2026-09-05T06:45:35.000000Z\"}}', '2026-09-05 00:45:35'),
(55, 1, 'Created Chart Of Account', '121101', '{\"data\": {\"id\": 53, \"code\": 121101, \"name\": \"Cash\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 36, \"created_at\": \"2026-09-05T06:45:49.000000Z\", \"updated_at\": \"2026-09-05T06:45:49.000000Z\"}}', '2026-09-05 00:45:49'),
(56, 1, 'Created Chart Of Account', '121201', '{\"data\": {\"id\": 54, \"code\": 121201, \"name\": \"Test Bank STD-123\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 37, \"created_at\": \"2026-09-05T06:46:14.000000Z\", \"updated_at\": \"2026-09-05T06:46:14.000000Z\"}}', '2026-09-05 00:46:14'),
(57, 1, 'Created Chart Of Account', '122101', '{\"data\": {\"id\": 55, \"code\": 122101, \"name\": \"Due Sales\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 38, \"created_at\": \"2026-09-05T06:46:59.000000Z\", \"updated_at\": \"2026-09-05T06:46:59.000000Z\"}}', '2026-09-05 00:46:59'),
(58, 1, 'Created Chart Of Account', '123101', '{\"data\": {\"id\": 56, \"code\": 123101, \"name\": \"Supplier Adance\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 39, \"created_at\": \"2026-09-05T06:47:23.000000Z\", \"updated_at\": \"2026-09-05T06:47:23.000000Z\"}}', '2026-09-05 00:47:23'),
(59, 1, 'Created Chart Of Account', '124200', '{\"data\": {\"id\": 57, \"code\": 124200, \"name\": \"Other Current Assets\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 20, \"created_at\": \"2026-09-05T06:47:32.000000Z\", \"updated_at\": \"2026-09-05T06:47:32.000000Z\"}}', '2026-09-05 00:47:32'),
(60, 1, 'Created Chart Of Account', '213000', '{\"data\": {\"id\": 58, \"code\": 213000, \"name\": \"Income Over Expenditure\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 7, \"created_at\": \"2026-09-05T06:48:30.000000Z\", \"updated_at\": \"2026-09-05T06:48:30.000000Z\"}}', '2026-09-05 00:48:30'),
(61, 1, 'Created Chart Of Account', '213100', '{\"data\": {\"id\": 59, \"code\": 213100, \"name\": \"Income Over Expenditure\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 58, \"created_at\": \"2026-09-05T06:48:35.000000Z\", \"updated_at\": \"2026-09-05T06:48:35.000000Z\"}}', '2026-09-05 00:48:35'),
(62, 1, 'Created Chart Of Account', '213101', '{\"data\": {\"id\": 60, \"code\": 213101, \"name\": \"Income Over Expenditure\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 59, \"created_at\": \"2026-09-05T06:48:39.000000Z\", \"updated_at\": \"2026-09-05T06:48:39.000000Z\"}}', '2026-09-05 00:48:39'),
(63, 1, 'Created Chart Of Account', '211101', '{\"data\": {\"id\": 61, \"code\": 211101, \"name\": \"General Fund\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 41, \"created_at\": \"2026-09-05T06:48:53.000000Z\", \"updated_at\": \"2026-09-05T06:48:53.000000Z\"}}', '2026-09-05 00:48:53'),
(64, 1, 'Created Chart Of Account', '212101', '{\"data\": {\"id\": 62, \"code\": 212101, \"name\": \"Capital Fund\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 42, \"created_at\": \"2026-09-05T06:49:00.000000Z\", \"updated_at\": \"2026-09-05T06:49:00.000000Z\"}}', '2026-09-05 00:49:00'),
(65, 1, 'Created Chart Of Account', '221101', '{\"data\": {\"id\": 63, \"code\": 221101, \"name\": \"Due Purchase\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 43, \"created_at\": \"2026-09-05T06:49:31.000000Z\", \"updated_at\": \"2026-09-05T06:49:31.000000Z\"}}', '2026-09-05 00:49:31'),
(66, 1, 'Created Chart Of Account', '222101', '{\"data\": {\"id\": 64, \"code\": 222101, \"name\": \"Other Liabilities\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 44, \"created_at\": \"2026-09-05T06:49:41.000000Z\", \"updated_at\": \"2026-09-05T06:49:41.000000Z\"}}', '2026-09-05 00:49:41'),
(67, 1, 'Created Chart Of Account', '311100', '{\"data\": {\"id\": 65, \"code\": 311100, \"name\": \"Sales\", \"type\": \"income\", \"status\": true, \"is_debit\": false, \"parent_id\": 25, \"created_at\": \"2026-09-05T06:49:51.000000Z\", \"updated_at\": \"2026-09-05T06:49:51.000000Z\"}}', '2026-09-05 00:49:51'),
(68, 1, 'Created Chart Of Account', '321100', '{\"data\": {\"id\": 66, \"code\": 321100, \"name\": \"Interest & Commisions\", \"type\": \"income\", \"status\": true, \"is_debit\": false, \"parent_id\": 26, \"created_at\": \"2026-09-05T06:50:03.000000Z\", \"updated_at\": \"2026-09-05T06:50:03.000000Z\"}}', '2026-09-05 00:50:03'),
(69, 1, 'Created Chart Of Account', '411100', '{\"data\": {\"id\": 67, \"code\": 411100, \"name\": \"Purchase\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 27, \"created_at\": \"2026-09-05T06:50:21.000000Z\", \"updated_at\": \"2026-09-05T06:50:21.000000Z\"}}', '2026-09-05 00:50:21'),
(70, 1, 'Created Chart Of Account', '421100', '{\"data\": {\"id\": 68, \"code\": 421100, \"name\": \"Interest & Charges\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 28, \"created_at\": \"2026-09-05T06:50:28.000000Z\", \"updated_at\": \"2026-09-05T06:50:28.000000Z\"}}', '2026-09-05 00:50:28'),
(71, 1, 'Updated Chart Of Account', '123100', '{\"id\": \"39\", \"new\": {\"id\": 39, \"code\": 123100, \"name\": \"Advance\", \"type\": \"asset\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 19, \"created_at\": \"2026-09-05T06:31:38.000000Z\", \"updated_at\": \"2026-09-05T06:51:36.000000Z\", \"is_transaction\": null}, \"old\": {\"id\": 39, \"code\": 123100, \"name\": \"Advance to Suppliers\", \"type\": \"asset\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 19, \"created_at\": \"2026-09-05T06:31:38.000000Z\", \"updated_at\": \"2026-09-05T06:31:38.000000Z\", \"is_transaction\": null}}', '2026-09-05 00:51:36'),
(72, 1, 'Created Chart Of Account', '123200', '{\"data\": {\"id\": 69, \"code\": 123200, \"name\": \"Pre Payments\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 19, \"created_at\": \"2026-09-05T06:51:58.000000Z\", \"updated_at\": \"2026-09-05T06:51:58.000000Z\"}}', '2026-09-05 00:51:58'),
(73, 1, 'Created Chart Of Account', '123201', '{\"data\": {\"id\": 70, \"code\": 123201, \"name\": \"Advance Againts Salary\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 69, \"created_at\": \"2026-09-05T06:52:30.000000Z\", \"updated_at\": \"2026-09-05T06:52:30.000000Z\"}}', '2026-09-05 00:52:30'),
(74, 1, 'Created Chart Of Account', '221200', '{\"data\": {\"id\": 71, \"code\": 221200, \"name\": \"Customer Advance\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 23, \"created_at\": \"2026-09-05T06:56:28.000000Z\", \"updated_at\": \"2026-09-05T06:56:28.000000Z\"}}', '2026-09-05 00:56:28'),
(75, 1, 'Created Chart Of Account', '221201', '{\"data\": {\"id\": 72, \"code\": 221201, \"name\": \"Customer Advance\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 71, \"created_at\": \"2026-09-05T06:56:40.000000Z\", \"updated_at\": \"2026-09-05T06:56:40.000000Z\"}}', '2026-09-05 00:56:40'),
(76, 1, 'Created Account Module', '1', '{\"data\": {\"id\": 1, \"created_at\": \"2026-09-05T06:57:22.000000Z\", \"entry_type\": \"Customer Advance\", \"module_key\": \"inventory\", \"updated_at\": \"2026-09-05T06:57:22.000000Z\", \"feature_key\": \"customer_advance\", \"module_name\": \"Customer Advance\"}, \"module_entry_id\": 1}', '2026-09-05 00:57:22'),
(77, 1, 'Created Chart Of Account', '430000', '{\"data\": {\"id\": 73, \"code\": 430000, \"name\": \"Depreciation\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 4, \"created_at\": \"2026-09-05T07:05:10.000000Z\", \"updated_at\": \"2026-09-05T07:05:10.000000Z\"}}', '2026-09-05 01:05:10'),
(78, 1, 'Created Chart Of Account', '431000', '{\"data\": {\"id\": 74, \"code\": 431000, \"name\": \"Depreciation\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 73, \"created_at\": \"2026-09-05T07:05:16.000000Z\", \"updated_at\": \"2026-09-05T07:05:16.000000Z\"}}', '2026-09-05 01:05:16'),
(79, 1, 'Created Chart Of Account', '431100', '{\"data\": {\"id\": 75, \"code\": 431100, \"name\": \"Depreciation\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 74, \"created_at\": \"2026-09-05T07:05:20.000000Z\", \"updated_at\": \"2026-09-05T07:05:20.000000Z\"}}', '2026-09-05 01:05:20'),
(80, 1, 'Created Chart Of Account', '431101', '{\"data\": {\"id\": 76, \"code\": 431101, \"name\": \"Depreciation\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 75, \"created_at\": \"2026-09-05T07:05:25.000000Z\", \"updated_at\": \"2026-09-05T07:05:25.000000Z\"}}', '2026-09-05 01:05:25'),
(81, 1, 'Created Chart Of Account', '311101', '{\"data\": {\"id\": 77, \"code\": 311101, \"name\": \"Sales\", \"type\": \"income\", \"status\": true, \"is_debit\": false, \"parent_id\": 65, \"created_at\": \"2026-09-05T07:17:59.000000Z\", \"updated_at\": \"2026-09-05T07:17:59.000000Z\"}}', '2026-09-05 01:17:59'),
(82, 1, 'Created Account Module', '2', '{\"data\": {\"id\": 2, \"created_at\": \"2026-09-05T07:18:47.000000Z\", \"entry_type\": \"Customer Previous Due\", \"module_key\": \"inventory\", \"updated_at\": \"2026-09-05T07:18:47.000000Z\", \"feature_key\": \"customer_previous_due\", \"module_name\": \"Customer Previous Due\"}, \"module_entry_id\": 2}', '2026-09-05 01:18:47'),
(83, 1, 'Created Chart Of Account', '411101', '{\"data\": {\"id\": 78, \"code\": 411101, \"name\": \"Purchase\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 67, \"created_at\": \"2026-09-05T07:20:25.000000Z\", \"updated_at\": \"2026-09-05T07:20:25.000000Z\"}}', '2026-09-05 01:20:25'),
(84, 1, 'Updated Chart Of Account', '124100', '{\"id\": \"40\", \"new\": {\"id\": 40, \"code\": 124100, \"name\": \"Inventory\", \"type\": \"asset\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 20, \"created_at\": \"2026-09-05T06:31:47.000000Z\", \"updated_at\": \"2026-09-05T07:23:28.000000Z\", \"is_transaction\": null}, \"old\": {\"id\": 40, \"code\": 124100, \"name\": \"Other Current Assets\", \"type\": \"asset\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 20, \"created_at\": \"2026-09-05T06:31:47.000000Z\", \"updated_at\": \"2026-09-05T06:31:47.000000Z\", \"is_transaction\": null}}', '2026-09-05 01:23:28'),
(85, 1, 'Updated Chart Of Account', '124200', '{\"id\": \"57\", \"new\": {\"id\": 57, \"code\": 124200, \"name\": \"Inventory\", \"type\": \"asset\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 20, \"created_at\": \"2026-09-05T06:47:32.000000Z\", \"updated_at\": \"2026-09-05T07:23:36.000000Z\", \"is_transaction\": null}, \"old\": {\"id\": 57, \"code\": 124200, \"name\": \"Other Current Assets\", \"type\": \"asset\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 20, \"created_at\": \"2026-09-05T06:47:32.000000Z\", \"updated_at\": \"2026-09-05T06:47:32.000000Z\", \"is_transaction\": null}}', '2026-09-05 01:23:36'),
(86, 1, 'Updated Chart Of Account', '124200', '{\"id\": \"57\", \"new\": {\"id\": 57, \"code\": 124200, \"name\": \"Others\", \"type\": \"asset\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 20, \"created_at\": \"2026-09-05T06:47:32.000000Z\", \"updated_at\": \"2026-09-05T07:23:53.000000Z\", \"is_transaction\": null}, \"old\": {\"id\": 57, \"code\": 124200, \"name\": \"Inventory\", \"type\": \"asset\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 20, \"created_at\": \"2026-09-05T06:47:32.000000Z\", \"updated_at\": \"2026-09-05T07:23:36.000000Z\", \"is_transaction\": null}}', '2026-09-05 01:23:53'),
(87, 1, 'Created Chart Of Account', '124101', '{\"data\": {\"id\": 79, \"code\": 124101, \"name\": \"Inventory\", \"type\": \"asset\", \"status\": true, \"is_debit\": true, \"parent_id\": 40, \"created_at\": \"2026-09-05T07:23:59.000000Z\", \"updated_at\": \"2026-09-05T07:23:59.000000Z\"}}', '2026-09-05 01:23:59'),
(88, 1, 'Updated Chart Of Account', '124101', '{\"id\": \"79\", \"new\": {\"id\": 79, \"code\": 124101, \"name\": \"Cost of Goods Sold (COGS)\", \"type\": \"asset\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 40, \"created_at\": \"2026-09-05T07:23:59.000000Z\", \"updated_at\": \"2026-09-05T07:24:34.000000Z\", \"is_transaction\": null}, \"old\": {\"id\": 79, \"code\": 124101, \"name\": \"Inventory\", \"type\": \"asset\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 40, \"created_at\": \"2026-09-05T07:23:59.000000Z\", \"updated_at\": \"2026-09-05T07:23:59.000000Z\", \"is_transaction\": null}}', '2026-09-05 01:24:34'),
(89, 1, 'Created Account Module', '3', '{\"data\": {\"id\": 3, \"created_at\": \"2026-09-05T07:25:36.000000Z\", \"entry_type\": \"Product Wastage\", \"module_key\": \"inventory\", \"updated_at\": \"2026-09-05T07:25:36.000000Z\", \"feature_key\": \"product_wastage\", \"module_name\": \"Product Wastage Voucher\"}, \"module_entry_id\": 3}', '2026-09-05 01:25:36'),
(90, 1, 'Created Chart Of Account', '421101', '{\"data\": {\"id\": 80, \"code\": 421101, \"name\": \"Tax\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 68, \"created_at\": \"2026-09-05T07:29:11.000000Z\", \"updated_at\": \"2026-09-05T07:29:11.000000Z\"}}', '2026-09-05 01:29:11'),
(91, 1, 'Created Chart Of Account', '421102', '{\"data\": {\"id\": 81, \"code\": 421102, \"name\": \"Vat\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 68, \"created_at\": \"2026-09-05T07:29:43.000000Z\", \"updated_at\": \"2026-09-05T07:29:43.000000Z\"}}', '2026-09-05 01:29:43'),
(92, 1, 'Created Chart Of Account', '440000', '{\"data\": {\"id\": 82, \"code\": 440000, \"name\": \"Miscellaneous Expense\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 4, \"created_at\": \"2026-09-05T07:36:16.000000Z\", \"updated_at\": \"2026-09-05T07:36:16.000000Z\"}}', '2026-09-05 01:36:16'),
(93, 1, 'Created Chart Of Account', '441000', '{\"data\": {\"id\": 83, \"code\": 441000, \"name\": \"Miscellaneous Expense\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 82, \"created_at\": \"2026-09-05T07:36:22.000000Z\", \"updated_at\": \"2026-09-05T07:36:22.000000Z\"}}', '2026-09-05 01:36:22'),
(94, 1, 'Created Chart Of Account', '441100', '{\"data\": {\"id\": 84, \"code\": 441100, \"name\": \"Miscellaneous Expense\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 83, \"created_at\": \"2026-09-05T07:36:26.000000Z\", \"updated_at\": \"2026-09-05T07:36:26.000000Z\"}}', '2026-09-05 01:36:26'),
(95, 1, 'Created Chart Of Account', '441101', '{\"data\": {\"id\": 85, \"code\": 441101, \"name\": \"Miscellaneous Expense\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 84, \"created_at\": \"2026-09-05T07:36:31.000000Z\", \"updated_at\": \"2026-09-05T07:36:31.000000Z\"}}', '2026-09-05 01:36:31'),
(96, 1, 'Updated Chart Of Account', '441101', '{\"id\": \"85\", \"new\": {\"id\": 85, \"code\": 441101, \"name\": \"Wastage Expense\", \"type\": \"expense\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 84, \"created_at\": \"2026-09-05T07:36:31.000000Z\", \"updated_at\": \"2026-09-05T07:47:43.000000Z\", \"is_transaction\": null}, \"old\": {\"id\": 85, \"code\": 441101, \"name\": \"Miscellaneous Expense\", \"type\": \"expense\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 84, \"created_at\": \"2026-09-05T07:36:31.000000Z\", \"updated_at\": \"2026-09-05T07:36:31.000000Z\", \"is_transaction\": null}}', '2026-09-05 01:47:43'),
(97, 1, 'Updated Account Module', '3', '{\"new\": {\"accounts\": [{\"is_debit\": true, \"component\": \"stock_wastage\", \"description\": \"Stock wastage expense.\", \"account_head_id\": 85}, {\"is_debit\": false, \"component\": \"inventory_wastage\", \"description\": \"Inventory value reduction.\", \"account_head_id\": 79}], \"entry_type\": \"Product Wastage\", \"module_key\": \"inventory\", \"feature_key\": \"product_wastage\", \"module_name\": \"Product Wastage Voucher\"}, \"old\": {\"id\": 3, \"status\": true, \"accounts\": [{\"id\": 5, \"is_debit\": 1, \"component\": \"stock_wastage\", \"created_at\": \"2026-09-05T07:25:36.000000Z\", \"updated_at\": \"2026-09-05T07:25:36.000000Z\", \"description\": \"Stock wastage expense.\", \"account_head_id\": 78, \"module_entry_id\": 3}, {\"id\": 6, \"is_debit\": 0, \"component\": \"inventory_wastage\", \"created_at\": \"2026-09-05T07:25:36.000000Z\", \"updated_at\": \"2026-09-05T07:25:36.000000Z\", \"description\": \"Inventory value reduction.\", \"account_head_id\": 79, \"module_entry_id\": 3}], \"created_at\": \"2026-09-05T07:25:36.000000Z\", \"entry_type\": \"Product Wastage\", \"module_key\": \"inventory\", \"updated_at\": \"2026-09-05T07:25:36.000000Z\", \"description\": null, \"feature_key\": \"product_wastage\", \"module_name\": \"Product Wastage Voucher\"}, \"module_entry_id\": 3}', '2026-09-05 01:48:07'),
(98, 1, 'Created Chart Of Account', '441102', '{\"data\": {\"id\": 86, \"code\": 441102, \"name\": \"Sales Discount\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 84, \"created_at\": \"2026-09-05T07:51:00.000000Z\", \"updated_at\": \"2026-09-05T07:51:00.000000Z\"}}', '2026-09-05 01:51:00'),
(99, 1, 'Created Account Module', '4', '{\"data\": {\"id\": 4, \"created_at\": \"2026-09-05T07:52:43.000000Z\", \"entry_type\": \"Customer Payment Voucher\", \"module_key\": \"inventory\", \"updated_at\": \"2026-09-05T07:52:43.000000Z\", \"feature_key\": \"customer_due_payment\", \"module_name\": \"Customer Due Payment\"}, \"module_entry_id\": 4}', '2026-09-05 01:52:43'),
(100, 1, 'Created Chart Of Account', '441103', '{\"data\": {\"id\": 87, \"code\": 441103, \"name\": \"Purchase Adjustment\", \"type\": \"expense\", \"status\": true, \"is_debit\": true, \"parent_id\": 84, \"created_at\": \"2026-09-05T07:56:12.000000Z\", \"updated_at\": \"2026-09-05T07:56:12.000000Z\"}}', '2026-09-05 01:56:12'),
(101, 1, 'Updated Chart Of Account', '441103', '{\"id\": \"87\", \"new\": {\"id\": 87, \"code\": 441103, \"name\": \"Sales Adjustment\", \"type\": \"expense\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 84, \"created_at\": \"2026-09-05T07:56:12.000000Z\", \"updated_at\": \"2026-09-05T07:56:54.000000Z\", \"is_transaction\": null}, \"old\": {\"id\": 87, \"code\": 441103, \"name\": \"Purchase Adjustment\", \"type\": \"expense\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 84, \"created_at\": \"2026-09-05T07:56:12.000000Z\", \"updated_at\": \"2026-09-05T07:56:12.000000Z\", \"is_transaction\": null}}', '2026-09-05 01:56:55'),
(102, 1, 'Updated Chart Of Account', '441103', '{\"id\": \"87\", \"new\": {\"id\": 87, \"code\": 441103, \"name\": \"Purchase Adjustment\", \"type\": \"expense\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 84, \"created_at\": \"2026-09-05T07:56:12.000000Z\", \"updated_at\": \"2026-09-05T08:07:48.000000Z\", \"is_transaction\": null}, \"old\": {\"id\": 87, \"code\": 441103, \"name\": \"Sales Adjustment\", \"type\": \"expense\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 84, \"created_at\": \"2026-09-05T07:56:12.000000Z\", \"updated_at\": \"2026-09-05T07:56:54.000000Z\", \"is_transaction\": null}}', '2026-09-05 02:07:48'),
(103, 1, 'Created Chart Of Account', '330000', '{\"data\": {\"id\": 88, \"code\": 330000, \"name\": \"Others Income\", \"type\": \"income\", \"status\": true, \"is_debit\": false, \"parent_id\": 3, \"created_at\": \"2026-09-05T08:08:39.000000Z\", \"updated_at\": \"2026-09-05T08:08:39.000000Z\"}}', '2026-09-05 02:08:39'),
(104, 1, 'Created Chart Of Account', '331000', '{\"data\": {\"id\": 89, \"code\": 331000, \"name\": \"Others Income\", \"type\": \"income\", \"status\": true, \"is_debit\": false, \"parent_id\": 88, \"created_at\": \"2026-09-05T08:08:58.000000Z\", \"updated_at\": \"2026-09-05T08:08:58.000000Z\"}}', '2026-09-05 02:08:58'),
(105, 1, 'Created Chart Of Account', '331100', '{\"data\": {\"id\": 90, \"code\": 331100, \"name\": \"Others Income\", \"type\": \"income\", \"status\": true, \"is_debit\": false, \"parent_id\": 89, \"created_at\": \"2026-09-05T08:09:11.000000Z\", \"updated_at\": \"2026-09-05T08:09:11.000000Z\"}}', '2026-09-05 02:09:11'),
(106, 1, 'Created Chart Of Account', '331101', '{\"data\": {\"id\": 91, \"code\": 331101, \"name\": \"Purchase Discount\", \"type\": \"income\", \"status\": true, \"is_debit\": false, \"parent_id\": 90, \"created_at\": \"2026-09-05T08:09:17.000000Z\", \"updated_at\": \"2026-09-05T08:09:17.000000Z\"}}', '2026-09-05 02:09:17'),
(107, 1, 'Created Account Module', '5', '{\"data\": {\"id\": 5, \"created_at\": \"2026-09-05T08:09:41.000000Z\", \"entry_type\": \"Purchase Voucher\", \"module_key\": \"inventory\", \"updated_at\": \"2026-09-05T08:09:41.000000Z\", \"feature_key\": \"purchase\", \"module_name\": \"Purchase Voucher\"}, \"module_entry_id\": 5}', '2026-09-05 02:09:41'),
(108, 1, 'Updated Chart Of Account', '123101', '{\"id\": \"56\", \"new\": {\"id\": 56, \"code\": 123101, \"name\": \"Supplier Advance\", \"type\": \"asset\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 39, \"created_at\": \"2026-09-05T06:47:23.000000Z\", \"updated_at\": \"2026-09-05T08:13:40.000000Z\", \"is_transaction\": null}, \"old\": {\"id\": 56, \"code\": 123101, \"name\": \"Supplier Adance\", \"type\": \"asset\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 39, \"created_at\": \"2026-09-05T06:47:23.000000Z\", \"updated_at\": \"2026-09-05T06:47:23.000000Z\", \"is_transaction\": null}}', '2026-09-05 02:13:40'),
(109, 1, 'Created Account Module', '6', '{\"data\": {\"id\": 6, \"created_at\": \"2026-09-05T08:25:19.000000Z\", \"entry_type\": \"Supplier Advance\", \"module_key\": \"inventory\", \"updated_at\": \"2026-09-05T08:25:19.000000Z\", \"feature_key\": \"supplier_advance\", \"module_name\": \"Supplier Advance\"}, \"module_entry_id\": 6}', '2026-09-05 02:25:19'),
(110, 1, 'Created Purchase Voucher Entry', 'REF-000001', '{\"data\": {\"id\": 1, \"date\": \"2026-09-05\", \"debit\": 683.53, \"lines\": {\"inventory\": {\"debit\": 650, \"credit\": 0, \"remarks\": \"Inventory value increase.\", \"ledger_account_id\": 78}, \"adjustment\": {\"debit\": 2, \"credit\": 0, \"remarks\": \"Rounding or other adjustment.\", \"ledger_account_id\": 87}, \"due_amount\": {\"debit\": 0, \"credit\": 64.03, \"remarks\": \"Supplier outstanding due.\", \"ledger_account_id\": 63}, \"tax_amount\": {\"debit\": 31.53, \"credit\": 0, \"remarks\": \"Purchase tax or VAT.\", \"ledger_account_id\": 80}, \"paid_amount\": {\"debit\": 0, \"credit\": 600, \"remarks\": \"Amount paid to supplier.\", \"ledger_account_id\": 53}, \"discount_amount\": {\"debit\": 0, \"credit\": 19.5, \"remarks\": \"Supplier discount.\", \"ledger_account_id\": 91}}, \"credit\": 683.53, \"module\": \"inventory\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000001\", \"source_id\": 130, \"created_at\": \"2026-09-05T09:24:25.000000Z\", \"created_by\": 1, \"updated_at\": \"2026-09-05T09:24:25.000000Z\", \"voucher_no\": \"PV-000001\", \"source_type\": \"purchase\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 1}', '2026-09-05 03:24:25'),
(111, 1, 'Created Chart Of Account', '331102', '{\"data\": {\"id\": 92, \"code\": 331102, \"name\": \"Purchase Adjustments\", \"type\": \"income\", \"status\": true, \"is_debit\": false, \"parent_id\": 90, \"created_at\": \"2026-09-05T09:42:35.000000Z\", \"updated_at\": \"2026-09-05T09:42:35.000000Z\"}}', '2026-09-05 03:42:35'),
(112, 1, 'Updated Chart Of Account', '441103', '{\"id\": \"87\", \"new\": {\"id\": 87, \"code\": 441103, \"name\": \"Sales Adjustment\", \"type\": \"expense\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 84, \"created_at\": \"2026-09-05T07:56:12.000000Z\", \"updated_at\": \"2026-09-05T09:42:47.000000Z\", \"is_transaction\": null}, \"old\": {\"id\": 87, \"code\": 441103, \"name\": \"Purchase Adjustment\", \"type\": \"expense\", \"status\": true, \"remarks\": null, \"is_debit\": true, \"branch_id\": null, \"parent_id\": 84, \"created_at\": \"2026-09-05T07:56:12.000000Z\", \"updated_at\": \"2026-09-05T08:07:48.000000Z\", \"is_transaction\": null}}', '2026-09-05 03:42:47'),
(113, 1, 'Updated Account Module', '5', '{\"new\": {\"accounts\": [{\"is_debit\": true, \"component\": \"inventory\", \"description\": \"Inventory value increase.\", \"account_head_id\": 78}, {\"is_debit\": true, \"component\": \"tax_amount\", \"description\": \"Purchase tax or VAT.\", \"account_head_id\": 80}, {\"is_debit\": false, \"component\": \"adjustment\", \"description\": \"Rounding or other adjustment.\", \"account_head_id\": 92}, {\"is_debit\": false, \"component\": \"discount_amount\", \"description\": \"Supplier discount.\", \"account_head_id\": 91}, {\"is_debit\": false, \"component\": \"paid_amount\", \"description\": \"Amount paid to supplier.\", \"account_head_id\": 53}, {\"is_debit\": false, \"component\": \"supplier_advance\", \"description\": \"Supplier advance adjustment.\", \"account_head_id\": 56}, {\"is_debit\": false, \"component\": \"due_amount\", \"description\": \"Supplier outstanding due.\", \"account_head_id\": 63}], \"entry_type\": \"Purchase Voucher\", \"module_key\": \"inventory\", \"feature_key\": \"purchase\", \"module_name\": \"Purchase Voucher\"}, \"old\": {\"id\": 5, \"status\": true, \"accounts\": [{\"id\": 12, \"is_debit\": 1, \"component\": \"inventory\", \"created_at\": \"2026-09-05T08:09:41.000000Z\", \"updated_at\": \"2026-09-05T08:09:41.000000Z\", \"description\": \"Inventory value increase.\", \"account_head_id\": 78, \"module_entry_id\": 5}, {\"id\": 13, \"is_debit\": 1, \"component\": \"tax_amount\", \"created_at\": \"2026-09-05T08:09:41.000000Z\", \"updated_at\": \"2026-09-05T08:09:41.000000Z\", \"description\": \"Purchase tax or VAT.\", \"account_head_id\": 80, \"module_entry_id\": 5}, {\"id\": 14, \"is_debit\": 1, \"component\": \"adjustment\", \"created_at\": \"2026-09-05T08:09:41.000000Z\", \"updated_at\": \"2026-09-05T08:09:41.000000Z\", \"description\": \"Rounding or other adjustment.\", \"account_head_id\": 87, \"module_entry_id\": 5}, {\"id\": 15, \"is_debit\": 0, \"component\": \"discount_amount\", \"created_at\": \"2026-09-05T08:09:41.000000Z\", \"updated_at\": \"2026-09-05T08:09:41.000000Z\", \"description\": \"Supplier discount.\", \"account_head_id\": 91, \"module_entry_id\": 5}, {\"id\": 16, \"is_debit\": 0, \"component\": \"paid_amount\", \"created_at\": \"2026-09-05T08:09:41.000000Z\", \"updated_at\": \"2026-09-05T08:09:41.000000Z\", \"description\": \"Amount paid to supplier.\", \"account_head_id\": 53, \"module_entry_id\": 5}, {\"id\": 17, \"is_debit\": 0, \"component\": \"supplier_advance\", \"created_at\": \"2026-09-05T08:09:41.000000Z\", \"updated_at\": \"2026-09-05T08:09:41.000000Z\", \"description\": \"Supplier advance adjustment.\", \"account_head_id\": 56, \"module_entry_id\": 5}, {\"id\": 18, \"is_debit\": 0, \"component\": \"due_amount\", \"created_at\": \"2026-09-05T08:09:41.000000Z\", \"updated_at\": \"2026-09-05T08:09:41.000000Z\", \"description\": \"Supplier outstanding due.\", \"account_head_id\": 63, \"module_entry_id\": 5}], \"created_at\": \"2026-09-05T08:09:41.000000Z\", \"entry_type\": \"Purchase Voucher\", \"module_key\": \"inventory\", \"updated_at\": \"2026-09-05T08:09:41.000000Z\", \"description\": null, \"feature_key\": \"purchase\", \"module_name\": \"Purchase Voucher\"}, \"module_entry_id\": 5}', '2026-09-05 03:44:24'),
(115, 1, 'Created Purchase Voucher Entry', 'REF-000002', '{\"data\": {\"id\": 2, \"date\": \"2026-09-05\", \"debit\": 430, \"lines\": {\"inventory\": {\"debit\": 400, \"credit\": 0, \"remarks\": \"Inventory value increase.\", \"ledger_account_id\": 78}, \"adjustment\": {\"debit\": 0, \"credit\": 10, \"remarks\": \"Rounding or other adjustment.\", \"ledger_account_id\": 92}, \"due_amount\": {\"debit\": 0, \"credit\": 100, \"remarks\": \"Supplier outstanding due.\", \"ledger_account_id\": 63}, \"tax_amount\": {\"debit\": 30, \"credit\": 0, \"remarks\": \"Purchase tax or VAT.\", \"ledger_account_id\": 80}, \"paid_amount\": {\"debit\": 0, \"credit\": 300, \"remarks\": \"Amount paid to supplier.\", \"ledger_account_id\": 53}, \"discount_amount\": {\"debit\": 0, \"credit\": 20, \"remarks\": \"Supplier discount.\", \"ledger_account_id\": 91}}, \"credit\": 430, \"module\": \"inventory\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000002\", \"source_id\": 137, \"created_at\": \"2026-09-05T09:59:04.000000Z\", \"created_by\": 1, \"updated_at\": \"2026-09-05T09:59:04.000000Z\", \"voucher_no\": \"PV-000002\", \"source_type\": \"purchase\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 2}', '2026-09-05 03:59:04'),
(116, 1, 'Created Chart Of Account', '322000', '{\"data\": {\"id\": 93, \"code\": 322000, \"name\": \"Tax & Vat\", \"type\": \"income\", \"status\": true, \"is_debit\": false, \"parent_id\": 10, \"created_at\": \"2026-09-05T10:06:12.000000Z\", \"updated_at\": \"2026-09-05T10:06:12.000000Z\"}}', '2026-09-05 04:06:12'),
(117, 1, 'Created Chart Of Account', '322100', '{\"data\": {\"id\": 94, \"code\": 322100, \"name\": \"Sales Tax\", \"type\": \"income\", \"status\": true, \"is_debit\": false, \"parent_id\": 93, \"created_at\": \"2026-09-05T10:06:25.000000Z\", \"updated_at\": \"2026-09-05T10:06:25.000000Z\"}}', '2026-09-05 04:06:25'),
(118, 1, 'Created Chart Of Account', '321101', '{\"data\": {\"id\": 93, \"code\": 321101, \"name\": \"Bank Interest\", \"type\": \"income\", \"status\": true, \"is_debit\": false, \"parent_id\": 66, \"created_at\": \"2026-09-05T10:09:51.000000Z\", \"updated_at\": \"2026-09-05T10:09:51.000000Z\"}}', '2026-09-05 04:09:51');
INSERT INTO `acc_audit_logs` (`id`, `user_id`, `action`, `source_ref`, `details`, `created_at`) VALUES
(119, 1, 'Created Chart Of Account', '222102', '{\"data\": {\"id\": 94, \"code\": 222102, \"name\": \"Tax & Vat\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 44, \"created_at\": \"2026-09-05T10:10:51.000000Z\", \"updated_at\": \"2026-09-05T10:10:51.000000Z\"}}', '2026-09-05 04:10:51'),
(120, 1, 'Updated Chart Of Account', '222102', '{\"id\": \"94\", \"new\": {\"id\": 94, \"code\": 222102, \"name\": \"Others\", \"type\": \"equity_liability\", \"status\": true, \"remarks\": null, \"is_debit\": false, \"branch_id\": null, \"parent_id\": 44, \"created_at\": \"2026-09-05T10:10:51.000000Z\", \"updated_at\": \"2026-09-05T10:11:07.000000Z\", \"is_transaction\": null}, \"old\": {\"id\": 94, \"code\": 222102, \"name\": \"Tax & Vat\", \"type\": \"equity_liability\", \"status\": true, \"remarks\": null, \"is_debit\": false, \"branch_id\": null, \"parent_id\": 44, \"created_at\": \"2026-09-05T10:10:51.000000Z\", \"updated_at\": \"2026-09-05T10:10:51.000000Z\", \"is_transaction\": null}}', '2026-09-05 04:11:07'),
(121, 1, 'Created Chart Of Account', '222200', '{\"data\": {\"id\": 95, \"code\": 222200, \"name\": \"Tax & Vat\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 24, \"created_at\": \"2026-09-05T10:11:17.000000Z\", \"updated_at\": \"2026-09-05T10:11:17.000000Z\"}}', '2026-09-05 04:11:17'),
(122, 1, 'Created Chart Of Account', '222201', '{\"data\": {\"id\": 96, \"code\": 222201, \"name\": \"Tax\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 95, \"created_at\": \"2026-09-05T10:11:24.000000Z\", \"updated_at\": \"2026-09-05T10:11:24.000000Z\"}}', '2026-09-05 04:11:24'),
(123, 1, 'Created Chart Of Account', '222202', '{\"data\": {\"id\": 97, \"code\": 222202, \"name\": \"Vat\", \"type\": \"equity_liability\", \"status\": true, \"is_debit\": false, \"parent_id\": 95, \"created_at\": \"2026-09-05T10:11:33.000000Z\", \"updated_at\": \"2026-09-05T10:11:33.000000Z\"}}', '2026-09-05 04:11:33'),
(124, 1, 'Created Account Module', '7', '{\"data\": {\"id\": 7, \"created_at\": \"2026-09-05T10:16:20.000000Z\", \"entry_type\": \"Sales Voucher\", \"module_key\": \"inventory\", \"updated_at\": \"2026-09-05T10:16:20.000000Z\", \"feature_key\": \"sales\", \"module_name\": \"Sales Voucher\"}, \"module_entry_id\": 7}', '2026-09-05 04:16:20'),
(125, 1, 'Updated Account Module', '7', '{\"new\": {\"accounts\": [{\"is_debit\": true, \"component\": \"paid_amount\", \"description\": \"Amount paid by customer.\", \"account_head_id\": 53}, {\"is_debit\": true, \"component\": \"customer_advance\", \"description\": \"Customer advance adjustment.\", \"account_head_id\": 72}, {\"is_debit\": true, \"component\": \"due_amount\", \"description\": \"Customer outstanding due.\", \"account_head_id\": 55}, {\"is_debit\": false, \"component\": \"discount_amount\", \"description\": \"Customer discount.\", \"account_head_id\": 86}, {\"is_debit\": false, \"component\": \"tax_amount\", \"description\": \"Sales tax or VAT.\", \"account_head_id\": 96}, {\"is_debit\": false, \"component\": \"adjustment\", \"description\": \"Rounding or other adjustment.\", \"account_head_id\": 87}], \"entry_type\": \"Sales Voucher\", \"module_key\": \"inventory\", \"feature_key\": \"sale\", \"module_name\": \"Sales Voucher\"}, \"old\": {\"id\": 7, \"status\": true, \"accounts\": [{\"id\": 28, \"is_debit\": 1, \"component\": \"paid_amount\", \"created_at\": \"2026-09-05T10:16:20.000000Z\", \"updated_at\": \"2026-09-05T10:16:20.000000Z\", \"description\": \"Amount paid by customer.\", \"account_head_id\": 53, \"module_entry_id\": 7}, {\"id\": 29, \"is_debit\": 1, \"component\": \"discount_amount\", \"created_at\": \"2026-09-05T10:16:20.000000Z\", \"updated_at\": \"2026-09-05T10:16:20.000000Z\", \"description\": \"Customer discount.\", \"account_head_id\": 86, \"module_entry_id\": 7}, {\"id\": 30, \"is_debit\": 1, \"component\": \"customer_advance\", \"created_at\": \"2026-09-05T10:16:20.000000Z\", \"updated_at\": \"2026-09-05T10:16:20.000000Z\", \"description\": \"Customer advance adjustment.\", \"account_head_id\": 72, \"module_entry_id\": 7}, {\"id\": 31, \"is_debit\": 1, \"component\": \"due_amount\", \"created_at\": \"2026-09-05T10:16:20.000000Z\", \"updated_at\": \"2026-09-05T10:16:20.000000Z\", \"description\": \"Customer outstanding due.\", \"account_head_id\": 55, \"module_entry_id\": 7}, {\"id\": 32, \"is_debit\": 0, \"component\": \"tax_amount\", \"created_at\": \"2026-09-05T10:16:20.000000Z\", \"updated_at\": \"2026-09-05T10:16:20.000000Z\", \"description\": \"Sales tax or VAT.\", \"account_head_id\": 96, \"module_entry_id\": 7}, {\"id\": 33, \"is_debit\": 0, \"component\": \"adjustment\", \"created_at\": \"2026-09-05T10:16:20.000000Z\", \"updated_at\": \"2026-09-05T10:16:20.000000Z\", \"description\": \"Rounding or other adjustment.\", \"account_head_id\": 87, \"module_entry_id\": 7}], \"created_at\": \"2026-09-05T10:16:20.000000Z\", \"entry_type\": \"Sales Voucher\", \"module_key\": \"inventory\", \"updated_at\": \"2026-09-05T10:16:20.000000Z\", \"description\": null, \"feature_key\": \"sale\", \"module_name\": \"Sales Voucher\"}, \"module_entry_id\": 7}', '2026-09-05 04:45:37'),
(126, 1, 'Updated Account Module', '7', '{\"new\": {\"accounts\": [{\"is_debit\": true, \"component\": \"paid_amount\", \"description\": \"Amount paid by customer.\", \"account_head_id\": 53}, {\"is_debit\": true, \"component\": \"customer_advance\", \"description\": \"Customer advance adjustment.\", \"account_head_id\": 72}, {\"is_debit\": true, \"component\": \"due_amount\", \"description\": \"Customer outstanding due.\", \"account_head_id\": 55}, {\"is_debit\": false, \"component\": \"sales_amount\", \"description\": null, \"account_head_id\": 77}, {\"is_debit\": false, \"component\": \"discount_amount\", \"description\": \"Customer discount.\", \"account_head_id\": 86}, {\"is_debit\": false, \"component\": \"tax_amount\", \"description\": \"Sales tax or VAT.\", \"account_head_id\": 96}, {\"is_debit\": false, \"component\": \"adjustment\", \"description\": \"Rounding or other adjustment.\", \"account_head_id\": 87}], \"entry_type\": \"Sales Voucher\", \"module_key\": \"inventory\", \"feature_key\": \"sale\", \"module_name\": \"Sales Voucher\"}, \"old\": {\"id\": 7, \"status\": true, \"accounts\": [{\"id\": 34, \"is_debit\": 1, \"component\": \"paid_amount\", \"created_at\": \"2026-09-05T10:45:37.000000Z\", \"updated_at\": \"2026-09-05T10:45:37.000000Z\", \"description\": \"Amount paid by customer.\", \"account_head_id\": 53, \"module_entry_id\": 7}, {\"id\": 35, \"is_debit\": 1, \"component\": \"customer_advance\", \"created_at\": \"2026-09-05T10:45:37.000000Z\", \"updated_at\": \"2026-09-05T10:45:37.000000Z\", \"description\": \"Customer advance adjustment.\", \"account_head_id\": 72, \"module_entry_id\": 7}, {\"id\": 36, \"is_debit\": 1, \"component\": \"due_amount\", \"created_at\": \"2026-09-05T10:45:37.000000Z\", \"updated_at\": \"2026-09-05T10:45:37.000000Z\", \"description\": \"Customer outstanding due.\", \"account_head_id\": 55, \"module_entry_id\": 7}, {\"id\": 37, \"is_debit\": 0, \"component\": \"discount_amount\", \"created_at\": \"2026-09-05T10:45:37.000000Z\", \"updated_at\": \"2026-09-05T10:45:37.000000Z\", \"description\": \"Customer discount.\", \"account_head_id\": 86, \"module_entry_id\": 7}, {\"id\": 38, \"is_debit\": 0, \"component\": \"tax_amount\", \"created_at\": \"2026-09-05T10:45:37.000000Z\", \"updated_at\": \"2026-09-05T10:45:37.000000Z\", \"description\": \"Sales tax or VAT.\", \"account_head_id\": 96, \"module_entry_id\": 7}, {\"id\": 39, \"is_debit\": 0, \"component\": \"adjustment\", \"created_at\": \"2026-09-05T10:45:37.000000Z\", \"updated_at\": \"2026-09-05T10:45:37.000000Z\", \"description\": \"Rounding or other adjustment.\", \"account_head_id\": 87, \"module_entry_id\": 7}], \"created_at\": \"2026-09-05T10:16:20.000000Z\", \"entry_type\": \"Sales Voucher\", \"module_key\": \"inventory\", \"updated_at\": \"2026-09-05T10:16:20.000000Z\", \"description\": null, \"feature_key\": \"sale\", \"module_name\": \"Sales Voucher\"}, \"module_entry_id\": 7}', '2026-09-05 04:48:06'),
(127, 1, 'Updated Account Module', '7', '{\"new\": {\"accounts\": [{\"is_debit\": true, \"component\": \"paid_amount\", \"description\": \"Amount paid by customer.\", \"account_head_id\": 53}, {\"is_debit\": true, \"component\": \"customer_advance\", \"description\": \"Customer advance adjustment.\", \"account_head_id\": 72}, {\"is_debit\": true, \"component\": \"due_amount\", \"description\": \"Customer outstanding due.\", \"account_head_id\": 55}, {\"is_debit\": true, \"component\": \"discount_amount\", \"description\": \"Customer discount.\", \"account_head_id\": 86}, {\"is_debit\": true, \"component\": \"adjustment\", \"description\": \"Rounding or other adjustment.\", \"account_head_id\": 87}, {\"is_debit\": false, \"component\": \"sales_amount\", \"description\": null, \"account_head_id\": 77}, {\"is_debit\": false, \"component\": \"tax_amount\", \"description\": \"Sales tax or VAT.\", \"account_head_id\": 96}], \"entry_type\": \"Sales Voucher\", \"module_key\": \"inventory\", \"feature_key\": \"sale\", \"module_name\": \"Sales Voucher\"}, \"old\": {\"id\": 7, \"status\": true, \"accounts\": [{\"id\": 40, \"is_debit\": 1, \"component\": \"paid_amount\", \"created_at\": \"2026-09-05T10:48:06.000000Z\", \"updated_at\": \"2026-09-05T10:48:06.000000Z\", \"description\": \"Amount paid by customer.\", \"account_head_id\": 53, \"module_entry_id\": 7}, {\"id\": 41, \"is_debit\": 1, \"component\": \"customer_advance\", \"created_at\": \"2026-09-05T10:48:06.000000Z\", \"updated_at\": \"2026-09-05T10:48:06.000000Z\", \"description\": \"Customer advance adjustment.\", \"account_head_id\": 72, \"module_entry_id\": 7}, {\"id\": 42, \"is_debit\": 1, \"component\": \"due_amount\", \"created_at\": \"2026-09-05T10:48:06.000000Z\", \"updated_at\": \"2026-09-05T10:48:06.000000Z\", \"description\": \"Customer outstanding due.\", \"account_head_id\": 55, \"module_entry_id\": 7}, {\"id\": 43, \"is_debit\": 0, \"component\": \"sales_amount\", \"created_at\": \"2026-09-05T10:48:06.000000Z\", \"updated_at\": \"2026-09-05T10:48:06.000000Z\", \"description\": null, \"account_head_id\": 77, \"module_entry_id\": 7}, {\"id\": 44, \"is_debit\": 0, \"component\": \"discount_amount\", \"created_at\": \"2026-09-05T10:48:06.000000Z\", \"updated_at\": \"2026-09-05T10:48:06.000000Z\", \"description\": \"Customer discount.\", \"account_head_id\": 86, \"module_entry_id\": 7}, {\"id\": 45, \"is_debit\": 0, \"component\": \"tax_amount\", \"created_at\": \"2026-09-05T10:48:06.000000Z\", \"updated_at\": \"2026-09-05T10:48:06.000000Z\", \"description\": \"Sales tax or VAT.\", \"account_head_id\": 96, \"module_entry_id\": 7}, {\"id\": 46, \"is_debit\": 0, \"component\": \"adjustment\", \"created_at\": \"2026-09-05T10:48:06.000000Z\", \"updated_at\": \"2026-09-05T10:48:06.000000Z\", \"description\": \"Rounding or other adjustment.\", \"account_head_id\": 87, \"module_entry_id\": 7}], \"created_at\": \"2026-09-05T10:16:20.000000Z\", \"entry_type\": \"Sales Voucher\", \"module_key\": \"inventory\", \"updated_at\": \"2026-09-05T10:16:20.000000Z\", \"description\": null, \"feature_key\": \"sale\", \"module_name\": \"Sales Voucher\"}, \"module_entry_id\": 7}', '2026-09-05 04:57:09'),
(128, 1, 'Created Sales Voucher Entry', 'REF-000003', '{\"data\": {\"id\": 3, \"date\": \"2026-09-05\", \"debit\": 1800, \"lines\": {\"adjustment\": {\"debit\": 40, \"credit\": 0, \"remarks\": \"Rounding or other adjustment.\", \"ledger_account_id\": 87}, \"due_amount\": {\"debit\": 200, \"credit\": 0, \"remarks\": \"Customer outstanding due.\", \"ledger_account_id\": 55}, \"tax_amount\": {\"debit\": 0, \"credit\": 200, \"remarks\": \"Sales tax or VAT.\", \"ledger_account_id\": 96}, \"paid_amount\": {\"debit\": 1500, \"credit\": 0, \"remarks\": \"Amount paid by customer.\", \"ledger_account_id\": 53}, \"sales_amount\": {\"debit\": 0, \"credit\": 1600, \"remarks\": null, \"ledger_account_id\": 77}, \"discount_amount\": {\"debit\": 60, \"credit\": 0, \"remarks\": \"Customer discount.\", \"ledger_account_id\": 86}}, \"credit\": 1800, \"module\": \"inventory\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Sales Voucher\", \"reference\": \"REF-000003\", \"source_id\": 48, \"created_at\": \"2026-09-05T10:57:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2026-09-05T10:57:23.000000Z\", \"voucher_no\": \"SV-000001\", \"source_type\": \"sale\", \"voucher_type\": \"Sales Voucher\"}, \"journal_entry_id\": 3}', '2026-09-05 04:57:23');

-- --------------------------------------------------------

--
-- Table structure for table `acc_journal_entries`
--

CREATE TABLE `acc_journal_entries` (
  `id` bigint UNSIGNED NOT NULL,
  `voucher_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date NOT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `voucher_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_id` bigint UNSIGNED DEFAULT NULL,
  `narration` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED NOT NULL,
  `approved_by` bigint UNSIGNED DEFAULT NULL,
  `debit` decimal(16,2) NOT NULL DEFAULT '0.00',
  `credit` decimal(16,2) NOT NULL DEFAULT '0.00',
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `acc_journal_entries`
--

INSERT INTO `acc_journal_entries` (`id`, `voucher_type`, `date`, `reference`, `voucher_no`, `module`, `source_type`, `source_id`, `narration`, `created_by`, `approved_by`, `debit`, `credit`, `status`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 'Purchase Voucher', '2026-09-05', 'REF-000001', 'PV-000001', 'inventory', 'purchase', 130, 'Purchase Voucher', 1, NULL, 683.53, 683.53, 'pending', 1, '2026-09-05 03:24:25', '2026-09-05 03:24:25'),
(2, 'Purchase Voucher', '2026-09-05', 'REF-000002', 'PV-000002', 'inventory', 'purchase', 137, 'Purchase Voucher', 1, NULL, 430.00, 430.00, 'pending', 1, '2026-09-05 03:59:04', '2026-09-05 03:59:04'),
(3, 'Sales Voucher', '2026-09-05', 'REF-000003', 'SV-000001', 'inventory', 'sale', 48, 'Sales Voucher', 1, NULL, 1800.00, 1800.00, 'pending', 1, '2026-09-05 04:57:23', '2026-09-05 04:57:23');

-- --------------------------------------------------------

--
-- Table structure for table `acc_journal_entry_details`
--

CREATE TABLE `acc_journal_entry_details` (
  `id` bigint UNSIGNED NOT NULL,
  `journal_entry_id` bigint UNSIGNED NOT NULL,
  `account_type_id` bigint UNSIGNED NOT NULL,
  `account_category_id` bigint UNSIGNED NOT NULL,
  `control_group_id` bigint UNSIGNED NOT NULL,
  `ledger_group_id` bigint UNSIGNED NOT NULL,
  `ledger_account_id` bigint UNSIGNED NOT NULL,
  `debit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `credit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `remarks` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `acc_journal_entry_details`
--

INSERT INTO `acc_journal_entry_details` (`id`, `journal_entry_id`, `account_type_id`, `account_category_id`, `control_group_id`, `ledger_group_id`, `ledger_account_id`, `debit`, `credit`, `remarks`, `created_at`, `updated_at`) VALUES
(1, 1, 4, 11, 27, 67, 78, 650.00, 0.00, 'Inventory value increase.', '2026-09-05 03:24:25', '2026-09-05 03:24:25'),
(2, 1, 4, 12, 28, 68, 80, 31.53, 0.00, 'Purchase tax or VAT.', '2026-09-05 03:24:25', '2026-09-05 03:24:25'),
(3, 1, 4, 82, 83, 84, 87, 2.00, 0.00, 'Rounding or other adjustment.', '2026-09-05 03:24:25', '2026-09-05 03:24:25'),
(4, 1, 3, 88, 89, 90, 91, 0.00, 19.50, 'Supplier discount.', '2026-09-05 03:24:25', '2026-09-05 03:24:25'),
(5, 1, 1, 6, 17, 36, 53, 0.00, 600.00, 'Amount paid to supplier.', '2026-09-05 03:24:25', '2026-09-05 03:24:25'),
(6, 1, 2, 8, 23, 43, 63, 0.00, 64.03, 'Supplier outstanding due.', '2026-09-05 03:24:25', '2026-09-05 03:24:25'),
(7, 2, 4, 11, 27, 67, 78, 400.00, 0.00, 'Inventory value increase.', '2026-09-05 03:59:04', '2026-09-05 03:59:04'),
(8, 2, 4, 12, 28, 68, 80, 30.00, 0.00, 'Purchase tax or VAT.', '2026-09-05 03:59:04', '2026-09-05 03:59:04'),
(9, 2, 3, 88, 89, 90, 92, 0.00, 10.00, 'Rounding or other adjustment.', '2026-09-05 03:59:04', '2026-09-05 03:59:04'),
(10, 2, 3, 88, 89, 90, 91, 0.00, 20.00, 'Supplier discount.', '2026-09-05 03:59:04', '2026-09-05 03:59:04'),
(11, 2, 1, 6, 17, 36, 53, 0.00, 300.00, 'Amount paid to supplier.', '2026-09-05 03:59:04', '2026-09-05 03:59:04'),
(12, 2, 2, 8, 23, 43, 63, 0.00, 100.00, 'Supplier outstanding due.', '2026-09-05 03:59:04', '2026-09-05 03:59:04'),
(13, 3, 1, 6, 17, 36, 53, 1500.00, 0.00, 'Amount paid by customer.', '2026-09-05 04:57:23', '2026-09-05 04:57:23'),
(14, 3, 1, 6, 18, 38, 55, 200.00, 0.00, 'Customer outstanding due.', '2026-09-05 04:57:23', '2026-09-05 04:57:23'),
(15, 3, 4, 82, 83, 84, 86, 60.00, 0.00, 'Customer discount.', '2026-09-05 04:57:23', '2026-09-05 04:57:23'),
(16, 3, 4, 82, 83, 84, 87, 40.00, 0.00, 'Rounding or other adjustment.', '2026-09-05 04:57:23', '2026-09-05 04:57:23'),
(17, 3, 3, 9, 25, 65, 77, 0.00, 1600.00, NULL, '2026-09-05 04:57:23', '2026-09-05 04:57:23'),
(18, 3, 2, 8, 24, 95, 96, 0.00, 200.00, 'Sales tax or VAT.', '2026-09-05 04:57:23', '2026-09-05 04:57:23');

-- --------------------------------------------------------

--
-- Table structure for table `acc_module_entries`
--

CREATE TABLE `acc_module_entries` (
  `id` bigint UNSIGNED NOT NULL,
  `module_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feature_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Module name like sales, purchase, etc.',
  `entry_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Entry type like invoice, bill, etc.',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `acc_module_entries`
--

INSERT INTO `acc_module_entries` (`id`, `module_key`, `feature_key`, `module_name`, `entry_type`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'inventory', 'customer_advance', 'Customer Advance', 'Customer Advance', NULL, 1, '2026-09-05 00:57:22', '2026-09-05 00:57:22'),
(2, 'inventory', 'customer_previous_due', 'Customer Previous Due', 'Customer Previous Due', NULL, 1, '2026-09-05 01:18:47', '2026-09-05 01:18:47'),
(3, 'inventory', 'product_wastage', 'Product Wastage Voucher', 'Product Wastage', NULL, 1, '2026-09-05 01:25:36', '2026-09-05 01:25:36'),
(4, 'inventory', 'customer_due_payment', 'Customer Due Payment', 'Customer Payment Voucher', NULL, 1, '2026-09-05 01:52:43', '2026-09-05 01:52:43'),
(5, 'inventory', 'purchase', 'Purchase Voucher', 'Purchase Voucher', NULL, 1, '2026-09-05 02:09:41', '2026-09-05 02:09:41'),
(6, 'inventory', 'supplier_advance', 'Supplier Advance', 'Supplier Advance', NULL, 1, '2026-09-05 02:25:19', '2026-09-05 02:25:19'),
(7, 'inventory', 'sale', 'Sales Voucher', 'Sales Voucher', NULL, 1, '2026-09-05 04:16:20', '2026-09-05 04:16:20');

-- --------------------------------------------------------

--
-- Table structure for table `acc_module_entry_accounts`
--

CREATE TABLE `acc_module_entry_accounts` (
  `id` bigint UNSIGNED NOT NULL,
  `module_entry_id` bigint UNSIGNED NOT NULL,
  `component` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Component name like revenue, vat, discount',
  `account_head_id` bigint UNSIGNED NOT NULL,
  `is_debit` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'True = debit, False = credit',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `acc_module_entry_accounts`
--

INSERT INTO `acc_module_entry_accounts` (`id`, `module_entry_id`, `component`, `account_head_id`, `is_debit`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 'amount', 53, 1, 'Advance received from customer.', '2026-09-05 00:57:22', '2026-09-05 00:57:22'),
(2, 1, 'customer_advance', 72, 0, 'Customer advance liability.', '2026-09-05 00:57:22', '2026-09-05 00:57:22'),
(3, 2, 'previous_due', 55, 1, 'Customer opening due.', '2026-09-05 01:18:47', '2026-09-05 01:18:47'),
(4, 2, 'opening_balance', 77, 0, 'Opening balance adjustment.', '2026-09-05 01:18:47', '2026-09-05 01:18:47'),
(7, 3, 'stock_wastage', 85, 1, 'Stock wastage expense.', '2026-09-05 01:48:07', '2026-09-05 01:48:07'),
(8, 3, 'inventory_wastage', 79, 0, 'Inventory value reduction.', '2026-09-05 01:48:07', '2026-09-05 01:48:07'),
(9, 4, 'payment', 53, 1, 'Customer due payment.', '2026-09-05 01:52:43', '2026-09-05 01:52:43'),
(10, 4, 'adjustment', 86, 1, 'Payment adjustment.', '2026-09-05 01:52:43', '2026-09-05 01:52:43'),
(11, 4, 'total_amount', 55, 0, 'Total settled amount.', '2026-09-05 01:52:43', '2026-09-05 01:52:43'),
(19, 6, 'amount', 53, 1, 'Advance paid to supplier.', '2026-09-05 02:25:19', '2026-09-05 02:25:19'),
(20, 6, 'supplier_advance', 56, 0, 'Supplier advance asset.', '2026-09-05 02:25:19', '2026-09-05 02:25:19'),
(21, 5, 'inventory', 78, 1, 'Inventory value increase.', '2026-09-05 03:44:24', '2026-09-05 03:44:24'),
(22, 5, 'tax_amount', 80, 1, 'Purchase tax or VAT.', '2026-09-05 03:44:24', '2026-09-05 03:44:24'),
(23, 5, 'adjustment', 92, 0, 'Rounding or other adjustment.', '2026-09-05 03:44:24', '2026-09-05 03:44:24'),
(24, 5, 'discount_amount', 91, 0, 'Supplier discount.', '2026-09-05 03:44:24', '2026-09-05 03:44:24'),
(25, 5, 'paid_amount', 53, 0, 'Amount paid to supplier.', '2026-09-05 03:44:24', '2026-09-05 03:44:24'),
(26, 5, 'supplier_advance', 56, 0, 'Supplier advance adjustment.', '2026-09-05 03:44:24', '2026-09-05 03:44:24'),
(27, 5, 'due_amount', 63, 0, 'Supplier outstanding due.', '2026-09-05 03:44:24', '2026-09-05 03:44:24'),
(47, 7, 'paid_amount', 53, 1, 'Amount paid by customer.', '2026-09-05 04:57:09', '2026-09-05 04:57:09'),
(48, 7, 'customer_advance', 72, 1, 'Customer advance adjustment.', '2026-09-05 04:57:09', '2026-09-05 04:57:09'),
(49, 7, 'due_amount', 55, 1, 'Customer outstanding due.', '2026-09-05 04:57:09', '2026-09-05 04:57:09'),
(50, 7, 'discount_amount', 86, 1, 'Customer discount.', '2026-09-05 04:57:09', '2026-09-05 04:57:09'),
(51, 7, 'adjustment', 87, 1, 'Rounding or other adjustment.', '2026-09-05 04:57:09', '2026-09-05 04:57:09'),
(52, 7, 'sales_amount', 77, 0, NULL, '2026-09-05 04:57:09', '2026-09-05 04:57:09'),
(53, 7, 'tax_amount', 96, 0, 'Sales tax or VAT.', '2026-09-05 04:57:09', '2026-09-05 04:57:09');

-- --------------------------------------------------------

--
-- Table structure for table `acc_voucher_types`
--

CREATE TABLE `acc_voucher_types` (
  `id` bigint UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_manual` tinyint DEFAULT NULL,
  `is_active` tinyint DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `acc_voucher_types`
--

INSERT INTO `acc_voucher_types` (`id`, `code`, `name`, `description`, `is_manual`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'receipt', 'Receipt Voucher', 'Incoming', 1, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(2, 'payment', 'Payment Voucher', 'Outgoing', 1, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(3, 'journal', 'Journal Voucher', 'Non Cash', 1, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(4, 'contra', 'Contra Voucher', 'Cash to bank or bank to cash', 1, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02');

-- --------------------------------------------------------

--
-- Table structure for table `admin_menus`
--

CREATE TABLE `admin_menus` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module_id` bigint UNSIGNED NOT NULL,
  `route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `sequence` int NOT NULL DEFAULT '0',
  `permission_route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_menus`
--

INSERT INTO `admin_menus` (`id`, `title`, `module_id`, `route`, `icon`, `parent_id`, `sequence`, `permission_route`, `status`, `created_at`, `updated_at`) VALUES
(44, 'Setting', 1, NULL, 'fas fa-cog', NULL, 1, NULL, 1, '2025-08-03 17:47:02', '2025-08-24 07:03:29'),
(45, 'User Manager', 1, 'core/users', NULL, 44, 1, 'api.core.users.index', 1, '2025-08-03 17:49:49', '2025-08-05 22:43:07'),
(46, 'Permissions', 1, 'core/permissions', NULL, 44, 4, 'api.core.permission.sections', 1, '2025-08-03 17:53:14', '2025-08-05 22:43:07'),
(47, 'Role Manager', 1, 'core/roles', NULL, 44, 2, 'api.core.roles.index', 1, '2025-08-03 17:54:19', '2025-08-05 22:43:07'),
(48, 'Settings Manage', 1, 'core/settings', NULL, 44, 6, 'api.core.settings.update', 1, '2025-08-03 17:58:01', '2025-08-05 22:43:07'),
(49, 'Module Manage', 1, 'core/modules', NULL, 44, 5, 'api.core.modules.index', 1, '2025-08-03 17:59:34', '2025-08-05 22:43:07'),
(50, 'Admin Menu', 1, 'core/admin-menus', NULL, 44, 3, 'api.core.admin-menus.index', 1, '2025-08-03 18:01:23', '2025-08-05 22:43:07'),
(51, 'Branch', 1, 'core/branches', NULL, 44, 7, 'api.core.branches.index', 1, '2025-08-25 00:20:56', '2025-08-25 00:20:56'),
(52, 'Setting', 2, NULL, 'fas fa-cog', NULL, 6, NULL, 1, '2025-08-26 03:46:56', '2026-07-08 23:33:12'),
(53, 'Category', 2, 'inventory/categories', NULL, 52, 3, 'api.inventory.categories.index', 1, '2025-08-26 03:47:35', '2026-07-08 23:33:12'),
(54, 'Unit', 2, 'inventory/units', NULL, 52, 4, 'api.inventory.units.index', 1, '2025-08-26 04:20:41', '2026-07-08 23:33:12'),
(55, 'Brand', 2, 'inventory/brands', NULL, 52, 5, 'api.inventory.brands.index', 1, '2025-08-26 04:23:25', '2026-07-08 23:33:12'),
(56, 'Supplier', 2, NULL, 'fas fa-warehouse', NULL, 3, NULL, 1, '2025-08-28 03:17:14', '2026-07-08 23:33:12'),
(57, 'Customer', 2, NULL, 'fas fa-users', NULL, 4, NULL, 1, '2025-08-28 03:17:51', '2026-07-08 23:33:12'),
(58, 'Supplier', 2, 'inventory/suppliers', NULL, 56, 1, 'api.inventory.suppliers.index', 1, '2025-08-28 03:28:45', '2026-07-08 23:33:12'),
(59, 'Customer', 2, 'inventory/customers', NULL, 57, 1, 'api.inventory.customers.index', 1, '2025-08-28 03:40:36', '2026-07-08 23:33:12'),
(60, 'Product', 2, 'inventory/products', NULL, 52, 1, 'api.inventory.products.index', 1, '2025-08-28 04:18:23', '2026-07-08 23:33:12'),
(61, 'Product Set', 2, 'inventory/product-sets', NULL, 52, 2, 'api.inventory.product-sets.index', 1, '2025-09-04 03:28:43', '2026-07-08 23:33:12'),
(62, 'Chart of Accounts', 3, 'accounting/chart-of-accounts', 'fas fa-chart-line', NULL, 3, 'api.accounting.chart-of-accounts.index', 1, '2025-09-08 00:56:47', '2025-09-11 00:18:27'),
(63, 'Voucher Posting', 3, 'accounting/voucher-posting', 'fas fa-receipt', NULL, 1, 'api.accounting.journal-entries.index', 1, '2025-09-10 00:52:25', '2025-09-11 00:18:27'),
(64, 'Account Module', 3, 'accounting/account-modules', 'fas fa-project-diagram', NULL, 2, 'api.accounting.account-modules.index', 1, '2025-09-11 00:17:57', '2025-09-11 00:18:27'),
(65, 'Supplier Advance', 2, 'inventory/supplier-advance', NULL, 56, 2, 'api.inventory.supplier-advance.index', 1, '2025-09-23 04:54:19', '2026-07-08 23:33:12'),
(66, 'Purchase', 2, 'inventory/purchases', 'fas fa-shopping-bag', NULL, 2, 'api.inventory.purchases.index', 1, '2025-11-04 03:13:07', '2026-07-08 23:33:12'),
(67, 'Purchase', 2, 'inventory/purchases', NULL, 66, 1, 'api.inventory.purchases.index', 1, '2025-11-04 03:15:56', '2026-07-08 23:33:12'),
(68, 'Customer Advance', 2, 'inventory/customer-advance', NULL, 57, 2, 'api.inventory.supplier-advance.index', 1, '2026-04-30 04:48:39', '2026-07-08 23:33:12'),
(69, 'Sales', 2, NULL, 'fas fa-cart-arrow-down', NULL, 1, NULL, 1, '2026-04-30 04:57:10', '2026-07-08 23:33:12'),
(70, 'POS', 2, 'inventory/pos', NULL, 69, 1, 'api.inventory.purchases.index', 1, '2026-04-30 04:58:38', '2026-08-08 02:01:10'),
(71, 'Sales Manager', 2, 'inventory/sales', NULL, 69, 2, 'api.inventory.purchases.index', 1, '2026-05-02 03:51:01', '2026-07-08 23:33:12'),
(72, 'Sale Return', 2, 'inventory/sale-return', NULL, 69, 3, 'api.inventory.purchases.index', 1, '2026-05-06 01:33:22', '2026-07-08 23:33:12'),
(73, 'Due Payment', 2, 'inventory/customer-due-payment', NULL, 57, 3, 'api.inventory.purchases.index', 1, '2026-06-06 01:28:13', '2026-07-08 23:33:12'),
(74, 'Due Payment', 2, 'inventory/supplier-due-payment', NULL, 56, 3, 'api.inventory.purchases.index', 1, '2026-06-12 22:35:00', '2026-07-08 23:33:12'),
(75, 'Purchase Return', 2, 'inventory/purchase-return', NULL, 66, 2, 'api.inventory.purchases.index', 1, '2026-06-15 02:53:12', '2026-07-08 23:33:12'),
(76, 'Stock Manage', 2, 'fas fa-boxes', NULL, NULL, 5, NULL, 1, '2026-07-08 23:33:06', '2026-07-08 23:34:07'),
(77, 'Stock Transfer', 2, 'inventory/stock-transfers', NULL, 76, 1, 'api.inventory.purchases.index', 1, '2026-07-08 23:36:11', '2026-07-08 23:36:11'),
(78, 'Product Wastage', 2, 'inventory/product-wastages', NULL, 76, 2, 'api.inventory.purchases.index', 1, '2026-07-12 06:06:03', '2026-07-12 06:06:03'),
(79, 'Supplier Ledger', 2, 'inventory/suppliers/ledger', NULL, 56, 4, 'api.inventory.purchases.index', 1, '2026-07-20 05:06:41', '2026-07-20 05:06:41'),
(80, 'Customer Ledger', 2, 'inventory/customers/ledger', NULL, 57, 4, 'api.inventory.purchases.index', 1, '2026-07-20 05:08:04', '2026-07-20 05:08:04'),
(81, 'All Stock Report', 2, 'inventory/reports/product-stocks', NULL, 76, 3, 'api.inventory.purchases.index', 1, '2026-08-04 03:34:20', '2026-08-04 03:34:20'),
(82, 'Product Stock Ledger', 2, 'inventory/reports/product-stock-ledger', NULL, 76, 4, 'api.inventory.purchases.index', 1, '2026-08-06 00:05:01', '2026-08-06 00:05:01'),
(83, 'Customer Due List', 2, 'inventory/reports/customer-due-list', NULL, 57, 5, 'api.inventory.purchases.index', 1, '2026-08-06 06:18:32', '2026-08-06 06:18:32'),
(84, 'Supplier Due List', 2, 'inventory/reports/supplier-due-list', NULL, 56, 5, 'api.inventory.purchases.index', 1, '2026-08-06 07:23:09', '2026-08-08 01:04:27'),
(85, 'Departments', 4, 'hrm/departments', 'fas fa-building', 94, 1, 'api.inventory.purchases.index', 1, '2026-08-22 01:48:57', '2026-08-29 03:46:03'),
(86, 'Designations', 4, 'hrm/designations', 'fas fa-id-badge', 94, 2, 'api.inventory.purchases.index', 1, '2026-08-22 01:52:12', '2026-08-29 03:46:03'),
(87, 'Genders', 4, 'hrm/genders', 'fas fa-venus-mars', 94, 3, 'api.inventory.purchases.index', 1, '2026-08-22 01:54:54', '2026-08-29 03:46:03'),
(88, 'Religions', 4, 'hrm/religions', 'fas fa-praying-hands', 94, 5, 'api.inventory.purchases.index', 1, '2026-08-22 01:57:47', '2026-08-29 03:46:03'),
(89, 'Shifts', 4, 'hrm/shifts', 'fas fa-business-time', 94, 6, 'api.inventory.purchases.index', 1, '2026-08-22 02:00:07', '2026-08-29 03:46:03'),
(90, 'Employee Category', 4, 'hrm/employee-categories', 'fas fa-user-tie', 95, 1, 'api.inventory.purchases.index', 1, '2026-08-22 02:02:40', '2026-08-29 03:46:03'),
(91, 'Employee Types', 4, 'hrm/employee-types', 'fas fa-user-tag', 95, 2, 'api.inventory.purchases.index', 1, '2026-08-22 02:08:57', '2026-08-29 03:46:03'),
(92, 'Employee Status', 4, 'hrm/employee-status', 'fas fa-user-check', 95, 3, 'api.inventory.purchases.index', 1, '2026-08-22 02:10:45', '2026-08-29 03:46:03'),
(93, 'Blood Group', 4, 'hrm/blood-group', 'fas fa-tint', 94, 4, 'api.inventory.purchases.index', 1, '2026-08-22 02:14:16', '2026-08-29 03:46:03'),
(94, 'HRM Setup', 4, '#', 'fas fa-tools', NULL, 2, NULL, 1, '2026-08-22 02:25:22', '2026-08-29 03:46:03'),
(95, 'Employee Setup', 4, '#', 'fas fa-user-cog', NULL, 3, NULL, 1, '2026-08-22 02:27:35', '2026-08-29 03:46:03'),
(96, 'Employees', 4, 'hrm/employees', 'fas fa-user-tie', NULL, 1, 'api.inventory.purchases.index', 1, '2026-08-22 03:35:24', '2026-08-29 03:46:03'),
(97, 'Leave Manager', 4, '#', 'fas fa-calendar-alt', NULL, 4, 'api.inventory.purchases.index', 1, '2026-08-29 03:32:59', '2026-08-29 03:46:03'),
(98, 'Leave Category', 4, 'hrm/leave-categories', 'fas fa-calendar-check', 97, 2, 'api.inventory.purchases.index', 1, '2026-08-29 03:36:45', '2026-08-29 03:46:03'),
(99, 'Leave List', 4, 'hrm/leave-list', 'fas fa-calendar-week', 97, 1, 'api.inventory.purchases.index', 1, '2026-08-29 03:45:45', '2026-08-29 03:46:03');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `contact_no`, `logo`, `created_at`, `updated_at`) VALUES
(1, 'Branch Office', '01700000004', '/storage/core/branch/xnZqsBXPX9A9RGS9ZKs1Z5JiNxor9HKjRkybHaz0.jpg', '2025-08-24 04:08:36', '2025-09-03 04:58:52'),
(2, 'Head Office', '01700000003', '/storage/core/branch/sRy7cyOdrsWrcpTivScoh5j65qfYhMd3dNEdJDK4.png', '2025-08-25 00:14:48', '2025-08-26 00:40:34');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('world_vision_enterprice_cache_spatie.permission.cache', 'a:3:{s:5:\"alias\";a:8:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:12:\"display_name\";s:1:\"d\";s:10:\"guard_name\";s:1:\"e\";s:8:\"group_id\";s:1:\"r\";s:5:\"roles\";s:1:\"j\";s:12:\"redirect_url\";s:1:\"k\";s:9:\"direction\";}s:11:\"permissions\";a:101:{i:0;a:6:{s:1:\"a\";i:1;s:1:\"b\";s:19:\"api.core.user-menus\";s:1:\"c\";s:19:\"Api Core User-menus\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:1;s:1:\"r\";a:1:{i:0;i:1;}}i:1;a:6:{s:1:\"a\";i:2;s:1:\"b\";s:24:\"api.core.settings.update\";s:1:\"c\";s:24:\"Api Core Settings Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:2;s:1:\"r\";a:1:{i:0;i:1;}}i:2;a:6:{s:1:\"a\";i:3;s:1:\"b\";s:20:\"api.core.users.index\";s:1:\"c\";s:20:\"Api Core Users Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:3;s:1:\"r\";a:1:{i:0;i:1;}}i:3;a:6:{s:1:\"a\";i:4;s:1:\"b\";s:20:\"api.core.users.store\";s:1:\"c\";s:20:\"Api Core Users Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:3;s:1:\"r\";a:1:{i:0;i:1;}}i:4;a:6:{s:1:\"a\";i:5;s:1:\"b\";s:19:\"api.core.users.show\";s:1:\"c\";s:19:\"Api Core Users Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:3;s:1:\"r\";a:1:{i:0;i:1;}}i:5;a:6:{s:1:\"a\";i:6;s:1:\"b\";s:21:\"api.core.users.update\";s:1:\"c\";s:21:\"Api Core Users Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:3;s:1:\"r\";a:1:{i:0;i:1;}}i:6;a:6:{s:1:\"a\";i:7;s:1:\"b\";s:22:\"api.core.users.destroy\";s:1:\"c\";s:22:\"Api Core Users Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:3;s:1:\"r\";a:1:{i:0;i:1;}}i:7;a:6:{s:1:\"a\";i:8;s:1:\"b\";s:20:\"api.core.roles.index\";s:1:\"c\";s:20:\"Api Core Roles Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:4;s:1:\"r\";a:1:{i:0;i:1;}}i:8;a:6:{s:1:\"a\";i:9;s:1:\"b\";s:20:\"api.core.roles.store\";s:1:\"c\";s:20:\"Api Core Roles Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:4;s:1:\"r\";a:1:{i:0;i:1;}}i:9;a:6:{s:1:\"a\";i:10;s:1:\"b\";s:19:\"api.core.roles.show\";s:1:\"c\";s:19:\"Api Core Roles Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:4;s:1:\"r\";a:1:{i:0;i:1;}}i:10;a:6:{s:1:\"a\";i:11;s:1:\"b\";s:21:\"api.core.roles.update\";s:1:\"c\";s:21:\"Api Core Roles Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:4;s:1:\"r\";a:1:{i:0;i:1;}}i:11;a:6:{s:1:\"a\";i:12;s:1:\"b\";s:22:\"api.core.roles.destroy\";s:1:\"c\";s:22:\"Api Core Roles Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:4;s:1:\"r\";a:1:{i:0;i:1;}}i:12;a:6:{s:1:\"a\";i:13;s:1:\"b\";s:22:\"api.core.modules.index\";s:1:\"c\";s:22:\"Api Core Modules Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:5;s:1:\"r\";a:1:{i:0;i:1;}}i:13;a:6:{s:1:\"a\";i:14;s:1:\"b\";s:22:\"api.core.modules.store\";s:1:\"c\";s:22:\"Api Core Modules Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:5;s:1:\"r\";a:1:{i:0;i:1;}}i:14;a:6:{s:1:\"a\";i:15;s:1:\"b\";s:21:\"api.core.modules.show\";s:1:\"c\";s:21:\"Api Core Modules Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:5;s:1:\"r\";a:1:{i:0;i:1;}}i:15;a:6:{s:1:\"a\";i:16;s:1:\"b\";s:23:\"api.core.modules.update\";s:1:\"c\";s:23:\"Api Core Modules Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:5;s:1:\"r\";a:1:{i:0;i:1;}}i:16;a:6:{s:1:\"a\";i:17;s:1:\"b\";s:24:\"api.core.modules.destroy\";s:1:\"c\";s:24:\"Api Core Modules Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:5;s:1:\"r\";a:1:{i:0;i:1;}}i:17;a:6:{s:1:\"a\";i:18;s:1:\"b\";s:27:\"api.core.admin-menus.parent\";s:1:\"c\";s:27:\"Api Core Admin-menus Parent\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:6;s:1:\"r\";a:1:{i:0;i:1;}}i:18;a:6:{s:1:\"a\";i:19;s:1:\"b\";s:28:\"api.core.admin-menus.reorder\";s:1:\"c\";s:28:\"Api Core Admin-menus Reorder\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:6;s:1:\"r\";a:1:{i:0;i:1;}}i:19;a:6:{s:1:\"a\";i:20;s:1:\"b\";s:26:\"api.core.admin-menus.index\";s:1:\"c\";s:26:\"Api Core Admin-menus Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:6;s:1:\"r\";a:1:{i:0;i:1;}}i:20;a:6:{s:1:\"a\";i:21;s:1:\"b\";s:26:\"api.core.admin-menus.store\";s:1:\"c\";s:26:\"Api Core Admin-menus Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:6;s:1:\"r\";a:1:{i:0;i:1;}}i:21;a:6:{s:1:\"a\";i:22;s:1:\"b\";s:25:\"api.core.admin-menus.show\";s:1:\"c\";s:25:\"Api Core Admin-menus Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:6;s:1:\"r\";a:1:{i:0;i:1;}}i:22;a:6:{s:1:\"a\";i:23;s:1:\"b\";s:27:\"api.core.admin-menus.update\";s:1:\"c\";s:27:\"Api Core Admin-menus Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:6;s:1:\"r\";a:1:{i:0;i:1;}}i:23;a:6:{s:1:\"a\";i:24;s:1:\"b\";s:28:\"api.core.admin-menus.destroy\";s:1:\"c\";s:28:\"Api Core Admin-menus Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:6;s:1:\"r\";a:1:{i:0;i:1;}}i:24;a:6:{s:1:\"a\";i:25;s:1:\"b\";s:28:\"api.core.permission.sections\";s:1:\"c\";s:28:\"Api Core Permission Sections\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:7;s:1:\"r\";a:1:{i:0;i:1;}}i:25;a:6:{s:1:\"a\";i:26;s:1:\"b\";s:31:\"api.core.permission.permissions\";s:1:\"c\";s:31:\"Api Core Permission Permissions\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:7;s:1:\"r\";a:1:{i:0;i:1;}}i:26;a:6:{s:1:\"a\";i:27;s:1:\"b\";s:25:\"api.core.permission.store\";s:1:\"c\";s:25:\"Api Core Permission Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:7;s:1:\"r\";a:1:{i:0;i:1;}}i:27;a:6:{s:1:\"a\";i:28;s:1:\"b\";s:26:\"api.core.permission.assign\";s:1:\"c\";s:26:\"Api Core Permission Assign\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:7;s:1:\"r\";a:1:{i:0;i:1;}}i:28;a:6:{s:1:\"a\";i:30;s:1:\"b\";s:23:\"api.core.branches.index\";s:1:\"c\";s:23:\"Api Core Branches Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:9;s:1:\"r\";a:1:{i:0;i:1;}}i:29;a:6:{s:1:\"a\";i:31;s:1:\"b\";s:23:\"api.core.branches.store\";s:1:\"c\";s:23:\"Api Core Branches Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:9;s:1:\"r\";a:1:{i:0;i:1;}}i:30;a:6:{s:1:\"a\";i:32;s:1:\"b\";s:22:\"api.core.branches.show\";s:1:\"c\";s:22:\"Api Core Branches Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:9;s:1:\"r\";a:1:{i:0;i:1;}}i:31;a:6:{s:1:\"a\";i:33;s:1:\"b\";s:24:\"api.core.branches.update\";s:1:\"c\";s:24:\"Api Core Branches Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:9;s:1:\"r\";a:1:{i:0;i:1;}}i:32;a:6:{s:1:\"a\";i:34;s:1:\"b\";s:25:\"api.core.branches.destroy\";s:1:\"c\";s:25:\"Api Core Branches Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:9;s:1:\"r\";a:1:{i:0;i:1;}}i:33;a:6:{s:1:\"a\";i:36;s:1:\"b\";s:20:\"api.core..food-lists\";s:1:\"c\";s:20:\"Api Core  Food-lists\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:10;s:1:\"r\";a:1:{i:0;i:1;}}i:34;a:6:{s:1:\"a\";i:37;s:1:\"b\";s:9:\"api.core.\";s:1:\"c\";s:9:\"Api Core \";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:10;s:1:\"r\";a:1:{i:0;i:1;}}i:35;a:6:{s:1:\"a\";i:38;s:1:\"b\";s:30:\"api.inventory.categories.index\";s:1:\"c\";s:30:\"Api Inventory Categories Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:11;s:1:\"r\";a:1:{i:0;i:1;}}i:36;a:6:{s:1:\"a\";i:39;s:1:\"b\";s:30:\"api.inventory.categories.store\";s:1:\"c\";s:30:\"Api Inventory Categories Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:11;s:1:\"r\";a:1:{i:0;i:1;}}i:37;a:6:{s:1:\"a\";i:40;s:1:\"b\";s:29:\"api.inventory.categories.show\";s:1:\"c\";s:29:\"Api Inventory Categories Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:11;s:1:\"r\";a:1:{i:0;i:1;}}i:38;a:6:{s:1:\"a\";i:41;s:1:\"b\";s:31:\"api.inventory.categories.update\";s:1:\"c\";s:31:\"Api Inventory Categories Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:11;s:1:\"r\";a:1:{i:0;i:1;}}i:39;a:6:{s:1:\"a\";i:42;s:1:\"b\";s:32:\"api.inventory.categories.destroy\";s:1:\"c\";s:32:\"Api Inventory Categories Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:11;s:1:\"r\";a:1:{i:0;i:1;}}i:40;a:6:{s:1:\"a\";i:43;s:1:\"b\";s:25:\"api.inventory.units.index\";s:1:\"c\";s:25:\"Api Inventory Units Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:12;s:1:\"r\";a:1:{i:0;i:1;}}i:41;a:6:{s:1:\"a\";i:44;s:1:\"b\";s:25:\"api.inventory.units.store\";s:1:\"c\";s:25:\"Api Inventory Units Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:12;s:1:\"r\";a:1:{i:0;i:1;}}i:42;a:6:{s:1:\"a\";i:45;s:1:\"b\";s:24:\"api.inventory.units.show\";s:1:\"c\";s:24:\"Api Inventory Units Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:12;s:1:\"r\";a:1:{i:0;i:1;}}i:43;a:6:{s:1:\"a\";i:46;s:1:\"b\";s:26:\"api.inventory.units.update\";s:1:\"c\";s:26:\"Api Inventory Units Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:12;s:1:\"r\";a:1:{i:0;i:1;}}i:44;a:6:{s:1:\"a\";i:47;s:1:\"b\";s:27:\"api.inventory.units.destroy\";s:1:\"c\";s:27:\"Api Inventory Units Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:12;s:1:\"r\";a:1:{i:0;i:1;}}i:45;a:6:{s:1:\"a\";i:48;s:1:\"b\";s:26:\"api.inventory.brands.index\";s:1:\"c\";s:26:\"Api Inventory Brands Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:13;s:1:\"r\";a:1:{i:0;i:1;}}i:46;a:6:{s:1:\"a\";i:49;s:1:\"b\";s:26:\"api.inventory.brands.store\";s:1:\"c\";s:26:\"Api Inventory Brands Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:13;s:1:\"r\";a:1:{i:0;i:1;}}i:47;a:6:{s:1:\"a\";i:50;s:1:\"b\";s:25:\"api.inventory.brands.show\";s:1:\"c\";s:25:\"Api Inventory Brands Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:13;s:1:\"r\";a:1:{i:0;i:1;}}i:48;a:6:{s:1:\"a\";i:51;s:1:\"b\";s:27:\"api.inventory.brands.update\";s:1:\"c\";s:27:\"Api Inventory Brands Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:13;s:1:\"r\";a:1:{i:0;i:1;}}i:49;a:6:{s:1:\"a\";i:52;s:1:\"b\";s:28:\"api.inventory.brands.destroy\";s:1:\"c\";s:28:\"Api Inventory Brands Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:13;s:1:\"r\";a:1:{i:0;i:1;}}i:50;a:6:{s:1:\"a\";i:53;s:1:\"b\";s:28:\"api.inventory.products.index\";s:1:\"c\";s:28:\"Api Inventory Products Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:14;s:1:\"r\";a:1:{i:0;i:1;}}i:51;a:6:{s:1:\"a\";i:54;s:1:\"b\";s:28:\"api.inventory.products.store\";s:1:\"c\";s:28:\"Api Inventory Products Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:14;s:1:\"r\";a:1:{i:0;i:1;}}i:52;a:6:{s:1:\"a\";i:55;s:1:\"b\";s:27:\"api.inventory.products.show\";s:1:\"c\";s:27:\"Api Inventory Products Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:14;s:1:\"r\";a:1:{i:0;i:1;}}i:53;a:6:{s:1:\"a\";i:56;s:1:\"b\";s:29:\"api.inventory.products.update\";s:1:\"c\";s:29:\"Api Inventory Products Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:14;s:1:\"r\";a:1:{i:0;i:1;}}i:54;a:6:{s:1:\"a\";i:57;s:1:\"b\";s:30:\"api.inventory.products.destroy\";s:1:\"c\";s:30:\"Api Inventory Products Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:14;s:1:\"r\";a:1:{i:0;i:1;}}i:55;a:6:{s:1:\"a\";i:58;s:1:\"b\";s:29:\"api.inventory.suppliers.index\";s:1:\"c\";s:29:\"Api Inventory Suppliers Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:15;s:1:\"r\";a:1:{i:0;i:1;}}i:56;a:6:{s:1:\"a\";i:59;s:1:\"b\";s:29:\"api.inventory.suppliers.store\";s:1:\"c\";s:29:\"Api Inventory Suppliers Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:15;s:1:\"r\";a:1:{i:0;i:1;}}i:57;a:6:{s:1:\"a\";i:60;s:1:\"b\";s:28:\"api.inventory.suppliers.show\";s:1:\"c\";s:28:\"Api Inventory Suppliers Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:15;s:1:\"r\";a:1:{i:0;i:1;}}i:58;a:6:{s:1:\"a\";i:61;s:1:\"b\";s:30:\"api.inventory.suppliers.update\";s:1:\"c\";s:30:\"Api Inventory Suppliers Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:15;s:1:\"r\";a:1:{i:0;i:1;}}i:59;a:6:{s:1:\"a\";i:62;s:1:\"b\";s:31:\"api.inventory.suppliers.destroy\";s:1:\"c\";s:31:\"Api Inventory Suppliers Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:15;s:1:\"r\";a:1:{i:0;i:1;}}i:60;a:6:{s:1:\"a\";i:63;s:1:\"b\";s:29:\"api.inventory.customers.index\";s:1:\"c\";s:29:\"Api Inventory Customers Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:16;s:1:\"r\";a:1:{i:0;i:1;}}i:61;a:6:{s:1:\"a\";i:64;s:1:\"b\";s:29:\"api.inventory.customers.store\";s:1:\"c\";s:29:\"Api Inventory Customers Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:16;s:1:\"r\";a:1:{i:0;i:1;}}i:62;a:6:{s:1:\"a\";i:65;s:1:\"b\";s:28:\"api.inventory.customers.show\";s:1:\"c\";s:28:\"Api Inventory Customers Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:16;s:1:\"r\";a:1:{i:0;i:1;}}i:63;a:6:{s:1:\"a\";i:66;s:1:\"b\";s:30:\"api.inventory.customers.update\";s:1:\"c\";s:30:\"Api Inventory Customers Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:16;s:1:\"r\";a:1:{i:0;i:1;}}i:64;a:6:{s:1:\"a\";i:67;s:1:\"b\";s:31:\"api.inventory.customers.destroy\";s:1:\"c\";s:31:\"Api Inventory Customers Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:16;s:1:\"r\";a:1:{i:0;i:1;}}i:65;a:6:{s:1:\"a\";i:68;s:1:\"b\";s:32:\"api.inventory.product-sets.index\";s:1:\"c\";s:32:\"Api Inventory Product-sets Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:17;s:1:\"r\";a:1:{i:0;i:1;}}i:66;a:6:{s:1:\"a\";i:69;s:1:\"b\";s:32:\"api.inventory.product-sets.store\";s:1:\"c\";s:32:\"Api Inventory Product-sets Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:17;s:1:\"r\";a:1:{i:0;i:1;}}i:67;a:6:{s:1:\"a\";i:70;s:1:\"b\";s:31:\"api.inventory.product-sets.show\";s:1:\"c\";s:31:\"Api Inventory Product-sets Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:17;s:1:\"r\";a:1:{i:0;i:1;}}i:68;a:6:{s:1:\"a\";i:71;s:1:\"b\";s:33:\"api.inventory.product-sets.update\";s:1:\"c\";s:33:\"Api Inventory Product-sets Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:17;s:1:\"r\";a:1:{i:0;i:1;}}i:69;a:6:{s:1:\"a\";i:72;s:1:\"b\";s:34:\"api.inventory.product-sets.destroy\";s:1:\"c\";s:34:\"Api Inventory Product-sets Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:17;s:1:\"r\";a:1:{i:0;i:1;}}i:70;a:6:{s:1:\"a\";i:73;s:1:\"b\";s:38:\"api.accounting.chart-of-accounts.index\";s:1:\"c\";s:38:\"Api Accounting Chart-of-accounts Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:18;s:1:\"r\";a:1:{i:0;i:1;}}i:71;a:6:{s:1:\"a\";i:74;s:1:\"b\";s:38:\"api.accounting.chart-of-accounts.store\";s:1:\"c\";s:38:\"Api Accounting Chart-of-accounts Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:18;s:1:\"r\";a:1:{i:0;i:1;}}i:72;a:6:{s:1:\"a\";i:75;s:1:\"b\";s:37:\"api.accounting.chart-of-accounts.show\";s:1:\"c\";s:37:\"Api Accounting Chart-of-accounts Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:18;s:1:\"r\";a:1:{i:0;i:1;}}i:73;a:6:{s:1:\"a\";i:76;s:1:\"b\";s:39:\"api.accounting.chart-of-accounts.update\";s:1:\"c\";s:39:\"Api Accounting Chart-of-accounts Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:18;s:1:\"r\";a:1:{i:0;i:1;}}i:74;a:6:{s:1:\"a\";i:77;s:1:\"b\";s:40:\"api.accounting.chart-of-accounts.destroy\";s:1:\"c\";s:40:\"Api Accounting Chart-of-accounts Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:18;s:1:\"r\";a:1:{i:0;i:1;}}i:75;a:6:{s:1:\"a\";i:78;s:1:\"b\";s:28:\"api.accounting.account-heads\";s:1:\"c\";s:28:\"Api Accounting Account-heads\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:19;s:1:\"r\";a:1:{i:0;i:1;}}i:76;a:6:{s:1:\"a\";i:79;s:1:\"b\";s:28:\"api.accounting.voucher-types\";s:1:\"c\";s:28:\"Api Accounting Voucher-types\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:20;s:1:\"r\";a:1:{i:0;i:1;}}i:77;a:6:{s:1:\"a\";i:80;s:1:\"b\";s:36:\"api.accounting.journal-entries.index\";s:1:\"c\";s:36:\"Api Accounting Journal-entries Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:21;s:1:\"r\";a:1:{i:0;i:1;}}i:78;a:6:{s:1:\"a\";i:81;s:1:\"b\";s:36:\"api.accounting.journal-entries.store\";s:1:\"c\";s:36:\"Api Accounting Journal-entries Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:21;s:1:\"r\";a:1:{i:0;i:1;}}i:79;a:6:{s:1:\"a\";i:82;s:1:\"b\";s:35:\"api.accounting.journal-entries.show\";s:1:\"c\";s:35:\"Api Accounting Journal-entries Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:21;s:1:\"r\";a:1:{i:0;i:1;}}i:80;a:6:{s:1:\"a\";i:83;s:1:\"b\";s:37:\"api.accounting.journal-entries.update\";s:1:\"c\";s:37:\"Api Accounting Journal-entries Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:21;s:1:\"r\";a:1:{i:0;i:1;}}i:81;a:6:{s:1:\"a\";i:84;s:1:\"b\";s:38:\"api.accounting.journal-entries.destroy\";s:1:\"c\";s:38:\"Api Accounting Journal-entries Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:21;s:1:\"r\";a:1:{i:0;i:1;}}i:82;a:6:{s:1:\"a\";i:85;s:1:\"b\";s:36:\"api.accounting.account-modules.index\";s:1:\"c\";s:36:\"Api Accounting Account-modules Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:22;s:1:\"r\";a:1:{i:0;i:1;}}i:83;a:6:{s:1:\"a\";i:86;s:1:\"b\";s:36:\"api.accounting.account-modules.store\";s:1:\"c\";s:36:\"Api Accounting Account-modules Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:22;s:1:\"r\";a:1:{i:0;i:1;}}i:84;a:6:{s:1:\"a\";i:87;s:1:\"b\";s:35:\"api.accounting.account-modules.show\";s:1:\"c\";s:35:\"Api Accounting Account-modules Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:22;s:1:\"r\";a:1:{i:0;i:1;}}i:85;a:6:{s:1:\"a\";i:88;s:1:\"b\";s:37:\"api.accounting.account-modules.update\";s:1:\"c\";s:37:\"Api Accounting Account-modules Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:22;s:1:\"r\";a:1:{i:0;i:1;}}i:86;a:6:{s:1:\"a\";i:89;s:1:\"b\";s:38:\"api.accounting.account-modules.destroy\";s:1:\"c\";s:38:\"Api Accounting Account-modules Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:22;s:1:\"r\";a:1:{i:0;i:1;}}i:87;a:6:{s:1:\"a\";i:90;s:1:\"b\";s:36:\"api.accounting.generate-reference-no\";s:1:\"c\";s:36:\"Api Accounting Generate-reference-no\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:23;s:1:\"r\";a:1:{i:0;i:1;}}i:88;a:6:{s:1:\"a\";i:91;s:1:\"b\";s:36:\"api.inventory.supplier-advance.index\";s:1:\"c\";s:36:\"Api Inventory Supplier-advance Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:24;s:1:\"r\";a:1:{i:0;i:1;}}i:89;a:6:{s:1:\"a\";i:92;s:1:\"b\";s:36:\"api.inventory.supplier-advance.store\";s:1:\"c\";s:36:\"Api Inventory Supplier-advance Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:24;s:1:\"r\";a:1:{i:0;i:1;}}i:90;a:6:{s:1:\"a\";i:93;s:1:\"b\";s:35:\"api.inventory.supplier-advance.show\";s:1:\"c\";s:35:\"Api Inventory Supplier-advance Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:24;s:1:\"r\";a:1:{i:0;i:1;}}i:91;a:6:{s:1:\"a\";i:94;s:1:\"b\";s:37:\"api.inventory.supplier-advance.update\";s:1:\"c\";s:37:\"Api Inventory Supplier-advance Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:24;s:1:\"r\";a:1:{i:0;i:1;}}i:92;a:6:{s:1:\"a\";i:95;s:1:\"b\";s:38:\"api.inventory.supplier-advance.destroy\";s:1:\"c\";s:38:\"Api Inventory Supplier-advance Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:24;s:1:\"r\";a:1:{i:0;i:1;}}i:93;a:6:{s:1:\"a\";i:96;s:1:\"b\";s:14:\"api.inventory.\";s:1:\"c\";s:14:\"Api Inventory \";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:25;s:1:\"r\";a:1:{i:0;i:1;}}i:94;a:6:{s:1:\"a\";i:97;s:1:\"b\";s:31:\"api.inventory.products-overview\";s:1:\"c\";s:31:\"Api Inventory Products-overview\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:26;s:1:\"r\";a:1:{i:0;i:1;}}i:95;a:6:{s:1:\"a\";i:98;s:1:\"b\";s:32:\"api.inventory.suppliers.balances\";s:1:\"c\";s:32:\"Api Inventory Suppliers Balances\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:15;s:1:\"r\";a:1:{i:0;i:1;}}i:96;a:6:{s:1:\"a\";i:99;s:1:\"b\";s:29:\"api.inventory.purchases.index\";s:1:\"c\";s:29:\"Api Inventory Purchases Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:27;s:1:\"r\";a:1:{i:0;i:1;}}i:97;a:6:{s:1:\"a\";i:100;s:1:\"b\";s:29:\"api.inventory.purchases.store\";s:1:\"c\";s:29:\"Api Inventory Purchases Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:27;s:1:\"r\";a:1:{i:0;i:1;}}i:98;a:6:{s:1:\"a\";i:101;s:1:\"b\";s:28:\"api.inventory.purchases.show\";s:1:\"c\";s:28:\"Api Inventory Purchases Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:27;s:1:\"r\";a:1:{i:0;i:1;}}i:99;a:6:{s:1:\"a\";i:102;s:1:\"b\";s:30:\"api.inventory.purchases.update\";s:1:\"c\";s:30:\"Api Inventory Purchases Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:27;s:1:\"r\";a:1:{i:0;i:1;}}i:100;a:6:{s:1:\"a\";i:103;s:1:\"b\";s:31:\"api.inventory.purchases.destroy\";s:1:\"c\";s:31:\"Api Inventory Purchases Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:27;s:1:\"r\";a:1:{i:0;i:1;}}}s:5:\"roles\";a:1:{i:0;a:5:{s:1:\"a\";i:1;s:1:\"b\";s:13:\"Administrator\";s:1:\"j\";N;s:1:\"k\";N;s:1:\"d\";s:7:\"sanctum\";}}}', 1788672452);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hrm_blood_groups`
--

CREATE TABLE `hrm_blood_groups` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrm_blood_groups`
--

INSERT INTO `hrm_blood_groups` (`id`, `name`, `short_name`, `slug`, `branch_id`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'A+', 'A+', 'a', NULL, 1, NULL, NULL, '2026-08-15 04:18:36', '2026-08-22 02:15:48'),
(2, 'B+', 'B+', 'b', NULL, 1, NULL, NULL, '2026-08-22 01:05:24', '2026-08-29 02:49:36');

-- --------------------------------------------------------

--
-- Table structure for table `hrm_departments`
--

CREATE TABLE `hrm_departments` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrm_departments`
--

INSERT INTO `hrm_departments` (`id`, `name`, `short_name`, `slug`, `branch_id`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Test', 'Test', 'test', NULL, 1, NULL, NULL, '2026-08-15 05:01:52', '2026-08-22 01:35:06'),
(3, 'Test-2', 'Test-2', 'test-2', NULL, 1, NULL, NULL, '2026-08-22 03:53:53', '2026-08-22 03:53:53');

-- --------------------------------------------------------

--
-- Table structure for table `hrm_designations`
--

CREATE TABLE `hrm_designations` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrm_designations`
--

INSERT INTO `hrm_designations` (`id`, `name`, `short_name`, `slug`, `branch_id`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Manager', 'Manager', 'manager', NULL, 1, NULL, NULL, NULL, '2026-08-22 01:53:40'),
(2, 'Staff', 'S', 'staff', NULL, 1, NULL, NULL, '2026-08-22 04:59:27', '2026-08-22 04:59:27');

-- --------------------------------------------------------

--
-- Table structure for table `hrm_employees`
--

CREATE TABLE `hrm_employees` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Unique employee ID',
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `father_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `spouse_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `present_address` text COLLATE utf8mb4_unicode_ci,
  `permanent_address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department_id` bigint UNSIGNED DEFAULT NULL,
  `designation_id` bigint UNSIGNED DEFAULT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `gender_id` bigint UNSIGNED DEFAULT NULL,
  `religion_id` bigint UNSIGNED DEFAULT NULL,
  `nationality` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Bangladeshi',
  `marital_status` enum('Married','Unmarried','Divorced','Widowed') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `joining_date` date DEFAULT NULL,
  `confirmation_date` date DEFAULT NULL,
  `termination_date` date DEFAULT NULL,
  `shift_id` bigint UNSIGNED DEFAULT NULL,
  `probation_period` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'In months',
  `tin_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Tax identification number',
  `national_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `passport_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `passport_expiry_date` date DEFAULT NULL,
  `employee_category_id` bigint UNSIGNED DEFAULT NULL,
  `employee_type_id` bigint UNSIGNED DEFAULT NULL,
  `employee_status_id` bigint UNSIGNED DEFAULT NULL,
  `blood_group_id` bigint UNSIGNED DEFAULT NULL,
  `profile_picture` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrm_employees`
--

INSERT INTO `hrm_employees` (`id`, `employee_id`, `first_name`, `last_name`, `father_name`, `mother_name`, `spouse_name`, `slug`, `email`, `phone`, `present_address`, `permanent_address`, `city`, `state`, `country`, `postal_code`, `department_id`, `designation_id`, `branch_id`, `gender_id`, `religion_id`, `nationality`, `marital_status`, `date_of_birth`, `joining_date`, `confirmation_date`, `termination_date`, `shift_id`, `probation_period`, `tin_no`, `national_id`, `passport_number`, `passport_expiry_date`, `employee_category_id`, `employee_type_id`, `employee_status_id`, `blood_group_id`, `profile_picture`, `remarks`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'EMP-2026080001', 'Wadudur', 'Rahman', 'Robert Doe', 'Sarah Doe', 'Jane Doe', 'wadudur-rahman', 'wadud@gmail.com', '+88 01729-764728', '123 Main Street, Dhaka', '456 Village Road, Chittagong', 'Dhaka', 'Dhaka Division', 'Bangladesh', '1212', 1, 1, 1, 1, 1, 'Bangladeshi', 'Married', '1990-05-15', '2024-01-01', '2024-07-01', NULL, 1, '6', '123456789012', '1234567890123456', 'AB1234567', '2030-12-31', 1, 1, 1, 1, 'profile_photos/john_doe.jpg', 'Senior developer with 5 years experience', NULL, NULL, '2026-08-22 00:56:45', '2026-08-29 04:46:48');

-- --------------------------------------------------------

--
-- Table structure for table `hrm_employee_categories`
--

CREATE TABLE `hrm_employee_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrm_employee_categories`
--

INSERT INTO `hrm_employee_categories` (`id`, `name`, `short_name`, `slug`, `branch_id`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Cat-1', 'Cat-1', 'cat-1', NULL, 1, NULL, NULL, '2026-08-15 04:37:30', '2026-08-15 04:38:13'),
(2, 'Cat-2', 'Cat-2', 'cat-2', NULL, 1, NULL, NULL, '2026-08-22 02:07:05', '2026-08-22 02:07:05');

-- --------------------------------------------------------

--
-- Table structure for table `hrm_employee_statuses`
--

CREATE TABLE `hrm_employee_statuses` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrm_employee_statuses`
--

INSERT INTO `hrm_employee_statuses` (`id`, `name`, `short_name`, `slug`, `branch_id`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Active', 'Active', 'active', NULL, 1, NULL, NULL, '2026-08-15 03:23:17', '2026-08-15 04:11:15'),
(2, 'Inactive', 'Inactive', 'inactive', NULL, 1, NULL, NULL, '2026-08-22 02:12:08', '2026-08-22 04:46:23'),
(3, 'OSD', 'OSD', 'osd', NULL, 1, NULL, NULL, '2026-08-22 04:59:55', '2026-08-22 04:59:55'),
(4, 'Suspend', 'Suspend', 'suspend', NULL, 1, NULL, NULL, '2026-08-22 05:00:05', '2026-08-22 05:00:05');

-- --------------------------------------------------------

--
-- Table structure for table `hrm_employee_types`
--

CREATE TABLE `hrm_employee_types` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrm_employee_types`
--

INSERT INTO `hrm_employee_types` (`id`, `name`, `short_name`, `slug`, `branch_id`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Permanent', 'Permanent', 'permanent', NULL, 1, NULL, NULL, '2026-08-15 03:17:29', '2026-08-15 03:18:33'),
(2, 'Ad-hock', 'Ad-hock', 'ad-hock', NULL, 1, NULL, NULL, '2026-08-22 02:09:20', '2026-08-22 02:09:20');

-- --------------------------------------------------------

--
-- Table structure for table `hrm_genders`
--

CREATE TABLE `hrm_genders` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrm_genders`
--

INSERT INTO `hrm_genders` (`id`, `name`, `short_name`, `slug`, `branch_id`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Male', 'M', 'male', NULL, 1, NULL, NULL, '2026-08-15 02:56:52', '2026-08-15 02:58:08'),
(2, 'Female', 'F', 'female', NULL, 0, NULL, NULL, '2026-08-22 01:56:46', '2026-08-28 23:19:40');

-- --------------------------------------------------------

--
-- Table structure for table `hrm_leaves`
--

CREATE TABLE `hrm_leaves` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `department_id` int UNSIGNED NOT NULL,
  `designation_id` int UNSIGNED NOT NULL,
  `leave_category_id` int UNSIGNED NOT NULL,
  `application_date` date NOT NULL,
  `leave_from` date DEFAULT NULL,
  `leave_to` date DEFAULT NULL,
  `total_leave` decimal(4,2) DEFAULT NULL,
  `leave_limit` decimal(4,2) DEFAULT NULL,
  `previous_taken` decimal(4,2) DEFAULT NULL,
  `leave_balance` decimal(4,2) DEFAULT NULL,
  `leave_reason` text COLLATE utf8mb4_unicode_ci,
  `attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `accepted_date` date DEFAULT NULL,
  `accepted_by` tinyint NOT NULL DEFAULT '0',
  `forwared_date` date DEFAULT NULL,
  `forwared_by` tinyint NOT NULL DEFAULT '0',
  `approved_date` date DEFAULT NULL,
  `approved_by` tinyint NOT NULL DEFAULT '0',
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'false',
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrm_leaves`
--

INSERT INTO `hrm_leaves` (`id`, `employee_id`, `department_id`, `designation_id`, `leave_category_id`, `application_date`, `leave_from`, `leave_to`, `total_leave`, `leave_limit`, `previous_taken`, `leave_balance`, `leave_reason`, `attachment`, `accepted_date`, `accepted_by`, `forwared_date`, `forwared_by`, `approved_date`, `approved_by`, `status`, `remarks`, `created_at`, `updated_at`) VALUES
(6, 1, 1, 2, 1, '2026-08-01', '2026-08-01', '2026-08-22', 22.00, 10.00, 0.00, -12.00, 'Personal', NULL, NULL, 0, NULL, 0, NULL, 0, '1', NULL, '2026-08-29 04:17:11', '2026-08-29 04:45:44'),
(7, 1, 1, 1, 1, '2026-08-23', '2026-08-23', '2026-08-29', 7.00, 10.00, 0.00, 3.00, 'Personal', NULL, NULL, 0, NULL, 0, NULL, 0, '1', NULL, '2026-09-01 07:29:05', '2026-09-01 07:29:05');

-- --------------------------------------------------------

--
-- Table structure for table `hrm_leave_categories`
--

CREATE TABLE `hrm_leave_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `leave_limit` tinyint DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrm_leave_categories`
--

INSERT INTO `hrm_leave_categories` (`id`, `name`, `short_name`, `leave_limit`, `slug`, `branch_id`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Casual Leave', 'CL', 10, 'casual-leave', NULL, 1, NULL, NULL, '2026-08-28 23:58:49', '2026-08-29 03:43:13'),
(2, 'ML', 'ML', 10, 'ml', NULL, 1, NULL, NULL, '2026-08-29 04:46:10', '2026-08-29 04:46:10'),
(3, 'Maternity Leave', 'Maternity', 90, 'maternity-leave', NULL, 1, NULL, NULL, '2026-09-05 03:03:40', '2026-09-05 03:03:40');

-- --------------------------------------------------------

--
-- Table structure for table `hrm_leave_details`
--

CREATE TABLE `hrm_leave_details` (
  `id` bigint UNSIGNED NOT NULL,
  `leave_id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `department_id` int UNSIGNED NOT NULL,
  `designation_id` int UNSIGNED NOT NULL,
  `leave_category_id` int UNSIGNED NOT NULL,
  `application_date` date NOT NULL,
  `leave_date` date NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'false',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrm_leave_details`
--

INSERT INTO `hrm_leave_details` (`id`, `leave_id`, `employee_id`, `department_id`, `designation_id`, `leave_category_id`, `application_date`, `leave_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 1, 1, 1, '2026-08-29', '2026-08-29', '1', '2026-08-29 02:58:31', '2026-08-29 02:58:31'),
(2, 3, 1, 1, 1, 1, '2026-08-23', '2026-08-23', '1', '2026-08-29 03:04:11', '2026-08-29 03:04:11'),
(3, 3, 1, 1, 1, 1, '2026-08-23', '2026-08-24', '1', '2026-08-29 03:04:11', '2026-08-29 03:04:11'),
(4, 3, 1, 1, 1, 1, '2026-08-23', '2026-08-25', '1', '2026-08-29 03:04:11', '2026-08-29 03:04:11'),
(5, 3, 1, 1, 1, 1, '2026-08-23', '2026-08-26', '1', '2026-08-29 03:04:11', '2026-08-29 03:04:11'),
(6, 3, 1, 1, 1, 1, '2026-08-23', '2026-08-27', '1', '2026-08-29 03:04:11', '2026-08-29 03:04:11'),
(7, 3, 1, 1, 1, 1, '2026-08-23', '2026-08-28', '1', '2026-08-29 03:04:11', '2026-08-29 03:04:11'),
(8, 3, 1, 1, 1, 1, '2026-08-23', '2026-08-29', '1', '2026-08-29 03:04:11', '2026-08-29 03:04:11'),
(9, 4, 1, 1, 1, 1, '2026-08-23', '2026-08-23', '1', '2026-08-29 03:08:11', '2026-08-29 03:08:11'),
(10, 4, 1, 1, 1, 1, '2026-08-23', '2026-08-24', '1', '2026-08-29 03:08:11', '2026-08-29 03:08:11'),
(11, 4, 1, 1, 1, 1, '2026-08-23', '2026-08-25', '1', '2026-08-29 03:08:11', '2026-08-29 03:08:11'),
(12, 4, 1, 1, 1, 1, '2026-08-23', '2026-08-26', '1', '2026-08-29 03:08:11', '2026-08-29 03:08:11'),
(13, 4, 1, 1, 1, 1, '2026-08-23', '2026-08-27', '1', '2026-08-29 03:08:11', '2026-08-29 03:08:11'),
(14, 4, 1, 1, 1, 1, '2026-08-23', '2026-08-28', '1', '2026-08-29 03:08:11', '2026-08-29 03:08:11'),
(15, 4, 1, 1, 1, 1, '2026-08-23', '2026-08-29', '1', '2026-08-29 03:08:11', '2026-08-29 03:08:11'),
(16, 5, 1, 1, 1, 1, '2026-08-23', '2026-08-23', '1', '2026-08-29 03:11:46', '2026-08-29 04:03:12'),
(17, 5, 1, 1, 1, 1, '2026-08-23', '2026-08-24', '1', '2026-08-29 03:11:46', '2026-08-29 04:03:12'),
(18, 5, 1, 1, 1, 1, '2026-08-23', '2026-08-25', '1', '2026-08-29 03:11:46', '2026-08-29 04:03:12'),
(19, 5, 1, 1, 1, 1, '2026-08-23', '2026-08-26', '1', '2026-08-29 03:11:46', '2026-08-29 04:03:12'),
(20, 5, 1, 1, 1, 1, '2026-08-23', '2026-08-27', '1', '2026-08-29 03:11:46', '2026-08-29 04:03:12'),
(21, 5, 1, 1, 1, 1, '2026-08-23', '2026-08-28', '1', '2026-08-29 03:11:46', '2026-08-29 04:03:12'),
(22, 5, 1, 1, 1, 1, '2026-08-23', '2026-08-29', '1', '2026-08-29 03:11:46', '2026-08-29 04:03:12'),
(46, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-01', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(47, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-02', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(48, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-03', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(49, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-04', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(50, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-05', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(51, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-06', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(52, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-07', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(53, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-08', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(54, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-09', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(55, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-10', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(56, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-11', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(57, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-12', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(58, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-13', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(59, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-14', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(60, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-15', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(61, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-16', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(62, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-17', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(63, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-18', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(64, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-19', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(65, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-20', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(66, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-21', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(67, 6, 1, 1, 2, 1, '2026-08-01', '2026-08-22', '1', '2026-08-29 04:32:45', '2026-08-29 04:32:45'),
(68, 7, 1, 1, 1, 1, '2026-08-23', '2026-08-23', '1', '2026-09-01 07:29:05', '2026-09-01 07:29:05'),
(69, 7, 1, 1, 1, 1, '2026-08-23', '2026-08-24', '1', '2026-09-01 07:29:05', '2026-09-01 07:29:05'),
(70, 7, 1, 1, 1, 1, '2026-08-23', '2026-08-25', '1', '2026-09-01 07:29:05', '2026-09-01 07:29:05'),
(71, 7, 1, 1, 1, 1, '2026-08-23', '2026-08-26', '1', '2026-09-01 07:29:05', '2026-09-01 07:29:05'),
(72, 7, 1, 1, 1, 1, '2026-08-23', '2026-08-27', '1', '2026-09-01 07:29:05', '2026-09-01 07:29:05'),
(73, 7, 1, 1, 1, 1, '2026-08-23', '2026-08-28', '1', '2026-09-01 07:29:05', '2026-09-01 07:29:05'),
(74, 7, 1, 1, 1, 1, '2026-08-23', '2026-08-29', '1', '2026-09-01 07:29:05', '2026-09-01 07:29:05');

-- --------------------------------------------------------

--
-- Table structure for table `hrm_religions`
--

CREATE TABLE `hrm_religions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrm_religions`
--

INSERT INTO `hrm_religions` (`id`, `name`, `short_name`, `slug`, `branch_id`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Islam', 'Islam', 'islam', NULL, 1, NULL, NULL, '2026-08-15 03:03:05', '2026-08-15 03:03:39'),
(2, 'Hindu', 'Hindu', 'hindu', NULL, 1, NULL, NULL, '2026-08-22 01:59:06', '2026-08-22 01:59:06');

-- --------------------------------------------------------

--
-- Table structure for table `hrm_shifts`
--

CREATE TABLE `hrm_shifts` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrm_shifts`
--

INSERT INTO `hrm_shifts` (`id`, `name`, `short_name`, `slug`, `branch_id`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Day Shift', 'Day', 'day-shift', NULL, 1, NULL, NULL, '2026-08-15 03:07:46', '2026-08-15 03:09:22'),
(2, 'Night Shifts', 'NS', 'night-shifts', NULL, 1, NULL, NULL, '2026-08-22 02:01:25', '2026-08-22 02:01:25');

-- --------------------------------------------------------

--
-- Table structure for table `inv_brands`
--

CREATE TABLE `inv_brands` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_brands`
--

INSERT INTO `inv_brands` (`id`, `name`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 'Avante', 1, '2025-08-24 05:39:15', '2025-08-26 04:22:27'),
(2, 'New Brand', 1, '2025-08-26 04:22:43', '2025-08-26 04:22:43');

-- --------------------------------------------------------

--
-- Table structure for table `inv_categories`
--

CREATE TABLE `inv_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_categories`
--

INSERT INTO `inv_categories` (`id`, `name`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 'Electronics', 1, '2025-08-24 05:39:24', '2025-08-24 05:39:24'),
(2, 'PC', 1, '2025-08-26 03:44:45', '2025-08-26 03:44:45'),
(3, 'abc', 1, '2025-08-28 05:15:10', '2025-08-28 05:15:10'),
(4, 'dfdf', 1, '2025-08-28 05:15:13', '2025-08-28 05:15:13'),
(5, 'jkfklfk', 1, '2025-08-28 05:15:23', '2025-08-28 05:15:23'),
(6, 'rerer', 1, '2025-08-28 05:15:26', '2025-08-28 05:15:26'),
(7, 'rererer', 1, '2025-08-28 05:15:33', '2025-08-28 05:15:33'),
(8, 'rererer', 1, '2025-08-28 05:15:36', '2025-08-28 05:15:36'),
(9, 'ioereuire', 1, '2025-08-28 05:15:43', '2025-08-28 05:15:43'),
(10, 'oiierieire', 1, '2025-08-28 05:15:48', '2025-08-28 05:15:48'),
(11, 'eruieriekjlr', 1, '2025-08-28 05:15:54', '2025-08-28 05:15:54'),
(12, 'kjxcnmxjkds', 1, '2025-08-28 05:15:59', '2025-08-28 05:15:59'),
(13, 'riejhjherjk', 1, '2025-08-28 05:16:05', '2025-08-28 05:16:05'),
(14, 'fdfd', 1, '2025-09-03 00:08:27', '2025-09-03 00:08:27'),
(15, 'afdfdf', 1, '2025-09-03 00:08:30', '2025-09-03 00:08:30'),
(16, 'rerere', 1, '2025-09-03 00:08:36', '2025-09-03 00:08:36'),
(17, 'afdfedr', 1, '2025-09-03 00:08:39', '2025-09-03 00:08:39'),
(18, 'arerere', 1, '2025-09-03 00:08:46', '2025-09-03 00:08:46'),
(19, 'uiuiuiu', 1, '2025-09-03 00:08:50', '2025-09-03 00:08:50'),
(20, 'hkkfghk', 1, '2025-09-03 00:08:58', '2025-09-03 00:08:58'),
(21, 'gwee', 1, '2025-09-03 00:09:03', '2025-09-03 00:09:03'),
(22, 'zcvfsafsd', 1, '2025-09-03 00:09:09', '2025-09-03 00:09:09'),
(23, 'fdertkkklj', 1, '2025-09-03 00:44:20', '2025-09-03 00:44:20'),
(24, 'erere', 1, '2025-09-03 00:44:22', '2025-09-03 00:44:22'),
(25, 'rere', 1, '2025-09-03 00:44:30', '2025-09-03 00:44:30'),
(27, 'iuiyuiyuiuy', 1, '2025-09-03 00:44:41', '2025-09-03 00:44:41'),
(28, 'weewewe', 1, '2025-09-03 00:44:47', '2025-09-03 00:44:47'),
(29, 'rteewx', 1, '2025-09-03 00:44:58', '2025-09-03 00:44:58'),
(30, 'weewewe', 1, '2025-09-03 00:45:03', '2025-09-03 00:45:03'),
(31, 'ererer', 1, '2025-09-03 00:45:08', '2025-09-03 00:45:08'),
(32, 'Abcd Test', 1, '2025-12-15 02:08:08', '2025-12-15 02:08:08');

-- --------------------------------------------------------

--
-- Table structure for table `inv_customers`
--

CREATE TABLE `inv_customers` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `previous_due` decimal(12,2) NOT NULL DEFAULT '0.00',
  `advance_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_customers`
--

INSERT INTO `inv_customers` (`id`, `name`, `phone`, `email`, `address`, `previous_due`, `advance_amount`, `status`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 'John Doe', '01711223344', 'john@example.com', '456 Customer Lane, Chattogram', 250.00, 100.00, 1, 1, '2025-08-24 06:21:46', '2025-08-24 06:21:55'),
(2, 'New User', NULL, NULL, NULL, 0.00, 0.00, 1, 1, '2025-08-28 03:42:28', '2025-08-28 03:42:28'),
(3, 'Sakib Customer', '0195454545', NULL, NULL, 0.00, 0.00, 1, 1, '2026-04-30 05:37:59', '2026-04-30 05:51:25'),
(4, 'New Sales Return', '019545455454', NULL, NULL, 0.00, 0.00, 1, 1, '2026-05-07 03:10:29', '2026-05-07 03:10:29'),
(5, 'Rakib', '0191111', NULL, NULL, 0.00, 0.00, 1, 1, '2026-06-07 04:43:47', '2026-06-07 04:43:47'),
(6, 'Habib', '01988745445', NULL, NULL, 0.00, 0.00, 1, 1, '2026-06-08 04:17:41', '2026-06-08 04:17:41'),
(40, 'John Doe', '01711223344', 'john@example.com', '456 Customer Lane, Chattogram', 6000.00, 100.00, 1, 1, '2026-09-01 04:27:56', '2026-09-01 04:27:56'),
(41, 'John Doe 2', '01711223344', 'john@example.com', '456 Customer Lane, Chattogram', 6000.00, 100.00, 1, 1, '2026-09-01 04:39:27', '2026-09-01 04:39:27'),
(56, 'Wadud', NULL, NULL, NULL, 0.00, 0.00, 1, 1, '2026-09-05 04:33:04', '2026-09-05 04:33:04');

-- --------------------------------------------------------

--
-- Table structure for table `inv_customer_advances`
--

CREATE TABLE `inv_customer_advances` (
  `id` bigint UNSIGNED NOT NULL,
  `customer_id` bigint UNSIGNED NOT NULL,
  `advance_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `adjusted_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `remaining_amount` decimal(15,2) GENERATED ALWAYS AS ((`advance_amount` - `adjusted_amount`)) VIRTUAL,
  `date` date NOT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `type` enum('advance','adjustment') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'advance',
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_customer_advances`
--

INSERT INTO `inv_customer_advances` (`id`, `customer_id`, `advance_amount`, `adjusted_amount`, `date`, `payment_method`, `reference_no`, `note`, `type`, `branch_id`, `created_at`, `updated_at`) VALUES
(3, 2, 1.00, 0.00, '2025-11-24', NULL, 'CAV-0001', 'Advance payment for upcoming order', 'advance', 1, '2025-11-24 01:37:30', '2026-04-30 06:09:25'),
(4, 3, 200.00, 0.00, '2026-04-30', NULL, 'CAV-0002', NULL, 'advance', 1, '2026-04-30 05:52:02', '2026-04-30 05:52:02');

-- --------------------------------------------------------

--
-- Table structure for table `inv_customer_ledgers`
--

CREATE TABLE `inv_customer_ledgers` (
  `id` bigint UNSIGNED NOT NULL,
  `customer_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `transaction_type` enum('opening_balance','advance','sale','payment','advance_adjust','adjustment','sale_return','due_payment','due_payment_adjust','return_due_adjust','return_advance_adjust','return_cash_refund','return_advance','tex_amount') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `debit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `credit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `reference_id` bigint UNSIGNED DEFAULT NULL,
  `reference_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_customer_ledgers`
--

INSERT INTO `inv_customer_ledgers` (`id`, `customer_id`, `date`, `transaction_type`, `debit`, `credit`, `balance`, `reference_id`, `reference_no`, `note`, `branch_id`, `created_at`, `updated_at`) VALUES
(6, 1, '2025-11-24', 'opening_balance', 0.00, 250.00, 250.00, 1, 'CPD-0001', NULL, 1, '2025-11-24 03:03:33', '2025-11-24 03:03:33'),
(7, 3, '2026-04-30', 'advance', 200.00, 0.00, 200.00, 4, 'CAV-0002', NULL, 1, '2026-04-30 05:52:02', '2026-04-30 05:52:02'),
(14, 3, '2026-05-02', 'sale', 0.00, 50.00, 150.00, 6, 'SAL-2026-05-0002', NULL, 1, '2026-05-02 05:28:45', '2026-05-02 05:28:45'),
(16, 3, '2026-05-02', 'sale', 0.00, 100.00, 50.00, 7, 'SAL-2026-05-0003', NULL, 1, '2026-05-02 05:34:30', '2026-05-02 05:34:30'),
(20, 1, '2026-05-02', 'sale', 0.00, 250.00, -376.28, 8, 'SAL-2026-05-0004', NULL, 1, '2026-05-02 07:06:29', '2026-05-02 07:06:29'),
(22, 2, '2026-05-03', 'sale', 0.00, 450.00, -449.00, 9, 'SAL-2026-05-0005', NULL, 1, '2026-05-02 22:55:07', '2026-05-02 22:55:07'),
(23, 3, '2026-05-03', 'sale', 0.00, 250.00, -200.00, 11, 'SAL-2605-0001', NULL, 1, '2026-05-02 23:24:00', '2026-05-02 23:24:00'),
(29, 1, '2026-05-03', 'sale', 0.00, 250.00, -626.28, 13, 'SAL-2605-0003', NULL, 1, '2026-05-02 23:51:14', '2026-05-02 23:51:14'),
(31, 3, '2026-05-03', 'sale', 0.00, 500.00, -700.00, 12, 'SAL-2605-0002', NULL, 1, '2026-05-02 23:52:58', '2026-05-02 23:52:58'),
(36, 3, '2026-05-05', 'sale', 0.00, 600.00, -1300.00, 18, 'SAL-2605-0005', NULL, 1, '2026-05-05 05:10:02', '2026-05-05 05:10:02'),
(39, 3, '2026-05-05', 'sale', 0.00, 300.00, -2200.00, 21, 'SAL-2605-0007', NULL, 1, '2026-05-05 06:19:57', '2026-05-05 06:19:57'),
(40, 3, '2026-05-06', 'sale', 0.00, 600.00, -2800.00, 24, 'SAL-2605-0008', NULL, 1, '2026-05-05 23:51:07', '2026-05-05 23:51:07'),
(43, 3, '2026-05-06', 'sale', 0.00, 600.00, -3400.00, 27, 'SAL-2605-0009', NULL, 1, '2026-05-05 23:52:48', '2026-05-05 23:52:48'),
(46, 3, '2026-05-06', 'sale', 0.00, 324.00, -3724.00, 30, 'SAL-2605-0010', NULL, 1, '2026-05-06 00:09:12', '2026-05-06 00:09:12'),
(47, 3, '2026-05-06', 'sale', 0.00, 315.00, -4039.00, 31, 'SAL-2605-0011', NULL, 1, '2026-05-06 00:12:38', '2026-05-06 00:12:38'),
(50, 4, '2026-05-07', 'sale', 0.00, 0.00, 0.00, 34, 'SAL-2605-0012', NULL, 1, '2026-05-07 03:12:31', '2026-05-07 03:12:31'),
(102, 4, '2026-05-24', 'return_cash_refund', 1600.00, 0.00, 1600.00, 86, NULL, 'sds', 1, '2026-05-24 01:20:00', '2026-05-24 01:20:00'),
(104, 4, '2026-05-24', 'return_cash_refund', 1600.00, 0.00, 3200.00, 87, NULL, 'sds', 1, '2026-05-24 01:20:00', '2026-05-24 01:20:00'),
(106, 4, '2026-05-24', 'return_cash_refund', 0.00, 1500.00, 1700.00, 89, NULL, NULL, 1, '2026-05-24 01:26:21', '2026-05-24 01:26:21'),
(107, 4, '2026-05-24', 'return_cash_refund', 0.00, 1500.00, 200.00, 90, NULL, NULL, 1, '2026-05-24 01:26:21', '2026-05-24 01:26:21'),
(110, 4, '2026-05-24', 'return_advance', 800.00, 0.00, 1000.00, 108, NULL, NULL, 1, '2026-05-24 02:56:52', '2026-05-24 02:56:52'),
(112, 4, '2026-05-24', 'return_advance', 800.00, 0.00, 1800.00, 109, 'SRT-2605-0006', NULL, 1, '2026-05-24 03:18:01', '2026-05-24 03:18:01'),
(114, 4, '2026-05-24', 'return_advance', 800.00, 0.00, 2600.00, 110, 'SRT-2605-0007', NULL, 1, '2026-05-24 03:18:10', '2026-05-24 03:18:10'),
(116, 4, '2026-05-24', 'return_advance', 800.00, 0.00, 3400.00, 120, 'SRT-2605-0008', NULL, 1, '2026-05-24 04:29:04', '2026-05-24 04:29:04'),
(144, 2, '2026-06-06', 'due_payment_adjust', 49.00, 0.00, -351.00, 2, 'CDP-2606-0002', 'Test', 1, '2026-06-06 06:22:10', '2026-06-06 06:22:10'),
(146, 2, '2026-06-06', 'due_payment_adjust', 51.00, 0.00, -301.00, 3, 'CDP-2606-0003', NULL, 1, '2026-06-06 06:39:12', '2026-06-06 06:39:12'),
(148, 2, '2026-06-06', 'due_payment_adjust', 1.00, 0.00, -300.00, 4, 'CDP-2606-0004', NULL, 1, '2026-06-06 06:42:42', '2026-06-06 06:42:42'),
(149, 2, '2026-06-06', 'due_payment', 300.00, 0.00, 0.00, 5, 'CDP-2606-0005', NULL, 1, '2026-06-06 06:43:10', '2026-06-06 06:43:10'),
(151, 1, '2026-06-07', 'due_payment_adjust', 50.00, 0.00, -700.00, 6, 'CDP-2606-0006', 'afdfd', 1, '2026-06-07 01:42:45', '2026-06-07 01:42:45'),
(155, 1, '2026-06-07', 'due_payment_adjust', 20.00, 0.00, -680.00, 14, 'CDP-2606-0007', NULL, 1, '2026-06-07 03:04:05', '2026-06-07 03:04:05'),
(157, 1, '2026-06-07', 'due_payment_adjust', 40.00, 0.00, -640.00, 15, 'CDP-2606-0008', NULL, 1, '2026-06-07 03:10:24', '2026-06-07 03:10:24'),
(158, 1, '2026-06-07', 'due_payment', 130.00, 0.00, -510.00, 16, 'CDP-2606-0009', NULL, 1, '2026-06-07 03:11:12', '2026-06-07 03:11:12'),
(159, 1, '2026-06-07', 'due_payment_adjust', 10.00, 0.00, -500.00, 16, 'CDP-2606-0009', NULL, 1, '2026-06-07 03:11:12', '2026-06-07 03:11:12'),
(200, 5, '2026-06-08', 'return_due_adjust', 1100.00, 0.00, 0.00, 159, 'SRT-2606-0001', NULL, 1, '2026-06-08 01:23:08', '2026-06-08 01:23:08'),
(201, 5, '2026-06-08', 'return_cash_refund', 270.00, 0.00, 270.00, 159, 'SRT-2606-0001', NULL, 1, '2026-06-08 01:23:08', '2026-06-08 01:23:08'),
(202, 5, '2026-06-08', 'return_advance', 130.00, 0.00, 400.00, 159, 'SRT-2606-0001', NULL, 1, '2026-06-08 01:23:08', '2026-06-08 01:23:08'),
(223, 5, '2026-06-08', 'sale', 0.00, 3000.00, -2600.00, 8, 'SAL-2026-05-0004', NULL, 1, '2026-06-08 04:00:41', '2026-06-08 04:00:41'),
(224, 5, '2026-06-08', 'tex_amount', 0.00, 60.00, -2660.00, 8, 'SAL-2026-05-0004', NULL, 1, '2026-06-08 04:00:41', '2026-06-08 04:00:41'),
(225, 5, '2026-06-08', 'payment', 1800.00, 0.00, -860.00, 8, 'SAL-2026-05-0004', NULL, 1, '2026-06-08 04:00:41', '2026-06-08 04:00:41'),
(226, 5, '2026-06-08', 'adjustment', 160.00, 0.00, -700.00, 8, 'SAL-2026-05-0004', NULL, 1, '2026-06-08 04:00:41', '2026-06-08 04:00:41'),
(227, 5, '2026-06-08', 'sale', 0.00, 3000.00, -2600.00, 39, 'SAL-2606-0001', NULL, 1, '2026-06-08 04:04:15', '2026-06-08 04:04:15'),
(228, 5, '2026-06-08', 'tex_amount', 0.00, 60.00, -2660.00, 39, 'SAL-2606-0001', NULL, 1, '2026-06-08 04:04:15', '2026-06-08 04:04:15'),
(229, 5, '2026-06-08', 'payment', 1800.00, 0.00, -860.00, 39, 'SAL-2606-0001', NULL, 1, '2026-06-08 04:04:15', '2026-06-08 04:04:15'),
(230, 5, '2026-06-08', 'adjustment', 160.00, 0.00, -700.00, 39, 'SAL-2606-0001', NULL, 1, '2026-06-08 04:04:15', '2026-06-08 04:04:15'),
(243, 6, '2026-06-08', 'return_due_adjust', 860.00, 0.00, 0.00, 160, 'SRT-2606-0002', NULL, 1, '2026-06-08 04:24:50', '2026-06-08 04:24:50'),
(244, 6, '2026-06-08', 'return_cash_refund', 470.00, 0.00, 470.00, 160, 'SRT-2606-0002', NULL, 1, '2026-06-08 04:24:50', '2026-06-08 04:24:50'),
(245, 6, '2026-06-08', 'return_advance', 270.00, 0.00, 740.00, 160, 'SRT-2606-0002', NULL, 1, '2026-06-08 04:24:50', '2026-06-08 04:24:50'),
(246, 6, '2026-06-08', 'sale', 0.00, 4000.00, -2400.00, 47, 'SAL-2606-0002', NULL, 1, '2026-06-08 04:40:23', '2026-06-08 04:40:23'),
(247, 6, '2026-06-08', 'tex_amount', 0.00, 280.00, -2680.00, 47, 'SAL-2606-0002', NULL, 1, '2026-06-08 04:40:23', '2026-06-08 04:40:23'),
(248, 6, '2026-06-08', 'payment', 3000.00, 0.00, 320.00, 47, 'SAL-2606-0002', NULL, 1, '2026-06-08 04:40:23', '2026-06-08 04:40:23'),
(249, 6, '2026-06-08', 'adjustment', 420.00, 0.00, 740.00, 47, 'SAL-2606-0002', NULL, 1, '2026-06-08 04:40:23', '2026-06-08 04:40:23'),
(257, 40, '2026-09-01', 'opening_balance', 0.00, 6000.00, -6000.00, 40, 'CPD-0007', NULL, 1, '2026-09-01 04:27:56', '2026-09-01 04:27:56'),
(258, 41, '2026-09-01', 'opening_balance', 0.00, 6000.00, -6000.00, 41, 'CPD-0041', NULL, 1, '2026-09-01 04:39:27', '2026-09-01 04:39:27'),
(311, 56, '2026-09-05', 'sale', 0.00, 1600.00, -1600.00, 48, 'SAL-2609-0001', NULL, 1, '2026-09-05 04:57:23', '2026-09-05 04:57:23'),
(312, 56, '2026-09-05', 'tex_amount', 0.00, 200.00, -1800.00, 48, 'SAL-2609-0001', NULL, 1, '2026-09-05 04:57:23', '2026-09-05 04:57:23'),
(313, 56, '2026-09-05', 'payment', 1500.00, 0.00, -300.00, 48, 'SAL-2609-0001', NULL, 1, '2026-09-05 04:57:23', '2026-09-05 04:57:23'),
(314, 56, '2026-09-05', 'adjustment', 100.00, 0.00, -200.00, 48, 'SAL-2609-0001', NULL, 1, '2026-09-05 04:57:23', '2026-09-05 04:57:23');

-- --------------------------------------------------------

--
-- Table structure for table `inv_customer_payments`
--

CREATE TABLE `inv_customer_payments` (
  `id` bigint UNSIGNED NOT NULL,
  `invoice_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint UNSIGNED NOT NULL,
  `payment_date` date NOT NULL,
  `payment` decimal(10,2) NOT NULL DEFAULT '0.00',
  `adjustment` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `note` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_customer_payments`
--

INSERT INTO `inv_customer_payments` (`id`, `invoice_no`, `customer_id`, `payment_date`, `payment`, `adjustment`, `total_amount`, `note`, `branch_id`, `created_by`, `created_at`, `updated_at`) VALUES
(2, 'CDP-2606-0002', 2, '2026-06-06', 400.00, 49.00, 449.00, 'Test', 1, 1, '2026-06-06 06:22:10', '2026-06-06 06:22:10'),
(3, 'CDP-2606-0003', 2, '2026-06-06', 300.00, 51.00, 351.00, NULL, 1, 1, '2026-06-06 06:39:12', '2026-06-06 06:39:12'),
(4, 'CDP-2606-0004', 2, '2026-06-06', 300.00, 1.00, 301.00, NULL, 1, 1, '2026-06-06 06:42:42', '2026-06-06 06:42:42'),
(5, 'CDP-2606-0005', 2, '2026-06-06', 300.00, 0.00, 300.00, NULL, 1, 1, '2026-06-06 06:43:10', '2026-06-06 06:43:10'),
(6, 'CDP-2606-0006', 1, '2026-06-07', 300.00, 50.00, 350.00, 'afdfd', 1, 1, '2026-06-07 01:42:45', '2026-06-07 01:42:45'),
(14, 'CDP-2606-0007', 1, '2026-06-07', 180.00, 20.00, 200.00, NULL, 1, 1, '2026-06-07 03:04:05', '2026-06-07 03:04:05'),
(15, 'CDP-2606-0008', 1, '2026-06-07', 140.00, 40.00, 180.00, NULL, 1, 1, '2026-06-07 03:10:23', '2026-06-07 03:10:23'),
(16, 'CDP-2606-0009', 1, '2026-06-07', 130.00, 10.00, 140.00, NULL, 1, 1, '2026-06-07 03:11:12', '2026-06-07 03:11:12');

-- --------------------------------------------------------

--
-- Table structure for table `inv_payments`
--

CREATE TABLE `inv_payments` (
  `id` bigint UNSIGNED NOT NULL,
  `payment_type` enum('in','out') COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `payment_date` date NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inv_price_lists`
--

CREATE TABLE `inv_price_lists` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `price_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'retail',
  `price` decimal(12,2) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_price_lists`
--

INSERT INTO `inv_price_lists` (`id`, `product_id`, `branch_id`, `price_type`, `price`, `start_date`, `end_date`, `remarks`, `created_at`, `updated_at`) VALUES
(39, 1, 1, 'purchase', 100.00, '2025-10-12', NULL, 'Updated from purchase', '2025-10-11 23:07:28', '2025-10-11 23:07:28'),
(40, 2, 1, 'purchase', 200.00, '2025-10-12', NULL, 'Updated from purchase', '2025-10-11 23:07:28', '2025-10-11 23:07:28'),
(41, 1, 1, 'sale', 200.00, '2025-10-12', NULL, 'Updated from purchase', '2025-10-11 23:30:41', '2025-10-11 23:30:41'),
(42, 2, 1, 'sale', 300.00, '2025-10-12', NULL, 'Updated from purchase', '2025-10-11 23:30:41', '2025-10-11 23:30:41'),
(43, 8, 1, 'purchase', 150.00, '2025-11-05', NULL, 'Updated from purchase', '2025-11-04 22:54:00', '2025-11-04 22:54:00'),
(44, 8, 1, 'sale', 200.00, '2025-11-05', NULL, 'Updated from purchase', '2025-11-04 22:54:00', '2025-11-04 22:54:00'),
(45, 7, 1, 'purchase', 250.00, '2025-11-05', NULL, 'Updated from purchase', '2025-11-04 22:54:00', '2025-11-04 22:54:00'),
(46, 7, 1, 'sale', 280.00, '2025-11-05', NULL, 'Updated from purchase', '2025-11-04 22:54:00', '2025-11-04 22:54:00'),
(47, 6, 1, 'purchase', 500.00, '2025-11-05', NULL, 'Updated from purchase', '2025-11-05 02:57:49', '2025-11-05 02:57:49'),
(48, 6, 1, 'sale', 600.00, '2025-11-05', NULL, 'Updated from purchase', '2025-11-05 02:57:49', '2025-11-05 02:57:49'),
(49, 1, 1, 'cost_price', 100.00, '2025-10-12', NULL, 'Updated from cost price', '2025-10-11 23:07:28', '2025-10-11 23:07:28'),
(50, 2, 1, 'cost_price', 200.00, '2025-10-12', NULL, 'Updated from cost price', '2025-10-11 23:07:28', '2025-10-11 23:07:28'),
(51, 8, 1, 'cost_price', 150.00, '2025-11-05', NULL, 'Updated from cost price', '2025-11-04 22:54:00', '2025-11-04 22:54:00'),
(52, 7, 1, 'cost_price', 250.00, '2025-11-05', NULL, 'Updated from cost price', '2025-11-04 22:54:00', '2025-11-04 22:54:00'),
(53, 6, 1, 'cost_price', 500.00, '2025-11-05', NULL, 'Updated from cost price', '2025-11-05 02:57:49', '2025-11-05 02:57:49');

-- --------------------------------------------------------

--
-- Table structure for table `inv_products`
--

CREATE TABLE `inv_products` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint UNSIGNED DEFAULT NULL,
  `unit_id` bigint UNSIGNED DEFAULT NULL,
  `brand_id` bigint UNSIGNED DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `branch_id` bigint UNSIGNED NOT NULL,
  `re_order` int DEFAULT NULL,
  `made_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `specification` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_products`
--

INSERT INTO `inv_products` (`id`, `name`, `sku`, `category_id`, `unit_id`, `brand_id`, `status`, `branch_id`, `re_order`, `made_by`, `image`, `specification`, `created_at`, `updated_at`) VALUES
(1, 'Digital Card', 'THERMO-001', 1, 1, 1, 1, 1, 5, 'ThermoTech Co.', '/storage/inventory/product/rlfaqXnn050AxxXnfSah16hgy13ldhWB7x9gmS1v.png', 'Fast reading digital thermometer.', '2025-08-24 06:06:05', '2025-09-03 06:02:16'),
(2, 'Irrigation Project Zone A', '00001', 22, 2, 2, 1, 1, NULL, NULL, '/storage/inventory/product/Vsc4aDVRTP58G0uj9vBwwOCTeb064FpWuLJi5Bz5.jpg', NULL, '2025-09-03 03:32:54', '2025-09-04 03:08:14'),
(3, 'New Product', '00002', 31, NULL, NULL, 0, 1, 6, '4555', NULL, 'Specification', '2025-09-03 07:19:28', '2025-09-03 07:19:28'),
(4, 'Monopolar Cable', '00003', 24, 2, NULL, 1, 1, NULL, NULL, NULL, NULL, '2025-10-29 00:40:36', '2025-10-29 00:40:36'),
(5, 'Fan Retractor', '00004', 25, 2, NULL, 1, 1, NULL, NULL, NULL, NULL, '2025-10-29 00:48:20', '2025-10-29 00:48:20'),
(6, 'Needle Holder', '00005', 30, 2, NULL, 1, 1, NULL, NULL, NULL, NULL, '2025-10-29 00:49:23', '2025-10-29 00:49:23'),
(7, 'Suture Passer', '00006', 25, 1, NULL, 1, 1, NULL, NULL, NULL, NULL, '2025-10-29 00:53:40', '2025-10-29 00:53:40'),
(8, 'Knot Pusher 4', '00007', 25, 2, NULL, 1, 1, NULL, NULL, NULL, NULL, '2025-10-29 01:04:07', '2025-12-15 03:36:47');

-- --------------------------------------------------------

--
-- Table structure for table `inv_product_sets`
--

CREATE TABLE `inv_product_sets` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_product_sets`
--

INSERT INTO `inv_product_sets` (`id`, `name`, `discount`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 'Winter Combo Set', 10.00, 1, '2025-09-04 00:05:16', '2025-09-04 00:05:16'),
(2, 'New Item', 50.00, 1, '2025-09-04 03:22:56', '2025-09-04 03:22:56');

-- --------------------------------------------------------

--
-- Table structure for table `inv_product_set_items`
--

CREATE TABLE `inv_product_set_items` (
  `id` bigint UNSIGNED NOT NULL,
  `product_set_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `qty` int NOT NULL DEFAULT '1',
  `price` decimal(8,2) DEFAULT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_product_set_items`
--

INSERT INTO `inv_product_set_items` (`id`, `product_set_id`, `product_id`, `qty`, `price`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 150.00, 1, '2025-09-04 00:05:16', '2025-09-04 00:05:16'),
(2, 1, 2, 1, 250.00, 1, '2025-09-04 00:05:16', '2025-09-04 00:05:16'),
(9, 2, 3, 5, 0.00, 1, '2025-12-15 03:22:20', '2025-12-15 03:22:20'),
(10, 2, 2, 3, 0.00, 1, '2025-12-15 03:22:20', '2025-12-15 03:22:20'),
(11, 2, 1, 1, 0.00, 1, '2025-12-15 03:22:20', '2025-12-15 03:22:20');

-- --------------------------------------------------------

--
-- Table structure for table `inv_product_wastages`
--

CREATE TABLE `inv_product_wastages` (
  `id` bigint UNSIGNED NOT NULL,
  `wastage_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `wastage_date` date NOT NULL,
  `total_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `note` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_product_wastages`
--

INSERT INTO `inv_product_wastages` (`id`, `wastage_no`, `wastage_date`, `total_amount`, `note`, `branch_id`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'WST-2607-0001', '2026-07-12', 150.00, NULL, 1, 1, '2026-07-12 05:55:49', '2026-07-12 05:55:49');

-- --------------------------------------------------------

--
-- Table structure for table `inv_product_wastage_items`
--

CREATE TABLE `inv_product_wastage_items` (
  `id` bigint UNSIGNED NOT NULL,
  `product_wastage_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `quantity` decimal(12,2) NOT NULL DEFAULT '0.00',
  `unit_cost` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `total_cost` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_product_wastage_items`
--

INSERT INTO `inv_product_wastage_items` (`id`, `product_wastage_id`, `product_id`, `quantity`, `unit_cost`, `total_cost`, `reason`, `created_at`, `updated_at`) VALUES
(1, 1, 8, 1.00, 150.0000, 150.0000, NULL, '2026-07-12 05:55:49', '2026-07-12 05:55:49');

-- --------------------------------------------------------

--
-- Table structure for table `inv_purchases`
--

CREATE TABLE `inv_purchases` (
  `id` bigint UNSIGNED NOT NULL,
  `invoice_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_id` bigint UNSIGNED NOT NULL,
  `invoice_date` date NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `discount_percent` decimal(5,2) NOT NULL DEFAULT '0.00',
  `discount_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount_percent` decimal(5,2) NOT NULL DEFAULT '0.00',
  `total_discount_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `adjustment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `tax_percent` decimal(5,2) NOT NULL DEFAULT '0.00',
  `tax_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_tax_percent` decimal(5,2) NOT NULL DEFAULT '0.00',
  `total_tax_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `supplier_adjust` decimal(12,2) NOT NULL DEFAULT '0.00',
  `net_total` decimal(12,2) NOT NULL,
  `paid_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `due_amount` decimal(12,2) NOT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_purchases`
--

INSERT INTO `inv_purchases` (`id`, `invoice_no`, `supplier_id`, `invoice_date`, `total_amount`, `discount_percent`, `discount_amount`, `total_discount_percent`, `total_discount_amount`, `adjustment`, `tax_percent`, `tax_amount`, `total_tax_percent`, `total_tax_amount`, `supplier_adjust`, `net_total`, `paid_amount`, `due_amount`, `remarks`, `branch_id`, `created_by`, `created_at`, `updated_at`) VALUES
(30, 'INV-2025-11-0001', 1, '2025-11-04', 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 600.00, 300.00, 300.00, NULL, 1, 1, '2025-11-04 01:29:28', '2025-11-04 01:29:28'),
(31, 'INV-2025-11-0002', 1, '2025-11-04', 200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 200.00, 0.00, NULL, 1, 1, '2025-11-04 01:32:15', '2025-11-04 01:32:15'),
(32, 'INV-2025-11-0003', 1, '2025-11-04', 200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 200.00, 200.00, 0.00, NULL, 1, 1, '2025-11-04 01:32:33', '2025-11-04 01:32:33'),
(33, 'INV-2025-11-0004', 1, '2025-11-04', 300.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 300.00, 300.00, 0.00, NULL, 1, 1, '2025-11-04 01:33:19', '2025-11-04 01:33:19'),
(34, 'INV-2025-11-0005', 1, '2025-11-04', 400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 400.00, 400.00, 0.00, NULL, 1, 1, '2025-11-04 01:50:18', '2025-11-04 01:50:18'),
(68, 'INV-2025-11-0006', 1, '2025-11-04', 100.00, 38.00, 38.00, 0.00, 0.00, 0.00, 30.81, 21.70, 0.00, 0.00, 0.00, 81.70, 30.00, 51.70, NULL, 1, 1, '2025-11-04 05:20:56', '2025-11-04 05:20:56'),
(72, 'INV-2025-11-0007', 1, '2025-11-04', 200.00, 13.50, 27.00, 0.00, 0.00, 0.00, 12.70, 11.35, 0.00, 0.00, 0.00, 174.35, 0.00, 174.35, NULL, 1, 1, '2025-11-04 05:33:27', '2025-11-04 05:33:27'),
(86, 'INV-2025-11-0008', 4, '2025-11-04', 200.00, 20.00, 40.00, 0.00, 0.00, 0.00, 8.06, 15.00, 0.00, 0.00, 0.00, 170.00, 0.00, 0.00, NULL, 1, 1, '2025-11-04 06:35:47', '2025-11-04 06:35:47'),
(87, 'INV-2025-11-0009', 10, '2025-11-05', 4250.00, 4.20, 70.00, 0.00, 0.00, 0.00, 3.89, 4.20, 0.00, 0.00, 0.00, 4179.50, 4000.00, 179.50, NULL, 1, 1, '2025-11-04 22:54:00', '2025-11-04 22:54:00'),
(88, 'INV-2025-11-0010', 9, '2025-11-05', 4500.00, 1.56, 70.00, 0.00, 0.00, 0.00, 0.89, 30.44, 0.00, 0.00, 0.00, 4390.44, 4000.00, 390.44, NULL, 1, 1, '2025-11-05 00:08:41', '2025-11-05 00:08:41'),
(89, 'INV-2025-11-0011', 8, '2025-11-05', 4000.00, 1.75, 70.00, 71.25, 120.00, 40.00, 0.50, 20.00, 1.51, 21.25, 0.00, 3910.00, 3000.00, 910.00, NULL, 1, 1, '2025-11-05 00:47:10', '2025-11-05 00:47:10'),
(90, 'INV-2025-11-0012', 10, '2025-11-05', 6000.00, 1.33, 80.00, 81.17, 150.00, 80.00, 70.00, 1.20, 71.00, 61.20, 0.00, 5841.20, 5000.00, 841.20, NULL, 1, 1, '2025-11-05 01:13:02', '2025-11-05 01:13:02'),
(91, 'INV-2025-11-0013', 10, '2025-11-05', 6000.00, 1.50, 90.00, 2.83, 170.00, 80.00, 1.37, 80.00, 2.54, 150.00, 0.00, 5910.00, 5000.00, 910.00, NULL, 1, 1, '2025-11-05 01:18:07', '2025-11-05 01:18:07'),
(109, 'INV-2025-11-0014', 10, '2025-11-05', 6000.00, 1.33, 80.00, 2.83, 170.00, 80.00, 1.20, 70.00, 2.53, 150.00, 0.00, 5900.00, 5000.00, 900.00, NULL, 1, 1, '2025-11-05 01:51:10', '2025-11-05 01:51:10'),
(110, 'INV-2025-11-0015', 8, '2025-11-05', 1500.00, 4.93, 74.00, 10.93, 164.00, 63.50, 4.27, 57.00, 8.97, 127.50, 0.00, 1400.00, 1000.00, 400.00, NULL, 1, 1, '2025-11-05 02:57:49', '2025-11-05 03:25:02'),
(111, 'INV-2025-11-0016', 4, '2025-11-05', 1250.00, 0.00, 0.00, 0.00, 0.00, 20.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1270.00, 0.00, 40.00, NULL, 1, 1, '2025-11-05 03:44:03', '2026-05-06 00:31:32'),
(113, 'INV-2026-06-0001', 9, '2026-06-11', 1250.00, 4.00, 50.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 1200.00, 0.00, NULL, 1, 1, '2026-06-11 05:24:36', '2026-06-11 05:24:36'),
(118, 'INV-2026-06-0002', 11, '2026-06-18', 2500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2500.00, 2200.00, 300.00, NULL, 1, 1, '2026-06-18 05:12:30', '2026-06-18 05:12:30'),
(119, 'INV-2026-06-0003', 12, '2026-06-18', 2500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2500.00, 2450.00, 50.00, NULL, 1, 1, '2026-06-18 06:02:44', '2026-06-18 06:02:44'),
(124, 'INV-2026-08-0001', 11, '2026-08-04', 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, NULL, 1, 1, '2026-08-03 23:06:02', '2026-08-03 23:06:02'),
(129, 'INV-2026-09-0001', 32, '2026-09-01', 250.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 250.00, 100.00, 150.00, NULL, 1, 1, '2026-09-01 06:27:40', '2026-09-01 06:27:40'),
(130, 'INV-2026-09-0002', 33, '2026-09-05', 650.00, 3.00, 19.50, 0.00, 0.00, 2.00, 5.00, 31.53, 0.00, 0.00, 0.00, 664.03, 600.00, 64.03, NULL, 1, 1, '2026-09-05 03:24:25', '2026-09-05 03:24:25'),
(137, 'INV-2026-09-0003', 33, '2026-09-05', 400.00, 5.00, 20.00, 0.00, 0.00, 10.00, 7.89, 30.00, 0.00, 0.00, 0.00, 400.00, 300.00, 100.00, NULL, 1, 1, '2026-09-05 03:59:04', '2026-09-05 03:59:04');

-- --------------------------------------------------------

--
-- Table structure for table `inv_purchase_items`
--

CREATE TABLE `inv_purchase_items` (
  `id` bigint UNSIGNED NOT NULL,
  `purchase_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `invoice_date` date DEFAULT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `cost_price` decimal(10,2) DEFAULT NULL,
  `inventory_subtotal` decimal(12,2) DEFAULT NULL,
  `sale_price` decimal(12,2) DEFAULT NULL,
  `total_price` decimal(12,2) NOT NULL,
  `discount_percent` decimal(5,2) NOT NULL DEFAULT '0.00',
  `discount_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `tax_percent` decimal(5,2) NOT NULL DEFAULT '0.00',
  `tax_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `net_price` decimal(12,2) NOT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_purchase_items`
--

INSERT INTO `inv_purchase_items` (`id`, `purchase_id`, `product_id`, `invoice_date`, `quantity`, `unit_price`, `cost_price`, `inventory_subtotal`, `sale_price`, `total_price`, `discount_percent`, `discount_amount`, `tax_percent`, `tax_amount`, `net_price`, `remarks`, `branch_id`, `created_at`, `updated_at`) VALUES
(70, 30, 2, '2025-11-04', 3, 200.00, 200.00, 600.00, 300.00, 600.00, 0.00, 0.00, 0.00, 0.00, 600.00, NULL, 1, '2025-11-04 01:29:28', '2025-11-04 01:29:28'),
(71, 31, 2, '2025-11-04', 1, 200.00, 200.00, 200.00, 300.00, 200.00, 0.00, 0.00, 0.00, 0.00, 200.00, NULL, 1, '2025-11-04 01:32:15', '2025-11-04 01:32:15'),
(72, 32, 2, '2025-11-04', 1, 200.00, 200.00, 200.00, 300.00, 200.00, 0.00, 0.00, 0.00, 0.00, 200.00, NULL, 1, '2025-11-04 01:32:33', '2025-11-04 01:32:33'),
(73, 33, 1, '2025-11-04', 3, 100.00, 100.00, 300.00, 200.00, 300.00, 0.00, 0.00, 0.00, 0.00, 300.00, NULL, 1, '2025-11-04 01:33:19', '2025-11-04 01:33:19'),
(74, 34, 2, '2025-11-04', 2, 200.00, 200.00, 400.00, 300.00, 400.00, 0.00, 0.00, 0.00, 0.00, 400.00, NULL, 1, '2025-11-04 01:50:18', '2025-11-04 01:50:18'),
(108, 68, 1, '2025-11-04', 1, 100.00, 92.00, 92.00, 200.00, 92.00, 20.00, 20.00, 15.00, 12.00, 100.00, NULL, 1, '2025-11-04 05:20:56', '2025-11-04 05:20:56'),
(112, 72, 2, '2025-11-04', 1, 200.00, 192.00, 192.00, 300.00, 192.01, 10.00, 20.00, 6.67, 12.01, 200.00, NULL, 1, '2025-11-04 05:33:27', '2025-11-04 05:33:27'),
(126, 86, 2, '2025-11-04', 1, 200.00, 190.00, 190.00, 300.00, 190.01, 10.00, 20.00, 5.56, 10.01, 200.00, NULL, 1, '2025-11-04 06:35:47', '2025-11-04 06:35:47'),
(127, 87, 8, '2025-11-05', 20, 150.00, 149.70, 2994.00, 200.00, 2999.70, 1.00, 30.00, 1.00, 29.70, 3000.00, NULL, 1, '2025-11-04 22:54:00', '2025-11-04 22:54:00'),
(128, 87, 7, '2025-11-05', 5, 250.00, 245.00, 1225.00, 280.00, 1244.97, 3.20, 40.00, 2.89, 34.97, 1250.00, NULL, 1, '2025-11-04 22:54:00', '2025-11-04 22:54:00'),
(129, 88, 8, '2025-11-05', 30, 150.00, 140.00, 4200.00, 200.00, 4489.86, 0.44, 20.00, 0.22, 9.86, 4500.00, NULL, 1, '2025-11-05 00:08:41', '2025-11-05 00:08:41'),
(130, 89, 2, '2025-11-05', 20, 200.00, 190.00, 3800.00, 300.00, 3989.90, 1.25, 50.00, 1.01, 39.90, 4000.00, NULL, 1, '2025-11-05 00:47:10', '2025-11-05 00:47:10'),
(131, 90, 2, '2025-11-05', 30, 200.00, 190.00, 5700.00, 300.00, 5990.00, 1.17, 70.00, 1.00, 60.00, 6000.00, NULL, 1, '2025-11-05 01:13:02', '2025-11-05 01:13:02'),
(132, 91, 2, '2025-11-05', 30, 200.00, 190.00, 5700.00, 300.00, 5990.00, 1.33, 80.00, 1.17, 70.00, 6000.00, NULL, 1, '2025-11-05 01:18:07', '2025-11-05 01:18:07'),
(150, 109, 2, '2025-11-05', 30, 200.00, 190.00, 5700.00, 300.00, 5990.00, 1.50, 90.00, 1.33, 80.00, 6000.00, NULL, 1, '2025-11-05 01:51:10', '2025-11-05 01:51:10'),
(152, 110, 6, '2025-11-05', 3, 500.00, 480.50, 1441.50, 600.00, 1480.50, 6.00, 90.00, 4.70, 70.50, 1500.00, NULL, 1, '2025-11-05 03:25:02', '2025-11-05 03:25:02'),
(154, 111, 7, '2025-11-05', 5, 250.00, 250.00, 1250.00, 280.00, 1250.00, 0.00, 0.00, 0.00, 0.00, 1250.00, NULL, 1, '2025-11-23 23:59:29', '2025-11-23 23:59:29'),
(157, 111, 7, '2025-11-05', 5, 250.00, 250.00, 1250.00, 280.00, 1250.00, 0.00, 0.00, 0.00, 0.00, 1250.00, NULL, 1, '2026-05-06 00:31:32', '2026-05-06 00:31:32'),
(159, 113, 7, '2026-06-11', 5, 250.00, 250.00, 1250.00, NULL, 1250.00, 0.00, 0.00, 0.00, 0.00, 1250.00, NULL, 1, '2026-06-11 05:24:36', '2026-06-11 05:24:36'),
(164, 118, 6, '2026-06-18', 10, 250.00, 250.00, 2500.00, NULL, 2500.00, 0.00, 0.00, 0.00, 0.00, 2500.00, NULL, 1, '2026-06-18 05:12:30', '2026-06-18 05:12:30'),
(165, 119, 7, '2026-06-18', 10, 250.00, 250.00, 2500.00, NULL, 2500.00, 0.00, 0.00, 0.00, 0.00, 2500.00, NULL, 1, '2026-06-18 06:02:44', '2026-06-18 06:02:44'),
(170, 124, 1, '2026-08-04', 10, 100.00, 100.00, 1000.00, NULL, 1000.00, 0.00, 0.00, 0.00, 0.00, 1000.00, NULL, 1, '2026-08-03 23:06:02', '2026-08-03 23:06:02'),
(175, 129, 7, '2026-09-01', 1, 250.00, 250.00, 250.00, NULL, 250.00, 0.00, 0.00, 0.00, 0.00, 250.00, NULL, 1, '2026-09-01 06:27:40', '2026-09-01 06:27:40'),
(176, 130, 8, '2026-09-05', 1, 150.00, 150.00, 150.00, NULL, 150.00, 0.00, 0.00, 0.00, 0.00, 150.00, NULL, 1, '2026-09-05 03:24:25', '2026-09-05 03:24:25'),
(177, 130, 6, '2026-09-05', 1, 500.00, 500.00, 500.00, NULL, 500.00, 0.00, 0.00, 0.00, 0.00, 500.00, NULL, 1, '2026-09-05 03:24:25', '2026-09-05 03:24:25'),
(192, 137, 8, '2026-09-05', 1, 150.00, 150.00, 150.00, NULL, 150.00, 0.00, 0.00, 0.00, 0.00, 150.00, NULL, 1, '2026-09-05 03:59:04', '2026-09-05 03:59:04'),
(193, 137, 7, '2026-09-05', 1, 250.00, 250.00, 250.00, NULL, 250.00, 0.00, 0.00, 0.00, 0.00, 250.00, NULL, 1, '2026-09-05 03:59:04', '2026-09-05 03:59:04');

-- --------------------------------------------------------

--
-- Table structure for table `inv_purchase_returns`
--

CREATE TABLE `inv_purchase_returns` (
  `id` bigint UNSIGNED NOT NULL,
  `invoice_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purchase_id` bigint UNSIGNED NOT NULL,
  `supplier_id` bigint UNSIGNED NOT NULL,
  `return_date` date NOT NULL,
  `total_return_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_refund_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `adjusted_due_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `cash_refund_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `supplier_advance` decimal(12,2) NOT NULL DEFAULT '0.00',
  `note` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'approved',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_purchase_returns`
--

INSERT INTO `inv_purchase_returns` (`id`, `invoice_no`, `purchase_id`, `supplier_id`, `return_date`, `total_return_amount`, `total_refund_amount`, `adjusted_due_amount`, `cash_refund_amount`, `supplier_advance`, `note`, `branch_id`, `created_by`, `status`, `created_at`, `updated_at`) VALUES
(30, 'PRT-2606-0001', 113, 9, '2026-06-18', 480.00, 730.00, 50.00, 600.00, 80.00, NULL, 1, 1, 'approved', '2026-06-18 00:16:08', '2026-06-18 00:16:08'),
(31, 'PRT-2606-0002', 118, 11, '2026-06-18', 480.00, 730.00, 50.00, 600.00, 80.00, NULL, 1, 1, 'approved', '2026-06-18 05:13:51', '2026-06-18 05:13:51'),
(33, 'PRT-2606-0003', 118, 11, '2026-06-18', 480.00, 730.00, 0.00, 700.00, 30.00, NULL, 1, 1, 'approved', '2026-06-18 05:44:22', '2026-06-18 05:44:22'),
(36, 'PRT-2606-0004', 118, 11, '2026-06-18', 500.00, 750.00, 0.00, 750.00, 0.00, NULL, 1, 1, 'approved', '2026-06-18 05:47:59', '2026-06-18 05:47:59');

-- --------------------------------------------------------

--
-- Table structure for table `inv_purchase_return_items`
--

CREATE TABLE `inv_purchase_return_items` (
  `id` bigint UNSIGNED NOT NULL,
  `purchase_return_id` bigint UNSIGNED NOT NULL,
  `purchase_item_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `return_qty` decimal(12,2) NOT NULL DEFAULT '0.00',
  `wastage_qty` decimal(12,2) NOT NULL DEFAULT '0.00',
  `unit_purchase_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `return_unit_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_return_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_refund_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `cost_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_purchase_return_items`
--

INSERT INTO `inv_purchase_return_items` (`id`, `purchase_return_id`, `purchase_item_id`, `product_id`, `return_qty`, `wastage_qty`, `unit_purchase_price`, `return_unit_price`, `total_return_price`, `total_refund_price`, `cost_price`, `branch_id`, `created_at`, `updated_at`) VALUES
(30, 30, 159, 7, 2.00, 1.00, 250.00, 240.00, 480.00, 730.00, 250.00, 1, '2026-06-18 00:16:08', '2026-06-18 00:16:08'),
(31, 31, 164, 6, 2.00, 1.00, 250.00, 240.00, 480.00, 730.00, 250.00, 1, '2026-06-18 05:13:51', '2026-06-18 05:13:51'),
(33, 33, 164, 6, 2.00, 1.00, 250.00, 240.00, 480.00, 730.00, 250.00, 1, '2026-06-18 05:44:22', '2026-06-18 05:44:22'),
(36, 36, 164, 6, 2.00, 1.00, 250.00, 250.00, 500.00, 750.00, 250.00, 1, '2026-06-18 05:47:59', '2026-06-18 05:47:59');

-- --------------------------------------------------------

--
-- Table structure for table `inv_sales`
--

CREATE TABLE `inv_sales` (
  `id` bigint UNSIGNED NOT NULL,
  `invoice_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint UNSIGNED NOT NULL,
  `invoice_date` date NOT NULL,
  `total_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `discount_percent` decimal(8,2) NOT NULL DEFAULT '0.00',
  `discount_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_discount_percent` decimal(8,2) DEFAULT '0.00',
  `total_discount_amount` decimal(15,2) DEFAULT '0.00',
  `adjustment` decimal(15,2) NOT NULL DEFAULT '0.00',
  `tax_percent` decimal(8,2) NOT NULL DEFAULT '0.00',
  `tax_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_tax_percent` decimal(8,2) NOT NULL DEFAULT '0.00',
  `total_tax_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `customer_adjust` decimal(15,2) NOT NULL DEFAULT '0.00',
  `net_total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `paid_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `due_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_sales`
--

INSERT INTO `inv_sales` (`id`, `invoice_no`, `customer_id`, `invoice_date`, `total_amount`, `discount_percent`, `discount_amount`, `total_discount_percent`, `total_discount_amount`, `adjustment`, `tax_percent`, `tax_amount`, `total_tax_percent`, `total_tax_amount`, `customer_adjust`, `net_total`, `paid_amount`, `due_amount`, `remarks`, `branch_id`, `created_by`, `created_at`, `updated_at`) VALUES
(6, 'SAL-2026-05-0002', 3, '2026-05-03', 250.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 250.00, 0.00, 50.00, NULL, 1, 1, '2026-05-02 05:28:45', '2026-05-02 05:28:45'),
(7, 'SAL-2026-05-0003', 3, '2026-05-02', 250.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 250.00, 0.00, 100.00, NULL, 1, 1, '2026-05-02 05:34:30', '2026-05-02 05:34:30'),
(8, 'SAL-2026-05-0004', 5, '2026-06-07', 3000.00, 5.00, 150.00, 0.00, 0.00, 10.00, 2.00, 60.00, 0.00, 0.00, 0.00, 2920.00, 1800.00, 720.00, NULL, 1, 1, '2026-05-02 05:44:27', '2026-06-08 04:00:41'),
(9, 'SAL-2026-05-0005', 2, '2026-05-02', 450.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 450.00, 0.00, 450.00, NULL, 1, 1, '2026-05-02 07:07:10', '2026-05-02 22:55:07'),
(10, 'SAL-2026-05-0006', 3, '2026-05-02', 400.00, 15.00, 60.00, 0.00, 0.00, 2.00, 3.53, 12.00, 3.53, 12.00, 0.00, 350.00, 300.00, 0.00, NULL, 1, 1, '2026-05-02 07:23:33', '2026-05-02 07:23:33'),
(11, 'SAL-2605-0001', 3, '2026-05-03', 850.00, 16.47, 140.00, 0.00, 0.00, 78.00, 23.66, 168.00, 23.66, 168.00, 0.00, 800.00, 500.00, 250.00, NULL, 1, 1, '2026-05-02 23:24:00', '2026-05-02 23:24:00'),
(12, 'SAL-2605-0002', 3, '2026-05-03', 500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 500.00, 0.00, 500.00, NULL, 1, 1, '2026-05-02 23:31:58', '2026-05-02 23:52:58'),
(13, 'SAL-2605-0003', 1, '2026-05-03', 250.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 250.00, 0.00, 250.00, NULL, 1, 1, '2026-05-02 23:35:07', '2026-05-02 23:51:14'),
(18, 'SAL-2605-0005', 3, '2026-05-05', 600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 600.00, 0.00, 600.00, NULL, 1, 1, '2026-05-05 04:52:34', '2026-05-05 05:10:02'),
(21, 'SAL-2605-0007', 3, '2026-05-05', 300.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 300.00, 300.00, 0.00, NULL, 1, 1, '2026-05-05 06:19:57', '2026-05-05 06:19:57'),
(24, 'SAL-2605-0008', 3, '2026-05-06', 600.00, 10.00, 60.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 600.00, 0.00, 600.00, NULL, 1, 1, '2026-05-05 23:51:07', '2026-05-05 23:51:07'),
(27, 'SAL-2605-0009', 3, '2026-05-06', 600.00, 12.00, 72.00, 0.00, 0.00, 0.00, 14.00, 84.00, 0.00, 0.00, 0.00, 600.00, 400.00, 200.00, NULL, 1, 1, '2026-05-05 23:52:48', '2026-05-05 23:52:48'),
(30, 'SAL-2605-0010', 3, '2026-05-06', 300.00, 12.00, 36.00, 0.00, 0.00, 24.00, 20.00, 60.00, 0.00, 0.00, 0.00, 324.00, 200.00, 124.00, NULL, 1, 1, '2026-05-06 00:09:12', '2026-05-06 00:09:12'),
(31, 'SAL-2605-0011', 3, '2026-05-06', 300.00, 10.00, 30.00, 0.00, 0.00, 15.00, 15.00, 45.00, 0.00, 0.00, 0.00, 315.00, 200.00, 115.00, NULL, 1, 1, '2026-05-06 00:12:38', '2026-05-06 00:12:38'),
(34, 'SAL-2605-0012', 4, '2026-05-07', 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 3000.00, 0.00, NULL, 1, 1, '2026-05-07 03:12:31', '2026-05-07 03:12:31'),
(39, 'SAL-2606-0001', 5, '2026-06-07', 3000.00, 5.00, 150.00, 0.00, 0.00, 10.00, 2.00, 60.00, 0.00, 0.00, 0.00, 2920.00, 1800.00, 1120.00, NULL, 1, 1, '2026-06-07 04:50:33', '2026-06-08 04:04:15'),
(47, 'SAL-2606-0002', 6, '2026-06-08', 4000.00, 10.00, 400.00, 0.00, 0.00, 20.00, 7.00, 280.00, 0.00, 0.00, 0.00, 3900.00, 3000.00, 160.00, NULL, 1, 1, '2026-06-08 04:22:59', '2026-06-08 04:40:23'),
(48, 'SAL-2609-0001', 56, '2026-09-05', 1600.00, 3.75, 60.00, 0.00, 0.00, 40.00, 12.50, 200.00, 0.00, 0.00, 0.00, 1700.00, 1500.00, 200.00, NULL, 1, 1, '2026-09-05 04:33:18', '2026-09-05 04:57:23');

-- --------------------------------------------------------

--
-- Table structure for table `inv_sale_items`
--

CREATE TABLE `inv_sale_items` (
  `id` bigint UNSIGNED NOT NULL,
  `sale_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `invoice_date` date DEFAULT NULL,
  `quantity` decimal(15,2) NOT NULL DEFAULT '0.00',
  `unit_price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `cost_price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `inventory_subtotal` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `discount_percent` decimal(8,2) NOT NULL DEFAULT '0.00',
  `discount_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `tax_percent` decimal(8,2) NOT NULL DEFAULT '0.00',
  `tax_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `net_price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `profit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_sale_items`
--

INSERT INTO `inv_sale_items` (`id`, `sale_id`, `product_id`, `invoice_date`, `quantity`, `unit_price`, `cost_price`, `inventory_subtotal`, `total_price`, `discount_percent`, `discount_amount`, `tax_percent`, `tax_amount`, `net_price`, `profit`, `remarks`, `branch_id`, `created_at`, `updated_at`) VALUES
(6, 6, 7, '2026-05-03', 1.00, 250.00, 250.00, 250.00, 250.00, 0.00, 0.00, 0.00, 0.00, 250.00, 280.00, NULL, 1, '2026-05-02 05:28:45', '2026-05-02 05:28:45'),
(8, 7, 7, '2026-05-02', 1.00, 250.00, 250.00, 250.00, 250.00, 0.00, 0.00, 0.00, 0.00, 250.00, 280.00, NULL, 1, '2026-05-02 05:34:30', '2026-05-02 05:34:30'),
(23, 10, 2, '2026-05-02', 1.00, 200.00, 200.00, 200.00, 200.00, 0.00, 0.00, 0.00, 0.00, 200.00, 300.00, NULL, 1, '2026-05-02 07:23:33', '2026-05-02 07:23:33'),
(24, 10, 2, '2026-05-02', 1.00, 200.00, 200.00, 200.00, 200.00, 0.00, 0.00, 0.00, 0.00, 200.00, 300.00, NULL, 1, '2026-05-02 07:23:33', '2026-05-02 07:23:33'),
(25, 9, 7, '2026-05-02', 1.00, 250.00, 250.00, 250.00, 250.00, 0.00, 0.00, 0.00, 0.00, 250.00, 280.00, NULL, 1, '2026-05-02 22:55:07', '2026-05-02 22:55:07'),
(26, 9, 2, '2026-05-02', 1.00, 200.00, 200.00, 200.00, 200.00, 0.00, 0.00, 0.00, 0.00, 200.00, 300.00, NULL, 1, '2026-05-02 22:55:07', '2026-05-02 22:55:07'),
(27, 11, 2, '2026-05-03', 2.00, 200.00, 200.00, 400.00, 400.00, 0.00, 0.00, 0.00, 0.00, 400.00, 300.00, NULL, 1, '2026-05-02 23:24:00', '2026-05-02 23:24:00'),
(28, 11, 1, '2026-05-03', 3.00, 100.00, 100.00, 300.00, 300.00, 0.00, 0.00, 0.00, 0.00, 300.00, 200.00, NULL, 1, '2026-05-02 23:24:00', '2026-05-02 23:24:00'),
(29, 11, 8, '2026-05-03', 1.00, 150.00, 150.00, 150.00, 150.00, 0.00, 0.00, 0.00, 0.00, 150.00, 200.00, NULL, 1, '2026-05-02 23:24:00', '2026-05-02 23:24:00'),
(35, 13, 7, '2026-05-03', 1.00, 250.00, 250.00, 250.00, 250.00, 0.00, 0.00, 0.00, 0.00, 250.00, 280.00, NULL, 1, '2026-05-02 23:51:14', '2026-05-02 23:51:14'),
(39, 12, 6, '2026-05-03', 1.00, 500.00, 500.00, 500.00, 500.00, 0.00, 0.00, 0.00, 0.00, 500.00, 600.00, NULL, 1, '2026-05-02 23:52:58', '2026-05-02 23:52:58'),
(51, 18, 2, '2026-05-05', 2.00, 300.00, 0.00, 0.00, 600.00, 0.00, 0.00, 0.00, 0.00, 600.00, 600.00, NULL, 1, '2026-05-05 04:52:34', '2026-05-05 04:52:34'),
(55, 18, 2, '2026-05-05', 2.00, 300.00, 0.00, 0.00, 600.00, 0.00, 0.00, 0.00, 0.00, 600.00, 600.00, NULL, 1, '2026-05-05 05:10:02', '2026-05-05 05:10:02'),
(58, 21, 2, '2026-05-05', 1.00, 300.00, 0.00, 0.00, 300.00, 0.00, 0.00, 0.00, 0.00, 300.00, 300.00, NULL, 1, '2026-05-05 06:19:57', '2026-05-05 06:19:57'),
(63, 24, 2, '2026-05-06', 2.00, 300.00, 200.00, 400.00, 600.00, 0.00, 0.00, 0.00, 0.00, 600.00, 200.00, NULL, 1, '2026-05-05 23:51:07', '2026-05-05 23:51:07'),
(66, 27, 2, '2026-05-06', 2.00, 300.00, 200.00, 400.00, 600.00, 0.00, 0.00, 0.00, 0.00, 600.00, 200.00, NULL, 1, '2026-05-05 23:52:48', '2026-05-05 23:52:48'),
(69, 30, 2, '2026-05-06', 1.00, 300.00, 200.00, 200.00, 300.00, 0.00, 0.00, 0.00, 0.00, 300.00, 100.00, NULL, 1, '2026-05-06 00:09:12', '2026-05-06 00:09:12'),
(70, 31, 2, '2026-05-06', 1.00, 300.00, 200.00, 200.00, 300.00, 0.00, 0.00, 0.00, 0.00, 300.00, 100.00, NULL, 1, '2026-05-06 00:12:38', '2026-05-06 00:12:38'),
(73, 34, 2, '2026-05-07', 10.00, 300.00, 200.00, 2000.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 1000.00, NULL, 1, '2026-05-07 03:12:31', '2026-05-07 03:12:31'),
(128, 8, 2, '2026-06-07', 10.00, 300.00, 170.06, 1747.20, 3000.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 1172.80, NULL, 1, '2026-06-08 04:00:41', '2026-06-08 04:00:41'),
(131, 39, 2, '2026-06-07', 10.00, 300.00, 170.06, 1747.20, 3000.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 1172.80, NULL, 1, '2026-06-08 04:04:15', '2026-06-08 04:04:15'),
(148, 47, 8, '2026-06-08', 20.00, 200.00, 142.59, 2925.00, 4000.00, 0.00, 0.00, 0.00, 0.00, 4000.00, 975.00, NULL, 1, '2026-06-08 04:40:23', '2026-06-08 04:40:23'),
(175, 48, 8, '2026-09-05', 1.00, 200.00, 179.92, 169.34, 200.00, 0.00, 0.00, 0.00, 0.00, 200.00, 43.16, NULL, 1, '2026-09-05 04:57:23', '2026-09-05 04:57:23'),
(176, 48, 7, '2026-09-05', 5.00, 280.00, 299.87, 1411.15, 1400.00, 0.00, 0.00, 0.00, 0.00, 1400.00, 76.35, NULL, 1, '2026-09-05 04:57:23', '2026-09-05 04:57:23');

-- --------------------------------------------------------

--
-- Table structure for table `inv_sale_returns`
--

CREATE TABLE `inv_sale_returns` (
  `id` bigint UNSIGNED NOT NULL,
  `invoice_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sale_id` bigint UNSIGNED NOT NULL,
  `customer_id` bigint UNSIGNED NOT NULL,
  `return_date` date NOT NULL,
  `total_return_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_refund_amount` decimal(12,2) DEFAULT '0.00',
  `adjusted_due_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `cash_refund_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `customer_advance` decimal(12,2) NOT NULL DEFAULT '0.00',
  `note` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'approved',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_sale_returns`
--

INSERT INTO `inv_sale_returns` (`id`, `invoice_no`, `sale_id`, `customer_id`, `return_date`, `total_return_amount`, `total_refund_amount`, `adjusted_due_amount`, `cash_refund_amount`, `customer_advance`, `note`, `branch_id`, `created_by`, `status`, `created_at`, `updated_at`) VALUES
(86, 'SRT-2605-0001', 34, 4, '2026-05-24', 1500.00, 2400.00, 0.00, 1600.00, 800.00, 'sds', 1, 1, 'approved', '2026-05-24 01:20:00', '2026-05-24 01:20:00'),
(87, 'SRT-2605-0002', 34, 4, '2026-05-24', 1500.00, 2400.00, 0.00, 1600.00, 800.00, 'sds', 1, 1, 'approved', '2026-05-24 01:20:00', '2026-05-24 01:20:00'),
(89, 'SRT-2605-0003', 34, 4, '2026-05-24', 1500.00, 2400.00, 0.00, 1500.00, 900.00, NULL, 1, 1, 'approved', '2026-05-24 01:26:21', '2026-05-24 01:26:21'),
(90, 'SRT-2605-0004', 34, 4, '2026-05-24', 1500.00, 2400.00, 0.00, 1500.00, 900.00, NULL, 1, 1, 'approved', '2026-05-24 01:26:21', '2026-05-24 01:26:21'),
(108, 'SRT-2605-0005', 34, 4, '2026-05-23', 1300.00, 2200.00, 0.00, 1400.00, 800.00, NULL, 1, 1, 'approved', '2026-05-24 02:56:52', '2026-05-24 02:56:52'),
(109, 'SRT-2605-0006', 34, 4, '2026-05-23', 1300.00, 2200.00, 0.00, 1400.00, 800.00, NULL, 1, 1, 'approved', '2026-05-24 03:18:01', '2026-05-24 03:18:01'),
(110, 'SRT-2605-0007', 34, 4, '2026-05-23', 1300.00, 2200.00, 0.00, 1400.00, 800.00, NULL, 1, 1, 'approved', '2026-05-24 03:18:10', '2026-05-24 03:18:10'),
(120, 'SRT-2605-0008', 34, 4, '2026-05-23', 1300.00, 2200.00, 0.00, 1400.00, 800.00, NULL, 1, 1, 'approved', '2026-05-24 04:29:04', '2026-05-24 04:29:04'),
(159, 'SRT-2606-0001', 39, 5, '2026-06-08', 900.00, 1500.00, 1100.00, 270.00, 130.00, NULL, 1, 1, 'approved', '2026-06-08 01:23:07', '2026-06-08 01:23:07'),
(160, 'SRT-2606-0002', 47, 6, '2026-06-08', 1000.00, 1600.00, 860.00, 470.00, 270.00, NULL, 1, 1, 'approved', '2026-06-08 04:24:50', '2026-06-08 04:24:50');

-- --------------------------------------------------------

--
-- Table structure for table `inv_sale_return_items`
--

CREATE TABLE `inv_sale_return_items` (
  `id` bigint UNSIGNED NOT NULL,
  `sale_return_id` bigint UNSIGNED NOT NULL,
  `sale_item_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `return_qty` decimal(12,2) NOT NULL,
  `wastage_qty` decimal(12,2) NOT NULL,
  `unit_sale_price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `return_unit_price` decimal(12,2) NOT NULL,
  `total_return_price` decimal(12,2) DEFAULT NULL,
  `total_refund_price` decimal(15,2) DEFAULT NULL,
  `cost_price` decimal(12,2) DEFAULT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_sale_return_items`
--

INSERT INTO `inv_sale_return_items` (`id`, `sale_return_id`, `sale_item_id`, `product_id`, `return_qty`, `wastage_qty`, `unit_sale_price`, `return_unit_price`, `total_return_price`, `total_refund_price`, `cost_price`, `branch_id`, `created_at`, `updated_at`) VALUES
(84, 86, 73, 2, 5.00, 3.00, 300.00, 300.00, 1500.00, 2400.00, 200.00, 1, '2026-05-24 01:20:00', '2026-05-24 01:20:00'),
(85, 87, 73, 2, 5.00, 3.00, 300.00, 300.00, 1500.00, 2400.00, 200.00, 1, '2026-05-24 01:20:00', '2026-05-24 01:20:00'),
(87, 89, 73, 2, 5.00, 3.00, 300.00, 300.00, 1500.00, 2400.00, 200.00, 1, '2026-05-24 01:26:21', '2026-05-24 01:26:21'),
(88, 90, 73, 2, 5.00, 3.00, 300.00, 300.00, 1500.00, 2400.00, 200.00, 1, '2026-05-24 01:26:21', '2026-05-24 01:26:21'),
(106, 108, 73, 2, 5.00, 3.00, 300.00, 260.00, 1300.00, 2200.00, 200.00, 1, '2026-05-24 02:56:52', '2026-05-24 02:56:52'),
(107, 109, 73, 2, 5.00, 3.00, 300.00, 260.00, 1300.00, 2200.00, 200.00, 1, '2026-05-24 03:18:01', '2026-05-24 03:18:01'),
(108, 110, 73, 2, 5.00, 3.00, 300.00, 260.00, 1300.00, 2200.00, 200.00, 1, '2026-05-24 03:18:10', '2026-05-24 03:18:10'),
(118, 120, 73, 2, 5.00, 3.00, 300.00, 260.00, 1300.00, 2200.00, 200.00, 1, '2026-05-24 04:29:04', '2026-05-24 04:29:04');

-- --------------------------------------------------------

--
-- Table structure for table `inv_stock_balances`
--

CREATE TABLE `inv_stock_balances` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `current_stock` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_stock_balances`
--

INSERT INTO `inv_stock_balances` (`id`, `product_id`, `branch_id`, `current_stock`, `created_at`, `updated_at`) VALUES
(41, 1, 1, 11, '2025-10-11 23:07:28', '2026-08-03 23:06:02'),
(42, 2, 1, 50, '2025-10-11 23:07:28', '2026-06-08 04:04:15'),
(43, 8, 1, 34, '2025-11-04 22:54:00', '2026-09-05 04:33:18'),
(44, 7, 1, 19, '2025-11-04 22:54:00', '2026-09-05 04:33:18'),
(45, 6, 1, 4, '2025-11-05 02:57:49', '2026-09-05 03:24:25'),
(46, 8, 2, 15, '2026-07-08 23:18:32', '2026-07-12 00:49:59'),
(47, 7, 2, 0, '2026-07-09 07:06:58', '2026-07-09 07:06:58');

-- --------------------------------------------------------

--
-- Table structure for table `inv_stock_movements`
--

CREATE TABLE `inv_stock_movements` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `movement_type` enum('purchase','sale','transfer_in','transfer_out','damage','purchase_return','sale_return','adjustment_in','adjustment_out','wastage') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `consumed_quantity` float DEFAULT '0',
  `unit_cost` decimal(10,2) DEFAULT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `reference_id` bigint UNSIGNED DEFAULT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `strategy` enum('fifo','lifo') COLLATE utf8mb4_unicode_ci DEFAULT 'fifo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_stock_movements`
--

INSERT INTO `inv_stock_movements` (`id`, `product_id`, `movement_type`, `quantity`, `consumed_quantity`, `unit_cost`, `unit_price`, `reference_id`, `branch_id`, `strategy`, `created_at`, `updated_at`) VALUES
(68, 2, 'purchase', 3, 3, 300.00, 200.00, 30, 1, 'fifo', '2025-11-04 01:29:28', '2026-05-02 22:55:07'),
(69, 2, 'purchase', 1, 1, 300.00, 200.00, 31, 1, 'fifo', '2025-11-04 01:32:15', '2026-05-02 23:24:00'),
(70, 2, 'purchase', 1, 1, 300.00, 200.00, 32, 1, 'fifo', '2025-11-04 01:32:33', '2026-05-02 23:24:00'),
(71, 1, 'purchase', 3, 3, 200.00, 100.00, 33, 1, 'fifo', '2025-11-04 01:33:19', '2026-05-02 23:24:00'),
(72, 2, 'purchase', 2, 2, 300.00, 200.00, 34, 1, 'fifo', '2025-11-04 01:50:18', '2026-05-04 23:57:49'),
(106, 1, 'purchase', 1, 0, 200.00, 100.00, 68, 1, 'fifo', '2025-11-04 05:20:56', '2025-11-04 05:20:56'),
(110, 2, 'purchase', 1, 1, 300.00, 200.00, 72, 1, 'fifo', '2025-11-04 05:33:27', '2026-05-04 23:57:49'),
(124, 2, 'purchase', 1, 1, 300.00, 200.00, 86, 1, 'fifo', '2025-11-04 06:35:47', '2026-05-05 00:27:54'),
(125, 8, 'purchase', 20, 20, 200.00, 150.00, 87, 1, 'fifo', '2025-11-04 22:54:00', '2026-06-08 04:22:59'),
(126, 7, 'purchase', 5, 5, 280.00, 250.00, 87, 1, 'fifo', '2025-11-04 22:54:00', '2026-05-02 22:55:07'),
(127, 8, 'purchase', 50, 41, 200.00, 150.00, 88, 1, 'fifo', '2025-11-05 00:08:41', '2026-09-05 04:57:23'),
(128, 2, 'purchase', 20, 20, 300.00, 200.00, 89, 1, 'fifo', '2025-11-05 00:47:10', '2026-05-07 03:12:31'),
(129, 2, 'purchase', 30, 30, 300.00, 200.00, 90, 1, 'fifo', '2025-11-05 01:13:02', '2026-06-08 01:24:41'),
(130, 2, 'purchase', 30, 30, 300.00, 200.00, 91, 1, 'fifo', '2025-11-05 01:18:07', '2026-06-08 03:57:49'),
(148, 2, 'purchase', 30, 30, 300.00, 200.00, 109, 1, 'fifo', '2025-11-05 01:51:10', '2026-06-08 04:04:15'),
(150, 6, 'purchase', 3, 3, 600.00, 500.00, 110, 1, 'fifo', '2025-11-05 03:25:02', '2026-05-02 23:52:58'),
(152, 7, 'purchase', 5, 5, 280.00, 250.00, 111, 1, 'fifo', '2025-11-23 23:59:29', '2026-05-02 23:51:14'),
(158, 7, 'sale', 1, 0, 280.00, 250.00, 6, 1, 'fifo', '2026-05-02 05:28:45', '2026-05-02 05:28:45'),
(160, 7, 'sale', 1, 0, 280.00, 250.00, 7, 1, 'fifo', '2026-05-02 05:34:30', '2026-05-02 05:34:30'),
(166, 2, 'sale', 1, 0, 300.00, 200.00, 10, 1, 'fifo', '2026-05-02 07:23:33', '2026-05-02 07:23:33'),
(167, 2, 'sale', 1, 0, 300.00, 200.00, 10, 1, 'fifo', '2026-05-02 07:23:33', '2026-05-02 07:23:33'),
(168, 7, 'sale', 1, 0, 280.00, 250.00, 9, 1, 'fifo', '2026-05-02 22:55:07', '2026-05-02 22:55:07'),
(169, 2, 'sale', 1, 0, 300.00, 200.00, 9, 1, 'fifo', '2026-05-02 22:55:07', '2026-05-02 22:55:07'),
(170, 2, 'sale', 2, 0, 300.00, 200.00, 11, 1, 'fifo', '2026-05-02 23:24:00', '2026-05-02 23:24:00'),
(171, 1, 'sale', 3, 0, 200.00, 100.00, 11, 1, 'fifo', '2026-05-02 23:24:00', '2026-05-02 23:24:00'),
(172, 8, 'sale', 1, 0, 200.00, 150.00, 11, 1, 'fifo', '2026-05-02 23:24:00', '2026-05-02 23:24:00'),
(178, 7, 'sale', 1, 0, 280.00, 250.00, 13, 1, 'fifo', '2026-05-02 23:51:14', '2026-05-02 23:51:14'),
(180, 6, 'sale', 1, 0, 600.00, 500.00, 12, 1, 'fifo', '2026-05-02 23:52:58', '2026-05-02 23:52:58'),
(186, 2, 'sale', 2, NULL, NULL, 300.00, 18, 1, 'fifo', '2026-05-05 04:52:34', '2026-05-05 04:52:34'),
(190, 2, 'sale', 2, NULL, NULL, 300.00, 18, 1, 'fifo', '2026-05-05 05:10:02', '2026-05-05 05:10:02'),
(193, 2, 'sale', 1, NULL, 0.00, 300.00, 21, 1, 'fifo', '2026-05-05 06:19:57', '2026-05-05 06:19:57'),
(194, 2, 'sale', 2, NULL, 200.00, 300.00, 24, 1, 'fifo', '2026-05-05 23:51:07', '2026-05-05 23:51:07'),
(197, 2, 'sale', 2, 2, 200.00, 300.00, 27, 1, 'fifo', '2026-05-05 23:52:48', '2026-06-01 23:41:44'),
(200, 2, 'sale', 1, NULL, 200.00, 300.00, 30, 1, 'fifo', '2026-05-06 00:09:12', '2026-05-06 00:09:12'),
(201, 2, 'sale', 1, NULL, 200.00, 300.00, 31, 1, 'fifo', '2026-05-06 00:12:38', '2026-05-06 00:12:38'),
(203, 7, 'purchase', 5, 5, 250.00, 250.00, 111, 1, 'fifo', '2026-05-06 00:31:32', '2026-09-05 04:33:18'),
(206, 2, 'sale', 10, 8, 200.00, 300.00, 34, 1, 'fifo', '2026-05-07 03:12:31', '2026-05-24 04:29:04'),
(213, 2, 'sale_return', 5, 5, 200.00, 260.00, 120, 1, 'fifo', '2026-05-24 04:29:04', '2026-06-08 04:04:15'),
(214, 2, 'wastage', 3, NULL, 200.00, 300.00, 120, 1, 'fifo', '2026-05-24 04:29:04', '2026-05-24 04:29:04'),
(308, 2, 'sale_return', 3, 3, 189.48, 300.00, 159, 1, 'fifo', '2026-06-08 01:23:08', '2026-06-08 04:04:15'),
(309, 2, 'wastage', 2, NULL, 189.48, 300.00, 159, 1, 'fifo', '2026-06-08 01:23:08', '2026-06-08 01:23:08'),
(315, 2, 'sale', 10, NULL, 170.06, 300.00, 8, 1, 'fifo', '2026-06-08 04:00:41', '2026-06-08 04:00:41'),
(316, 2, 'sale', 10, 5, 170.06, 300.00, 39, 1, 'fifo', '2026-06-08 04:04:15', '2026-06-08 04:04:15'),
(326, 8, 'sale_return', 5, 0, 146.25, 200.00, 160, 1, 'fifo', '2026-06-08 04:24:50', '2026-06-08 04:24:50'),
(327, 8, 'wastage', 3, NULL, 146.25, 200.00, 160, 1, 'fifo', '2026-06-08 04:24:50', '2026-06-08 04:24:50'),
(328, 8, 'sale', 20, 8, 142.59, 200.00, 47, 1, 'fifo', '2026-06-08 04:40:23', '2026-06-08 04:40:23'),
(330, 7, 'purchase', 5, 5, 250.00, 250.00, 113, 1, 'fifo', '2026-06-11 05:24:36', '2026-09-05 04:34:02'),
(388, 7, 'purchase_return', 2, NULL, 250.00, 240.00, 30, 1, 'fifo', '2026-06-18 00:16:08', '2026-06-18 00:16:08'),
(389, 7, 'wastage', 1, NULL, 250.00, 250.00, 30, 1, 'fifo', '2026-06-18 00:16:08', '2026-06-18 00:16:08'),
(394, 6, 'purchase', 10, 5, 250.00, 250.00, 118, 1, 'fifo', '2026-06-18 05:12:30', '2026-06-18 05:47:59'),
(395, 6, 'purchase_return', 2, NULL, 250.00, 240.00, 31, 1, 'fifo', '2026-06-18 05:13:51', '2026-06-18 05:13:51'),
(396, 6, 'wastage', 1, NULL, 250.00, 250.00, 31, 1, 'fifo', '2026-06-18 05:13:51', '2026-06-18 05:13:51'),
(397, 6, 'purchase_return', 2, NULL, 250.00, 240.00, 33, 1, 'fifo', '2026-06-18 05:44:22', '2026-06-18 05:44:22'),
(398, 6, 'wastage', 1, NULL, 250.00, 250.00, 33, 1, 'fifo', '2026-06-18 05:44:22', '2026-06-18 05:44:22'),
(401, 6, 'purchase_return', 2, NULL, 250.00, 250.00, 36, 1, 'fifo', '2026-06-18 05:47:59', '2026-06-18 05:47:59'),
(402, 6, 'wastage', 1, NULL, 250.00, 250.00, 36, 1, 'fifo', '2026-06-18 05:47:59', '2026-06-18 05:47:59'),
(403, 7, 'purchase', 10, 10, 250.00, 250.00, 119, 1, 'fifo', '2026-06-18 06:02:44', '2026-09-05 04:57:23'),
(405, 7, 'wastage', 1, NULL, 250.00, 250.00, 39, 1, 'fifo', '2026-06-18 06:03:05', '2026-06-18 06:03:05'),
(438, 8, 'transfer_out', 4, NULL, 0.00, 0.00, 25, 1, 'fifo', '2026-07-12 00:48:17', '2026-07-12 00:48:17'),
(439, 8, 'transfer_in', 4, NULL, 0.00, 0.00, 25, 2, 'fifo', '2026-07-12 00:48:17', '2026-07-12 00:48:17'),
(440, 8, 'transfer_out', 7, NULL, 0.00, 0.00, 26, 1, 'fifo', '2026-07-12 00:49:34', '2026-07-12 00:49:34'),
(441, 8, 'transfer_in', 7, NULL, 0.00, 0.00, 26, 2, 'fifo', '2026-07-12 00:49:34', '2026-07-12 00:49:34'),
(442, 8, 'transfer_out', 4, NULL, 0.00, 0.00, 27, 1, 'fifo', '2026-07-12 00:49:59', '2026-07-12 00:49:59'),
(443, 8, 'transfer_in', 4, NULL, 0.00, 0.00, 27, 2, 'fifo', '2026-07-12 00:49:59', '2026-07-12 00:49:59'),
(444, 8, 'transfer_out', 1, NULL, 0.00, 0.00, 1, 1, 'fifo', '2026-07-12 05:55:49', '2026-07-12 05:55:49'),
(446, 1, 'purchase', 10, 0, 100.00, 100.00, 124, 1, 'fifo', '2026-08-03 23:06:02', '2026-08-03 23:06:02'),
(451, 7, 'purchase', 1, 1, 250.00, 250.00, 129, 1, 'fifo', '2026-09-01 06:27:41', '2026-09-05 04:57:23'),
(453, 6, 'purchase', 1, 0, 500.00, 500.00, 130, 1, 'fifo', '2026-09-05 03:24:25', '2026-09-05 03:24:25'),
(469, 7, 'purchase', 1, 1, 250.00, 250.00, 137, 1, 'fifo', '2026-09-05 03:59:04', '2026-09-05 04:57:23'),
(497, 7, 'sale', 5, 0, 299.87, 280.00, 48, 1, 'fifo', '2026-09-05 04:57:23', '2026-09-05 04:57:23');

-- --------------------------------------------------------

--
-- Table structure for table `inv_stock_transfers`
--

CREATE TABLE `inv_stock_transfers` (
  `id` bigint UNSIGNED NOT NULL,
  `transfer_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_branch_id` bigint UNSIGNED NOT NULL,
  `to_branch_id` bigint UNSIGNED NOT NULL,
  `transfer_date` date NOT NULL,
  `total_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'completed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_stock_transfers`
--

INSERT INTO `inv_stock_transfers` (`id`, `transfer_no`, `from_branch_id`, `to_branch_id`, `transfer_date`, `total_amount`, `note`, `created_by`, `status`, `created_at`, `updated_at`) VALUES
(25, 'TRF-2607-0001', 1, 2, '2026-07-12', 600.00, NULL, 1, 'completed', '2026-07-12 00:48:17', '2026-07-12 00:48:17'),
(26, 'TRF-2607-0002', 1, 2, '2026-07-12', 1050.00, NULL, 1, 'completed', '2026-07-12 00:49:34', '2026-07-12 00:49:34'),
(27, 'TRF-2607-0003', 1, 2, '2026-07-12', 600.00, NULL, 1, 'completed', '2026-07-12 00:49:59', '2026-07-12 00:49:59');

-- --------------------------------------------------------

--
-- Table structure for table `inv_stock_transfer_items`
--

CREATE TABLE `inv_stock_transfer_items` (
  `id` bigint UNSIGNED NOT NULL,
  `stock_transfer_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `quantity` decimal(12,2) NOT NULL DEFAULT '0.00',
  `unit_cost` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `total_cost` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_stock_transfer_items`
--

INSERT INTO `inv_stock_transfer_items` (`id`, `stock_transfer_id`, `product_id`, `quantity`, `unit_cost`, `total_cost`, `created_at`, `updated_at`) VALUES
(24, 25, 8, 4.00, 150.0000, 600.0000, '2026-07-12 00:48:17', '2026-07-12 00:48:17'),
(25, 26, 8, 7.00, 150.0000, 1050.0000, '2026-07-12 00:49:34', '2026-07-12 00:49:34'),
(26, 27, 8, 4.00, 150.0000, 600.0000, '2026-07-12 00:49:59', '2026-07-12 00:49:59');

-- --------------------------------------------------------

--
-- Table structure for table `inv_suppliers`
--

CREATE TABLE `inv_suppliers` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `previous_due` decimal(12,2) DEFAULT '0.00',
  `advance_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_suppliers`
--

INSERT INTO `inv_suppliers` (`id`, `name`, `phone`, `email`, `address`, `previous_due`, `advance_amount`, `status`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 'ABC Supplies Ltd.', '01712345678', 'abc@supplies.com', '123 Supplier Street, Dhaka', 1500.00, 500.00, 1, 1, '2025-08-24 06:16:17', '2025-09-23 02:51:15'),
(4, 'New User', '01712345678', NULL, NULL, 0.00, 0.00, 1, 1, '2025-08-28 03:35:53', '2025-09-23 03:55:58'),
(8, 'Mamun', '554', NULL, NULL, 0.00, 0.00, 1, 1, '2025-11-03 03:16:00', '2025-11-03 03:16:00'),
(9, 'Nadim', '45445', NULL, NULL, 0.00, 0.00, 1, 1, '2025-11-03 03:28:42', '2025-11-03 03:28:42'),
(10, 'Sakib', '88', NULL, NULL, 0.00, 0.00, 1, 1, '2025-11-03 03:29:00', '2025-11-03 03:29:00'),
(11, 'Riaz', '45545454', NULL, NULL, 0.00, 0.00, 1, 1, '2026-06-18 00:30:55', '2026-06-18 00:30:55'),
(12, 'Amin', '78454554', NULL, NULL, 0.00, 0.00, 1, 1, '2026-06-18 06:02:20', '2026-06-18 06:02:20'),
(21, 'ABC Supplies Ltd.', '01712345678', 'abc@supplies.com', '123 Supplier Street, Dhaka', 1500.00, 500.00, 1, 1, '2026-09-01 06:09:54', '2026-09-01 06:09:54'),
(32, 'Shahin', '455454454', NULL, NULL, 0.00, 0.00, 1, 1, '2026-09-01 06:19:30', '2026-09-01 06:19:30'),
(33, 'Wadud', NULL, NULL, NULL, 0.00, 0.00, 1, 1, '2026-09-05 03:13:11', '2026-09-05 03:13:11');

-- --------------------------------------------------------

--
-- Table structure for table `inv_supplier_advances`
--

CREATE TABLE `inv_supplier_advances` (
  `id` bigint UNSIGNED NOT NULL,
  `supplier_id` bigint UNSIGNED NOT NULL,
  `advance_amount` decimal(15,2) NOT NULL,
  `adjusted_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `remaining_amount` decimal(15,2) GENERATED ALWAYS AS ((`advance_amount` - `adjusted_amount`)) VIRTUAL,
  `date` date NOT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `type` enum('advance','adjustment') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'advance',
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_supplier_advances`
--

INSERT INTO `inv_supplier_advances` (`id`, `supplier_id`, `advance_amount`, `adjusted_amount`, `date`, `payment_method`, `reference_no`, `note`, `type`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 4, 5000.00, 0.00, '2025-09-22', NULL, 'ADV-0001', 'Advance payment for upcoming order', 'advance', 1, '2025-09-23 01:50:50', '2025-09-23 01:52:16'),
(3, 4, 1000.00, 0.00, '2025-09-23', NULL, 'ADV-0002', NULL, 'advance', 1, '2025-09-23 04:47:00', '2025-09-23 04:47:00');

-- --------------------------------------------------------

--
-- Table structure for table `inv_supplier_ledgers`
--

CREATE TABLE `inv_supplier_ledgers` (
  `id` bigint UNSIGNED NOT NULL,
  `supplier_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `transaction_type` enum('opening_balance','advance','purchase','payment','advance_adjust','adjustment','purchase_return','due_payment','due_payment_adjust','return_due_adjust','return_advance_adjust','return_cash_refund','return_advance','tex_amount') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `debit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `credit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `balance` decimal(15,2) DEFAULT NULL,
  `reference_id` bigint UNSIGNED NOT NULL,
  `reference_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_supplier_ledgers`
--

INSERT INTO `inv_supplier_ledgers` (`id`, `supplier_id`, `date`, `transaction_type`, `debit`, `credit`, `balance`, `reference_id`, `reference_no`, `note`, `branch_id`, `created_at`, `updated_at`) VALUES
(3, 4, '2025-09-22', 'advance', 5000.00, 0.00, 5000.00, 1, 'ADV-0001', 'Advance payment for upcoming order', 1, '2025-09-23 01:52:16', '2025-09-23 01:52:16'),
(8, 1, '2025-09-23', 'opening_balance', 0.00, 1500.00, 1500.00, 1, 'SPD-0001', NULL, 1, '2025-09-23 02:51:15', '2025-09-23 02:51:15'),
(10, 4, '2025-09-23', 'advance', 1000.00, 0.00, 6000.00, 3, 'ADV-0002', NULL, 1, '2025-09-23 04:47:00', '2025-09-23 04:47:00'),
(37, 1, '2025-11-04', 'purchase', 0.00, 600.00, -6415.00, 30, 'INV-2025-11-0001', NULL, 1, '2025-11-04 01:29:28', '2025-11-04 01:29:28'),
(38, 1, '2025-11-04', 'purchase', 0.00, 200.00, -6615.00, 31, 'INV-2025-11-0002', NULL, 1, '2025-11-04 01:32:15', '2025-11-04 01:32:15'),
(39, 1, '2025-11-04', 'purchase', 0.00, 200.00, -6815.00, 32, 'INV-2025-11-0003', NULL, 1, '2025-11-04 01:32:33', '2025-11-04 01:32:33'),
(40, 1, '2025-11-04', 'purchase', 0.00, 300.00, -7115.00, 33, 'INV-2025-11-0004', NULL, 1, '2025-11-04 01:33:19', '2025-11-04 01:33:19'),
(41, 1, '2025-11-04', 'purchase', 0.00, 400.00, -7515.00, 34, 'INV-2025-11-0005', NULL, 1, '2025-11-04 01:50:18', '2025-11-04 01:50:18'),
(58, 1, '2025-11-04', 'purchase', 0.00, 81.70, -7596.70, 68, 'INV-2025-11-0006', NULL, 1, '2025-11-04 05:20:56', '2025-11-04 05:20:56'),
(61, 1, '2025-11-04', 'purchase', 0.00, 174.35, -7771.05, 72, 'INV-2025-11-0007', NULL, 1, '2025-11-04 05:33:27', '2025-11-04 05:33:27'),
(69, 10, '2025-11-05', 'purchase', 0.00, 5900.00, -5900.00, 109, 'INV-2025-11-0014', NULL, 1, '2025-11-05 01:51:10', '2025-11-05 01:51:10'),
(71, 8, '2025-11-05', 'purchase', 0.00, 400.00, -400.00, 110, 'INV-2025-11-0015', NULL, 1, '2025-11-05 03:25:03', '2025-11-05 03:25:03'),
(73, 4, '2026-05-06', 'purchase', 0.00, 1270.00, 4730.00, 111, 'INV-2025-11-0016', NULL, 1, '2026-05-06 00:31:32', '2026-05-06 00:31:32'),
(74, 9, '2026-06-11', 'purchase', 0.00, 1250.00, -1250.00, 113, 'INV-2026-06-0001', NULL, 1, '2026-06-11 05:24:36', '2026-06-11 05:24:36'),
(75, 9, '2026-06-11', 'payment', 1200.00, 0.00, -50.00, 113, 'INV-2026-06-0001', NULL, 1, '2026-06-11 05:24:36', '2026-06-11 05:24:36'),
(77, 10, '2026-06-13', 'due_payment', 900.00, 0.00, -5000.00, 2, 'SDP-2606-0001', NULL, 1, '2026-06-12 22:48:20', '2026-06-12 22:48:20'),
(90, 10, '2026-06-13', 'due_payment', 550.00, 0.00, -4450.00, 10, 'SDP-2606-0002', NULL, 1, '2026-06-12 23:09:40', '2026-06-12 23:09:40'),
(91, 10, '2026-06-13', 'due_payment_adjust', 50.00, 0.00, -4400.00, 10, 'SDP-2606-0002', NULL, 1, '2026-06-12 23:09:40', '2026-06-12 23:09:40'),
(116, 9, '2026-06-18', 'return_due_adjust', 50.00, 0.00, 0.00, 30, 'PRT-2606-0001', NULL, 1, '2026-06-18 00:16:08', '2026-06-18 00:16:08'),
(117, 9, '2026-06-18', 'return_cash_refund', 600.00, 0.00, 600.00, 30, 'PRT-2606-0001', NULL, 1, '2026-06-18 00:16:08', '2026-06-18 00:16:08'),
(118, 9, '2026-06-18', 'return_advance', 80.00, 0.00, 680.00, 30, 'PRT-2606-0001', NULL, 1, '2026-06-18 00:16:08', '2026-06-18 00:16:08'),
(119, 11, '2026-06-18', 'purchase', 0.00, 2500.00, -2500.00, 118, 'INV-2026-06-0002', NULL, 1, '2026-06-18 05:12:30', '2026-06-18 05:12:30'),
(120, 11, '2026-06-18', 'payment', 2200.00, 0.00, -300.00, 118, 'INV-2026-06-0002', NULL, 1, '2026-06-18 05:12:30', '2026-06-18 05:12:30'),
(121, 11, '2026-06-18', 'due_payment', 200.00, 0.00, -100.00, 11, 'SDP-2606-0003', NULL, 1, '2026-06-18 05:13:17', '2026-06-18 05:13:17'),
(122, 11, '2026-06-18', 'due_payment_adjust', 50.00, 0.00, -50.00, 11, 'SDP-2606-0003', NULL, 1, '2026-06-18 05:13:17', '2026-06-18 05:13:17'),
(123, 11, '2026-06-18', 'return_due_adjust', 50.00, 0.00, 0.00, 31, 'PRT-2606-0002', NULL, 1, '2026-06-18 05:13:51', '2026-06-18 05:13:51'),
(124, 11, '2026-06-18', 'return_cash_refund', 600.00, 0.00, 600.00, 31, 'PRT-2606-0002', NULL, 1, '2026-06-18 05:13:51', '2026-06-18 05:13:51'),
(125, 11, '2026-06-18', 'return_advance', 80.00, 0.00, 680.00, 31, 'PRT-2606-0002', NULL, 1, '2026-06-18 05:13:51', '2026-06-18 05:13:51'),
(126, 11, '2026-06-18', 'return_cash_refund', 700.00, 0.00, 1380.00, 33, 'PRT-2606-0003', NULL, 1, '2026-06-18 05:44:23', '2026-06-18 05:44:23'),
(127, 11, '2026-06-18', 'return_advance', 30.00, 0.00, 1410.00, 33, 'PRT-2606-0003', NULL, 1, '2026-06-18 05:44:23', '2026-06-18 05:44:23'),
(128, 11, '2026-06-18', 'return_cash_refund', 750.00, 0.00, 2160.00, 36, 'PRT-2606-0004', NULL, 1, '2026-06-18 05:47:59', '2026-06-18 05:47:59'),
(129, 12, '2026-06-18', 'purchase', 0.00, 2500.00, -2500.00, 119, 'INV-2026-06-0003', NULL, 1, '2026-06-18 06:02:44', '2026-06-18 06:02:44'),
(130, 12, '2026-06-18', 'payment', 2450.00, 0.00, -50.00, 119, 'INV-2026-06-0003', NULL, 1, '2026-06-18 06:02:44', '2026-06-18 06:02:44'),
(134, 11, '2026-08-04', 'purchase', 0.00, 1000.00, 1160.00, 124, 'INV-2026-08-0001', NULL, 1, '2026-08-03 23:06:03', '2026-08-03 23:06:03'),
(137, 21, '2026-09-01', 'opening_balance', 0.00, 1500.00, -1500.00, 21, 'SPD-0013', NULL, 1, '2026-09-01 06:09:54', '2026-09-01 06:09:54'),
(146, 32, '2026-09-01', 'purchase', 0.00, 250.00, -250.00, 129, 'INV-2026-09-0001', NULL, 1, '2026-09-01 06:27:41', '2026-09-01 06:27:41'),
(147, 32, '2026-09-01', 'payment', 100.00, 0.00, -150.00, 129, 'INV-2026-09-0001', NULL, 1, '2026-09-01 06:27:41', '2026-09-01 06:27:41'),
(148, 33, '2026-09-05', 'purchase', 0.00, 650.00, -650.00, 130, 'INV-2026-09-0002', 'dfdf', 1, '2026-09-05 03:24:25', '2026-09-05 03:24:25'),
(149, 33, '2026-09-05', 'tex_amount', 0.00, 31.53, -681.53, 130, 'INV-2026-09-0002', 'dfdf', 1, '2026-09-05 03:24:25', '2026-09-05 03:24:25'),
(150, 33, '2026-09-05', 'payment', 600.00, 0.00, -81.53, 130, 'INV-2026-09-0002', 'dfdf', 1, '2026-09-05 03:24:25', '2026-09-05 03:24:25'),
(151, 33, '2026-09-05', 'adjustment', 21.50, 0.00, -60.03, 130, 'INV-2026-09-0002', 'dfdf', 1, '2026-09-05 03:24:25', '2026-09-05 03:24:25'),
(180, 33, '2026-09-05', 'purchase', 0.00, 400.00, -460.03, 137, 'INV-2026-09-0003', NULL, 1, '2026-09-05 03:59:04', '2026-09-05 03:59:04'),
(181, 33, '2026-09-05', 'tex_amount', 0.00, 30.00, -490.03, 137, 'INV-2026-09-0003', NULL, 1, '2026-09-05 03:59:04', '2026-09-05 03:59:04'),
(182, 33, '2026-09-05', 'payment', 300.00, 0.00, -190.03, 137, 'INV-2026-09-0003', NULL, 1, '2026-09-05 03:59:04', '2026-09-05 03:59:04'),
(183, 33, '2026-09-05', 'adjustment', 30.00, 0.00, -160.03, 137, 'INV-2026-09-0003', NULL, 1, '2026-09-05 03:59:04', '2026-09-05 03:59:04');

-- --------------------------------------------------------

--
-- Table structure for table `inv_supplier_payments`
--

CREATE TABLE `inv_supplier_payments` (
  `id` bigint UNSIGNED NOT NULL,
  `invoice_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_id` bigint UNSIGNED NOT NULL,
  `payment_date` date NOT NULL,
  `payment` decimal(10,2) NOT NULL DEFAULT '0.00',
  `adjustment` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `note` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_supplier_payments`
--

INSERT INTO `inv_supplier_payments` (`id`, `invoice_no`, `supplier_id`, `payment_date`, `payment`, `adjustment`, `total_amount`, `note`, `branch_id`, `created_by`, `created_at`, `updated_at`) VALUES
(2, 'SDP-2606-0001', 10, '2026-06-13', 900.00, 0.00, 900.00, NULL, 1, 1, '2026-06-12 22:48:20', '2026-06-12 22:48:20'),
(10, 'SDP-2606-0002', 10, '2026-06-13', 550.00, 50.00, 600.00, NULL, 1, 1, '2026-06-12 23:09:40', '2026-06-12 23:09:40'),
(11, 'SDP-2606-0003', 11, '2026-06-18', 200.00, 50.00, 250.00, NULL, 1, 1, '2026-06-18 05:13:17', '2026-06-18 05:13:17');

-- --------------------------------------------------------

--
-- Table structure for table `inv_units`
--

CREATE TABLE `inv_units` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_units`
--

INSERT INTO `inv_units` (`id`, `name`, `short_code`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 'Kg', 'Kg', 1, '2025-08-24 05:39:30', '2025-08-24 05:39:30'),
(2, 'Pc', 'pc', 1, '2025-08-26 04:20:09', '2025-08-26 04:20:09');

-- --------------------------------------------------------

--
-- Table structure for table `inv_user_logs`
--

CREATE TABLE `inv_user_logs` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_id` bigint UNSIGNED DEFAULT NULL,
  `old_data` json DEFAULT NULL,
  `new_data` json DEFAULT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_user_logs`
--

INSERT INTO `inv_user_logs` (`id`, `user_id`, `action`, `module`, `reference_id`, `old_data`, `new_data`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'purchase_created', 'purchase', 25, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-10-11\\\",\\\"discount_percent\\\":5,\\\"discount_amount\\\":350,\\\"tax_percent\\\":10,\\\"paid_amount\\\":500,\\\"invoice_no\\\":\\\"INV-2025-10-0001\\\",\\\"total_amount\\\":7000,\\\"tax_amount\\\":665,\\\"net_total\\\":7315,\\\"due_amount\\\":6815,\\\"updated_at\\\":\\\"2025-10-12T05:07:28.000000Z\\\",\\\"created_at\\\":\\\"2025-10-12T05:07:28.000000Z\\\",\\\"id\\\":25}\"', '{\"id\": 25, \"branch_id\": 1, \"net_total\": 7315, \"created_at\": \"2025-10-12T05:07:28.000000Z\", \"created_by\": 1, \"due_amount\": 6815, \"invoice_no\": \"INV-2025-10-0001\", \"tax_amount\": 665, \"updated_at\": \"2025-10-12T05:07:28.000000Z\", \"paid_amount\": 500, \"supplier_id\": 1, \"tax_percent\": 10, \"invoice_date\": \"2025-10-11\", \"total_amount\": 7000, \"discount_amount\": 350, \"discount_percent\": 5}', 1, '2025-10-11 23:07:28', NULL),
(2, 1, 'purchase_updated', 'purchase', 25, '\"{\\\"id\\\":25,\\\"invoice_no\\\":\\\"INV-2025-10-0001\\\",\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-10-11\\\",\\\"total_amount\\\":7000,\\\"discount_percent\\\":5,\\\"discount_amount\\\":350,\\\"tax_percent\\\":10,\\\"tax_amount\\\":665,\\\"supplier_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":7315,\\\"paid_amount\\\":500,\\\"due_amount\\\":6815,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2025-10-12T05:07:28.000000Z\\\",\\\"updated_at\\\":\\\"2025-10-12T05:23:34.000000Z\\\"}\"', '{\"id\": 25, \"remarks\": null, \"branch_id\": 1, \"net_total\": 7315, \"created_at\": \"2025-10-12T05:07:28.000000Z\", \"created_by\": 1, \"due_amount\": 6815, \"invoice_no\": \"INV-2025-10-0001\", \"tax_amount\": 665, \"updated_at\": \"2025-10-12T05:23:34.000000Z\", \"paid_amount\": 500, \"supplier_id\": 1, \"tax_percent\": 10, \"invoice_date\": \"2025-10-11\", \"total_amount\": 7000, \"discount_amount\": 350, \"supplier_adjust\": \"0.00\", \"discount_percent\": 5}', 1, '2025-10-11 23:23:34', NULL),
(3, 1, 'purchase_updated', 'purchase', 25, '\"{\\\"id\\\":25,\\\"invoice_no\\\":\\\"INV-2025-10-0001\\\",\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-10-11\\\",\\\"total_amount\\\":7000,\\\"discount_percent\\\":5,\\\"discount_amount\\\":350,\\\"tax_percent\\\":10,\\\"tax_amount\\\":665,\\\"supplier_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":7315,\\\"paid_amount\\\":500,\\\"due_amount\\\":6815,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2025-10-12T05:07:28.000000Z\\\",\\\"updated_at\\\":\\\"2025-10-12T05:24:09.000000Z\\\"}\"', '{\"id\": 25, \"remarks\": null, \"branch_id\": 1, \"net_total\": 7315, \"created_at\": \"2025-10-12T05:07:28.000000Z\", \"created_by\": 1, \"due_amount\": 6815, \"invoice_no\": \"INV-2025-10-0001\", \"tax_amount\": 665, \"updated_at\": \"2025-10-12T05:24:09.000000Z\", \"paid_amount\": 500, \"supplier_id\": 1, \"tax_percent\": 10, \"invoice_date\": \"2025-10-11\", \"total_amount\": 7000, \"discount_amount\": 350, \"supplier_adjust\": \"0.00\", \"discount_percent\": 5}', 1, '2025-10-11 23:24:09', NULL),
(4, 1, 'purchase_updated', 'purchase', 25, '\"{\\\"id\\\":25,\\\"invoice_no\\\":\\\"INV-2025-10-0001\\\",\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-10-11\\\",\\\"total_amount\\\":7000,\\\"discount_percent\\\":5,\\\"discount_amount\\\":350,\\\"tax_percent\\\":10,\\\"tax_amount\\\":665,\\\"supplier_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":7315,\\\"paid_amount\\\":500,\\\"due_amount\\\":6815,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2025-10-12T05:07:28.000000Z\\\",\\\"updated_at\\\":\\\"2025-10-12T05:30:41.000000Z\\\"}\"', '{\"id\": 25, \"remarks\": null, \"branch_id\": 1, \"net_total\": 7315, \"created_at\": \"2025-10-12T05:07:28.000000Z\", \"created_by\": 1, \"due_amount\": 6815, \"invoice_no\": \"INV-2025-10-0001\", \"tax_amount\": 665, \"updated_at\": \"2025-10-12T05:30:41.000000Z\", \"paid_amount\": 500, \"supplier_id\": 1, \"tax_percent\": 10, \"invoice_date\": \"2025-10-11\", \"total_amount\": 7000, \"discount_amount\": 350, \"supplier_adjust\": \"0.00\", \"discount_percent\": 5}', 1, '2025-10-11 23:30:41', NULL),
(5, 1, 'purchase_updated', 'purchase', 25, '\"{\\\"id\\\":25,\\\"invoice_no\\\":\\\"INV-2025-10-0001\\\",\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-10-11\\\",\\\"total_amount\\\":7000,\\\"discount_percent\\\":5,\\\"discount_amount\\\":350,\\\"tax_percent\\\":10,\\\"tax_amount\\\":665,\\\"supplier_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":7315,\\\"paid_amount\\\":500,\\\"due_amount\\\":6815,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2025-10-12T05:07:28.000000Z\\\",\\\"updated_at\\\":\\\"2025-10-12T05:39:47.000000Z\\\"}\"', '{\"id\": 25, \"remarks\": null, \"branch_id\": 1, \"net_total\": 7315, \"created_at\": \"2025-10-12T05:07:28.000000Z\", \"created_by\": 1, \"due_amount\": 6815, \"invoice_no\": \"INV-2025-10-0001\", \"tax_amount\": 665, \"updated_at\": \"2025-10-12T05:39:47.000000Z\", \"paid_amount\": 500, \"supplier_id\": 1, \"tax_percent\": 10, \"invoice_date\": \"2025-10-11\", \"total_amount\": 7000, \"discount_amount\": 350, \"supplier_adjust\": \"0.00\", \"discount_percent\": 5}', 1, '2025-10-11 23:39:47', NULL),
(6, 1, 'purchase_updated', 'purchase', 25, '\"{\\\"id\\\":25,\\\"invoice_no\\\":\\\"INV-2025-10-0001\\\",\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-10-11\\\",\\\"total_amount\\\":7000,\\\"discount_percent\\\":5,\\\"discount_amount\\\":350,\\\"tax_percent\\\":10,\\\"tax_amount\\\":665,\\\"supplier_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":7315,\\\"paid_amount\\\":500,\\\"due_amount\\\":6815,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2025-10-12T05:07:28.000000Z\\\",\\\"updated_at\\\":\\\"2025-10-12T05:40:01.000000Z\\\"}\"', '{\"id\": 25, \"remarks\": null, \"branch_id\": 1, \"net_total\": 7315, \"created_at\": \"2025-10-12T05:07:28.000000Z\", \"created_by\": 1, \"due_amount\": 6815, \"invoice_no\": \"INV-2025-10-0001\", \"tax_amount\": 665, \"updated_at\": \"2025-10-12T05:40:01.000000Z\", \"paid_amount\": 500, \"supplier_id\": 1, \"tax_percent\": 10, \"invoice_date\": \"2025-10-11\", \"total_amount\": 7000, \"discount_amount\": 350, \"supplier_adjust\": \"0.00\", \"discount_percent\": 5}', 1, '2025-10-11 23:40:01', NULL),
(7, 1, 'purchase_updated', 'purchase', 25, '\"{\\\"id\\\":25,\\\"invoice_no\\\":\\\"INV-2025-10-0001\\\",\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-10-11\\\",\\\"total_amount\\\":7000,\\\"discount_percent\\\":5,\\\"discount_amount\\\":350,\\\"tax_percent\\\":10,\\\"tax_amount\\\":665,\\\"supplier_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":7315,\\\"paid_amount\\\":500,\\\"due_amount\\\":6815,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2025-10-12T05:07:28.000000Z\\\",\\\"updated_at\\\":\\\"2025-10-12T05:47:12.000000Z\\\"}\"', '{\"id\": 25, \"remarks\": null, \"branch_id\": 1, \"net_total\": 7315, \"created_at\": \"2025-10-12T05:07:28.000000Z\", \"created_by\": 1, \"due_amount\": 6815, \"invoice_no\": \"INV-2025-10-0001\", \"tax_amount\": 665, \"updated_at\": \"2025-10-12T05:47:12.000000Z\", \"paid_amount\": 500, \"supplier_id\": 1, \"tax_percent\": 10, \"invoice_date\": \"2025-10-11\", \"total_amount\": 7000, \"discount_amount\": 350, \"supplier_adjust\": \"0.00\", \"discount_percent\": 5}', 1, '2025-10-11 23:47:12', NULL),
(8, 1, 'purchase_updated', 'purchase', 25, '\"{\\\"id\\\":25,\\\"invoice_no\\\":\\\"INV-2025-10-0001\\\",\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-10-11\\\",\\\"total_amount\\\":7000,\\\"discount_percent\\\":5,\\\"discount_amount\\\":350,\\\"tax_percent\\\":10,\\\"tax_amount\\\":665,\\\"supplier_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":7315,\\\"paid_amount\\\":500,\\\"due_amount\\\":6815,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2025-10-12T05:07:28.000000Z\\\",\\\"updated_at\\\":\\\"2025-10-12T06:13:26.000000Z\\\"}\"', '{\"id\": 25, \"remarks\": null, \"branch_id\": 1, \"net_total\": 7315, \"created_at\": \"2025-10-12T05:07:28.000000Z\", \"created_by\": 1, \"due_amount\": 6815, \"invoice_no\": \"INV-2025-10-0001\", \"tax_amount\": 665, \"updated_at\": \"2025-10-12T06:13:26.000000Z\", \"paid_amount\": 500, \"supplier_id\": 1, \"tax_percent\": 10, \"invoice_date\": \"2025-10-11\", \"total_amount\": 7000, \"discount_amount\": 350, \"supplier_adjust\": \"0.00\", \"discount_percent\": 5}', 1, '2025-10-12 00:13:26', NULL),
(9, 1, 'purchase_updated', 'purchase', 25, '\"{\\\"id\\\":25,\\\"invoice_no\\\":\\\"INV-2025-10-0001\\\",\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-10-11\\\",\\\"total_amount\\\":7000,\\\"discount_percent\\\":5,\\\"discount_amount\\\":350,\\\"tax_percent\\\":10,\\\"tax_amount\\\":665,\\\"supplier_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":7315,\\\"paid_amount\\\":500,\\\"due_amount\\\":6815,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2025-10-12T05:07:28.000000Z\\\",\\\"updated_at\\\":\\\"2025-10-12T06:18:14.000000Z\\\"}\"', '{\"id\": 25, \"remarks\": null, \"branch_id\": 1, \"net_total\": 7315, \"created_at\": \"2025-10-12T05:07:28.000000Z\", \"created_by\": 1, \"due_amount\": 6815, \"invoice_no\": \"INV-2025-10-0001\", \"tax_amount\": 665, \"updated_at\": \"2025-10-12T06:18:14.000000Z\", \"paid_amount\": 500, \"supplier_id\": 1, \"tax_percent\": 10, \"invoice_date\": \"2025-10-11\", \"total_amount\": 7000, \"discount_amount\": 350, \"supplier_adjust\": \"0.00\", \"discount_percent\": 5}', 1, '2025-10-12 00:18:14', NULL),
(10, 1, 'purchase_updated', 'purchase', 25, '\"{\\\"id\\\":25,\\\"invoice_no\\\":\\\"INV-2025-10-0001\\\",\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-10-11\\\",\\\"total_amount\\\":7000,\\\"discount_percent\\\":5,\\\"discount_amount\\\":350,\\\"tax_percent\\\":10,\\\"tax_amount\\\":665,\\\"supplier_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":7315,\\\"paid_amount\\\":500,\\\"due_amount\\\":6815,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2025-10-12T05:07:28.000000Z\\\",\\\"updated_at\\\":\\\"2025-10-12T06:39:27.000000Z\\\"}\"', '{\"id\": 25, \"remarks\": null, \"branch_id\": 1, \"net_total\": 7315, \"created_at\": \"2025-10-12T05:07:28.000000Z\", \"created_by\": 1, \"due_amount\": 6815, \"invoice_no\": \"INV-2025-10-0001\", \"tax_amount\": 665, \"updated_at\": \"2025-10-12T06:39:27.000000Z\", \"paid_amount\": 500, \"supplier_id\": 1, \"tax_percent\": 10, \"invoice_date\": \"2025-10-11\", \"total_amount\": 7000, \"discount_amount\": 350, \"supplier_adjust\": \"0.00\", \"discount_percent\": 5}', 1, '2025-10-12 00:39:27', NULL),
(11, 1, 'purchase_created', 'purchase', 26, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-10-11\\\",\\\"discount_percent\\\":5,\\\"discount_amount\\\":350,\\\"tax_percent\\\":10,\\\"paid_amount\\\":500,\\\"invoice_no\\\":\\\"INV-2025-10-0001\\\",\\\"total_amount\\\":7000,\\\"tax_amount\\\":665,\\\"net_total\\\":7315,\\\"due_amount\\\":6815,\\\"updated_at\\\":\\\"2025-10-12T06:48:08.000000Z\\\",\\\"created_at\\\":\\\"2025-10-12T06:48:08.000000Z\\\",\\\"id\\\":26}\"', '{\"id\": 26, \"branch_id\": 1, \"net_total\": 7315, \"created_at\": \"2025-10-12T06:48:08.000000Z\", \"created_by\": 1, \"due_amount\": 6815, \"invoice_no\": \"INV-2025-10-0001\", \"tax_amount\": 665, \"updated_at\": \"2025-10-12T06:48:08.000000Z\", \"paid_amount\": 500, \"supplier_id\": 1, \"tax_percent\": 10, \"invoice_date\": \"2025-10-11\", \"total_amount\": 7000, \"discount_amount\": 350, \"discount_percent\": 5}', 1, '2025-10-12 00:48:08', NULL),
(12, 1, 'purchase_created', 'purchase', 30, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-11-04\\\",\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"paid_amount\\\":300,\\\"invoice_no\\\":\\\"INV-2025-11-0001\\\",\\\"total_amount\\\":600,\\\"net_total\\\":600,\\\"due_amount\\\":300,\\\"updated_at\\\":\\\"2025-11-04T07:29:28.000000Z\\\",\\\"created_at\\\":\\\"2025-11-04T07:29:28.000000Z\\\",\\\"id\\\":30}\"', '{\"id\": 30, \"branch_id\": 1, \"net_total\": 600, \"created_at\": \"2025-11-04T07:29:28.000000Z\", \"created_by\": 1, \"due_amount\": 300, \"invoice_no\": \"INV-2025-11-0001\", \"tax_amount\": 0, \"updated_at\": \"2025-11-04T07:29:28.000000Z\", \"paid_amount\": 300, \"supplier_id\": 1, \"tax_percent\": 0, \"invoice_date\": \"2025-11-04\", \"total_amount\": 600, \"discount_amount\": 0, \"discount_percent\": 0}', 1, '2025-11-04 01:29:29', NULL),
(13, 1, 'purchase_created', 'purchase', 31, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-11-04\\\",\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"paid_amount\\\":200,\\\"invoice_no\\\":\\\"INV-2025-11-0002\\\",\\\"total_amount\\\":200,\\\"net_total\\\":200,\\\"due_amount\\\":0,\\\"updated_at\\\":\\\"2025-11-04T07:32:15.000000Z\\\",\\\"created_at\\\":\\\"2025-11-04T07:32:15.000000Z\\\",\\\"id\\\":31}\"', '{\"id\": 31, \"branch_id\": 1, \"net_total\": 200, \"created_at\": \"2025-11-04T07:32:15.000000Z\", \"created_by\": 1, \"due_amount\": 0, \"invoice_no\": \"INV-2025-11-0002\", \"tax_amount\": 0, \"updated_at\": \"2025-11-04T07:32:15.000000Z\", \"paid_amount\": 200, \"supplier_id\": 1, \"tax_percent\": 0, \"invoice_date\": \"2025-11-04\", \"total_amount\": 200, \"discount_amount\": 0, \"discount_percent\": 0}', 1, '2025-11-04 01:32:15', NULL),
(14, 1, 'purchase_created', 'purchase', 32, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-11-04\\\",\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"paid_amount\\\":200,\\\"invoice_no\\\":\\\"INV-2025-11-0003\\\",\\\"total_amount\\\":200,\\\"net_total\\\":200,\\\"due_amount\\\":0,\\\"updated_at\\\":\\\"2025-11-04T07:32:33.000000Z\\\",\\\"created_at\\\":\\\"2025-11-04T07:32:33.000000Z\\\",\\\"id\\\":32}\"', '{\"id\": 32, \"branch_id\": 1, \"net_total\": 200, \"created_at\": \"2025-11-04T07:32:33.000000Z\", \"created_by\": 1, \"due_amount\": 0, \"invoice_no\": \"INV-2025-11-0003\", \"tax_amount\": 0, \"updated_at\": \"2025-11-04T07:32:33.000000Z\", \"paid_amount\": 200, \"supplier_id\": 1, \"tax_percent\": 0, \"invoice_date\": \"2025-11-04\", \"total_amount\": 200, \"discount_amount\": 0, \"discount_percent\": 0}', 1, '2025-11-04 01:32:33', NULL),
(15, 1, 'purchase_created', 'purchase', 33, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-11-04\\\",\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"paid_amount\\\":300,\\\"invoice_no\\\":\\\"INV-2025-11-0004\\\",\\\"total_amount\\\":300,\\\"net_total\\\":300,\\\"due_amount\\\":0,\\\"updated_at\\\":\\\"2025-11-04T07:33:19.000000Z\\\",\\\"created_at\\\":\\\"2025-11-04T07:33:19.000000Z\\\",\\\"id\\\":33}\"', '{\"id\": 33, \"branch_id\": 1, \"net_total\": 300, \"created_at\": \"2025-11-04T07:33:19.000000Z\", \"created_by\": 1, \"due_amount\": 0, \"invoice_no\": \"INV-2025-11-0004\", \"tax_amount\": 0, \"updated_at\": \"2025-11-04T07:33:19.000000Z\", \"paid_amount\": 300, \"supplier_id\": 1, \"tax_percent\": 0, \"invoice_date\": \"2025-11-04\", \"total_amount\": 300, \"discount_amount\": 0, \"discount_percent\": 0}', 1, '2025-11-04 01:33:19', NULL),
(16, 1, 'purchase_created', 'purchase', 34, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-11-04\\\",\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"paid_amount\\\":400,\\\"invoice_no\\\":\\\"INV-2025-11-0005\\\",\\\"total_amount\\\":400,\\\"net_total\\\":400,\\\"due_amount\\\":0,\\\"updated_at\\\":\\\"2025-11-04T07:50:18.000000Z\\\",\\\"created_at\\\":\\\"2025-11-04T07:50:18.000000Z\\\",\\\"id\\\":34}\"', '{\"id\": 34, \"branch_id\": 1, \"net_total\": 400, \"created_at\": \"2025-11-04T07:50:18.000000Z\", \"created_by\": 1, \"due_amount\": 0, \"invoice_no\": \"INV-2025-11-0005\", \"tax_amount\": 0, \"updated_at\": \"2025-11-04T07:50:18.000000Z\", \"paid_amount\": 400, \"supplier_id\": 1, \"tax_percent\": 0, \"invoice_date\": \"2025-11-04\", \"total_amount\": 400, \"discount_amount\": 0, \"discount_percent\": 0}', 1, '2025-11-04 01:50:18', NULL),
(17, 1, 'purchase_created', 'purchase', 68, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-11-04\\\",\\\"discount_percent\\\":38,\\\"discount_amount\\\":38,\\\"tax_percent\\\":30.81081081081081,\\\"tax_amount\\\":21.7027027027027,\\\"paid_amount\\\":30,\\\"invoice_no\\\":\\\"INV-2025-11-0006\\\",\\\"total_amount\\\":100,\\\"net_total\\\":81.70270270270271,\\\"due_amount\\\":51.70270270270271,\\\"updated_at\\\":\\\"2025-11-04T11:20:56.000000Z\\\",\\\"created_at\\\":\\\"2025-11-04T11:20:56.000000Z\\\",\\\"id\\\":68}\"', '{\"id\": 68, \"branch_id\": 1, \"net_total\": 81.70270270270271, \"created_at\": \"2025-11-04T11:20:56.000000Z\", \"created_by\": 1, \"due_amount\": 51.70270270270271, \"invoice_no\": \"INV-2025-11-0006\", \"tax_amount\": 21.7027027027027, \"updated_at\": \"2025-11-04T11:20:56.000000Z\", \"paid_amount\": 30, \"supplier_id\": 1, \"tax_percent\": 30.81081081081081, \"invoice_date\": \"2025-11-04\", \"total_amount\": 100, \"discount_amount\": 38, \"discount_percent\": 38}', 1, '2025-11-04 05:20:56', NULL),
(18, 1, 'purchase_created', 'purchase', 72, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":1,\\\"invoice_date\\\":\\\"2025-11-04\\\",\\\"discount_percent\\\":13.5,\\\"discount_amount\\\":27,\\\"tax_percent\\\":12.702702702702702,\\\"tax_amount\\\":11.345675675675675,\\\"paid_amount\\\":0,\\\"invoice_no\\\":\\\"INV-2025-11-0007\\\",\\\"total_amount\\\":200,\\\"net_total\\\":174.34567567567566,\\\"due_amount\\\":174.34567567567566,\\\"updated_at\\\":\\\"2025-11-04T11:33:27.000000Z\\\",\\\"created_at\\\":\\\"2025-11-04T11:33:27.000000Z\\\",\\\"id\\\":72}\"', '{\"id\": 72, \"branch_id\": 1, \"net_total\": 174.34567567567566, \"created_at\": \"2025-11-04T11:33:27.000000Z\", \"created_by\": 1, \"due_amount\": 174.34567567567566, \"invoice_no\": \"INV-2025-11-0007\", \"tax_amount\": 11.345675675675675, \"updated_at\": \"2025-11-04T11:33:27.000000Z\", \"paid_amount\": 0, \"supplier_id\": 1, \"tax_percent\": 12.702702702702702, \"invoice_date\": \"2025-11-04\", \"total_amount\": 200, \"discount_amount\": 27, \"discount_percent\": 13.5}', 1, '2025-11-04 05:33:27', NULL),
(19, 1, 'purchase_created', 'purchase', 86, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":4,\\\"invoice_date\\\":\\\"2025-11-04\\\",\\\"discount_percent\\\":20,\\\"discount_amount\\\":40,\\\"tax_percent\\\":8.059999999999999,\\\"tax_amount\\\":15,\\\"paid_amount\\\":0,\\\"invoice_no\\\":\\\"INV-2025-11-0008\\\",\\\"total_amount\\\":200,\\\"net_total\\\":170,\\\"due_amount\\\":0,\\\"updated_at\\\":\\\"2025-11-04T12:35:47.000000Z\\\",\\\"created_at\\\":\\\"2025-11-04T12:35:47.000000Z\\\",\\\"id\\\":86}\"', '{\"id\": 86, \"branch_id\": 1, \"net_total\": 170, \"created_at\": \"2025-11-04T12:35:47.000000Z\", \"created_by\": 1, \"due_amount\": 0, \"invoice_no\": \"INV-2025-11-0008\", \"tax_amount\": 15, \"updated_at\": \"2025-11-04T12:35:47.000000Z\", \"paid_amount\": 0, \"supplier_id\": 4, \"tax_percent\": 8.059999999999999, \"invoice_date\": \"2025-11-04\", \"total_amount\": 200, \"discount_amount\": 40, \"discount_percent\": 20}', 1, '2025-11-04 06:35:47', NULL),
(20, 1, 'purchase_created', 'purchase', 87, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":10,\\\"invoice_date\\\":\\\"2025-11-05\\\",\\\"discount_percent\\\":4.2,\\\"discount_amount\\\":70,\\\"tax_percent\\\":3.89,\\\"tax_amount\\\":4.2,\\\"paid_amount\\\":4000,\\\"invoice_no\\\":\\\"INV-2025-11-0009\\\",\\\"total_amount\\\":4250,\\\"net_total\\\":4179.5,\\\"due_amount\\\":179.5,\\\"updated_at\\\":\\\"2025-11-05T04:54:00.000000Z\\\",\\\"created_at\\\":\\\"2025-11-05T04:54:00.000000Z\\\",\\\"id\\\":87}\"', '{\"id\": 87, \"branch_id\": 1, \"net_total\": 4179.5, \"created_at\": \"2025-11-05T04:54:00.000000Z\", \"created_by\": 1, \"due_amount\": 179.5, \"invoice_no\": \"INV-2025-11-0009\", \"tax_amount\": 4.2, \"updated_at\": \"2025-11-05T04:54:00.000000Z\", \"paid_amount\": 4000, \"supplier_id\": 10, \"tax_percent\": 3.89, \"invoice_date\": \"2025-11-05\", \"total_amount\": 4250, \"discount_amount\": 70, \"discount_percent\": 4.2}', 1, '2025-11-04 22:54:00', NULL),
(21, 1, 'purchase_created', 'purchase', 88, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":9,\\\"invoice_date\\\":\\\"2025-11-05\\\",\\\"discount_percent\\\":1.5555555555555556,\\\"discount_amount\\\":70,\\\"tax_percent\\\":0.8866666666666667,\\\"tax_amount\\\":30.444444444444443,\\\"paid_amount\\\":4000,\\\"invoice_no\\\":\\\"INV-2025-11-0010\\\",\\\"total_amount\\\":4500,\\\"net_total\\\":4390.444444444444,\\\"due_amount\\\":390.44444444444434,\\\"updated_at\\\":\\\"2025-11-05T06:08:41.000000Z\\\",\\\"created_at\\\":\\\"2025-11-05T06:08:41.000000Z\\\",\\\"id\\\":88}\"', '{\"id\": 88, \"branch_id\": 1, \"net_total\": 4390.444444444444, \"created_at\": \"2025-11-05T06:08:41.000000Z\", \"created_by\": 1, \"due_amount\": 390.44444444444434, \"invoice_no\": \"INV-2025-11-0010\", \"tax_amount\": 30.444444444444443, \"updated_at\": \"2025-11-05T06:08:41.000000Z\", \"paid_amount\": 4000, \"supplier_id\": 9, \"tax_percent\": 0.8866666666666667, \"invoice_date\": \"2025-11-05\", \"total_amount\": 4500, \"discount_amount\": 70, \"discount_percent\": 1.5555555555555556}', 1, '2025-11-05 00:08:41', NULL),
(22, 1, 'purchase_created', 'purchase', 89, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":8,\\\"invoice_date\\\":\\\"2025-11-05\\\",\\\"discount_percent\\\":1.7500000000000002,\\\"discount_amount\\\":70,\\\"tax_percent\\\":0.5,\\\"tax_amount\\\":20,\\\"adjustment\\\":40,\\\"paid_amount\\\":3000,\\\"invoice_no\\\":\\\"INV-2025-11-0011\\\",\\\"total_amount\\\":4000,\\\"total_discount_amount\\\":120,\\\"total_discount_percent\\\":71.25,\\\"total_tax_percent\\\":1.51,\\\"total_tax_amount\\\":21.25,\\\"net_total\\\":3910,\\\"due_amount\\\":910,\\\"updated_at\\\":\\\"2025-11-05T06:47:10.000000Z\\\",\\\"created_at\\\":\\\"2025-11-05T06:47:10.000000Z\\\",\\\"id\\\":89}\"', '{\"id\": 89, \"branch_id\": 1, \"net_total\": 3910, \"adjustment\": 40, \"created_at\": \"2025-11-05T06:47:10.000000Z\", \"created_by\": 1, \"due_amount\": 910, \"invoice_no\": \"INV-2025-11-0011\", \"tax_amount\": 20, \"updated_at\": \"2025-11-05T06:47:10.000000Z\", \"paid_amount\": 3000, \"supplier_id\": 8, \"tax_percent\": 0.5, \"invoice_date\": \"2025-11-05\", \"total_amount\": 4000, \"discount_amount\": 70, \"discount_percent\": 1.7500000000000002, \"total_tax_amount\": 21.25, \"total_tax_percent\": 1.51, \"total_discount_amount\": 120, \"total_discount_percent\": 71.25}', 1, '2025-11-05 00:47:10', NULL),
(23, 1, 'purchase_created', 'purchase', 90, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":10,\\\"invoice_date\\\":\\\"2025-11-05\\\",\\\"discount_percent\\\":1.33,\\\"discount_amount\\\":80,\\\"tax_percent\\\":70,\\\"tax_amount\\\":1.2,\\\"adjustment\\\":80,\\\"paid_amount\\\":5000,\\\"invoice_no\\\":\\\"INV-2025-11-0012\\\",\\\"total_amount\\\":6000,\\\"total_discount_amount\\\":150,\\\"total_discount_percent\\\":81.17,\\\"total_tax_percent\\\":71,\\\"total_tax_amount\\\":61.2,\\\"net_total\\\":5841.2,\\\"due_amount\\\":841.1999999999998,\\\"updated_at\\\":\\\"2025-11-05T07:13:02.000000Z\\\",\\\"created_at\\\":\\\"2025-11-05T07:13:02.000000Z\\\",\\\"id\\\":90}\"', '{\"id\": 90, \"branch_id\": 1, \"net_total\": 5841.2, \"adjustment\": 80, \"created_at\": \"2025-11-05T07:13:02.000000Z\", \"created_by\": 1, \"due_amount\": 841.1999999999998, \"invoice_no\": \"INV-2025-11-0012\", \"tax_amount\": 1.2, \"updated_at\": \"2025-11-05T07:13:02.000000Z\", \"paid_amount\": 5000, \"supplier_id\": 10, \"tax_percent\": 70, \"invoice_date\": \"2025-11-05\", \"total_amount\": 6000, \"discount_amount\": 80, \"discount_percent\": 1.33, \"total_tax_amount\": 61.2, \"total_tax_percent\": 71, \"total_discount_amount\": 150, \"total_discount_percent\": 81.17}', 1, '2025-11-05 01:13:02', NULL),
(24, 1, 'purchase_created', 'purchase', 91, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":10,\\\"invoice_date\\\":\\\"2025-11-05\\\",\\\"discount_percent\\\":1.5,\\\"discount_amount\\\":90,\\\"tax_percent\\\":1.37,\\\"tax_amount\\\":80,\\\"adjustment\\\":80,\\\"paid_amount\\\":5000,\\\"invoice_no\\\":\\\"INV-2025-11-0013\\\",\\\"total_amount\\\":6000,\\\"total_discount_percent\\\":2.83,\\\"total_discount_amount\\\":170,\\\"total_tax_percent\\\":2.54,\\\"total_tax_amount\\\":150,\\\"net_total\\\":5910,\\\"due_amount\\\":910,\\\"updated_at\\\":\\\"2025-11-05T07:18:07.000000Z\\\",\\\"created_at\\\":\\\"2025-11-05T07:18:07.000000Z\\\",\\\"id\\\":91}\"', '{\"id\": 91, \"branch_id\": 1, \"net_total\": 5910, \"adjustment\": 80, \"created_at\": \"2025-11-05T07:18:07.000000Z\", \"created_by\": 1, \"due_amount\": 910, \"invoice_no\": \"INV-2025-11-0013\", \"tax_amount\": 80, \"updated_at\": \"2025-11-05T07:18:07.000000Z\", \"paid_amount\": 5000, \"supplier_id\": 10, \"tax_percent\": 1.37, \"invoice_date\": \"2025-11-05\", \"total_amount\": 6000, \"discount_amount\": 90, \"discount_percent\": 1.5, \"total_tax_amount\": 150, \"total_tax_percent\": 2.54, \"total_discount_amount\": 170, \"total_discount_percent\": 2.83}', 1, '2025-11-05 01:18:07', NULL),
(25, 1, 'purchase_created', 'purchase', 109, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":10,\\\"invoice_date\\\":\\\"2025-11-05\\\",\\\"discount_percent\\\":1.33,\\\"discount_amount\\\":80,\\\"tax_percent\\\":1.2,\\\"tax_amount\\\":70,\\\"adjustment\\\":80,\\\"paid_amount\\\":5000,\\\"invoice_no\\\":\\\"INV-2025-11-0014\\\",\\\"total_amount\\\":6000,\\\"total_discount_percent\\\":2.83,\\\"total_discount_amount\\\":170,\\\"total_tax_percent\\\":2.5300000000000002,\\\"total_tax_amount\\\":150,\\\"net_total\\\":5900,\\\"due_amount\\\":900,\\\"updated_at\\\":\\\"2025-11-05T07:51:10.000000Z\\\",\\\"created_at\\\":\\\"2025-11-05T07:51:10.000000Z\\\",\\\"id\\\":109}\"', '{\"id\": 109, \"branch_id\": 1, \"net_total\": 5900, \"adjustment\": 80, \"created_at\": \"2025-11-05T07:51:10.000000Z\", \"created_by\": 1, \"due_amount\": 900, \"invoice_no\": \"INV-2025-11-0014\", \"tax_amount\": 70, \"updated_at\": \"2025-11-05T07:51:10.000000Z\", \"paid_amount\": 5000, \"supplier_id\": 10, \"tax_percent\": 1.2, \"invoice_date\": \"2025-11-05\", \"total_amount\": 6000, \"discount_amount\": 80, \"discount_percent\": 1.33, \"total_tax_amount\": 150, \"total_tax_percent\": 2.53, \"total_discount_amount\": 170, \"total_discount_percent\": 2.83}', 1, '2025-11-05 01:51:10', NULL),
(26, 1, 'purchase_created', 'purchase', 110, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":8,\\\"invoice_date\\\":\\\"2025-11-05\\\",\\\"discount_percent\\\":4.94,\\\"discount_amount\\\":74.03,\\\"tax_percent\\\":4.21,\\\"tax_amount\\\":56.26,\\\"adjustment\\\":62.73,\\\"paid_amount\\\":1000,\\\"invoice_no\\\":\\\"INV-2025-11-0015\\\",\\\"total_amount\\\":1500,\\\"total_discount_percent\\\":10.940000000000001,\\\"total_discount_amount\\\":164.03,\\\"total_tax_percent\\\":8.91,\\\"total_tax_amount\\\":126.75999999999999,\\\"net_total\\\":1400,\\\"due_amount\\\":400,\\\"updated_at\\\":\\\"2025-11-05T08:57:49.000000Z\\\",\\\"created_at\\\":\\\"2025-11-05T08:57:49.000000Z\\\",\\\"id\\\":110}\"', '{\"id\": 110, \"branch_id\": 1, \"net_total\": 1400, \"adjustment\": 62.73, \"created_at\": \"2025-11-05T08:57:49.000000Z\", \"created_by\": 1, \"due_amount\": 400, \"invoice_no\": \"INV-2025-11-0015\", \"tax_amount\": 56.26, \"updated_at\": \"2025-11-05T08:57:49.000000Z\", \"paid_amount\": 1000, \"supplier_id\": 8, \"tax_percent\": 4.21, \"invoice_date\": \"2025-11-05\", \"total_amount\": 1500, \"discount_amount\": 74.03, \"discount_percent\": 4.94, \"total_tax_amount\": 126.76, \"total_tax_percent\": 8.91, \"total_discount_amount\": 164.03, \"total_discount_percent\": 10.94}', 1, '2025-11-05 02:57:49', NULL),
(27, 1, 'purchase_updated', 'purchase', 110, '\"{\\\"id\\\":110,\\\"invoice_no\\\":\\\"INV-2025-11-0015\\\",\\\"supplier_id\\\":8,\\\"invoice_date\\\":\\\"2025-11-05\\\",\\\"total_amount\\\":1500,\\\"discount_percent\\\":4.93,\\\"discount_amount\\\":74,\\\"total_discount_percent\\\":10.93,\\\"total_discount_amount\\\":164,\\\"adjustment\\\":63.5,\\\"tax_percent\\\":4.27,\\\"tax_amount\\\":57,\\\"total_tax_percent\\\":8.969999999999999,\\\"total_tax_amount\\\":127.5,\\\"supplier_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":1400,\\\"paid_amount\\\":1000,\\\"due_amount\\\":400,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2025-11-05T08:57:49.000000Z\\\",\\\"updated_at\\\":\\\"2025-11-05T09:25:02.000000Z\\\"}\"', '{\"id\": 110, \"remarks\": null, \"branch_id\": 1, \"net_total\": 1400, \"adjustment\": 63.5, \"created_at\": \"2025-11-05T08:57:49.000000Z\", \"created_by\": 1, \"due_amount\": 400, \"invoice_no\": \"INV-2025-11-0015\", \"tax_amount\": 57, \"updated_at\": \"2025-11-05T09:25:02.000000Z\", \"paid_amount\": 1000, \"supplier_id\": 8, \"tax_percent\": 4.27, \"invoice_date\": \"2025-11-05\", \"total_amount\": 1500, \"discount_amount\": 74, \"supplier_adjust\": \"0.00\", \"discount_percent\": 4.93, \"total_tax_amount\": 127.5, \"total_tax_percent\": 8.969999999999999, \"total_discount_amount\": 164, \"total_discount_percent\": 10.93}', 1, '2025-11-05 03:25:03', NULL),
(28, 1, 'purchase_created', 'purchase', 111, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"supplier_id\\\":4,\\\"invoice_date\\\":\\\"2025-11-05\\\",\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"adjustment\\\":0,\\\"paid_amount\\\":0,\\\"invoice_no\\\":\\\"INV-2025-11-0016\\\",\\\"total_amount\\\":1250,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"net_total\\\":1250,\\\"due_amount\\\":0,\\\"updated_at\\\":\\\"2025-11-05T09:44:03.000000Z\\\",\\\"created_at\\\":\\\"2025-11-05T09:44:03.000000Z\\\",\\\"id\\\":111}\"', '{\"id\": 111, \"branch_id\": 1, \"net_total\": 1250, \"adjustment\": 0, \"created_at\": \"2025-11-05T09:44:03.000000Z\", \"created_by\": 1, \"due_amount\": 0, \"invoice_no\": \"INV-2025-11-0016\", \"tax_amount\": 0, \"updated_at\": \"2025-11-05T09:44:03.000000Z\", \"paid_amount\": 0, \"supplier_id\": 4, \"tax_percent\": 0, \"invoice_date\": \"2025-11-05\", \"total_amount\": 1250, \"discount_amount\": 0, \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2025-11-05 03:44:03', NULL),
(29, 1, 'purchase_updated', 'purchase', 111, '\"{\\\"id\\\":111,\\\"invoice_no\\\":\\\"INV-2025-11-0016\\\",\\\"supplier_id\\\":4,\\\"invoice_date\\\":\\\"2025-11-05\\\",\\\"total_amount\\\":1250,\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"adjustment\\\":0,\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"supplier_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":1250,\\\"paid_amount\\\":0,\\\"due_amount\\\":0,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2025-11-05T09:44:03.000000Z\\\",\\\"updated_at\\\":\\\"2025-11-24T05:59:29.000000Z\\\"}\"', '{\"id\": 111, \"remarks\": null, \"branch_id\": 1, \"net_total\": 1250, \"adjustment\": 0, \"created_at\": \"2025-11-05T09:44:03.000000Z\", \"created_by\": 1, \"due_amount\": 0, \"invoice_no\": \"INV-2025-11-0016\", \"tax_amount\": 0, \"updated_at\": \"2025-11-24T05:59:29.000000Z\", \"paid_amount\": 0, \"supplier_id\": 4, \"tax_percent\": 0, \"invoice_date\": \"2025-11-05\", \"total_amount\": 1250, \"discount_amount\": 0, \"supplier_adjust\": \"0.00\", \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2025-11-23 23:59:29', NULL),
(30, 1, 'sale_created', 'sale', 5, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"customer_id\\\":1,\\\"invoice_date\\\":\\\"2026-05-02\\\",\\\"discount_percent\\\":10.08,\\\"discount_amount\\\":25.2,\\\"tax_percent\\\":14.95,\\\"tax_amount\\\":33.6,\\\"adjustment\\\":\\\"28.40\\\",\\\"paid_amount\\\":\\\"160\\\",\\\"invoice_no\\\":\\\"SAL-2026-05-0001\\\",\\\"total_amount\\\":250,\\\"total_discount_percent\\\":10.08,\\\"total_discount_amount\\\":25.2,\\\"total_tax_percent\\\":14.95,\\\"total_tax_amount\\\":33.6,\\\"net_total\\\":230.00000000000003,\\\"due_amount\\\":70.00000000000003,\\\"updated_at\\\":\\\"2026-05-02T08:48:09.000000Z\\\",\\\"created_at\\\":\\\"2026-05-02T08:48:09.000000Z\\\",\\\"id\\\":5}\"', '{\"id\": 5, \"branch_id\": 1, \"net_total\": 230.00000000000003, \"adjustment\": \"28.40\", \"created_at\": \"2026-05-02T08:48:09.000000Z\", \"created_by\": 1, \"due_amount\": 70.00000000000003, \"invoice_no\": \"SAL-2026-05-0001\", \"tax_amount\": 33.6, \"updated_at\": \"2026-05-02T08:48:09.000000Z\", \"customer_id\": 1, \"paid_amount\": \"160\", \"tax_percent\": 14.95, \"invoice_date\": \"2026-05-02\", \"total_amount\": 250, \"discount_amount\": 25.2, \"discount_percent\": 10.08, \"total_tax_amount\": 33.6, \"total_tax_percent\": 14.95, \"total_discount_amount\": 25.2, \"total_discount_percent\": 10.08}', 1, '2026-05-02 02:48:09', NULL),
(31, 1, 'sale_updated', 'sale', 5, '\"{\\\"id\\\":5,\\\"invoice_no\\\":\\\"SAL-2026-05-0001\\\",\\\"customer_id\\\":1,\\\"invoice_date\\\":\\\"2026-05-02\\\",\\\"total_amount\\\":500,\\\"discount_percent\\\":11.29,\\\"discount_amount\\\":56.45,\\\"total_discount_percent\\\":11.29,\\\"total_discount_amount\\\":56.45,\\\"adjustment\\\":\\\"28.40\\\",\\\"tax_percent\\\":18.87,\\\"tax_amount\\\":83.72,\\\"total_tax_percent\\\":18.87,\\\"total_tax_amount\\\":83.72,\\\"customer_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":498.87,\\\"paid_amount\\\":\\\"160.00\\\",\\\"due_amount\\\":338.87,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2026-05-02T08:48:09.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-02T10:14:47.000000Z\\\"}\"', '{\"id\": 5, \"remarks\": null, \"branch_id\": 1, \"net_total\": 498.87, \"adjustment\": \"28.40\", \"created_at\": \"2026-05-02T08:48:09.000000Z\", \"created_by\": 1, \"due_amount\": 338.87, \"invoice_no\": \"SAL-2026-05-0001\", \"tax_amount\": 83.72, \"updated_at\": \"2026-05-02T10:14:47.000000Z\", \"customer_id\": 1, \"paid_amount\": \"160.00\", \"tax_percent\": 18.87, \"invoice_date\": \"2026-05-02\", \"total_amount\": 500, \"customer_adjust\": \"0.00\", \"discount_amount\": 56.45, \"discount_percent\": 11.29, \"total_tax_amount\": 83.72, \"total_tax_percent\": 18.87, \"total_discount_amount\": 56.45, \"total_discount_percent\": 11.29}', 1, '2026-05-02 04:14:47', NULL),
(32, 1, 'sale_updated', 'sale', 5, '\"{\\\"id\\\":5,\\\"invoice_no\\\":\\\"SAL-2026-05-0001\\\",\\\"customer_id\\\":1,\\\"invoice_date\\\":\\\"2026-05-02\\\",\\\"total_amount\\\":500,\\\"discount_percent\\\":12.64,\\\"discount_amount\\\":63.22,\\\"total_discount_percent\\\":12.64,\\\"total_discount_amount\\\":63.22,\\\"adjustment\\\":\\\"28.40\\\",\\\"tax_percent\\\":24.19,\\\"tax_amount\\\":105.67,\\\"total_tax_percent\\\":24.19,\\\"total_tax_amount\\\":105.67,\\\"customer_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":514.05,\\\"paid_amount\\\":\\\"160.00\\\",\\\"due_amount\\\":354.04999999999995,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2026-05-02T08:48:09.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-02T11:10:22.000000Z\\\"}\"', '{\"id\": 5, \"remarks\": null, \"branch_id\": 1, \"net_total\": 514.05, \"adjustment\": \"28.40\", \"created_at\": \"2026-05-02T08:48:09.000000Z\", \"created_by\": 1, \"due_amount\": 354.04999999999995, \"invoice_no\": \"SAL-2026-05-0001\", \"tax_amount\": 105.67, \"updated_at\": \"2026-05-02T11:10:22.000000Z\", \"customer_id\": 1, \"paid_amount\": \"160.00\", \"tax_percent\": 24.19, \"invoice_date\": \"2026-05-02\", \"total_amount\": 500, \"customer_adjust\": \"0.00\", \"discount_amount\": 63.22, \"discount_percent\": 12.64, \"total_tax_amount\": 105.67, \"total_tax_percent\": 24.19, \"total_discount_amount\": 63.22, \"total_discount_percent\": 12.64}', 1, '2026-05-02 05:10:23', NULL),
(33, 1, 'sale_created', 'sale', 6, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"customer_id\\\":3,\\\"invoice_date\\\":\\\"2026-05-03\\\",\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"adjustment\\\":0,\\\"paid_amount\\\":0,\\\"invoice_no\\\":\\\"SAL-2026-05-0002\\\",\\\"total_amount\\\":250,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"net_total\\\":250,\\\"due_amount\\\":50,\\\"updated_at\\\":\\\"2026-05-02T11:28:45.000000Z\\\",\\\"created_at\\\":\\\"2026-05-02T11:28:45.000000Z\\\",\\\"id\\\":6}\"', '{\"id\": 6, \"branch_id\": 1, \"net_total\": 250, \"adjustment\": 0, \"created_at\": \"2026-05-02T11:28:45.000000Z\", \"created_by\": 1, \"due_amount\": 50, \"invoice_no\": \"SAL-2026-05-0002\", \"tax_amount\": 0, \"updated_at\": \"2026-05-02T11:28:45.000000Z\", \"customer_id\": 3, \"paid_amount\": 0, \"tax_percent\": 0, \"invoice_date\": \"2026-05-03\", \"total_amount\": 250, \"discount_amount\": 0, \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2026-05-02 05:28:45', NULL),
(34, 1, 'sale_updated', 'sale', 5, '\"{\\\"id\\\":5,\\\"invoice_no\\\":\\\"SAL-2026-05-0001\\\",\\\"customer_id\\\":1,\\\"invoice_date\\\":\\\"2026-05-02\\\",\\\"total_amount\\\":500,\\\"discount_percent\\\":14.16,\\\"discount_amount\\\":70.78,\\\"total_discount_percent\\\":14.16,\\\"total_discount_amount\\\":70.78,\\\"adjustment\\\":\\\"28.40\\\",\\\"tax_percent\\\":31.56,\\\"tax_amount\\\":135.46,\\\"total_tax_percent\\\":31.56,\\\"total_tax_amount\\\":135.46,\\\"customer_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":536.28,\\\"paid_amount\\\":\\\"160.00\\\",\\\"due_amount\\\":376.28,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2026-05-02T08:48:09.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-02T11:32:44.000000Z\\\",\\\"items\\\":[{\\\"id\\\":7,\\\"sale_id\\\":5,\\\"product_id\\\":7,\\\"invoice_date\\\":\\\"2026-05-02\\\",\\\"quantity\\\":\\\"2.00\\\",\\\"unit_price\\\":\\\"250.00\\\",\\\"cost_price\\\":\\\"250.00\\\",\\\"sale_price\\\":\\\"280.00\\\",\\\"inventory_subtotal\\\":\\\"500.00\\\",\\\"total_price\\\":\\\"500.00\\\",\\\"discount_percent\\\":\\\"0.00\\\",\\\"discount_amount\\\":\\\"0.00\\\",\\\"tax_percent\\\":\\\"0.00\\\",\\\"tax_amount\\\":\\\"0.00\\\",\\\"net_price\\\":\\\"500.00\\\",\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_at\\\":\\\"2026-05-02T11:32:44.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-02T11:32:44.000000Z\\\"}]}\"', '{\"id\": 5, \"items\": [{\"id\": 7, \"remarks\": null, \"sale_id\": 5, \"quantity\": \"2.00\", \"branch_id\": 1, \"net_price\": \"500.00\", \"cost_price\": \"250.00\", \"created_at\": \"2026-05-02T11:32:44.000000Z\", \"product_id\": 7, \"sale_price\": \"280.00\", \"tax_amount\": \"0.00\", \"unit_price\": \"250.00\", \"updated_at\": \"2026-05-02T11:32:44.000000Z\", \"tax_percent\": \"0.00\", \"total_price\": \"500.00\", \"invoice_date\": \"2026-05-02\", \"discount_amount\": \"0.00\", \"discount_percent\": \"0.00\", \"inventory_subtotal\": \"500.00\"}], \"remarks\": null, \"branch_id\": 1, \"net_total\": 536.28, \"adjustment\": \"28.40\", \"created_at\": \"2026-05-02T08:48:09.000000Z\", \"created_by\": 1, \"due_amount\": 376.28, \"invoice_no\": \"SAL-2026-05-0001\", \"tax_amount\": 135.46, \"updated_at\": \"2026-05-02T11:32:44.000000Z\", \"customer_id\": 1, \"paid_amount\": \"160.00\", \"tax_percent\": 31.56, \"invoice_date\": \"2026-05-02\", \"total_amount\": 500, \"customer_adjust\": \"0.00\", \"discount_amount\": 70.78, \"discount_percent\": 14.16, \"total_tax_amount\": 135.46, \"total_tax_percent\": 31.56, \"total_discount_amount\": 70.78, \"total_discount_percent\": 14.16}', 1, '2026-05-02 05:32:44', NULL),
(35, 1, 'sale_created', 'sale', 7, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"customer_id\\\":3,\\\"invoice_date\\\":\\\"2026-05-02\\\",\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"adjustment\\\":0,\\\"paid_amount\\\":0,\\\"invoice_no\\\":\\\"SAL-2026-05-0003\\\",\\\"total_amount\\\":250,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"net_total\\\":250,\\\"due_amount\\\":100,\\\"updated_at\\\":\\\"2026-05-02T11:34:30.000000Z\\\",\\\"created_at\\\":\\\"2026-05-02T11:34:30.000000Z\\\",\\\"id\\\":7}\"', '{\"id\": 7, \"branch_id\": 1, \"net_total\": 250, \"adjustment\": 0, \"created_at\": \"2026-05-02T11:34:30.000000Z\", \"created_by\": 1, \"due_amount\": 100, \"invoice_no\": \"SAL-2026-05-0003\", \"tax_amount\": 0, \"updated_at\": \"2026-05-02T11:34:30.000000Z\", \"customer_id\": 3, \"paid_amount\": 0, \"tax_percent\": 0, \"invoice_date\": \"2026-05-02\", \"total_amount\": 250, \"discount_amount\": 0, \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2026-05-02 05:34:30', NULL),
(36, 1, 'sale_created', 'sale', 8, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"customer_id\\\":1,\\\"invoice_date\\\":\\\"2026-05-02\\\",\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"adjustment\\\":0,\\\"paid_amount\\\":0,\\\"invoice_no\\\":\\\"SAL-2026-05-0004\\\",\\\"total_amount\\\":250,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"net_total\\\":250,\\\"due_amount\\\":250,\\\"updated_at\\\":\\\"2026-05-02T11:44:27.000000Z\\\",\\\"created_at\\\":\\\"2026-05-02T11:44:27.000000Z\\\",\\\"id\\\":8}\"', '{\"id\": 8, \"branch_id\": 1, \"net_total\": 250, \"adjustment\": 0, \"created_at\": \"2026-05-02T11:44:27.000000Z\", \"created_by\": 1, \"due_amount\": 250, \"invoice_no\": \"SAL-2026-05-0004\", \"tax_amount\": 0, \"updated_at\": \"2026-05-02T11:44:27.000000Z\", \"customer_id\": 1, \"paid_amount\": 0, \"tax_percent\": 0, \"invoice_date\": \"2026-05-02\", \"total_amount\": 250, \"discount_amount\": 0, \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2026-05-02 05:44:27', NULL),
(37, 1, 'sale_updated', 'sale', 8, '\"{\\\"id\\\":8,\\\"invoice_no\\\":\\\"SAL-2026-05-0004\\\",\\\"customer_id\\\":1,\\\"invoice_date\\\":\\\"2026-05-02\\\",\\\"total_amount\\\":250,\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"adjustment\\\":\\\"0.00\\\",\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"customer_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":250,\\\"paid_amount\\\":\\\"0.00\\\",\\\"due_amount\\\":250,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2026-05-02T11:44:27.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-02T12:40:59.000000Z\\\",\\\"items\\\":[{\\\"id\\\":9,\\\"sale_id\\\":8,\\\"product_id\\\":7,\\\"invoice_date\\\":\\\"2026-05-02\\\",\\\"quantity\\\":\\\"1.00\\\",\\\"unit_price\\\":\\\"250.00\\\",\\\"cost_price\\\":\\\"250.00\\\",\\\"sale_price\\\":\\\"280.00\\\",\\\"inventory_subtotal\\\":\\\"250.00\\\",\\\"total_price\\\":\\\"250.00\\\",\\\"discount_percent\\\":\\\"0.00\\\",\\\"discount_amount\\\":\\\"0.00\\\",\\\"tax_percent\\\":\\\"0.00\\\",\\\"tax_amount\\\":\\\"0.00\\\",\\\"net_price\\\":\\\"250.00\\\",\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_at\\\":\\\"2026-05-02T11:44:27.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-02T11:44:27.000000Z\\\"}]}\"', '{\"id\": 8, \"items\": [{\"id\": 9, \"remarks\": null, \"sale_id\": 8, \"quantity\": \"1.00\", \"branch_id\": 1, \"net_price\": \"250.00\", \"cost_price\": \"250.00\", \"created_at\": \"2026-05-02T11:44:27.000000Z\", \"product_id\": 7, \"sale_price\": \"280.00\", \"tax_amount\": \"0.00\", \"unit_price\": \"250.00\", \"updated_at\": \"2026-05-02T11:44:27.000000Z\", \"tax_percent\": \"0.00\", \"total_price\": \"250.00\", \"invoice_date\": \"2026-05-02\", \"discount_amount\": \"0.00\", \"discount_percent\": \"0.00\", \"inventory_subtotal\": \"250.00\"}], \"remarks\": null, \"branch_id\": 1, \"net_total\": 250, \"adjustment\": \"0.00\", \"created_at\": \"2026-05-02T11:44:27.000000Z\", \"created_by\": 1, \"due_amount\": 250, \"invoice_no\": \"SAL-2026-05-0004\", \"tax_amount\": 0, \"updated_at\": \"2026-05-02T12:40:59.000000Z\", \"customer_id\": 1, \"paid_amount\": \"0.00\", \"tax_percent\": 0, \"invoice_date\": \"2026-05-02\", \"total_amount\": 250, \"customer_adjust\": \"0.00\", \"discount_amount\": 0, \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2026-05-02 06:40:59', NULL),
(38, 1, 'sale_updated', 'sale', 8, '\"{\\\"id\\\":8,\\\"invoice_no\\\":\\\"SAL-2026-05-0004\\\",\\\"customer_id\\\":1,\\\"invoice_date\\\":\\\"2026-05-02\\\",\\\"total_amount\\\":250,\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"adjustment\\\":\\\"0.00\\\",\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"customer_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":250,\\\"paid_amount\\\":\\\"0.00\\\",\\\"due_amount\\\":250,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2026-05-02T11:44:27.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-02T12:41:49.000000Z\\\",\\\"items\\\":[{\\\"id\\\":19,\\\"sale_id\\\":8,\\\"product_id\\\":7,\\\"invoice_date\\\":\\\"2026-05-02\\\",\\\"quantity\\\":\\\"1.00\\\",\\\"unit_price\\\":\\\"250.00\\\",\\\"cost_price\\\":\\\"250.00\\\",\\\"sale_price\\\":\\\"280.00\\\",\\\"inventory_subtotal\\\":\\\"250.00\\\",\\\"total_price\\\":\\\"250.00\\\",\\\"discount_percent\\\":\\\"0.00\\\",\\\"discount_amount\\\":\\\"0.00\\\",\\\"tax_percent\\\":\\\"0.00\\\",\\\"tax_amount\\\":\\\"0.00\\\",\\\"net_price\\\":\\\"250.00\\\",\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_at\\\":\\\"2026-05-02T12:40:59.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-02T12:40:59.000000Z\\\"}]}\"', '{\"id\": 8, \"items\": [{\"id\": 19, \"remarks\": null, \"sale_id\": 8, \"quantity\": \"1.00\", \"branch_id\": 1, \"net_price\": \"250.00\", \"cost_price\": \"250.00\", \"created_at\": \"2026-05-02T12:40:59.000000Z\", \"product_id\": 7, \"sale_price\": \"280.00\", \"tax_amount\": \"0.00\", \"unit_price\": \"250.00\", \"updated_at\": \"2026-05-02T12:40:59.000000Z\", \"tax_percent\": \"0.00\", \"total_price\": \"250.00\", \"invoice_date\": \"2026-05-02\", \"discount_amount\": \"0.00\", \"discount_percent\": \"0.00\", \"inventory_subtotal\": \"250.00\"}], \"remarks\": null, \"branch_id\": 1, \"net_total\": 250, \"adjustment\": \"0.00\", \"created_at\": \"2026-05-02T11:44:27.000000Z\", \"created_by\": 1, \"due_amount\": 250, \"invoice_no\": \"SAL-2026-05-0004\", \"tax_amount\": 0, \"updated_at\": \"2026-05-02T12:41:49.000000Z\", \"customer_id\": 1, \"paid_amount\": \"0.00\", \"tax_percent\": 0, \"invoice_date\": \"2026-05-02\", \"total_amount\": 250, \"customer_adjust\": \"0.00\", \"discount_amount\": 0, \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2026-05-02 06:41:49', NULL);
INSERT INTO `inv_user_logs` (`id`, `user_id`, `action`, `module`, `reference_id`, `old_data`, `new_data`, `branch_id`, `created_at`, `updated_at`) VALUES
(39, 1, 'sale_updated', 'sale', 8, '\"{\\\"id\\\":8,\\\"invoice_no\\\":\\\"SAL-2026-05-0004\\\",\\\"customer_id\\\":1,\\\"invoice_date\\\":\\\"2026-05-02\\\",\\\"total_amount\\\":250,\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"adjustment\\\":\\\"0.00\\\",\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"customer_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":250,\\\"paid_amount\\\":\\\"0.00\\\",\\\"due_amount\\\":250,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2026-05-02T11:44:27.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-02T13:06:29.000000Z\\\",\\\"items\\\":[{\\\"id\\\":20,\\\"sale_id\\\":8,\\\"product_id\\\":7,\\\"invoice_date\\\":\\\"2026-05-02\\\",\\\"quantity\\\":\\\"1.00\\\",\\\"unit_price\\\":\\\"250.00\\\",\\\"cost_price\\\":\\\"250.00\\\",\\\"sale_price\\\":\\\"280.00\\\",\\\"inventory_subtotal\\\":\\\"250.00\\\",\\\"total_price\\\":\\\"250.00\\\",\\\"discount_percent\\\":\\\"0.00\\\",\\\"discount_amount\\\":\\\"0.00\\\",\\\"tax_percent\\\":\\\"0.00\\\",\\\"tax_amount\\\":\\\"0.00\\\",\\\"net_price\\\":\\\"250.00\\\",\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_at\\\":\\\"2026-05-02T12:41:49.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-02T12:41:49.000000Z\\\"}]}\"', '{\"id\": 8, \"items\": [{\"id\": 20, \"remarks\": null, \"sale_id\": 8, \"quantity\": \"1.00\", \"branch_id\": 1, \"net_price\": \"250.00\", \"cost_price\": \"250.00\", \"created_at\": \"2026-05-02T12:41:49.000000Z\", \"product_id\": 7, \"sale_price\": \"280.00\", \"tax_amount\": \"0.00\", \"unit_price\": \"250.00\", \"updated_at\": \"2026-05-02T12:41:49.000000Z\", \"tax_percent\": \"0.00\", \"total_price\": \"250.00\", \"invoice_date\": \"2026-05-02\", \"discount_amount\": \"0.00\", \"discount_percent\": \"0.00\", \"inventory_subtotal\": \"250.00\"}], \"remarks\": null, \"branch_id\": 1, \"net_total\": 250, \"adjustment\": \"0.00\", \"created_at\": \"2026-05-02T11:44:27.000000Z\", \"created_by\": 1, \"due_amount\": 250, \"invoice_no\": \"SAL-2026-05-0004\", \"tax_amount\": 0, \"updated_at\": \"2026-05-02T13:06:29.000000Z\", \"customer_id\": 1, \"paid_amount\": \"0.00\", \"tax_percent\": 0, \"invoice_date\": \"2026-05-02\", \"total_amount\": 250, \"customer_adjust\": \"0.00\", \"discount_amount\": 0, \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2026-05-02 07:06:29', NULL),
(40, 1, 'sale_created', 'sale', 9, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"customer_id\\\":2,\\\"invoice_date\\\":\\\"2026-05-02\\\",\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"adjustment\\\":0,\\\"paid_amount\\\":0,\\\"invoice_no\\\":\\\"SAL-2026-05-0005\\\",\\\"total_amount\\\":250,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"net_total\\\":250,\\\"due_amount\\\":249,\\\"updated_at\\\":\\\"2026-05-02T13:07:10.000000Z\\\",\\\"created_at\\\":\\\"2026-05-02T13:07:10.000000Z\\\",\\\"id\\\":9}\"', '{\"id\": 9, \"branch_id\": 1, \"net_total\": 250, \"adjustment\": 0, \"created_at\": \"2026-05-02T13:07:10.000000Z\", \"created_by\": 1, \"due_amount\": 249, \"invoice_no\": \"SAL-2026-05-0005\", \"tax_amount\": 0, \"updated_at\": \"2026-05-02T13:07:10.000000Z\", \"customer_id\": 2, \"paid_amount\": 0, \"tax_percent\": 0, \"invoice_date\": \"2026-05-02\", \"total_amount\": 250, \"discount_amount\": 0, \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2026-05-02 07:07:10', NULL),
(41, 1, 'sale_created', 'sale', 10, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"customer_id\\\":3,\\\"invoice_date\\\":\\\"2026-05-02\\\",\\\"discount_percent\\\":15,\\\"discount_amount\\\":60,\\\"tax_percent\\\":3.53,\\\"tax_amount\\\":12,\\\"adjustment\\\":\\\"2\\\",\\\"paid_amount\\\":\\\"300\\\",\\\"invoice_no\\\":\\\"SAL-2026-05-0006\\\",\\\"total_amount\\\":400,\\\"total_discount_percent\\\":15,\\\"total_discount_amount\\\":60,\\\"total_tax_percent\\\":3.53,\\\"total_tax_amount\\\":12,\\\"net_total\\\":350,\\\"due_amount\\\":0,\\\"updated_at\\\":\\\"2026-05-02T13:23:33.000000Z\\\",\\\"created_at\\\":\\\"2026-05-02T13:23:33.000000Z\\\",\\\"id\\\":10}\"', '{\"id\": 10, \"branch_id\": 1, \"net_total\": 350, \"adjustment\": \"2\", \"created_at\": \"2026-05-02T13:23:33.000000Z\", \"created_by\": 1, \"due_amount\": 0, \"invoice_no\": \"SAL-2026-05-0006\", \"tax_amount\": 12, \"updated_at\": \"2026-05-02T13:23:33.000000Z\", \"customer_id\": 3, \"paid_amount\": \"300\", \"tax_percent\": 3.53, \"invoice_date\": \"2026-05-02\", \"total_amount\": 400, \"discount_amount\": 60, \"discount_percent\": 15, \"total_tax_amount\": 12, \"total_tax_percent\": 3.53, \"total_discount_amount\": 60, \"total_discount_percent\": 15}', 1, '2026-05-02 07:23:33', NULL),
(42, 1, 'sale_updated', 'sale', 9, '\"{\\\"id\\\":9,\\\"invoice_no\\\":\\\"SAL-2026-05-0005\\\",\\\"customer_id\\\":2,\\\"invoice_date\\\":\\\"2026-05-02\\\",\\\"total_amount\\\":450,\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"adjustment\\\":\\\"0.00\\\",\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"customer_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":450,\\\"paid_amount\\\":\\\"0.00\\\",\\\"due_amount\\\":450,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2026-05-02T13:07:10.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-03T04:55:07.000000Z\\\",\\\"items\\\":[{\\\"id\\\":22,\\\"sale_id\\\":9,\\\"product_id\\\":7,\\\"invoice_date\\\":\\\"2026-05-02\\\",\\\"quantity\\\":\\\"1.00\\\",\\\"unit_price\\\":\\\"250.00\\\",\\\"cost_price\\\":\\\"250.00\\\",\\\"sale_price\\\":\\\"280.00\\\",\\\"inventory_subtotal\\\":\\\"250.00\\\",\\\"total_price\\\":\\\"250.00\\\",\\\"discount_percent\\\":\\\"0.00\\\",\\\"discount_amount\\\":\\\"0.00\\\",\\\"tax_percent\\\":\\\"0.00\\\",\\\"tax_amount\\\":\\\"0.00\\\",\\\"net_price\\\":\\\"250.00\\\",\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_at\\\":\\\"2026-05-02T13:07:10.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-02T13:07:10.000000Z\\\"}]}\"', '{\"id\": 9, \"items\": [{\"id\": 22, \"remarks\": null, \"sale_id\": 9, \"quantity\": \"1.00\", \"branch_id\": 1, \"net_price\": \"250.00\", \"cost_price\": \"250.00\", \"created_at\": \"2026-05-02T13:07:10.000000Z\", \"product_id\": 7, \"sale_price\": \"280.00\", \"tax_amount\": \"0.00\", \"unit_price\": \"250.00\", \"updated_at\": \"2026-05-02T13:07:10.000000Z\", \"tax_percent\": \"0.00\", \"total_price\": \"250.00\", \"invoice_date\": \"2026-05-02\", \"discount_amount\": \"0.00\", \"discount_percent\": \"0.00\", \"inventory_subtotal\": \"250.00\"}], \"remarks\": null, \"branch_id\": 1, \"net_total\": 450, \"adjustment\": \"0.00\", \"created_at\": \"2026-05-02T13:07:10.000000Z\", \"created_by\": 1, \"due_amount\": 450, \"invoice_no\": \"SAL-2026-05-0005\", \"tax_amount\": 0, \"updated_at\": \"2026-05-03T04:55:07.000000Z\", \"customer_id\": 2, \"paid_amount\": \"0.00\", \"tax_percent\": 0, \"invoice_date\": \"2026-05-02\", \"total_amount\": 450, \"customer_adjust\": \"0.00\", \"discount_amount\": 0, \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2026-05-02 22:55:07', NULL),
(43, 1, 'sale_created', 'sale', 11, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"customer_id\\\":3,\\\"invoice_date\\\":\\\"2026-05-03\\\",\\\"discount_percent\\\":16.47,\\\"discount_amount\\\":140,\\\"tax_percent\\\":23.66,\\\"tax_amount\\\":168,\\\"adjustment\\\":\\\"78\\\",\\\"paid_amount\\\":\\\"500\\\",\\\"invoice_no\\\":\\\"SAL-2605-0001\\\",\\\"total_amount\\\":850,\\\"total_discount_percent\\\":16.47,\\\"total_discount_amount\\\":140,\\\"total_tax_percent\\\":23.66,\\\"total_tax_amount\\\":168,\\\"net_total\\\":800,\\\"due_amount\\\":250,\\\"updated_at\\\":\\\"2026-05-03T05:24:00.000000Z\\\",\\\"created_at\\\":\\\"2026-05-03T05:24:00.000000Z\\\",\\\"id\\\":11}\"', '{\"id\": 11, \"branch_id\": 1, \"net_total\": 800, \"adjustment\": \"78\", \"created_at\": \"2026-05-03T05:24:00.000000Z\", \"created_by\": 1, \"due_amount\": 250, \"invoice_no\": \"SAL-2605-0001\", \"tax_amount\": 168, \"updated_at\": \"2026-05-03T05:24:00.000000Z\", \"customer_id\": 3, \"paid_amount\": \"500\", \"tax_percent\": 23.66, \"invoice_date\": \"2026-05-03\", \"total_amount\": 850, \"discount_amount\": 140, \"discount_percent\": 16.47, \"total_tax_amount\": 168, \"total_tax_percent\": 23.66, \"total_discount_amount\": 140, \"total_discount_percent\": 16.47}', 1, '2026-05-02 23:24:00', NULL),
(44, 1, 'sale_created', 'sale', 12, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"customer_id\\\":3,\\\"invoice_date\\\":\\\"2026-05-03\\\",\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"adjustment\\\":0,\\\"paid_amount\\\":0,\\\"invoice_no\\\":\\\"SAL-2605-0002\\\",\\\"total_amount\\\":500,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"net_total\\\":500,\\\"due_amount\\\":500,\\\"updated_at\\\":\\\"2026-05-03T05:31:58.000000Z\\\",\\\"created_at\\\":\\\"2026-05-03T05:31:58.000000Z\\\",\\\"id\\\":12}\"', '{\"id\": 12, \"branch_id\": 1, \"net_total\": 500, \"adjustment\": 0, \"created_at\": \"2026-05-03T05:31:58.000000Z\", \"created_by\": 1, \"due_amount\": 500, \"invoice_no\": \"SAL-2605-0002\", \"tax_amount\": 0, \"updated_at\": \"2026-05-03T05:31:58.000000Z\", \"customer_id\": 3, \"paid_amount\": 0, \"tax_percent\": 0, \"invoice_date\": \"2026-05-03\", \"total_amount\": 500, \"discount_amount\": 0, \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2026-05-02 23:31:58', NULL),
(45, 1, 'sale_created', 'sale', 13, '\"{\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"customer_id\\\":1,\\\"invoice_date\\\":\\\"2026-05-03\\\",\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"adjustment\\\":0,\\\"paid_amount\\\":0,\\\"invoice_no\\\":\\\"SAL-2605-0003\\\",\\\"total_amount\\\":250,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"net_total\\\":250,\\\"due_amount\\\":250,\\\"updated_at\\\":\\\"2026-05-03T05:35:07.000000Z\\\",\\\"created_at\\\":\\\"2026-05-03T05:35:07.000000Z\\\",\\\"id\\\":13}\"', '{\"id\": 13, \"branch_id\": 1, \"net_total\": 250, \"adjustment\": 0, \"created_at\": \"2026-05-03T05:35:07.000000Z\", \"created_by\": 1, \"due_amount\": 250, \"invoice_no\": \"SAL-2605-0003\", \"tax_amount\": 0, \"updated_at\": \"2026-05-03T05:35:07.000000Z\", \"customer_id\": 1, \"paid_amount\": 0, \"tax_percent\": 0, \"invoice_date\": \"2026-05-03\", \"total_amount\": 250, \"discount_amount\": 0, \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2026-05-02 23:35:07', NULL),
(46, 1, 'sale_updated', 'sale', 13, '\"{\\\"id\\\":13,\\\"invoice_no\\\":\\\"SAL-2605-0003\\\",\\\"customer_id\\\":1,\\\"invoice_date\\\":\\\"2026-05-03\\\",\\\"total_amount\\\":250,\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"adjustment\\\":\\\"0.00\\\",\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"customer_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":250,\\\"paid_amount\\\":\\\"0.00\\\",\\\"due_amount\\\":250,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2026-05-03T05:35:07.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-03T05:46:46.000000Z\\\",\\\"items\\\":[{\\\"id\\\":31,\\\"sale_id\\\":13,\\\"product_id\\\":7,\\\"invoice_date\\\":\\\"2026-05-03\\\",\\\"quantity\\\":\\\"1.00\\\",\\\"unit_price\\\":\\\"250.00\\\",\\\"cost_price\\\":\\\"250.00\\\",\\\"sale_price\\\":\\\"280.00\\\",\\\"inventory_subtotal\\\":\\\"250.00\\\",\\\"total_price\\\":\\\"250.00\\\",\\\"discount_percent\\\":\\\"0.00\\\",\\\"discount_amount\\\":\\\"0.00\\\",\\\"tax_percent\\\":\\\"0.00\\\",\\\"tax_amount\\\":\\\"0.00\\\",\\\"net_price\\\":\\\"250.00\\\",\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_at\\\":\\\"2026-05-03T05:35:07.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-03T05:35:07.000000Z\\\"}]}\"', '{\"id\": 13, \"items\": [{\"id\": 31, \"remarks\": null, \"sale_id\": 13, \"quantity\": \"1.00\", \"branch_id\": 1, \"net_price\": \"250.00\", \"cost_price\": \"250.00\", \"created_at\": \"2026-05-03T05:35:07.000000Z\", \"product_id\": 7, \"sale_price\": \"280.00\", \"tax_amount\": \"0.00\", \"unit_price\": \"250.00\", \"updated_at\": \"2026-05-03T05:35:07.000000Z\", \"tax_percent\": \"0.00\", \"total_price\": \"250.00\", \"invoice_date\": \"2026-05-03\", \"discount_amount\": \"0.00\", \"discount_percent\": \"0.00\", \"inventory_subtotal\": \"250.00\"}], \"remarks\": null, \"branch_id\": 1, \"net_total\": 250, \"adjustment\": \"0.00\", \"created_at\": \"2026-05-03T05:35:07.000000Z\", \"created_by\": 1, \"due_amount\": 250, \"invoice_no\": \"SAL-2605-0003\", \"tax_amount\": 0, \"updated_at\": \"2026-05-03T05:46:46.000000Z\", \"customer_id\": 1, \"paid_amount\": \"0.00\", \"tax_percent\": 0, \"invoice_date\": \"2026-05-03\", \"total_amount\": 250, \"customer_adjust\": \"0.00\", \"discount_amount\": 0, \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2026-05-02 23:46:46', NULL),
(47, 1, 'sale_updated', 'sale', 13, '\"{\\\"id\\\":13,\\\"invoice_no\\\":\\\"SAL-2605-0003\\\",\\\"customer_id\\\":1,\\\"invoice_date\\\":\\\"2026-05-03\\\",\\\"total_amount\\\":250,\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"adjustment\\\":\\\"0.00\\\",\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"customer_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":250,\\\"paid_amount\\\":\\\"0.00\\\",\\\"due_amount\\\":250,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2026-05-03T05:35:07.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-03T05:49:36.000000Z\\\",\\\"items\\\":[{\\\"id\\\":32,\\\"sale_id\\\":13,\\\"product_id\\\":7,\\\"invoice_date\\\":\\\"2026-05-03\\\",\\\"quantity\\\":\\\"1.00\\\",\\\"unit_price\\\":\\\"250.00\\\",\\\"cost_price\\\":\\\"250.00\\\",\\\"sale_price\\\":\\\"280.00\\\",\\\"inventory_subtotal\\\":\\\"250.00\\\",\\\"total_price\\\":\\\"250.00\\\",\\\"discount_percent\\\":\\\"0.00\\\",\\\"discount_amount\\\":\\\"0.00\\\",\\\"tax_percent\\\":\\\"0.00\\\",\\\"tax_amount\\\":\\\"0.00\\\",\\\"net_price\\\":\\\"250.00\\\",\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_at\\\":\\\"2026-05-03T05:46:46.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-03T05:46:46.000000Z\\\"}]}\"', '{\"id\": 13, \"items\": [{\"id\": 32, \"remarks\": null, \"sale_id\": 13, \"quantity\": \"1.00\", \"branch_id\": 1, \"net_price\": \"250.00\", \"cost_price\": \"250.00\", \"created_at\": \"2026-05-03T05:46:46.000000Z\", \"product_id\": 7, \"sale_price\": \"280.00\", \"tax_amount\": \"0.00\", \"unit_price\": \"250.00\", \"updated_at\": \"2026-05-03T05:46:46.000000Z\", \"tax_percent\": \"0.00\", \"total_price\": \"250.00\", \"invoice_date\": \"2026-05-03\", \"discount_amount\": \"0.00\", \"discount_percent\": \"0.00\", \"inventory_subtotal\": \"250.00\"}], \"remarks\": null, \"branch_id\": 1, \"net_total\": 250, \"adjustment\": \"0.00\", \"created_at\": \"2026-05-03T05:35:07.000000Z\", \"created_by\": 1, \"due_amount\": 250, \"invoice_no\": \"SAL-2605-0003\", \"tax_amount\": 0, \"updated_at\": \"2026-05-03T05:49:36.000000Z\", \"customer_id\": 1, \"paid_amount\": \"0.00\", \"tax_percent\": 0, \"invoice_date\": \"2026-05-03\", \"total_amount\": 250, \"customer_adjust\": \"0.00\", \"discount_amount\": 0, \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2026-05-02 23:49:36', NULL),
(48, 1, 'sale_updated', 'sale', 13, '\"{\\\"id\\\":13,\\\"invoice_no\\\":\\\"SAL-2605-0003\\\",\\\"customer_id\\\":1,\\\"invoice_date\\\":\\\"2026-05-03\\\",\\\"total_amount\\\":250,\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"adjustment\\\":\\\"0.00\\\",\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"customer_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":250,\\\"paid_amount\\\":\\\"0.00\\\",\\\"due_amount\\\":250,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2026-05-03T05:35:07.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-03T05:49:56.000000Z\\\",\\\"items\\\":[{\\\"id\\\":33,\\\"sale_id\\\":13,\\\"product_id\\\":7,\\\"invoice_date\\\":\\\"2026-05-03\\\",\\\"quantity\\\":\\\"1.00\\\",\\\"unit_price\\\":\\\"250.00\\\",\\\"cost_price\\\":\\\"250.00\\\",\\\"sale_price\\\":\\\"280.00\\\",\\\"inventory_subtotal\\\":\\\"250.00\\\",\\\"total_price\\\":\\\"250.00\\\",\\\"discount_percent\\\":\\\"0.00\\\",\\\"discount_amount\\\":\\\"0.00\\\",\\\"tax_percent\\\":\\\"0.00\\\",\\\"tax_amount\\\":\\\"0.00\\\",\\\"net_price\\\":\\\"250.00\\\",\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_at\\\":\\\"2026-05-03T05:49:36.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-03T05:49:36.000000Z\\\"}]}\"', '{\"id\": 13, \"items\": [{\"id\": 33, \"remarks\": null, \"sale_id\": 13, \"quantity\": \"1.00\", \"branch_id\": 1, \"net_price\": \"250.00\", \"cost_price\": \"250.00\", \"created_at\": \"2026-05-03T05:49:36.000000Z\", \"product_id\": 7, \"sale_price\": \"280.00\", \"tax_amount\": \"0.00\", \"unit_price\": \"250.00\", \"updated_at\": \"2026-05-03T05:49:36.000000Z\", \"tax_percent\": \"0.00\", \"total_price\": \"250.00\", \"invoice_date\": \"2026-05-03\", \"discount_amount\": \"0.00\", \"discount_percent\": \"0.00\", \"inventory_subtotal\": \"250.00\"}], \"remarks\": null, \"branch_id\": 1, \"net_total\": 250, \"adjustment\": \"0.00\", \"created_at\": \"2026-05-03T05:35:07.000000Z\", \"created_by\": 1, \"due_amount\": 250, \"invoice_no\": \"SAL-2605-0003\", \"tax_amount\": 0, \"updated_at\": \"2026-05-03T05:49:56.000000Z\", \"customer_id\": 1, \"paid_amount\": \"0.00\", \"tax_percent\": 0, \"invoice_date\": \"2026-05-03\", \"total_amount\": 250, \"customer_adjust\": \"0.00\", \"discount_amount\": 0, \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2026-05-02 23:49:56', NULL),
(49, 1, 'sale_updated', 'sale', 13, '\"{\\\"id\\\":13,\\\"invoice_no\\\":\\\"SAL-2605-0003\\\",\\\"customer_id\\\":1,\\\"invoice_date\\\":\\\"2026-05-03\\\",\\\"total_amount\\\":250,\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"adjustment\\\":\\\"0.00\\\",\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"customer_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":250,\\\"paid_amount\\\":\\\"0.00\\\",\\\"due_amount\\\":250,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2026-05-03T05:35:07.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-03T05:51:14.000000Z\\\",\\\"items\\\":[{\\\"id\\\":34,\\\"sale_id\\\":13,\\\"product_id\\\":7,\\\"invoice_date\\\":\\\"2026-05-03\\\",\\\"quantity\\\":\\\"1.00\\\",\\\"unit_price\\\":\\\"250.00\\\",\\\"cost_price\\\":\\\"250.00\\\",\\\"sale_price\\\":\\\"280.00\\\",\\\"inventory_subtotal\\\":\\\"250.00\\\",\\\"total_price\\\":\\\"250.00\\\",\\\"discount_percent\\\":\\\"0.00\\\",\\\"discount_amount\\\":\\\"0.00\\\",\\\"tax_percent\\\":\\\"0.00\\\",\\\"tax_amount\\\":\\\"0.00\\\",\\\"net_price\\\":\\\"250.00\\\",\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_at\\\":\\\"2026-05-03T05:49:56.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-03T05:49:56.000000Z\\\"}]}\"', '{\"id\": 13, \"items\": [{\"id\": 34, \"remarks\": null, \"sale_id\": 13, \"quantity\": \"1.00\", \"branch_id\": 1, \"net_price\": \"250.00\", \"cost_price\": \"250.00\", \"created_at\": \"2026-05-03T05:49:56.000000Z\", \"product_id\": 7, \"sale_price\": \"280.00\", \"tax_amount\": \"0.00\", \"unit_price\": \"250.00\", \"updated_at\": \"2026-05-03T05:49:56.000000Z\", \"tax_percent\": \"0.00\", \"total_price\": \"250.00\", \"invoice_date\": \"2026-05-03\", \"discount_amount\": \"0.00\", \"discount_percent\": \"0.00\", \"inventory_subtotal\": \"250.00\"}], \"remarks\": null, \"branch_id\": 1, \"net_total\": 250, \"adjustment\": \"0.00\", \"created_at\": \"2026-05-03T05:35:07.000000Z\", \"created_by\": 1, \"due_amount\": 250, \"invoice_no\": \"SAL-2605-0003\", \"tax_amount\": 0, \"updated_at\": \"2026-05-03T05:51:14.000000Z\", \"customer_id\": 1, \"paid_amount\": \"0.00\", \"tax_percent\": 0, \"invoice_date\": \"2026-05-03\", \"total_amount\": 250, \"customer_adjust\": \"0.00\", \"discount_amount\": 0, \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2026-05-02 23:51:14', NULL),
(50, 1, 'sale_updated', 'sale', 12, '\"{\\\"id\\\":12,\\\"invoice_no\\\":\\\"SAL-2605-0002\\\",\\\"customer_id\\\":3,\\\"invoice_date\\\":\\\"2026-05-03\\\",\\\"total_amount\\\":500,\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"adjustment\\\":\\\"0.00\\\",\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"customer_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":500,\\\"paid_amount\\\":\\\"0.00\\\",\\\"due_amount\\\":500,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2026-05-03T05:31:58.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-03T05:52:28.000000Z\\\",\\\"items\\\":[{\\\"id\\\":30,\\\"sale_id\\\":12,\\\"product_id\\\":6,\\\"invoice_date\\\":\\\"2026-05-03\\\",\\\"quantity\\\":\\\"1.00\\\",\\\"unit_price\\\":\\\"500.00\\\",\\\"cost_price\\\":\\\"500.00\\\",\\\"sale_price\\\":\\\"600.00\\\",\\\"inventory_subtotal\\\":\\\"500.00\\\",\\\"total_price\\\":\\\"500.00\\\",\\\"discount_percent\\\":\\\"0.00\\\",\\\"discount_amount\\\":\\\"0.00\\\",\\\"tax_percent\\\":\\\"0.00\\\",\\\"tax_amount\\\":\\\"0.00\\\",\\\"net_price\\\":\\\"500.00\\\",\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_at\\\":\\\"2026-05-03T05:31:58.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-03T05:31:58.000000Z\\\"}]}\"', '{\"id\": 12, \"items\": [{\"id\": 30, \"remarks\": null, \"sale_id\": 12, \"quantity\": \"1.00\", \"branch_id\": 1, \"net_price\": \"500.00\", \"cost_price\": \"500.00\", \"created_at\": \"2026-05-03T05:31:58.000000Z\", \"product_id\": 6, \"sale_price\": \"600.00\", \"tax_amount\": \"0.00\", \"unit_price\": \"500.00\", \"updated_at\": \"2026-05-03T05:31:58.000000Z\", \"tax_percent\": \"0.00\", \"total_price\": \"500.00\", \"invoice_date\": \"2026-05-03\", \"discount_amount\": \"0.00\", \"discount_percent\": \"0.00\", \"inventory_subtotal\": \"500.00\"}], \"remarks\": null, \"branch_id\": 1, \"net_total\": 500, \"adjustment\": \"0.00\", \"created_at\": \"2026-05-03T05:31:58.000000Z\", \"created_by\": 1, \"due_amount\": 500, \"invoice_no\": \"SAL-2605-0002\", \"tax_amount\": 0, \"updated_at\": \"2026-05-03T05:52:28.000000Z\", \"customer_id\": 3, \"paid_amount\": \"0.00\", \"tax_percent\": 0, \"invoice_date\": \"2026-05-03\", \"total_amount\": 500, \"customer_adjust\": \"0.00\", \"discount_amount\": 0, \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2026-05-02 23:52:28', NULL),
(51, 1, 'sale_updated', 'sale', 12, '\"{\\\"id\\\":12,\\\"invoice_no\\\":\\\"SAL-2605-0002\\\",\\\"customer_id\\\":3,\\\"invoice_date\\\":\\\"2026-05-03\\\",\\\"total_amount\\\":500,\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"adjustment\\\":\\\"0.00\\\",\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"customer_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":500,\\\"paid_amount\\\":\\\"0.00\\\",\\\"due_amount\\\":500,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2026-05-03T05:31:58.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-03T05:52:58.000000Z\\\",\\\"items\\\":[{\\\"id\\\":38,\\\"sale_id\\\":12,\\\"product_id\\\":6,\\\"invoice_date\\\":\\\"2026-05-03\\\",\\\"quantity\\\":\\\"1.00\\\",\\\"unit_price\\\":\\\"500.00\\\",\\\"cost_price\\\":\\\"500.00\\\",\\\"sale_price\\\":\\\"600.00\\\",\\\"inventory_subtotal\\\":\\\"500.00\\\",\\\"total_price\\\":\\\"500.00\\\",\\\"discount_percent\\\":\\\"0.00\\\",\\\"discount_amount\\\":\\\"0.00\\\",\\\"tax_percent\\\":\\\"0.00\\\",\\\"tax_amount\\\":\\\"0.00\\\",\\\"net_price\\\":\\\"500.00\\\",\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_at\\\":\\\"2026-05-03T05:52:28.000000Z\\\",\\\"updated_at\\\":\\\"2026-05-03T05:52:28.000000Z\\\"}]}\"', '{\"id\": 12, \"items\": [{\"id\": 38, \"remarks\": null, \"sale_id\": 12, \"quantity\": \"1.00\", \"branch_id\": 1, \"net_price\": \"500.00\", \"cost_price\": \"500.00\", \"created_at\": \"2026-05-03T05:52:28.000000Z\", \"product_id\": 6, \"sale_price\": \"600.00\", \"tax_amount\": \"0.00\", \"unit_price\": \"500.00\", \"updated_at\": \"2026-05-03T05:52:28.000000Z\", \"tax_percent\": \"0.00\", \"total_price\": \"500.00\", \"invoice_date\": \"2026-05-03\", \"discount_amount\": \"0.00\", \"discount_percent\": \"0.00\", \"inventory_subtotal\": \"500.00\"}], \"remarks\": null, \"branch_id\": 1, \"net_total\": 500, \"adjustment\": \"0.00\", \"created_at\": \"2026-05-03T05:31:58.000000Z\", \"created_by\": 1, \"due_amount\": 500, \"invoice_no\": \"SAL-2605-0002\", \"tax_amount\": 0, \"updated_at\": \"2026-05-03T05:52:58.000000Z\", \"customer_id\": 3, \"paid_amount\": \"0.00\", \"tax_percent\": 0, \"invoice_date\": \"2026-05-03\", \"total_amount\": 500, \"customer_adjust\": \"0.00\", \"discount_amount\": 0, \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2026-05-02 23:52:58', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_05_30_043217_create_modules_table', 1),
(5, '2025_05_30_050552_create_permission_groups_table', 1),
(6, '2025_05_31_050552_create_permission_tables', 1),
(7, '2025_05_31_050702_create_personal_access_tokens_table', 1),
(8, '2025_06_04_110721_add_redirect_url_and_direction_to_roles_table', 1),
(9, '2025_06_04_131210_create_settings_table', 1),
(10, '2025_07_24_053036_create_module_sections_table', 1),
(11, '2025_07_27_121904_create_admin_menus_table', 1),
(12, '2025_08_24_091444_create_branches_table', 2),
(23, '2025_08_24_091555_create_inv_categories_table', 3),
(24, '2025_08_24_091850_create_inv_units_table', 3),
(25, '2025_08_24_091851_create_inv_brands_table', 3),
(27, '2025_08_24_092424_create_inv_suppliers_table', 3),
(28, '2025_08_24_092545_create_inv_customers_table', 3),
(29, '2025_08_24_091956_create_inv_products_table', 4),
(34, '2025_09_04_045138_create_inv_product_sets_table', 5),
(35, '2025_09_04_045243_create_inv_product_set_items_table', 5),
(36, '2025_09_04_100246_create_acc_account_heads_table', 6),
(37, '2025_09_04_100543_create_acc_journal_entries_table', 6),
(38, '2025_09_04_101618_create_acc_journal_entry_details_table', 6),
(40, '2025_09_04_102546_create_acc_account_settings_table', 6),
(41, '2025_09_04_102715_create_acc_account_users_table', 6),
(42, '2025_09_04_103522_create_acc_account_balances_table', 6),
(43, '2025_09_04_105938_create_acc_audit_logs_table', 6),
(44, '2025_09_04_112348_create_acc_voucher_types_table', 7),
(45, '2025_09_07_073249_create_acc_module_entries_table', 8),
(46, '2025_09_07_073307_create_acc_module_entry_accounts_table', 8),
(48, '2025_09_22_050000_create_inv_supplier_advances_table', 9),
(49, '2025_09_22_052609_create_inv_supplier_ledgers_table', 9),
(50, '2025_09_25_091333_create_inv_purchases_table', 10),
(51, '2025_09_25_091749_create_inv_purchase_items_table', 10),
(52, '2025_09_25_092440_create_inv_stock_movements_table', 10),
(53, '2025_09_25_093825_create_inv_stock_balances_table', 10),
(54, '2025_09_25_094157_create_inv_price_lists_table', 10),
(55, '2025_09_25_095806_create_inv_payments_table', 10),
(56, '2025_09_25_100324_create_inv_user_logs_table', 10),
(57, '2025_11_24_062047_create_inv_sales_table', 11),
(59, '2025_11_24_062438_create_inv_customer_ledgers_table', 12),
(60, '2025_11_24_063757_create_inv_customer_advances_table', 13),
(61, '2025_11_24_062321_create_inv_sale_items_table', 14),
(62, '2026_05_03_065811_create_inv_sale_returns_table', 15),
(63, '2026_05_03_065835_create_inv_sale_return_items_table', 15),
(64, '2026_06_06_092611_create_inv_customer_payments_table', 16),
(65, '2026_06_11_092611_create_inv_supplier_payments_table', 17),
(66, '2026_06_13_065811_create_inv_purchase_returns_table', 18),
(67, '2026_06_13_065835_create_inv_purchase_return_items_table', 18),
(68, '2026_06_24_065835_create_inv_stock_transfers_table', 19),
(69, '2026_06_24_065836_create_inv_stock_transfer_items_table', 19),
(70, '2026_07_12_065836_create_inv_product_wastages_table', 20),
(71, '2026_07_12_065837_create_inv_product_wastage_items_table', 20),
(72, '2026_08_15_055148_create_hrm_departments_table', 21),
(73, '2026_08_15_055952_create_hrm_designations_table', 21),
(74, '2026_08_15_075420_create_hrm_genders_table', 21),
(75, '2026_08_15_075522_create_hrm_religions_table', 21),
(76, '2026_08_15_075624_create_hrm_shifts_table', 21),
(77, '2026_08_15_075704_create_hrm_employee_types_table', 21),
(78, '2026_08_15_075746_create_hrm_employee_statuses_table', 21),
(80, '2026_08_15_075903_create_hrm_blood_groups_table', 22),
(81, '2026_08_15_102250_create_hrm_employee_categories_table', 23),
(82, '2026_08_15_102342_create_hrm_employees_table', 23),
(83, '2026_08_15_075903_create_hrm_leave_categories_table', 24),
(88, '2026_08_29_072711_create_hrm_leaves_table', 25),
(89, '2026_08_29_072738_create_hrn_leave_details_table', 25);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'Modules\\Core\\Models\\User', 1);

-- --------------------------------------------------------

--
-- Table structure for table `modules`
--

CREATE TABLE `modules` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `modules`
--

INSERT INTO `modules` (`id`, `name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Core', 'core', 1, '2025-08-24 06:37:38', '2025-08-24 06:37:38'),
(2, 'Inventory', 'inventory', 1, '2025-08-24 06:38:08', '2025-08-24 06:38:08'),
(3, 'Accounting', 'accounting', 1, '2025-09-04 03:52:01', '2025-09-04 03:52:01'),
(4, 'HRM', 'hrm', 1, '2026-08-14 23:25:17', '2026-08-14 23:25:17');

-- --------------------------------------------------------

--
-- Table structure for table `module_sections`
--

CREATE TABLE `module_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `module_id` bigint UNSIGNED NOT NULL,
  `section_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `section_action_route` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `section_roles_permission` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `guard_name`, `group_id`, `created_at`, `updated_at`) VALUES
(1, 'api.core.user-menus', 'Api Core User-menus', 'sanctum', 1, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(2, 'api.core.settings.update', 'Api Core Settings Update', 'sanctum', 2, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(3, 'api.core.users.index', 'Api Core Users Index', 'sanctum', 3, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(4, 'api.core.users.store', 'Api Core Users Store', 'sanctum', 3, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(5, 'api.core.users.show', 'Api Core Users Show', 'sanctum', 3, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(6, 'api.core.users.update', 'Api Core Users Update', 'sanctum', 3, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(7, 'api.core.users.destroy', 'Api Core Users Destroy', 'sanctum', 3, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(8, 'api.core.roles.index', 'Api Core Roles Index', 'sanctum', 4, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(9, 'api.core.roles.store', 'Api Core Roles Store', 'sanctum', 4, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(10, 'api.core.roles.show', 'Api Core Roles Show', 'sanctum', 4, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(11, 'api.core.roles.update', 'Api Core Roles Update', 'sanctum', 4, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(12, 'api.core.roles.destroy', 'Api Core Roles Destroy', 'sanctum', 4, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(13, 'api.core.modules.index', 'Api Core Modules Index', 'sanctum', 5, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(14, 'api.core.modules.store', 'Api Core Modules Store', 'sanctum', 5, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(15, 'api.core.modules.show', 'Api Core Modules Show', 'sanctum', 5, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(16, 'api.core.modules.update', 'Api Core Modules Update', 'sanctum', 5, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(17, 'api.core.modules.destroy', 'Api Core Modules Destroy', 'sanctum', 5, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(18, 'api.core.admin-menus.parent', 'Api Core Admin-menus Parent', 'sanctum', 6, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(19, 'api.core.admin-menus.reorder', 'Api Core Admin-menus Reorder', 'sanctum', 6, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(20, 'api.core.admin-menus.index', 'Api Core Admin-menus Index', 'sanctum', 6, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(21, 'api.core.admin-menus.store', 'Api Core Admin-menus Store', 'sanctum', 6, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(22, 'api.core.admin-menus.show', 'Api Core Admin-menus Show', 'sanctum', 6, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(23, 'api.core.admin-menus.update', 'Api Core Admin-menus Update', 'sanctum', 6, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(24, 'api.core.admin-menus.destroy', 'Api Core Admin-menus Destroy', 'sanctum', 6, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(25, 'api.core.permission.sections', 'Api Core Permission Sections', 'sanctum', 7, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(26, 'api.core.permission.permissions', 'Api Core Permission Permissions', 'sanctum', 7, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(27, 'api.core.permission.store', 'Api Core Permission Store', 'sanctum', 7, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(28, 'api.core.permission.assign', 'Api Core Permission Assign', 'sanctum', 7, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(30, 'api.core.branches.index', 'Api Core Branches Index', 'sanctum', 9, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(31, 'api.core.branches.store', 'Api Core Branches Store', 'sanctum', 9, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(32, 'api.core.branches.show', 'Api Core Branches Show', 'sanctum', 9, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(33, 'api.core.branches.update', 'Api Core Branches Update', 'sanctum', 9, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(34, 'api.core.branches.destroy', 'Api Core Branches Destroy', 'sanctum', 9, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(36, 'api.core..food-lists', 'Api Core  Food-lists', 'sanctum', 10, '2025-08-24 07:15:28', '2025-08-24 07:15:28'),
(37, 'api.core.', 'Api Core ', 'sanctum', 10, '2025-08-24 07:15:28', '2025-08-24 07:15:28'),
(38, 'api.inventory.categories.index', 'Api Inventory Categories Index', 'sanctum', 11, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(39, 'api.inventory.categories.store', 'Api Inventory Categories Store', 'sanctum', 11, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(40, 'api.inventory.categories.show', 'Api Inventory Categories Show', 'sanctum', 11, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(41, 'api.inventory.categories.update', 'Api Inventory Categories Update', 'sanctum', 11, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(42, 'api.inventory.categories.destroy', 'Api Inventory Categories Destroy', 'sanctum', 11, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(43, 'api.inventory.units.index', 'Api Inventory Units Index', 'sanctum', 12, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(44, 'api.inventory.units.store', 'Api Inventory Units Store', 'sanctum', 12, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(45, 'api.inventory.units.show', 'Api Inventory Units Show', 'sanctum', 12, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(46, 'api.inventory.units.update', 'Api Inventory Units Update', 'sanctum', 12, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(47, 'api.inventory.units.destroy', 'Api Inventory Units Destroy', 'sanctum', 12, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(48, 'api.inventory.brands.index', 'Api Inventory Brands Index', 'sanctum', 13, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(49, 'api.inventory.brands.store', 'Api Inventory Brands Store', 'sanctum', 13, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(50, 'api.inventory.brands.show', 'Api Inventory Brands Show', 'sanctum', 13, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(51, 'api.inventory.brands.update', 'Api Inventory Brands Update', 'sanctum', 13, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(52, 'api.inventory.brands.destroy', 'Api Inventory Brands Destroy', 'sanctum', 13, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(53, 'api.inventory.products.index', 'Api Inventory Products Index', 'sanctum', 14, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(54, 'api.inventory.products.store', 'Api Inventory Products Store', 'sanctum', 14, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(55, 'api.inventory.products.show', 'Api Inventory Products Show', 'sanctum', 14, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(56, 'api.inventory.products.update', 'Api Inventory Products Update', 'sanctum', 14, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(57, 'api.inventory.products.destroy', 'Api Inventory Products Destroy', 'sanctum', 14, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(58, 'api.inventory.suppliers.index', 'Api Inventory Suppliers Index', 'sanctum', 15, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(59, 'api.inventory.suppliers.store', 'Api Inventory Suppliers Store', 'sanctum', 15, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(60, 'api.inventory.suppliers.show', 'Api Inventory Suppliers Show', 'sanctum', 15, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(61, 'api.inventory.suppliers.update', 'Api Inventory Suppliers Update', 'sanctum', 15, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(62, 'api.inventory.suppliers.destroy', 'Api Inventory Suppliers Destroy', 'sanctum', 15, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(63, 'api.inventory.customers.index', 'Api Inventory Customers Index', 'sanctum', 16, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(64, 'api.inventory.customers.store', 'Api Inventory Customers Store', 'sanctum', 16, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(65, 'api.inventory.customers.show', 'Api Inventory Customers Show', 'sanctum', 16, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(66, 'api.inventory.customers.update', 'Api Inventory Customers Update', 'sanctum', 16, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(67, 'api.inventory.customers.destroy', 'Api Inventory Customers Destroy', 'sanctum', 16, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(68, 'api.inventory.product-sets.index', 'Api Inventory Product-sets Index', 'sanctum', 17, '2025-09-04 03:27:44', '2025-09-04 03:27:44'),
(69, 'api.inventory.product-sets.store', 'Api Inventory Product-sets Store', 'sanctum', 17, '2025-09-04 03:27:44', '2025-09-04 03:27:44'),
(70, 'api.inventory.product-sets.show', 'Api Inventory Product-sets Show', 'sanctum', 17, '2025-09-04 03:27:44', '2025-09-04 03:27:44'),
(71, 'api.inventory.product-sets.update', 'Api Inventory Product-sets Update', 'sanctum', 17, '2025-09-04 03:27:44', '2025-09-04 03:27:44'),
(72, 'api.inventory.product-sets.destroy', 'Api Inventory Product-sets Destroy', 'sanctum', 17, '2025-09-04 03:27:44', '2025-09-04 03:27:44'),
(73, 'api.accounting.chart-of-accounts.index', 'Api Accounting Chart-of-accounts Index', 'sanctum', 18, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(74, 'api.accounting.chart-of-accounts.store', 'Api Accounting Chart-of-accounts Store', 'sanctum', 18, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(75, 'api.accounting.chart-of-accounts.show', 'Api Accounting Chart-of-accounts Show', 'sanctum', 18, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(76, 'api.accounting.chart-of-accounts.update', 'Api Accounting Chart-of-accounts Update', 'sanctum', 18, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(77, 'api.accounting.chart-of-accounts.destroy', 'Api Accounting Chart-of-accounts Destroy', 'sanctum', 18, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(78, 'api.accounting.account-heads', 'Api Accounting Account-heads', 'sanctum', 19, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(79, 'api.accounting.voucher-types', 'Api Accounting Voucher-types', 'sanctum', 20, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(80, 'api.accounting.journal-entries.index', 'Api Accounting Journal-entries Index', 'sanctum', 21, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(81, 'api.accounting.journal-entries.store', 'Api Accounting Journal-entries Store', 'sanctum', 21, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(82, 'api.accounting.journal-entries.show', 'Api Accounting Journal-entries Show', 'sanctum', 21, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(83, 'api.accounting.journal-entries.update', 'Api Accounting Journal-entries Update', 'sanctum', 21, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(84, 'api.accounting.journal-entries.destroy', 'Api Accounting Journal-entries Destroy', 'sanctum', 21, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(85, 'api.accounting.account-modules.index', 'Api Accounting Account-modules Index', 'sanctum', 22, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(86, 'api.accounting.account-modules.store', 'Api Accounting Account-modules Store', 'sanctum', 22, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(87, 'api.accounting.account-modules.show', 'Api Accounting Account-modules Show', 'sanctum', 22, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(88, 'api.accounting.account-modules.update', 'Api Accounting Account-modules Update', 'sanctum', 22, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(89, 'api.accounting.account-modules.destroy', 'Api Accounting Account-modules Destroy', 'sanctum', 22, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(90, 'api.accounting.generate-reference-no', 'Api Accounting Generate-reference-no', 'sanctum', 23, '2025-09-23 04:54:57', '2025-09-23 04:54:57'),
(91, 'api.inventory.supplier-advance.index', 'Api Inventory Supplier-advance Index', 'sanctum', 24, '2025-09-23 04:54:57', '2025-09-23 04:54:57'),
(92, 'api.inventory.supplier-advance.store', 'Api Inventory Supplier-advance Store', 'sanctum', 24, '2025-09-23 04:54:57', '2025-09-23 04:54:57'),
(93, 'api.inventory.supplier-advance.show', 'Api Inventory Supplier-advance Show', 'sanctum', 24, '2025-09-23 04:54:57', '2025-09-23 04:54:57'),
(94, 'api.inventory.supplier-advance.update', 'Api Inventory Supplier-advance Update', 'sanctum', 24, '2025-09-23 04:54:57', '2025-09-23 04:54:57'),
(95, 'api.inventory.supplier-advance.destroy', 'Api Inventory Supplier-advance Destroy', 'sanctum', 24, '2025-09-23 04:54:57', '2025-09-23 04:54:57'),
(96, 'api.inventory.', 'Api Inventory ', 'sanctum', 25, '2025-09-23 04:54:57', '2025-09-23 04:54:57'),
(97, 'api.inventory.products-overview', 'Api Inventory Products-overview', 'sanctum', 26, '2025-11-04 03:13:47', '2025-11-04 03:13:47'),
(98, 'api.inventory.suppliers.balances', 'Api Inventory Suppliers Balances', 'sanctum', 15, '2025-11-04 03:13:47', '2025-11-04 03:13:47'),
(99, 'api.inventory.purchases.index', 'Api Inventory Purchases Index', 'sanctum', 27, '2025-11-04 03:13:47', '2025-11-04 03:13:47'),
(100, 'api.inventory.purchases.store', 'Api Inventory Purchases Store', 'sanctum', 27, '2025-11-04 03:13:47', '2025-11-04 03:13:47'),
(101, 'api.inventory.purchases.show', 'Api Inventory Purchases Show', 'sanctum', 27, '2025-11-04 03:13:47', '2025-11-04 03:13:47'),
(102, 'api.inventory.purchases.update', 'Api Inventory Purchases Update', 'sanctum', 27, '2025-11-04 03:13:47', '2025-11-04 03:13:47'),
(103, 'api.inventory.purchases.destroy', 'Api Inventory Purchases Destroy', 'sanctum', 27, '2025-11-04 03:13:47', '2025-11-04 03:13:47');

-- --------------------------------------------------------

--
-- Table structure for table `permission_groups`
--

CREATE TABLE `permission_groups` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permission_groups`
--

INSERT INTO `permission_groups` (`id`, `name`, `module_id`, `created_at`, `updated_at`) VALUES
(1, 'user-menus', 1, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(2, 'settings', 1, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(3, 'users', 1, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(4, 'roles', 1, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(5, 'modules', 1, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(6, 'admin-menus', 1, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(7, 'permission', 1, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(9, 'branches', 1, '2025-08-24 07:00:31', '2025-08-24 07:00:31'),
(10, '', 1, '2025-08-24 07:15:28', '2025-08-24 07:15:28'),
(11, 'categories', 2, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(12, 'units', 2, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(13, 'brands', 2, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(14, 'products', 2, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(15, 'suppliers', 2, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(16, 'customers', 2, '2025-08-26 04:11:22', '2025-08-26 04:11:22'),
(17, 'product-sets', 2, '2025-09-04 03:27:44', '2025-09-04 03:27:44'),
(18, 'chart-of-accounts', 3, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(19, 'account-heads', 3, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(20, 'voucher-types', 3, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(21, 'journal-entries', 3, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(22, 'account-modules', 3, '2025-09-08 00:24:56', '2025-09-08 00:24:56'),
(23, 'generate-reference-no', 3, '2025-09-23 04:54:57', '2025-09-23 04:54:57'),
(24, 'supplier-advance', 2, '2025-09-23 04:54:57', '2025-09-23 04:54:57'),
(25, '', 2, '2025-09-23 04:54:57', '2025-09-23 04:54:57'),
(26, 'products-overview', 2, '2025-11-04 03:13:47', '2025-11-04 03:13:47'),
(27, 'purchases', 2, '2025-11-04 03:13:47', '2025-11-04 03:13:47');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'Modules\\Core\\Models\\User', 1, 'api-token', 'bed414454b1cd4cbd9a1bd4277ec9caca7a32e886a04e7bb83f644733bafa962', '[\"*\"]', '2025-12-15 04:22:50', NULL, '2025-08-24 04:08:21', '2025-12-15 04:22:50'),
(8, 'Modules\\Core\\Models\\User', 1, 'api-token', 'b26b703b289bcff2f8365062a163e4a26866450344dc6b8743237d9b02de0c4d', '[\"*\"]', '2025-08-24 07:06:42', NULL, '2025-08-24 07:05:37', '2025-08-24 07:06:42'),
(9, 'Modules\\Core\\Models\\User', 1, 'api-token', '6c142bc24b07d5c3ff049b3860d879dc3889ae466b030923730e4c96d958f00c', '[\"*\"]', '2025-08-24 07:07:04', NULL, '2025-08-24 07:07:04', '2025-08-24 07:07:04'),
(13, 'Modules\\Core\\Models\\User', 1, 'api-token', '677c9a19b21d9b1bd2483e0f4820d02dc4d1ec0dcf297ade4fb9a80fcd7dc8bf', '[\"*\"]', '2025-11-06 00:54:32', NULL, '2025-08-24 22:26:44', '2025-11-06 00:54:32'),
(14, 'Modules\\Core\\Models\\User', 1, 'api-token', 'fb1bed7e3778362e45bcfcc9f1dde0ad28cf25965db2086df0116a58be1422cb', '[\"*\"]', '2026-06-13 00:20:00', NULL, '2025-11-23 23:25:46', '2026-06-13 00:20:00'),
(15, 'Modules\\Core\\Models\\User', 1, 'api-token', '152533449addd4e9f50fd9f6334e290d6245f448bec22e51670512b4efbf31b4', '[\"*\"]', '2026-09-05 04:31:39', NULL, '2026-04-29 23:28:59', '2026-09-05 04:31:39'),
(17, 'Modules\\Core\\Models\\User', 1, 'api-token', '46cbb6dc1b1a2083da68daf91947928336d5479bdf5a1f09edcdb244373692a2', '[\"*\"]', '2026-09-05 05:05:07', NULL, '2026-08-22 22:38:26', '2026-09-05 05:05:07'),
(18, 'Modules\\Core\\Models\\User', 1, 'api-token', '4c37576022952e588cc2f72985b7e29bfe55fc405ce656db0eab05dbed3afbbf', '[\"*\"]', '2026-08-29 03:30:47', NULL, '2026-08-28 22:41:49', '2026-08-29 03:30:47'),
(19, 'Modules\\Core\\Models\\User', 1, 'api-token', '0cc46c2b27983d0431c15d03c23d8531aaea97acc975e96f17d69e4f3ba51c89', '[\"*\"]', '2026-08-29 04:46:54', NULL, '2026-08-29 03:30:58', '2026-08-29 04:46:54'),
(20, 'Modules\\Core\\Models\\User', 1, 'api-token', '4e4de530ad83fa23acadc0529ca237449fabdcb3d29b8aacf3539dd5125c0ecd', '[\"*\"]', '2026-09-05 04:16:25', NULL, '2026-09-05 01:45:29', '2026-09-05 04:16:25');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `redirect_url`, `direction`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'Administrator', NULL, NULL, 'sanctum', '2025-08-24 02:49:42', '2025-08-24 02:49:42');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(71, 1),
(72, 1),
(73, 1),
(74, 1),
(75, 1),
(76, 1),
(77, 1),
(78, 1),
(79, 1),
(80, 1),
(81, 1),
(82, 1),
(83, 1),
(84, 1),
(85, 1),
(86, 1),
(87, 1),
(88, 1),
(89, 1),
(90, 1),
(91, 1),
(92, 1),
(93, 1),
(94, 1),
(95, 1),
(96, 1),
(97, 1),
(98, 1),
(99, 1),
(100, 1),
(101, 1),
(102, 1),
(103, 1);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('1eoOqeWXndBfSYMd3MdyAHVzMwfnSWLLU8nQkM9W', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTnNJcXJoWkRTZlpJRVdCS3dmelFxMGc5Yk9ZSWZsOTF6Y1A3UTRvZyI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756900724),
('4fOjsDxjhAn8QvZPvsGr0qhy3p00r5JsL633bU1m', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiRUk0SFpMdkxjZXVDNFNDakdVOGlFQkFLTzRXUHRNR0dyeENNcHFMUCI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6OTM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9pbnZlbnRvcnkvcHJvZHVjdC9TWDNVbTVJVDV0MEVLSXRHTjJWc0p6bGhINzlibXl5bTJ2U0doaGhYLmpwZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756900912),
('aBuLAdg0mNY59KZOmwnLCdL6YfDXPRUkXIBNIOSI', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiOXQ1dDA0Z3NIMnU1bUFFVUl1N0Z6ZGxhUHNSSHQzRjBORDNvY2t5MyI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1762411530),
('D6rY8TPVqb8RNc3uIOyI3OsQ8kFILfbuODC5HHIb', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiYXFlSWhpV004alo1amJMNE02ZDlhS3l5bVB2NVNTUVcyZnBpVXNxcCI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756900607),
('LkyXAp9woP1u5UsP7eumPZB3zjnk3VA2eM0oTOyQ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNGxZajV2RDN6WHdoRHQ1dDBHYTRFMTVCaVdqQjVJQlFuWm5PckVZciI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6OTM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9pbnZlbnRvcnkvcHJvZHVjdC9TWDNVbTVJVDV0MEVLSXRHTjJWc0p6bGhINzlibXl5bTJ2U0doaGhYLmpwZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756900817),
('lQxVl9Hx2QyEPMy5jiF9eLxq6ll9aAyumMtXOXIU', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiemFKNEJ6SmZwWjg4ZkdmR3B0eW9LaE9kaVk4UWhlR214eE9iellJWCI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756900717),
('rkhDOHdQ2HQzgkBzots4BrFNbLwrcrDWI8UeuICq', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQzZLT1BCejJIWkVDdjQ3bWJsZUtRbzBWRXpjR3FOd09RN09nc0NsdSI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1788586035),
('RnyQETWi8ULbiw8TlPq6l027TAxpKR6BIdMh73in', NULL, '127.0.0.1', 'PostmanRuntime/7.56.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoib2Z3WGFubTJ3NUpnc3JLZzFyQXU0MzFvVlFpNHU1b0tObzlaTTY2byI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1785840081),
('SVlV7w6lh8fWllO2PZO8PblYbRJ8vmopMrBLt3sk', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTGpCeGZzQmJ2YjFJQllrakV2VjdkOFI4VFM4T3hVTHFKWlFwb1RwdyI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1762422569),
('UhsgJ91lGadcPLBZZBATeJEnKFM7raVjhuZFyZTJ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiYmRGRW50WUFtUnlZbWRtRnJRaUI0WFgwa1Q5cE9acjFGTlZiMnJLRyI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756900717),
('wQOjW9BB5e9wFfzPXLpYTqPriVVunOIYnQIEVZs4', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQXNCRVNJd0dxYUpvanZTWnQyQlg5M0pGa05sWkRib2wzUm9BSk1ZQyI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756900630),
('zhAVpIkDzFD6kGsZofEyt5LP7dFSqYtKgRAbfSDS', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiM3FmV3RzcFlBZjBXaU12eGZONWpYQ1h2aVpZSGtJdGFNcHV3cFFLUiI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6OTM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9pbnZlbnRvcnkvcHJvZHVjdC9TWDNVbTVJVDV0MEVLSXRHTjJWc0p6bGhINzlibXl5bTJ2U0doaGhYLmpwZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756900905);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint UNSIGNED NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `type`, `created_at`, `updated_at`) VALUES
(1, 'app_name', 'World vision Enterprice', 'text', '2025-08-24 02:49:42', '2025-08-24 06:36:33'),
(2, 'app_title', NULL, 'text', '2025-08-24 02:49:42', '2025-08-24 06:36:33'),
(3, 'app_url', NULL, 'text', '2025-08-24 02:49:42', '2025-08-24 06:36:33'),
(4, 'app_email', NULL, 'text', '2025-08-24 02:49:42', '2025-08-24 06:36:33'),
(5, 'app_address', 'HOUSE # 26, ROAD # 8, BLOCK # E, BANASREE RAMPURA DHAKA-1219, BANGLADESH', 'text', '2025-08-24 02:49:42', '2025-09-10 23:26:28'),
(6, 'app_contact', NULL, 'text', '2025-08-24 02:49:42', '2025-08-24 06:36:33'),
(7, 'app_logo', '/storage/setting/rUF8IoUSV5ymmL4Cfv9CrKyHJ8X9y8IZ2eRfjFl7.jpg', 'text', '2025-08-24 02:49:42', '2025-08-24 06:36:47'),
(8, 'icon_logo', '/storage/setting/yWrDoPxPUnaZnxgJk2KKZq6tgRgcw3PXGvvHKhbX.jpg', 'text', '2025-08-24 02:49:42', '2025-08-24 06:36:47'),
(9, 'currency_symbol', NULL, 'text', '2025-08-24 02:49:42', '2025-08-24 06:36:33'),
(10, 'symbol_position', NULL, 'text', '2025-08-24 02:49:42', '2025-08-24 06:36:33');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@gmail.com', NULL, '$2y$12$1P1zB7PN5nuRGGPhQ6e3OeqO2njJb615o/WgINW8EKZ6QEs13ff3G', NULL, '2025-08-24 02:49:42', '2025-08-24 02:49:42');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `acc_account_balances`
--
ALTER TABLE `acc_account_balances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `acc_account_balances_account_head_id_foreign` (`account_head_id`),
  ADD KEY `acc_account_balances_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `acc_account_heads`
--
ALTER TABLE `acc_account_heads`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `acc_account_heads_code_unique` (`code`),
  ADD KEY `acc_account_heads_branch_id_foreign` (`branch_id`),
  ADD KEY `is_transaction` (`is_transaction`);

--
-- Indexes for table `acc_account_settings`
--
ALTER TABLE `acc_account_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `acc_account_settings_key_unique` (`key`),
  ADD KEY `acc_account_settings_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `acc_account_users`
--
ALTER TABLE `acc_account_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `acc_account_users_user_id_foreign` (`user_id`),
  ADD KEY `acc_account_users_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `acc_audit_logs`
--
ALTER TABLE `acc_audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `acc_audit_logs_user_id_foreign` (`user_id`);

--
-- Indexes for table `acc_journal_entries`
--
ALTER TABLE `acc_journal_entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `acc_journal_entries_branch_id_foreign` (`branch_id`),
  ADD KEY `entry_date` (`date`),
  ADD KEY `voucher_type` (`voucher_type`),
  ADD KEY `source_type` (`source_type`);

--
-- Indexes for table `acc_journal_entry_details`
--
ALTER TABLE `acc_journal_entry_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `acc_journal_entry_details_journal_entry_id_foreign` (`journal_entry_id`),
  ADD KEY `acc_journal_entry_details_account_category_id_foreign` (`account_category_id`),
  ADD KEY `acc_journal_entry_details_control_group_id_foreign` (`control_group_id`),
  ADD KEY `acc_journal_entry_details_ledger_group_id_foreign` (`ledger_group_id`),
  ADD KEY `acc_journal_entry_details_ledger_account_id_foreign` (`ledger_account_id`),
  ADD KEY `acc_journal_entry_details_account_hierarchy_index` (`account_type_id`,`account_category_id`,`control_group_id`,`ledger_group_id`,`ledger_account_id`);

--
-- Indexes for table `acc_module_entries`
--
ALTER TABLE `acc_module_entries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `feature_key` (`feature_key`);

--
-- Indexes for table `acc_module_entry_accounts`
--
ALTER TABLE `acc_module_entry_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `acc_module_entry_accounts_module_entry_id_foreign` (`module_entry_id`),
  ADD KEY `acc_module_entry_accounts_account_head_id_foreign` (`account_head_id`);

--
-- Indexes for table `acc_voucher_types`
--
ALTER TABLE `acc_voucher_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `acc_voucher_types_code_unique` (`code`);

--
-- Indexes for table `admin_menus`
--
ALTER TABLE `admin_menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_menus_parent_id_foreign` (`parent_id`),
  ADD KEY `admin_menus_module_id_foreign` (`module_id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `hrm_blood_groups`
--
ALTER TABLE `hrm_blood_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hrm_blood_groups_branch_id_foreign` (`branch_id`),
  ADD KEY `hrm_blood_groups_created_by_foreign` (`created_by`),
  ADD KEY `hrm_blood_groups_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `hrm_departments`
--
ALTER TABLE `hrm_departments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hrm_departments_branch_id_foreign` (`branch_id`),
  ADD KEY `hrm_departments_created_by_foreign` (`created_by`),
  ADD KEY `hrm_departments_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `hrm_designations`
--
ALTER TABLE `hrm_designations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hrm_designations_branch_id_foreign` (`branch_id`),
  ADD KEY `hrm_designations_created_by_foreign` (`created_by`),
  ADD KEY `hrm_designations_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `hrm_employees`
--
ALTER TABLE `hrm_employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `hrm_employees_employee_id_unique` (`employee_id`),
  ADD UNIQUE KEY `hrm_employees_email_unique` (`email`),
  ADD UNIQUE KEY `hrm_employees_phone_unique` (`phone`),
  ADD UNIQUE KEY `hrm_employees_national_id_unique` (`national_id`),
  ADD UNIQUE KEY `hrm_employees_passport_number_unique` (`passport_number`),
  ADD KEY `hrm_employees_department_id_foreign` (`department_id`),
  ADD KEY `hrm_employees_designation_id_foreign` (`designation_id`),
  ADD KEY `hrm_employees_branch_id_foreign` (`branch_id`),
  ADD KEY `hrm_employees_gender_id_foreign` (`gender_id`),
  ADD KEY `hrm_employees_religion_id_foreign` (`religion_id`),
  ADD KEY `hrm_employees_shift_id_foreign` (`shift_id`),
  ADD KEY `hrm_employees_employee_category_id_foreign` (`employee_category_id`),
  ADD KEY `hrm_employees_employee_type_id_foreign` (`employee_type_id`),
  ADD KEY `hrm_employees_employee_status_id_foreign` (`employee_status_id`),
  ADD KEY `hrm_employees_blood_group_id_foreign` (`blood_group_id`),
  ADD KEY `hrm_employees_created_by_foreign` (`created_by`),
  ADD KEY `hrm_employees_updated_by_foreign` (`updated_by`),
  ADD KEY `hrm_employees_employee_id_index` (`employee_id`),
  ADD KEY `hrm_employees_first_name_last_name_index` (`first_name`,`last_name`),
  ADD KEY `hrm_employees_email_phone_index` (`email`,`phone`);

--
-- Indexes for table `hrm_employee_categories`
--
ALTER TABLE `hrm_employee_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hrm_employee_categories_branch_id_foreign` (`branch_id`),
  ADD KEY `hrm_employee_categories_created_by_foreign` (`created_by`),
  ADD KEY `hrm_employee_categories_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `hrm_employee_statuses`
--
ALTER TABLE `hrm_employee_statuses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hrm_employee_statuses_branch_id_foreign` (`branch_id`),
  ADD KEY `hrm_employee_statuses_created_by_foreign` (`created_by`),
  ADD KEY `hrm_employee_statuses_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `hrm_employee_types`
--
ALTER TABLE `hrm_employee_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hrm_employee_types_branch_id_foreign` (`branch_id`),
  ADD KEY `hrm_employee_types_created_by_foreign` (`created_by`),
  ADD KEY `hrm_employee_types_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `hrm_genders`
--
ALTER TABLE `hrm_genders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hrm_genders_branch_id_foreign` (`branch_id`),
  ADD KEY `hrm_genders_created_by_foreign` (`created_by`),
  ADD KEY `hrm_genders_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `hrm_leaves`
--
ALTER TABLE `hrm_leaves`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hrm_leave_categories`
--
ALTER TABLE `hrm_leave_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hrm_leave_categories_branch_id_foreign` (`branch_id`),
  ADD KEY `hrm_leave_categories_created_by_foreign` (`created_by`),
  ADD KEY `hrm_leave_categories_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `hrm_leave_details`
--
ALTER TABLE `hrm_leave_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hrm_religions`
--
ALTER TABLE `hrm_religions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hrm_religions_branch_id_foreign` (`branch_id`),
  ADD KEY `hrm_religions_created_by_foreign` (`created_by`),
  ADD KEY `hrm_religions_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `hrm_shifts`
--
ALTER TABLE `hrm_shifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hrm_shifts_branch_id_foreign` (`branch_id`),
  ADD KEY `hrm_shifts_created_by_foreign` (`created_by`),
  ADD KEY `hrm_shifts_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `inv_brands`
--
ALTER TABLE `inv_brands`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_brands_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `inv_categories`
--
ALTER TABLE `inv_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_categories_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `inv_customers`
--
ALTER TABLE `inv_customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_customers_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `inv_customer_advances`
--
ALTER TABLE `inv_customer_advances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_customer_advances_customer_id_foreign` (`customer_id`),
  ADD KEY `inv_customer_advances_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `inv_customer_ledgers`
--
ALTER TABLE `inv_customer_ledgers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_customer_ledgers_customer_id_foreign` (`customer_id`),
  ADD KEY `inv_customer_ledgers_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `inv_customer_payments`
--
ALTER TABLE `inv_customer_payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `inv_customer_payments_invoice_no_unique` (`invoice_no`),
  ADD KEY `inv_customer_payments_customer_id_foreign` (`customer_id`),
  ADD KEY `inv_customer_payments_branch_id_foreign` (`branch_id`),
  ADD KEY `inv_customer_payments_created_by_foreign` (`created_by`);

--
-- Indexes for table `inv_payments`
--
ALTER TABLE `inv_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_payments_branch_id_foreign` (`branch_id`),
  ADD KEY `inv_payments_created_by_foreign` (`created_by`),
  ADD KEY `inv_payments_reference_type_reference_id_index` (`reference_type`,`reference_id`);

--
-- Indexes for table `inv_price_lists`
--
ALTER TABLE `inv_price_lists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_price_lists_branch_id_foreign` (`branch_id`),
  ADD KEY `unique_price_list` (`product_id`,`branch_id`,`price_type`) USING BTREE;

--
-- Indexes for table `inv_products`
--
ALTER TABLE `inv_products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `inv_products_sku_unique` (`sku`),
  ADD KEY `inv_products_category_id_foreign` (`category_id`),
  ADD KEY `inv_products_unit_id_foreign` (`unit_id`),
  ADD KEY `inv_products_brand_id_foreign` (`brand_id`),
  ADD KEY `inv_products_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `inv_product_sets`
--
ALTER TABLE `inv_product_sets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_product_sets_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `inv_product_set_items`
--
ALTER TABLE `inv_product_set_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_product_set_items_product_set_id_foreign` (`product_set_id`),
  ADD KEY `inv_product_set_items_product_id_foreign` (`product_id`),
  ADD KEY `inv_product_set_items_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `inv_product_wastages`
--
ALTER TABLE `inv_product_wastages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `inv_product_wastages_wastage_no_unique` (`wastage_no`),
  ADD KEY `inv_product_wastages_branch_id_foreign` (`branch_id`),
  ADD KEY `inv_product_wastages_created_by_foreign` (`created_by`);

--
-- Indexes for table `inv_product_wastage_items`
--
ALTER TABLE `inv_product_wastage_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_product_wastage_items_product_wastage_id_foreign` (`product_wastage_id`),
  ADD KEY `inv_product_wastage_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `inv_purchases`
--
ALTER TABLE `inv_purchases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `inv_purchases_invoice_no_unique` (`invoice_no`),
  ADD KEY `inv_purchases_supplier_id_foreign` (`supplier_id`),
  ADD KEY `inv_purchases_branch_id_foreign` (`branch_id`),
  ADD KEY `inv_purchases_created_by_foreign` (`created_by`),
  ADD KEY `inv_purchases_invoice_date_index` (`invoice_date`);

--
-- Indexes for table `inv_purchase_items`
--
ALTER TABLE `inv_purchase_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_purchase_items_purchase_id_foreign` (`purchase_id`),
  ADD KEY `inv_purchase_items_product_id_foreign` (`product_id`),
  ADD KEY `inv_purchase_items_branch_id_foreign` (`branch_id`),
  ADD KEY `inv_purchase_items_invoice_date_index` (`invoice_date`);

--
-- Indexes for table `inv_purchase_returns`
--
ALTER TABLE `inv_purchase_returns`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `inv_purchase_returns_invoice_no_unique` (`invoice_no`),
  ADD KEY `inv_purchase_returns_purchase_id_foreign` (`purchase_id`),
  ADD KEY `inv_purchase_returns_supplier_id_foreign` (`supplier_id`),
  ADD KEY `inv_purchase_returns_branch_id_foreign` (`branch_id`),
  ADD KEY `inv_purchase_returns_created_by_foreign` (`created_by`);

--
-- Indexes for table `inv_purchase_return_items`
--
ALTER TABLE `inv_purchase_return_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_purchase_return_items_purchase_return_id_foreign` (`purchase_return_id`),
  ADD KEY `inv_purchase_return_items_purchase_item_id_foreign` (`purchase_item_id`),
  ADD KEY `inv_purchase_return_items_product_id_foreign` (`product_id`),
  ADD KEY `inv_purchase_return_items_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `inv_sales`
--
ALTER TABLE `inv_sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `inv_sales_invoice_no_unique` (`invoice_no`),
  ADD KEY `inv_sales_customer_id_foreign` (`customer_id`),
  ADD KEY `inv_sales_branch_id_foreign` (`branch_id`),
  ADD KEY `inv_sales_created_by_foreign` (`created_by`),
  ADD KEY `invoice_date` (`invoice_date`);

--
-- Indexes for table `inv_sale_items`
--
ALTER TABLE `inv_sale_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_sale_items_sale_id_foreign` (`sale_id`),
  ADD KEY `inv_sale_items_product_id_foreign` (`product_id`),
  ADD KEY `inv_sale_items_branch_id_foreign` (`branch_id`),
  ADD KEY `inv_sale_items_invoice_date_index` (`invoice_date`);

--
-- Indexes for table `inv_sale_returns`
--
ALTER TABLE `inv_sale_returns`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `inv_sale_returns_return_no_unique` (`invoice_no`),
  ADD KEY `inv_sale_returns_sale_id_foreign` (`sale_id`),
  ADD KEY `inv_sale_returns_customer_id_foreign` (`customer_id`),
  ADD KEY `inv_sale_returns_branch_id_foreign` (`branch_id`),
  ADD KEY `inv_sale_returns_created_by_foreign` (`created_by`);

--
-- Indexes for table `inv_sale_return_items`
--
ALTER TABLE `inv_sale_return_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_sale_return_items_sale_return_id_foreign` (`sale_return_id`),
  ADD KEY `inv_sale_return_items_sale_item_id_foreign` (`sale_item_id`),
  ADD KEY `inv_sale_return_items_product_id_foreign` (`product_id`),
  ADD KEY `inv_sale_return_items_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `inv_stock_balances`
--
ALTER TABLE `inv_stock_balances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `inv_stock_balances_product_id_branch_id_unique` (`product_id`,`branch_id`),
  ADD KEY `inv_stock_balances_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `inv_stock_movements`
--
ALTER TABLE `inv_stock_movements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `branch_id` (`branch_id`,`created_at`),
  ADD KEY `product_id` (`product_id`,`branch_id`,`created_at`),
  ADD KEY `movement_type` (`movement_type`);

--
-- Indexes for table `inv_stock_transfers`
--
ALTER TABLE `inv_stock_transfers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `inv_stock_transfers_transfer_no_unique` (`transfer_no`),
  ADD KEY `inv_stock_transfers_from_branch_id_foreign` (`from_branch_id`),
  ADD KEY `inv_stock_transfers_to_branch_id_foreign` (`to_branch_id`);

--
-- Indexes for table `inv_stock_transfer_items`
--
ALTER TABLE `inv_stock_transfer_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_transfer_items_stock_transfer_id_foreign` (`stock_transfer_id`),
  ADD KEY `stock_transfer_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `inv_suppliers`
--
ALTER TABLE `inv_suppliers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_suppliers_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `inv_supplier_advances`
--
ALTER TABLE `inv_supplier_advances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_supplier_advances_supplier_id_foreign` (`supplier_id`),
  ADD KEY `inv_supplier_advances_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `inv_supplier_ledgers`
--
ALTER TABLE `inv_supplier_ledgers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_supplier_ledgers_supplier_id_foreign` (`supplier_id`),
  ADD KEY `inv_supplier_ledgers_branch_id_foreign` (`branch_id`),
  ADD KEY `date` (`date`);

--
-- Indexes for table `inv_supplier_payments`
--
ALTER TABLE `inv_supplier_payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `inv_supplier_payments_invoice_no_unique` (`invoice_no`),
  ADD KEY `inv_supplier_payments_supplier_id_foreign` (`supplier_id`),
  ADD KEY `inv_supplier_payments_branch_id_foreign` (`branch_id`),
  ADD KEY `inv_supplier_payments_created_by_foreign` (`created_by`);

--
-- Indexes for table `inv_units`
--
ALTER TABLE `inv_units`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_units_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `inv_user_logs`
--
ALTER TABLE `inv_user_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_user_logs_user_id_foreign` (`user_id`),
  ADD KEY `inv_user_logs_branch_id_foreign` (`branch_id`),
  ADD KEY `inv_user_logs_module_reference_id_action_index` (`module`,`reference_id`,`action`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `modules`
--
ALTER TABLE `modules`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `modules_slug_unique` (`slug`);

--
-- Indexes for table `module_sections`
--
ALTER TABLE `module_sections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `module_sections_module_id_foreign` (`module_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`),
  ADD KEY `permissions_group_id_foreign` (`group_id`);

--
-- Indexes for table `permission_groups`
--
ALTER TABLE `permission_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permission_groups_module_id_foreign` (`module_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `acc_account_balances`
--
ALTER TABLE `acc_account_balances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `acc_account_heads`
--
ALTER TABLE `acc_account_heads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `acc_account_settings`
--
ALTER TABLE `acc_account_settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `acc_account_users`
--
ALTER TABLE `acc_account_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `acc_audit_logs`
--
ALTER TABLE `acc_audit_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT for table `acc_journal_entries`
--
ALTER TABLE `acc_journal_entries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `acc_journal_entry_details`
--
ALTER TABLE `acc_journal_entry_details`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `acc_module_entries`
--
ALTER TABLE `acc_module_entries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `acc_module_entry_accounts`
--
ALTER TABLE `acc_module_entry_accounts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `acc_voucher_types`
--
ALTER TABLE `acc_voucher_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `admin_menus`
--
ALTER TABLE `admin_menus`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hrm_blood_groups`
--
ALTER TABLE `hrm_blood_groups`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `hrm_departments`
--
ALTER TABLE `hrm_departments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `hrm_designations`
--
ALTER TABLE `hrm_designations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `hrm_employees`
--
ALTER TABLE `hrm_employees`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `hrm_employee_categories`
--
ALTER TABLE `hrm_employee_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `hrm_employee_statuses`
--
ALTER TABLE `hrm_employee_statuses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `hrm_employee_types`
--
ALTER TABLE `hrm_employee_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `hrm_genders`
--
ALTER TABLE `hrm_genders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `hrm_leaves`
--
ALTER TABLE `hrm_leaves`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `hrm_leave_categories`
--
ALTER TABLE `hrm_leave_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `hrm_leave_details`
--
ALTER TABLE `hrm_leave_details`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `hrm_religions`
--
ALTER TABLE `hrm_religions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `hrm_shifts`
--
ALTER TABLE `hrm_shifts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `inv_brands`
--
ALTER TABLE `inv_brands`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `inv_categories`
--
ALTER TABLE `inv_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `inv_customers`
--
ALTER TABLE `inv_customers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `inv_customer_advances`
--
ALTER TABLE `inv_customer_advances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `inv_customer_ledgers`
--
ALTER TABLE `inv_customer_ledgers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=315;

--
-- AUTO_INCREMENT for table `inv_customer_payments`
--
ALTER TABLE `inv_customer_payments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `inv_payments`
--
ALTER TABLE `inv_payments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inv_price_lists`
--
ALTER TABLE `inv_price_lists`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `inv_products`
--
ALTER TABLE `inv_products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `inv_product_sets`
--
ALTER TABLE `inv_product_sets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `inv_product_set_items`
--
ALTER TABLE `inv_product_set_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `inv_product_wastages`
--
ALTER TABLE `inv_product_wastages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `inv_product_wastage_items`
--
ALTER TABLE `inv_product_wastage_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `inv_purchases`
--
ALTER TABLE `inv_purchases`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;

--
-- AUTO_INCREMENT for table `inv_purchase_items`
--
ALTER TABLE `inv_purchase_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;

--
-- AUTO_INCREMENT for table `inv_purchase_returns`
--
ALTER TABLE `inv_purchase_returns`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `inv_purchase_return_items`
--
ALTER TABLE `inv_purchase_return_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `inv_sales`
--
ALTER TABLE `inv_sales`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `inv_sale_items`
--
ALTER TABLE `inv_sale_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=180;

--
-- AUTO_INCREMENT for table `inv_sale_returns`
--
ALTER TABLE `inv_sale_returns`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

--
-- AUTO_INCREMENT for table `inv_sale_return_items`
--
ALTER TABLE `inv_sale_return_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=159;

--
-- AUTO_INCREMENT for table `inv_stock_balances`
--
ALTER TABLE `inv_stock_balances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `inv_stock_movements`
--
ALTER TABLE `inv_stock_movements`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=501;

--
-- AUTO_INCREMENT for table `inv_stock_transfers`
--
ALTER TABLE `inv_stock_transfers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `inv_stock_transfer_items`
--
ALTER TABLE `inv_stock_transfer_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `inv_suppliers`
--
ALTER TABLE `inv_suppliers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `inv_supplier_advances`
--
ALTER TABLE `inv_supplier_advances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `inv_supplier_ledgers`
--
ALTER TABLE `inv_supplier_ledgers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=184;

--
-- AUTO_INCREMENT for table `inv_supplier_payments`
--
ALTER TABLE `inv_supplier_payments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `inv_units`
--
ALTER TABLE `inv_units`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `inv_user_logs`
--
ALTER TABLE `inv_user_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `modules`
--
ALTER TABLE `modules`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `module_sections`
--
ALTER TABLE `module_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `permission_groups`
--
ALTER TABLE `permission_groups`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `acc_account_balances`
--
ALTER TABLE `acc_account_balances`
  ADD CONSTRAINT `acc_account_balances_account_head_id_foreign` FOREIGN KEY (`account_head_id`) REFERENCES `acc_account_heads` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `acc_account_balances_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `acc_account_heads`
--
ALTER TABLE `acc_account_heads`
  ADD CONSTRAINT `acc_account_heads_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `acc_account_settings`
--
ALTER TABLE `acc_account_settings`
  ADD CONSTRAINT `acc_account_settings_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `acc_account_users`
--
ALTER TABLE `acc_account_users`
  ADD CONSTRAINT `acc_account_users_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `acc_account_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `acc_audit_logs`
--
ALTER TABLE `acc_audit_logs`
  ADD CONSTRAINT `acc_audit_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `acc_journal_entries`
--
ALTER TABLE `acc_journal_entries`
  ADD CONSTRAINT `acc_journal_entries_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `acc_journal_entry_details`
--
ALTER TABLE `acc_journal_entry_details`
  ADD CONSTRAINT `acc_journal_entry_details_account_category_id_foreign` FOREIGN KEY (`account_category_id`) REFERENCES `acc_account_heads` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `acc_journal_entry_details_account_type_id_foreign` FOREIGN KEY (`account_type_id`) REFERENCES `acc_account_heads` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `acc_journal_entry_details_control_group_id_foreign` FOREIGN KEY (`control_group_id`) REFERENCES `acc_account_heads` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `acc_journal_entry_details_journal_entry_id_foreign` FOREIGN KEY (`journal_entry_id`) REFERENCES `acc_journal_entries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `acc_journal_entry_details_ledger_account_id_foreign` FOREIGN KEY (`ledger_account_id`) REFERENCES `acc_account_heads` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `acc_journal_entry_details_ledger_group_id_foreign` FOREIGN KEY (`ledger_group_id`) REFERENCES `acc_account_heads` (`id`) ON DELETE RESTRICT;

--
-- Constraints for table `acc_module_entry_accounts`
--
ALTER TABLE `acc_module_entry_accounts`
  ADD CONSTRAINT `acc_module_entry_accounts_account_head_id_foreign` FOREIGN KEY (`account_head_id`) REFERENCES `acc_account_heads` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `acc_module_entry_accounts_module_entry_id_foreign` FOREIGN KEY (`module_entry_id`) REFERENCES `acc_module_entries` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `admin_menus`
--
ALTER TABLE `admin_menus`
  ADD CONSTRAINT `admin_menus_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `admin_menus_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `admin_menus` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `hrm_blood_groups`
--
ALTER TABLE `hrm_blood_groups`
  ADD CONSTRAINT `hrm_blood_groups_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hrm_blood_groups_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_blood_groups_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `hrm_departments`
--
ALTER TABLE `hrm_departments`
  ADD CONSTRAINT `hrm_departments_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hrm_departments_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_departments_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `hrm_designations`
--
ALTER TABLE `hrm_designations`
  ADD CONSTRAINT `hrm_designations_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hrm_designations_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_designations_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `hrm_employees`
--
ALTER TABLE `hrm_employees`
  ADD CONSTRAINT `hrm_employees_blood_group_id_foreign` FOREIGN KEY (`blood_group_id`) REFERENCES `hrm_blood_groups` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_employees_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_employees_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_employees_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `hrm_departments` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_employees_designation_id_foreign` FOREIGN KEY (`designation_id`) REFERENCES `hrm_designations` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_employees_employee_category_id_foreign` FOREIGN KEY (`employee_category_id`) REFERENCES `hrm_employee_categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_employees_employee_status_id_foreign` FOREIGN KEY (`employee_status_id`) REFERENCES `hrm_employee_statuses` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_employees_employee_type_id_foreign` FOREIGN KEY (`employee_type_id`) REFERENCES `hrm_employee_types` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_employees_gender_id_foreign` FOREIGN KEY (`gender_id`) REFERENCES `hrm_genders` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_employees_religion_id_foreign` FOREIGN KEY (`religion_id`) REFERENCES `hrm_religions` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_employees_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `hrm_shifts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_employees_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `hrm_employee_categories`
--
ALTER TABLE `hrm_employee_categories`
  ADD CONSTRAINT `hrm_employee_categories_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hrm_employee_categories_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_employee_categories_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `hrm_employee_statuses`
--
ALTER TABLE `hrm_employee_statuses`
  ADD CONSTRAINT `hrm_employee_statuses_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hrm_employee_statuses_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_employee_statuses_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `hrm_employee_types`
--
ALTER TABLE `hrm_employee_types`
  ADD CONSTRAINT `hrm_employee_types_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hrm_employee_types_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_employee_types_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `hrm_genders`
--
ALTER TABLE `hrm_genders`
  ADD CONSTRAINT `hrm_genders_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hrm_genders_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_genders_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `hrm_leave_categories`
--
ALTER TABLE `hrm_leave_categories`
  ADD CONSTRAINT `hrm_leave_categories_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hrm_leave_categories_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_leave_categories_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `hrm_religions`
--
ALTER TABLE `hrm_religions`
  ADD CONSTRAINT `hrm_religions_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hrm_religions_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_religions_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `hrm_shifts`
--
ALTER TABLE `hrm_shifts`
  ADD CONSTRAINT `hrm_shifts_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hrm_shifts_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hrm_shifts_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `inv_brands`
--
ALTER TABLE `inv_brands`
  ADD CONSTRAINT `inv_brands_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_categories`
--
ALTER TABLE `inv_categories`
  ADD CONSTRAINT `inv_categories_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_customers`
--
ALTER TABLE `inv_customers`
  ADD CONSTRAINT `inv_customers_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_customer_advances`
--
ALTER TABLE `inv_customer_advances`
  ADD CONSTRAINT `inv_customer_advances_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_customer_advances_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `inv_customers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_customer_ledgers`
--
ALTER TABLE `inv_customer_ledgers`
  ADD CONSTRAINT `inv_customer_ledgers_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_customer_ledgers_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `inv_customers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_customer_payments`
--
ALTER TABLE `inv_customer_payments`
  ADD CONSTRAINT `inv_customer_payments_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_customer_payments_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `inv_customer_payments_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `inv_customers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_payments`
--
ALTER TABLE `inv_payments`
  ADD CONSTRAINT `inv_payments_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_payments_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `inv_price_lists`
--
ALTER TABLE `inv_price_lists`
  ADD CONSTRAINT `inv_price_lists_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_price_lists_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `inv_products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_products`
--
ALTER TABLE `inv_products`
  ADD CONSTRAINT `inv_products_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `inv_brands` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `inv_products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `inv_categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `inv_products_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `inv_units` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `inv_product_sets`
--
ALTER TABLE `inv_product_sets`
  ADD CONSTRAINT `inv_product_sets_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_product_set_items`
--
ALTER TABLE `inv_product_set_items`
  ADD CONSTRAINT `inv_product_set_items_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_product_set_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `inv_products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_product_set_items_product_set_id_foreign` FOREIGN KEY (`product_set_id`) REFERENCES `inv_product_sets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_product_wastages`
--
ALTER TABLE `inv_product_wastages`
  ADD CONSTRAINT `inv_product_wastages_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_product_wastages_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `inv_product_wastage_items`
--
ALTER TABLE `inv_product_wastage_items`
  ADD CONSTRAINT `inv_product_wastage_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `inv_products` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `inv_product_wastage_items_product_wastage_id_foreign` FOREIGN KEY (`product_wastage_id`) REFERENCES `inv_product_wastages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_purchases`
--
ALTER TABLE `inv_purchases`
  ADD CONSTRAINT `inv_purchases_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_purchases_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `inv_purchases_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `inv_suppliers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_purchase_items`
--
ALTER TABLE `inv_purchase_items`
  ADD CONSTRAINT `inv_purchase_items_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_purchase_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `inv_products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_purchase_items_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `inv_purchases` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_purchase_returns`
--
ALTER TABLE `inv_purchase_returns`
  ADD CONSTRAINT `inv_purchase_returns_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_purchase_returns_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `inv_purchase_returns_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `inv_purchases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_purchase_returns_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `inv_suppliers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_purchase_return_items`
--
ALTER TABLE `inv_purchase_return_items`
  ADD CONSTRAINT `inv_purchase_return_items_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_purchase_return_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `inv_products` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `inv_purchase_return_items_purchase_item_id_foreign` FOREIGN KEY (`purchase_item_id`) REFERENCES `inv_purchase_items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_purchase_return_items_purchase_return_id_foreign` FOREIGN KEY (`purchase_return_id`) REFERENCES `inv_purchase_returns` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_sales`
--
ALTER TABLE `inv_sales`
  ADD CONSTRAINT `inv_sales_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_sales_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `inv_sales_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `inv_customers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_sale_items`
--
ALTER TABLE `inv_sale_items`
  ADD CONSTRAINT `inv_sale_items_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_sale_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `inv_products` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `inv_sale_items_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `inv_sales` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_sale_returns`
--
ALTER TABLE `inv_sale_returns`
  ADD CONSTRAINT `inv_sale_returns_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_sale_returns_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `inv_sale_returns_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `inv_customers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_sale_returns_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `inv_sales` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_sale_return_items`
--
ALTER TABLE `inv_sale_return_items`
  ADD CONSTRAINT `inv_sale_return_items_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_sale_return_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `inv_products` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `inv_sale_return_items_sale_item_id_foreign` FOREIGN KEY (`sale_item_id`) REFERENCES `inv_sale_items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_sale_return_items_sale_return_id_foreign` FOREIGN KEY (`sale_return_id`) REFERENCES `inv_sale_returns` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_stock_balances`
--
ALTER TABLE `inv_stock_balances`
  ADD CONSTRAINT `inv_stock_balances_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_stock_balances_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `inv_products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_stock_movements`
--
ALTER TABLE `inv_stock_movements`
  ADD CONSTRAINT `inv_stock_movements_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_stock_movements_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `inv_products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_stock_transfers`
--
ALTER TABLE `inv_stock_transfers`
  ADD CONSTRAINT `inv_stock_transfers_from_branch_id_foreign` FOREIGN KEY (`from_branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_stock_transfers_to_branch_id_foreign` FOREIGN KEY (`to_branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_stock_transfer_items`
--
ALTER TABLE `inv_stock_transfer_items`
  ADD CONSTRAINT `stock_transfer_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `inv_products` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `stock_transfer_items_stock_transfer_id_foreign` FOREIGN KEY (`stock_transfer_id`) REFERENCES `inv_stock_transfers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_suppliers`
--
ALTER TABLE `inv_suppliers`
  ADD CONSTRAINT `inv_suppliers_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_supplier_advances`
--
ALTER TABLE `inv_supplier_advances`
  ADD CONSTRAINT `inv_supplier_advances_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_supplier_advances_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `inv_suppliers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_supplier_ledgers`
--
ALTER TABLE `inv_supplier_ledgers`
  ADD CONSTRAINT `inv_supplier_ledgers_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_supplier_ledgers_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `inv_suppliers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_supplier_payments`
--
ALTER TABLE `inv_supplier_payments`
  ADD CONSTRAINT `inv_supplier_payments_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inv_supplier_payments_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `inv_supplier_payments_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `inv_suppliers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_units`
--
ALTER TABLE `inv_units`
  ADD CONSTRAINT `inv_units_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inv_user_logs`
--
ALTER TABLE `inv_user_logs`
  ADD CONSTRAINT `inv_user_logs_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `inv_user_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `module_sections`
--
ALTER TABLE `module_sections`
  ADD CONSTRAINT `module_sections_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `permissions`
--
ALTER TABLE `permissions`
  ADD CONSTRAINT `permissions_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `permission_groups` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `permission_groups`
--
ALTER TABLE `permission_groups`
  ADD CONSTRAINT `permission_groups_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

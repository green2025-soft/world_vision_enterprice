-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 04, 2025 at 04:31 AM
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
(20, 6, 50000.00, 0.00, 50000.00, '2025-09-22', NULL, '2025-09-23 01:44:13', '2025-09-23 01:44:13'),
(21, 9, 0.00, 50000.00, 50000.00, '2025-09-22', NULL, '2025-09-23 01:44:13', '2025-09-23 01:44:13'),
(22, 6, 0.00, 6000.00, 44000.00, '2025-09-23', 1, '2025-09-23 01:50:50', '2025-09-23 04:47:00'),
(26, 20, 6000.00, 0.00, 6000.00, '2025-09-23', 1, '2025-09-23 01:52:16', '2025-09-23 04:47:00'),
(33, 41, 1500.00, 0.00, -1500.00, '2025-09-23', 1, '2025-09-23 02:51:15', '2025-09-23 02:51:15'),
(34, 8, 0.00, 1500.00, 1500.00, '2025-09-23', 1, '2025-09-23 02:51:15', '2025-09-23 02:51:15'),
(45, 38, 12600.00, 0.00, 12600.00, '2025-10-12', 1, '2025-10-11 23:07:28', '2025-11-04 06:39:03'),
(46, 40, 1330.00, 0.00, 1330.00, '2025-10-12', 1, '2025-10-11 23:07:28', '2025-11-04 06:39:03'),
(47, 39, 700.00, 0.00, -700.00, '2025-10-12', 1, '2025-10-11 23:07:28', '2025-11-04 06:39:03'),
(48, 6, 0.00, 1000.00, 43000.00, '2025-10-12', 1, '2025-10-11 23:07:28', '2025-11-04 06:39:03'),
(49, 8, 0.00, 13630.00, 15130.00, '2025-10-12', 1, '2025-10-11 23:07:28', '2025-11-04 06:39:03'),
(50, 38, 2200.00, 0.00, 14800.00, '2025-11-04', 1, '2025-11-04 01:29:28', '2025-11-04 06:39:03'),
(51, 6, 0.00, 1430.00, 41570.00, '2025-11-04', 1, '2025-11-04 01:29:28', '2025-11-04 06:39:03'),
(52, 8, 0.00, 526.05, 15656.05, '2025-11-04', 1, '2025-11-04 01:29:28', '2025-11-04 06:39:03'),
(53, 40, 48.05, 0.00, 1378.05, '2025-11-04', 1, '2025-11-04 05:20:56', '2025-11-04 06:39:03'),
(54, 39, 0.00, 122.00, -578.00, '2025-11-04', 1, '2025-11-04 05:20:56', '2025-11-04 06:39:03'),
(55, 20, 0.00, 170.00, 5830.00, '2025-11-04', 1, '2025-11-04 06:35:47', '2025-11-04 06:35:47'),
(56, 38, 32250.00, 0.00, 47050.00, '2025-11-05', 1, '2025-11-04 22:54:00', '2025-11-23 23:59:29'),
(57, 40, 413.34, 0.00, 1791.39, '2025-11-05', 1, '2025-11-04 22:54:00', '2025-11-05 03:25:03'),
(58, 39, 0.00, 1132.20, 554.20, '2025-11-05', 1, '2025-11-04 22:54:00', '2025-11-05 03:25:03'),
(59, 6, 0.00, 27000.00, 14570.00, '2025-11-05', 1, '2025-11-04 22:54:00', '2025-11-05 03:25:03'),
(60, 8, 0.00, 4531.14, 20187.19, '2025-11-05', 1, '2025-11-04 22:54:00', '2025-11-05 03:25:03'),
(61, 20, 0.00, 0.00, 5830.00, '2025-11-05', 1, '2025-11-05 03:44:03', '2025-11-23 23:59:29'),
(62, 38, 1250.00, 0.00, 48300.00, '2025-11-24', 1, '2025-11-23 23:59:29', '2025-11-23 23:59:29'),
(63, 20, 0.00, 1250.00, 4580.00, '2025-11-24', 1, '2025-11-23 23:59:29', '2025-11-23 23:59:29'),
(64, 6, 5000.00, 0.00, 19570.00, '2025-11-24', 1, '2025-11-24 01:37:30', '2025-11-24 01:38:53'),
(66, 36, 0.00, 5000.00, 5000.00, '2025-11-24', 1, '2025-11-24 01:38:53', '2025-11-24 01:38:53'),
(67, 42, 250.00, 0.00, 250.00, '2025-11-24', 1, '2025-11-24 03:03:33', '2025-11-24 03:03:33'),
(68, 41, 0.00, 250.00, -1250.00, '2025-11-24', 1, '2025-11-24 03:03:33', '2025-11-24 03:03:33');

-- --------------------------------------------------------

--
-- Table structure for table `acc_account_heads`
--

CREATE TABLE `acc_account_heads` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `type` enum('asset','liability','income','expense','equity') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_debit` tinyint(1) NOT NULL DEFAULT '1',
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `acc_account_heads`
--

INSERT INTO `acc_account_heads` (`id`, `name`, `code`, `parent_id`, `type`, `is_debit`, `remarks`, `branch_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Assets', '10000', NULL, 'asset', 1, 'System generated parent account', NULL, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(2, 'Liabilities', '20000', NULL, 'liability', 0, 'System generated parent account', NULL, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(3, 'Equity', '30000', NULL, 'equity', 0, 'System generated parent account', NULL, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(4, 'Income', '40000', NULL, 'income', 0, 'System generated parent account', NULL, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(5, 'Expenses', '50000', NULL, 'expense', 1, 'System generated parent account', NULL, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(6, 'Cash in Hand', '10001', 1, 'asset', 1, NULL, NULL, 1, NULL, '2025-09-08 03:12:07'),
(7, 'Bank Account', '10002', 1, 'asset', 1, NULL, NULL, 1, NULL, NULL),
(8, 'Accounts Payable', '20001', 2, 'liability', 0, NULL, NULL, 1, NULL, NULL),
(9, 'Owner’s Capital', '30001', 3, 'equity', 0, NULL, NULL, 1, NULL, '2025-09-08 02:54:29'),
(10, 'Sales Revenue', '40001', 4, 'income', 0, NULL, NULL, 1, NULL, NULL),
(11, 'Sales Discount', '50001', 5, 'expense', 1, NULL, NULL, 1, NULL, NULL),
(20, 'Supplier Advance', '10003', 1, 'asset', 1, 'Revenue from product sales', NULL, 1, '2025-09-07 04:23:08', '2025-09-07 06:51:24'),
(34, 'Cost of Goods Sold', '50002', 5, 'expense', 1, NULL, NULL, 1, '2025-09-20 06:12:42', '2025-09-20 06:12:42'),
(35, 'Tax Payable', '20002', 2, 'liability', 0, NULL, NULL, 1, '2025-09-20 06:12:58', '2025-09-20 06:12:58'),
(36, 'Customer Advance', '20003', 2, 'liability', 0, NULL, NULL, 1, '2025-09-20 06:22:18', '2025-09-20 06:22:18'),
(37, 'Accounts Receivable', '10004', 1, 'asset', 1, NULL, NULL, 1, '2025-09-20 06:24:14', '2025-09-20 06:24:14'),
(38, 'Inventory', '10005', 1, 'asset', 1, NULL, NULL, 1, '2025-09-20 06:24:50', '2025-09-20 06:24:50'),
(39, 'Purchase Discount', '40002', 4, 'income', 0, NULL, NULL, 1, '2025-09-20 07:10:14', '2025-09-20 07:10:14'),
(40, 'Purchase Tax', '10006', 1, 'asset', 1, NULL, NULL, 1, '2025-09-20 07:10:57', '2025-09-20 07:10:57'),
(41, 'Opening Balance Adjustment', '30002', 3, 'equity', 0, NULL, NULL, 1, '2025-09-22 23:10:27', '2025-09-22 23:10:27'),
(42, 'Customer Previous Due', '10007', 1, 'asset', 1, NULL, NULL, 1, '2025-11-24 02:52:16', '2025-11-24 02:52:16');

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
(1, 1, 'Created Account Head', NULL, '{\"data\": {\"id\": 19, \"code\": \"01001\", \"name\": \"Sales Revenue\", \"type\": \"asset\", \"is_debit\": 1, \"parent_id\": 1, \"created_at\": \"2025-09-07T10:13:34.000000Z\", \"updated_at\": \"2025-09-07T10:13:34.000000Z\"}}', '2025-09-07 04:13:34'),
(2, 1, 'Updated Account Head', NULL, '{\"id\": \"19\", \"new\": {\"id\": 19, \"code\": \"01001\", \"name\": \"Sales Revenue Update\", \"type\": \"asset\", \"remarks\": \"Revenue from product sales\", \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": \"2025-09-07T10:13:34.000000Z\", \"updated_at\": \"2025-09-07T10:18:44.000000Z\"}, \"old\": {\"id\": 19, \"code\": \"01001\", \"name\": \"Sales Revenue Update\", \"type\": \"asset\", \"remarks\": null, \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": \"2025-09-07T10:13:34.000000Z\", \"updated_at\": \"2025-09-07T10:18:44.000000Z\"}}', '2025-09-07 04:18:44'),
(3, 1, 'Updated Account Head', NULL, '{\"id\": \"19\", \"new\": {\"id\": 19, \"code\": \"01001\", \"name\": \"Sales Revenue\", \"type\": \"asset\", \"remarks\": \"Revenue from product sales\", \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": \"2025-09-07T10:13:34.000000Z\", \"updated_at\": \"2025-09-07T10:20:43.000000Z\"}, \"old\": {\"id\": 19, \"code\": \"01001\", \"name\": \"Sales Revenue Update\", \"type\": \"asset\", \"remarks\": \"Revenue from product sales\", \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": \"2025-09-07T10:13:34.000000Z\", \"updated_at\": \"2025-09-07T10:18:44.000000Z\"}}', '2025-09-07 04:20:43'),
(4, 1, 'Deleted Account Head', NULL, '{\"id\": \"19\", \"data\": {\"id\": 19, \"code\": \"01001\", \"name\": \"Sales Revenue\", \"type\": \"asset\", \"remarks\": \"Revenue from product sales\", \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": \"2025-09-07T10:13:34.000000Z\", \"updated_at\": \"2025-09-07T10:20:43.000000Z\"}}', '2025-09-07 04:22:13'),
(5, 1, 'Created Account Head', NULL, '{\"data\": {\"id\": 20, \"code\": \"01001\", \"name\": \"Sales Revenue\", \"type\": \"asset\", \"is_debit\": 1, \"parent_id\": 1, \"created_at\": \"2025-09-07T10:23:08.000000Z\", \"updated_at\": \"2025-09-07T10:23:08.000000Z\"}}', '2025-09-07 04:23:08'),
(6, 1, 'Updated Account Head', NULL, '{\"id\": \"20\", \"new\": {\"id\": 20, \"code\": \"01001\", \"name\": \"Sales Revenue\", \"type\": \"asset\", \"remarks\": \"Revenue from product sales\", \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": \"2025-09-07T10:23:08.000000Z\", \"updated_at\": \"2025-09-07T10:23:38.000000Z\"}, \"old\": {\"id\": 20, \"code\": \"01001\", \"name\": \"Sales Revenue\", \"type\": \"asset\", \"remarks\": null, \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": \"2025-09-07T10:23:08.000000Z\", \"updated_at\": \"2025-09-07T10:23:08.000000Z\"}}', '2025-09-07 04:23:38'),
(7, 1, 'Created Account Module', NULL, '{\"data\": {\"id\": 1, \"status\": true, \"created_at\": \"2025-09-07T10:42:12.000000Z\", \"entry_type\": \"sales\", \"updated_at\": \"2025-09-07T10:42:12.000000Z\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"module_entry_id\": 1}', '2025-09-07 04:42:12'),
(8, 1, 'Updated Account Module', NULL, '{\"new\": {\"status\": true, \"accounts\": [{\"is_debit\": false, \"component\": \"Revenue\", \"description\": \"Sales revenue account\", \"account_head_id\": 5}, {\"is_debit\": true, \"component\": \"Cash\", \"description\": \"Cash received from customer\", \"account_head_id\": 2}], \"entry_type\": \"sales\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"old\": {\"id\": 1, \"status\": 1, \"accounts\": [{\"id\": 1, \"is_debit\": 0, \"component\": \"Revenue\", \"created_at\": \"2025-09-07T10:42:12.000000Z\", \"updated_at\": \"2025-09-07T10:42:12.000000Z\", \"description\": \"Sales revenue account\", \"account_head_id\": 5, \"module_entry_id\": 1}, {\"id\": 2, \"is_debit\": 1, \"component\": \"Cash\", \"created_at\": \"2025-09-07T10:42:12.000000Z\", \"updated_at\": \"2025-09-07T10:42:12.000000Z\", \"description\": \"Cash received from customer\", \"account_head_id\": 2, \"module_entry_id\": 1}], \"created_at\": \"2025-09-07T10:42:12.000000Z\", \"entry_type\": \"sales\", \"updated_at\": \"2025-09-07T10:42:12.000000Z\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"module_entry_id\": 1}', '2025-09-07 04:44:26'),
(9, 1, 'Updated Account Head', '01001', '{\"id\": \"20\", \"new\": {\"id\": 20, \"code\": \"01001\", \"name\": \"Sales Revenue\", \"type\": \"asset\", \"remarks\": \"Revenue from product sales\", \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": \"2025-09-07T10:23:08.000000Z\", \"updated_at\": \"2025-09-07T12:51:24.000000Z\"}, \"old\": {\"id\": 20, \"code\": \"01001\", \"name\": \"Sales Revenue\", \"type\": \"asset\", \"remarks\": \"Revenue from product sales\", \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": \"2025-09-07T10:23:08.000000Z\", \"updated_at\": \"2025-09-07T10:23:38.000000Z\"}}', '2025-09-07 06:51:24'),
(10, 1, 'Updated Account Module', '1', '{\"new\": {\"status\": true, \"accounts\": [{\"is_debit\": false, \"component\": \"Revenue\", \"description\": \"Sales revenue account\", \"account_head_id\": 5}, {\"is_debit\": true, \"component\": \"Cash\", \"description\": \"Cash received from customer\", \"account_head_id\": 2}], \"entry_type\": \"sales\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"old\": {\"id\": 1, \"status\": 1, \"accounts\": [{\"id\": 3, \"is_debit\": 0, \"component\": \"Revenue\", \"created_at\": \"2025-09-07T10:44:26.000000Z\", \"updated_at\": \"2025-09-07T10:44:26.000000Z\", \"description\": \"Sales revenue account\", \"account_head_id\": 5, \"module_entry_id\": 1}, {\"id\": 4, \"is_debit\": 1, \"component\": \"Cash\", \"created_at\": \"2025-09-07T10:44:26.000000Z\", \"updated_at\": \"2025-09-07T10:44:26.000000Z\", \"description\": \"Cash received from customer\", \"account_head_id\": 2, \"module_entry_id\": 1}], \"created_at\": \"2025-09-07T10:42:12.000000Z\", \"entry_type\": \"sales\", \"updated_at\": \"2025-09-07T10:44:26.000000Z\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"module_entry_id\": 1}', '2025-09-07 06:54:29'),
(11, 1, 'Created Journal Voucher Entry', 'INV-001', '{\"data\": {\"id\": 1, \"date\": \"2025-09-08\", \"lines\": [{\"debit\": 500, \"credit\": 0, \"description\": \"Stationery expense\", \"account_head_id\": 1}, {\"debit\": 0, \"credit\": 500, \"description\": \"Cash payment\", \"account_head_id\": 2}], \"module\": null, \"status\": 1, \"branch_id\": null, \"reference\": \"INV-001\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-08T04:47:23.000000Z\", \"voucher_no\": \"JV-000001\", \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"journal_entry_id\": 1}', '2025-09-07 22:47:24'),
(12, 1, 'Updated Journal Voucher Entry', 'INV-001', '{\"new\": {\"id\": 1, \"date\": \"2025-09-08\", \"lines\": [{\"debit\": 500, \"credit\": 0, \"description\": \"Stationery expense\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 500, \"description\": \"Cash payment\", \"account_head_id\": 9}], \"module\": null, \"status\": 1, \"details\": [{\"id\": 1, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"updated_at\": \"2025-09-08T04:47:23.000000Z\", \"account_head_id\": 1, \"journal_entry_id\": 1}, {\"id\": 2, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"updated_at\": \"2025-09-08T04:47:23.000000Z\", \"account_head_id\": 2, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": null, \"reference\": \"INV-001\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-08T04:55:49.000000Z\", \"voucher_no\": \"JV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"old\": {\"id\": 1, \"date\": \"2025-09-08\", \"lines\": [{\"id\": 1, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"updated_at\": \"2025-09-08T04:47:23.000000Z\", \"account_head_id\": 1, \"journal_entry_id\": 1}, {\"id\": 2, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"updated_at\": \"2025-09-08T04:47:23.000000Z\", \"account_head_id\": 2, \"journal_entry_id\": 1}], \"module\": null, \"status\": \"pending\", \"details\": [{\"id\": 1, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"updated_at\": \"2025-09-08T04:47:23.000000Z\", \"account_head_id\": 1, \"journal_entry_id\": 1}, {\"id\": 2, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"updated_at\": \"2025-09-08T04:47:23.000000Z\", \"account_head_id\": 2, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": null, \"reference\": \"INV-001\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-08T04:47:23.000000Z\", \"voucher_no\": \"JV-000001\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"journal_entry_id\": 1}', '2025-09-07 22:55:49'),
(13, 1, 'Updated Journal Voucher Entry', 'INV-001', '{\"new\": {\"id\": 1, \"date\": \"2025-09-08\", \"lines\": [{\"debit\": 500, \"credit\": 0, \"description\": \"Stationery expense\", \"account_head_id\": 1}, {\"debit\": 0, \"credit\": 500, \"description\": \"Cash payment\", \"account_head_id\": 2}], \"module\": null, \"status\": 1, \"details\": [{\"id\": 3, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-08T04:55:49.000000Z\", \"updated_at\": \"2025-09-08T04:55:49.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 4, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-08T04:55:49.000000Z\", \"updated_at\": \"2025-09-08T04:55:49.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": null, \"reference\": \"INV-001\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-08T05:05:10.000000Z\", \"voucher_no\": \"JV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"old\": {\"id\": 1, \"date\": \"2025-09-08\", \"lines\": [{\"id\": 3, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-08T04:55:49.000000Z\", \"updated_at\": \"2025-09-08T04:55:49.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 4, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-08T04:55:49.000000Z\", \"updated_at\": \"2025-09-08T04:55:49.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"module\": null, \"status\": \"pending\", \"details\": [{\"id\": 3, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-08T04:55:49.000000Z\", \"updated_at\": \"2025-09-08T04:55:49.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 4, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-08T04:55:49.000000Z\", \"updated_at\": \"2025-09-08T04:55:49.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": null, \"reference\": \"INV-001\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-08T04:55:49.000000Z\", \"voucher_no\": \"JV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"journal_entry_id\": 1}', '2025-09-07 23:05:10'),
(14, 1, 'Updated Journal Voucher Entry', 'INV-001', '{\"new\": {\"id\": 1, \"date\": \"2025-09-08\", \"lines\": [{\"debit\": 500, \"credit\": 0, \"description\": \"Stationery expense\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 500, \"description\": \"Cash payment\", \"account_head_id\": 9}], \"module\": null, \"status\": 1, \"details\": [{\"id\": 5, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-08T05:05:10.000000Z\", \"updated_at\": \"2025-09-08T05:05:10.000000Z\", \"account_head_id\": 1, \"journal_entry_id\": 1}, {\"id\": 6, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-08T05:05:10.000000Z\", \"updated_at\": \"2025-09-08T05:05:10.000000Z\", \"account_head_id\": 2, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": null, \"reference\": \"INV-001\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-08T05:05:51.000000Z\", \"voucher_no\": \"JV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"old\": {\"id\": 1, \"date\": \"2025-09-08\", \"lines\": [{\"id\": 5, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-08T05:05:10.000000Z\", \"updated_at\": \"2025-09-08T05:05:10.000000Z\", \"account_head_id\": 1, \"journal_entry_id\": 1}, {\"id\": 6, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-08T05:05:10.000000Z\", \"updated_at\": \"2025-09-08T05:05:10.000000Z\", \"account_head_id\": 2, \"journal_entry_id\": 1}], \"module\": null, \"status\": \"pending\", \"details\": [{\"id\": 5, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-08T05:05:10.000000Z\", \"updated_at\": \"2025-09-08T05:05:10.000000Z\", \"account_head_id\": 1, \"journal_entry_id\": 1}, {\"id\": 6, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-08T05:05:10.000000Z\", \"updated_at\": \"2025-09-08T05:05:10.000000Z\", \"account_head_id\": 2, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": null, \"reference\": \"INV-001\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-08T05:05:10.000000Z\", \"voucher_no\": \"JV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"journal_entry_id\": 1}', '2025-09-07 23:05:51'),
(15, 1, 'Updated Chart Of Account', '1001', '{\"id\": \"6\", \"new\": {\"id\": 6, \"code\": \"1001\", \"name\": \"Cash in Hand\", \"type\": \"asset\", \"status\": 1, \"remarks\": null, \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": null, \"updated_at\": \"2025-09-08T08:54:01.000000Z\"}, \"old\": {\"id\": 6, \"code\": \"1001\", \"name\": \"Cash in Hand\", \"type\": \"asset\", \"status\": 1, \"remarks\": null, \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": null, \"updated_at\": null}}', '2025-09-08 02:54:01'),
(16, 1, 'Updated Chart Of Account', '3001', '{\"id\": \"9\", \"new\": {\"id\": 9, \"code\": \"3001\", \"name\": \"Owner’s Capital\", \"type\": \"equity\", \"status\": 1, \"remarks\": null, \"is_debit\": 0, \"branch_id\": null, \"parent_id\": 6, \"created_at\": null, \"updated_at\": \"2025-09-08T08:54:29.000000Z\"}, \"old\": {\"id\": 9, \"code\": \"3001\", \"name\": \"Owner’s Capital\", \"type\": \"equity\", \"status\": 1, \"remarks\": null, \"is_debit\": 0, \"branch_id\": null, \"parent_id\": 6, \"created_at\": null, \"updated_at\": null}}', '2025-09-08 02:54:29'),
(17, 1, 'Updated Chart Of Account', '1001', '{\"id\": \"6\", \"new\": {\"id\": 6, \"code\": \"1001\", \"name\": \"Cash in Hand\", \"type\": \"asset\", \"status\": \"0\", \"remarks\": null, \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": null, \"updated_at\": \"2025-09-08T09:10:34.000000Z\"}, \"old\": {\"id\": 6, \"code\": \"1001\", \"name\": \"Cash in Hand\", \"type\": \"asset\", \"status\": 1, \"remarks\": null, \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": null, \"updated_at\": \"2025-09-08T08:54:01.000000Z\"}}', '2025-09-08 03:10:34'),
(18, 1, 'Updated Chart Of Account', '1001', '{\"id\": \"6\", \"new\": {\"id\": 6, \"code\": \"1001\", \"name\": \"Cash in Hand\", \"type\": \"asset\", \"status\": \"1\", \"remarks\": null, \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": null, \"updated_at\": \"2025-09-08T09:10:46.000000Z\"}, \"old\": {\"id\": 6, \"code\": \"1001\", \"name\": \"Cash in Hand\", \"type\": \"asset\", \"status\": 0, \"remarks\": null, \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": null, \"updated_at\": \"2025-09-08T09:10:34.000000Z\"}}', '2025-09-08 03:10:46'),
(19, 1, 'Updated Chart Of Account', '1001', '{\"id\": \"6\", \"new\": {\"id\": 6, \"code\": \"1001\", \"name\": \"Cash in Hand\", \"type\": \"asset\", \"status\": \"0\", \"remarks\": null, \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": null, \"updated_at\": \"2025-09-08T09:12:03.000000Z\"}, \"old\": {\"id\": 6, \"code\": \"1001\", \"name\": \"Cash in Hand\", \"type\": \"asset\", \"status\": 1, \"remarks\": null, \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": null, \"updated_at\": \"2025-09-08T09:10:46.000000Z\"}}', '2025-09-08 03:12:03'),
(20, 1, 'Updated Chart Of Account', '1001', '{\"id\": \"6\", \"new\": {\"id\": 6, \"code\": \"1001\", \"name\": \"Cash in Hand\", \"type\": \"asset\", \"status\": \"1\", \"remarks\": null, \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": null, \"updated_at\": \"2025-09-08T09:12:07.000000Z\"}, \"old\": {\"id\": 6, \"code\": \"1001\", \"name\": \"Cash in Hand\", \"type\": \"asset\", \"status\": 0, \"remarks\": null, \"is_debit\": 1, \"branch_id\": null, \"parent_id\": 1, \"created_at\": null, \"updated_at\": \"2025-09-08T09:12:03.000000Z\"}}', '2025-09-08 03:12:07'),
(21, 1, 'Created Chart Of Account', '02001', '{\"data\": {\"id\": 21, \"code\": \"02001\", \"name\": \"New Test\", \"type\": \"liability\", \"status\": 1, \"is_debit\": 0, \"parent_id\": 2, \"created_at\": \"2025-09-08T09:13:33.000000Z\", \"updated_at\": \"2025-09-08T09:13:33.000000Z\"}}', '2025-09-08 03:13:33'),
(22, 1, 'Created Chart Of Account', '02002', '{\"data\": {\"id\": 22, \"code\": \"02002\", \"name\": \"New Test 2\", \"type\": \"liability\", \"status\": 1, \"is_debit\": 0, \"parent_id\": 21, \"created_at\": \"2025-09-08T09:13:51.000000Z\", \"updated_at\": \"2025-09-08T09:13:51.000000Z\"}}', '2025-09-08 03:13:51'),
(23, 1, 'Updated Journal Voucher Entry', 'REF-000002', '{\"new\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": 500, \"lines\": [{\"debit\": \"500.00\", \"credit\": \"0.00\", \"account_head_id\": 6}, {\"debit\": \"0.00\", \"credit\": \"500.00\", \"account_head_id\": 9}], \"credit\": 500, \"module\": null, \"status\": 1, \"details\": [{\"id\": 7, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-08T05:05:51.000000Z\", \"updated_at\": \"2025-09-08T05:05:51.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 8, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-08T05:05:51.000000Z\", \"updated_at\": \"2025-09-08T05:05:51.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": null, \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-10T11:23:02.000000Z\", \"voucher_no\": \"JV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"old\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": \"0.00\", \"lines\": [{\"id\": 7, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-08T05:05:51.000000Z\", \"updated_at\": \"2025-09-08T05:05:51.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 8, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-08T05:05:51.000000Z\", \"updated_at\": \"2025-09-08T05:05:51.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"credit\": \"0.00\", \"module\": null, \"status\": \"pending\", \"details\": [{\"id\": 7, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-08T05:05:51.000000Z\", \"updated_at\": \"2025-09-08T05:05:51.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 8, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-08T05:05:51.000000Z\", \"updated_at\": \"2025-09-08T05:05:51.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": null, \"reference\": \"INV-001\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-08T05:05:51.000000Z\", \"voucher_no\": \"JV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"journal_entry_id\": 1}', '2025-09-10 05:23:02'),
(24, 1, 'Updated Journal Voucher Entry', 'REF-000002', '{\"new\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": 500, \"lines\": [{\"debit\": \"500.00\", \"credit\": \"0.00\", \"account_head_id\": 6}, {\"debit\": \"0.00\", \"credit\": \"500.00\", \"account_head_id\": 9}], \"credit\": 500, \"module\": null, \"status\": 1, \"details\": [{\"id\": 9, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:23:02.000000Z\", \"updated_at\": \"2025-09-10T11:23:02.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 10, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:23:02.000000Z\", \"updated_at\": \"2025-09-10T11:23:02.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": null, \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-10T11:23:59.000000Z\", \"voucher_no\": \"JV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"old\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": \"500.00\", \"lines\": [{\"id\": 9, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:23:02.000000Z\", \"updated_at\": \"2025-09-10T11:23:02.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 10, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:23:02.000000Z\", \"updated_at\": \"2025-09-10T11:23:02.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"credit\": \"500.00\", \"module\": null, \"status\": \"pending\", \"details\": [{\"id\": 9, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:23:02.000000Z\", \"updated_at\": \"2025-09-10T11:23:02.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 10, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:23:02.000000Z\", \"updated_at\": \"2025-09-10T11:23:02.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": null, \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-10T11:23:02.000000Z\", \"voucher_no\": \"JV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"journal_entry_id\": 1}', '2025-09-10 05:23:59'),
(25, 1, 'Updated Journal Voucher Entry', 'REF-000002', '{\"new\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": 500, \"lines\": [{\"debit\": \"500.00\", \"credit\": \"0.00\", \"account_head_id\": 6}, {\"debit\": \"0.00\", \"credit\": \"500.00\", \"account_head_id\": 9}], \"credit\": 500, \"module\": null, \"status\": 1, \"details\": [{\"id\": 11, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:23:59.000000Z\", \"updated_at\": \"2025-09-10T11:23:59.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 12, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:23:59.000000Z\", \"updated_at\": \"2025-09-10T11:23:59.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": \"Test\", \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-10T11:24:41.000000Z\", \"voucher_no\": \"JV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"old\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": \"500.00\", \"lines\": [{\"id\": 11, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:23:59.000000Z\", \"updated_at\": \"2025-09-10T11:23:59.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 12, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:23:59.000000Z\", \"updated_at\": \"2025-09-10T11:23:59.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"credit\": \"500.00\", \"module\": null, \"status\": \"pending\", \"details\": [{\"id\": 11, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:23:59.000000Z\", \"updated_at\": \"2025-09-10T11:23:59.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 12, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:23:59.000000Z\", \"updated_at\": \"2025-09-10T11:23:59.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": null, \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-10T11:23:59.000000Z\", \"voucher_no\": \"JV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"journal_entry_id\": 1}', '2025-09-10 05:24:41'),
(26, 1, 'Updated Journal Voucher Entry', 'REF-000002', '{\"new\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": 500, \"lines\": [{\"debit\": \"500.00\", \"credit\": \"0.00\", \"account_head_id\": 6}, {\"debit\": \"0.00\", \"credit\": \"500.00\", \"account_head_id\": 9}], \"credit\": 500, \"module\": null, \"status\": 1, \"details\": [{\"id\": 13, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:24:41.000000Z\", \"updated_at\": \"2025-09-10T11:24:41.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 14, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:24:41.000000Z\", \"updated_at\": \"2025-09-10T11:24:41.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": \"Test\", \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-10T11:47:11.000000Z\", \"voucher_no\": \"JV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"old\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": \"500.00\", \"lines\": [{\"id\": 13, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:24:41.000000Z\", \"updated_at\": \"2025-09-10T11:24:41.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 14, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:24:41.000000Z\", \"updated_at\": \"2025-09-10T11:24:41.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"credit\": \"500.00\", \"module\": null, \"status\": \"pending\", \"details\": [{\"id\": 13, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:24:41.000000Z\", \"updated_at\": \"2025-09-10T11:24:41.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 14, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:24:41.000000Z\", \"updated_at\": \"2025-09-10T11:24:41.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": \"Test\", \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-10T11:24:41.000000Z\", \"voucher_no\": \"JV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"journal_entry_id\": 1}', '2025-09-10 05:47:11'),
(27, 1, 'Updated Journal Voucher Entry', 'REF-000002', '{\"new\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": 500, \"lines\": [{\"debit\": \"500.00\", \"credit\": \"0.00\", \"account_head_id\": 6}, {\"debit\": \"0.00\", \"credit\": \"500.00\", \"account_head_id\": 9}], \"credit\": 500, \"module\": null, \"status\": 1, \"details\": [{\"id\": 15, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:11.000000Z\", \"updated_at\": \"2025-09-10T11:47:11.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 16, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:11.000000Z\", \"updated_at\": \"2025-09-10T11:47:11.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": \"Test\", \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-10T11:47:23.000000Z\", \"voucher_no\": \"JV-000001\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"old\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": \"500.00\", \"lines\": [{\"id\": 15, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:11.000000Z\", \"updated_at\": \"2025-09-10T11:47:11.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 16, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:11.000000Z\", \"updated_at\": \"2025-09-10T11:47:11.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"credit\": \"500.00\", \"module\": null, \"status\": \"pending\", \"details\": [{\"id\": 15, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:11.000000Z\", \"updated_at\": \"2025-09-10T11:47:11.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 16, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:11.000000Z\", \"updated_at\": \"2025-09-10T11:47:11.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": \"Test\", \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-10T11:47:11.000000Z\", \"voucher_no\": \"JV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"journal_entry_id\": 1}', '2025-09-10 05:47:23'),
(28, 1, 'Updated Journal Voucher Entry', 'REF-000002', '{\"new\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": 500, \"lines\": [{\"debit\": \"500.00\", \"credit\": \"0.00\", \"account_head_id\": 6}, {\"debit\": \"0.00\", \"credit\": \"500.00\", \"account_head_id\": 9}], \"credit\": 500, \"module\": null, \"status\": 1, \"details\": [{\"id\": 17, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:23.000000Z\", \"updated_at\": \"2025-09-10T11:47:23.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 18, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:23.000000Z\", \"updated_at\": \"2025-09-10T11:47:23.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": \"Test\", \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-10T11:47:41.000000Z\", \"voucher_no\": \"JV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"old\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": \"500.00\", \"lines\": [{\"id\": 17, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:23.000000Z\", \"updated_at\": \"2025-09-10T11:47:23.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 18, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:23.000000Z\", \"updated_at\": \"2025-09-10T11:47:23.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"credit\": \"500.00\", \"module\": null, \"status\": \"pending\", \"details\": [{\"id\": 17, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:23.000000Z\", \"updated_at\": \"2025-09-10T11:47:23.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 18, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:23.000000Z\", \"updated_at\": \"2025-09-10T11:47:23.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": \"Test\", \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-10T11:47:23.000000Z\", \"voucher_no\": \"JV-000001\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"journal_entry_id\": 1}', '2025-09-10 05:47:41'),
(29, 1, 'Updated Journal Voucher Entry', 'REF-000002', '{\"new\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": 500, \"lines\": [{\"debit\": \"500.00\", \"credit\": \"0.00\", \"account_head_id\": 6}, {\"debit\": \"0.00\", \"credit\": \"500.00\", \"account_head_id\": 9}], \"credit\": 500, \"module\": null, \"status\": 1, \"details\": [{\"id\": 19, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:41.000000Z\", \"updated_at\": \"2025-09-10T11:47:41.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 20, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:41.000000Z\", \"updated_at\": \"2025-09-10T11:47:41.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": \"Test\", \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-10T11:48:35.000000Z\", \"voucher_no\": \"JV-000001\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"old\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": \"500.00\", \"lines\": [{\"id\": 19, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:41.000000Z\", \"updated_at\": \"2025-09-10T11:47:41.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 20, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:41.000000Z\", \"updated_at\": \"2025-09-10T11:47:41.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"credit\": \"500.00\", \"module\": null, \"status\": \"pending\", \"details\": [{\"id\": 19, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:41.000000Z\", \"updated_at\": \"2025-09-10T11:47:41.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 20, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:47:41.000000Z\", \"updated_at\": \"2025-09-10T11:47:41.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": \"Test\", \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-10T11:47:41.000000Z\", \"voucher_no\": \"JV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"journal_entry_id\": 1}', '2025-09-10 05:48:35'),
(30, 1, 'Updated Journal Voucher Entry', 'REF-000002', '{\"new\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": 500, \"lines\": [{\"debit\": \"500.00\", \"credit\": \"0.00\", \"account_head_id\": 6}, {\"debit\": \"0.00\", \"credit\": \"500.00\", \"account_head_id\": 9}], \"credit\": 500, \"module\": null, \"status\": 1, \"details\": [{\"id\": 21, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:48:35.000000Z\", \"updated_at\": \"2025-09-10T11:48:35.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 22, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:48:35.000000Z\", \"updated_at\": \"2025-09-10T11:48:35.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": \"Test\", \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-10T12:11:33.000000Z\", \"voucher_no\": \"RAD-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"old\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": \"500.00\", \"lines\": [{\"id\": 21, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:48:35.000000Z\", \"updated_at\": \"2025-09-10T11:48:35.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 22, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:48:35.000000Z\", \"updated_at\": \"2025-09-10T11:48:35.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"credit\": \"500.00\", \"module\": null, \"status\": \"pending\", \"details\": [{\"id\": 21, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:48:35.000000Z\", \"updated_at\": \"2025-09-10T11:48:35.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 22, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T11:48:35.000000Z\", \"updated_at\": \"2025-09-10T11:48:35.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": \"Test\", \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-10T11:48:35.000000Z\", \"voucher_no\": \"JV-000001\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"journal_entry_id\": 1}', '2025-09-10 06:11:33'),
(31, 1, 'Updated Journal Voucher Entry', 'REF-000002', '{\"new\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": 500, \"lines\": [{\"debit\": \"500.00\", \"credit\": \"0.00\", \"account_head_id\": 6}, {\"debit\": \"0.00\", \"credit\": \"500.00\", \"account_head_id\": 9}], \"credit\": 500, \"module\": null, \"status\": 1, \"details\": [{\"id\": 23, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T12:11:33.000000Z\", \"updated_at\": \"2025-09-10T12:11:33.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 24, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T12:11:33.000000Z\", \"updated_at\": \"2025-09-10T12:11:33.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": \"Test\", \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-10T12:11:49.000000Z\", \"voucher_no\": \"JV-000001\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"old\": {\"id\": 1, \"date\": \"2025-09-08\", \"debit\": \"500.00\", \"lines\": [{\"id\": 23, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T12:11:33.000000Z\", \"updated_at\": \"2025-09-10T12:11:33.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 24, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T12:11:33.000000Z\", \"updated_at\": \"2025-09-10T12:11:33.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"credit\": \"500.00\", \"module\": null, \"status\": \"pending\", \"details\": [{\"id\": 23, \"debit\": \"500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-10T12:11:33.000000Z\", \"updated_at\": \"2025-09-10T12:11:33.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 1}, {\"id\": 24, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-09-10T12:11:33.000000Z\", \"updated_at\": \"2025-09-10T12:11:33.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 1}], \"branch_id\": null, \"narration\": \"Test\", \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-08T04:47:23.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-10T12:11:33.000000Z\", \"voucher_no\": \"RAD-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"journal_entry_id\": 1}', '2025-09-10 06:11:49'),
(32, 1, 'Created Payment Voucher Entry', 'REF-000002', '{\"data\": {\"id\": 2, \"date\": \"2025-09-11\", \"debit\": 5000, \"lines\": [{\"debit\": \"5000\", \"credit\": 0, \"account_head_id\": 6}, {\"debit\": 0, \"credit\": \"5000\", \"account_head_id\": 9}], \"credit\": 5000, \"module\": null, \"status\": 1, \"branch_id\": null, \"narration\": null, \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-11T04:30:57.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-11T04:30:57.000000Z\", \"voucher_no\": \"PV-000001\", \"source_type\": null, \"voucher_type\": \"Payment Voucher\"}, \"journal_entry_id\": 2}', '2025-09-10 22:30:57'),
(33, 1, 'Updated Payment Voucher Entry', 'REF-000002', '{\"new\": {\"id\": 2, \"date\": \"2025-09-11\", \"debit\": 5000, \"lines\": [{\"debit\": \"5000.00\", \"credit\": \"0.00\", \"account_head_id\": 6}, {\"debit\": \"0.00\", \"credit\": \"5000.00\", \"account_head_id\": 9}], \"credit\": 5000, \"module\": null, \"status\": 1, \"details\": [{\"id\": 27, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-11T04:30:57.000000Z\", \"updated_at\": \"2025-09-11T04:30:57.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 2}, {\"id\": 28, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-09-11T04:30:57.000000Z\", \"updated_at\": \"2025-09-11T04:30:57.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 2}], \"branch_id\": null, \"narration\": null, \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-11T04:30:57.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-11T04:33:34.000000Z\", \"voucher_no\": \"PV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Payment Voucher\"}, \"old\": {\"id\": 2, \"date\": \"2025-09-11\", \"debit\": \"5000.00\", \"lines\": [{\"id\": 27, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-11T04:30:57.000000Z\", \"updated_at\": \"2025-09-11T04:30:57.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 2}, {\"id\": 28, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-09-11T04:30:57.000000Z\", \"updated_at\": \"2025-09-11T04:30:57.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 2}], \"credit\": \"5000.00\", \"module\": null, \"status\": \"pending\", \"details\": [{\"id\": 27, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-11T04:30:57.000000Z\", \"updated_at\": \"2025-09-11T04:30:57.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 2}, {\"id\": 28, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-09-11T04:30:57.000000Z\", \"updated_at\": \"2025-09-11T04:30:57.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 2}], \"branch_id\": null, \"narration\": null, \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-11T04:30:57.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-11T04:30:57.000000Z\", \"voucher_no\": \"PV-000001\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Payment Voucher\"}, \"journal_entry_id\": 2}', '2025-09-10 22:33:34'),
(34, 1, 'Updated Payment Voucher Entry', 'REF-000002', '{\"new\": {\"id\": 2, \"date\": \"2025-09-11\", \"debit\": 5050, \"lines\": [{\"debit\": \"5050.00\", \"credit\": 0, \"account_head_id\": 6}, {\"debit\": 0, \"credit\": \"5050.00\", \"account_head_id\": 9}], \"credit\": 5050, \"module\": null, \"status\": 1, \"details\": [{\"id\": 29, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-11T04:33:34.000000Z\", \"updated_at\": \"2025-09-11T04:33:34.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 2}, {\"id\": 30, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-09-11T04:33:34.000000Z\", \"updated_at\": \"2025-09-11T04:33:34.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 2}], \"branch_id\": null, \"narration\": null, \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-11T04:30:57.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-11T06:08:21.000000Z\", \"voucher_no\": \"PV-000003\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Payment Voucher\"}, \"old\": {\"id\": 2, \"date\": \"2025-09-11\", \"debit\": \"5000.00\", \"lines\": [{\"id\": 29, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-11T04:33:34.000000Z\", \"updated_at\": \"2025-09-11T04:33:34.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 2}, {\"id\": 30, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-09-11T04:33:34.000000Z\", \"updated_at\": \"2025-09-11T04:33:34.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 2}], \"credit\": \"5000.00\", \"module\": null, \"status\": \"pending\", \"details\": [{\"id\": 29, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-11T04:33:34.000000Z\", \"updated_at\": \"2025-09-11T04:33:34.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 2}, {\"id\": 30, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-09-11T04:33:34.000000Z\", \"updated_at\": \"2025-09-11T04:33:34.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 2}], \"branch_id\": null, \"narration\": null, \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-11T04:30:57.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-11T04:33:34.000000Z\", \"voucher_no\": \"PV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Payment Voucher\"}, \"journal_entry_id\": 2}', '2025-09-11 00:08:21');
INSERT INTO `acc_audit_logs` (`id`, `user_id`, `action`, `source_ref`, `details`, `created_at`) VALUES
(35, 1, 'Updated Payment Voucher Entry', 'REF-000002', '{\"new\": {\"id\": 2, \"date\": \"2025-09-11\", \"debit\": 5254, \"lines\": [{\"debit\": \"5254.00\", \"credit\": 0, \"account_head_id\": 6}, {\"debit\": 0, \"credit\": \"5254.00\", \"account_head_id\": 9}], \"credit\": 5254, \"module\": null, \"status\": 1, \"details\": [{\"id\": 31, \"debit\": \"5050.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-11T06:08:21.000000Z\", \"updated_at\": \"2025-09-11T06:08:21.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 2}, {\"id\": 32, \"debit\": \"0.00\", \"credit\": \"5050.00\", \"remarks\": null, \"created_at\": \"2025-09-11T06:08:21.000000Z\", \"updated_at\": \"2025-09-11T06:08:21.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 2}], \"branch_id\": null, \"narration\": null, \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-11T04:30:57.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-11T06:08:53.000000Z\", \"voucher_no\": \"PV-000004\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Payment Voucher\"}, \"old\": {\"id\": 2, \"date\": \"2025-09-11\", \"debit\": \"5050.00\", \"lines\": [{\"id\": 31, \"debit\": \"5050.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-11T06:08:21.000000Z\", \"updated_at\": \"2025-09-11T06:08:21.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 2}, {\"id\": 32, \"debit\": \"0.00\", \"credit\": \"5050.00\", \"remarks\": null, \"created_at\": \"2025-09-11T06:08:21.000000Z\", \"updated_at\": \"2025-09-11T06:08:21.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 2}], \"credit\": \"5050.00\", \"module\": null, \"status\": \"pending\", \"details\": [{\"id\": 31, \"debit\": \"5050.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-11T06:08:21.000000Z\", \"updated_at\": \"2025-09-11T06:08:21.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 2}, {\"id\": 32, \"debit\": \"0.00\", \"credit\": \"5050.00\", \"remarks\": null, \"created_at\": \"2025-09-11T06:08:21.000000Z\", \"updated_at\": \"2025-09-11T06:08:21.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 2}], \"branch_id\": null, \"narration\": null, \"reference\": \"REF-000002\", \"source_id\": null, \"created_at\": \"2025-09-11T04:30:57.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-11T06:08:21.000000Z\", \"voucher_no\": \"PV-000003\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Payment Voucher\"}, \"journal_entry_id\": 2}', '2025-09-11 00:08:53'),
(36, 1, 'Updated Account Module', '1', '{\"new\": {\"status\": 1, \"accounts\": [{\"component\": \"Revenue\", \"account_head_id\": 5}, {\"component\": \"Cash\", \"account_head_id\": 2}], \"entry_type\": \"sales\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"old\": {\"id\": 1, \"status\": 1, \"accounts\": [{\"id\": 5, \"is_debit\": 0, \"component\": \"Revenue\", \"created_at\": \"2025-09-07T12:54:29.000000Z\", \"updated_at\": \"2025-09-07T12:54:29.000000Z\", \"description\": \"Sales revenue account\", \"account_head_id\": 5, \"module_entry_id\": 1}, {\"id\": 6, \"is_debit\": 1, \"component\": \"Cash\", \"created_at\": \"2025-09-07T12:54:29.000000Z\", \"updated_at\": \"2025-09-07T12:54:29.000000Z\", \"description\": \"Cash received from customer\", \"account_head_id\": 2, \"module_entry_id\": 1}], \"created_at\": \"2025-09-07T10:42:12.000000Z\", \"entry_type\": \"sales\", \"updated_at\": \"2025-09-07T12:54:29.000000Z\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"module_entry_id\": 1}', '2025-09-20 02:43:01'),
(37, 1, 'Created Account Module', '2', '{\"data\": {\"id\": 2, \"status\": true, \"created_at\": \"2025-09-20T08:44:01.000000Z\", \"entry_type\": \"sales\", \"updated_at\": \"2025-09-20T08:44:01.000000Z\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"module_entry_id\": 2}', '2025-09-20 02:44:01'),
(38, 1, 'Updated Account Module', '2', '{\"new\": {\"status\": 1, \"accounts\": [{\"component\": \"Revenue\", \"description\": \"Sales revenue account\", \"account_head_id\": 9}, {\"component\": \"Cash\", \"description\": \"Cash received from customer\", \"account_head_id\": 10}], \"entry_type\": \"sales\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"old\": {\"id\": 2, \"status\": 1, \"accounts\": [{\"id\": 9, \"is_debit\": 0, \"component\": \"Revenue\", \"created_at\": \"2025-09-20T08:44:01.000000Z\", \"updated_at\": \"2025-09-20T08:44:01.000000Z\", \"description\": \"Sales revenue account\", \"account_head_id\": 5, \"module_entry_id\": 2}, {\"id\": 10, \"is_debit\": 0, \"component\": \"Cash\", \"created_at\": \"2025-09-20T08:44:01.000000Z\", \"updated_at\": \"2025-09-20T08:44:01.000000Z\", \"description\": \"Cash received from customer\", \"account_head_id\": 2, \"module_entry_id\": 2}], \"created_at\": \"2025-09-20T08:44:01.000000Z\", \"entry_type\": \"sales\", \"updated_at\": \"2025-09-20T08:44:01.000000Z\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"module_entry_id\": 2}', '2025-09-20 02:53:17'),
(39, 1, 'Updated Account Module', '1', '{\"new\": {\"status\": 1, \"accounts\": [{\"component\": \"Revenue\", \"description\": null, \"account_head_id\": 7}, {\"component\": \"Cash\", \"description\": null, \"account_head_id\": 8}], \"entry_type\": \"sales\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"old\": {\"id\": 1, \"status\": 1, \"accounts\": [{\"id\": 7, \"is_debit\": 0, \"component\": \"Revenue\", \"created_at\": \"2025-09-20T08:43:01.000000Z\", \"updated_at\": \"2025-09-20T08:43:01.000000Z\", \"description\": null, \"account_head_id\": 5, \"module_entry_id\": 1}, {\"id\": 8, \"is_debit\": 0, \"component\": \"Cash\", \"created_at\": \"2025-09-20T08:43:01.000000Z\", \"updated_at\": \"2025-09-20T08:43:01.000000Z\", \"description\": null, \"account_head_id\": 2, \"module_entry_id\": 1}], \"created_at\": \"2025-09-07T10:42:12.000000Z\", \"entry_type\": \"sales\", \"updated_at\": \"2025-09-07T12:54:29.000000Z\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"module_entry_id\": 1}', '2025-09-20 02:53:35'),
(40, 1, 'Updated Account Module', '1', '{\"new\": {\"status\": 1, \"accounts\": [{\"component\": \"Revenue\", \"description\": null, \"account_head_id\": 7}, {\"component\": \"Cash\", \"description\": null, \"account_head_id\": 1}], \"entry_type\": \"sales\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"old\": {\"id\": 1, \"status\": 1, \"accounts\": [{\"id\": 13, \"is_debit\": 0, \"component\": \"Revenue\", \"created_at\": \"2025-09-20T08:53:35.000000Z\", \"updated_at\": \"2025-09-20T08:53:35.000000Z\", \"description\": null, \"account_head_id\": 7, \"module_entry_id\": 1}, {\"id\": 14, \"is_debit\": 0, \"component\": \"Cash\", \"created_at\": \"2025-09-20T08:53:35.000000Z\", \"updated_at\": \"2025-09-20T08:53:35.000000Z\", \"description\": null, \"account_head_id\": 8, \"module_entry_id\": 1}], \"created_at\": \"2025-09-07T10:42:12.000000Z\", \"entry_type\": \"sales\", \"updated_at\": \"2025-09-07T12:54:29.000000Z\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"module_entry_id\": 1}', '2025-09-20 02:54:07'),
(41, 1, 'Updated Account Module', '2', '{\"new\": {\"status\": 1, \"accounts\": [{\"component\": \"Revenue\", \"description\": \"Sales revenue account\", \"account_head_id\": 11}, {\"component\": \"Cash\", \"description\": \"Cash received from customer\", \"account_head_id\": 5}], \"entry_type\": \"sales\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"old\": {\"id\": 2, \"status\": 1, \"accounts\": [{\"id\": 11, \"is_debit\": 0, \"component\": \"Revenue\", \"created_at\": \"2025-09-20T08:53:17.000000Z\", \"updated_at\": \"2025-09-20T08:53:17.000000Z\", \"description\": \"Sales revenue account\", \"account_head_id\": 9, \"module_entry_id\": 2}, {\"id\": 12, \"is_debit\": 0, \"component\": \"Cash\", \"created_at\": \"2025-09-20T08:53:17.000000Z\", \"updated_at\": \"2025-09-20T08:53:17.000000Z\", \"description\": \"Cash received from customer\", \"account_head_id\": 10, \"module_entry_id\": 2}], \"created_at\": \"2025-09-20T08:44:01.000000Z\", \"entry_type\": \"sales\", \"updated_at\": \"2025-09-20T08:44:01.000000Z\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"module_entry_id\": 2}', '2025-09-20 02:59:12'),
(42, 1, 'Updated Account Module', '2', '{\"new\": {\"status\": 1, \"accounts\": [{\"component\": \"Revenue\", \"description\": \"Sales revenue account\", \"account_head_id\": 11}, {\"component\": \"Cash\", \"description\": \"Cash received from customer\", \"account_head_id\": 5}], \"entry_type\": \"sales\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"old\": {\"id\": 2, \"status\": 1, \"accounts\": [{\"id\": 17, \"is_debit\": 0, \"component\": \"Revenue\", \"created_at\": \"2025-09-20T08:59:12.000000Z\", \"updated_at\": \"2025-09-20T08:59:12.000000Z\", \"description\": \"Sales revenue account\", \"account_head_id\": 11, \"module_entry_id\": 2}, {\"id\": 18, \"is_debit\": 0, \"component\": \"Cash\", \"created_at\": \"2025-09-20T08:59:12.000000Z\", \"updated_at\": \"2025-09-20T08:59:12.000000Z\", \"description\": \"Cash received from customer\", \"account_head_id\": 5, \"module_entry_id\": 2}], \"created_at\": \"2025-09-20T08:44:01.000000Z\", \"entry_type\": \"sales\", \"updated_at\": \"2025-09-20T08:44:01.000000Z\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"module_entry_id\": 2}', '2025-09-20 03:14:53'),
(43, 1, 'Updated Account Module', '2', '{\"new\": {\"status\": 1, \"accounts\": [{\"component\": \"Revenue\", \"description\": \"Sales revenue account\", \"account_head_id\": 11}, {\"component\": \"Cash\", \"description\": \"Cash received from customer\", \"account_head_id\": 5}], \"entry_type\": \"sales\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"old\": {\"id\": 2, \"status\": 1, \"accounts\": [{\"id\": 19, \"is_debit\": 0, \"component\": \"Revenue\", \"created_at\": \"2025-09-20T09:14:53.000000Z\", \"updated_at\": \"2025-09-20T09:14:53.000000Z\", \"description\": \"Sales revenue account\", \"account_head_id\": 11, \"module_entry_id\": 2}, {\"id\": 20, \"is_debit\": 0, \"component\": \"Cash\", \"created_at\": \"2025-09-20T09:14:53.000000Z\", \"updated_at\": \"2025-09-20T09:14:53.000000Z\", \"description\": \"Cash received from customer\", \"account_head_id\": 5, \"module_entry_id\": 2}], \"created_at\": \"2025-09-20T08:44:01.000000Z\", \"entry_type\": \"sales\", \"updated_at\": \"2025-09-20T08:44:01.000000Z\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"module_entry_id\": 2}', '2025-09-20 03:17:39'),
(44, 1, 'Updated Account Module', '2', '{\"new\": {\"status\": 0, \"accounts\": [{\"component\": \"Revenue\", \"description\": \"Sales revenue account\", \"account_head_id\": 11}, {\"component\": \"Cash\", \"description\": \"Cash received from customer\", \"account_head_id\": 5}], \"entry_type\": \"sales\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"old\": {\"id\": 2, \"status\": 1, \"accounts\": [{\"id\": 21, \"is_debit\": 0, \"component\": \"Revenue\", \"created_at\": \"2025-09-20T09:17:39.000000Z\", \"updated_at\": \"2025-09-20T09:17:39.000000Z\", \"description\": \"Sales revenue account\", \"account_head_id\": 11, \"module_entry_id\": 2}, {\"id\": 22, \"is_debit\": 0, \"component\": \"Cash\", \"created_at\": \"2025-09-20T09:17:39.000000Z\", \"updated_at\": \"2025-09-20T09:17:39.000000Z\", \"description\": \"Cash received from customer\", \"account_head_id\": 5, \"module_entry_id\": 2}], \"created_at\": \"2025-09-20T08:44:01.000000Z\", \"entry_type\": \"sales\", \"updated_at\": \"2025-09-20T08:44:01.000000Z\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"module_entry_id\": 2}', '2025-09-20 03:17:44'),
(45, 1, 'Updated Account Module', '2', '{\"new\": {\"status\": 1, \"accounts\": [{\"component\": \"Revenue\", \"description\": \"Sales revenue account\", \"account_head_id\": 11}, {\"component\": \"Cash\", \"description\": \"Cash received from customer\", \"account_head_id\": 5}], \"entry_type\": \"sales\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"old\": {\"id\": 2, \"status\": 0, \"accounts\": [{\"id\": 23, \"is_debit\": 0, \"component\": \"Revenue\", \"created_at\": \"2025-09-20T09:17:44.000000Z\", \"updated_at\": \"2025-09-20T09:17:44.000000Z\", \"description\": \"Sales revenue account\", \"account_head_id\": 11, \"module_entry_id\": 2}, {\"id\": 24, \"is_debit\": 0, \"component\": \"Cash\", \"created_at\": \"2025-09-20T09:17:44.000000Z\", \"updated_at\": \"2025-09-20T09:17:44.000000Z\", \"description\": \"Cash received from customer\", \"account_head_id\": 5, \"module_entry_id\": 2}], \"created_at\": \"2025-09-20T08:44:01.000000Z\", \"entry_type\": \"sales\", \"updated_at\": \"2025-09-20T09:17:44.000000Z\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Sales Invoice\"}, \"module_entry_id\": 2}', '2025-09-20 03:17:49'),
(46, 1, 'Created Chart Of Account', '00001', '{\"data\": {\"id\": 32, \"code\": \"00001\", \"name\": \"Sales Discount\", \"type\": \"income\", \"status\": 1, \"is_debit\": 0, \"parent_id\": 4, \"created_at\": \"2025-09-20T12:00:44.000000Z\", \"updated_at\": \"2025-09-20T12:00:44.000000Z\"}}', '2025-09-20 06:00:44'),
(47, 1, 'Created Chart Of Account', '040002', '{\"data\": {\"id\": 33, \"code\": \"040002\", \"name\": \"Sales Discount\", \"type\": \"income\", \"status\": 1, \"is_debit\": 0, \"parent_id\": 4, \"created_at\": \"2025-09-20T12:11:57.000000Z\", \"updated_at\": \"2025-09-20T12:11:57.000000Z\"}}', '2025-09-20 06:11:57'),
(48, 1, 'Created Chart Of Account', '40002', '{\"data\": {\"id\": 34, \"code\": \"40002\", \"name\": \"Sales Discount\", \"type\": \"income\", \"status\": 1, \"is_debit\": 0, \"parent_id\": 4, \"created_at\": \"2025-09-20T12:12:42.000000Z\", \"updated_at\": \"2025-09-20T12:12:42.000000Z\"}}', '2025-09-20 06:12:42'),
(49, 1, 'Created Chart Of Account', '40003', '{\"data\": {\"id\": 35, \"code\": \"40003\", \"name\": \"Tax Payable\", \"type\": \"income\", \"status\": 1, \"is_debit\": 0, \"parent_id\": 4, \"created_at\": \"2025-09-20T12:12:58.000000Z\", \"updated_at\": \"2025-09-20T12:12:58.000000Z\"}}', '2025-09-20 06:12:58'),
(50, 1, 'Created Chart Of Account', '20003', '{\"data\": {\"id\": 36, \"code\": \"20003\", \"name\": \"Customer Advance\", \"type\": \"liability\", \"status\": 1, \"is_debit\": 0, \"parent_id\": 2, \"created_at\": \"2025-09-20T12:22:18.000000Z\", \"updated_at\": \"2025-09-20T12:22:18.000000Z\"}}', '2025-09-20 06:22:18'),
(51, 1, 'Created Chart Of Account', '10004', '{\"data\": {\"id\": 37, \"code\": \"10004\", \"name\": \"Accounts Receivable\", \"type\": \"asset\", \"status\": 1, \"is_debit\": 1, \"parent_id\": 1, \"created_at\": \"2025-09-20T12:24:14.000000Z\", \"updated_at\": \"2025-09-20T12:24:14.000000Z\"}}', '2025-09-20 06:24:14'),
(52, 1, 'Created Chart Of Account', '10005', '{\"data\": {\"id\": 38, \"code\": \"10005\", \"name\": \"Inventory\", \"type\": \"asset\", \"status\": 1, \"is_debit\": 1, \"parent_id\": 1, \"created_at\": \"2025-09-20T12:24:50.000000Z\", \"updated_at\": \"2025-09-20T12:24:50.000000Z\"}}', '2025-09-20 06:24:50'),
(53, 1, 'Created Account Module', '1', '{\"data\": {\"id\": 1, \"status\": 1, \"created_at\": \"2025-09-20T12:58:55.000000Z\", \"entry_type\": \"Sales Voucher\", \"updated_at\": \"2025-09-20T12:58:55.000000Z\", \"description\": \"Account entries for sales invoices\", \"module_name\": \"Inventory\"}, \"module_entry_id\": 1}', '2025-09-20 06:58:55'),
(54, 1, 'Created Chart Of Account', '40002', '{\"data\": {\"id\": 39, \"code\": \"40002\", \"name\": \"Purchase Discount\", \"type\": \"income\", \"status\": 1, \"is_debit\": 0, \"parent_id\": 4, \"created_at\": \"2025-09-20T13:10:14.000000Z\", \"updated_at\": \"2025-09-20T13:10:14.000000Z\"}}', '2025-09-20 07:10:14'),
(55, 1, 'Created Chart Of Account', '10006', '{\"data\": {\"id\": 40, \"code\": \"10006\", \"name\": \"Purchase Tax\", \"type\": \"asset\", \"status\": 1, \"is_debit\": 1, \"parent_id\": 1, \"created_at\": \"2025-09-20T13:10:57.000000Z\", \"updated_at\": \"2025-09-20T13:10:57.000000Z\"}}', '2025-09-20 07:10:57'),
(56, 1, 'Created Account Module', '2', '{\"data\": {\"id\": 2, \"status\": 1, \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"entry_type\": \"Purchase Voucher\", \"updated_at\": \"2025-09-20T13:16:15.000000Z\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"module_entry_id\": 2}', '2025-09-20 07:16:15'),
(57, 1, 'Updated Account Module', '2', '{\"new\": {\"status\": 1, \"accounts\": [{\"component\": \"Inventory\", \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"component\": \"Tax\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"component\": \"Discount\", \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"component\": \"Cash\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"component\": \"Supplier Advance\", \"description\": \"Advance adjusted\", \"account_head_id\": 20}, {\"component\": \"Due\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"entry_type\": \"Purchase Voucher\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"old\": {\"id\": 2, \"status\": 1, \"accounts\": [{\"id\": 9, \"is_debit\": 0, \"component\": \"Inventory\", \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"updated_at\": \"2025-09-20T13:16:15.000000Z\", \"description\": \"Inventory increase\", \"account_head_id\": 38, \"module_entry_id\": 2}, {\"id\": 10, \"is_debit\": 0, \"component\": \"Tax\", \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"updated_at\": \"2025-09-20T13:16:15.000000Z\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40, \"module_entry_id\": 2}, {\"id\": 11, \"is_debit\": 0, \"component\": \"Discount\", \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"updated_at\": \"2025-09-20T13:16:15.000000Z\", \"description\": \"Purchase discount\", \"account_head_id\": 39, \"module_entry_id\": 2}, {\"id\": 12, \"is_debit\": 0, \"component\": \"Cash\", \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"updated_at\": \"2025-09-20T13:16:15.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 2}, {\"id\": 13, \"is_debit\": 0, \"component\": \"Supplier Advance\", \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"updated_at\": \"2025-09-20T13:16:15.000000Z\", \"description\": \"Advance adjusted\", \"account_head_id\": 20, \"module_entry_id\": 2}, {\"id\": 14, \"is_debit\": 0, \"component\": \"Due\", \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"updated_at\": \"2025-09-20T13:16:15.000000Z\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8, \"module_entry_id\": 2}], \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"entry_type\": \"Purchase Voucher\", \"updated_at\": \"2025-09-20T13:16:15.000000Z\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"module_entry_id\": 2}', '2025-09-21 07:18:09'),
(58, 1, 'Updated Account Module', '2', '{\"new\": {\"status\": 1, \"accounts\": [{\"component\": \"Inventory\", \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"component\": \"Tax\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"component\": \"Discount\", \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"component\": \"Cash\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"component\": \"Supplier Advance\", \"description\": \"Advance adjusted\", \"account_head_id\": 20}, {\"component\": \"Due\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"entry_type\": \"Purchase Voucher\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"old\": {\"id\": 2, \"status\": 1, \"accounts\": [{\"id\": 15, \"is_debit\": 0, \"component\": \"Inventory\", \"created_at\": \"2025-09-21T13:18:09.000000Z\", \"updated_at\": \"2025-09-21T13:18:09.000000Z\", \"description\": \"Inventory increase\", \"account_head_id\": 38, \"module_entry_id\": 2}, {\"id\": 16, \"is_debit\": 0, \"component\": \"Tax\", \"created_at\": \"2025-09-21T13:18:09.000000Z\", \"updated_at\": \"2025-09-21T13:18:09.000000Z\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40, \"module_entry_id\": 2}, {\"id\": 17, \"is_debit\": 0, \"component\": \"Discount\", \"created_at\": \"2025-09-21T13:18:09.000000Z\", \"updated_at\": \"2025-09-21T13:18:09.000000Z\", \"description\": \"Purchase discount\", \"account_head_id\": 39, \"module_entry_id\": 2}, {\"id\": 18, \"is_debit\": 0, \"component\": \"Cash\", \"created_at\": \"2025-09-21T13:18:09.000000Z\", \"updated_at\": \"2025-09-21T13:18:09.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 2}, {\"id\": 19, \"is_debit\": 0, \"component\": \"Supplier Advance\", \"created_at\": \"2025-09-21T13:18:09.000000Z\", \"updated_at\": \"2025-09-21T13:18:09.000000Z\", \"description\": \"Advance adjusted\", \"account_head_id\": 20, \"module_entry_id\": 2}, {\"id\": 20, \"is_debit\": 0, \"component\": \"Due\", \"created_at\": \"2025-09-21T13:18:09.000000Z\", \"updated_at\": \"2025-09-21T13:18:09.000000Z\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8, \"module_entry_id\": 2}], \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"entry_type\": \"Purchase Voucher\", \"updated_at\": \"2025-09-20T13:16:15.000000Z\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"module_entry_id\": 2}', '2025-09-21 07:18:19'),
(59, 1, 'Updated Account Module', '2', '{\"new\": {\"status\": 1, \"accounts\": [{\"component\": \"Inventory\", \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"component\": \"Tax\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"component\": \"Discount\", \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"component\": \"Cash\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"component\": \"Supplier Advance\", \"description\": \"Advance adjusted\", \"account_head_id\": 20}, {\"component\": \"Due\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"entry_type\": \"Purchase Voucher\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"old\": {\"id\": 2, \"status\": 1, \"accounts\": [{\"id\": 21, \"is_debit\": 0, \"component\": \"Inventory\", \"created_at\": \"2025-09-21T13:18:19.000000Z\", \"updated_at\": \"2025-09-21T13:18:19.000000Z\", \"description\": \"Inventory increase\", \"account_head_id\": 38, \"module_entry_id\": 2}, {\"id\": 22, \"is_debit\": 0, \"component\": \"Tax\", \"created_at\": \"2025-09-21T13:18:19.000000Z\", \"updated_at\": \"2025-09-21T13:18:19.000000Z\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40, \"module_entry_id\": 2}, {\"id\": 23, \"is_debit\": 0, \"component\": \"Discount\", \"created_at\": \"2025-09-21T13:18:19.000000Z\", \"updated_at\": \"2025-09-21T13:18:19.000000Z\", \"description\": \"Purchase discount\", \"account_head_id\": 39, \"module_entry_id\": 2}, {\"id\": 24, \"is_debit\": 0, \"component\": \"Cash\", \"created_at\": \"2025-09-21T13:18:19.000000Z\", \"updated_at\": \"2025-09-21T13:18:19.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 2}, {\"id\": 25, \"is_debit\": 0, \"component\": \"Supplier Advance\", \"created_at\": \"2025-09-21T13:18:19.000000Z\", \"updated_at\": \"2025-09-21T13:18:19.000000Z\", \"description\": \"Advance adjusted\", \"account_head_id\": 20, \"module_entry_id\": 2}, {\"id\": 26, \"is_debit\": 0, \"component\": \"Due\", \"created_at\": \"2025-09-21T13:18:19.000000Z\", \"updated_at\": \"2025-09-21T13:18:19.000000Z\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8, \"module_entry_id\": 2}], \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"entry_type\": \"Purchase Voucher\", \"updated_at\": \"2025-09-20T13:16:15.000000Z\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"module_entry_id\": 2}', '2025-09-21 07:19:18'),
(60, 1, 'Updated Account Module', '2', '{\"new\": {\"status\": 1, \"accounts\": [{\"is_debit\": \"1\", \"component\": \"Inventory\", \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"is_debit\": 0, \"component\": \"Tax\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"is_debit\": 0, \"component\": \"Discount\", \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"is_debit\": 0, \"component\": \"Cash\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"is_debit\": 0, \"component\": \"Supplier Advance\", \"description\": \"Advance adjusted\", \"account_head_id\": 20}, {\"is_debit\": 0, \"component\": \"Due\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"entry_type\": \"Purchase Voucher\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"old\": {\"id\": 2, \"status\": 1, \"accounts\": [{\"id\": 27, \"is_debit\": 0, \"component\": \"Inventory\", \"created_at\": \"2025-09-21T13:19:18.000000Z\", \"updated_at\": \"2025-09-21T13:19:18.000000Z\", \"description\": \"Inventory increase\", \"account_head_id\": 38, \"module_entry_id\": 2}, {\"id\": 28, \"is_debit\": 0, \"component\": \"Tax\", \"created_at\": \"2025-09-21T13:19:18.000000Z\", \"updated_at\": \"2025-09-21T13:19:18.000000Z\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40, \"module_entry_id\": 2}, {\"id\": 29, \"is_debit\": 0, \"component\": \"Discount\", \"created_at\": \"2025-09-21T13:19:18.000000Z\", \"updated_at\": \"2025-09-21T13:19:18.000000Z\", \"description\": \"Purchase discount\", \"account_head_id\": 39, \"module_entry_id\": 2}, {\"id\": 30, \"is_debit\": 0, \"component\": \"Cash\", \"created_at\": \"2025-09-21T13:19:18.000000Z\", \"updated_at\": \"2025-09-21T13:19:18.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 2}, {\"id\": 31, \"is_debit\": 0, \"component\": \"Supplier Advance\", \"created_at\": \"2025-09-21T13:19:18.000000Z\", \"updated_at\": \"2025-09-21T13:19:18.000000Z\", \"description\": \"Advance adjusted\", \"account_head_id\": 20, \"module_entry_id\": 2}, {\"id\": 32, \"is_debit\": 0, \"component\": \"Due\", \"created_at\": \"2025-09-21T13:19:18.000000Z\", \"updated_at\": \"2025-09-21T13:19:18.000000Z\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8, \"module_entry_id\": 2}], \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"entry_type\": \"Purchase Voucher\", \"updated_at\": \"2025-09-20T13:16:15.000000Z\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"module_entry_id\": 2}', '2025-09-21 07:20:32'),
(61, 1, 'Created Account Module', '5', '{\"data\": {\"id\": 5, \"status\": 1, \"created_at\": \"2025-09-22T04:47:45.000000Z\", \"entry_type\": \"Payment Voucher\", \"updated_at\": \"2025-09-22T04:47:45.000000Z\", \"description\": \"Supplier Advance\", \"module_name\": \"Supplier Advance\"}, \"module_entry_id\": 5}', '2025-09-21 22:47:45'),
(62, 1, 'Updated Account Module', '5', '{\"new\": {\"status\": 1, \"accounts\": [{\"is_debit\": false, \"component\": \"Cash\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"is_debit\": 0, \"component\": \"Supplier Advance\", \"description\": \"Supplier Advance\", \"account_head_id\": 20}], \"entry_type\": \"Payment Voucher\", \"description\": \"Supplier Advance\", \"module_name\": \"Supplier Advance\"}, \"old\": {\"id\": 5, \"status\": 1, \"accounts\": [{\"id\": 39, \"is_debit\": 1, \"component\": \"Cash\", \"created_at\": \"2025-09-22T04:47:45.000000Z\", \"updated_at\": \"2025-09-22T04:47:45.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 5}, {\"id\": 40, \"is_debit\": 0, \"component\": \"Supplier Advance\", \"created_at\": \"2025-09-22T04:47:45.000000Z\", \"updated_at\": \"2025-09-22T04:47:45.000000Z\", \"description\": \"Supplier Advance\", \"account_head_id\": 20, \"module_entry_id\": 5}], \"created_at\": \"2025-09-22T04:47:45.000000Z\", \"entry_type\": \"Payment Voucher\", \"updated_at\": \"2025-09-22T04:47:45.000000Z\", \"description\": \"Supplier Advance\", \"module_name\": \"Supplier Advance\"}, \"module_entry_id\": 5}', '2025-09-21 22:48:06'),
(63, 1, 'Updated Account Module', '5', '{\"new\": {\"status\": 1, \"accounts\": [{\"is_debit\": \"1\", \"component\": \"Cash\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"is_debit\": 0, \"component\": \"Supplier Advance\", \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"entry_type\": \"automatic\", \"description\": \"Advance given to supplier\", \"module_name\": \"Supplier Advance\"}, \"old\": {\"id\": 5, \"status\": 1, \"accounts\": [{\"id\": 41, \"is_debit\": 0, \"component\": \"Cash\", \"created_at\": \"2025-09-22T04:48:06.000000Z\", \"updated_at\": \"2025-09-22T04:48:06.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 5}, {\"id\": 42, \"is_debit\": 0, \"component\": \"Supplier Advance\", \"created_at\": \"2025-09-22T04:48:06.000000Z\", \"updated_at\": \"2025-09-22T04:48:06.000000Z\", \"description\": \"Supplier Advance\", \"account_head_id\": 20, \"module_entry_id\": 5}], \"created_at\": \"2025-09-22T04:47:45.000000Z\", \"entry_type\": \"Payment Voucher\", \"updated_at\": \"2025-09-22T04:47:45.000000Z\", \"description\": \"Supplier Advance\", \"module_name\": \"Supplier Advance\"}, \"module_entry_id\": 5}', '2025-09-22 02:49:17'),
(64, 1, 'Updated Account Module', '5', '{\"new\": {\"status\": 1, \"accounts\": [{\"is_debit\": 1, \"component\": \"Cash\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"is_debit\": 0, \"component\": \"Supplier Advance\", \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"entry_type\": \"supplier_ledger\", \"description\": \"Advance given to supplier\", \"module_name\": \"Supplier Advance\"}, \"old\": {\"id\": 5, \"status\": 1, \"accounts\": [{\"id\": 43, \"is_debit\": 1, \"component\": \"Cash\", \"created_at\": \"2025-09-22T08:49:17.000000Z\", \"updated_at\": \"2025-09-22T08:49:17.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 5}, {\"id\": 44, \"is_debit\": 0, \"component\": \"Supplier Advance\", \"created_at\": \"2025-09-22T08:49:17.000000Z\", \"updated_at\": \"2025-09-22T08:49:17.000000Z\", \"description\": \"Supplier account credited\", \"account_head_id\": 20, \"module_entry_id\": 5}], \"created_at\": \"2025-09-22T04:47:45.000000Z\", \"entry_type\": \"automatic\", \"updated_at\": \"2025-09-22T08:49:17.000000Z\", \"description\": \"Advance given to supplier\", \"module_name\": \"Supplier Advance\"}, \"module_entry_id\": 5}', '2025-09-22 03:54:24'),
(65, 1, 'Updated Account Module', '5', '{\"new\": {\"status\": 1, \"accounts\": [{\"is_debit\": 1, \"component\": \"Cash\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"is_debit\": 0, \"component\": \"Supplier Advance\", \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"entry_type\": \"supplier_ledger\", \"description\": \"Advance given to supplier\", \"module_name\": \"Supplier Advance\"}, \"old\": {\"id\": 5, \"status\": 1, \"accounts\": [{\"id\": 45, \"is_debit\": 1, \"component\": \"Cash\", \"created_at\": \"2025-09-22T09:54:24.000000Z\", \"updated_at\": \"2025-09-22T09:54:24.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 5}, {\"id\": 46, \"is_debit\": 0, \"component\": \"Supplier Advance\", \"created_at\": \"2025-09-22T09:54:24.000000Z\", \"updated_at\": \"2025-09-22T09:54:24.000000Z\", \"description\": \"Supplier account credited\", \"account_head_id\": 20, \"module_entry_id\": 5}], \"created_at\": \"2025-09-22T04:47:45.000000Z\", \"entry_type\": \"supplier_ledger\", \"updated_at\": \"2025-09-22T09:54:24.000000Z\", \"description\": \"Advance given to supplier\", \"module_name\": \"Supplier Advance\"}, \"module_entry_id\": 5}', '2025-09-22 03:56:55'),
(66, 1, 'Updated Account Module', '5', '{\"new\": {\"status\": 1, \"accounts\": [{\"is_debit\": 1, \"component\": \"amount\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"is_debit\": 0, \"component\": \"amount\", \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"entry_type\": \"supplier_ledger\", \"description\": \"Advance given to supplier\", \"module_name\": \"Supplier Advance\"}, \"old\": {\"id\": 5, \"status\": 1, \"accounts\": [{\"id\": 47, \"is_debit\": 1, \"component\": \"Cash\", \"created_at\": \"2025-09-22T09:56:55.000000Z\", \"updated_at\": \"2025-09-22T09:56:55.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 5}, {\"id\": 48, \"is_debit\": 0, \"component\": \"Supplier Advance\", \"created_at\": \"2025-09-22T09:56:55.000000Z\", \"updated_at\": \"2025-09-22T09:56:55.000000Z\", \"description\": \"Supplier account credited\", \"account_head_id\": 20, \"module_entry_id\": 5}], \"created_at\": \"2025-09-22T04:47:45.000000Z\", \"entry_type\": \"supplier_ledger\", \"updated_at\": \"2025-09-22T09:54:24.000000Z\", \"description\": \"Advance given to supplier\", \"module_name\": \"Supplier Advance\"}, \"module_entry_id\": 5}', '2025-09-22 04:04:48'),
(67, 1, 'Created Supplier_advance Entry', 'REF-000003', '{\"data\": {\"id\": 3, \"date\": \"2025-09-22\", \"debit\": 5000, \"lines\": [{\"debit\": 5000, \"credit\": 0, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 5000, \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"credit\": 5000, \"module\": \"Supplier Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000003\", \"source_id\": 8, \"created_at\": \"2025-09-22T10:14:24.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-22T10:14:24.000000Z\", \"voucher_no\": \"SA-000001\", \"source_type\": \"supplier_ledger\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 3}', '2025-09-22 04:14:24'),
(68, 1, 'Updated Account Module', '5', '{\"new\": {\"status\": 1, \"accounts\": [{\"is_debit\": 1, \"component\": \"amount\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"is_debit\": 0, \"component\": \"amount\", \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"entry_type\": \"Supplier Advance\", \"description\": \"Advance given to supplier\", \"module_name\": \"Supplier Advance\"}, \"old\": {\"id\": 5, \"status\": 1, \"accounts\": [{\"id\": 49, \"is_debit\": 1, \"component\": \"amount\", \"created_at\": \"2025-09-22T10:04:48.000000Z\", \"updated_at\": \"2025-09-22T10:04:48.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 5}, {\"id\": 50, \"is_debit\": 0, \"component\": \"amount\", \"created_at\": \"2025-09-22T10:04:48.000000Z\", \"updated_at\": \"2025-09-22T10:04:48.000000Z\", \"description\": \"Supplier account credited\", \"account_head_id\": 20, \"module_entry_id\": 5}], \"created_at\": \"2025-09-22T04:47:45.000000Z\", \"entry_type\": \"supplier_ledger\", \"updated_at\": \"2025-09-22T09:54:24.000000Z\", \"description\": \"Advance given to supplier\", \"module_name\": \"Supplier Advance\"}, \"module_entry_id\": 5}', '2025-09-22 04:16:56'),
(69, 1, 'Created Journal Voucher Entry', 'REF-000001', '{\"data\": {\"id\": 4, \"date\": \"2025-09-22\", \"debit\": 50000, \"lines\": [{\"debit\": \"50000\", \"credit\": 0, \"account_head_id\": 6}, {\"debit\": 0, \"credit\": \"50000\", \"account_head_id\": 9}], \"credit\": 50000, \"module\": null, \"status\": 1, \"branch_id\": null, \"narration\": null, \"reference\": \"REF-000001\", \"source_id\": null, \"created_at\": \"2025-09-22T10:25:37.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-22T10:25:37.000000Z\", \"voucher_no\": \"JV-000001\", \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"journal_entry_id\": 4}', '2025-09-22 04:25:37'),
(70, 1, 'Created Supplier_advance Entry', 'REF-000002', '{\"data\": {\"id\": 5, \"date\": \"2025-09-22\", \"debit\": 5000, \"lines\": [{\"debit\": 5000, \"credit\": 0, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 5000, \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"credit\": 5000, \"module\": \"Supplier Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000002\", \"source_id\": 1, \"created_at\": \"2025-09-22T10:26:57.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-22T10:26:57.000000Z\", \"voucher_no\": \"SA-000001\", \"source_type\": \"Supplier Advance\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 5}', '2025-09-22 04:26:57'),
(71, 1, 'Updated Account Module', '5', '{\"new\": {\"status\": 1, \"accounts\": [{\"is_debit\": false, \"component\": \"amount\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"is_debit\": \"1\", \"component\": \"amount\", \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"entry_type\": \"Supplier Advance\", \"description\": \"Advance given to supplier\", \"module_name\": \"Supplier Advance\"}, \"old\": {\"id\": 5, \"status\": 1, \"accounts\": [{\"id\": 51, \"is_debit\": 1, \"component\": \"amount\", \"created_at\": \"2025-09-22T10:16:56.000000Z\", \"updated_at\": \"2025-09-22T10:16:56.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 5}, {\"id\": 52, \"is_debit\": 0, \"component\": \"amount\", \"created_at\": \"2025-09-22T10:16:56.000000Z\", \"updated_at\": \"2025-09-22T10:16:56.000000Z\", \"description\": \"Supplier account credited\", \"account_head_id\": 20, \"module_entry_id\": 5}], \"created_at\": \"2025-09-22T04:47:45.000000Z\", \"entry_type\": \"Supplier Advance\", \"updated_at\": \"2025-09-22T10:16:56.000000Z\", \"description\": \"Advance given to supplier\", \"module_name\": \"Supplier Advance\"}, \"module_entry_id\": 5}', '2025-09-22 04:28:07'),
(72, 1, 'Created Supplier_advance Entry', 'REF-000003', '{\"data\": {\"id\": 6, \"date\": \"2025-09-22\", \"debit\": 5000, \"lines\": [{\"debit\": 0, \"credit\": 5000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 5000, \"credit\": 0, \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"credit\": 5000, \"module\": \"Supplier Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000003\", \"source_id\": 1, \"created_at\": \"2025-09-22T10:28:12.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-22T10:28:12.000000Z\", \"voucher_no\": \"SA-000002\", \"source_type\": \"Supplier Advance\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 6}', '2025-09-22 04:28:12'),
(73, 1, 'Created Supplier_advance Entry', 'REF-000002', '{\"data\": {\"id\": 7, \"date\": \"2025-09-22\", \"debit\": 5000, \"lines\": [{\"debit\": 0, \"credit\": 5000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 5000, \"credit\": 0, \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"credit\": 5000, \"module\": \"Supplier Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000002\", \"source_id\": 1, \"created_at\": \"2025-09-22T11:01:34.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-22T11:01:34.000000Z\", \"voucher_no\": \"SA-000001\", \"source_type\": \"Supplier Advance\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 7}', '2025-09-22 05:01:34'),
(74, 1, 'Deleted Supplier_advance Entry', 'REF-000002', '{\"data\": {\"id\": 7, \"date\": \"2025-09-22\", \"debit\": \"5000.00\", \"lines\": [{\"id\": 7, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-09-22T11:01:34.000000Z\", \"updated_at\": \"2025-09-22T11:01:34.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 7}, {\"id\": 8, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-22T11:01:34.000000Z\", \"updated_at\": \"2025-09-22T11:01:34.000000Z\", \"account_head_id\": 20, \"journal_entry_id\": 7}], \"credit\": \"5000.00\", \"module\": \"Supplier Advance\", \"status\": \"pending\", \"details\": [{\"id\": 7, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-09-22T11:01:34.000000Z\", \"updated_at\": \"2025-09-22T11:01:34.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 7}, {\"id\": 8, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-22T11:01:34.000000Z\", \"updated_at\": \"2025-09-22T11:01:34.000000Z\", \"account_head_id\": 20, \"journal_entry_id\": 7}], \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000002\", \"source_id\": 1, \"created_at\": \"2025-09-22T11:01:34.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-22T11:01:34.000000Z\", \"voucher_no\": \"SA-000001\", \"approved_by\": null, \"source_type\": \"Supplier Advance\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 7}', '2025-09-22 22:32:35'),
(75, 1, 'Created Supplier_advance Entry', 'REF-000002', '{\"data\": {\"id\": 8, \"date\": \"2025-09-23\", \"debit\": 5000, \"lines\": [{\"debit\": 0, \"credit\": 5000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 5000, \"credit\": 0, \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"credit\": 5000, \"module\": \"Supplier Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000002\", \"source_id\": 1, \"created_at\": \"2025-09-23T04:35:12.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T04:35:12.000000Z\", \"voucher_no\": \"SA-000001\", \"source_type\": \"Supplier Advance\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 8}', '2025-09-22 22:35:12'),
(76, 1, 'Deleted Supplier_advance Entry', 'REF-000002', '{\"data\": {\"id\": 8, \"date\": \"2025-09-23\", \"debit\": \"5000.00\", \"lines\": [{\"id\": 9, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T04:35:12.000000Z\", \"updated_at\": \"2025-09-23T04:35:12.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 8}, {\"id\": 10, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T04:35:12.000000Z\", \"updated_at\": \"2025-09-23T04:35:12.000000Z\", \"account_head_id\": 20, \"journal_entry_id\": 8}], \"credit\": \"5000.00\", \"module\": \"Supplier Advance\", \"status\": \"pending\", \"details\": [{\"id\": 9, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T04:35:12.000000Z\", \"updated_at\": \"2025-09-23T04:35:12.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 8}, {\"id\": 10, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T04:35:12.000000Z\", \"updated_at\": \"2025-09-23T04:35:12.000000Z\", \"account_head_id\": 20, \"journal_entry_id\": 8}], \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000002\", \"source_id\": 1, \"created_at\": \"2025-09-23T04:35:12.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T04:35:12.000000Z\", \"voucher_no\": \"SA-000001\", \"approved_by\": null, \"source_type\": \"Supplier Advance\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 8}', '2025-09-22 22:42:21'),
(77, 1, 'Created Supplier_advance Entry', 'REF-000002', '{\"data\": {\"id\": 9, \"date\": \"2025-09-23\", \"debit\": 10000, \"lines\": [{\"debit\": 0, \"credit\": 10000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 10000, \"credit\": 0, \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"credit\": 10000, \"module\": \"Supplier Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000002\", \"source_id\": 2, \"created_at\": \"2025-09-23T04:42:21.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T04:42:21.000000Z\", \"voucher_no\": \"SA-000001\", \"source_type\": \"Supplier Advance\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 9}', '2025-09-22 22:42:21'),
(78, 1, 'Created Supplier_advance Entry', 'REF-000003', '{\"data\": {\"id\": 10, \"date\": \"2025-09-23\", \"debit\": 5000, \"lines\": [{\"debit\": 0, \"credit\": 5000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 5000, \"credit\": 0, \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"credit\": 5000, \"module\": \"Supplier Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000003\", \"source_id\": 3, \"created_at\": \"2025-09-23T04:42:57.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T04:42:57.000000Z\", \"voucher_no\": \"SA-000002\", \"source_type\": \"Supplier Advance\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 10}', '2025-09-22 22:42:57'),
(79, 1, 'Created Supplier_advance Entry', 'REF-000004', '{\"data\": {\"id\": 11, \"date\": \"2025-09-23\", \"debit\": 5000, \"lines\": [{\"debit\": 0, \"credit\": 5000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 5000, \"credit\": 0, \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"credit\": 5000, \"module\": \"Supplier Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000004\", \"source_id\": 4, \"created_at\": \"2025-09-23T04:43:21.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T04:43:21.000000Z\", \"voucher_no\": \"SA-000003\", \"source_type\": \"Supplier Advance\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 11}', '2025-09-22 22:43:21'),
(80, 1, 'Created Supplier_advance Entry', 'REF-000002', '{\"data\": {\"id\": 12, \"date\": \"2025-09-23\", \"debit\": 5000, \"lines\": [{\"debit\": 0, \"credit\": 5000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 5000, \"credit\": 0, \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"credit\": 5000, \"module\": \"Supplier Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000002\", \"source_id\": 1, \"created_at\": \"2025-09-23T04:51:28.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T04:51:28.000000Z\", \"voucher_no\": \"SA-000001\", \"source_type\": \"Supplier Advance\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 12}', '2025-09-22 22:51:28'),
(81, 1, 'Deleted Supplier_advance Entry', 'REF-000002', '{\"data\": {\"id\": 12, \"date\": \"2025-09-23\", \"debit\": \"5000.00\", \"lines\": [{\"id\": 17, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T04:51:28.000000Z\", \"updated_at\": \"2025-09-23T04:51:28.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 12}, {\"id\": 18, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T04:51:28.000000Z\", \"updated_at\": \"2025-09-23T04:51:28.000000Z\", \"account_head_id\": 20, \"journal_entry_id\": 12}], \"credit\": \"5000.00\", \"module\": \"Supplier Advance\", \"status\": \"pending\", \"details\": [{\"id\": 17, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T04:51:28.000000Z\", \"updated_at\": \"2025-09-23T04:51:28.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 12}, {\"id\": 18, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T04:51:28.000000Z\", \"updated_at\": \"2025-09-23T04:51:28.000000Z\", \"account_head_id\": 20, \"journal_entry_id\": 12}], \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000002\", \"source_id\": 1, \"created_at\": \"2025-09-23T04:51:28.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T04:51:28.000000Z\", \"voucher_no\": \"SA-000001\", \"approved_by\": null, \"source_type\": \"Supplier Advance\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 12}', '2025-09-22 22:55:49');
INSERT INTO `acc_audit_logs` (`id`, `user_id`, `action`, `source_ref`, `details`, `created_at`) VALUES
(82, 1, 'Created Supplier_advance Entry', 'REF-000002', '{\"data\": {\"id\": 13, \"date\": \"2025-09-23\", \"debit\": 10000, \"lines\": [{\"debit\": 0, \"credit\": 10000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 10000, \"credit\": 0, \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"credit\": 10000, \"module\": \"Supplier Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000002\", \"source_id\": 1, \"created_at\": \"2025-09-23T04:55:49.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T04:55:49.000000Z\", \"voucher_no\": \"SA-000001\", \"source_type\": \"Supplier Advance\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 13}', '2025-09-22 22:55:49'),
(83, 1, 'Deleted Supplier_advance Entry', 'REF-000002', '{\"data\": {\"id\": 13, \"date\": \"2025-09-23\", \"debit\": \"10000.00\", \"lines\": [{\"id\": 19, \"debit\": \"0.00\", \"credit\": \"10000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T04:55:49.000000Z\", \"updated_at\": \"2025-09-23T04:55:49.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 13}, {\"id\": 20, \"debit\": \"10000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T04:55:49.000000Z\", \"updated_at\": \"2025-09-23T04:55:49.000000Z\", \"account_head_id\": 20, \"journal_entry_id\": 13}], \"credit\": \"10000.00\", \"module\": \"Supplier Advance\", \"status\": \"pending\", \"details\": [{\"id\": 19, \"debit\": \"0.00\", \"credit\": \"10000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T04:55:49.000000Z\", \"updated_at\": \"2025-09-23T04:55:49.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 13}, {\"id\": 20, \"debit\": \"10000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T04:55:49.000000Z\", \"updated_at\": \"2025-09-23T04:55:49.000000Z\", \"account_head_id\": 20, \"journal_entry_id\": 13}], \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000002\", \"source_id\": 1, \"created_at\": \"2025-09-23T04:55:49.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T04:55:49.000000Z\", \"voucher_no\": \"SA-000001\", \"approved_by\": null, \"source_type\": \"Supplier Advance\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 13}', '2025-09-22 22:56:09'),
(84, 1, 'Created Supplier_advance Entry', 'REF-000002', '{\"data\": {\"id\": 14, \"date\": \"2025-09-23\", \"debit\": 5000, \"lines\": [{\"debit\": 0, \"credit\": 5000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 5000, \"credit\": 0, \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"credit\": 5000, \"module\": \"Supplier Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000002\", \"source_id\": 1, \"created_at\": \"2025-09-23T04:56:09.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T04:56:09.000000Z\", \"voucher_no\": \"SA-000001\", \"source_type\": \"Supplier Advance\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 14}', '2025-09-22 22:56:09'),
(85, 1, 'Created Chart Of Account', '30002', '{\"data\": {\"id\": 41, \"code\": \"30002\", \"name\": \"Opening Balance Adjustment\", \"type\": \"equity\", \"status\": 1, \"is_debit\": 0, \"parent_id\": 3, \"created_at\": \"2025-09-23T05:10:27.000000Z\", \"updated_at\": \"2025-09-23T05:10:27.000000Z\"}}', '2025-09-22 23:10:27'),
(86, 1, 'Created Account Module', '6', '{\"data\": {\"id\": 6, \"status\": 1, \"created_at\": \"2025-09-23T05:18:35.000000Z\", \"entry_type\": \"Supplier Previous Due\", \"updated_at\": \"2025-09-23T05:18:35.000000Z\", \"description\": \"Supplier Previous Due\", \"module_name\": \"Supplier Previous Due\"}, \"module_entry_id\": 6}', '2025-09-22 23:18:35'),
(87, 1, 'Deleted Supplier_advance Entry', 'REF-000002', '{\"data\": {\"id\": 14, \"date\": \"2025-09-23\", \"debit\": \"5000.00\", \"lines\": [{\"id\": 21, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T04:56:09.000000Z\", \"updated_at\": \"2025-09-23T04:56:09.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 14}, {\"id\": 22, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T04:56:09.000000Z\", \"updated_at\": \"2025-09-23T04:56:09.000000Z\", \"account_head_id\": 20, \"journal_entry_id\": 14}], \"credit\": \"5000.00\", \"module\": \"Supplier Advance\", \"status\": \"pending\", \"details\": [{\"id\": 21, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T04:56:09.000000Z\", \"updated_at\": \"2025-09-23T04:56:09.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 14}, {\"id\": 22, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T04:56:09.000000Z\", \"updated_at\": \"2025-09-23T04:56:09.000000Z\", \"account_head_id\": 20, \"journal_entry_id\": 14}], \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000002\", \"source_id\": 1, \"created_at\": \"2025-09-23T04:56:09.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T04:56:09.000000Z\", \"voucher_no\": \"SA-000001\", \"approved_by\": null, \"source_type\": \"Supplier Advance\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 14}', '2025-09-22 23:48:54'),
(88, 1, 'Created Supplier_advance Entry', 'REF-000002', '{\"data\": {\"id\": 15, \"date\": \"2025-09-23\", \"debit\": 5000, \"lines\": [{\"debit\": 0, \"credit\": 5000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 5000, \"credit\": 0, \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"credit\": 5000, \"module\": \"Supplier Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000002\", \"source_id\": 1, \"created_at\": \"2025-09-23T05:48:54.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T05:48:54.000000Z\", \"voucher_no\": \"SA-000001\", \"source_type\": \"Supplier Advance\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 15}', '2025-09-22 23:48:54'),
(89, 1, 'Created Supplier_advance Entry', 'REF-000002', '{\"data\": {\"id\": 16, \"date\": \"2025-09-23\", \"debit\": 5000, \"lines\": [{\"debit\": 0, \"credit\": 5000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 5000, \"credit\": 0, \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"credit\": 5000, \"module\": \"Supplier Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Advance Accounting Entry\", \"reference\": \"REF-000002\", \"source_id\": 1, \"created_at\": \"2025-09-23T06:34:38.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T06:34:38.000000Z\", \"voucher_no\": \"SA-000001\", \"source_type\": \"Supplier Advance\", \"voucher_type\": \"supplier_advance\"}, \"journal_entry_id\": 16}', '2025-09-23 00:34:38'),
(90, 1, 'Created Supplier_previous_due Entry', 'REF-000003', '{\"data\": {\"id\": 17, \"date\": \"2025-09-23\", \"debit\": 2000, \"lines\": [{\"debit\": 2000, \"credit\": 0, \"description\": \"Previous Due (Debit)\", \"account_head_id\": 41}, {\"debit\": 0, \"credit\": 2000, \"description\": \"Supplier Liability (Credit)\", \"account_head_id\": 8}], \"credit\": 2000, \"module\": \"Supplier Previous Due\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Previous Due Accounting Entry\", \"reference\": \"REF-000003\", \"source_id\": 1, \"created_at\": \"2025-09-23T06:48:36.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T06:48:36.000000Z\", \"voucher_no\": \"SPD-000001\", \"source_type\": \"Supplier Previous Due\", \"voucher_type\": \"supplier_previous_due\"}, \"journal_entry_id\": 17}', '2025-09-23 00:48:36'),
(91, 1, 'Deleted Supplier_previous_due Entry', 'REF-000003', '{\"data\": {\"id\": 17, \"date\": \"2025-09-23\", \"debit\": \"2000.00\", \"lines\": [{\"id\": 27, \"debit\": \"2000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T06:48:36.000000Z\", \"updated_at\": \"2025-09-23T06:48:36.000000Z\", \"account_head_id\": 41, \"journal_entry_id\": 17}, {\"id\": 28, \"debit\": \"0.00\", \"credit\": \"2000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T06:48:36.000000Z\", \"updated_at\": \"2025-09-23T06:48:36.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 17}], \"credit\": \"2000.00\", \"module\": \"Supplier Previous Due\", \"status\": \"pending\", \"details\": [{\"id\": 27, \"debit\": \"2000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T06:48:36.000000Z\", \"updated_at\": \"2025-09-23T06:48:36.000000Z\", \"account_head_id\": 41, \"journal_entry_id\": 17}, {\"id\": 28, \"debit\": \"0.00\", \"credit\": \"2000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T06:48:36.000000Z\", \"updated_at\": \"2025-09-23T06:48:36.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 17}], \"branch_id\": 1, \"narration\": \"Supplier Previous Due Accounting Entry\", \"reference\": \"REF-000003\", \"source_id\": 1, \"created_at\": \"2025-09-23T06:48:36.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T06:48:36.000000Z\", \"voucher_no\": \"SPD-000001\", \"approved_by\": null, \"source_type\": \"Supplier Previous Due\", \"voucher_type\": \"supplier_previous_due\"}, \"journal_entry_id\": 17}', '2025-09-23 00:52:31'),
(92, 1, 'Created Supplier Previous Due Entry', 'REF-000003', '{\"data\": {\"id\": 18, \"date\": \"2025-09-23\", \"debit\": 1000, \"lines\": [{\"debit\": 1000, \"credit\": 0, \"description\": \"Previous Due (Debit)\", \"account_head_id\": 41}, {\"debit\": 0, \"credit\": 1000, \"description\": \"Supplier Liability (Credit)\", \"account_head_id\": 8}], \"credit\": 1000, \"module\": \"Supplier Previous Due\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Previous Due Accounting Entry\", \"reference\": \"REF-000003\", \"source_id\": 1, \"created_at\": \"2025-09-23T06:52:54.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T06:52:54.000000Z\", \"voucher_no\": \"SPD-000001\", \"source_type\": \"Supplier Previous Due\", \"voucher_type\": \"Supplier Previous Due\"}, \"journal_entry_id\": 18}', '2025-09-23 00:52:54'),
(93, 1, 'Updated Account Module', '6', '{\"new\": {\"status\": 1, \"accounts\": [{\"is_debit\": 1, \"component\": \"amount\", \"description\": \"Previous Due (Debit)\", \"account_head_id\": 41}, {\"is_debit\": 0, \"component\": \"amount\", \"description\": \"Supplier Liability (Credit)\", \"account_head_id\": 8}], \"entry_type\": \"Supplier Previous Due\", \"description\": \"Supplier Previous Due\", \"module_name\": \"Supplier Previous Due\"}, \"old\": {\"id\": 6, \"status\": 1, \"accounts\": [{\"id\": 55, \"is_debit\": 1, \"component\": \"amount\", \"created_at\": \"2025-09-23T05:18:35.000000Z\", \"updated_at\": \"2025-09-23T05:18:35.000000Z\", \"description\": \"Previous Due (Debit)\", \"account_head_id\": 41, \"module_entry_id\": 6}, {\"id\": 56, \"is_debit\": 0, \"component\": \"amount\", \"created_at\": \"2025-09-23T05:18:35.000000Z\", \"updated_at\": \"2025-09-23T05:18:35.000000Z\", \"description\": \"Supplier Liability (Credit)\", \"account_head_id\": 8, \"module_entry_id\": 6}], \"created_at\": \"2025-09-23T05:18:35.000000Z\", \"entry_type\": \"Supplier Previous Due\", \"updated_at\": \"2025-09-23T05:18:35.000000Z\", \"description\": \"Supplier Previous Due\", \"module_name\": \"Supplier Previous Due\"}, \"module_entry_id\": 6}', '2025-09-23 01:14:05'),
(94, 1, 'Updated Journal Voucher Entry', 'REF-000001', '{\"new\": {\"id\": 4, \"date\": \"2025-09-22\", \"debit\": 50000, \"lines\": [{\"debit\": \"50000.00\", \"credit\": \"0.00\", \"account_head_id\": 6}, {\"debit\": \"0.00\", \"credit\": \"50000.00\", \"account_head_id\": 9}], \"credit\": 50000, \"module\": null, \"status\": 1, \"details\": [{\"id\": 1, \"debit\": \"50000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-22T10:25:37.000000Z\", \"updated_at\": \"2025-09-22T10:25:37.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 4}, {\"id\": 2, \"debit\": \"0.00\", \"credit\": \"50000.00\", \"remarks\": null, \"created_at\": \"2025-09-22T10:25:37.000000Z\", \"updated_at\": \"2025-09-22T10:25:37.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 4}], \"branch_id\": null, \"narration\": null, \"reference\": \"REF-000001\", \"source_id\": null, \"created_at\": \"2025-09-22T10:25:37.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T07:44:13.000000Z\", \"voucher_no\": \"JV-000002\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"old\": {\"id\": 4, \"date\": \"2025-09-22\", \"debit\": \"50000.00\", \"lines\": [{\"id\": 1, \"debit\": \"50000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-22T10:25:37.000000Z\", \"updated_at\": \"2025-09-22T10:25:37.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 4}, {\"id\": 2, \"debit\": \"0.00\", \"credit\": \"50000.00\", \"remarks\": null, \"created_at\": \"2025-09-22T10:25:37.000000Z\", \"updated_at\": \"2025-09-22T10:25:37.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 4}], \"credit\": \"50000.00\", \"module\": null, \"status\": \"pending\", \"details\": [{\"id\": 1, \"debit\": \"50000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-22T10:25:37.000000Z\", \"updated_at\": \"2025-09-22T10:25:37.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 4}, {\"id\": 2, \"debit\": \"0.00\", \"credit\": \"50000.00\", \"remarks\": null, \"created_at\": \"2025-09-22T10:25:37.000000Z\", \"updated_at\": \"2025-09-22T10:25:37.000000Z\", \"account_head_id\": 9, \"journal_entry_id\": 4}], \"branch_id\": null, \"narration\": null, \"reference\": \"REF-000001\", \"source_id\": null, \"created_at\": \"2025-09-22T10:25:37.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-22T10:25:37.000000Z\", \"voucher_no\": \"JV-000001\", \"approved_by\": null, \"source_type\": null, \"voucher_type\": \"Journal Voucher\"}, \"journal_entry_id\": 4}', '2025-09-23 01:44:13'),
(95, 1, 'Deleted Supplier Previous Due Entry', 'REF-000003', '{\"data\": {\"id\": 18, \"date\": \"2025-09-23\", \"debit\": \"1000.00\", \"lines\": [{\"id\": 29, \"debit\": \"1000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T06:52:54.000000Z\", \"updated_at\": \"2025-09-23T06:52:54.000000Z\", \"account_head_id\": 41, \"journal_entry_id\": 18}, {\"id\": 30, \"debit\": \"0.00\", \"credit\": \"1000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T06:52:54.000000Z\", \"updated_at\": \"2025-09-23T06:52:54.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 18}], \"credit\": \"1000.00\", \"module\": \"Supplier Previous Due\", \"status\": \"pending\", \"details\": [{\"id\": 29, \"debit\": \"1000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T06:52:54.000000Z\", \"updated_at\": \"2025-09-23T06:52:54.000000Z\", \"account_head_id\": 41, \"journal_entry_id\": 18}, {\"id\": 30, \"debit\": \"0.00\", \"credit\": \"1000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T06:52:54.000000Z\", \"updated_at\": \"2025-09-23T06:52:54.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 18}], \"branch_id\": 1, \"narration\": \"Supplier Previous Due Accounting Entry\", \"reference\": \"REF-000003\", \"source_id\": 1, \"created_at\": \"2025-09-23T06:52:54.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T06:52:54.000000Z\", \"voucher_no\": \"SPD-000001\", \"approved_by\": null, \"source_type\": \"Supplier Previous Due\", \"voucher_type\": \"Supplier Previous Due\"}, \"journal_entry_id\": 18}', '2025-09-23 01:48:48'),
(96, 1, 'Created Supplier Advance Entry', 'REF-000002', '{\"data\": {\"id\": 19, \"date\": \"2025-09-23\", \"debit\": 5000, \"lines\": [{\"debit\": 0, \"credit\": 5000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 5000, \"credit\": 0, \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"credit\": 5000, \"module\": \"Supplier Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Advance\", \"reference\": \"REF-000002\", \"source_id\": 1, \"created_at\": \"2025-09-23T07:50:50.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T07:50:50.000000Z\", \"voucher_no\": \"SA-000001\", \"source_type\": \"Supplier Advance\", \"voucher_type\": \"Supplier Advance\"}, \"journal_entry_id\": 19}', '2025-09-23 01:50:50'),
(97, 1, 'Created Supplier Previous Due Entry', 'REF-000003', '{\"data\": {\"id\": 20, \"date\": \"2025-09-23\", \"debit\": 1000, \"lines\": [{\"debit\": 1000, \"credit\": 0, \"description\": \"Previous Due (Debit)\", \"account_head_id\": 41}, {\"debit\": 0, \"credit\": 1000, \"description\": \"Supplier Liability (Credit)\", \"account_head_id\": 8}], \"credit\": 1000, \"module\": \"Supplier Previous Due\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Previous Due\", \"reference\": \"REF-000003\", \"source_id\": 1, \"created_at\": \"2025-09-23T07:51:40.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T07:51:40.000000Z\", \"voucher_no\": \"SPD-000001\", \"source_type\": \"Supplier Previous Due\", \"voucher_type\": \"Supplier Previous Due\"}, \"journal_entry_id\": 20}', '2025-09-23 01:51:40'),
(98, 1, 'Deleted Supplier Advance Entry', 'REF-000002', '{\"data\": {\"id\": 19, \"date\": \"2025-09-23\", \"debit\": \"5000.00\", \"lines\": [{\"id\": 33, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T07:50:50.000000Z\", \"updated_at\": \"2025-09-23T07:50:50.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 19}, {\"id\": 34, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T07:50:50.000000Z\", \"updated_at\": \"2025-09-23T07:50:50.000000Z\", \"account_head_id\": 20, \"journal_entry_id\": 19}], \"credit\": \"5000.00\", \"module\": \"Supplier Advance\", \"status\": \"pending\", \"details\": [{\"id\": 33, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T07:50:50.000000Z\", \"updated_at\": \"2025-09-23T07:50:50.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 19}, {\"id\": 34, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T07:50:50.000000Z\", \"updated_at\": \"2025-09-23T07:50:50.000000Z\", \"account_head_id\": 20, \"journal_entry_id\": 19}], \"branch_id\": 1, \"narration\": \"Supplier Advance\", \"reference\": \"REF-000002\", \"source_id\": 1, \"created_at\": \"2025-09-23T07:50:50.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T07:50:50.000000Z\", \"voucher_no\": \"SA-000001\", \"approved_by\": null, \"source_type\": \"Supplier Advance\", \"voucher_type\": \"Supplier Advance\"}, \"journal_entry_id\": 19}', '2025-09-23 01:52:16'),
(99, 1, 'Created Supplier Advance Entry', 'REF-000004', '{\"data\": {\"id\": 21, \"date\": \"2025-09-23\", \"debit\": 5000, \"lines\": [{\"debit\": 0, \"credit\": 5000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 5000, \"credit\": 0, \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"credit\": 5000, \"module\": \"Supplier Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Advance\", \"reference\": \"REF-000004\", \"source_id\": 1, \"created_at\": \"2025-09-23T07:52:16.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T07:52:16.000000Z\", \"voucher_no\": \"SA-000001\", \"source_type\": \"Supplier Advance\", \"voucher_type\": \"Supplier Advance\"}, \"journal_entry_id\": 21}', '2025-09-23 01:52:16'),
(100, 1, 'Deleted Supplier Previous Due Entry', 'REF-000003', '{\"data\": {\"id\": 20, \"date\": \"2025-09-23\", \"debit\": \"1000.00\", \"lines\": [{\"id\": 35, \"debit\": \"1000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T07:51:40.000000Z\", \"updated_at\": \"2025-09-23T07:51:40.000000Z\", \"account_head_id\": 41, \"journal_entry_id\": 20}, {\"id\": 36, \"debit\": \"0.00\", \"credit\": \"1000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T07:51:40.000000Z\", \"updated_at\": \"2025-09-23T07:51:40.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 20}], \"credit\": \"1000.00\", \"module\": \"Supplier Previous Due\", \"status\": \"pending\", \"details\": [{\"id\": 35, \"debit\": \"1000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T07:51:40.000000Z\", \"updated_at\": \"2025-09-23T07:51:40.000000Z\", \"account_head_id\": 41, \"journal_entry_id\": 20}, {\"id\": 36, \"debit\": \"0.00\", \"credit\": \"1000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T07:51:40.000000Z\", \"updated_at\": \"2025-09-23T07:51:40.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 20}], \"branch_id\": 1, \"narration\": \"Supplier Previous Due\", \"reference\": \"REF-000003\", \"source_id\": 1, \"created_at\": \"2025-09-23T07:51:40.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T07:51:40.000000Z\", \"voucher_no\": \"SPD-000001\", \"approved_by\": null, \"source_type\": \"Supplier Previous Due\", \"voucher_type\": \"Supplier Previous Due\"}, \"journal_entry_id\": 20}', '2025-09-23 02:44:19'),
(101, 1, 'Created Supplier Previous Due Entry', 'REF-000005', '{\"data\": {\"id\": 22, \"date\": \"2025-09-23\", \"debit\": 1500, \"lines\": [{\"debit\": 1500, \"credit\": 0, \"description\": \"Previous Due (Debit)\", \"account_head_id\": 41}, {\"debit\": 0, \"credit\": 1500, \"description\": \"Supplier Liability (Credit)\", \"account_head_id\": 8}], \"credit\": 1500, \"module\": \"Supplier Previous Due\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Previous Due\", \"reference\": \"REF-000005\", \"source_id\": 1, \"created_at\": \"2025-09-23T08:44:19.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T08:44:19.000000Z\", \"voucher_no\": \"SPD-000001\", \"source_type\": \"Supplier Previous Due\", \"voucher_type\": \"Supplier Previous Due\"}, \"journal_entry_id\": 22}', '2025-09-23 02:44:19'),
(103, 1, 'Deleted Supplier Previous Due Entry', 'REF-000005', '{\"data\": {\"id\": 22, \"date\": \"2025-09-23\", \"debit\": \"1500.00\", \"lines\": [{\"id\": 39, \"debit\": \"1500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T08:44:19.000000Z\", \"updated_at\": \"2025-09-23T08:44:19.000000Z\", \"account_head_id\": 41, \"journal_entry_id\": 22}, {\"id\": 40, \"debit\": \"0.00\", \"credit\": \"1500.00\", \"remarks\": null, \"created_at\": \"2025-09-23T08:44:19.000000Z\", \"updated_at\": \"2025-09-23T08:44:19.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 22}], \"credit\": \"1500.00\", \"module\": \"Supplier Previous Due\", \"status\": \"pending\", \"details\": [{\"id\": 39, \"debit\": \"1500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T08:44:19.000000Z\", \"updated_at\": \"2025-09-23T08:44:19.000000Z\", \"account_head_id\": 41, \"journal_entry_id\": 22}, {\"id\": 40, \"debit\": \"0.00\", \"credit\": \"1500.00\", \"remarks\": null, \"created_at\": \"2025-09-23T08:44:19.000000Z\", \"updated_at\": \"2025-09-23T08:44:19.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 22}], \"branch_id\": 1, \"narration\": \"Supplier Previous Due\", \"reference\": \"REF-000005\", \"source_id\": 1, \"created_at\": \"2025-09-23T08:44:19.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T08:44:19.000000Z\", \"voucher_no\": \"SPD-000001\", \"approved_by\": null, \"source_type\": \"Supplier Previous Due\", \"voucher_type\": \"Supplier Previous Due\"}, \"journal_entry_id\": 22}', '2025-09-23 02:45:19'),
(104, 1, 'Created Supplier Previous Due Entry', 'REF-000005', '{\"data\": {\"id\": 23, \"date\": \"2025-09-23\", \"debit\": 1500, \"lines\": [{\"debit\": 1500, \"credit\": 0, \"description\": \"Previous Due (Debit)\", \"account_head_id\": 41}, {\"debit\": 0, \"credit\": 1500, \"description\": \"Supplier Liability (Credit)\", \"account_head_id\": 8}], \"credit\": 1500, \"module\": \"Supplier Previous Due\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Previous Due\", \"reference\": \"REF-000005\", \"source_id\": 1, \"created_at\": \"2025-09-23T08:46:02.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T08:46:02.000000Z\", \"voucher_no\": \"SPD-000001\", \"source_type\": \"Supplier Previous Due\", \"voucher_type\": \"Supplier Previous Due\"}, \"journal_entry_id\": 23}', '2025-09-23 02:46:02'),
(106, 1, 'Deleted Supplier Previous Due Entry', 'REF-000005', '{\"data\": {\"id\": 23, \"date\": \"2025-09-23\", \"debit\": \"1500.00\", \"lines\": [{\"id\": 41, \"debit\": \"1500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T08:46:02.000000Z\", \"updated_at\": \"2025-09-23T08:46:02.000000Z\", \"account_head_id\": 41, \"journal_entry_id\": 23}, {\"id\": 42, \"debit\": \"0.00\", \"credit\": \"1500.00\", \"remarks\": null, \"created_at\": \"2025-09-23T08:46:02.000000Z\", \"updated_at\": \"2025-09-23T08:46:02.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 23}], \"credit\": \"1500.00\", \"module\": \"Supplier Previous Due\", \"status\": \"pending\", \"details\": [{\"id\": 41, \"debit\": \"1500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T08:46:02.000000Z\", \"updated_at\": \"2025-09-23T08:46:02.000000Z\", \"account_head_id\": 41, \"journal_entry_id\": 23}, {\"id\": 42, \"debit\": \"0.00\", \"credit\": \"1500.00\", \"remarks\": null, \"created_at\": \"2025-09-23T08:46:02.000000Z\", \"updated_at\": \"2025-09-23T08:46:02.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 23}], \"branch_id\": 1, \"narration\": \"Supplier Previous Due\", \"reference\": \"REF-000005\", \"source_id\": 1, \"created_at\": \"2025-09-23T08:46:02.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T08:46:02.000000Z\", \"voucher_no\": \"SPD-000001\", \"approved_by\": null, \"source_type\": \"Supplier Previous Due\", \"voucher_type\": \"Supplier Previous Due\"}, \"journal_entry_id\": 23}', '2025-09-23 02:50:28'),
(107, 1, 'Created Supplier Previous Due Entry', 'REF-000005', '{\"data\": {\"id\": 24, \"date\": \"2025-09-23\", \"debit\": 1500, \"lines\": [{\"debit\": 1500, \"credit\": 0, \"description\": \"Previous Due (Debit)\", \"account_head_id\": 41}, {\"debit\": 0, \"credit\": 1500, \"description\": \"Supplier Liability (Credit)\", \"account_head_id\": 8}], \"credit\": 1500, \"module\": \"Supplier Previous Due\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Previous Due\", \"reference\": \"REF-000005\", \"source_id\": 1, \"created_at\": \"2025-09-23T08:50:51.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T08:50:51.000000Z\", \"voucher_no\": \"SPD-000001\", \"source_type\": \"Supplier Previous Due\", \"voucher_type\": \"Supplier Previous Due\"}, \"journal_entry_id\": 24}', '2025-09-23 02:50:51'),
(108, 1, 'Deleted Supplier Previous Due Entry', 'REF-000005', '{\"data\": {\"id\": 24, \"date\": \"2025-09-23\", \"debit\": \"1500.00\", \"lines\": [{\"id\": 43, \"debit\": \"1500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T08:50:51.000000Z\", \"updated_at\": \"2025-09-23T08:50:51.000000Z\", \"account_head_id\": 41, \"journal_entry_id\": 24}, {\"id\": 44, \"debit\": \"0.00\", \"credit\": \"1500.00\", \"remarks\": null, \"created_at\": \"2025-09-23T08:50:51.000000Z\", \"updated_at\": \"2025-09-23T08:50:51.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 24}], \"credit\": \"1500.00\", \"module\": \"Supplier Previous Due\", \"status\": \"pending\", \"details\": [{\"id\": 43, \"debit\": \"1500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T08:50:51.000000Z\", \"updated_at\": \"2025-09-23T08:50:51.000000Z\", \"account_head_id\": 41, \"journal_entry_id\": 24}, {\"id\": 44, \"debit\": \"0.00\", \"credit\": \"1500.00\", \"remarks\": null, \"created_at\": \"2025-09-23T08:50:51.000000Z\", \"updated_at\": \"2025-09-23T08:50:51.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 24}], \"branch_id\": 1, \"narration\": \"Supplier Previous Due\", \"reference\": \"REF-000005\", \"source_id\": 1, \"created_at\": \"2025-09-23T08:50:51.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T08:50:51.000000Z\", \"voucher_no\": \"SPD-000001\", \"approved_by\": null, \"source_type\": \"Supplier Previous Due\", \"voucher_type\": \"Supplier Previous Due\"}, \"journal_entry_id\": 24}', '2025-09-23 02:50:56'),
(109, 1, 'Created Supplier Previous Due Entry', 'REF-000005', '{\"data\": {\"id\": 25, \"date\": \"2025-09-23\", \"debit\": 1500, \"lines\": [{\"debit\": 1500, \"credit\": 0, \"description\": \"Previous Due (Debit)\", \"account_head_id\": 41}, {\"debit\": 0, \"credit\": 1500, \"description\": \"Supplier Liability (Credit)\", \"account_head_id\": 8}], \"credit\": 1500, \"module\": \"Supplier Previous Due\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Previous Due\", \"reference\": \"REF-000005\", \"source_id\": 1, \"created_at\": \"2025-09-23T08:51:15.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T08:51:15.000000Z\", \"voucher_no\": \"SPD-000001\", \"source_type\": \"Supplier Previous Due\", \"voucher_type\": \"Supplier Previous Due\"}, \"journal_entry_id\": 25}', '2025-09-23 02:51:15'),
(110, 1, 'Created Supplier Advance Entry', 'REF-000006', '{\"data\": {\"id\": 26, \"date\": \"2025-09-23\", \"debit\": 1000, \"lines\": [{\"debit\": 0, \"credit\": 1000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 1000, \"credit\": 0, \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"credit\": 1000, \"module\": \"Supplier Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Advance\", \"reference\": \"REF-000006\", \"source_id\": 2, \"created_at\": \"2025-09-23T10:46:36.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T10:46:36.000000Z\", \"voucher_no\": \"SA-000002\", \"source_type\": \"Supplier Advance\", \"voucher_type\": \"Supplier Advance\"}, \"journal_entry_id\": 26}', '2025-09-23 04:46:36'),
(111, 1, 'Deleted Supplier Advance Entry', 'REF-000006', '{\"data\": {\"id\": 26, \"date\": \"2025-09-23\", \"debit\": \"1000.00\", \"lines\": [{\"id\": 47, \"debit\": \"0.00\", \"credit\": \"1000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T10:46:36.000000Z\", \"updated_at\": \"2025-09-23T10:46:36.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 26}, {\"id\": 48, \"debit\": \"1000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T10:46:36.000000Z\", \"updated_at\": \"2025-09-23T10:46:36.000000Z\", \"account_head_id\": 20, \"journal_entry_id\": 26}], \"credit\": \"1000.00\", \"module\": \"Supplier Advance\", \"status\": \"pending\", \"details\": [{\"id\": 47, \"debit\": \"0.00\", \"credit\": \"1000.00\", \"remarks\": null, \"created_at\": \"2025-09-23T10:46:36.000000Z\", \"updated_at\": \"2025-09-23T10:46:36.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 26}, {\"id\": 48, \"debit\": \"1000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-09-23T10:46:36.000000Z\", \"updated_at\": \"2025-09-23T10:46:36.000000Z\", \"account_head_id\": 20, \"journal_entry_id\": 26}], \"branch_id\": 1, \"narration\": \"Supplier Advance\", \"reference\": \"REF-000006\", \"source_id\": 2, \"created_at\": \"2025-09-23T10:46:36.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T10:46:36.000000Z\", \"voucher_no\": \"SA-000002\", \"approved_by\": null, \"source_type\": \"Supplier Advance\", \"voucher_type\": \"Supplier Advance\"}, \"journal_entry_id\": 26}', '2025-09-23 04:46:45'),
(112, 1, 'Created Supplier Advance Entry', 'REF-000006', '{\"data\": {\"id\": 27, \"date\": \"2025-09-23\", \"debit\": 1000, \"lines\": [{\"debit\": 0, \"credit\": 1000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 1000, \"credit\": 0, \"description\": \"Supplier account credited\", \"account_head_id\": 20}], \"credit\": 1000, \"module\": \"Supplier Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Supplier Advance\", \"reference\": \"REF-000006\", \"source_id\": 3, \"created_at\": \"2025-09-23T10:47:00.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-09-23T10:47:00.000000Z\", \"voucher_no\": \"SA-000002\", \"source_type\": \"Supplier Advance\", \"voucher_type\": \"Supplier Advance\"}, \"journal_entry_id\": 27}', '2025-09-23 04:47:00'),
(113, 1, 'Updated Account Module', '2', '{\"new\": {\"status\": 1, \"accounts\": [{\"is_debit\": 1, \"component\": \"inventory\", \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"is_debit\": 0, \"component\": \"tax\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"is_debit\": 0, \"component\": \"discount\", \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"is_debit\": 0, \"component\": \"cash\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"is_debit\": 0, \"component\": \"supplier_advance\", \"description\": \"Advance adjusted\", \"account_head_id\": 20}, {\"is_debit\": 0, \"component\": \"due\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"entry_type\": \"Purchase Voucher\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"old\": {\"id\": 2, \"status\": 1, \"accounts\": [{\"id\": 33, \"is_debit\": 1, \"component\": \"Inventory\", \"created_at\": \"2025-09-21T13:20:32.000000Z\", \"updated_at\": \"2025-09-21T13:20:32.000000Z\", \"description\": \"Inventory increase\", \"account_head_id\": 38, \"module_entry_id\": 2}, {\"id\": 34, \"is_debit\": 0, \"component\": \"Tax\", \"created_at\": \"2025-09-21T13:20:32.000000Z\", \"updated_at\": \"2025-09-21T13:20:32.000000Z\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40, \"module_entry_id\": 2}, {\"id\": 35, \"is_debit\": 0, \"component\": \"Discount\", \"created_at\": \"2025-09-21T13:20:32.000000Z\", \"updated_at\": \"2025-09-21T13:20:32.000000Z\", \"description\": \"Purchase discount\", \"account_head_id\": 39, \"module_entry_id\": 2}, {\"id\": 36, \"is_debit\": 0, \"component\": \"Cash\", \"created_at\": \"2025-09-21T13:20:32.000000Z\", \"updated_at\": \"2025-09-21T13:20:32.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 2}, {\"id\": 37, \"is_debit\": 0, \"component\": \"Supplier Advance\", \"created_at\": \"2025-09-21T13:20:32.000000Z\", \"updated_at\": \"2025-09-21T13:20:32.000000Z\", \"description\": \"Advance adjusted\", \"account_head_id\": 20, \"module_entry_id\": 2}, {\"id\": 38, \"is_debit\": 0, \"component\": \"Due\", \"created_at\": \"2025-09-21T13:20:32.000000Z\", \"updated_at\": \"2025-09-21T13:20:32.000000Z\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8, \"module_entry_id\": 2}], \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"entry_type\": \"Purchase Voucher\", \"updated_at\": \"2025-09-20T13:16:15.000000Z\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"module_entry_id\": 2}', '2025-10-11 05:33:15'),
(114, 1, 'Updated Account Module', '2', '{\"new\": {\"status\": 1, \"accounts\": [{\"is_debit\": \"1\", \"component\": \"inventory\", \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"is_debit\": \"1\", \"component\": \"tax\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"is_debit\": false, \"component\": \"discount\", \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"is_debit\": 0, \"component\": \"cash\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"is_debit\": \"1\", \"component\": \"supplier_advance\", \"description\": \"Advance adjusted\", \"account_head_id\": 20}, {\"is_debit\": false, \"component\": \"due\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"entry_type\": \"Purchase Voucher\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"old\": {\"id\": 2, \"status\": 1, \"accounts\": [{\"id\": 59, \"is_debit\": 1, \"component\": \"inventory\", \"created_at\": \"2025-10-11T11:33:15.000000Z\", \"updated_at\": \"2025-10-11T11:33:15.000000Z\", \"description\": \"Inventory increase\", \"account_head_id\": 38, \"module_entry_id\": 2}, {\"id\": 60, \"is_debit\": 0, \"component\": \"tax\", \"created_at\": \"2025-10-11T11:33:15.000000Z\", \"updated_at\": \"2025-10-11T11:33:15.000000Z\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40, \"module_entry_id\": 2}, {\"id\": 61, \"is_debit\": 0, \"component\": \"discount\", \"created_at\": \"2025-10-11T11:33:15.000000Z\", \"updated_at\": \"2025-10-11T11:33:15.000000Z\", \"description\": \"Purchase discount\", \"account_head_id\": 39, \"module_entry_id\": 2}, {\"id\": 62, \"is_debit\": 0, \"component\": \"cash\", \"created_at\": \"2025-10-11T11:33:15.000000Z\", \"updated_at\": \"2025-10-11T11:33:15.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 2}, {\"id\": 63, \"is_debit\": 0, \"component\": \"supplier_advance\", \"created_at\": \"2025-10-11T11:33:15.000000Z\", \"updated_at\": \"2025-10-11T11:33:15.000000Z\", \"description\": \"Advance adjusted\", \"account_head_id\": 20, \"module_entry_id\": 2}, {\"id\": 64, \"is_debit\": 0, \"component\": \"due\", \"created_at\": \"2025-10-11T11:33:15.000000Z\", \"updated_at\": \"2025-10-11T11:33:15.000000Z\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8, \"module_entry_id\": 2}], \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"entry_type\": \"Purchase Voucher\", \"updated_at\": \"2025-09-20T13:16:15.000000Z\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"module_entry_id\": 2}', '2025-10-11 05:37:17'),
(115, 1, 'Updated Account Module', '2', '{\"new\": {\"status\": 1, \"accounts\": [{\"is_debit\": 1, \"component\": \"inventory\", \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"is_debit\": 1, \"component\": \"tax\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"is_debit\": \"1\", \"component\": \"discount\", \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"is_debit\": 0, \"component\": \"cash\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"is_debit\": false, \"component\": \"supplier_advance\", \"description\": \"Advance adjusted\", \"account_head_id\": 20}, {\"is_debit\": 0, \"component\": \"due\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"entry_type\": \"Purchase Voucher\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"old\": {\"id\": 2, \"status\": 1, \"accounts\": [{\"id\": 65, \"is_debit\": 1, \"component\": \"inventory\", \"created_at\": \"2025-10-11T11:37:17.000000Z\", \"updated_at\": \"2025-10-11T11:37:17.000000Z\", \"description\": \"Inventory increase\", \"account_head_id\": 38, \"module_entry_id\": 2}, {\"id\": 66, \"is_debit\": 1, \"component\": \"tax\", \"created_at\": \"2025-10-11T11:37:17.000000Z\", \"updated_at\": \"2025-10-11T11:37:17.000000Z\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40, \"module_entry_id\": 2}, {\"id\": 67, \"is_debit\": 0, \"component\": \"discount\", \"created_at\": \"2025-10-11T11:37:17.000000Z\", \"updated_at\": \"2025-10-11T11:37:17.000000Z\", \"description\": \"Purchase discount\", \"account_head_id\": 39, \"module_entry_id\": 2}, {\"id\": 68, \"is_debit\": 0, \"component\": \"cash\", \"created_at\": \"2025-10-11T11:37:17.000000Z\", \"updated_at\": \"2025-10-11T11:37:17.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 2}, {\"id\": 69, \"is_debit\": 1, \"component\": \"supplier_advance\", \"created_at\": \"2025-10-11T11:37:17.000000Z\", \"updated_at\": \"2025-10-11T11:37:17.000000Z\", \"description\": \"Advance adjusted\", \"account_head_id\": 20, \"module_entry_id\": 2}, {\"id\": 70, \"is_debit\": 0, \"component\": \"due\", \"created_at\": \"2025-10-11T11:37:17.000000Z\", \"updated_at\": \"2025-10-11T11:37:17.000000Z\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8, \"module_entry_id\": 2}], \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"entry_type\": \"Purchase Voucher\", \"updated_at\": \"2025-09-20T13:16:15.000000Z\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"module_entry_id\": 2}', '2025-10-11 07:20:00'),
(116, 1, 'Updated Account Module', '2', '{\"new\": {\"status\": 1, \"accounts\": [{\"is_debit\": 1, \"component\": \"inventory\", \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"is_debit\": 1, \"component\": \"tax\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"is_debit\": 1, \"component\": \"discount\", \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"is_debit\": 0, \"component\": \"paid_amount\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"is_debit\": 0, \"component\": \"supplier_advance\", \"description\": \"Advance adjusted\", \"account_head_id\": 20}, {\"is_debit\": 0, \"component\": \"due\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"entry_type\": \"Purchase Voucher\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"old\": {\"id\": 2, \"status\": 1, \"accounts\": [{\"id\": 71, \"is_debit\": 1, \"component\": \"inventory\", \"created_at\": \"2025-10-11T13:20:00.000000Z\", \"updated_at\": \"2025-10-11T13:20:00.000000Z\", \"description\": \"Inventory increase\", \"account_head_id\": 38, \"module_entry_id\": 2}, {\"id\": 72, \"is_debit\": 1, \"component\": \"tax\", \"created_at\": \"2025-10-11T13:20:00.000000Z\", \"updated_at\": \"2025-10-11T13:20:00.000000Z\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40, \"module_entry_id\": 2}, {\"id\": 73, \"is_debit\": 1, \"component\": \"discount\", \"created_at\": \"2025-10-11T13:20:00.000000Z\", \"updated_at\": \"2025-10-11T13:20:00.000000Z\", \"description\": \"Purchase discount\", \"account_head_id\": 39, \"module_entry_id\": 2}, {\"id\": 74, \"is_debit\": 0, \"component\": \"cash\", \"created_at\": \"2025-10-11T13:20:00.000000Z\", \"updated_at\": \"2025-10-11T13:20:00.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 2}, {\"id\": 75, \"is_debit\": 0, \"component\": \"supplier_advance\", \"created_at\": \"2025-10-11T13:20:00.000000Z\", \"updated_at\": \"2025-10-11T13:20:00.000000Z\", \"description\": \"Advance adjusted\", \"account_head_id\": 20, \"module_entry_id\": 2}, {\"id\": 76, \"is_debit\": 0, \"component\": \"due\", \"created_at\": \"2025-10-11T13:20:00.000000Z\", \"updated_at\": \"2025-10-11T13:20:00.000000Z\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8, \"module_entry_id\": 2}], \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"entry_type\": \"Purchase Voucher\", \"updated_at\": \"2025-09-20T13:16:15.000000Z\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"module_entry_id\": 2}', '2025-10-11 22:52:37'),
(117, 1, 'Updated Account Module', '2', '{\"new\": {\"status\": 1, \"accounts\": [{\"is_debit\": 1, \"component\": \"inventory\", \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"is_debit\": 1, \"component\": \"tax_amount\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"is_debit\": 1, \"component\": \"discount_amount\", \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"is_debit\": 0, \"component\": \"paid_amount\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"is_debit\": 0, \"component\": \"supplier_advance\", \"description\": \"Advance adjusted\", \"account_head_id\": 20}, {\"is_debit\": 0, \"component\": \"due_amount\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"entry_type\": \"Purchase Voucher\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"old\": {\"id\": 2, \"status\": 1, \"accounts\": [{\"id\": 77, \"is_debit\": 1, \"component\": \"inventory\", \"created_at\": \"2025-10-12T04:52:37.000000Z\", \"updated_at\": \"2025-10-12T04:52:37.000000Z\", \"description\": \"Inventory increase\", \"account_head_id\": 38, \"module_entry_id\": 2}, {\"id\": 78, \"is_debit\": 1, \"component\": \"tax\", \"created_at\": \"2025-10-12T04:52:37.000000Z\", \"updated_at\": \"2025-10-12T04:52:37.000000Z\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40, \"module_entry_id\": 2}, {\"id\": 79, \"is_debit\": 1, \"component\": \"discount\", \"created_at\": \"2025-10-12T04:52:37.000000Z\", \"updated_at\": \"2025-10-12T04:52:37.000000Z\", \"description\": \"Purchase discount\", \"account_head_id\": 39, \"module_entry_id\": 2}, {\"id\": 80, \"is_debit\": 0, \"component\": \"paid_amount\", \"created_at\": \"2025-10-12T04:52:37.000000Z\", \"updated_at\": \"2025-10-12T04:52:37.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 2}, {\"id\": 81, \"is_debit\": 0, \"component\": \"supplier_advance\", \"created_at\": \"2025-10-12T04:52:37.000000Z\", \"updated_at\": \"2025-10-12T04:52:37.000000Z\", \"description\": \"Advance adjusted\", \"account_head_id\": 20, \"module_entry_id\": 2}, {\"id\": 82, \"is_debit\": 0, \"component\": \"due\", \"created_at\": \"2025-10-12T04:52:37.000000Z\", \"updated_at\": \"2025-10-12T04:52:37.000000Z\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8, \"module_entry_id\": 2}], \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"entry_type\": \"Purchase Voucher\", \"updated_at\": \"2025-09-20T13:16:15.000000Z\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"module_entry_id\": 2}', '2025-10-11 22:55:38'),
(120, 1, 'Created Purchase Entry', 'REF-000007', '{\"data\": {\"id\": 30, \"date\": \"2025-10-12\", \"debit\": 7315, \"lines\": [{\"debit\": 6300, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 665, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 350, \"credit\": 0, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 500, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 6815, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 7315, \"module\": \"Purchase\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase\", \"reference\": \"REF-000007\", \"source_id\": 25, \"created_at\": \"2025-10-12T05:07:28.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T05:07:28.000000Z\", \"voucher_no\": \"P-000001\", \"source_type\": \"Purchase\", \"voucher_type\": \"Purchase\"}, \"journal_entry_id\": 30}', '2025-10-11 23:07:28'),
(121, 1, 'Created Purchase Entry', 'REF-000008', '{\"data\": {\"id\": 31, \"date\": \"2025-10-12\", \"debit\": 7315, \"lines\": [{\"debit\": 6300, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 665, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 350, \"credit\": 0, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 500, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 6815, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 7315, \"module\": \"Purchase\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase\", \"reference\": \"REF-000008\", \"source_id\": 25, \"created_at\": \"2025-10-12T05:23:34.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T05:23:34.000000Z\", \"voucher_no\": \"P-000002\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase\"}, \"journal_entry_id\": 31}', '2025-10-11 23:23:34'),
(122, 1, 'Created Purchase Entry', 'REF-000009', '{\"data\": {\"id\": 32, \"date\": \"2025-10-12\", \"debit\": 7315, \"lines\": [{\"debit\": 6300, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 665, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 350, \"credit\": 0, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 500, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 6815, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 7315, \"module\": \"Purchase\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase\", \"reference\": \"REF-000009\", \"source_id\": 25, \"created_at\": \"2025-10-12T05:24:09.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T05:24:09.000000Z\", \"voucher_no\": \"P-000003\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase\"}, \"journal_entry_id\": 32}', '2025-10-11 23:24:09');
INSERT INTO `acc_audit_logs` (`id`, `user_id`, `action`, `source_ref`, `details`, `created_at`) VALUES
(123, 1, 'Created Purchase Entry', 'REF-000010', '{\"data\": {\"id\": 33, \"date\": \"2025-10-12\", \"debit\": 7315, \"lines\": [{\"debit\": 6300, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 665, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 350, \"credit\": 0, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 500, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 6815, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 7315, \"module\": \"Purchase\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase\", \"reference\": \"REF-000010\", \"source_id\": 25, \"created_at\": \"2025-10-12T05:30:41.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T05:30:41.000000Z\", \"voucher_no\": \"P-000004\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase\"}, \"journal_entry_id\": 33}', '2025-10-11 23:30:41'),
(124, 1, 'Deleted Purchase Entry', 'REF-000008', '{\"data\": {\"id\": 31, \"date\": \"2025-10-12\", \"debit\": \"7315.00\", \"lines\": [{\"id\": 66, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:23:34.000000Z\", \"updated_at\": \"2025-10-12T05:23:34.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 31}, {\"id\": 67, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:23:34.000000Z\", \"updated_at\": \"2025-10-12T05:23:34.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 31}, {\"id\": 68, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:23:34.000000Z\", \"updated_at\": \"2025-10-12T05:23:34.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 31}, {\"id\": 69, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:23:34.000000Z\", \"updated_at\": \"2025-10-12T05:23:34.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 31}, {\"id\": 70, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:23:34.000000Z\", \"updated_at\": \"2025-10-12T05:23:34.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 31}], \"credit\": \"7315.00\", \"module\": \"Purchase\", \"status\": \"pending\", \"details\": [{\"id\": 66, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:23:34.000000Z\", \"updated_at\": \"2025-10-12T05:23:34.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 31}, {\"id\": 67, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:23:34.000000Z\", \"updated_at\": \"2025-10-12T05:23:34.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 31}, {\"id\": 68, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:23:34.000000Z\", \"updated_at\": \"2025-10-12T05:23:34.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 31}, {\"id\": 69, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:23:34.000000Z\", \"updated_at\": \"2025-10-12T05:23:34.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 31}, {\"id\": 70, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:23:34.000000Z\", \"updated_at\": \"2025-10-12T05:23:34.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 31}], \"branch_id\": 1, \"narration\": \"Purchase\", \"reference\": \"REF-000008\", \"source_id\": 25, \"created_at\": \"2025-10-12T05:23:34.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T05:23:34.000000Z\", \"voucher_no\": \"P-000002\", \"approved_by\": null, \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase\"}, \"journal_entry_id\": 31}', '2025-10-11 23:39:47'),
(125, 1, 'Deleted Purchase Entry', 'REF-000009', '{\"data\": {\"id\": 32, \"date\": \"2025-10-12\", \"debit\": \"7315.00\", \"lines\": [{\"id\": 71, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:24:09.000000Z\", \"updated_at\": \"2025-10-12T05:24:09.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 32}, {\"id\": 72, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:24:09.000000Z\", \"updated_at\": \"2025-10-12T05:24:09.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 32}, {\"id\": 73, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:24:09.000000Z\", \"updated_at\": \"2025-10-12T05:24:09.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 32}, {\"id\": 74, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:24:09.000000Z\", \"updated_at\": \"2025-10-12T05:24:09.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 32}, {\"id\": 75, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:24:09.000000Z\", \"updated_at\": \"2025-10-12T05:24:09.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 32}], \"credit\": \"7315.00\", \"module\": \"Purchase\", \"status\": \"pending\", \"details\": [{\"id\": 71, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:24:09.000000Z\", \"updated_at\": \"2025-10-12T05:24:09.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 32}, {\"id\": 72, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:24:09.000000Z\", \"updated_at\": \"2025-10-12T05:24:09.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 32}, {\"id\": 73, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:24:09.000000Z\", \"updated_at\": \"2025-10-12T05:24:09.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 32}, {\"id\": 74, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:24:09.000000Z\", \"updated_at\": \"2025-10-12T05:24:09.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 32}, {\"id\": 75, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:24:09.000000Z\", \"updated_at\": \"2025-10-12T05:24:09.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 32}], \"branch_id\": 1, \"narration\": \"Purchase\", \"reference\": \"REF-000009\", \"source_id\": 25, \"created_at\": \"2025-10-12T05:24:09.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T05:24:09.000000Z\", \"voucher_no\": \"P-000003\", \"approved_by\": null, \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase\"}, \"journal_entry_id\": 32}', '2025-10-11 23:39:47'),
(126, 1, 'Deleted Purchase Entry', 'REF-000010', '{\"data\": {\"id\": 33, \"date\": \"2025-10-12\", \"debit\": \"7315.00\", \"lines\": [{\"id\": 76, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:30:41.000000Z\", \"updated_at\": \"2025-10-12T05:30:41.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 33}, {\"id\": 77, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:30:41.000000Z\", \"updated_at\": \"2025-10-12T05:30:41.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 33}, {\"id\": 78, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:30:41.000000Z\", \"updated_at\": \"2025-10-12T05:30:41.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 33}, {\"id\": 79, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:30:41.000000Z\", \"updated_at\": \"2025-10-12T05:30:41.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 33}, {\"id\": 80, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:30:41.000000Z\", \"updated_at\": \"2025-10-12T05:30:41.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 33}], \"credit\": \"7315.00\", \"module\": \"Purchase\", \"status\": \"pending\", \"details\": [{\"id\": 76, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:30:41.000000Z\", \"updated_at\": \"2025-10-12T05:30:41.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 33}, {\"id\": 77, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:30:41.000000Z\", \"updated_at\": \"2025-10-12T05:30:41.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 33}, {\"id\": 78, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:30:41.000000Z\", \"updated_at\": \"2025-10-12T05:30:41.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 33}, {\"id\": 79, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:30:41.000000Z\", \"updated_at\": \"2025-10-12T05:30:41.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 33}, {\"id\": 80, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:30:41.000000Z\", \"updated_at\": \"2025-10-12T05:30:41.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 33}], \"branch_id\": 1, \"narration\": \"Purchase\", \"reference\": \"REF-000010\", \"source_id\": 25, \"created_at\": \"2025-10-12T05:30:41.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T05:30:41.000000Z\", \"voucher_no\": \"P-000004\", \"approved_by\": null, \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase\"}, \"journal_entry_id\": 33}', '2025-10-11 23:39:47'),
(127, 1, 'Created Purchase Entry', 'REF-000008', '{\"data\": {\"id\": 34, \"date\": \"2025-10-12\", \"debit\": 7315, \"lines\": [{\"debit\": 6300, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 665, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 350, \"credit\": 0, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 500, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 6815, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 7315, \"module\": \"Purchase\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase\", \"reference\": \"REF-000008\", \"source_id\": 25, \"created_at\": \"2025-10-12T05:39:47.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T05:39:47.000000Z\", \"voucher_no\": \"P-000002\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase\"}, \"journal_entry_id\": 34}', '2025-10-11 23:39:47'),
(128, 1, 'Deleted Purchase Entry', 'REF-000008', '{\"data\": {\"id\": 34, \"date\": \"2025-10-12\", \"debit\": \"7315.00\", \"lines\": [{\"id\": 81, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:39:47.000000Z\", \"updated_at\": \"2025-10-12T05:39:47.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 34}, {\"id\": 82, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:39:47.000000Z\", \"updated_at\": \"2025-10-12T05:39:47.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 34}, {\"id\": 83, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:39:47.000000Z\", \"updated_at\": \"2025-10-12T05:39:47.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 34}, {\"id\": 84, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:39:47.000000Z\", \"updated_at\": \"2025-10-12T05:39:47.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 34}, {\"id\": 85, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:39:47.000000Z\", \"updated_at\": \"2025-10-12T05:39:47.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 34}], \"credit\": \"7315.00\", \"module\": \"Purchase\", \"status\": \"pending\", \"details\": [{\"id\": 81, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:39:47.000000Z\", \"updated_at\": \"2025-10-12T05:39:47.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 34}, {\"id\": 82, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:39:47.000000Z\", \"updated_at\": \"2025-10-12T05:39:47.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 34}, {\"id\": 83, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:39:47.000000Z\", \"updated_at\": \"2025-10-12T05:39:47.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 34}, {\"id\": 84, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:39:47.000000Z\", \"updated_at\": \"2025-10-12T05:39:47.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 34}, {\"id\": 85, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:39:47.000000Z\", \"updated_at\": \"2025-10-12T05:39:47.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 34}], \"branch_id\": 1, \"narration\": \"Purchase\", \"reference\": \"REF-000008\", \"source_id\": 25, \"created_at\": \"2025-10-12T05:39:47.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T05:39:47.000000Z\", \"voucher_no\": \"P-000002\", \"approved_by\": null, \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase\"}, \"journal_entry_id\": 34}', '2025-10-11 23:40:01'),
(129, 1, 'Created Purchase Entry', 'REF-000008', '{\"data\": {\"id\": 35, \"date\": \"2025-10-12\", \"debit\": 7315, \"lines\": [{\"debit\": 6300, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 665, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 350, \"credit\": 0, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 500, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 6815, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 7315, \"module\": \"Purchase\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase\", \"reference\": \"REF-000008\", \"source_id\": 25, \"created_at\": \"2025-10-12T05:40:01.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T05:40:01.000000Z\", \"voucher_no\": \"P-000002\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase\"}, \"journal_entry_id\": 35}', '2025-10-11 23:40:01'),
(130, 1, 'Deleted Purchase Entry', 'REF-000008', '{\"data\": {\"id\": 35, \"date\": \"2025-10-12\", \"debit\": \"7315.00\", \"lines\": [{\"id\": 86, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:40:01.000000Z\", \"updated_at\": \"2025-10-12T05:40:01.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 35}, {\"id\": 87, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:40:01.000000Z\", \"updated_at\": \"2025-10-12T05:40:01.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 35}, {\"id\": 88, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:40:01.000000Z\", \"updated_at\": \"2025-10-12T05:40:01.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 35}, {\"id\": 89, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:40:01.000000Z\", \"updated_at\": \"2025-10-12T05:40:01.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 35}, {\"id\": 90, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:40:01.000000Z\", \"updated_at\": \"2025-10-12T05:40:01.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 35}], \"credit\": \"7315.00\", \"module\": \"Purchase\", \"status\": \"pending\", \"details\": [{\"id\": 86, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:40:01.000000Z\", \"updated_at\": \"2025-10-12T05:40:01.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 35}, {\"id\": 87, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:40:01.000000Z\", \"updated_at\": \"2025-10-12T05:40:01.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 35}, {\"id\": 88, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:40:01.000000Z\", \"updated_at\": \"2025-10-12T05:40:01.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 35}, {\"id\": 89, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:40:01.000000Z\", \"updated_at\": \"2025-10-12T05:40:01.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 35}, {\"id\": 90, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:40:01.000000Z\", \"updated_at\": \"2025-10-12T05:40:01.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 35}], \"branch_id\": 1, \"narration\": \"Purchase\", \"reference\": \"REF-000008\", \"source_id\": 25, \"created_at\": \"2025-10-12T05:40:01.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T05:40:01.000000Z\", \"voucher_no\": \"P-000002\", \"approved_by\": null, \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase\"}, \"journal_entry_id\": 35}', '2025-10-11 23:47:12'),
(131, 1, 'Created Purchase Entry', 'REF-000008', '{\"data\": {\"id\": 36, \"date\": \"2025-10-12\", \"debit\": 7315, \"lines\": [{\"debit\": 6300, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 665, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 350, \"credit\": 0, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 500, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 6815, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 7315, \"module\": \"Purchase\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase\", \"reference\": \"REF-000008\", \"source_id\": 25, \"created_at\": \"2025-10-12T05:47:12.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T05:47:12.000000Z\", \"voucher_no\": \"P-000002\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase\"}, \"journal_entry_id\": 36}', '2025-10-11 23:47:12'),
(132, 1, 'Deleted Purchase Entry', 'REF-000008', '{\"data\": {\"id\": 36, \"date\": \"2025-10-12\", \"debit\": \"7315.00\", \"lines\": [{\"id\": 91, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:47:12.000000Z\", \"updated_at\": \"2025-10-12T05:47:12.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 36}, {\"id\": 92, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:47:12.000000Z\", \"updated_at\": \"2025-10-12T05:47:12.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 36}, {\"id\": 93, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:47:12.000000Z\", \"updated_at\": \"2025-10-12T05:47:12.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 36}, {\"id\": 94, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:47:12.000000Z\", \"updated_at\": \"2025-10-12T05:47:12.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 36}, {\"id\": 95, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:47:12.000000Z\", \"updated_at\": \"2025-10-12T05:47:12.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 36}], \"credit\": \"7315.00\", \"module\": \"Purchase\", \"status\": \"pending\", \"details\": [{\"id\": 91, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:47:12.000000Z\", \"updated_at\": \"2025-10-12T05:47:12.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 36}, {\"id\": 92, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:47:12.000000Z\", \"updated_at\": \"2025-10-12T05:47:12.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 36}, {\"id\": 93, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:47:12.000000Z\", \"updated_at\": \"2025-10-12T05:47:12.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 36}, {\"id\": 94, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:47:12.000000Z\", \"updated_at\": \"2025-10-12T05:47:12.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 36}, {\"id\": 95, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T05:47:12.000000Z\", \"updated_at\": \"2025-10-12T05:47:12.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 36}], \"branch_id\": 1, \"narration\": \"Purchase\", \"reference\": \"REF-000008\", \"source_id\": 25, \"created_at\": \"2025-10-12T05:47:12.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T05:47:12.000000Z\", \"voucher_no\": \"P-000002\", \"approved_by\": null, \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase\"}, \"journal_entry_id\": 36}', '2025-10-12 00:13:26'),
(133, 1, 'Created Purchase Entry', 'REF-000008', '{\"data\": {\"id\": 37, \"date\": \"2025-10-12\", \"debit\": 7315, \"lines\": [{\"debit\": 6300, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 665, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 350, \"credit\": 0, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 500, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 6815, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 7315, \"module\": \"Purchase\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase\", \"reference\": \"REF-000008\", \"source_id\": 25, \"created_at\": \"2025-10-12T06:13:26.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T06:13:26.000000Z\", \"voucher_no\": \"P-000002\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase\"}, \"journal_entry_id\": 37}', '2025-10-12 00:13:26'),
(134, 1, 'Deleted Purchase Entry', 'REF-000008', '{\"data\": {\"id\": 37, \"date\": \"2025-10-12\", \"debit\": \"7315.00\", \"lines\": [{\"id\": 96, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:13:26.000000Z\", \"updated_at\": \"2025-10-12T06:13:26.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 37}, {\"id\": 97, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:13:26.000000Z\", \"updated_at\": \"2025-10-12T06:13:26.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 37}, {\"id\": 98, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:13:26.000000Z\", \"updated_at\": \"2025-10-12T06:13:26.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 37}, {\"id\": 99, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:13:26.000000Z\", \"updated_at\": \"2025-10-12T06:13:26.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 37}, {\"id\": 100, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:13:26.000000Z\", \"updated_at\": \"2025-10-12T06:13:26.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 37}], \"credit\": \"7315.00\", \"module\": \"Purchase\", \"status\": \"pending\", \"details\": [{\"id\": 96, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:13:26.000000Z\", \"updated_at\": \"2025-10-12T06:13:26.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 37}, {\"id\": 97, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:13:26.000000Z\", \"updated_at\": \"2025-10-12T06:13:26.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 37}, {\"id\": 98, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:13:26.000000Z\", \"updated_at\": \"2025-10-12T06:13:26.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 37}, {\"id\": 99, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:13:26.000000Z\", \"updated_at\": \"2025-10-12T06:13:26.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 37}, {\"id\": 100, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:13:26.000000Z\", \"updated_at\": \"2025-10-12T06:13:26.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 37}], \"branch_id\": 1, \"narration\": \"Purchase\", \"reference\": \"REF-000008\", \"source_id\": 25, \"created_at\": \"2025-10-12T06:13:26.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T06:13:26.000000Z\", \"voucher_no\": \"P-000002\", \"approved_by\": null, \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase\"}, \"journal_entry_id\": 37}', '2025-10-12 00:18:14'),
(135, 1, 'Created Purchase Entry', 'REF-000008', '{\"data\": {\"id\": 38, \"date\": \"2025-10-12\", \"debit\": 7315, \"lines\": [{\"debit\": 6300, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 665, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 350, \"credit\": 0, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 500, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 6815, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 7315, \"module\": \"Purchase\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase\", \"reference\": \"REF-000008\", \"source_id\": 25, \"created_at\": \"2025-10-12T06:18:14.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T06:18:14.000000Z\", \"voucher_no\": \"P-000002\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase\"}, \"journal_entry_id\": 38}', '2025-10-12 00:18:14'),
(136, 1, 'Updated Account Module', '2', '{\"new\": {\"status\": 1, \"accounts\": [{\"is_debit\": 1, \"component\": \"inventory\", \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"is_debit\": 1, \"component\": \"tax_amount\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"is_debit\": 1, \"component\": \"discount_amount\", \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"is_debit\": 0, \"component\": \"paid_amount\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"is_debit\": 0, \"component\": \"supplier_advance\", \"description\": \"Advance adjusted\", \"account_head_id\": 20}, {\"is_debit\": 0, \"component\": \"due_amount\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"entry_type\": \"Purchase Voucher\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase Voucher\"}, \"old\": {\"id\": 2, \"status\": 1, \"accounts\": [{\"id\": 83, \"is_debit\": 1, \"component\": \"inventory\", \"created_at\": \"2025-10-12T04:55:38.000000Z\", \"updated_at\": \"2025-10-12T04:55:38.000000Z\", \"description\": \"Inventory increase\", \"account_head_id\": 38, \"module_entry_id\": 2}, {\"id\": 84, \"is_debit\": 1, \"component\": \"tax_amount\", \"created_at\": \"2025-10-12T04:55:38.000000Z\", \"updated_at\": \"2025-10-12T04:55:38.000000Z\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40, \"module_entry_id\": 2}, {\"id\": 85, \"is_debit\": 1, \"component\": \"discount_amount\", \"created_at\": \"2025-10-12T04:55:38.000000Z\", \"updated_at\": \"2025-10-12T04:55:38.000000Z\", \"description\": \"Purchase discount\", \"account_head_id\": 39, \"module_entry_id\": 2}, {\"id\": 86, \"is_debit\": 0, \"component\": \"paid_amount\", \"created_at\": \"2025-10-12T04:55:38.000000Z\", \"updated_at\": \"2025-10-12T04:55:38.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 2}, {\"id\": 87, \"is_debit\": 0, \"component\": \"supplier_advance\", \"created_at\": \"2025-10-12T04:55:38.000000Z\", \"updated_at\": \"2025-10-12T04:55:38.000000Z\", \"description\": \"Advance adjusted\", \"account_head_id\": 20, \"module_entry_id\": 2}, {\"id\": 88, \"is_debit\": 0, \"component\": \"due_amount\", \"created_at\": \"2025-10-12T04:55:38.000000Z\", \"updated_at\": \"2025-10-12T04:55:38.000000Z\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8, \"module_entry_id\": 2}], \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"entry_type\": \"Purchase Voucher\", \"updated_at\": \"2025-09-20T13:16:15.000000Z\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase\"}, \"module_entry_id\": 2}', '2025-10-12 00:39:10'),
(137, 1, 'Created Purchase Voucher Entry', 'REF-000009', '{\"data\": {\"id\": 39, \"date\": \"2025-10-12\", \"debit\": 7315, \"lines\": [{\"debit\": 6300, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 665, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 350, \"credit\": 0, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 500, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 6815, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 7315, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000009\", \"source_id\": 25, \"created_at\": \"2025-10-12T06:39:27.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T06:39:27.000000Z\", \"voucher_no\": \"PV-000001\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 39}', '2025-10-12 00:39:27'),
(138, 1, 'Deleted Purchase Voucher Entry', 'REF-000009', '{\"data\": {\"id\": 39, \"date\": \"2025-10-12\", \"debit\": \"7315.00\", \"lines\": [{\"id\": 106, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:39:27.000000Z\", \"updated_at\": \"2025-10-12T06:39:27.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 39}, {\"id\": 107, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:39:27.000000Z\", \"updated_at\": \"2025-10-12T06:39:27.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 39}, {\"id\": 108, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:39:27.000000Z\", \"updated_at\": \"2025-10-12T06:39:27.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 39}, {\"id\": 109, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:39:27.000000Z\", \"updated_at\": \"2025-10-12T06:39:27.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 39}, {\"id\": 110, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:39:27.000000Z\", \"updated_at\": \"2025-10-12T06:39:27.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 39}], \"credit\": \"7315.00\", \"module\": \"Purchase Voucher\", \"status\": \"pending\", \"details\": [{\"id\": 106, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:39:27.000000Z\", \"updated_at\": \"2025-10-12T06:39:27.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 39}, {\"id\": 107, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:39:27.000000Z\", \"updated_at\": \"2025-10-12T06:39:27.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 39}, {\"id\": 108, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:39:27.000000Z\", \"updated_at\": \"2025-10-12T06:39:27.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 39}, {\"id\": 109, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:39:27.000000Z\", \"updated_at\": \"2025-10-12T06:39:27.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 39}, {\"id\": 110, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:39:27.000000Z\", \"updated_at\": \"2025-10-12T06:39:27.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 39}], \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000009\", \"source_id\": 25, \"created_at\": \"2025-10-12T06:39:27.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T06:39:27.000000Z\", \"voucher_no\": \"PV-000001\", \"approved_by\": null, \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 39}', '2025-10-12 00:46:35'),
(139, 1, 'Created Purchase Voucher Entry', 'REF-000009', '{\"data\": {\"id\": 40, \"date\": \"2025-10-12\", \"debit\": 7315, \"lines\": [{\"debit\": 6300, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 665, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 350, \"credit\": 0, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 500, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 6815, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 7315, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000009\", \"source_id\": 26, \"created_at\": \"2025-10-12T06:48:08.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T06:48:08.000000Z\", \"voucher_no\": \"PV-000001\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 40}', '2025-10-12 00:48:08'),
(140, 1, 'Created Purchase Voucher Entry', 'REF-000010', '{\"data\": {\"id\": 41, \"date\": \"2025-11-04\", \"debit\": 600, \"lines\": [{\"debit\": 600, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 0, \"credit\": 300, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 300, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 600, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000010\", \"source_id\": 30, \"created_at\": \"2025-11-04T07:29:28.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-04T07:29:28.000000Z\", \"voucher_no\": \"PV-000002\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 41}', '2025-11-04 01:29:28'),
(141, 1, 'Created Purchase Voucher Entry', 'REF-000011', '{\"data\": {\"id\": 42, \"date\": \"2025-11-04\", \"debit\": 200, \"lines\": [{\"debit\": 200, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 0, \"credit\": 200, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}], \"credit\": 200, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000011\", \"source_id\": 31, \"created_at\": \"2025-11-04T07:32:15.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-04T07:32:15.000000Z\", \"voucher_no\": \"PV-000003\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 42}', '2025-11-04 01:32:15'),
(142, 1, 'Created Purchase Voucher Entry', 'REF-000012', '{\"data\": {\"id\": 43, \"date\": \"2025-11-04\", \"debit\": 200, \"lines\": [{\"debit\": 200, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 0, \"credit\": 200, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}], \"credit\": 200, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000012\", \"source_id\": 32, \"created_at\": \"2025-11-04T07:32:33.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-04T07:32:33.000000Z\", \"voucher_no\": \"PV-000004\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 43}', '2025-11-04 01:32:33'),
(143, 1, 'Created Purchase Voucher Entry', 'REF-000013', '{\"data\": {\"id\": 44, \"date\": \"2025-11-04\", \"debit\": 300, \"lines\": [{\"debit\": 300, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 0, \"credit\": 300, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}], \"credit\": 300, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000013\", \"source_id\": 33, \"created_at\": \"2025-11-04T07:33:19.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-04T07:33:19.000000Z\", \"voucher_no\": \"PV-000005\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 44}', '2025-11-04 01:33:19'),
(144, 1, 'Created Purchase Voucher Entry', 'REF-000014', '{\"data\": {\"id\": 45, \"date\": \"2025-11-04\", \"debit\": 400, \"lines\": [{\"debit\": 400, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 0, \"credit\": 400, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}], \"credit\": 400, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000014\", \"source_id\": 34, \"created_at\": \"2025-11-04T07:50:18.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-04T07:50:18.000000Z\", \"voucher_no\": \"PV-000006\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 45}', '2025-11-04 01:50:18'),
(145, 1, 'Updated Account Module', '2', '{\"new\": {\"status\": 1, \"accounts\": [{\"is_debit\": 1, \"component\": \"inventory\", \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"is_debit\": 1, \"component\": \"tax_amount\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"is_debit\": false, \"component\": \"discount_amount\", \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"is_debit\": 0, \"component\": \"paid_amount\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"is_debit\": 0, \"component\": \"supplier_advance\", \"description\": \"Advance adjusted\", \"account_head_id\": 20}, {\"is_debit\": 0, \"component\": \"due_amount\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"entry_type\": \"Purchase Voucher\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase Voucher\"}, \"old\": {\"id\": 2, \"status\": 1, \"accounts\": [{\"id\": 89, \"is_debit\": 1, \"component\": \"inventory\", \"created_at\": \"2025-10-12T06:39:10.000000Z\", \"updated_at\": \"2025-10-12T06:39:10.000000Z\", \"description\": \"Inventory increase\", \"account_head_id\": 38, \"module_entry_id\": 2}, {\"id\": 90, \"is_debit\": 1, \"component\": \"tax_amount\", \"created_at\": \"2025-10-12T06:39:10.000000Z\", \"updated_at\": \"2025-10-12T06:39:10.000000Z\", \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40, \"module_entry_id\": 2}, {\"id\": 91, \"is_debit\": 1, \"component\": \"discount_amount\", \"created_at\": \"2025-10-12T06:39:10.000000Z\", \"updated_at\": \"2025-10-12T06:39:10.000000Z\", \"description\": \"Purchase discount\", \"account_head_id\": 39, \"module_entry_id\": 2}, {\"id\": 92, \"is_debit\": 0, \"component\": \"paid_amount\", \"created_at\": \"2025-10-12T06:39:10.000000Z\", \"updated_at\": \"2025-10-12T06:39:10.000000Z\", \"description\": \"Cash paid to supplier\", \"account_head_id\": 6, \"module_entry_id\": 2}, {\"id\": 93, \"is_debit\": 0, \"component\": \"supplier_advance\", \"created_at\": \"2025-10-12T06:39:10.000000Z\", \"updated_at\": \"2025-10-12T06:39:10.000000Z\", \"description\": \"Advance adjusted\", \"account_head_id\": 20, \"module_entry_id\": 2}, {\"id\": 94, \"is_debit\": 0, \"component\": \"due_amount\", \"created_at\": \"2025-10-12T06:39:10.000000Z\", \"updated_at\": \"2025-10-12T06:39:10.000000Z\", \"description\": \"Payable due to supplier\", \"account_head_id\": 8, \"module_entry_id\": 2}], \"created_at\": \"2025-09-20T13:16:15.000000Z\", \"entry_type\": \"Purchase Voucher\", \"updated_at\": \"2025-10-12T06:39:10.000000Z\", \"description\": \"Purchase invoice related\", \"module_name\": \"Purchase Voucher\"}, \"module_entry_id\": 2}', '2025-11-04 05:19:06'),
(146, 1, 'Created Purchase Voucher Entry', 'REF-000015', '{\"data\": {\"id\": 46, \"date\": \"2025-11-04\", \"debit\": 121.7, \"lines\": [{\"debit\": 100, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 21.7027027027027, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 0, \"credit\": 40, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 30, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 51.70270270270271, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 121.7, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000015\", \"source_id\": 68, \"created_at\": \"2025-11-04T11:20:56.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-04T11:20:56.000000Z\", \"voucher_no\": \"PV-000007\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 46}', '2025-11-04 05:20:56'),
(147, 1, 'Created Purchase Voucher Entry', 'REF-000016', '{\"data\": {\"id\": 47, \"date\": \"2025-11-04\", \"debit\": 211.35, \"lines\": [{\"debit\": 200, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 11.345675675675675, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 0, \"credit\": 37, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 174.34567567567566, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 211.35, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000016\", \"source_id\": 72, \"created_at\": \"2025-11-04T11:33:27.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-04T11:33:27.000000Z\", \"voucher_no\": \"PV-000008\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 47}', '2025-11-04 05:33:27'),
(148, 1, 'Created Purchase Voucher Entry', 'REF-000017', '{\"data\": {\"id\": 48, \"date\": \"2025-11-04\", \"debit\": 215, \"lines\": [{\"debit\": 200, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 15, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 0, \"credit\": 45, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 170, \"description\": \"Advance adjusted\", \"account_head_id\": 20}], \"credit\": 215, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000017\", \"source_id\": 86, \"created_at\": \"2025-11-04T12:35:47.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-04T12:35:47.000000Z\", \"voucher_no\": \"PV-000009\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 48}', '2025-11-04 06:35:47'),
(149, 1, 'Deleted Purchase Voucher Entry', 'REF-000009', '{\"data\": {\"id\": 40, \"date\": \"2025-10-12\", \"debit\": \"7315.00\", \"lines\": [{\"id\": 111, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:48:08.000000Z\", \"updated_at\": \"2025-10-12T06:48:08.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 40}, {\"id\": 112, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:48:08.000000Z\", \"updated_at\": \"2025-10-12T06:48:08.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 40}, {\"id\": 113, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:48:08.000000Z\", \"updated_at\": \"2025-10-12T06:48:08.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 40}, {\"id\": 114, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:48:08.000000Z\", \"updated_at\": \"2025-10-12T06:48:08.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 40}, {\"id\": 115, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:48:08.000000Z\", \"updated_at\": \"2025-10-12T06:48:08.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 40}], \"credit\": \"7315.00\", \"module\": \"Purchase Voucher\", \"status\": \"pending\", \"details\": [{\"id\": 111, \"debit\": \"6300.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:48:08.000000Z\", \"updated_at\": \"2025-10-12T06:48:08.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 40}, {\"id\": 112, \"debit\": \"665.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:48:08.000000Z\", \"updated_at\": \"2025-10-12T06:48:08.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 40}, {\"id\": 113, \"debit\": \"350.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:48:08.000000Z\", \"updated_at\": \"2025-10-12T06:48:08.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 40}, {\"id\": 114, \"debit\": \"0.00\", \"credit\": \"500.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:48:08.000000Z\", \"updated_at\": \"2025-10-12T06:48:08.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 40}, {\"id\": 115, \"debit\": \"0.00\", \"credit\": \"6815.00\", \"remarks\": null, \"created_at\": \"2025-10-12T06:48:08.000000Z\", \"updated_at\": \"2025-10-12T06:48:08.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 40}], \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000009\", \"source_id\": 26, \"created_at\": \"2025-10-12T06:48:08.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-10-12T06:48:08.000000Z\", \"voucher_no\": \"PV-000001\", \"approved_by\": null, \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 40}', '2025-11-04 06:39:03'),
(150, 1, 'Created Purchase Voucher Entry', 'REF-000018', '{\"data\": {\"id\": 49, \"date\": \"2025-11-05\", \"debit\": 4254.2, \"lines\": [{\"debit\": 4250, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 4.2, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 0, \"credit\": 74.7, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 4000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 179.5, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 4254.2, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000018\", \"source_id\": 87, \"created_at\": \"2025-11-05T04:54:00.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-05T04:54:00.000000Z\", \"voucher_no\": \"PV-000010\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 49}', '2025-11-04 22:54:00'),
(151, 1, 'Created Purchase Voucher Entry', 'REF-000019', '{\"data\": {\"id\": 50, \"date\": \"2025-11-05\", \"debit\": 4530.44, \"lines\": [{\"debit\": 4500, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 30.444444444444443, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 0, \"credit\": 140, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 4000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 390.44444444444434, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 4530.44, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000019\", \"source_id\": 88, \"created_at\": \"2025-11-05T06:08:41.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-05T06:08:41.000000Z\", \"voucher_no\": \"PV-000011\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 50}', '2025-11-05 00:08:41');
INSERT INTO `acc_audit_logs` (`id`, `user_id`, `action`, `source_ref`, `details`, `created_at`) VALUES
(152, 1, 'Created Purchase Voucher Entry', 'REF-000020', '{\"data\": {\"id\": 51, \"date\": \"2025-11-05\", \"debit\": 4020, \"lines\": [{\"debit\": 4000, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 20, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 0, \"credit\": 110, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 3000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 910, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 4020, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000020\", \"source_id\": 89, \"created_at\": \"2025-11-05T06:47:10.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-05T06:47:10.000000Z\", \"voucher_no\": \"PV-000012\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 51}', '2025-11-05 00:47:10'),
(153, 1, 'Created Purchase Voucher Entry', 'REF-000021', '{\"data\": {\"id\": 52, \"date\": \"2025-11-05\", \"debit\": 6001.2, \"lines\": [{\"debit\": 6000, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 1.2, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 0, \"credit\": 160, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 5000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 841.1999999999998, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 6001.2, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000021\", \"source_id\": 90, \"created_at\": \"2025-11-05T07:13:02.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-05T07:13:02.000000Z\", \"voucher_no\": \"PV-000013\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 52}', '2025-11-05 01:13:02'),
(154, 1, 'Created Purchase Voucher Entry', 'REF-000022', '{\"data\": {\"id\": 53, \"date\": \"2025-11-05\", \"debit\": 6080, \"lines\": [{\"debit\": 6000, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 80, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 0, \"credit\": 170, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 5000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 910, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 6080, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000022\", \"source_id\": 91, \"created_at\": \"2025-11-05T07:18:07.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-05T07:18:07.000000Z\", \"voucher_no\": \"PV-000014\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 53}', '2025-11-05 01:18:07'),
(155, 1, 'Created Purchase Voucher Entry', 'REF-000023', '{\"data\": {\"id\": 54, \"date\": \"2025-11-05\", \"debit\": 6150, \"lines\": [{\"debit\": 6000, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 150, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 0, \"credit\": 250, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 5000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 900, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 6150, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000023\", \"source_id\": 109, \"created_at\": \"2025-11-05T07:51:10.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-05T07:51:10.000000Z\", \"voucher_no\": \"PV-000015\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 54}', '2025-11-05 01:51:10'),
(156, 1, 'Created Purchase Voucher Entry', 'REF-000024', '{\"data\": {\"id\": 55, \"date\": \"2025-11-05\", \"debit\": 1626.76, \"lines\": [{\"debit\": 1500, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 126.76, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 0, \"credit\": 226.76, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 1000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 400, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 1626.76, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000024\", \"source_id\": 110, \"created_at\": \"2025-11-05T08:57:49.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-05T08:57:49.000000Z\", \"voucher_no\": \"PV-000016\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 55}', '2025-11-05 02:57:49'),
(157, 1, 'Deleted Purchase Voucher Entry', 'REF-000024', '{\"data\": {\"id\": 55, \"date\": \"2025-11-05\", \"debit\": \"1626.76\", \"lines\": [{\"id\": 170, \"debit\": \"1500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-11-05T08:57:49.000000Z\", \"updated_at\": \"2025-11-05T08:57:49.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 55}, {\"id\": 171, \"debit\": \"126.76\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-11-05T08:57:49.000000Z\", \"updated_at\": \"2025-11-05T08:57:49.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 55}, {\"id\": 172, \"debit\": \"0.00\", \"credit\": \"226.76\", \"remarks\": null, \"created_at\": \"2025-11-05T08:57:49.000000Z\", \"updated_at\": \"2025-11-05T08:57:49.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 55}, {\"id\": 173, \"debit\": \"0.00\", \"credit\": \"1000.00\", \"remarks\": null, \"created_at\": \"2025-11-05T08:57:49.000000Z\", \"updated_at\": \"2025-11-05T08:57:49.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 55}, {\"id\": 174, \"debit\": \"0.00\", \"credit\": \"400.00\", \"remarks\": null, \"created_at\": \"2025-11-05T08:57:49.000000Z\", \"updated_at\": \"2025-11-05T08:57:49.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 55}], \"credit\": \"1626.76\", \"module\": \"Purchase Voucher\", \"status\": \"pending\", \"details\": [{\"id\": 170, \"debit\": \"1500.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-11-05T08:57:49.000000Z\", \"updated_at\": \"2025-11-05T08:57:49.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 55}, {\"id\": 171, \"debit\": \"126.76\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-11-05T08:57:49.000000Z\", \"updated_at\": \"2025-11-05T08:57:49.000000Z\", \"account_head_id\": 40, \"journal_entry_id\": 55}, {\"id\": 172, \"debit\": \"0.00\", \"credit\": \"226.76\", \"remarks\": null, \"created_at\": \"2025-11-05T08:57:49.000000Z\", \"updated_at\": \"2025-11-05T08:57:49.000000Z\", \"account_head_id\": 39, \"journal_entry_id\": 55}, {\"id\": 173, \"debit\": \"0.00\", \"credit\": \"1000.00\", \"remarks\": null, \"created_at\": \"2025-11-05T08:57:49.000000Z\", \"updated_at\": \"2025-11-05T08:57:49.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 55}, {\"id\": 174, \"debit\": \"0.00\", \"credit\": \"400.00\", \"remarks\": null, \"created_at\": \"2025-11-05T08:57:49.000000Z\", \"updated_at\": \"2025-11-05T08:57:49.000000Z\", \"account_head_id\": 8, \"journal_entry_id\": 55}], \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000024\", \"source_id\": 110, \"created_at\": \"2025-11-05T08:57:49.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-05T08:57:49.000000Z\", \"voucher_no\": \"PV-000016\", \"approved_by\": null, \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 55}', '2025-11-05 03:25:03'),
(158, 1, 'Created Purchase Voucher Entry', 'REF-000024', '{\"data\": {\"id\": 56, \"date\": \"2025-11-05\", \"debit\": 1627.5, \"lines\": [{\"debit\": 1500, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 127.5, \"credit\": 0, \"description\": \"Purchase tax (input VAT)\", \"account_head_id\": 40}, {\"debit\": 0, \"credit\": 227.5, \"description\": \"Purchase discount\", \"account_head_id\": 39}, {\"debit\": 0, \"credit\": 1000, \"description\": \"Cash paid to supplier\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 400, \"description\": \"Payable due to supplier\", \"account_head_id\": 8}], \"credit\": 1627.5, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000024\", \"source_id\": 110, \"created_at\": \"2025-11-05T09:25:03.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-05T09:25:03.000000Z\", \"voucher_no\": \"PV-000016\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 56}', '2025-11-05 03:25:03'),
(159, 1, 'Created Purchase Voucher Entry', 'REF-000025', '{\"data\": {\"id\": 57, \"date\": \"2025-11-05\", \"debit\": 1250, \"lines\": [{\"debit\": 1250, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 0, \"credit\": 1250, \"description\": \"Advance adjusted\", \"account_head_id\": 20}], \"credit\": 1250, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000025\", \"source_id\": 111, \"created_at\": \"2025-11-05T09:44:03.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-05T09:44:03.000000Z\", \"voucher_no\": \"PV-000017\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 57}', '2025-11-05 03:44:03'),
(160, 1, 'Deleted Purchase Voucher Entry', 'REF-000025', '{\"data\": {\"id\": 57, \"date\": \"2025-11-05\", \"debit\": \"1250.00\", \"lines\": [{\"id\": 180, \"debit\": \"1250.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-11-05T09:44:03.000000Z\", \"updated_at\": \"2025-11-05T09:44:03.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 57}, {\"id\": 181, \"debit\": \"0.00\", \"credit\": \"1250.00\", \"remarks\": null, \"created_at\": \"2025-11-05T09:44:03.000000Z\", \"updated_at\": \"2025-11-05T09:44:03.000000Z\", \"account_head_id\": 20, \"journal_entry_id\": 57}], \"credit\": \"1250.00\", \"module\": \"Purchase Voucher\", \"status\": \"pending\", \"details\": [{\"id\": 180, \"debit\": \"1250.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-11-05T09:44:03.000000Z\", \"updated_at\": \"2025-11-05T09:44:03.000000Z\", \"account_head_id\": 38, \"journal_entry_id\": 57}, {\"id\": 181, \"debit\": \"0.00\", \"credit\": \"1250.00\", \"remarks\": null, \"created_at\": \"2025-11-05T09:44:03.000000Z\", \"updated_at\": \"2025-11-05T09:44:03.000000Z\", \"account_head_id\": 20, \"journal_entry_id\": 57}], \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000025\", \"source_id\": 111, \"created_at\": \"2025-11-05T09:44:03.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-05T09:44:03.000000Z\", \"voucher_no\": \"PV-000017\", \"approved_by\": null, \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 57}', '2025-11-23 23:59:29'),
(161, 1, 'Created Purchase Voucher Entry', 'REF-000025', '{\"data\": {\"id\": 58, \"date\": \"2025-11-24\", \"debit\": 1250, \"lines\": [{\"debit\": 1250, \"credit\": 0, \"description\": \"Inventory increase\", \"account_head_id\": 38}, {\"debit\": 0, \"credit\": 1250, \"description\": \"Advance adjusted\", \"account_head_id\": 20}], \"credit\": 1250, \"module\": \"Purchase Voucher\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Purchase Voucher\", \"reference\": \"REF-000025\", \"source_id\": 111, \"created_at\": \"2025-11-24T05:59:29.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-24T05:59:29.000000Z\", \"voucher_no\": \"PV-000017\", \"source_type\": \"Purchase Voucher\", \"voucher_type\": \"Purchase Voucher\"}, \"journal_entry_id\": 58}', '2025-11-23 23:59:29'),
(162, 1, 'Created Account Module', '7', '{\"data\": {\"id\": 7, \"status\": 1, \"created_at\": \"2025-11-24T07:37:20.000000Z\", \"entry_type\": \"Customer Advance\", \"updated_at\": \"2025-11-24T07:37:20.000000Z\", \"description\": \"Advance given to customer\", \"module_name\": \"Customer Advance\"}, \"module_entry_id\": 7}', '2025-11-24 01:37:20'),
(163, 1, 'Created Customer Advance Entry', 'REF-000026', '{\"data\": {\"id\": 59, \"date\": \"2025-11-24\", \"debit\": 5000, \"lines\": [{\"debit\": 5000, \"credit\": 0, \"description\": \"Cash paid to customer\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 5000, \"description\": \"Customer account credited\", \"account_head_id\": 36}], \"credit\": 5000, \"module\": \"Customer Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Customer Advance\", \"reference\": \"REF-000026\", \"source_id\": 3, \"created_at\": \"2025-11-24T07:37:30.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-24T07:37:30.000000Z\", \"voucher_no\": \"CA-000001\", \"source_type\": \"Customer Advance\", \"voucher_type\": \"Customer Advance\"}, \"journal_entry_id\": 59}', '2025-11-24 01:37:30'),
(164, 1, 'Deleted Customer Advance Entry', 'REF-000026', '{\"data\": {\"id\": 59, \"date\": \"2025-11-24\", \"debit\": \"5000.00\", \"lines\": [{\"id\": 184, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-11-24T07:37:30.000000Z\", \"updated_at\": \"2025-11-24T07:37:30.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 59}, {\"id\": 185, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-11-24T07:37:30.000000Z\", \"updated_at\": \"2025-11-24T07:37:30.000000Z\", \"account_head_id\": 36, \"journal_entry_id\": 59}], \"credit\": \"5000.00\", \"module\": \"Customer Advance\", \"status\": \"pending\", \"details\": [{\"id\": 184, \"debit\": \"5000.00\", \"credit\": \"0.00\", \"remarks\": null, \"created_at\": \"2025-11-24T07:37:30.000000Z\", \"updated_at\": \"2025-11-24T07:37:30.000000Z\", \"account_head_id\": 6, \"journal_entry_id\": 59}, {\"id\": 185, \"debit\": \"0.00\", \"credit\": \"5000.00\", \"remarks\": null, \"created_at\": \"2025-11-24T07:37:30.000000Z\", \"updated_at\": \"2025-11-24T07:37:30.000000Z\", \"account_head_id\": 36, \"journal_entry_id\": 59}], \"branch_id\": 1, \"narration\": \"Customer Advance\", \"reference\": \"REF-000026\", \"source_id\": 3, \"created_at\": \"2025-11-24T07:37:30.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-24T07:37:30.000000Z\", \"voucher_no\": \"CA-000001\", \"approved_by\": null, \"source_type\": \"Customer Advance\", \"voucher_type\": \"Customer Advance\"}, \"journal_entry_id\": 59}', '2025-11-24 01:38:53'),
(165, 1, 'Created Customer Advance Entry', 'REF-000026', '{\"data\": {\"id\": 60, \"date\": \"2025-11-24\", \"debit\": 5000, \"lines\": [{\"debit\": 5000, \"credit\": 0, \"description\": \"Cash paid to customer\", \"account_head_id\": 6}, {\"debit\": 0, \"credit\": 5000, \"description\": \"Customer account credited\", \"account_head_id\": 36}], \"credit\": 5000, \"module\": \"Customer Advance\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Customer Advance\", \"reference\": \"REF-000026\", \"source_id\": 3, \"created_at\": \"2025-11-24T07:38:53.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-24T07:38:53.000000Z\", \"voucher_no\": \"CA-000001\", \"source_type\": \"Customer Advance\", \"voucher_type\": \"Customer Advance\"}, \"journal_entry_id\": 60}', '2025-11-24 01:38:53'),
(166, 1, 'Created Chart Of Account', '10007', '{\"data\": {\"id\": 42, \"code\": \"10007\", \"name\": \"Customer Previous Due\", \"type\": \"asset\", \"status\": 1, \"is_debit\": 1, \"parent_id\": 1, \"created_at\": \"2025-11-24T08:52:16.000000Z\", \"updated_at\": \"2025-11-24T08:52:16.000000Z\"}}', '2025-11-24 02:52:16'),
(167, 1, 'Created Account Module', '8', '{\"data\": {\"id\": 8, \"status\": 1, \"created_at\": \"2025-11-24T09:03:23.000000Z\", \"entry_type\": \"Customer Previous Due\", \"updated_at\": \"2025-11-24T09:03:23.000000Z\", \"description\": \"Customer Previous Due\", \"module_name\": \"Customer Previous Due\"}, \"module_entry_id\": 8}', '2025-11-24 03:03:23'),
(168, 1, 'Created Customer Previous Due Entry', 'REF-000027', '{\"data\": {\"id\": 61, \"date\": \"2025-11-24\", \"debit\": 250, \"lines\": [{\"debit\": 250, \"credit\": 0, \"description\": \"Previous Due (Debit)\", \"account_head_id\": 42}, {\"debit\": 0, \"credit\": 250, \"description\": \"Customer Liability (Credit)\", \"account_head_id\": 41}], \"credit\": 250, \"module\": \"Customer Previous Due\", \"status\": 1, \"branch_id\": 1, \"narration\": \"Customer Previous Due\", \"reference\": \"REF-000027\", \"source_id\": 1, \"created_at\": \"2025-11-24T09:03:33.000000Z\", \"created_by\": 1, \"updated_at\": \"2025-11-24T09:03:33.000000Z\", \"voucher_no\": \"CPD-000001\", \"source_type\": \"Customer Previous Due\", \"voucher_type\": \"Customer Previous Due\"}, \"journal_entry_id\": 61}', '2025-11-24 03:03:33');

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
(4, 'Journal Voucher', '2025-09-22', 'REF-000001', 'JV-000002', NULL, NULL, NULL, NULL, 1, NULL, 50000.00, 50000.00, 'pending', NULL, '2025-09-22 04:25:37', '2025-09-23 01:44:13'),
(21, 'Supplier Advance', '2025-09-23', 'REF-000004', 'SA-000001', 'Supplier Advance', 'Supplier Advance', 1, 'Supplier Advance', 1, NULL, 5000.00, 5000.00, 'pending', 1, '2025-09-23 01:52:16', '2025-09-23 01:52:16'),
(25, 'Supplier Previous Due', '2025-09-23', 'REF-000005', 'SPD-000001', 'Supplier Previous Due', 'Supplier Previous Due', 1, 'Supplier Previous Due', 1, NULL, 1500.00, 1500.00, 'pending', 1, '2025-09-23 02:51:15', '2025-09-23 02:51:15'),
(27, 'Supplier Advance', '2025-09-23', 'REF-000006', 'SA-000002', 'Supplier Advance', 'Supplier Advance', 3, 'Supplier Advance', 1, NULL, 1000.00, 1000.00, 'pending', 1, '2025-09-23 04:47:00', '2025-09-23 04:47:00'),
(30, 'Purchase', '2025-10-12', 'REF-000007', 'P-000001', 'Purchase', 'Purchase', 25, 'Purchase', 1, NULL, 7315.00, 7315.00, 'pending', 1, '2025-10-11 23:07:28', '2025-10-11 23:07:28'),
(38, 'Purchase', '2025-10-12', 'REF-000008', 'P-000002', 'Purchase', 'Purchase Voucher', 25, 'Purchase', 1, NULL, 7315.00, 7315.00, 'pending', 1, '2025-10-12 00:18:14', '2025-10-12 00:18:14'),
(41, 'Purchase Voucher', '2025-11-04', 'REF-000010', 'PV-000002', 'Purchase Voucher', 'Purchase Voucher', 30, 'Purchase Voucher', 1, NULL, 600.00, 600.00, 'pending', 1, '2025-11-04 01:29:28', '2025-11-04 01:29:28'),
(42, 'Purchase Voucher', '2025-11-04', 'REF-000011', 'PV-000003', 'Purchase Voucher', 'Purchase Voucher', 31, 'Purchase Voucher', 1, NULL, 200.00, 200.00, 'pending', 1, '2025-11-04 01:32:15', '2025-11-04 01:32:15'),
(43, 'Purchase Voucher', '2025-11-04', 'REF-000012', 'PV-000004', 'Purchase Voucher', 'Purchase Voucher', 32, 'Purchase Voucher', 1, NULL, 200.00, 200.00, 'pending', 1, '2025-11-04 01:32:33', '2025-11-04 01:32:33'),
(44, 'Purchase Voucher', '2025-11-04', 'REF-000013', 'PV-000005', 'Purchase Voucher', 'Purchase Voucher', 33, 'Purchase Voucher', 1, NULL, 300.00, 300.00, 'pending', 1, '2025-11-04 01:33:19', '2025-11-04 01:33:19'),
(45, 'Purchase Voucher', '2025-11-04', 'REF-000014', 'PV-000006', 'Purchase Voucher', 'Purchase Voucher', 34, 'Purchase Voucher', 1, NULL, 400.00, 400.00, 'pending', 1, '2025-11-04 01:50:18', '2025-11-04 01:50:18'),
(46, 'Purchase Voucher', '2025-11-04', 'REF-000015', 'PV-000007', 'Purchase Voucher', 'Purchase Voucher', 68, 'Purchase Voucher', 1, NULL, 121.70, 121.70, 'pending', 1, '2025-11-04 05:20:56', '2025-11-04 05:20:56'),
(47, 'Purchase Voucher', '2025-11-04', 'REF-000016', 'PV-000008', 'Purchase Voucher', 'Purchase Voucher', 72, 'Purchase Voucher', 1, NULL, 211.35, 211.35, 'pending', 1, '2025-11-04 05:33:27', '2025-11-04 05:33:27'),
(48, 'Purchase Voucher', '2025-11-04', 'REF-000017', 'PV-000009', 'Purchase Voucher', 'Purchase Voucher', 86, 'Purchase Voucher', 1, NULL, 215.00, 215.00, 'pending', 1, '2025-11-04 06:35:47', '2025-11-04 06:35:47'),
(49, 'Purchase Voucher', '2025-11-05', 'REF-000018', 'PV-000010', 'Purchase Voucher', 'Purchase Voucher', 87, 'Purchase Voucher', 1, NULL, 4254.20, 4254.20, 'pending', 1, '2025-11-04 22:54:00', '2025-11-04 22:54:00'),
(50, 'Purchase Voucher', '2025-11-05', 'REF-000019', 'PV-000011', 'Purchase Voucher', 'Purchase Voucher', 88, 'Purchase Voucher', 1, NULL, 4530.44, 4530.44, 'pending', 1, '2025-11-05 00:08:41', '2025-11-05 00:08:41'),
(51, 'Purchase Voucher', '2025-11-05', 'REF-000020', 'PV-000012', 'Purchase Voucher', 'Purchase Voucher', 89, 'Purchase Voucher', 1, NULL, 4020.00, 4020.00, 'pending', 1, '2025-11-05 00:47:10', '2025-11-05 00:47:10'),
(52, 'Purchase Voucher', '2025-11-05', 'REF-000021', 'PV-000013', 'Purchase Voucher', 'Purchase Voucher', 90, 'Purchase Voucher', 1, NULL, 6001.20, 6001.20, 'pending', 1, '2025-11-05 01:13:02', '2025-11-05 01:13:02'),
(53, 'Purchase Voucher', '2025-11-05', 'REF-000022', 'PV-000014', 'Purchase Voucher', 'Purchase Voucher', 91, 'Purchase Voucher', 1, NULL, 6080.00, 6080.00, 'pending', 1, '2025-11-05 01:18:07', '2025-11-05 01:18:07'),
(54, 'Purchase Voucher', '2025-11-05', 'REF-000023', 'PV-000015', 'Purchase Voucher', 'Purchase Voucher', 109, 'Purchase Voucher', 1, NULL, 6150.00, 6150.00, 'pending', 1, '2025-11-05 01:51:10', '2025-11-05 01:51:10'),
(56, 'Purchase Voucher', '2025-11-05', 'REF-000024', 'PV-000016', 'Purchase Voucher', 'Purchase Voucher', 110, 'Purchase Voucher', 1, NULL, 1627.50, 1627.50, 'pending', 1, '2025-11-05 03:25:03', '2025-11-05 03:25:03'),
(58, 'Purchase Voucher', '2025-11-24', 'REF-000025', 'PV-000017', 'Purchase Voucher', 'Purchase Voucher', 111, 'Purchase Voucher', 1, NULL, 1250.00, 1250.00, 'pending', 1, '2025-11-23 23:59:29', '2025-11-23 23:59:29'),
(60, 'Customer Advance', '2025-11-24', 'REF-000026', 'CA-000001', 'Customer Advance', 'Customer Advance', 3, 'Customer Advance', 1, NULL, 5000.00, 5000.00, 'pending', 1, '2025-11-24 01:38:53', '2025-11-24 01:38:53'),
(61, 'Customer Previous Due', '2025-11-24', 'REF-000027', 'CPD-000001', 'Customer Previous Due', 'Customer Previous Due', 1, 'Customer Previous Due', 1, NULL, 250.00, 250.00, 'pending', 1, '2025-11-24 03:03:33', '2025-11-24 03:03:33');

-- --------------------------------------------------------

--
-- Table structure for table `acc_journal_entry_details`
--

CREATE TABLE `acc_journal_entry_details` (
  `id` bigint UNSIGNED NOT NULL,
  `journal_entry_id` bigint UNSIGNED NOT NULL,
  `account_head_id` bigint UNSIGNED NOT NULL,
  `debit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `credit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `acc_journal_entry_details`
--

INSERT INTO `acc_journal_entry_details` (`id`, `journal_entry_id`, `account_head_id`, `debit`, `credit`, `remarks`, `created_at`, `updated_at`) VALUES
(31, 4, 6, 50000.00, 0.00, NULL, '2025-09-23 01:44:13', '2025-09-23 01:44:13'),
(32, 4, 9, 0.00, 50000.00, NULL, '2025-09-23 01:44:13', '2025-09-23 01:44:13'),
(37, 21, 6, 0.00, 5000.00, NULL, '2025-09-23 01:52:16', '2025-09-23 01:52:16'),
(38, 21, 20, 5000.00, 0.00, NULL, '2025-09-23 01:52:16', '2025-09-23 01:52:16'),
(45, 25, 41, 1500.00, 0.00, NULL, '2025-09-23 02:51:15', '2025-09-23 02:51:15'),
(46, 25, 8, 0.00, 1500.00, NULL, '2025-09-23 02:51:15', '2025-09-23 02:51:15'),
(49, 27, 6, 0.00, 1000.00, NULL, '2025-09-23 04:47:00', '2025-09-23 04:47:00'),
(50, 27, 20, 1000.00, 0.00, NULL, '2025-09-23 04:47:00', '2025-09-23 04:47:00'),
(61, 30, 38, 6300.00, 0.00, NULL, '2025-10-11 23:07:28', '2025-10-11 23:07:28'),
(62, 30, 40, 665.00, 0.00, NULL, '2025-10-11 23:07:28', '2025-10-11 23:07:28'),
(63, 30, 39, 350.00, 0.00, NULL, '2025-10-11 23:07:28', '2025-10-11 23:07:28'),
(64, 30, 6, 0.00, 500.00, NULL, '2025-10-11 23:07:28', '2025-10-11 23:07:28'),
(65, 30, 8, 0.00, 6815.00, NULL, '2025-10-11 23:07:28', '2025-10-11 23:07:28'),
(101, 38, 38, 6300.00, 0.00, NULL, '2025-10-12 00:18:14', '2025-10-12 00:18:14'),
(102, 38, 40, 665.00, 0.00, NULL, '2025-10-12 00:18:14', '2025-10-12 00:18:14'),
(103, 38, 39, 350.00, 0.00, NULL, '2025-10-12 00:18:14', '2025-10-12 00:18:14'),
(104, 38, 6, 0.00, 500.00, NULL, '2025-10-12 00:18:14', '2025-10-12 00:18:14'),
(105, 38, 8, 0.00, 6815.00, NULL, '2025-10-12 00:18:14', '2025-10-12 00:18:14'),
(116, 41, 38, 600.00, 0.00, NULL, '2025-11-04 01:29:28', '2025-11-04 01:29:28'),
(117, 41, 6, 0.00, 300.00, NULL, '2025-11-04 01:29:28', '2025-11-04 01:29:28'),
(118, 41, 8, 0.00, 300.00, NULL, '2025-11-04 01:29:28', '2025-11-04 01:29:28'),
(119, 42, 38, 200.00, 0.00, NULL, '2025-11-04 01:32:15', '2025-11-04 01:32:15'),
(120, 42, 6, 0.00, 200.00, NULL, '2025-11-04 01:32:15', '2025-11-04 01:32:15'),
(121, 43, 38, 200.00, 0.00, NULL, '2025-11-04 01:32:33', '2025-11-04 01:32:33'),
(122, 43, 6, 0.00, 200.00, NULL, '2025-11-04 01:32:33', '2025-11-04 01:32:33'),
(123, 44, 38, 300.00, 0.00, NULL, '2025-11-04 01:33:19', '2025-11-04 01:33:19'),
(124, 44, 6, 0.00, 300.00, NULL, '2025-11-04 01:33:19', '2025-11-04 01:33:19'),
(125, 45, 38, 400.00, 0.00, NULL, '2025-11-04 01:50:18', '2025-11-04 01:50:18'),
(126, 45, 6, 0.00, 400.00, NULL, '2025-11-04 01:50:18', '2025-11-04 01:50:18'),
(127, 46, 38, 100.00, 0.00, NULL, '2025-11-04 05:20:56', '2025-11-04 05:20:56'),
(128, 46, 40, 21.70, 0.00, NULL, '2025-11-04 05:20:56', '2025-11-04 05:20:56'),
(129, 46, 39, 0.00, 40.00, NULL, '2025-11-04 05:20:56', '2025-11-04 05:20:56'),
(130, 46, 6, 0.00, 30.00, NULL, '2025-11-04 05:20:56', '2025-11-04 05:20:56'),
(131, 46, 8, 0.00, 51.70, NULL, '2025-11-04 05:20:56', '2025-11-04 05:20:56'),
(132, 47, 38, 200.00, 0.00, NULL, '2025-11-04 05:33:27', '2025-11-04 05:33:27'),
(133, 47, 40, 11.35, 0.00, NULL, '2025-11-04 05:33:27', '2025-11-04 05:33:27'),
(134, 47, 39, 0.00, 37.00, NULL, '2025-11-04 05:33:27', '2025-11-04 05:33:27'),
(135, 47, 8, 0.00, 174.35, NULL, '2025-11-04 05:33:27', '2025-11-04 05:33:27'),
(136, 48, 38, 200.00, 0.00, NULL, '2025-11-04 06:35:47', '2025-11-04 06:35:47'),
(137, 48, 40, 15.00, 0.00, NULL, '2025-11-04 06:35:47', '2025-11-04 06:35:47'),
(138, 48, 39, 0.00, 45.00, NULL, '2025-11-04 06:35:47', '2025-11-04 06:35:47'),
(139, 48, 20, 0.00, 170.00, NULL, '2025-11-04 06:35:47', '2025-11-04 06:35:47'),
(140, 49, 38, 4250.00, 0.00, NULL, '2025-11-04 22:54:00', '2025-11-04 22:54:00'),
(141, 49, 40, 4.20, 0.00, NULL, '2025-11-04 22:54:00', '2025-11-04 22:54:00'),
(142, 49, 39, 0.00, 74.70, NULL, '2025-11-04 22:54:00', '2025-11-04 22:54:00'),
(143, 49, 6, 0.00, 4000.00, NULL, '2025-11-04 22:54:00', '2025-11-04 22:54:00'),
(144, 49, 8, 0.00, 179.50, NULL, '2025-11-04 22:54:00', '2025-11-04 22:54:00'),
(145, 50, 38, 4500.00, 0.00, NULL, '2025-11-05 00:08:41', '2025-11-05 00:08:41'),
(146, 50, 40, 30.44, 0.00, NULL, '2025-11-05 00:08:41', '2025-11-05 00:08:41'),
(147, 50, 39, 0.00, 140.00, NULL, '2025-11-05 00:08:41', '2025-11-05 00:08:41'),
(148, 50, 6, 0.00, 4000.00, NULL, '2025-11-05 00:08:41', '2025-11-05 00:08:41'),
(149, 50, 8, 0.00, 390.44, NULL, '2025-11-05 00:08:41', '2025-11-05 00:08:41'),
(150, 51, 38, 4000.00, 0.00, NULL, '2025-11-05 00:47:10', '2025-11-05 00:47:10'),
(151, 51, 40, 20.00, 0.00, NULL, '2025-11-05 00:47:10', '2025-11-05 00:47:10'),
(152, 51, 39, 0.00, 110.00, NULL, '2025-11-05 00:47:10', '2025-11-05 00:47:10'),
(153, 51, 6, 0.00, 3000.00, NULL, '2025-11-05 00:47:10', '2025-11-05 00:47:10'),
(154, 51, 8, 0.00, 910.00, NULL, '2025-11-05 00:47:10', '2025-11-05 00:47:10'),
(155, 52, 38, 6000.00, 0.00, NULL, '2025-11-05 01:13:02', '2025-11-05 01:13:02'),
(156, 52, 40, 1.20, 0.00, NULL, '2025-11-05 01:13:02', '2025-11-05 01:13:02'),
(157, 52, 39, 0.00, 160.00, NULL, '2025-11-05 01:13:02', '2025-11-05 01:13:02'),
(158, 52, 6, 0.00, 5000.00, NULL, '2025-11-05 01:13:02', '2025-11-05 01:13:02'),
(159, 52, 8, 0.00, 841.20, NULL, '2025-11-05 01:13:02', '2025-11-05 01:13:02'),
(160, 53, 38, 6000.00, 0.00, NULL, '2025-11-05 01:18:07', '2025-11-05 01:18:07'),
(161, 53, 40, 80.00, 0.00, NULL, '2025-11-05 01:18:07', '2025-11-05 01:18:07'),
(162, 53, 39, 0.00, 170.00, NULL, '2025-11-05 01:18:07', '2025-11-05 01:18:07'),
(163, 53, 6, 0.00, 5000.00, NULL, '2025-11-05 01:18:07', '2025-11-05 01:18:07'),
(164, 53, 8, 0.00, 910.00, NULL, '2025-11-05 01:18:07', '2025-11-05 01:18:07'),
(165, 54, 38, 6000.00, 0.00, NULL, '2025-11-05 01:51:10', '2025-11-05 01:51:10'),
(166, 54, 40, 150.00, 0.00, NULL, '2025-11-05 01:51:10', '2025-11-05 01:51:10'),
(167, 54, 39, 0.00, 250.00, NULL, '2025-11-05 01:51:10', '2025-11-05 01:51:10'),
(168, 54, 6, 0.00, 5000.00, NULL, '2025-11-05 01:51:10', '2025-11-05 01:51:10'),
(169, 54, 8, 0.00, 900.00, NULL, '2025-11-05 01:51:10', '2025-11-05 01:51:10'),
(175, 56, 38, 1500.00, 0.00, NULL, '2025-11-05 03:25:03', '2025-11-05 03:25:03'),
(176, 56, 40, 127.50, 0.00, NULL, '2025-11-05 03:25:03', '2025-11-05 03:25:03'),
(177, 56, 39, 0.00, 227.50, NULL, '2025-11-05 03:25:03', '2025-11-05 03:25:03'),
(178, 56, 6, 0.00, 1000.00, NULL, '2025-11-05 03:25:03', '2025-11-05 03:25:03'),
(179, 56, 8, 0.00, 400.00, NULL, '2025-11-05 03:25:03', '2025-11-05 03:25:03'),
(182, 58, 38, 1250.00, 0.00, NULL, '2025-11-23 23:59:29', '2025-11-23 23:59:29'),
(183, 58, 20, 0.00, 1250.00, NULL, '2025-11-23 23:59:29', '2025-11-23 23:59:29'),
(186, 60, 6, 5000.00, 0.00, NULL, '2025-11-24 01:38:53', '2025-11-24 01:38:53'),
(187, 60, 36, 0.00, 5000.00, NULL, '2025-11-24 01:38:53', '2025-11-24 01:38:53'),
(188, 61, 42, 250.00, 0.00, NULL, '2025-11-24 03:03:33', '2025-11-24 03:03:33'),
(189, 61, 41, 0.00, 250.00, NULL, '2025-11-24 03:03:33', '2025-11-24 03:03:33');

-- --------------------------------------------------------

--
-- Table structure for table `acc_module_entries`
--

CREATE TABLE `acc_module_entries` (
  `id` bigint UNSIGNED NOT NULL,
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

INSERT INTO `acc_module_entries` (`id`, `module_name`, `entry_type`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Inventory', 'Sales Voucher', 'Account entries for sales invoices', 1, '2025-09-20 06:58:55', '2025-09-20 06:58:55'),
(2, 'Purchase Voucher', 'Purchase Voucher', 'Purchase invoice related', 1, '2025-09-20 07:16:15', '2025-10-12 00:39:10'),
(5, 'Supplier Advance', 'Supplier Advance', 'Advance given to supplier', 1, '2025-09-21 22:47:45', '2025-09-22 04:16:56'),
(6, 'Supplier Previous Due', 'Supplier Previous Due', 'Supplier Previous Due', 1, '2025-09-22 23:18:35', '2025-09-22 23:18:35'),
(7, 'Customer Advance', 'Customer Advance', 'Advance given to customer', 1, '2025-11-24 01:37:20', '2025-11-24 01:37:20'),
(8, 'Customer Previous Due', 'Customer Previous Due', 'Customer Previous Due', 1, '2025-11-24 03:03:23', '2025-11-24 03:03:23');

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
(1, 1, 'Cash', 6, 0, 'Cash received from customer', '2025-09-20 06:58:55', '2025-09-20 06:58:55'),
(2, 1, 'Revenue', 10, 0, 'Sales revenue account', '2025-09-20 06:58:55', '2025-09-20 06:58:55'),
(3, 1, 'Discount', 11, 0, 'Sales discount given', '2025-09-20 06:58:55', '2025-09-20 06:58:55'),
(4, 1, 'COGS', 34, 0, 'Cost of goods sold', '2025-09-20 06:58:55', '2025-09-20 06:58:55'),
(5, 1, 'Inventory', 38, 0, 'Inventory asset reduction', '2025-09-20 06:58:55', '2025-09-20 06:58:55'),
(6, 1, 'Customer Advance', 36, 0, 'Customer advance adjustment', '2025-09-20 06:58:55', '2025-09-20 06:58:55'),
(7, 1, 'Due', 37, 0, 'Amount due from customer', '2025-09-20 06:58:55', '2025-09-20 06:58:55'),
(8, 1, 'Tax', 35, 0, 'Tax collected from customer', '2025-09-20 06:58:55', '2025-09-20 06:58:55'),
(53, 5, 'amount', 6, 0, 'Cash paid to supplier', '2025-09-22 04:28:07', '2025-09-22 04:28:07'),
(54, 5, 'amount', 20, 1, 'Supplier account credited', '2025-09-22 04:28:07', '2025-09-22 04:28:07'),
(57, 6, 'amount', 41, 1, 'Previous Due (Debit)', '2025-09-23 01:14:05', '2025-09-23 01:14:05'),
(58, 6, 'amount', 8, 0, 'Supplier Liability (Credit)', '2025-09-23 01:14:05', '2025-09-23 01:14:05'),
(95, 2, 'inventory', 38, 1, 'Inventory increase', '2025-11-04 05:19:06', '2025-11-04 05:19:06'),
(96, 2, 'tax_amount', 40, 1, 'Purchase tax (input VAT)', '2025-11-04 05:19:06', '2025-11-04 05:19:06'),
(97, 2, 'discount_amount', 39, 0, 'Purchase discount', '2025-11-04 05:19:06', '2025-11-04 05:19:06'),
(98, 2, 'paid_amount', 6, 0, 'Cash paid to supplier', '2025-11-04 05:19:06', '2025-11-04 05:19:06'),
(99, 2, 'supplier_advance', 20, 0, 'Advance adjusted', '2025-11-04 05:19:06', '2025-11-04 05:19:06'),
(100, 2, 'due_amount', 8, 0, 'Payable due to supplier', '2025-11-04 05:19:06', '2025-11-04 05:19:06'),
(101, 7, 'amount', 6, 1, 'Cash paid to customer', '2025-11-24 01:37:20', '2025-11-24 01:37:20'),
(102, 7, 'amount', 36, 0, 'Customer account credited', '2025-11-24 01:37:20', '2025-11-24 01:37:20'),
(103, 8, 'amount', 42, 1, 'Previous Due (Debit)', '2025-11-24 03:03:23', '2025-11-24 03:03:23'),
(104, 8, 'amount', 41, 0, 'Customer Liability (Credit)', '2025-11-24 03:03:23', '2025-11-24 03:03:23');

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
(1, 'journal', 'Journal Voucher', 'General adjusting entry', 1, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(2, 'payment', 'Payment Voucher', 'Outgoing payment', 1, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(3, 'receipt', 'Receipt Voucher', 'Incoming payment', 1, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(4, 'sales', 'Sales Voucher', 'Sales invoice related', NULL, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(5, 'purchase', 'Purchase Voucher', 'Purchase invoice related', NULL, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(6, 'contra', 'Contra Voucher', 'Cash to bank or bank to cash', 1, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(7, 'credit_note', 'Credit Note', 'Sales return or discount', NULL, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02'),
(8, 'debit_note', 'Debit Note', 'Purchase return or extra billing', NULL, 1, '2025-09-04 06:48:02', '2025-09-04 06:48:02');

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
(52, 'Setting', 2, NULL, 'fas fa-cog', NULL, 4, NULL, 1, '2025-08-26 03:46:56', '2025-11-04 03:13:19'),
(53, 'Category', 2, 'inventory/categories', NULL, 52, 3, 'api.inventory.categories.index', 1, '2025-08-26 03:47:35', '2025-11-04 03:13:19'),
(54, 'Unit', 2, 'inventory/units', NULL, 52, 4, 'api.inventory.units.index', 1, '2025-08-26 04:20:41', '2025-11-04 03:13:19'),
(55, 'Brand', 2, 'inventory/brands', NULL, 52, 5, 'api.inventory.brands.index', 1, '2025-08-26 04:23:25', '2025-11-04 03:13:19'),
(56, 'Supplier', 2, NULL, 'fas fa-warehouse', NULL, 2, NULL, 1, '2025-08-28 03:17:14', '2025-11-04 03:13:19'),
(57, 'Customer', 2, NULL, 'fas fa-users', NULL, 3, NULL, 1, '2025-08-28 03:17:51', '2025-11-04 03:13:19'),
(58, 'Supplier', 2, 'inventory/suppliers', NULL, 56, 1, 'api.inventory.suppliers.index', 1, '2025-08-28 03:28:45', '2025-11-04 03:13:19'),
(59, 'Customer', 2, 'inventory/customers', NULL, 57, 1, 'api.inventory.customers.index', 1, '2025-08-28 03:40:36', '2025-11-04 03:13:19'),
(60, 'Product', 2, 'inventory/products', NULL, 52, 1, 'api.inventory.products.index', 1, '2025-08-28 04:18:23', '2025-11-04 03:13:19'),
(61, 'Product Set', 2, 'inventory/product-sets', NULL, 52, 2, 'api.inventory.product-sets.index', 1, '2025-09-04 03:28:43', '2025-11-04 03:13:19'),
(62, 'Chart of Accounts', 3, 'accounting/chart-of-accounts', 'fas fa-chart-line', NULL, 3, 'api.accounting.chart-of-accounts.index', 1, '2025-09-08 00:56:47', '2025-09-11 00:18:27'),
(63, 'Voucher Posting', 3, 'accounting/voucher-posting', 'fas fa-receipt', NULL, 1, 'api.accounting.journal-entries.index', 1, '2025-09-10 00:52:25', '2025-09-11 00:18:27'),
(64, 'Account Module', 3, 'accounting/account-modules', 'fas fa-project-diagram', NULL, 2, 'api.accounting.account-modules.index', 1, '2025-09-11 00:17:57', '2025-09-11 00:18:27'),
(65, 'Supplier Advance', 2, 'inventory/supplier-advance', NULL, 56, 2, 'api.inventory.supplier-advance.index', 1, '2025-09-23 04:54:19', '2025-11-04 03:13:19'),
(66, 'Purchase', 2, 'inventory/purchases', 'fas fa-shopping-bag', NULL, 1, 'api.inventory.purchases.index', 1, '2025-11-04 03:13:07', '2025-11-24 07:16:21'),
(67, 'Purchase', 2, 'inventory/purchases', NULL, 66, 1, 'api.inventory.purchases.index', 1, '2025-11-04 03:15:56', '2025-11-24 07:16:26');

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
('world_vision_enterprice_cache_spatie.permission.cache', 'a:3:{s:5:\"alias\";a:8:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:12:\"display_name\";s:1:\"d\";s:10:\"guard_name\";s:1:\"e\";s:8:\"group_id\";s:1:\"r\";s:5:\"roles\";s:1:\"j\";s:12:\"redirect_url\";s:1:\"k\";s:9:\"direction\";}s:11:\"permissions\";a:101:{i:0;a:6:{s:1:\"a\";i:1;s:1:\"b\";s:19:\"api.core.user-menus\";s:1:\"c\";s:19:\"Api Core User-menus\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:1;s:1:\"r\";a:1:{i:0;i:1;}}i:1;a:6:{s:1:\"a\";i:2;s:1:\"b\";s:24:\"api.core.settings.update\";s:1:\"c\";s:24:\"Api Core Settings Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:2;s:1:\"r\";a:1:{i:0;i:1;}}i:2;a:6:{s:1:\"a\";i:3;s:1:\"b\";s:20:\"api.core.users.index\";s:1:\"c\";s:20:\"Api Core Users Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:3;s:1:\"r\";a:1:{i:0;i:1;}}i:3;a:6:{s:1:\"a\";i:4;s:1:\"b\";s:20:\"api.core.users.store\";s:1:\"c\";s:20:\"Api Core Users Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:3;s:1:\"r\";a:1:{i:0;i:1;}}i:4;a:6:{s:1:\"a\";i:5;s:1:\"b\";s:19:\"api.core.users.show\";s:1:\"c\";s:19:\"Api Core Users Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:3;s:1:\"r\";a:1:{i:0;i:1;}}i:5;a:6:{s:1:\"a\";i:6;s:1:\"b\";s:21:\"api.core.users.update\";s:1:\"c\";s:21:\"Api Core Users Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:3;s:1:\"r\";a:1:{i:0;i:1;}}i:6;a:6:{s:1:\"a\";i:7;s:1:\"b\";s:22:\"api.core.users.destroy\";s:1:\"c\";s:22:\"Api Core Users Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:3;s:1:\"r\";a:1:{i:0;i:1;}}i:7;a:6:{s:1:\"a\";i:8;s:1:\"b\";s:20:\"api.core.roles.index\";s:1:\"c\";s:20:\"Api Core Roles Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:4;s:1:\"r\";a:1:{i:0;i:1;}}i:8;a:6:{s:1:\"a\";i:9;s:1:\"b\";s:20:\"api.core.roles.store\";s:1:\"c\";s:20:\"Api Core Roles Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:4;s:1:\"r\";a:1:{i:0;i:1;}}i:9;a:6:{s:1:\"a\";i:10;s:1:\"b\";s:19:\"api.core.roles.show\";s:1:\"c\";s:19:\"Api Core Roles Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:4;s:1:\"r\";a:1:{i:0;i:1;}}i:10;a:6:{s:1:\"a\";i:11;s:1:\"b\";s:21:\"api.core.roles.update\";s:1:\"c\";s:21:\"Api Core Roles Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:4;s:1:\"r\";a:1:{i:0;i:1;}}i:11;a:6:{s:1:\"a\";i:12;s:1:\"b\";s:22:\"api.core.roles.destroy\";s:1:\"c\";s:22:\"Api Core Roles Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:4;s:1:\"r\";a:1:{i:0;i:1;}}i:12;a:6:{s:1:\"a\";i:13;s:1:\"b\";s:22:\"api.core.modules.index\";s:1:\"c\";s:22:\"Api Core Modules Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:5;s:1:\"r\";a:1:{i:0;i:1;}}i:13;a:6:{s:1:\"a\";i:14;s:1:\"b\";s:22:\"api.core.modules.store\";s:1:\"c\";s:22:\"Api Core Modules Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:5;s:1:\"r\";a:1:{i:0;i:1;}}i:14;a:6:{s:1:\"a\";i:15;s:1:\"b\";s:21:\"api.core.modules.show\";s:1:\"c\";s:21:\"Api Core Modules Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:5;s:1:\"r\";a:1:{i:0;i:1;}}i:15;a:6:{s:1:\"a\";i:16;s:1:\"b\";s:23:\"api.core.modules.update\";s:1:\"c\";s:23:\"Api Core Modules Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:5;s:1:\"r\";a:1:{i:0;i:1;}}i:16;a:6:{s:1:\"a\";i:17;s:1:\"b\";s:24:\"api.core.modules.destroy\";s:1:\"c\";s:24:\"Api Core Modules Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:5;s:1:\"r\";a:1:{i:0;i:1;}}i:17;a:6:{s:1:\"a\";i:18;s:1:\"b\";s:27:\"api.core.admin-menus.parent\";s:1:\"c\";s:27:\"Api Core Admin-menus Parent\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:6;s:1:\"r\";a:1:{i:0;i:1;}}i:18;a:6:{s:1:\"a\";i:19;s:1:\"b\";s:28:\"api.core.admin-menus.reorder\";s:1:\"c\";s:28:\"Api Core Admin-menus Reorder\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:6;s:1:\"r\";a:1:{i:0;i:1;}}i:19;a:6:{s:1:\"a\";i:20;s:1:\"b\";s:26:\"api.core.admin-menus.index\";s:1:\"c\";s:26:\"Api Core Admin-menus Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:6;s:1:\"r\";a:1:{i:0;i:1;}}i:20;a:6:{s:1:\"a\";i:21;s:1:\"b\";s:26:\"api.core.admin-menus.store\";s:1:\"c\";s:26:\"Api Core Admin-menus Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:6;s:1:\"r\";a:1:{i:0;i:1;}}i:21;a:6:{s:1:\"a\";i:22;s:1:\"b\";s:25:\"api.core.admin-menus.show\";s:1:\"c\";s:25:\"Api Core Admin-menus Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:6;s:1:\"r\";a:1:{i:0;i:1;}}i:22;a:6:{s:1:\"a\";i:23;s:1:\"b\";s:27:\"api.core.admin-menus.update\";s:1:\"c\";s:27:\"Api Core Admin-menus Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:6;s:1:\"r\";a:1:{i:0;i:1;}}i:23;a:6:{s:1:\"a\";i:24;s:1:\"b\";s:28:\"api.core.admin-menus.destroy\";s:1:\"c\";s:28:\"Api Core Admin-menus Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:6;s:1:\"r\";a:1:{i:0;i:1;}}i:24;a:6:{s:1:\"a\";i:25;s:1:\"b\";s:28:\"api.core.permission.sections\";s:1:\"c\";s:28:\"Api Core Permission Sections\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:7;s:1:\"r\";a:1:{i:0;i:1;}}i:25;a:6:{s:1:\"a\";i:26;s:1:\"b\";s:31:\"api.core.permission.permissions\";s:1:\"c\";s:31:\"Api Core Permission Permissions\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:7;s:1:\"r\";a:1:{i:0;i:1;}}i:26;a:6:{s:1:\"a\";i:27;s:1:\"b\";s:25:\"api.core.permission.store\";s:1:\"c\";s:25:\"Api Core Permission Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:7;s:1:\"r\";a:1:{i:0;i:1;}}i:27;a:6:{s:1:\"a\";i:28;s:1:\"b\";s:26:\"api.core.permission.assign\";s:1:\"c\";s:26:\"Api Core Permission Assign\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:7;s:1:\"r\";a:1:{i:0;i:1;}}i:28;a:6:{s:1:\"a\";i:30;s:1:\"b\";s:23:\"api.core.branches.index\";s:1:\"c\";s:23:\"Api Core Branches Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:9;s:1:\"r\";a:1:{i:0;i:1;}}i:29;a:6:{s:1:\"a\";i:31;s:1:\"b\";s:23:\"api.core.branches.store\";s:1:\"c\";s:23:\"Api Core Branches Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:9;s:1:\"r\";a:1:{i:0;i:1;}}i:30;a:6:{s:1:\"a\";i:32;s:1:\"b\";s:22:\"api.core.branches.show\";s:1:\"c\";s:22:\"Api Core Branches Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:9;s:1:\"r\";a:1:{i:0;i:1;}}i:31;a:6:{s:1:\"a\";i:33;s:1:\"b\";s:24:\"api.core.branches.update\";s:1:\"c\";s:24:\"Api Core Branches Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:9;s:1:\"r\";a:1:{i:0;i:1;}}i:32;a:6:{s:1:\"a\";i:34;s:1:\"b\";s:25:\"api.core.branches.destroy\";s:1:\"c\";s:25:\"Api Core Branches Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:9;s:1:\"r\";a:1:{i:0;i:1;}}i:33;a:6:{s:1:\"a\";i:36;s:1:\"b\";s:20:\"api.core..food-lists\";s:1:\"c\";s:20:\"Api Core  Food-lists\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:10;s:1:\"r\";a:1:{i:0;i:1;}}i:34;a:6:{s:1:\"a\";i:37;s:1:\"b\";s:9:\"api.core.\";s:1:\"c\";s:9:\"Api Core \";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:10;s:1:\"r\";a:1:{i:0;i:1;}}i:35;a:6:{s:1:\"a\";i:38;s:1:\"b\";s:30:\"api.inventory.categories.index\";s:1:\"c\";s:30:\"Api Inventory Categories Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:11;s:1:\"r\";a:1:{i:0;i:1;}}i:36;a:6:{s:1:\"a\";i:39;s:1:\"b\";s:30:\"api.inventory.categories.store\";s:1:\"c\";s:30:\"Api Inventory Categories Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:11;s:1:\"r\";a:1:{i:0;i:1;}}i:37;a:6:{s:1:\"a\";i:40;s:1:\"b\";s:29:\"api.inventory.categories.show\";s:1:\"c\";s:29:\"Api Inventory Categories Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:11;s:1:\"r\";a:1:{i:0;i:1;}}i:38;a:6:{s:1:\"a\";i:41;s:1:\"b\";s:31:\"api.inventory.categories.update\";s:1:\"c\";s:31:\"Api Inventory Categories Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:11;s:1:\"r\";a:1:{i:0;i:1;}}i:39;a:6:{s:1:\"a\";i:42;s:1:\"b\";s:32:\"api.inventory.categories.destroy\";s:1:\"c\";s:32:\"Api Inventory Categories Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:11;s:1:\"r\";a:1:{i:0;i:1;}}i:40;a:6:{s:1:\"a\";i:43;s:1:\"b\";s:25:\"api.inventory.units.index\";s:1:\"c\";s:25:\"Api Inventory Units Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:12;s:1:\"r\";a:1:{i:0;i:1;}}i:41;a:6:{s:1:\"a\";i:44;s:1:\"b\";s:25:\"api.inventory.units.store\";s:1:\"c\";s:25:\"Api Inventory Units Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:12;s:1:\"r\";a:1:{i:0;i:1;}}i:42;a:6:{s:1:\"a\";i:45;s:1:\"b\";s:24:\"api.inventory.units.show\";s:1:\"c\";s:24:\"Api Inventory Units Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:12;s:1:\"r\";a:1:{i:0;i:1;}}i:43;a:6:{s:1:\"a\";i:46;s:1:\"b\";s:26:\"api.inventory.units.update\";s:1:\"c\";s:26:\"Api Inventory Units Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:12;s:1:\"r\";a:1:{i:0;i:1;}}i:44;a:6:{s:1:\"a\";i:47;s:1:\"b\";s:27:\"api.inventory.units.destroy\";s:1:\"c\";s:27:\"Api Inventory Units Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:12;s:1:\"r\";a:1:{i:0;i:1;}}i:45;a:6:{s:1:\"a\";i:48;s:1:\"b\";s:26:\"api.inventory.brands.index\";s:1:\"c\";s:26:\"Api Inventory Brands Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:13;s:1:\"r\";a:1:{i:0;i:1;}}i:46;a:6:{s:1:\"a\";i:49;s:1:\"b\";s:26:\"api.inventory.brands.store\";s:1:\"c\";s:26:\"Api Inventory Brands Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:13;s:1:\"r\";a:1:{i:0;i:1;}}i:47;a:6:{s:1:\"a\";i:50;s:1:\"b\";s:25:\"api.inventory.brands.show\";s:1:\"c\";s:25:\"Api Inventory Brands Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:13;s:1:\"r\";a:1:{i:0;i:1;}}i:48;a:6:{s:1:\"a\";i:51;s:1:\"b\";s:27:\"api.inventory.brands.update\";s:1:\"c\";s:27:\"Api Inventory Brands Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:13;s:1:\"r\";a:1:{i:0;i:1;}}i:49;a:6:{s:1:\"a\";i:52;s:1:\"b\";s:28:\"api.inventory.brands.destroy\";s:1:\"c\";s:28:\"Api Inventory Brands Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:13;s:1:\"r\";a:1:{i:0;i:1;}}i:50;a:6:{s:1:\"a\";i:53;s:1:\"b\";s:28:\"api.inventory.products.index\";s:1:\"c\";s:28:\"Api Inventory Products Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:14;s:1:\"r\";a:1:{i:0;i:1;}}i:51;a:6:{s:1:\"a\";i:54;s:1:\"b\";s:28:\"api.inventory.products.store\";s:1:\"c\";s:28:\"Api Inventory Products Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:14;s:1:\"r\";a:1:{i:0;i:1;}}i:52;a:6:{s:1:\"a\";i:55;s:1:\"b\";s:27:\"api.inventory.products.show\";s:1:\"c\";s:27:\"Api Inventory Products Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:14;s:1:\"r\";a:1:{i:0;i:1;}}i:53;a:6:{s:1:\"a\";i:56;s:1:\"b\";s:29:\"api.inventory.products.update\";s:1:\"c\";s:29:\"Api Inventory Products Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:14;s:1:\"r\";a:1:{i:0;i:1;}}i:54;a:6:{s:1:\"a\";i:57;s:1:\"b\";s:30:\"api.inventory.products.destroy\";s:1:\"c\";s:30:\"Api Inventory Products Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:14;s:1:\"r\";a:1:{i:0;i:1;}}i:55;a:6:{s:1:\"a\";i:58;s:1:\"b\";s:29:\"api.inventory.suppliers.index\";s:1:\"c\";s:29:\"Api Inventory Suppliers Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:15;s:1:\"r\";a:1:{i:0;i:1;}}i:56;a:6:{s:1:\"a\";i:59;s:1:\"b\";s:29:\"api.inventory.suppliers.store\";s:1:\"c\";s:29:\"Api Inventory Suppliers Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:15;s:1:\"r\";a:1:{i:0;i:1;}}i:57;a:6:{s:1:\"a\";i:60;s:1:\"b\";s:28:\"api.inventory.suppliers.show\";s:1:\"c\";s:28:\"Api Inventory Suppliers Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:15;s:1:\"r\";a:1:{i:0;i:1;}}i:58;a:6:{s:1:\"a\";i:61;s:1:\"b\";s:30:\"api.inventory.suppliers.update\";s:1:\"c\";s:30:\"Api Inventory Suppliers Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:15;s:1:\"r\";a:1:{i:0;i:1;}}i:59;a:6:{s:1:\"a\";i:62;s:1:\"b\";s:31:\"api.inventory.suppliers.destroy\";s:1:\"c\";s:31:\"Api Inventory Suppliers Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:15;s:1:\"r\";a:1:{i:0;i:1;}}i:60;a:6:{s:1:\"a\";i:63;s:1:\"b\";s:29:\"api.inventory.customers.index\";s:1:\"c\";s:29:\"Api Inventory Customers Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:16;s:1:\"r\";a:1:{i:0;i:1;}}i:61;a:6:{s:1:\"a\";i:64;s:1:\"b\";s:29:\"api.inventory.customers.store\";s:1:\"c\";s:29:\"Api Inventory Customers Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:16;s:1:\"r\";a:1:{i:0;i:1;}}i:62;a:6:{s:1:\"a\";i:65;s:1:\"b\";s:28:\"api.inventory.customers.show\";s:1:\"c\";s:28:\"Api Inventory Customers Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:16;s:1:\"r\";a:1:{i:0;i:1;}}i:63;a:6:{s:1:\"a\";i:66;s:1:\"b\";s:30:\"api.inventory.customers.update\";s:1:\"c\";s:30:\"Api Inventory Customers Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:16;s:1:\"r\";a:1:{i:0;i:1;}}i:64;a:6:{s:1:\"a\";i:67;s:1:\"b\";s:31:\"api.inventory.customers.destroy\";s:1:\"c\";s:31:\"Api Inventory Customers Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:16;s:1:\"r\";a:1:{i:0;i:1;}}i:65;a:6:{s:1:\"a\";i:68;s:1:\"b\";s:32:\"api.inventory.product-sets.index\";s:1:\"c\";s:32:\"Api Inventory Product-sets Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:17;s:1:\"r\";a:1:{i:0;i:1;}}i:66;a:6:{s:1:\"a\";i:69;s:1:\"b\";s:32:\"api.inventory.product-sets.store\";s:1:\"c\";s:32:\"Api Inventory Product-sets Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:17;s:1:\"r\";a:1:{i:0;i:1;}}i:67;a:6:{s:1:\"a\";i:70;s:1:\"b\";s:31:\"api.inventory.product-sets.show\";s:1:\"c\";s:31:\"Api Inventory Product-sets Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:17;s:1:\"r\";a:1:{i:0;i:1;}}i:68;a:6:{s:1:\"a\";i:71;s:1:\"b\";s:33:\"api.inventory.product-sets.update\";s:1:\"c\";s:33:\"Api Inventory Product-sets Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:17;s:1:\"r\";a:1:{i:0;i:1;}}i:69;a:6:{s:1:\"a\";i:72;s:1:\"b\";s:34:\"api.inventory.product-sets.destroy\";s:1:\"c\";s:34:\"Api Inventory Product-sets Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:17;s:1:\"r\";a:1:{i:0;i:1;}}i:70;a:6:{s:1:\"a\";i:73;s:1:\"b\";s:38:\"api.accounting.chart-of-accounts.index\";s:1:\"c\";s:38:\"Api Accounting Chart-of-accounts Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:18;s:1:\"r\";a:1:{i:0;i:1;}}i:71;a:6:{s:1:\"a\";i:74;s:1:\"b\";s:38:\"api.accounting.chart-of-accounts.store\";s:1:\"c\";s:38:\"Api Accounting Chart-of-accounts Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:18;s:1:\"r\";a:1:{i:0;i:1;}}i:72;a:6:{s:1:\"a\";i:75;s:1:\"b\";s:37:\"api.accounting.chart-of-accounts.show\";s:1:\"c\";s:37:\"Api Accounting Chart-of-accounts Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:18;s:1:\"r\";a:1:{i:0;i:1;}}i:73;a:6:{s:1:\"a\";i:76;s:1:\"b\";s:39:\"api.accounting.chart-of-accounts.update\";s:1:\"c\";s:39:\"Api Accounting Chart-of-accounts Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:18;s:1:\"r\";a:1:{i:0;i:1;}}i:74;a:6:{s:1:\"a\";i:77;s:1:\"b\";s:40:\"api.accounting.chart-of-accounts.destroy\";s:1:\"c\";s:40:\"Api Accounting Chart-of-accounts Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:18;s:1:\"r\";a:1:{i:0;i:1;}}i:75;a:6:{s:1:\"a\";i:78;s:1:\"b\";s:28:\"api.accounting.account-heads\";s:1:\"c\";s:28:\"Api Accounting Account-heads\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:19;s:1:\"r\";a:1:{i:0;i:1;}}i:76;a:6:{s:1:\"a\";i:79;s:1:\"b\";s:28:\"api.accounting.voucher-types\";s:1:\"c\";s:28:\"Api Accounting Voucher-types\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:20;s:1:\"r\";a:1:{i:0;i:1;}}i:77;a:6:{s:1:\"a\";i:80;s:1:\"b\";s:36:\"api.accounting.journal-entries.index\";s:1:\"c\";s:36:\"Api Accounting Journal-entries Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:21;s:1:\"r\";a:1:{i:0;i:1;}}i:78;a:6:{s:1:\"a\";i:81;s:1:\"b\";s:36:\"api.accounting.journal-entries.store\";s:1:\"c\";s:36:\"Api Accounting Journal-entries Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:21;s:1:\"r\";a:1:{i:0;i:1;}}i:79;a:6:{s:1:\"a\";i:82;s:1:\"b\";s:35:\"api.accounting.journal-entries.show\";s:1:\"c\";s:35:\"Api Accounting Journal-entries Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:21;s:1:\"r\";a:1:{i:0;i:1;}}i:80;a:6:{s:1:\"a\";i:83;s:1:\"b\";s:37:\"api.accounting.journal-entries.update\";s:1:\"c\";s:37:\"Api Accounting Journal-entries Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:21;s:1:\"r\";a:1:{i:0;i:1;}}i:81;a:6:{s:1:\"a\";i:84;s:1:\"b\";s:38:\"api.accounting.journal-entries.destroy\";s:1:\"c\";s:38:\"Api Accounting Journal-entries Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:21;s:1:\"r\";a:1:{i:0;i:1;}}i:82;a:6:{s:1:\"a\";i:85;s:1:\"b\";s:36:\"api.accounting.account-modules.index\";s:1:\"c\";s:36:\"Api Accounting Account-modules Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:22;s:1:\"r\";a:1:{i:0;i:1;}}i:83;a:6:{s:1:\"a\";i:86;s:1:\"b\";s:36:\"api.accounting.account-modules.store\";s:1:\"c\";s:36:\"Api Accounting Account-modules Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:22;s:1:\"r\";a:1:{i:0;i:1;}}i:84;a:6:{s:1:\"a\";i:87;s:1:\"b\";s:35:\"api.accounting.account-modules.show\";s:1:\"c\";s:35:\"Api Accounting Account-modules Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:22;s:1:\"r\";a:1:{i:0;i:1;}}i:85;a:6:{s:1:\"a\";i:88;s:1:\"b\";s:37:\"api.accounting.account-modules.update\";s:1:\"c\";s:37:\"Api Accounting Account-modules Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:22;s:1:\"r\";a:1:{i:0;i:1;}}i:86;a:6:{s:1:\"a\";i:89;s:1:\"b\";s:38:\"api.accounting.account-modules.destroy\";s:1:\"c\";s:38:\"Api Accounting Account-modules Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:22;s:1:\"r\";a:1:{i:0;i:1;}}i:87;a:6:{s:1:\"a\";i:90;s:1:\"b\";s:36:\"api.accounting.generate-reference-no\";s:1:\"c\";s:36:\"Api Accounting Generate-reference-no\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:23;s:1:\"r\";a:1:{i:0;i:1;}}i:88;a:6:{s:1:\"a\";i:91;s:1:\"b\";s:36:\"api.inventory.supplier-advance.index\";s:1:\"c\";s:36:\"Api Inventory Supplier-advance Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:24;s:1:\"r\";a:1:{i:0;i:1;}}i:89;a:6:{s:1:\"a\";i:92;s:1:\"b\";s:36:\"api.inventory.supplier-advance.store\";s:1:\"c\";s:36:\"Api Inventory Supplier-advance Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:24;s:1:\"r\";a:1:{i:0;i:1;}}i:90;a:6:{s:1:\"a\";i:93;s:1:\"b\";s:35:\"api.inventory.supplier-advance.show\";s:1:\"c\";s:35:\"Api Inventory Supplier-advance Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:24;s:1:\"r\";a:1:{i:0;i:1;}}i:91;a:6:{s:1:\"a\";i:94;s:1:\"b\";s:37:\"api.inventory.supplier-advance.update\";s:1:\"c\";s:37:\"Api Inventory Supplier-advance Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:24;s:1:\"r\";a:1:{i:0;i:1;}}i:92;a:6:{s:1:\"a\";i:95;s:1:\"b\";s:38:\"api.inventory.supplier-advance.destroy\";s:1:\"c\";s:38:\"Api Inventory Supplier-advance Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:24;s:1:\"r\";a:1:{i:0;i:1;}}i:93;a:6:{s:1:\"a\";i:96;s:1:\"b\";s:14:\"api.inventory.\";s:1:\"c\";s:14:\"Api Inventory \";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:25;s:1:\"r\";a:1:{i:0;i:1;}}i:94;a:6:{s:1:\"a\";i:97;s:1:\"b\";s:31:\"api.inventory.products-overview\";s:1:\"c\";s:31:\"Api Inventory Products-overview\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:26;s:1:\"r\";a:1:{i:0;i:1;}}i:95;a:6:{s:1:\"a\";i:98;s:1:\"b\";s:32:\"api.inventory.suppliers.balances\";s:1:\"c\";s:32:\"Api Inventory Suppliers Balances\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:15;s:1:\"r\";a:1:{i:0;i:1;}}i:96;a:6:{s:1:\"a\";i:99;s:1:\"b\";s:29:\"api.inventory.purchases.index\";s:1:\"c\";s:29:\"Api Inventory Purchases Index\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:27;s:1:\"r\";a:1:{i:0;i:1;}}i:97;a:6:{s:1:\"a\";i:100;s:1:\"b\";s:29:\"api.inventory.purchases.store\";s:1:\"c\";s:29:\"Api Inventory Purchases Store\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:27;s:1:\"r\";a:1:{i:0;i:1;}}i:98;a:6:{s:1:\"a\";i:101;s:1:\"b\";s:28:\"api.inventory.purchases.show\";s:1:\"c\";s:28:\"Api Inventory Purchases Show\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:27;s:1:\"r\";a:1:{i:0;i:1;}}i:99;a:6:{s:1:\"a\";i:102;s:1:\"b\";s:30:\"api.inventory.purchases.update\";s:1:\"c\";s:30:\"Api Inventory Purchases Update\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:27;s:1:\"r\";a:1:{i:0;i:1;}}i:100;a:6:{s:1:\"a\";i:103;s:1:\"b\";s:31:\"api.inventory.purchases.destroy\";s:1:\"c\";s:31:\"Api Inventory Purchases Destroy\";s:1:\"d\";s:7:\"sanctum\";s:1:\"e\";i:27;s:1:\"r\";a:1:{i:0;i:1;}}}s:5:\"roles\";a:1:{i:0;a:5:{s:1:\"a\";i:1;s:1:\"b\";s:13:\"Administrator\";s:1:\"j\";N;s:1:\"k\";N;s:1:\"d\";s:7:\"sanctum\";}}}', 1764048514);

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
(31, 'ererer', 1, '2025-09-03 00:45:08', '2025-09-03 00:45:08');

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
(2, 'New User', NULL, NULL, NULL, 0.00, 0.00, 1, 1, '2025-08-28 03:42:28', '2025-08-28 03:42:28');

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
(3, 2, 5000.00, 0.00, '2025-11-24', NULL, 'CAV-0001', 'Advance payment for upcoming order', 'advance', 1, '2025-11-24 01:37:30', '2025-11-24 01:38:53');

-- --------------------------------------------------------

--
-- Table structure for table `inv_customer_ledgers`
--

CREATE TABLE `inv_customer_ledgers` (
  `id` bigint UNSIGNED NOT NULL,
  `customer_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `transaction_type` enum('sale','sale_return','advance','payment','adjustment','opening_balance') COLLATE utf8mb4_unicode_ci NOT NULL,
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
(4, 2, '2025-11-24', 'advance', 5000.00, 0.00, 5000.00, 3, 'CAV-0001', 'Advance payment for upcoming order', 1, '2025-11-24 01:38:53', '2025-11-24 01:38:53'),
(6, 1, '2025-11-24', 'opening_balance', 0.00, 250.00, 250.00, 1, 'CPD-0001', NULL, 1, '2025-11-24 03:03:33', '2025-11-24 03:03:33');

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
(48, 6, 1, 'sale', 600.00, '2025-11-05', NULL, 'Updated from purchase', '2025-11-05 02:57:49', '2025-11-05 02:57:49');

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
(8, 'Knot Pusher', '00007', 25, 2, NULL, 1, 1, NULL, NULL, NULL, NULL, '2025-10-29 01:04:07', '2025-10-29 01:04:07');

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
(6, 2, 3, 5, 0.00, 1, '2025-09-04 03:42:36', '2025-09-04 03:42:36'),
(7, 2, 2, 3, 0.00, 1, '2025-09-04 03:42:36', '2025-09-04 03:42:36'),
(8, 2, 1, 1, 0.00, 1, '2025-09-04 03:42:36', '2025-09-04 03:42:36');

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
(111, 'INV-2025-11-0016', 4, '2025-11-05', 1250.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1250.00, 0.00, 0.00, NULL, 1, 1, '2025-11-05 03:44:03', '2025-11-23 23:59:29');

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
(154, 111, 7, '2025-11-05', 5, 250.00, 250.00, 1250.00, 280.00, 1250.00, 0.00, 0.00, 0.00, 0.00, 1250.00, NULL, 1, '2025-11-23 23:59:29', '2025-11-23 23:59:29');

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
  `total_discount_percent` decimal(8,2) NOT NULL DEFAULT '0.00',
  `total_discount_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
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
  `sale_price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `inventory_subtotal` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `discount_percent` decimal(8,2) NOT NULL DEFAULT '0.00',
  `discount_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `tax_percent` decimal(8,2) NOT NULL DEFAULT '0.00',
  `tax_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `net_price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(41, 1, 1, 64, '2025-10-11 23:07:28', '2025-11-04 06:39:03'),
(42, 2, 1, 194, '2025-10-11 23:07:28', '2025-11-05 01:51:10'),
(43, 8, 1, 50, '2025-11-04 22:54:00', '2025-11-05 00:08:41'),
(44, 7, 1, 15, '2025-11-04 22:54:00', '2025-11-23 23:59:29'),
(45, 6, 1, 6, '2025-11-05 02:57:49', '2025-11-05 03:25:03');

-- --------------------------------------------------------

--
-- Table structure for table `inv_stock_movements`
--

CREATE TABLE `inv_stock_movements` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `movement_type` enum('purchase','sale','transfer_in','transfer_out','damage','purchase_return','sale_return','adjustment_in','adjustment_out') COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `consumed_quantity` float DEFAULT '0',
  `unit_price` decimal(10,2) NOT NULL,
  `sales_price` decimal(10,2) DEFAULT NULL,
  `reference_id` bigint UNSIGNED DEFAULT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `strategy` enum('fifo','lifo') COLLATE utf8mb4_unicode_ci DEFAULT 'fifo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inv_stock_movements`
--

INSERT INTO `inv_stock_movements` (`id`, `product_id`, `movement_type`, `quantity`, `consumed_quantity`, `unit_price`, `sales_price`, `reference_id`, `branch_id`, `strategy`, `created_at`, `updated_at`) VALUES
(68, 2, 'purchase', 3, 0, 200.00, 300.00, 30, 1, 'fifo', '2025-11-04 01:29:28', '2025-11-04 01:29:28'),
(69, 2, 'purchase', 1, 0, 200.00, 300.00, 31, 1, 'fifo', '2025-11-04 01:32:15', '2025-11-04 01:32:15'),
(70, 2, 'purchase', 1, 0, 200.00, 300.00, 32, 1, 'fifo', '2025-11-04 01:32:33', '2025-11-04 01:32:33'),
(71, 1, 'purchase', 3, 0, 100.00, 200.00, 33, 1, 'fifo', '2025-11-04 01:33:19', '2025-11-04 01:33:19'),
(72, 2, 'purchase', 2, 0, 200.00, 300.00, 34, 1, 'fifo', '2025-11-04 01:50:18', '2025-11-04 01:50:18'),
(106, 1, 'purchase', 1, 0, 100.00, 200.00, 68, 1, 'fifo', '2025-11-04 05:20:56', '2025-11-04 05:20:56'),
(110, 2, 'purchase', 1, 0, 200.00, 300.00, 72, 1, 'fifo', '2025-11-04 05:33:27', '2025-11-04 05:33:27'),
(124, 2, 'purchase', 1, 0, 200.00, 300.00, 86, 1, 'fifo', '2025-11-04 06:35:47', '2025-11-04 06:35:47'),
(125, 8, 'purchase', 20, 0, 150.00, 200.00, 87, 1, 'fifo', '2025-11-04 22:54:00', '2025-11-04 22:54:00'),
(126, 7, 'purchase', 5, 0, 250.00, 280.00, 87, 1, 'fifo', '2025-11-04 22:54:00', '2025-11-04 22:54:00'),
(127, 8, 'purchase', 30, 0, 150.00, 200.00, 88, 1, 'fifo', '2025-11-05 00:08:41', '2025-11-05 00:08:41'),
(128, 2, 'purchase', 20, 0, 200.00, 300.00, 89, 1, 'fifo', '2025-11-05 00:47:10', '2025-11-05 00:47:10'),
(129, 2, 'purchase', 30, 0, 200.00, 300.00, 90, 1, 'fifo', '2025-11-05 01:13:02', '2025-11-05 01:13:02'),
(130, 2, 'purchase', 30, 0, 200.00, 300.00, 91, 1, 'fifo', '2025-11-05 01:18:07', '2025-11-05 01:18:07'),
(148, 2, 'purchase', 30, 0, 200.00, 300.00, 109, 1, 'fifo', '2025-11-05 01:51:10', '2025-11-05 01:51:10'),
(150, 6, 'purchase', 3, 0, 500.00, 600.00, 110, 1, 'fifo', '2025-11-05 03:25:02', '2025-11-05 03:25:02'),
(152, 7, 'purchase', 5, 0, 250.00, 280.00, 111, 1, 'fifo', '2025-11-23 23:59:29', '2025-11-23 23:59:29');

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
(10, 'Sakib', '88', NULL, NULL, 0.00, 0.00, 1, 1, '2025-11-03 03:29:00', '2025-11-03 03:29:00');

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
  `transaction_type` enum('purchase','purchase_return','advance','payment','adjustment','opening_balance') COLLATE utf8mb4_unicode_ci NOT NULL,
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
(71, 8, '2025-11-05', 'purchase', 0.00, 400.00, -400.00, 110, 'INV-2025-11-0015', NULL, 1, '2025-11-05 03:25:03', '2025-11-05 03:25:03');

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
(29, 1, 'purchase_updated', 'purchase', 111, '\"{\\\"id\\\":111,\\\"invoice_no\\\":\\\"INV-2025-11-0016\\\",\\\"supplier_id\\\":4,\\\"invoice_date\\\":\\\"2025-11-05\\\",\\\"total_amount\\\":1250,\\\"discount_percent\\\":0,\\\"discount_amount\\\":0,\\\"total_discount_percent\\\":0,\\\"total_discount_amount\\\":0,\\\"adjustment\\\":0,\\\"tax_percent\\\":0,\\\"tax_amount\\\":0,\\\"total_tax_percent\\\":0,\\\"total_tax_amount\\\":0,\\\"supplier_adjust\\\":\\\"0.00\\\",\\\"net_total\\\":1250,\\\"paid_amount\\\":0,\\\"due_amount\\\":0,\\\"remarks\\\":null,\\\"branch_id\\\":1,\\\"created_by\\\":1,\\\"created_at\\\":\\\"2025-11-05T09:44:03.000000Z\\\",\\\"updated_at\\\":\\\"2025-11-24T05:59:29.000000Z\\\"}\"', '{\"id\": 111, \"remarks\": null, \"branch_id\": 1, \"net_total\": 1250, \"adjustment\": 0, \"created_at\": \"2025-11-05T09:44:03.000000Z\", \"created_by\": 1, \"due_amount\": 0, \"invoice_no\": \"INV-2025-11-0016\", \"tax_amount\": 0, \"updated_at\": \"2025-11-24T05:59:29.000000Z\", \"paid_amount\": 0, \"supplier_id\": 4, \"tax_percent\": 0, \"invoice_date\": \"2025-11-05\", \"total_amount\": 1250, \"discount_amount\": 0, \"supplier_adjust\": \"0.00\", \"discount_percent\": 0, \"total_tax_amount\": 0, \"total_tax_percent\": 0, \"total_discount_amount\": 0, \"total_discount_percent\": 0}', 1, '2025-11-23 23:59:29', NULL);

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
(61, '2025_11_24_062321_create_inv_sale_items_table', 14);

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
(3, 'Accounting', 'accounting', 1, '2025-09-04 03:52:01', '2025-09-04 03:52:01');

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
(1, 'Modules\\Core\\Models\\User', 1, 'api-token', 'bed414454b1cd4cbd9a1bd4277ec9caca7a32e886a04e7bb83f644733bafa962', '[\"*\"]', '2025-11-24 01:39:11', NULL, '2025-08-24 04:08:21', '2025-11-24 01:39:11'),
(8, 'Modules\\Core\\Models\\User', 1, 'api-token', 'b26b703b289bcff2f8365062a163e4a26866450344dc6b8743237d9b02de0c4d', '[\"*\"]', '2025-08-24 07:06:42', NULL, '2025-08-24 07:05:37', '2025-08-24 07:06:42'),
(9, 'Modules\\Core\\Models\\User', 1, 'api-token', '6c142bc24b07d5c3ff049b3860d879dc3889ae466b030923730e4c96d958f00c', '[\"*\"]', '2025-08-24 07:07:04', NULL, '2025-08-24 07:07:04', '2025-08-24 07:07:04'),
(13, 'Modules\\Core\\Models\\User', 1, 'api-token', '677c9a19b21d9b1bd2483e0f4820d02dc4d1ec0dcf297ade4fb9a80fcd7dc8bf', '[\"*\"]', '2025-11-06 00:54:32', NULL, '2025-08-24 22:26:44', '2025-11-06 00:54:32'),
(14, 'Modules\\Core\\Models\\User', 1, 'api-token', 'fb1bed7e3778362e45bcfcc9f1dde0ad28cf25965db2086df0116a58be1422cb', '[\"*\"]', '2025-11-24 07:17:20', NULL, '2025-11-23 23:25:46', '2025-11-24 07:17:20');

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
  ADD KEY `acc_account_heads_branch_id_foreign` (`branch_id`);

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
  ADD KEY `acc_journal_entry_details_account_head_id_foreign` (`account_head_id`);

--
-- Indexes for table `acc_module_entries`
--
ALTER TABLE `acc_module_entries`
  ADD PRIMARY KEY (`id`);

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
  ADD UNIQUE KEY `unique_price_list` (`product_id`,`branch_id`,`price_type`),
  ADD KEY `inv_price_lists_branch_id_foreign` (`branch_id`);

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
  ADD KEY `inv_stock_movements_product_id_foreign` (`product_id`),
  ADD KEY `inv_stock_movements_branch_id_foreign` (`branch_id`);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `acc_account_heads`
--
ALTER TABLE `acc_account_heads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=169;

--
-- AUTO_INCREMENT for table `acc_journal_entries`
--
ALTER TABLE `acc_journal_entries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `acc_journal_entry_details`
--
ALTER TABLE `acc_journal_entry_details`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=190;

--
-- AUTO_INCREMENT for table `acc_module_entries`
--
ALTER TABLE `acc_module_entries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `acc_module_entry_accounts`
--
ALTER TABLE `acc_module_entry_accounts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `acc_voucher_types`
--
ALTER TABLE `acc_voucher_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `admin_menus`
--
ALTER TABLE `admin_menus`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

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
-- AUTO_INCREMENT for table `inv_brands`
--
ALTER TABLE `inv_brands`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `inv_categories`
--
ALTER TABLE `inv_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `inv_customers`
--
ALTER TABLE `inv_customers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `inv_customer_advances`
--
ALTER TABLE `inv_customer_advances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `inv_customer_ledgers`
--
ALTER TABLE `inv_customer_ledgers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `inv_payments`
--
ALTER TABLE `inv_payments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inv_price_lists`
--
ALTER TABLE `inv_price_lists`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `inv_purchases`
--
ALTER TABLE `inv_purchases`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- AUTO_INCREMENT for table `inv_purchase_items`
--
ALTER TABLE `inv_purchase_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=155;

--
-- AUTO_INCREMENT for table `inv_sales`
--
ALTER TABLE `inv_sales`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inv_sale_items`
--
ALTER TABLE `inv_sale_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inv_stock_balances`
--
ALTER TABLE `inv_stock_balances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `inv_stock_movements`
--
ALTER TABLE `inv_stock_movements`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT for table `inv_suppliers`
--
ALTER TABLE `inv_suppliers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `inv_supplier_advances`
--
ALTER TABLE `inv_supplier_advances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `inv_supplier_ledgers`
--
ALTER TABLE `inv_supplier_ledgers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `inv_units`
--
ALTER TABLE `inv_units`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `inv_user_logs`
--
ALTER TABLE `inv_user_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `modules`
--
ALTER TABLE `modules`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

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
  ADD CONSTRAINT `acc_journal_entry_details_account_head_id_foreign` FOREIGN KEY (`account_head_id`) REFERENCES `acc_account_heads` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `acc_journal_entry_details_journal_entry_id_foreign` FOREIGN KEY (`journal_entry_id`) REFERENCES `acc_journal_entries` (`id`) ON DELETE CASCADE;

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

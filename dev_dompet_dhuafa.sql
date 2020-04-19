/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : localhost:3306
 Source Schema         : dev_dompet_dhuafa

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 19/04/2020 23:07:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for data_donasi
-- ----------------------------
DROP TABLE IF EXISTS `data_donasi`;
CREATE TABLE `data_donasi`  (
  `id_data_donasi` int(11) NOT NULL,
  `id_donasi` int(20) NULL DEFAULT NULL COMMENT 'nomor referensi/kode konfirmasi',
  `id_donatur` int(11) NULL DEFAULT NULL,
  `id_target_donasi` int(11) NULL DEFAULT NULL,
  `nominal` int(50) NULL DEFAULT NULL,
  `kode_unik` int(10) NULL DEFAULT NULL,
  `total_pembayaran` int(50) NULL DEFAULT NULL COMMENT 'nominal+kode_unik',
  `status` enum('0','1','2') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0' COMMENT '0=menunggu_pembayaran; 1=lunas; 2=expired',
  `iat` datetime(0) NULL DEFAULT NULL,
  `uat` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_data_donasi`) USING BTREE,
  UNIQUE INDEX `id_donasi`(`id_donasi`) USING BTREE,
  INDEX `id_donatur`(`id_donatur`) USING BTREE,
  INDEX `id_target_donasi`(`id_target_donasi`) USING BTREE,
  CONSTRAINT `data_donasi_ibfk_1` FOREIGN KEY (`id_donatur`) REFERENCES `data_donatur` (`id_donatur`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_donasi_ibfk_2` FOREIGN KEY (`id_target_donasi`) REFERENCES `master_target_donasi` (`id_target_donasi`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for data_donatur
-- ----------------------------
DROP TABLE IF EXISTS `data_donatur`;
CREATE TABLE `data_donatur`  (
  `id_data_donatur` int(11) NOT NULL AUTO_INCREMENT,
  `id_donatur` int(11) NULL DEFAULT NULL,
  `nama_donatur` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `telepon` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alamat` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `tipe_donatur` enum('personal','institusi') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `institusi` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `npwp` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `negara` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `provinsi` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kota/kabupaten` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kodepos` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `iat` datetime(0) NULL DEFAULT NULL,
  `uat` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_data_donatur`) USING BTREE,
  UNIQUE INDEX `id_donatur`(`id_donatur`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for data_konfirmasi_donasi
-- ----------------------------
DROP TABLE IF EXISTS `data_konfirmasi_donasi`;
CREATE TABLE `data_konfirmasi_donasi`  (
  `id_data_konfirmasi_donasi` int(11) NOT NULL,
  `id_konfirmasi_donasi` int(11) NULL DEFAULT NULL,
  `id_donasi` int(20) NULL DEFAULT NULL,
  `bank_nama` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bank_cabang` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bank_norek` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bank_atas_nama` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_bayar` datetime(0) NULL DEFAULT NULL,
  `bukti_pembayaran` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `catatan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `iat` datetime(0) NULL DEFAULT NULL,
  `uat` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_data_konfirmasi_donasi`) USING BTREE,
  UNIQUE INDEX `id_konfirmasi_donasi`(`id_konfirmasi_donasi`) USING BTREE,
  INDEX `id_donasi`(`id_donasi`) USING BTREE,
  CONSTRAINT `data_konfirmasi_donasi_ibfk_1` FOREIGN KEY (`id_donasi`) REFERENCES `data_donasi` (`id_donasi`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for master_jenis_donasi
-- ----------------------------
DROP TABLE IF EXISTS `master_jenis_donasi`;
CREATE TABLE `master_jenis_donasi`  (
  `id_master_jenis_donasi` int(11) NOT NULL AUTO_INCREMENT,
  `id_jenis_donasi` int(11) NULL DEFAULT NULL,
  `jenis_donasi` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `iat` datetime(0) NULL DEFAULT NULL,
  `uat` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_master_jenis_donasi`) USING BTREE,
  UNIQUE INDEX `id_jenis_donasi`(`id_jenis_donasi`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of master_jenis_donasi
-- ----------------------------
INSERT INTO `master_jenis_donasi` VALUES (1, 91077432, 'Zakat', '2020-04-19 03:51:11', '2020-04-19 03:51:41');
INSERT INTO `master_jenis_donasi` VALUES (2, 72584460, 'Infaq/Sedekah', '2020-04-19 03:51:14', '2020-04-19 03:51:41');
INSERT INTO `master_jenis_donasi` VALUES (3, 46238496, 'Waqaf', '2020-04-19 03:51:16', '2020-04-19 03:51:41');
INSERT INTO `master_jenis_donasi` VALUES (4, 49014882, 'Kemanusiaan', '2020-04-19 03:51:19', '2020-04-19 03:51:41');

-- ----------------------------
-- Table structure for master_metode_pembayaran
-- ----------------------------
DROP TABLE IF EXISTS `master_metode_pembayaran`;
CREATE TABLE `master_metode_pembayaran`  (
  `id_master_metode_pembayaran` int(11) NOT NULL AUTO_INCREMENT,
  `id_metode_pembayaran` int(11) NULL DEFAULT NULL,
  `metode_pembarayan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `norek` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `atas_nama` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `iat` datetime(0) NULL DEFAULT NULL,
  `uat` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_master_metode_pembayaran`) USING BTREE,
  UNIQUE INDEX `id_metode_pembayaran`(`id_metode_pembayaran`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of master_metode_pembayaran
-- ----------------------------
INSERT INTO `master_metode_pembayaran` VALUES (1, 30550240, 'Bank BNI', NULL, NULL, 'donasi', NULL, '2020-04-19 04:11:49', '2020-04-19 09:44:48');
INSERT INTO `master_metode_pembayaran` VALUES (2, 76957036, 'Bank Mandiri', '152.0011.7600.51', 'Yayasan Dompet Dhuafa Republika Rekening Zakat ', '	donasi', NULL, '2020-04-19 04:11:49', '2020-04-19 09:44:53');
INSERT INTO `master_metode_pembayaran` VALUES (3, 42256129, 'Bank BCA', '7890387777', 'Yayasan Dompet Dhuafa Republika Rekening Zakat ', '	donasi', NULL, '2020-04-19 04:11:49', '2020-04-19 09:44:54');
INSERT INTO `master_metode_pembayaran` VALUES (4, 45259423, 'Bank Muamalat', '8010048527 ', 'Yayasan Dompet Dhuafa Republika Rekening Zakat ', '	donasi', NULL, '2020-04-19 04:11:49', '2020-04-19 09:44:55');
INSERT INTO `master_metode_pembayaran` VALUES (5, 88246397, 'BNI Syariah', '015.938.7145', NULL, 'sedekah', NULL, '2020-04-19 09:46:12', '2020-04-19 09:46:15');
INSERT INTO `master_metode_pembayaran` VALUES (6, 49288787, 'Bank Muamalat ', '801.004.8528', NULL, 'sedekah', NULL, '2020-04-19 09:46:12', '2020-04-19 09:46:16');
INSERT INTO `master_metode_pembayaran` VALUES (7, 77823354, 'Bank Mandiri', '152.0022.9992.92 ', NULL, 'sedekah', NULL, '2020-04-19 09:46:12', '2020-04-19 09:46:16');

-- ----------------------------
-- Table structure for master_subjenis_donasi
-- ----------------------------
DROP TABLE IF EXISTS `master_subjenis_donasi`;
CREATE TABLE `master_subjenis_donasi`  (
  `id_master_subjenis_donasi` int(11) NOT NULL AUTO_INCREMENT,
  `id_subjenis_donasi` int(11) NULL DEFAULT NULL,
  `id_jenis_donasi` int(11) NULL DEFAULT NULL,
  `subjenis_donasi` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `iat` datetime(0) NULL DEFAULT NULL,
  `uat` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_master_subjenis_donasi`) USING BTREE,
  UNIQUE INDEX `id_subjenis_donasi`(`id_subjenis_donasi`) USING BTREE,
  INDEX `id_jenis_donasi`(`id_jenis_donasi`) USING BTREE,
  CONSTRAINT `master_subjenis_donasi_ibfk_1` FOREIGN KEY (`id_jenis_donasi`) REFERENCES `master_jenis_donasi` (`id_jenis_donasi`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of master_subjenis_donasi
-- ----------------------------
INSERT INTO `master_subjenis_donasi` VALUES (1, 56880199, 91077432, 'Zakat Fitrah', '2020-04-19 03:52:53', '2020-04-19 03:55:31');
INSERT INTO `master_subjenis_donasi` VALUES (2, 16858220, 91077432, 'Zakat Maal', '2020-04-19 03:52:56', '2020-04-19 03:55:31');
INSERT INTO `master_subjenis_donasi` VALUES (3, 40650232, 91077432, 'Fidyah', '2020-04-19 03:52:59', '2020-04-19 03:55:31');
INSERT INTO `master_subjenis_donasi` VALUES (4, 78760362, 72584460, 'Pendidikan', '2020-04-19 03:54:52', '2020-04-19 03:55:31');
INSERT INTO `master_subjenis_donasi` VALUES (5, 17817724, 72584460, 'Kesehatan', '2020-04-19 03:54:52', '2020-04-19 03:55:31');
INSERT INTO `master_subjenis_donasi` VALUES (6, 67350812, 72584460, 'Sosial', '2020-04-19 03:54:52', '2020-04-19 03:55:31');
INSERT INTO `master_subjenis_donasi` VALUES (7, 64183258, 72584460, 'Dakwah', '2020-04-19 03:54:52', '2020-04-19 03:55:31');
INSERT INTO `master_subjenis_donasi` VALUES (8, 67323192, 72584460, 'Ekonomi', '2020-04-19 03:54:52', '2020-04-19 03:55:31');
INSERT INTO `master_subjenis_donasi` VALUES (9, 96699437, 46238496, 'Waqaf Qur\'an', '2020-04-19 03:56:38', '2020-04-19 03:57:01');
INSERT INTO `master_subjenis_donasi` VALUES (10, 92168993, 46238496, 'Waqaf Masjid', '2020-04-19 03:56:38', '2020-04-19 03:57:01');
INSERT INTO `master_subjenis_donasi` VALUES (11, 27227237, 46238496, 'Waqaf Pesantren', '2020-04-19 03:56:38', '2020-04-19 03:57:01');
INSERT INTO `master_subjenis_donasi` VALUES (12, 61048920, 49014882, 'Bencana Alam', '2020-04-19 03:57:49', '2020-04-19 03:58:26');
INSERT INTO `master_subjenis_donasi` VALUES (13, 99102513, 49014882, 'Bantuan untuk Palestina', '2020-04-19 03:57:51', '2020-04-19 03:58:26');

-- ----------------------------
-- Table structure for master_target_donasi
-- ----------------------------
DROP TABLE IF EXISTS `master_target_donasi`;
CREATE TABLE `master_target_donasi`  (
  `id_master_target_donasi` int(11) NOT NULL AUTO_INCREMENT,
  `id_target_donasi` int(11) NULL DEFAULT NULL,
  `id_subjenis_donasi` int(11) NULL DEFAULT NULL,
  `target_donasi` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `iat` datetime(0) NULL DEFAULT NULL,
  `uat` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_master_target_donasi`) USING BTREE,
  UNIQUE INDEX `id_target_donasi`(`id_target_donasi`) USING BTREE,
  INDEX `id_subjenis_donasi`(`id_subjenis_donasi`) USING BTREE,
  CONSTRAINT `master_target_donasi_ibfk_1` FOREIGN KEY (`id_subjenis_donasi`) REFERENCES `master_subjenis_donasi` (`id_subjenis_donasi`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of master_target_donasi
-- ----------------------------
INSERT INTO `master_target_donasi` VALUES (1, 49647637, 16858220, 'Emas', '2020-04-19 04:00:30', '2020-04-19 04:02:38');
INSERT INTO `master_target_donasi` VALUES (2, 53330514, 16858220, 'Penghasilan', '2020-04-19 04:00:30', '2020-04-19 04:02:38');
INSERT INTO `master_target_donasi` VALUES (3, 23207905, 16858220, 'Simpanan', '2020-04-19 04:00:30', '2020-04-19 04:02:38');
INSERT INTO `master_target_donasi` VALUES (4, 83337664, 16858220, 'Perdagangan', '2020-04-19 04:00:30', '2020-04-19 04:02:38');
INSERT INTO `master_target_donasi` VALUES (5, 42122642, 78760362, 'Sekolah Literasi Indonesia', '2020-04-19 04:03:21', '2020-04-19 04:03:41');
INSERT INTO `master_target_donasi` VALUES (6, 17527834, 78760362, 'Pelatihan guru', '2020-04-19 04:03:24', '2020-04-19 04:04:29');
INSERT INTO `master_target_donasi` VALUES (7, 45686355, 17817724, 'Layanan kesehatan cuma-cuma', '2020-04-19 04:04:55', '2020-04-19 04:09:27');
INSERT INTO `master_target_donasi` VALUES (8, 84354954, 17817724, 'Kursi roda untuk dhuafa', '2020-04-19 04:04:55', '2020-04-19 04:09:27');
INSERT INTO `master_target_donasi` VALUES (9, 33267044, 17817724, 'Ambulance gratis', '2020-04-19 04:04:55', '2020-04-19 04:09:27');
INSERT INTO `master_target_donasi` VALUES (10, 28721748, 67350812, 'Kado untuk anak yatim', '2020-04-19 04:05:38', '2020-04-19 04:09:27');
INSERT INTO `master_target_donasi` VALUES (11, 22152874, 67350812, 'Sembako untuk dhuafa', '2020-04-19 04:05:40', '2020-04-19 04:09:27');
INSERT INTO `master_target_donasi` VALUES (12, 15736309, 64183258, 'Sedekah untuk guru mengaji', '2020-04-19 04:06:56', '2020-04-19 04:09:27');
INSERT INTO `master_target_donasi` VALUES (13, 66583779, 64183258, 'Sedekah dai pedalaman', '2020-04-19 04:06:56', '2020-04-19 04:09:27');
INSERT INTO `master_target_donasi` VALUES (14, 51902592, 67323192, 'Rumah produksi', '2020-04-19 04:08:07', '2020-04-19 04:09:27');
INSERT INTO `master_target_donasi` VALUES (15, 62307373, 67323192, 'Perempuan wirausaha', '2020-04-19 04:08:07', '2020-04-19 04:09:27');
INSERT INTO `master_target_donasi` VALUES (16, 80464292, 67323192, 'Modal usaha untuk dhuafa', '2020-04-19 04:08:07', '2020-04-19 04:09:27');
INSERT INTO `master_target_donasi` VALUES (17, 65015874, 67323192, 'Ternak untuk dhuafa', '2020-04-19 04:08:07', '2020-04-19 04:09:27');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id_user` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `fullname` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `notelp` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `email` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `username` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `foto` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `roles` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '09:00',
  `status_aktif` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '1',
  `iat` datetime(0) NOT NULL,
  `uat` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `active_timestamps_since` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id_user`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('143221231', 'Rahma H Slamet', '081344966375', 'itsme.arhen@gmail.com', 'admin', '$2y$10$Wm88uKSK.7dKcgARHThAh.BPKJrJmmG8QHsqujM5XwByw.9dkaDAi', '', 'admin', '1', '2017-08-03 11:00:00', '2018-11-09 16:02:33', NULL);

SET FOREIGN_KEY_CHECKS = 1;

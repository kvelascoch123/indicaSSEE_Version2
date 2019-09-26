/*
Navicat MySQL Data Transfer

Source Server         : navicat
Source Server Version : 50644
Source Host           : 107.180.44.137:3306
Source Database       : ss_indicators_test

Target Server Type    : MYSQL
Target Server Version : 50644
File Encoding         : 65001

Date: 2019-09-20 17:57:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `al_area`
-- ----------------------------
DROP TABLE IF EXISTS `al_area`;
CREATE TABLE `al_area` (
  `al_area_id` int(10) NOT NULL AUTO_INCREMENT,
  `value` int(10) NOT NULL,
  `isactive` char(1) NOT NULL,
  `description` text NOT NULL,
  `created` datetime NOT NULL,
  `created_by` varchar(32) NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `al_org_id` int(10) NOT NULL,
  PRIMARY KEY (`al_area_id`),
  KEY `al_org_id` (`al_org_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of al_area
-- ----------------------------
INSERT INTO `al_area` VALUES ('1', '100', 'y', 'area financiera', '2019-09-02 16:18:13', '100', '2019-09-02 16:18:27', '100', 'Financiera', '1');
INSERT INTO `al_area` VALUES ('2', '100', 'y', 'area comercial', '2019-09-02 16:19:26', '100', '2019-09-02 16:19:30', '100', 'Comercial', '2');
INSERT INTO `al_area` VALUES ('3', '100', 'y', 'area contable', '2019-09-06 10:16:31', '100', '2019-09-06 10:16:40', '100', 'Contable', '1');

-- ----------------------------
-- Table structure for `al_factor`
-- ----------------------------
DROP TABLE IF EXISTS `al_factor`;
CREATE TABLE `al_factor` (
  `al_factor_id` int(10) NOT NULL AUTO_INCREMENT,
  `value` int(10) NOT NULL,
  `isactive` char(1) NOT NULL,
  `description` text NOT NULL,
  `created` datetime NOT NULL,
  `created_by` varchar(32) NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `al_org_id` int(11) NOT NULL,
  `al_area_id` int(11) NOT NULL,
  PRIMARY KEY (`al_factor_id`),
  KEY `al_org_id` (`al_org_id`) USING BTREE,
  KEY `al_area_id` (`al_area_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of al_factor
-- ----------------------------
INSERT INTO `al_factor` VALUES ('1', '100', 'Y', 'area financiera', '2019-09-02 16:21:30', '100', '2019-09-02 16:21:34', '100', 'Liquidez', '1', '1');
INSERT INTO `al_factor` VALUES ('2', '100', 'Y', 'area financiera', '2019-09-02 16:22:53', '100', '2019-09-02 16:22:58', '100', 'Solvencia', '1', '1');
INSERT INTO `al_factor` VALUES ('3', '100', 'Y', 'area financiera', '2019-09-02 16:23:40', '100', '2019-09-02 16:23:44', '100', 'Gestion', '1', '1');
INSERT INTO `al_factor` VALUES ('4', '100', 'Y', 'area financiera', '2019-09-02 16:26:53', '100', '2019-09-02 16:27:01', '100', 'Rentabilidad', '1', '1');

-- ----------------------------
-- Table structure for `al_indicators`
-- ----------------------------
DROP TABLE IF EXISTS `al_indicators`;
CREATE TABLE `al_indicators` (
  `al_indicator_id` int(11) NOT NULL AUTO_INCREMENT,
  `value` int(10) NOT NULL,
  `isactive` char(1) NOT NULL,
  `description` text NOT NULL,
  `created` datetime NOT NULL,
  `created_by` varchar(32) NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `al_org_id` int(10) NOT NULL,
  `al_user_role_id` int(10) DEFAULT NULL,
  `allow_monthly` char(1) DEFAULT NULL,
  `allow_not_compare` char(1) DEFAULT NULL,
  `al_factor_id` int(10) DEFAULT NULL,
  `criterial` char(1) DEFAULT NULL,
  `interpretation_need_compare` char(2) DEFAULT 'N',
  `not_compare_value` decimal(10,2) DEFAULT NULL,
  `compare_middle_point_min` decimal(10,2) DEFAULT NULL COMMENT 'Punto de Equilibrio',
  `compare_middle_point_max` decimal(10,2) DEFAULT NULL,
  `txt_affirmative` text,
  `txt_negative` text,
  `graph_min_value` int(10) DEFAULT NULL,
  `graph_max_value` int(10) DEFAULT NULL,
  `graph_green_min_value` int(10) DEFAULT NULL,
  `graph_green_max_value` int(10) DEFAULT NULL,
  `graph_yellow_min_value` int(10) DEFAULT NULL,
  `graph_yellow_max_value` int(10) DEFAULT NULL,
  `graph_red_min_value` int(10) DEFAULT NULL,
  `graph_red_max_value` int(10) DEFAULT NULL,
  PRIMARY KEY (`al_indicator_id`),
  KEY `al_org_id` (`al_org_id`) USING BTREE,
  KEY `al_user_role_id` (`al_user_role_id`) USING BTREE,
  KEY `al_factor_id` (`al_factor_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of al_indicators
-- ----------------------------
INSERT INTO `al_indicators` VALUES ('1', '100', 'Y', 'liquidez', '2019-09-02 16:47:30', '100', '2019-09-02 16:47:37', '100', 'liquidez corriente', '1', '1', 'Y', 'Y', '1', 'B', 'N', null, null, null, null, null, '0', '6', '0', '5', '6', '3', '5', '6');
INSERT INTO `al_indicators` VALUES ('2', '100', 'Y', 'solvencia', '2019-09-02 16:49:29', '100', '2019-09-02 16:49:33', '100', 'endeudamiento del activo', '1', '1', 'Y', 'N', '2', 'L', 'N', null, null, null, 'El valor se encuentra sobre el limite de 60%, la empresa esta dejando una gran parte de su financiacion a terceros.  Esto podra hacerle perder autonomia en su administracion y gestion. Y generarle gran carga de intereses.', 'Si el ratio esta por debajo del 40%, la empresa contaria con un nivel de recursos propios muy elevado.', '0', '80', '65', '80', '35', '65', '0', '35');
INSERT INTO `al_indicators` VALUES ('3', '100', 'Y', 'gestion', '2019-09-02 16:50:49', '100', '2019-09-02 16:50:55', '100', 'rotacion de cartera', '1', '1', 'N', 'Y', '3', 'B', 'N', null, null, null, 'El resultado significa que la empresa en promedio tarda 25 dias en recuperar su cartera, en otras palabras su cartera se convierte en efectivo en menos de un mes.', null, '0', '50', '35', '50', '25', '35', '25', '0');
INSERT INTO `al_indicators` VALUES ('4', '100', 'Y', 'rentabilidad', '2019-09-02 16:52:07', '100', '2019-09-02 16:52:14', '100', 'rentabilidad neta del activo', '1', '2', 'N', 'N', '4', 'L', 'N', null, null, null, 'El resultado significa que la empresa en promedio tarda 25 dias en recuperar su cartera, en otras palabras su cartera se convierte en efectivo en menos de un mes.', null, '0', '10', '0', '4', '5', '8', '0', '10');
INSERT INTO `al_indicators` VALUES ('5', '100', 'Y', 'solvencia', '2019-09-02 16:53:24', '100', '2019-09-02 16:53:32', '100', 'bancos', '1', '2', 'N', 'Y', '2', 'B', 'N', null, null, null, null, null, '0', '200', '0', '80', '80', '160', '160', '200');
INSERT INTO `al_indicators` VALUES ('6', '100', 'Y', 'liquidez', '2019-09-09 09:35:05', '100', '2019-09-09 09:35:11', '100', 'prueba acida', '1', '1', 'Y', 'Y', '1', 'B', 'N', '1.00', null, null, 'la empresa puede solventar sus obligaciones a corto plazo.', ' la empresa no puede cubrir sus obligaciones paratemas de endeudamiento\r\n', '0', '10', '0', '4', '4', '8', '8', '10');
INSERT INTO `al_indicators` VALUES ('7', '0', '', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', 'rotacion de ventas', '1', '1', 'Y', 'Y', '3', 'B', 'N', null, null, null, 'Mientras mayor sea el volumen de ventas que se pueda realizar con determinada inversion, mas eficiente sera la direccion del negocio. ', null, '0', '100', '0', '45', '45', '80', '100', null);

-- ----------------------------
-- Table structure for `al_indicators_years`
-- ----------------------------
DROP TABLE IF EXISTS `al_indicators_years`;
CREATE TABLE `al_indicators_years` (
  `al_indicator_id` int(11) NOT NULL AUTO_INCREMENT,
  `value` int(10) NOT NULL,
  `isactive` char(1) NOT NULL,
  `description` text NOT NULL,
  `created` datetime NOT NULL,
  `created_by` varchar(32) NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `al_org_id` int(10) NOT NULL,
  `al_user_role_id` int(10) DEFAULT NULL,
  `last_year` decimal(4,2) DEFAULT NULL,
  `current_year` decimal(4,2) DEFAULT NULL,
  `variation_between_years` decimal(4,2) DEFAULT NULL,
  `last_month` decimal(4,2) DEFAULT NULL,
  `current_month` decimal(4,2) DEFAULT NULL,
  `variation_between_months` decimal(4,2) DEFAULT NULL,
  `al_factor_id` int(10) DEFAULT NULL,
  `year` varchar(4) DEFAULT NULL,
  `month` varchar(20) DEFAULT NULL,
  `criterial` char(1) DEFAULT NULL,
  PRIMARY KEY (`al_indicator_id`),
  KEY `al_org_id` (`al_org_id`) USING BTREE,
  KEY `al_user_role_id` (`al_user_role_id`) USING BTREE,
  KEY `al_factor_id` (`al_factor_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of al_indicators_years
-- ----------------------------
INSERT INTO `al_indicators_years` VALUES ('1', '100', 'Y', 'liquidez', '2019-09-02 16:47:30', '100', '2019-09-02 16:47:37', '100', 'liquidez corriente', '1', '1', '1.37', '1.46', '6.16', '1.56', '1.43', '-8.33', '1', '2019', 'enero', 'B');
INSERT INTO `al_indicators_years` VALUES ('2', '100', 'Y', 'solvencia', '2019-09-02 16:49:29', '100', '2019-09-02 16:49:33', '100', 'endeudamiento del activo', '1', '1', '2.43', '3.45', '8.34', '3.45', '4.45', '8.65', '2', '2019', 'septiembre', 'L');
INSERT INTO `al_indicators_years` VALUES ('3', '100', 'Y', 'gestion', '2019-09-02 16:50:49', '100', '2019-09-02 16:50:55', '100', 'rotacion de cartera', '1', '1', '2.21', '1.12', '4.65', '3.18', '4.56', '6.23', '3', '2019', 'marzo', 'B');
INSERT INTO `al_indicators_years` VALUES ('4', '100', 'Y', 'rentabilidad', '2019-09-02 16:52:07', '100', '2019-09-02 16:52:14', '100', 'rentabilidad neta del activo', '1', '2', '1.54', '3.56', '23.45', '5.45', '2.34', '6.76', '4', '2019', 'agosto', 'B');
INSERT INTO `al_indicators_years` VALUES ('6', '100', 'y', 'liquidez', '2019-09-05 14:12:32', '100', '2019-09-05 14:12:41', '100', 'liquidez corriente', '1', '1', '3.33', '4.33', '3.45', '2.34', '4.33', '5.54', '1', '2018', 'enero', 'B');
INSERT INTO `al_indicators_years` VALUES ('7', '100', 'Y', 'liquidez', '2019-09-09 09:39:08', '100', '2019-09-09 09:39:18', '100', 'prueba acida', '1', '1', '1.33', '1.30', '4.00', '1.33', '1.30', '4.20', '1', '2019', 'agosto', 'B');
INSERT INTO `al_indicators_years` VALUES ('9', '100', 'Y', 'gestion', '2019-09-09 12:17:01', '100', '2019-09-09 12:17:09', '100', 'rotacion de cartera', '1', '1', '25.10', '35.22', '10.10', '20.05', '25.01', '5.10', '3', '2019', 'agosto', 'N');
INSERT INTO `al_indicators_years` VALUES ('8', '100', 'Y', 'solvencia', '2019-09-09 12:13:32', '100', '2019-09-09 12:13:40', '100', 'endeudamiento del activo', '1', '1', '58.21', '69.76', '-11.58', '42.10', '62.15', '20.05', '2', '2019', 'agosto', 'N');
INSERT INTO `al_indicators_years` VALUES ('10', '100', 'Y', 'gestion', '2019-09-09 12:28:08', '100', '2019-09-09 12:28:13', '100', 'rotacion de ventas', '1', '1', '71.13', '75.86', '12.44', '56.65', '67.86', '22.54', '3', '2019', 'agosto', 'N');
INSERT INTO `al_indicators_years` VALUES ('11', '100', 'Y', 'solvencia', '2019-09-18 12:14:47', '100', '2019-09-18 12:14:55', '100', 'endeudamiento del activo', '1', '1', '52.15', '99.99', '98.00', '12.06', '13.08', '9.54', '2', '2019', 'enero', 'N');

-- ----------------------------
-- Table structure for `al_org`
-- ----------------------------
DROP TABLE IF EXISTS `al_org`;
CREATE TABLE `al_org` (
  `al_org_id` int(10) NOT NULL AUTO_INCREMENT,
  `value` int(10) NOT NULL,
  `isactive` char(1) NOT NULL,
  `description` text NOT NULL,
  `created` datetime NOT NULL,
  `created_by` varchar(32) NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`al_org_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of al_org
-- ----------------------------
INSERT INTO `al_org` VALUES ('1', '100', 'y', 'Sidesoft', '2019-09-02 15:54:57', '100', '2019-09-02 15:55:03', '100', 'Sidesoft');
INSERT INTO `al_org` VALUES ('2', '100', 'Y', 'GrupoMB', '2019-09-02 16:13:25', '100', '2019-09-02 16:13:33', '100', 'GrupoMB');

-- ----------------------------
-- Table structure for `al_role`
-- ----------------------------
DROP TABLE IF EXISTS `al_role`;
CREATE TABLE `al_role` (
  `al_role_id` int(10) NOT NULL AUTO_INCREMENT,
  `value` decimal(10,2) NOT NULL,
  `isactive` varchar(1) NOT NULL,
  `description` text NOT NULL,
  `created` datetime NOT NULL,
  `created_by` varchar(32) NOT NULL,
  `update` datetime NOT NULL,
  `update_by` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `al_org_id` int(10) NOT NULL,
  PRIMARY KEY (`al_role_id`),
  KEY `al_org_id` (`al_org_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of al_role
-- ----------------------------
INSERT INTO `al_role` VALUES ('1', '100.00', 'Y', 'Ninguna', '2019-09-02 16:15:38', 'Admin', '2019-09-02 16:15:50', 'Admin', 'Admin', '1');
INSERT INTO `al_role` VALUES ('2', '100.00', 'Y', 'Ninguna', '2019-09-02 16:16:29', 'Admin', '2019-09-02 16:18:53', 'Admin', 'Client', '2');
INSERT INTO `al_role` VALUES ('4', '0.00', '', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', '', '0');

-- ----------------------------
-- Table structure for `al_user`
-- ----------------------------
DROP TABLE IF EXISTS `al_user`;
CREATE TABLE `al_user` (
  `al_user_id` int(10) NOT NULL AUTO_INCREMENT,
  `value` decimal(10,2) NOT NULL,
  `isactive` char(1) NOT NULL,
  `description` text NOT NULL,
  `created` datetime NOT NULL,
  `created_by` varchar(32) NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `al_org_id` int(10) NOT NULL,
  `alias_name` varchar(255) NOT NULL,
  PRIMARY KEY (`al_user_id`),
  KEY `al_org_id` (`al_org_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of al_user
-- ----------------------------
INSERT INTO `al_user` VALUES ('1', '100.00', 'Y', 'Ninguna', '2019-09-02 15:55:04', '100', '2019-09-02 15:55:52', '100', 'Franklin', 'fabio.paredes@gmail.com', 'al47', '1', 'franklin');
INSERT INTO `al_user` VALUES ('2', '100.00', 'Y', 'Ninguna', '2019-09-02 16:14:34', '100', '2019-09-02 16:14:38', '100', 'Kevin', 'kav.chuga@yavirac.edu.ec', 'velasco', '2', 'kevin');
INSERT INTO `al_user` VALUES ('3', '100.00', 'Y', 'Ninguna', '2019-09-02 16:31:03', '100', '2019-09-02 16:32:43', '100', 'Miguel', 'cmb.ramos@yavirac.edu.ec', 'al47', '1', 'miguel');
INSERT INTO `al_user` VALUES ('4', '100.00', 'Y', 'Ninguna', '2019-09-02 16:32:34', '100', '2019-09-17 12:14:24', '100', 'Milton', 'mmino@sidesoft.com.ec', 'al47', '2', 'milton');
INSERT INTO `al_user` VALUES ('5', '100.00', 'Y', 'Ninguna', '2019-09-17 12:14:10', '100', '2019-09-17 12:14:28', '100', 'Darwin', 'dquintana@sidesoft.com.ec', 'quintana', '1', 'darwin');

-- ----------------------------
-- Table structure for `al_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `al_user_role`;
CREATE TABLE `al_user_role` (
  `al_user_rol_id` int(10) NOT NULL AUTO_INCREMENT,
  `value` decimal(10,2) NOT NULL,
  `isactive` char(1) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `created_by` varchar(255) NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `al_user_id` int(10) NOT NULL,
  `al_role_id` int(10) NOT NULL,
  PRIMARY KEY (`al_user_rol_id`),
  KEY `al_role_id` (`al_role_id`) USING BTREE,
  KEY `al_user_id` (`al_user_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of al_user_role
-- ----------------------------
INSERT INTO `al_user_role` VALUES ('1', '100.00', 'Y', 'Ninguna', '2019-09-02 16:27:07', 'Admin', '2019-09-02 16:27:16', 'Admin', 'Admin', '1', '1');
INSERT INTO `al_user_role` VALUES ('2', '100.00', 'Y', 'Ninguna', '2019-09-02 16:28:42', 'Admin', '2019-09-02 16:28:56', 'Admin', 'Admin', '2', '1');
INSERT INTO `al_user_role` VALUES ('3', '100.00', 'Y', 'Ninguna', '2019-09-02 16:30:19', 'Admin', '2019-09-02 16:30:26', 'Admin', 'Client', '3', '2');
INSERT INTO `al_user_role` VALUES ('4', '100.00', 'Y', 'Ninguna', '2019-09-02 16:32:01', 'Admin', '2019-09-02 16:32:07', 'Admin', 'Client', '4', '2');

-- ----------------------------
-- Table structure for `ss_configuration`
-- ----------------------------
DROP TABLE IF EXISTS `ss_configuration`;
CREATE TABLE `ss_configuration` (
  `id_al_configuration` int(11) NOT NULL DEFAULT '0',
  `value` decimal(10,2) DEFAULT NULL,
  `isactive` char(1) DEFAULT NULL,
  `description` text,
  `created` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updated_by` varchar(10) DEFAULT NULL,
  `name` varchar(225) DEFAULT NULL,
  `al_org_id` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_al_configuration`),
  KEY `al_configuration_org` (`al_org_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ss_configuration
-- ----------------------------
INSERT INTO `ss_configuration` VALUES ('1', '100.00', 'y', 'url correo electronico', '2019-09-02 16:18:13', '100', '2019-09-02 16:18:27', '100', 'www.google.com', '1');

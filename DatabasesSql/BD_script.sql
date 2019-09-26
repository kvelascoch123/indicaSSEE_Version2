CREATE TABLE `al_area` (
`al_area_id` int(10) NOT NULL AUTO_INCREMENT,
`value` int(10) NOT NULL,
`isactive` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`description` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`created` datetime NOT NULL,
`created_by` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`updated` datetime NOT NULL,
`updated_by` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`al_org_id` int(10) NOT NULL,
PRIMARY KEY (`al_area_id`) ,
INDEX `al_org_id` (`al_org_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;
CREATE TABLE `al_factor` (
`al_factor_id` int(10) NOT NULL AUTO_INCREMENT,
`value` int(10) NOT NULL,
`isactive` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`description` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`created` datetime NOT NULL,
`created_by` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`updated` datetime NOT NULL,
`updated_by` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`al_org_id` int(11) NOT NULL,
`al_area_id` int(11) NOT NULL,
PRIMARY KEY (`al_factor_id`) ,
INDEX `al_org_id` (`al_org_id` ASC) USING BTREE,
INDEX `al_area_id` (`al_area_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 6
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;
CREATE TABLE `al_indicators` (
`al_indicator_id` int(11) NOT NULL AUTO_INCREMENT,
`value` int(10) NOT NULL,
`isactive` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`description` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`created` datetime NOT NULL,
`created_by` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`updated` datetime NOT NULL,
`updated_by` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`al_org_id` int(10) NOT NULL,
`al_user_role_id` int(10) NULL DEFAULT NULL,
`allow_monthly` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
`allow_not_compare` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
`al_factor_id` int(10) NULL DEFAULT NULL,
`criterial` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
`interpretation_need_compare` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'N',
`not_compare_value` decimal(10,2) NULL DEFAULT NULL,
`compare_middle_point_min` decimal(10,2) NULL DEFAULT NULL COMMENT 'Punto de Equilibrio',
`compare_middle_point_max` decimal(10,2) NULL DEFAULT NULL,
`txt_affirmative` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
`txt_negative` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
PRIMARY KEY (`al_indicator_id`) ,
INDEX `al_org_id` (`al_org_id` ASC) USING BTREE,
INDEX `al_user_role_id` (`al_user_role_id` ASC) USING BTREE,
INDEX `al_factor_id` (`al_factor_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 8
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;
CREATE TABLE `al_indicators_years` (
`al_indicator_id` int(11) NOT NULL AUTO_INCREMENT,
`value` int(10) NOT NULL,
`isactive` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`description` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`created` datetime NOT NULL,
`created_by` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`updated` datetime NOT NULL,
`updated_by` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`al_org_id` int(10) NOT NULL,
`al_user_role_id` int(10) NULL DEFAULT NULL,
`last_year` decimal(4,2) NULL DEFAULT NULL,
`current_year` decimal(4,2) NULL DEFAULT NULL,
`variation_between_years` decimal(4,2) NULL DEFAULT NULL,
`last_month` decimal(4,2) NULL DEFAULT NULL,
`current_month` decimal(4,2) NULL DEFAULT NULL,
`variation_between_months` decimal(4,2) NULL DEFAULT NULL,
`al_factor_id` int(10) NULL DEFAULT NULL,
`year` varchar(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
`month` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
`criterial` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
PRIMARY KEY (`al_indicator_id`) ,
INDEX `al_org_id` (`al_org_id` ASC) USING BTREE,
INDEX `al_user_role_id` (`al_user_role_id` ASC) USING BTREE,
INDEX `al_factor_id` (`al_factor_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 11
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;
CREATE TABLE `al_org` (
`al_org_id` int(10) NOT NULL AUTO_INCREMENT,
`value` int(10) NOT NULL,
`isactive` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`description` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`created` datetime NOT NULL,
`created_by` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`updated` datetime NOT NULL,
`updated_by` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
PRIMARY KEY (`al_org_id`) 
)
ENGINE = MyISAM
AUTO_INCREMENT = 3
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;
CREATE TABLE `al_role` (
`al_role_id` int(10) NOT NULL AUTO_INCREMENT,
`value` decimal(10,2) NOT NULL,
`isactive` varchar(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`description` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`created` datetime NOT NULL,
`created_by` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`update` datetime NOT NULL,
`update_by` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`al_org_id` int(10) NOT NULL,
PRIMARY KEY (`al_role_id`) ,
INDEX `al_org_id` (`al_org_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;
CREATE TABLE `al_user` (
`al_user_id` int(10) NOT NULL AUTO_INCREMENT,
`value` decimal(10,2) NOT NULL,
`isactive` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`description` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`created` datetime NOT NULL,
`created_by` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`updated` datetime NOT NULL,
`updated_by` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`user_password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`al_org_id` int(10) NOT NULL,
`alias_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
PRIMARY KEY (`al_user_id`) ,
INDEX `al_org_id` (`al_org_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 5
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;
CREATE TABLE `al_user_role` (
`al_user_rol_id` int(10) NOT NULL AUTO_INCREMENT,
`value` decimal(10,2) NOT NULL,
`isactive` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`description` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`created` datetime NOT NULL,
`created_by` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`updated` datetime NOT NULL,
`updated_by` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
`al_user_id` int(10) NOT NULL,
`al_role_id` int(10) NOT NULL,
PRIMARY KEY (`al_user_rol_id`) ,
INDEX `al_role_id` (`al_role_id` ASC) USING BTREE,
INDEX `al_user_id` (`al_user_id` ASC) USING BTREE
)
ENGINE = MyISAM
AUTO_INCREMENT = 5
AVG_ROW_LENGTH = 0
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
KEY_BLOCK_SIZE = 0
MAX_ROWS = 0
MIN_ROWS = 0
ROW_FORMAT = Dynamic;

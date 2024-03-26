-- DB update 2021_06_18_12 -> 2021_06_18_13
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_18_12';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_18_12 2021_06_18_13 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1623112710636791400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623112710636791400');

DELETE FROM `acore_string` WHERE `entry` = 6617;
INSERT INTO `acore_string` VALUES (6617, 'No acore_string for id: %i found.', null, null, 'Es wurde kein acore_string mit der id: %i gefunden.', null, null, null, null, null);

DELETE FROM `command` WHERE `name` = 'string';
INSERT INTO `command` VALUES ('string', 2, 'Syntax: .string #id [#locale]');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_18_13' WHERE sql_rev = '1623112710636791400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

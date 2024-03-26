-- DB update 2021_10_07_01 -> 2021_10_07_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_07_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_07_01 2021_10_07_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632482613720296800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632482613720296800');

DELETE FROM `spell_script_names` WHERE `spell_id`=43714;
INSERT INTO `spell_script_names` VALUES
(43714,'spell_brewfest_relay_race_force_cast');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_07_02' WHERE sql_rev = '1632482613720296800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

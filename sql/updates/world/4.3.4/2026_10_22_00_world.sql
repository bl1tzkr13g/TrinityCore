-- Blood Elf starting-zone class trainers: remove stale gossip assignments.
-- On this 4.3.4 core these menu assignments have no usable trainer option,
-- preventing the default trainer interaction even though creature_trainer is populated.
-- Keep the original rows in a dedicated backup table for easy rollback.
-- Scope is deliberately limited to the seven confirmed NPC/menu pairs.

CREATE TABLE IF NOT EXISTS `backup_belf_starting_trainer_gossip_20261022` LIKE `creature_template_gossip`;

INSERT IGNORE INTO `backup_belf_starting_trainer_gossip_20261022`
SELECT g.*
FROM `creature_template_gossip` AS g
WHERE (g.`CreatureID`, g.`MenuID`) IN (
    (15279, 14136), -- Julia Sunstriker (Mage)
    (15280, 14137), -- Jesthenis Sunstriker (Paladin)
    (15283, 14138), -- Summoner Teli'Larien (Warlock)
    (15284, 14139), -- Matron Arena (Priest)
    (15285, 14140), -- Pathstalker Kariel (Rogue)
    (15513, 14141), -- Ranger Sallina (Hunter)
    (16270, 14144)  -- Hannovia (Hunter)
);

DELETE FROM `creature_template_gossip`
WHERE (`CreatureID`, `MenuID`) IN (
    (15279, 14136),
    (15280, 14137),
    (15283, 14138),
    (15284, 14139),
    (15285, 14140),
    (15513, 14141),
    (16270, 14144)
);

-- Rogue and Hunter starting trainers need their dedicated gossip menus.
-- These menus contain trainer options plus talent-reset and quest interactions.
-- The preceding update removes stale 14140/14141 assignments; this update
-- attaches the verified 4.3.4 trainer menus instead.
-- Safe to re-run: updates existing matching rows without duplicating them.

INSERT INTO `creature_template_gossip` (`CreatureID`, `MenuID`, `VerifiedBuild`)
VALUES
    (15285, 6650, 15595), -- Pathstalker Kariel (Rogue)
    (15513, 6652, 15595)  -- Ranger Sallina (Hunter)
ON DUPLICATE KEY UPDATE `VerifiedBuild` = VALUES(`VerifiedBuild`);


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

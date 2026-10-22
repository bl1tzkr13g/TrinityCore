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

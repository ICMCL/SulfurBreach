scoreboard players add @s sb_hp 1
execute unless score @s sb_hp < #col_max_hp sb_var run tag @s remove sb_need_rep
function sb:arena/col_render
particle minecraft:happy_villager ~ ~1.1 ~ 0.35 0.5 0.35 0.05 12 force

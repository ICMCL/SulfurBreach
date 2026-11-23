execute unless entity @a[tag=sb_hitter,limit=1] run return 0
execute if entity @s[type=minecraft:sulfur_cube,tag=sb_ball] at @s run function sb:cube/on_jab_hit
tag @a[tag=sb_hitter] remove sb_hitter

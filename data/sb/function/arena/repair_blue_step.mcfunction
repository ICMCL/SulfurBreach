execute unless score #rep_left sb_var matches 1.. run return 0
execute unless entity @e[type=marker,tag=sb_wblue,tag=sb_need_rep] run return 0
tag @e[tag=sb_rep_pick] remove sb_rep_pick
tag @e[type=marker,tag=sb_wblue,tag=sb_need_rep,sort=nearest,limit=1] add sb_rep_pick
execute as @e[type=marker,tag=sb_rep_pick,limit=1] run scoreboard players add @s sb_hp 1
execute as @e[type=marker,tag=sb_rep_pick,limit=1] unless score @s sb_hp < #col_max_hp sb_var run tag @s remove sb_need_rep
execute as @e[type=marker,tag=sb_rep_pick,limit=1] at @s run function sb:arena/col_render
execute as @e[type=marker,tag=sb_rep_pick,limit=1] at @s run particle minecraft:happy_villager ~ ~1.1 ~ 0.35 0.5 0.35 0.05 12 force
tag @e[tag=sb_rep_pick] remove sb_rep_pick
scoreboard players remove #rep_left sb_var 1
execute if score #rep_left sb_var matches 1.. run function sb:arena/repair_blue_step

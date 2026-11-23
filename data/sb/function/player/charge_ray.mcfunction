execute unless block ~ ~ ~ air unless block ~ ~ ~ barrier run return 0
execute positioned ~ ~-0.45 ~ if entity @e[type=sulfur_cube,tag=sb_ball,scores={sb_state=1..2},distance=..0.8] run return run execute as @n[type=sulfur_cube,tag=sb_ball,scores={sb_state=1..2},distance=..0.8] at @s run function sb:cube/try_charge_hit
scoreboard players remove #ray_steps sb_var 1
execute if score #ray_steps sb_var matches 1.. positioned ^ ^ ^0.25 run function sb:player/charge_ray

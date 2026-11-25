# 重锤：中心列 -2 HP，相邻两列各 -1 HP。
scoreboard players operation #hc_l sb_var = @e[type=marker,tag=sb_hit_col,limit=1] sb_col
scoreboard players operation #hc_r sb_var = #hc_l sb_var
scoreboard players remove #hc_l sb_var 1
scoreboard players add #hc_r sb_var 1
scoreboard players set #dmg sb_var 2
execute as @e[type=marker,tag=sb_hit_col,limit=1] at @s run function sb:arena/col_damage
scoreboard players set #dmg sb_var 1
$execute as @e[type=marker,tag=sb_w$(team),scores={sb_hp=1..}] if score @s sb_col = #hc_l sb_var at @s run function sb:arena/col_damage
$execute as @e[type=marker,tag=sb_w$(team),scores={sb_hp=1..}] if score @s sb_col = #hc_r sb_var at @s run function sb:arena/col_damage
tag @e[type=marker,tag=sb_hit_col] remove sb_hit_col
particle minecraft:lava ~ ~0.8 ~ 0.35 0.6 0.6 0.15 24 force
playsound minecraft:block.anvil.land master @a ~ ~1 ~ 1.1 0.85
function sb:cube/destroy_ball
function sb:arena/recalc_hp

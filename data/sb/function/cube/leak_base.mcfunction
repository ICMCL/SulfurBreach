# 背板只影响落点周围的列：常规/修补半径 2，超载半径 3。
execute if score #bcol_raw sb_var matches ..-10 run scoreboard players set #bcol_raw sb_var -9
execute if score #bcol_raw sb_var matches 10.. run scoreboard players set #bcol_raw sb_var 9
scoreboard players set #rad sb_var 2
execute if score @s sb_state matches 2 unless score @s sb_special matches 2 run scoreboard players set #rad sb_var 3
scoreboard players operation #col_min sb_var = #bcol_raw sb_var
scoreboard players operation #col_min sb_var -= #rad sb_var
scoreboard players operation #col_max sb_var = #bcol_raw sb_var
scoreboard players operation #col_max sb_var += #rad sb_var

$execute if score @s sb_special matches 2 as @e[type=marker,tag=sb_w$(team)] if score @s sb_col >= #col_min sb_var if score @s sb_col <= #col_max sb_var if score @s sb_hp < #col_max_hp sb_var run tag @s add sb_need_rep
$execute if score @s sb_special matches 2 run return run function sb:cube/repair_wall {message:"泥砖修墙芯补入$(side)方破口 (+2 HP)！"}

tag @e[type=marker,tag=sb_aoe_col] remove sb_aoe_col
$execute as @e[type=marker,tag=sb_w$(team),scores={sb_hp=1..}] if score @s sb_col >= #col_min sb_var if score @s sb_col <= #col_max sb_var run tag @s add sb_aoe_col
$execute unless entity @e[type=marker,tag=sb_aoe_col,limit=1] run return run function sb:cube/back_bounce {sign:$(sign)}

scoreboard players set #dmg sb_var 1
execute as @e[type=marker,tag=sb_aoe_col] at @s run function sb:arena/col_damage
execute as @e[type=marker,tag=sb_aoe_col] at @s run particle minecraft:electric_spark ~ ~1.1 ~ 0.3 0.6 0.3 0.2 14 force
tag @e[type=marker,tag=sb_aoe_col] remove sb_aoe_col
particle minecraft:electric_spark ~ ~0.8 ~ 0.4 0.8 1.0 0.3 36 force
playsound minecraft:entity.lightning_bolt.impact master @a ~ ~1 ~ 0.8 1.35
playsound minecraft:block.respawn_anchor.deplete master @a ~ ~1 ~ 1.15 0.95
$title @a[tag=sb_ingame] actionbar {text:"⚡ $(side)方背板震波！落点半径内残墙各 -1 HP！",color:"$(team)",bold:true}
function sb:cube/destroy_ball
function sb:arena/recalc_hp

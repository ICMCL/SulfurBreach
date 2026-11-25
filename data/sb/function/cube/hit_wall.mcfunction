# 优先命中正前方 Z 列。正前方是缺口时，仅在速度表明已撞到邻列后才结算。
tag @e[type=marker,tag=sb_hit_col] remove sb_hit_col
$execute if score #bcol_raw sb_var matches -9..9 as @e[type=marker,tag=sb_w$(team),scores={sb_hp=1..}] if score @s sb_col = #bcol_raw sb_var run tag @s add sb_hit_col
$execute if score @s sb_vx matches $(incoming) if score #cur_vx sb_var matches $(deflected) unless entity @e[type=marker,tag=sb_hit_col,limit=1] run tag @n[type=marker,tag=sb_w$(team),scores={sb_hp=1..},distance=..1.42] add sb_hit_col
execute unless entity @e[type=marker,tag=sb_hit_col,limit=1] run return 0

$execute if score @s sb_special matches 2 as @e[type=marker,tag=sb_w$(team)] if score @s sb_hp < #col_max_hp sb_var run tag @s add sb_need_rep
$execute if score @s sb_special matches 2 run return run function sb:cube/repair_wall {message:"泥砖修墙芯撞击$(side)墙，恢复 2 HP！"}
$execute if score @s sb_state matches 2 run return run function sb:cube/hit_overload {team:"$(team)"}

scoreboard players set #dmg sb_var 1
execute as @e[type=marker,tag=sb_hit_col,limit=1] at @s run function sb:arena/col_damage
tag @e[type=marker,tag=sb_hit_col] remove sb_hit_col
execute if score #col_broke sb_var matches 1 run function sb:cube/destroy_ball
execute if score #col_broke sb_var matches 0 run function sb:cube/set_state_spent
$execute if score #col_broke sb_var matches 0 store result entity @s Motion[0] double 0.001 run scoreboard players set @s sb_vx $(bounce)
function sb:arena/recalc_hp

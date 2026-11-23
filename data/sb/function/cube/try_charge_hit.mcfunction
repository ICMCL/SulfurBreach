# ===== 右键架矛迎击 (Charge) 相对闭合速度校验（不区分球由谁击出，对所有运动冲撞球一视同仁） =====
execute unless score @s sb_state matches 1..2 run return 0
execute unless score @s sb_hit_cd matches 0 run return 0

execute store result score #bvx sb_var run data get entity @s Motion[0] 1000
execute store result score #bvz sb_var run data get entity @s Motion[2] 1000

scoreboard players operation #rvx sb_var = #pvx sb_var
scoreboard players operation #rvx sb_var -= #bvx sb_var
scoreboard players operation #rvz sb_var = #pvz sb_var
scoreboard players operation #rvz sb_var -= #bvz sb_var

scoreboard players operation #cls sb_var = #rvx sb_var
scoreboard players operation #cls sb_var *= #fx sb_var
scoreboard players operation #ctmp sb_var = #rvz sb_var
scoreboard players operation #ctmp sb_var *= #fz sb_var
scoreboard players operation #cls sb_var += #ctmp sb_var
scoreboard players operation #cls sb_var /= #1000 sb_const

execute if score #cls sb_var >= #parry_min sb_var run function sb:cube/on_charge_hit

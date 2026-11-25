# 仅在缩圈（双墙前推 push_step）时触发：将处于新墙推进带内的玩家或硫方怪推入安全内侧（仅校正 X，硫方怪额外给向内回弹速度）
execute store result score #ex sb_var run data get entity @s Pos[0] 1000
scoreboard players set #moved sb_var 0

execute if score #ex sb_var < #clamp_min_x sb_var run scoreboard players set #moved sb_var 1
execute if score #ex sb_var < #clamp_min_x sb_var run scoreboard players operation #ex sb_var = #clamp_min_x sb_var

execute if score #ex sb_var > #clamp_max_x sb_var run scoreboard players set #moved sb_var 2
execute if score #ex sb_var > #clamp_max_x sb_var run scoreboard players operation #ex sb_var = #clamp_max_x sb_var

execute if score #moved sb_var matches 1.. if entity @s[type=player] run scoreboard players operation @s sb_px = #ex sb_var
execute if score #moved sb_var matches 1.. store result storage sb:tmp tp.x double 0.001 run scoreboard players get #ex sb_var
execute if score #moved sb_var matches 1.. at @s run function sb:arena/tp_x_m with storage sb:tmp tp

execute if score #moved sb_var matches 1 if entity @s[type=sulfur_cube] run data modify entity @s Motion[0] set value 0.48d
execute if score #moved sb_var matches 1 if entity @s[type=sulfur_cube] run scoreboard players set @s sb_vx 480
execute if score #moved sb_var matches 2 if entity @s[type=sulfur_cube] run data modify entity @s Motion[0] set value -0.48d
execute if score #moved sb_var matches 2 if entity @s[type=sulfur_cube] run scoreboard players set @s sb_vx -480

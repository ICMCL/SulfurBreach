# 将处于推进墙带内的玩家或硫方怪平滑推入新半场安全侧（保留玩家视角，硫方怪同步赋予向内回弹速度）
execute store result score #ex sb_var run data get entity @s Pos[0] 1000
execute store result score #ez sb_var run data get entity @s Pos[2] 1000
scoreboard players set #moved sb_var 0

execute if score #ex sb_var < #clamp_min_x sb_var run scoreboard players set #moved sb_var 1
execute if score #ex sb_var < #clamp_min_x sb_var if entity @s[type=sulfur_cube] run data modify entity @s Motion[0] set value 0.48d
execute if score #ex sb_var < #clamp_min_x sb_var if entity @s[type=sulfur_cube] run scoreboard players set @s sb_vx 480
execute if score #ex sb_var < #clamp_min_x sb_var run scoreboard players operation #ex sb_var = #clamp_min_x sb_var

execute if score #ex sb_var > #clamp_max_x sb_var run scoreboard players set #moved sb_var 1
execute if score #ex sb_var > #clamp_max_x sb_var if entity @s[type=sulfur_cube] run data modify entity @s Motion[0] set value -0.48d
execute if score #ex sb_var > #clamp_max_x sb_var if entity @s[type=sulfur_cube] run scoreboard players set @s sb_vx -480
execute if score #ex sb_var > #clamp_max_x sb_var run scoreboard players operation #ex sb_var = #clamp_max_x sb_var

execute if score #moved sb_var matches 1 store result storage sb:tmp tp.x double 0.001 run scoreboard players get #ex sb_var
execute if score #moved sb_var matches 1 store result storage sb:tmp tp.z double 0.001 run scoreboard players get #ez sb_var
execute if score #moved sb_var matches 1 run function sb:arena/tp_xz_m with storage sb:tmp tp

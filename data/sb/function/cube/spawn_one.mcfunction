# 在中央 5 格共享中立区 (x=0.5, z=-7.5..+7.5) 生成一只空心晃荡硫方怪（若开启突变球则每第 4 只预装冰芯/修墙芯）
execute store result score #sz sb_var run random value -7..7
execute if score #o_layout sb_var matches 1 if score #sz sb_var matches -5 run scoreboard players set #sz sb_var -3
execute if score #o_layout sb_var matches 1 if score #sz sb_var matches 5 run scoreboard players set #sz sb_var 3

execute store result storage sb:tmp sp.z int 1 run scoreboard players get #sz sb_var
function sb:cube/spawn_at_m with storage sb:tmp sp

scoreboard players add #spawn_seq sb_var 1
execute as @e[type=sulfur_cube,tag=sb_new] at @s run function sb:cube/init_spawned
tag @e[type=sulfur_cube,tag=sb_new] remove sb_new

# 若场上仍缺球，间隔 15 tick 继续补齐；否则重置标准 30 tick (1.5s) 补球冷却
scoreboard players set #spawn_cd sb_var 30
scoreboard players add #cur_balls sb_var 1
execute if score #cur_balls sb_var < #ball_cap sb_var run scoreboard players set #spawn_cd sb_var 15

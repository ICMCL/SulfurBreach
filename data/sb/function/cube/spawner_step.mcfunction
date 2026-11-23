# ===== 场内硫方怪常驻数量维持与中立区补球调度 =====
scoreboard players operation #ball_cap sb_var = #cfg_balls sb_var
execute if score #cfg_dur sb_var matches 1.. if score #rem_sec sb_var matches ..24 run scoreboard players add #ball_cap sb_var 1
execute if score #sudden_death sb_var matches 1 run scoreboard players add #ball_cap sb_var 1

scoreboard players set #cur_balls sb_var 0
execute as @e[type=sulfur_cube,tag=sb_ball] run scoreboard players add #cur_balls sb_var 1

execute if score #cur_balls sb_var >= #ball_cap sb_var run return 0

execute if score #spawn_cd sb_var matches 1.. run scoreboard players remove #spawn_cd sb_var 1
execute if score #spawn_cd sb_var matches ..0 run function sb:cube/spawn_one

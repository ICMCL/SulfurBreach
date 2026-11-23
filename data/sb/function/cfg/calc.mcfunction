# 根据选项索引计算实际生效数值
scoreboard players set #cfg_dur sb_var 120
execute if score #o_dur sb_var matches 0 run scoreboard players set #cfg_dur sb_var 90
execute if score #o_dur sb_var matches 2 run scoreboard players set #cfg_dur sb_var 180
execute if score #o_dur sb_var matches 3 run scoreboard players set #cfg_dur sb_var 0

scoreboard players set #cfg_balls sb_var 2
execute if score #o_balls sb_var matches 0 run scoreboard players set #cfg_balls sb_var 1
execute if score #o_balls sb_var matches 2 run scoreboard players set #cfg_balls sb_var 3

scoreboard players operation #col_max_hp sb_var = #o_wall_hp sb_var
scoreboard players add #col_max_hp sb_var 1
scoreboard players operation #wall_max_hp sb_var = #col_max_hp sb_var
scoreboard players operation #wall_max_hp sb_var *= #19 sb_const

scoreboard players operation #speed_pct sb_var = #o_speed sb_var
scoreboard players operation #speed_pct sb_var *= #25 sb_const
scoreboard players add #speed_pct sb_var 75

scoreboard players set #cfg_recall_sec sb_var 3
execute if score #o_recall sb_var matches 1 run scoreboard players set #cfg_recall_sec sb_var 5
execute if score #o_recall sb_var matches 2 run scoreboard players set #cfg_recall_sec sb_var 8
execute if score #o_recall sb_var matches 3 run scoreboard players set #cfg_recall_sec sb_var 0
scoreboard players operation #cfg_recall_ticks sb_var = #cfg_recall_sec sb_var
scoreboard players operation #cfg_recall_ticks sb_var *= #20 sb_const

# 右键架矛迎击门槛：5.5 格/秒 = 275 千分格/tick（穿 +25% 疾风战靴平地疾跑约 7.0 格/秒 = 350）
scoreboard players set #parry_min sb_var 275

# 背板空洞反弹回场保护：当球刚从大缺口背板弹回、尚未完全离开墙线时，若斜向擦到实心邻列背面则平滑推出缺口前侧防卡死
execute store result score #bpx sb_var run data get entity @s Pos[0] 1000
execute store result score #bpz sb_var run data get entity @s Pos[2] 1000
scoreboard players operation #bcol_raw sb_var = #bpz sb_var
scoreboard players operation #bcol_raw sb_var /= #1000 sb_const

execute if score #bpx sb_var < #r_front sb_var if score #bcol_raw sb_var matches -9..9 as @e[type=marker,tag=sb_wred,scores={sb_hp=1..}] if score @s sb_col = #bcol_raw sb_var run scoreboard players set #need_eject_r sb_var 1
execute if score #need_eject_r sb_var matches 1 store result storage sb:tmp tp.x double 0.001 run scoreboard players get #r_front sb_var
execute if score #need_eject_r sb_var matches 1 at @s run function sb:arena/tp_x_m with storage sb:tmp tp
execute if score #need_eject_r sb_var matches 1 run function sb:cube/restore_vel
scoreboard players set #need_eject_r sb_var 0

execute if score #bpx sb_var > #b_front sb_var if score #bcol_raw sb_var matches -9..9 as @e[type=marker,tag=sb_wblue,scores={sb_hp=1..}] if score @s sb_col = #bcol_raw sb_var run scoreboard players set #need_eject_b sb_var 1
execute if score #need_eject_b sb_var matches 1 store result storage sb:tmp tp.x double 0.001 run scoreboard players get #b_front sb_var
execute if score #need_eject_b sb_var matches 1 at @s run function sb:arena/tp_x_m with storage sb:tmp tp
execute if score #need_eject_b sb_var matches 1 run function sb:cube/restore_vel
scoreboard players set #need_eject_b sb_var 0

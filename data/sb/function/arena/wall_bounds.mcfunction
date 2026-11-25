# 千分格墙线：场地重置、双墙前推或载入已有存档时更新，不随球移动。
scoreboard players operation #r_wall_xm sb_var = #r_wall_x sb_var
scoreboard players operation #r_wall_xm sb_var *= #1000 sb_const
scoreboard players operation #b_wall_xm sb_var = #b_wall_x sb_var
scoreboard players operation #b_wall_xm sb_var *= #1000 sb_const

scoreboard players operation #hit_r sb_var = #r_wall_xm sb_var
scoreboard players add #hit_r sb_var 1650
scoreboard players operation #hit_b sb_var = #b_wall_xm sb_var
scoreboard players remove #hit_b sb_var 650
scoreboard players operation #r_front sb_var = #r_wall_xm sb_var
scoreboard players add #r_front sb_var 1520
scoreboard players operation #b_front sb_var = #b_wall_xm sb_var
scoreboard players remove #b_front sb_var 520

scoreboard players operation #leak_r sb_var = #r_wall_xm sb_var
scoreboard players add #leak_r sb_var 450
scoreboard players operation #leak_b sb_var = #b_wall_xm sb_var
scoreboard players add #leak_b sb_var 550
scoreboard players operation #back_r_deep sb_var = #r_wall_xm sb_var
scoreboard players remove #back_r_deep sb_var 150
scoreboard players operation #back_b_deep sb_var = #b_wall_xm sb_var
scoreboard players add #back_b_deep sb_var 1150

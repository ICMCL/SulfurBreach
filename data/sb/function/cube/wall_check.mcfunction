# ===== 守护墙实心撞击与背板局部半径震波检测（无阵营区分，撞哪面墙就结算哪面墙） =====
execute store result score #bpx sb_var run data get entity @s Pos[0] 1000
execute store result score #bpz sb_var run data get entity @s Pos[2] 1000
execute store result score #cur_vx sb_var run data get entity @s Motion[0] 1000

scoreboard players operation #bcol_raw sb_var = #bpz sb_var
scoreboard players operation #bcol_raw sb_var /= #1000 sb_const

# 1. 背板（墙后底线外护壁）碰撞检测：
# 红侧触达背板带 (<= r_wall_xm - 150) 或已入底线被背板弹回/截停 (<= r_wall_xm + 450 且 cur_vx >= -30)
scoreboard players set #hit_back_r sb_var 0
scoreboard players operation #back_r_deep sb_var = #r_wall_xm sb_var
scoreboard players remove #back_r_deep sb_var 150
scoreboard players operation #leak_r sb_var = #r_wall_xm sb_var
scoreboard players add #leak_r sb_var 450
execute if score @s sb_back_cd matches 0 if score #bpx sb_var <= #back_r_deep sb_var run scoreboard players set #hit_back_r sb_var 1
execute if score @s sb_back_cd matches 0 if score #bpx sb_var <= #leak_r sb_var if score #cur_vx sb_var matches -30.. run scoreboard players set #hit_back_r sb_var 1
execute if score #hit_back_r sb_var matches 1 run return run function sb:cube/leak_red_base

# 蓝侧触达背板带 (>= b_wall_xm + 1150) 或已入底线被背板弹回/截停 (>= b_wall_xm + 550 且 cur_vx <= 30)
scoreboard players set #hit_back_b sb_var 0
scoreboard players operation #back_b_deep sb_var = #b_wall_xm sb_var
scoreboard players add #back_b_deep sb_var 1150
scoreboard players operation #leak_b sb_var = #b_wall_xm sb_var
scoreboard players add #leak_b sb_var 550
execute if score @s sb_back_cd matches 0 if score #bpx sb_var >= #back_b_deep sb_var run scoreboard players set #hit_back_b sb_var 1
execute if score @s sb_back_cd matches 0 if score #bpx sb_var >= #leak_b sb_var if score #cur_vx sb_var matches ..30 run scoreboard players set #hit_back_b sb_var 1
execute if score #hit_back_b sb_var matches 1 run return run function sb:cube/leak_blue_base

# 2. 实心守护墙正面碰撞检测（仅冲撞态 1 / 重锤态 2 生效；卸力态 3 及刚从背板回弹的球不伤实心墙）
execute unless score @s sb_state matches 1..2 run return 0
execute if score @s sb_back_cd matches 1.. run return 0

scoreboard players operation #hit_r sb_var = #r_wall_xm sb_var
scoreboard players add #hit_r sb_var 1650
execute if score #bpx sb_var <= #hit_r sb_var run return run function sb:cube/hit_red_wall

scoreboard players operation #hit_b sb_var = #b_wall_xm sb_var
scoreboard players remove #hit_b sb_var 650
execute if score #bpx sb_var >= #hit_b sb_var run return run function sb:cube/hit_blue_wall

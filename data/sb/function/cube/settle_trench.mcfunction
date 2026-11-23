execute store result score #bpx sb_var run data get entity @s Pos[0] 1000
execute store result score #bpz sb_var run data get entity @s Pos[2] 1000
execute store result score #cur_vx sb_var run data get entity @s Motion[0] 1000
scoreboard players operation #bcol_raw sb_var = #bpz sb_var
scoreboard players operation #bcol_raw sb_var /= #1000 sb_const

scoreboard players operation #leak_r sb_var = #r_wall_xm sb_var
scoreboard players add #leak_r sb_var 450
execute if score @s sb_back_cd matches 0 if score #bpx sb_var <= #leak_r sb_var run return run function sb:cube/leak_red_base

scoreboard players operation #leak_b sb_var = #b_wall_xm sb_var
scoreboard players add #leak_b sb_var 550
execute if score @s sb_back_cd matches 0 if score #bpx sb_var >= #leak_b sb_var run return run function sb:cube/leak_blue_base

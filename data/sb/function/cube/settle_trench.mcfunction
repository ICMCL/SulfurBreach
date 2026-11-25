execute unless score @s sb_back_cd matches 0 run return 0
execute store result score #bpx sb_var run data get entity @s Pos[0] 1000
execute if score #bpx sb_var > #leak_r sb_var if score #bpx sb_var < #leak_b sb_var run return 0
execute store result score #bcol_raw sb_var run data get entity @s Pos[2] 1000
execute store result score #cur_vx sb_var run data get entity @s Motion[0] 1000
scoreboard players operation #bcol_raw sb_var /= #1000 sb_const

execute if score #bpx sb_var <= #leak_r sb_var run return run function sb:cube/leak_base with storage sb:t red
execute if score #bpx sb_var >= #leak_b sb_var run return run function sb:cube/leak_base with storage sb:t blue

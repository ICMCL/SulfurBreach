# ===== 开局重置 29×21 三区球场与两侧 19 列满血守护墙 =====
execute as @e[type=sulfur_cube] run data remove entity @s equipment
execute as @e[type=sulfur_cube] run data remove entity @s CustomName
execute as @e[type=sulfur_cube] run data modify entity @s Size set value 0
tp @e[type=sulfur_cube] 0 -200 0
kill @e[type=sulfur_cube]
kill @e[type=wind_charge]
kill @e[type=item,x=-15,y=64,z=-11,dx=30,dy=6,dz=22]
kill @e[type=marker,tag=sb_wcol]
kill @e[type=marker,tag=sb_bumper]

fill -14 65 -10 14 70 10 air
function sb:arena/floor

scoreboard players set #push_stage sb_var 0
scoreboard players set #r_base_x sb_var -14
scoreboard players set #r_wall_x sb_var -13
scoreboard players set #b_wall_x sb_var 13
scoreboard players set #b_base_x sb_var 14
scoreboard players set #r_wall_xm sb_var -13000
scoreboard players set #b_wall_xm sb_var 13000
scoreboard players set #spawn_cd sb_var 10
scoreboard players set #spawn_seq sb_var 0
scoreboard players set #sudden_death sb_var 0
scoreboard players set #match_sec sb_var 0

function sb:arena/walls_init
execute if score #o_layout sb_var matches 1 run function sb:arena/bumpers_init

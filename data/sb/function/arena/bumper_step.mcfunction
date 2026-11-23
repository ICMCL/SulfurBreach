execute store result score #bx sb_var run data get entity @s Pos[0] 1000
execute store result score #bz sb_var run data get entity @s Pos[2] 1000
execute as @e[type=sulfur_cube,tag=sb_ball,scores={sb_state=1..2},distance=..1.38] unless score @s sb_bumper_cd matches 1.. at @s run function sb:arena/bumper_bounce

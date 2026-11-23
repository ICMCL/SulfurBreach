execute unless entity @n[type=marker,tag=sb_math] run summon marker 0 64 0 {Tags:["sb_math"]}
execute at @s rotated ~ 0 positioned ^ ^ ^1 run tp @n[type=marker,tag=sb_math] ~ ~ ~
execute store result score #fx sb_var run data get entity @n[type=marker,tag=sb_math] Pos[0] 1000
execute store result score #fz sb_var run data get entity @n[type=marker,tag=sb_math] Pos[2] 1000
execute store result score #ox sb_var run data get entity @s Pos[0] 1000
execute store result score #oz sb_var run data get entity @s Pos[2] 1000
scoreboard players operation #fx sb_var -= #ox sb_var
scoreboard players operation #fz sb_var -= #oz sb_var
tag @s add sb_hitter

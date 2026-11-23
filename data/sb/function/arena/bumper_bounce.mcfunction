# 紫水晶偏转柱：赋予 35° 斜向旋量与弹射提速
scoreboard players set @s sb_bumper_cd 8
execute store result score #cx sb_var run data get entity @s Pos[0] 1000
execute store result score #cz sb_var run data get entity @s Pos[2] 1000

scoreboard players operation #rx sb_var = #cx sb_var
scoreboard players operation #rx sb_var -= #bx sb_var
scoreboard players operation #rz sb_var = #cz sb_var
scoreboard players operation #rz sb_var -= #bz sb_var

scoreboard players operation #tx sb_var = #rz sb_var
scoreboard players operation #tx sb_var *= #-1 sb_const
scoreboard players operation #tx sb_var *= #3 sb_const
scoreboard players operation #tx sb_var /= #5 sb_const

scoreboard players operation #tz sb_var = #rx sb_var
scoreboard players operation #tz sb_var *= #3 sb_const
scoreboard players operation #tz sb_var /= #5 sb_const

execute if score #g2 sb_var matches 1 run scoreboard players operation #tx sb_var *= #-1 sb_const
execute if score #g2 sb_var matches 1 run scoreboard players operation #tz sb_var *= #-1 sb_const

scoreboard players operation #in_x sb_var = #rx sb_var
scoreboard players operation #in_x sb_var += #tx sb_var
scoreboard players operation #in_z sb_var = #rz sb_var
scoreboard players operation #in_z sb_var += #tz sb_var
scoreboard players set #target_spd sb_var 1020
execute if score @s sb_state matches 2 run scoreboard players set #target_spd sb_var 1260
function sb:util/norm2d

function sb:cube/set_horizontal
data modify entity @s Motion[1] set value 0.05d

particle minecraft:electric_spark ~ ~0.5 ~ 0.35 0.35 0.35 0.25 20 force
playsound minecraft:block.amethyst_block.chime master @a ~ ~0.5 ~ 1.4 1.35
playsound minecraft:block.amethyst_cluster.hit master @a ~ ~0.5 ~ 1.0 1.2

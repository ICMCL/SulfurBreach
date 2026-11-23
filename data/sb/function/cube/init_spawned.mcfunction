# 初始化新刷出的中立区硫方怪（默认空心；若开启突变开关则每第 4 球轮换蓝冰极速芯 / 泥砖修墙芯）
attribute @s minecraft:max_health base set 1024.0
data modify entity @s Health set value 1024.0f
scoreboard players set @s sb_hit_cd 0
scoreboard players set @s sb_back_cd 0
scoreboard players set @s sb_bumper_cd 0
scoreboard players set @s sb_stuck 0
function sb:cube/set_state_empty

scoreboard players operation #m_rem sb_var = #spawn_seq sb_var
scoreboard players operation #m_rem sb_var %= #4 sb_const
execute if score #o_mutant sb_var matches 1 if score #m_rem sb_var matches 0 run function sb:cube/init_mutant

execute store result score @s sb_px run data get entity @s Pos[0] 1000
execute store result score @s sb_pz run data get entity @s Pos[2] 1000
scoreboard players set @s sb_vx 0
scoreboard players set @s sb_vz 0

particle minecraft:poof ~ ~0.4 ~ 0.25 0.25 0.25 0.04 12 force
playsound minecraft:entity.sulfur_cube.squish master @a ~ ~0.5 ~ 0.9 1.2

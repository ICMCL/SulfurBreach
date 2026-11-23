# 半场与共享 5 格中立区 (x=-2..+2, 实体坐标 [-2.0, +3.0]) 软边界约束：
# 红队允许范围：[r_wall_xm + 1350, +2700]；蓝队允许范围：[-1700, b_wall_xm - 350]
execute if entity @s[y=-64,dy=126] run tp @s ~ 65.1 ~
execute if entity @s[y=71,dy=20] run tp @s ~ 65.1 ~

execute store result score #px sb_var run data get entity @s Pos[0] 1000
execute store result score #pz sb_var run data get entity @s Pos[2] 1000
scoreboard players set #clamped sb_var 0
scoreboard players set #cross_mid sb_var 0

scoreboard players operation #min_wall_x sb_var = #r_wall_xm sb_var
scoreboard players add #min_wall_x sb_var 1350
scoreboard players operation #max_wall_x sb_var = #b_wall_xm sb_var
scoreboard players remove #max_wall_x sb_var 350

execute if score #px sb_var < #min_wall_x sb_var run scoreboard players set #clamped sb_var 1
execute if score #px sb_var < #min_wall_x sb_var run scoreboard players operation #px sb_var = #min_wall_x sb_var

execute if score #px sb_var > #max_wall_x sb_var run scoreboard players set #clamped sb_var 1
execute if score #px sb_var > #max_wall_x sb_var run scoreboard players operation #px sb_var = #max_wall_x sb_var

execute if score @s sb_team matches 1 if score #px sb_var matches 2701.. run scoreboard players set #clamped sb_var 1
execute if score @s sb_team matches 1 if score #px sb_var matches 2701.. run scoreboard players set #cross_mid sb_var 1
execute if score @s sb_team matches 1 if score #px sb_var matches 2701.. run scoreboard players set #px sb_var 2660

execute if score @s sb_team matches 2 if score #px sb_var matches ..-1701 run scoreboard players set #clamped sb_var 1
execute if score @s sb_team matches 2 if score #px sb_var matches ..-1701 run scoreboard players set #cross_mid sb_var 1
execute if score @s sb_team matches 2 if score #px sb_var matches ..-1701 run scoreboard players set #px sb_var -1660

execute if score #clamped sb_var matches 1 run scoreboard players operation @s sb_px = #px sb_var
execute if score #clamped sb_var matches 1 store result storage sb:tmp tp.x double 0.001 run scoreboard players get #px sb_var
execute if score #clamped sb_var matches 1 store result storage sb:tmp tp.z double 0.001 run scoreboard players get #pz sb_var
execute if score #clamped sb_var matches 1 run function sb:arena/tp_xz_m with storage sb:tmp tp

execute if score #cross_mid sb_var matches 1 if score @s sb_warn_cd matches 0 run scoreboard players set @s sb_warn_cd 15
execute if score #cross_mid sb_var matches 1 if score @s sb_warn_cd matches 15 run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 0.65 1.2
execute if score #cross_mid sb_var matches 1 if score @s sb_warn_cd matches 15 run title @s actionbar {text:"⚠ 已达 5 格共享中立区边界，不可进入敌方专属半场！",color:"yellow"}

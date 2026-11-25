# 共享 5 格中立区 (x=-2..+2, 实体坐标 [-2.0, +3.0]) 软边界约束：仅阻止越入敌方专属半场
execute if entity @s[y=-64,dy=126] run tp @s ~ 65.1 ~
execute if entity @s[y=71,dy=20] run tp @s ~ 65.1 ~

execute store result score #px sb_var run data get entity @s Pos[0] 1000
scoreboard players set #cross_mid sb_var 0

execute if score @s sb_team matches 1 if score #px sb_var matches 2701.. run scoreboard players set #cross_mid sb_var 1
execute if score @s sb_team matches 1 if score #px sb_var matches 2701.. run scoreboard players set @s sb_px 2660
execute if score @s sb_team matches 1 if score #px sb_var matches 2701.. at @s run tp @s 2.66 ~ ~

execute if score @s sb_team matches 2 if score #px sb_var matches ..-1701 run scoreboard players set #cross_mid sb_var 1
execute if score @s sb_team matches 2 if score #px sb_var matches ..-1701 run scoreboard players set @s sb_px -1660
execute if score @s sb_team matches 2 if score #px sb_var matches ..-1701 at @s run tp @s -1.66 ~ ~

execute if score #cross_mid sb_var matches 1 if score @s sb_warn_cd matches 0 run scoreboard players set @s sb_warn_cd 15
execute if score #cross_mid sb_var matches 1 if score @s sb_warn_cd matches 15 run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 0.65 1.2
execute if score #cross_mid sb_var matches 1 if score @s sb_warn_cd matches 15 run title @s actionbar {text:"⚠ 已达 5 格共享中立区边界，不可进入敌方专属半场！",color:"yellow"}

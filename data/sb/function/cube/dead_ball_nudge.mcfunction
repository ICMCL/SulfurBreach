# 防平行死球保护：沿原有东西向速度符号（若恰为 0 则对称随机）补注水平分速度
scoreboard players set @s sb_dead_tmr 0
scoreboard players set #nx_dir sb_var 1
execute if score @s sb_vx matches ..-1 run scoreboard players set #nx_dir sb_var -1
execute if score @s sb_vx matches 0 if score #g2 sb_var matches 1 run scoreboard players set #nx_dir sb_var -1

scoreboard players set #nudge_vx sb_var 320
scoreboard players operation #nudge_vx sb_var *= #nx_dir sb_var
scoreboard players operation #nudge_vx sb_var *= #speed_pct sb_var
scoreboard players operation #nudge_vx sb_var /= #100 sb_const
scoreboard players operation @s sb_vx = #nudge_vx sb_var
execute store result entity @s Motion[0] double 0.001 run scoreboard players get @s sb_vx
particle minecraft:poof ~ ~0.4 ~ 0.15 0.15 0.15 0.03 5 force

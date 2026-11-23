# 已破口守护墙后方的底线电弧警示粒子（每隔 10 tick 渲染，提示破洞即是致命漏球门）
execute as @e[type=marker,tag=sb_wred,scores={sb_hp=0}] at @s run particle minecraft:electric_spark ~-1.0 ~0.6 ~ 0.15 0.45 0.25 0.02 3 force
execute as @e[type=marker,tag=sb_wblue,scores={sb_hp=0}] at @s run particle minecraft:electric_spark ~1.0 ~0.6 ~ 0.15 0.45 0.25 0.02 3 force

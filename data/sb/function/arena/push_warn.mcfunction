# 双墙前推前 1.5 秒预警：活塞蓄力声与墙前警示粒子
execute if score #o_shrink sb_var matches 1 run return 0
execute if score #push_stage sb_var matches 5.. run return 0
playsound minecraft:block.piston.contract master @a 0 66 0 1.4 0.75
title @a[tag=sb_ingame] actionbar {text:"⚠ 双方守护墙即将带伤向场心推进 1 格！注意脚下站位",color:"gold",bold:true}
execute as @e[type=marker,tag=sb_wred] at @s run particle minecraft:dust{color:[1.0,0.65,0.1],scale:1.4} ~1.0 ~0.15 ~ 0.1 0.05 0.25 0 2 force
execute as @e[type=marker,tag=sb_wblue] at @s run particle minecraft:dust{color:[1.0,0.65,0.1],scale:1.4} ~-1.0 ~0.15 ~ 0.1 0.05 0.25 0 2 force

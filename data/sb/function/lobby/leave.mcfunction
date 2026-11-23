team leave @s
scoreboard players set @s sb_team 0
playsound minecraft:ui.button.click master @s ~ ~ ~ 0.7 1.2
title @s actionbar {text:"已切换为旁观模式",color:"gray"}
tellraw @a [{text:"[硫方破壁] ",color:"gold"},{selector:"@s"},{text:" 退出了队伍（旁观）。",color:"gray"}]

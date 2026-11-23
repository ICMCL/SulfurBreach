# 状态 1：常规冲撞态（铁块芯 iron_block；若本球自带特殊突变芯则保留其蓝冰/泥砖内容物）
scoreboard players set @s sb_state 1
scoreboard players set @s sb_idle_tmr 0
scoreboard players set @s sb_dead_tmr 0
data modify entity @s Health set value 1024.0f

execute if score @s sb_special matches 0 run item replace entity @s armor.body with minecraft:iron_block
execute if score @s sb_special matches 0 run team join sb_iron @s
execute if score @s sb_special matches 0 run data modify entity @s CustomNameVisible set value 0b

execute if score @s sb_special matches 1 run item replace entity @s armor.body with minecraft:blue_ice
execute if score @s sb_special matches 1 run team join sb_iron @s
execute if score @s sb_special matches 1 run data modify entity @s CustomName set value {text:"❄ 极速冰芯",color:"aqua",bold:true}
execute if score @s sb_special matches 1 run data modify entity @s CustomNameVisible set value 1b

execute if score @s sb_special matches 2 run item replace entity @s armor.body with minecraft:mud_bricks
execute if score @s sb_special matches 2 run team join sb_repair @s
execute if score @s sb_special matches 2 run data modify entity @s CustomName set value {text:"🧱 修墙泥芯 (+2 HP)",color:"green",bold:true}
execute if score @s sb_special matches 2 run data modify entity @s CustomNameVisible set value 1b

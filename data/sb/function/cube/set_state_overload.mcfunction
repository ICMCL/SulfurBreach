# 状态 2：重锤超载态（炽热岩浆芯 magma_block，撞墙中心 -2 HP 贯通 + 左右邻列各 -1 HP）
execute if score @s sb_special matches 2 run return run function sb:cube/set_state_iron
scoreboard players set @s sb_state 2
scoreboard players set @s sb_special 0
scoreboard players set @s sb_idle_tmr 0
scoreboard players set @s sb_dead_tmr 0
data modify entity @s Health set value 1024.0f
item replace entity @s armor.body with minecraft:magma_block
team join sb_overload @s
data modify entity @s CustomName set value {text:"🔥 重锤超载",color:"gold",bold:true}
data modify entity @s CustomNameVisible set value 1b

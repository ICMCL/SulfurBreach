# 状态 3：撞墙卸力态（灰暗凝灰岩芯 tuff，再次被挥矛击打前不重复蹭伤实心墙；停滞回中立区超 3s 恢复空心）
scoreboard players set @s sb_state 3
scoreboard players set @s sb_special 0
scoreboard players set @s sb_rally 0
scoreboard players set @s sb_crossed 0
scoreboard players set @s sb_strike_side 0
scoreboard players set @s sb_idle_tmr 0
scoreboard players set @s sb_dead_tmr 0
data modify entity @s Health set value 1024.0f
item replace entity @s armor.body with minecraft:tuff
team join sb_spent @s
data modify entity @s CustomNameVisible set value 0b

# 状态 0：空心晃荡态（仅在中央 5 格共享中立区内自由晃荡）
scoreboard players set @s sb_state 0
scoreboard players set @s sb_special 0
scoreboard players set @s sb_rally 0
scoreboard players set @s sb_crossed 0
scoreboard players set @s sb_strike_side 0
scoreboard players set @s sb_idle_tmr 0
scoreboard players set @s sb_dead_tmr 0
item replace entity @s armor.body with minecraft:air
data modify entity @s Health set value 1024.0f
team join sb_empty @s
data modify entity @s CustomNameVisible set value 0b

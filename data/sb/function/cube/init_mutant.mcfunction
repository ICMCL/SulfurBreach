scoreboard players operation #m_kind sb_var = #spawn_seq sb_var
scoreboard players operation #m_kind sb_var /= #4 sb_const
scoreboard players operation #m_kind sb_var %= #2 sb_const

execute if score #m_kind sb_var matches 1 run scoreboard players set @s sb_special 1
execute if score #m_kind sb_var matches 1 run item replace entity @s armor.body with minecraft:blue_ice
execute if score #m_kind sb_var matches 1 run team join sb_iron @s
execute if score #m_kind sb_var matches 1 run data modify entity @s CustomName set value {text:"❄ 蓝冰极速芯 (中立争抢)",color:"aqua",bold:true}
execute if score #m_kind sb_var matches 1 run data modify entity @s CustomNameVisible set value 1b

execute if score #m_kind sb_var matches 0 run scoreboard players set @s sb_special 2
execute if score #m_kind sb_var matches 0 run item replace entity @s armor.body with minecraft:mud_bricks
execute if score #m_kind sb_var matches 0 run team join sb_repair @s
execute if score #m_kind sb_var matches 0 run data modify entity @s CustomName set value {text:"🧱 泥砖修墙芯 (+2 HP)",color:"green",bold:true}
execute if score #m_kind sb_var matches 0 run data modify entity @s CustomNameVisible set value 1b

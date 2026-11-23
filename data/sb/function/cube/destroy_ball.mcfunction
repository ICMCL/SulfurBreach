scoreboard players set #spawn_cd sb_var 30
item replace entity @s armor.body with minecraft:air
data remove entity @s equipment
data remove entity @s CustomName
data modify entity @s CustomNameVisible set value 0b
data modify entity @s Size set value 0
tp @s 0 -200 0
kill @s

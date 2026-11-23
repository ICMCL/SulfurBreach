execute unless data entity @s Item.components."minecraft:custom_data".sb_kit run return 0
execute store result score @s sb_tmp run data get entity @s Age
execute if score @s sb_tmp matches 30.. run return run kill @s
data modify entity @s PickupDelay set value 0s
tag @s add sb_it
execute on origin run tp @e[type=item,tag=sb_it,limit=1] @s
tag @s remove sb_it
kill @s

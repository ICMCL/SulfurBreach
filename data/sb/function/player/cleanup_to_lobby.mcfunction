tag @s remove sb_ingame
tag @s remove sb_alive
scoreboard players set @s sb_charging 0
scoreboard players set @s sb_charge_dur 0
scoreboard players set @s sb_bump_cd 0
scoreboard players set @s sb_warn_cd 0
effect clear @s
attribute @s minecraft:knockback_resistance base set 0.0
attribute @s minecraft:max_health base set 20.0
execute in minecraft:overworld run function sb:inv/restore
gamemode adventure @s
effect give @s minecraft:instant_health 1 10 true
effect give @s minecraft:saturation 2 4 true
function sb:lobby/ensure_present

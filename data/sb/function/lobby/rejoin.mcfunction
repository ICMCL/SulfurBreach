scoreboard players set @s sb_left 0
execute if entity @s[tag=sb_ingame] unless score #state sb_var matches 1..2 run function sb:player/cleanup_to_lobby
execute if entity @s[tag=sb_ingame] if score #state sb_var matches 1..2 unless score @s sb_gid = #gid sb_var run function sb:player/cleanup_to_lobby
execute if entity @s[tag=sb_ingame] if score #state sb_var matches 1..2 if score @s sb_gid = #gid sb_var at @s run function sb:player/zone_clamp

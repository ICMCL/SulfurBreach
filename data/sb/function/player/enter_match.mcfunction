# ===== 参战玩家入场初始化（主世界执行，无生命淘汰，全程守护身后城墙） =====
function sb:inv/stash
tag @s add sb_ingame
tag @s add sb_alive
scoreboard players operation @s sb_gid = #gid sb_var
execute if entity @s[team=red] run scoreboard players set @s sb_team 1
execute if entity @s[team=blue] run scoreboard players set @s sb_team 2

gamemode adventure @s
effect clear @s
attribute @s minecraft:max_health base set 20.0
attribute @s minecraft:knockback_resistance base set 1.0
effect give @s minecraft:instant_health 1 10 true
effect give @s minecraft:saturation 3 19 true
effect give @s minecraft:resistance 5 4 true

scoreboard players set @s sb_charging 0
scoreboard players set @s sb_charge_dur 0
scoreboard players set @s sb_bump_cd 0
scoreboard players set @s sb_warn_cd 0

function sb:player/tp_spawn
execute store result score @s sb_px run data get entity @s Pos[0] 1000
execute store result score @s sb_pz run data get entity @s Pos[2] 1000
scoreboard players set @s sb_vx 0
scoreboard players set @s sb_vz 0

execute if score @s sb_team matches 1 run function sb:player/give_kit with storage sb:t red
execute if score @s sb_team matches 2 run function sb:player/give_kit with storage sb:t blue

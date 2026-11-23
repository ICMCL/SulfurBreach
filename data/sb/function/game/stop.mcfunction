# ===== 结束对局、清理硫方怪、全员恢复原背包返回二层大厅（保留残垣断壁终局现场供俯瞰复盘，下一局开始再重置） =====
scoreboard players set #state sb_var 0
scoreboard players set #solo_mode sb_var 0
scoreboard players set #sudden_death sb_var 0

execute in minecraft:overworld as @e[type=sulfur_cube] run item replace entity @s armor.body with minecraft:air
execute in minecraft:overworld as @e[type=sulfur_cube] run data remove entity @s equipment
execute in minecraft:overworld as @e[type=sulfur_cube] run data remove entity @s CustomName
execute in minecraft:overworld as @e[type=sulfur_cube] run data modify entity @s Size set value 0
execute in minecraft:overworld run tp @e[type=sulfur_cube] 0 -200 0
execute in minecraft:overworld run kill @e[type=sulfur_cube]
execute in minecraft:overworld run kill @e[type=wind_charge]

bossbar set sb:red_wall visible false
bossbar set sb:blue_wall visible false
bossbar set sb:red_wall players
bossbar set sb:blue_wall players
scoreboard objectives setdisplay sidebar

execute as @a[tag=sb_ingame] run function sb:player/cleanup_to_lobby

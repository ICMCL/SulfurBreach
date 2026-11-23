# ===== 绑定存档首次进入及每次 /reload 自动同步大厅看板实体（首次进入时同步初始化 29×21 动态守墙） =====
scoreboard players set #lobby_synced sb_var 1
execute in minecraft:overworld run function sb:lobby/build
execute unless score #world_ready sb_var matches 1 in minecraft:overworld run function sb:arena/reset_round
scoreboard players set #world_ready sb_var 1

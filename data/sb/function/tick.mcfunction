# ===== 硫方破壁 · 全局主循环 =====
execute unless score #lobby_synced sb_var matches 1 in minecraft:overworld if loaded 0 64 0 run function sb:internal/world_boot

scoreboard players add #gt sb_var 1
scoreboard players operation #g20 sb_var = #gt sb_var
scoreboard players operation #g20 sb_var %= #20 sb_const
scoreboard players operation #g2 sb_var = #gt sb_var
scoreboard players operation #g2 sb_var %= #2 sb_const

# 重连与新玩家欢迎
execute as @a[scores={sb_left=1..}] run function sb:lobby/rejoin
execute as @a[tag=!sb_seen] run function sb:lobby/welcome

# 对话框触发器（非对局玩家可修改设置）
scoreboard players enable @a[tag=!sb_ingame] sb_cfg
scoreboard players enable @a[tag=!sb_ingame] sb_set
execute as @a[scores={sb_cfg=1..}] run function sb:cfg/open
execute as @a[scores={sb_set=1..}] run function sb:cfg/apply_rules

# 防止丢弃比赛装备与清理意外分裂的小硫方怪
execute as @e[type=item] run function sb:util/item
execute in minecraft:overworld run kill @e[type=sulfur_cube,tag=!sb_ball]

# 大厅循环
execute in minecraft:overworld run function sb:lobby/tick

# 竞技场状态机循环
execute if score #state sb_var matches 1..2 in minecraft:overworld run function sb:game/tick

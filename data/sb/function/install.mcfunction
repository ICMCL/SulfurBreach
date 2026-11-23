# ===== 一次性世界配置与建造 =====
gamerule keep_inventory true
gamerule immediate_respawn true
gamerule respawn_radius 0
gamerule block_drops false
gamerule mob_drops false
gamerule mob_griefing false
gamerule spawn_mobs false
gamerule spawn_phantoms false
gamerule advance_time false
gamerule advance_weather false
gamerule fall_damage false
gamerule fire_damage false
gamerule natural_health_regeneration true
gamerule show_advancement_messages false
gamerule send_command_feedback false
gamerule command_block_output false
gamerule max_block_modifications 4000000
difficulty normal
time set 6000
weather clear

execute in minecraft:overworld run forceload add -48 -48 47 47
function sb:internal/world_boot
execute in minecraft:overworld as @a run function sb:lobby/arrive
tellraw @a [{text:"[硫方破壁] ",color:"gold",bold:true},{text:"赛场动态城墙与大厅交互实体已重置就绪！",color:"green",bold:false}]

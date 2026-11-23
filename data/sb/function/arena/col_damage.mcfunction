# 对单列守护墙标记实体 (@s) 扣除 #dmg 点耐久并刷新方块外观
execute if score @s sb_hp matches ..0 run return 0
scoreboard players operation @s sb_hp -= #dmg sb_var
execute if score @s sb_hp matches ..-1 run scoreboard players set @s sb_hp 0
function sb:arena/col_render

scoreboard players set #col_broke sb_var 0
execute if score @s sb_hp matches 0 run scoreboard players set #col_broke sb_var 1

execute if score #col_broke sb_var matches 1 if entity @s[tag=sb_wred] run particle minecraft:block{block_state:"minecraft:red_concrete"} ~ ~1.0 ~ 0.35 0.55 0.35 0.15 28 force
execute if score #col_broke sb_var matches 1 if entity @s[tag=sb_wblue] run particle minecraft:block{block_state:"minecraft:blue_concrete"} ~ ~1.0 ~ 0.35 0.55 0.35 0.15 28 force
execute if score #col_broke sb_var matches 1 run playsound minecraft:block.sandstone.break master @a ~ ~1 ~ 1.3 0.9

execute if score #col_broke sb_var matches 0 if entity @s[tag=sb_wred] run particle minecraft:block{block_state:"minecraft:red_glazed_terracotta"} ~ ~1.0 ~ 0.3 0.45 0.3 0.1 16 force
execute if score #col_broke sb_var matches 0 if entity @s[tag=sb_wblue] run particle minecraft:block{block_state:"minecraft:blue_glazed_terracotta"} ~ ~1.0 ~ 0.3 0.45 0.3 0.1 16 force
execute if score #col_broke sb_var matches 0 run playsound minecraft:block.stone.hit master @a ~ ~1 ~ 1.1 0.95

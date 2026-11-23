# 根据单列剩余 sb_hp 渲染守护墙方块（y=65..66 实体墙，y=67..70 永久屏障防越顶）
fill ~ 67 ~ ~ 70 ~ minecraft:barrier

execute if score @s sb_hp matches ..0 run return run fill ~ 65 ~ ~ 66 ~ minecraft:air

# 满耐久态：饱满队色混凝土
execute if score @s sb_hp = #col_max_hp sb_var if entity @s[tag=sb_wred] run return run fill ~ 65 ~ ~ 66 ~ minecraft:red_concrete
execute if score @s sb_hp = #col_max_hp sb_var if entity @s[tag=sb_wblue] run return run fill ~ 65 ~ ~ 66 ~ minecraft:blue_concrete

# 仅剩最后 1 HP（受损危急态）：带釉陶瓦裂纹预警
execute if score @s sb_hp matches 1 if entity @s[tag=sb_wred] run return run fill ~ 65 ~ ~ 66 ~ minecraft:red_glazed_terracotta
execute if score @s sb_hp matches 1 if entity @s[tag=sb_wblue] run return run fill ~ 65 ~ ~ 66 ~ minecraft:blue_glazed_terracotta

# 3 点耐久模式下的中间 2 HP 态：哑光陶瓦过渡
execute if entity @s[tag=sb_wred] run fill ~ 65 ~ ~ 66 ~ minecraft:red_terracotta
execute if entity @s[tag=sb_wblue] run fill ~ 65 ~ ~ 66 ~ minecraft:blue_terracotta

# ===== 方案 A：双墙带伤前推 1 格（共 5 阶段，中央 5 格共享中立区保持不变，100% 继承每列残血与破口） =====
execute if score #o_shrink sb_var matches 1 run return 0
execute if score #push_stage sb_var matches 5.. run return 0

# 1. 先结算已钻入旧底线槽内的球，避免前推漏算
execute as @e[type=sulfur_cube,tag=sb_ball] at @s run function sb:cube/settle_trench
execute unless score #state sb_var matches 2 run return 0

# 2. 计算旧/新坐标并更新当前阶段
scoreboard players operation #old_rb sb_var = #r_base_x sb_var
scoreboard players operation #old_rw sb_var = #r_wall_x sb_var
scoreboard players operation #old_bw sb_var = #b_wall_x sb_var
scoreboard players operation #old_bb sb_var = #b_base_x sb_var

scoreboard players add #push_stage sb_var 1
scoreboard players add #r_base_x sb_var 1
scoreboard players add #r_wall_x sb_var 1
scoreboard players remove #b_wall_x sb_var 1
scoreboard players remove #b_base_x sb_var 1

function sb:arena/wall_bounds

# 3. 先将贴近新守护墙前侧的玩家与场内硫方怪平滑内推，防卡墙窒息与防误吞入底线
execute as @a[tag=sb_alive] at @s run function sb:arena/push_clamp
execute as @e[type=sulfur_cube,tag=sb_ball] at @s run function sb:arena/push_clamp

# 4. 同步前移两侧 19 列守护墙标记实体，并用 clone move 原样平移整面残墙，将旧底线封实为外墙
execute as @e[type=marker,tag=sb_wred] at @s run tp @s ~1 ~ ~
execute as @e[type=marker,tag=sb_wblue] at @s run tp @s ~-1 ~ ~

execute store result storage sb:tmp ps.orb int 1 run scoreboard players get #old_rb sb_var
execute store result storage sb:tmp ps.orw int 1 run scoreboard players get #old_rw sb_var
execute store result storage sb:tmp ps.nrb int 1 run scoreboard players get #r_base_x sb_var
execute store result storage sb:tmp ps.nrw int 1 run scoreboard players get #r_wall_x sb_var
execute store result storage sb:tmp ps.obb int 1 run scoreboard players get #old_bb sb_var
execute store result storage sb:tmp ps.obw int 1 run scoreboard players get #old_bw sb_var
execute store result storage sb:tmp ps.nbb int 1 run scoreboard players get #b_base_x sb_var
execute store result storage sb:tmp ps.nbw int 1 run scoreboard players get #b_wall_x sb_var
function sb:arena/push_clone_m with storage sb:tmp ps

playsound minecraft:block.piston.extend master @a 0 66 0 1.5 0.85
title @a[tag=sb_ingame] actionbar [{text:"🧱 双墙带伤前推 (",color:"gold",bold:true},{score:{name:"#push_stage",objective:"sb_var"},color:"yellow"},{text:"/5)！对抽距离已缩短",color:"gold"}]
function sb:arena/recalc_hp

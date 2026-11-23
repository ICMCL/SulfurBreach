# 红方实心守护墙碰撞结算（优先匹配正前方 Z 列；若正前方已破洞，仅当球边缘实际撞上相邻实心列反弹时才结算邻列）
tag @e[tag=sb_hit_col] remove sb_hit_col
execute if score #bcol_raw sb_var matches -9..9 as @e[type=marker,tag=sb_wred,scores={sb_hp=1..}] if score @s sb_col = #bcol_raw sb_var run tag @s add sb_hit_col
execute unless entity @e[tag=sb_hit_col] if score @s sb_vx matches ..-50 if score #cur_vx sb_var matches -30.. run tag @e[type=marker,tag=sb_wred,scores={sb_hp=1..},distance=..1.42,sort=nearest,limit=1] add sb_hit_col
execute unless entity @e[tag=sb_hit_col] run return 0

# 分支 1：泥砖修墙芯 -> 为红墙就近恢复 2 HP
execute if score @s sb_special matches 2 as @e[type=marker,tag=sb_wred] if score @s sb_hp < #col_max_hp sb_var run tag @s add sb_need_rep
execute if score @s sb_special matches 2 run scoreboard players set #rep_left sb_var 2
execute if score @s sb_special matches 2 run function sb:arena/repair_red_step
execute if score @s sb_special matches 2 run tag @e[tag=sb_need_rep] remove sb_need_rep
execute if score @s sb_special matches 2 run tag @e[tag=sb_hit_col] remove sb_hit_col
execute if score @s sb_special matches 2 run playsound minecraft:block.mud_bricks.place master @a ~ ~1 ~ 1.3 1.1
execute if score @s sb_special matches 2 run playsound minecraft:entity.player.levelup master @a ~ ~1 ~ 0.9 1.4
execute if score @s sb_special matches 2 run title @a[tag=sb_ingame] actionbar {text:"🧱 泥砖修墙芯撞击红墙，恢复 2 HP！",color:"green",bold:true}
execute if score @s sb_special matches 2 run function sb:cube/destroy_ball
execute if score @s sb_special matches 2 run return run function sb:arena/recalc_hp

# 分支 2：岩浆重锤超载态 (sb_state=2) -> 中心列 -2 HP 贯通 + 上下相邻列各 -1 HP，随后销毁重发
execute if score @s sb_state matches 2 store result score #hc sb_var run scoreboard players get @e[tag=sb_hit_col,limit=1] sb_col
execute if score @s sb_state matches 2 run scoreboard players operation #hc_l sb_var = #hc sb_var
execute if score @s sb_state matches 2 run scoreboard players remove #hc_l sb_var 1
execute if score @s sb_state matches 2 run scoreboard players operation #hc_r sb_var = #hc sb_var
execute if score @s sb_state matches 2 run scoreboard players add #hc_r sb_var 1
execute if score @s sb_state matches 2 run scoreboard players set #dmg sb_var 2
execute if score @s sb_state matches 2 as @e[tag=sb_hit_col,limit=1] at @s run function sb:arena/col_damage
execute if score @s sb_state matches 2 run scoreboard players set #dmg sb_var 1
execute if score @s sb_state matches 2 as @e[type=marker,tag=sb_wred,scores={sb_hp=1..}] if score @s sb_col = #hc_l sb_var at @s run function sb:arena/col_damage
execute if score @s sb_state matches 2 as @e[type=marker,tag=sb_wred,scores={sb_hp=1..}] if score @s sb_col = #hc_r sb_var at @s run function sb:arena/col_damage
execute if score @s sb_state matches 2 run tag @e[tag=sb_hit_col] remove sb_hit_col
execute if score @s sb_state matches 2 run particle minecraft:lava ~ ~0.8 ~ 0.35 0.6 0.6 0.15 24 force
execute if score @s sb_state matches 2 run playsound minecraft:block.anvil.land master @a ~ ~1 ~ 1.1 0.85
execute if score @s sb_state matches 2 run function sb:cube/destroy_ball
execute if score @s sb_state matches 2 run return run function sb:arena/recalc_hp

# 分支 3：常规铁芯 / 蓝冰极速芯 (sb_state=1) -> 命中列 -1 HP；破洞则销毁重发，未破洞则化为凝灰岩卸力态回弹
scoreboard players set #dmg sb_var 1
execute as @e[tag=sb_hit_col,limit=1] at @s run function sb:arena/col_damage
tag @e[tag=sb_hit_col] remove sb_hit_col

execute if score #col_broke sb_var matches 1 run function sb:cube/destroy_ball
execute if score #col_broke sb_var matches 0 run function sb:cube/set_state_spent
execute if score #col_broke sb_var matches 0 run data modify entity @s Motion[0] set value 0.50d
execute if score #col_broke sb_var matches 0 run scoreboard players set @s sb_vx 500
function sb:arena/recalc_hp

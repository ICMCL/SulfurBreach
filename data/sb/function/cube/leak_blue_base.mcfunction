# 蓝方背板（墙后底线）碰撞结算：
# - 仅对落点 Z 周围局部半径内（常规半径 2 列 / 重锤半径 3 列）的存活守护墙列各扣 1 HP 并回收球；
# - 若落点半径内已无任何存活守护墙（大缺口中心打空），则 0 扣血并直接从背板高弹回场继续对局！
scoreboard players operation #bcol sb_var = #bcol_raw sb_var
execute if score #bcol sb_var matches ..-10 run scoreboard players set #bcol sb_var -9
execute if score #bcol sb_var matches 10.. run scoreboard players set #bcol sb_var 9

# 分支 1：泥砖修墙芯 -> 仅修补落点半径 2 列内的破损/缺口蓝墙（最多 +2 HP）
scoreboard players operation #rmin sb_var = #bcol sb_var
scoreboard players remove #rmin sb_var 2
scoreboard players operation #rmax sb_var = #bcol sb_var
scoreboard players add #rmax sb_var 2
execute if score @s sb_special matches 2 as @e[type=marker,tag=sb_wblue] if score @s sb_col >= #rmin sb_var if score @s sb_col <= #rmax sb_var if score @s sb_hp < #col_max_hp sb_var run tag @s add sb_need_rep
execute if score @s sb_special matches 2 run scoreboard players set #rep_left sb_var 2
execute if score @s sb_special matches 2 run function sb:arena/repair_blue_step
execute if score @s sb_special matches 2 run tag @e[tag=sb_need_rep] remove sb_need_rep
execute if score @s sb_special matches 2 run playsound minecraft:block.mud_bricks.place master @a ~ ~1 ~ 1.3 1.1
execute if score @s sb_special matches 2 run playsound minecraft:entity.player.levelup master @a ~ ~1 ~ 0.9 1.4
execute if score @s sb_special matches 2 run title @a[tag=sb_ingame] actionbar {text:"🧱 泥砖修墙芯补入蓝方破口 (+2 HP)！",color:"green",bold:true}
execute if score @s sb_special matches 2 run function sb:cube/destroy_ball
execute if score @s sb_special matches 2 run return run function sb:arena/recalc_hp

# 分支 2：局部半径筛选（常规半径 2 列，重锤半径 3 列）
scoreboard players set #rad sb_var 2
execute if score @s sb_state matches 2 run scoreboard players set #rad sb_var 3
scoreboard players operation #col_min sb_var = #bcol sb_var
scoreboard players operation #col_min sb_var -= #rad sb_var
scoreboard players operation #col_max sb_var = #bcol sb_var
scoreboard players operation #col_max sb_var += #rad sb_var

tag @e[tag=sb_aoe_col] remove sb_aoe_col
scoreboard players set #aoe_cnt sb_var 0
execute as @e[type=marker,tag=sb_wblue,scores={sb_hp=1..}] if score @s sb_col >= #col_min sb_var if score @s sb_col <= #col_max sb_var run tag @s add sb_aoe_col
execute as @e[type=marker,tag=sb_aoe_col] run scoreboard players add #aoe_cnt sb_var 1

# 子情况 2A：落点半径内无残存墙列 -> 0 扣血，从背板高弹回场继续回合！
execute if score #aoe_cnt sb_var matches 0 run scoreboard players set @s sb_back_cd 8
execute if score #aoe_cnt sb_var matches 0 run scoreboard players operation #bspd sb_var = @s sb_vx
execute if score #aoe_cnt sb_var matches 0 if score #bspd sb_var matches ..-1 run scoreboard players operation #bspd sb_var *= #-1 sb_const
execute if score #aoe_cnt sb_var matches 0 run scoreboard players operation #cspd sb_var = #cur_vx sb_var
execute if score #aoe_cnt sb_var matches 0 if score #cspd sb_var matches ..-1 run scoreboard players operation #cspd sb_var *= #-1 sb_const
execute if score #aoe_cnt sb_var matches 0 if score #cspd sb_var > #bspd sb_var run scoreboard players operation #bspd sb_var = #cspd sb_var
execute if score #aoe_cnt sb_var matches 0 run scoreboard players operation #bspd sb_var *= #95 sb_const
execute if score #aoe_cnt sb_var matches 0 run scoreboard players operation #bspd sb_var /= #100 sb_const
execute if score #aoe_cnt sb_var matches 0 if score #bspd sb_var matches ..479 run scoreboard players set #bspd sb_var 480
execute if score #aoe_cnt sb_var matches 0 run scoreboard players operation #bspd sb_var *= #-1 sb_const
execute if score #aoe_cnt sb_var matches 0 run scoreboard players operation @s sb_vx = #bspd sb_var
execute if score #aoe_cnt sb_var matches 0 run function sb:cube/restore_vel
execute if score #aoe_cnt sb_var matches 0 run particle minecraft:poof ~ ~0.5 ~ 0.2 0.25 0.2 0.05 8 force
execute if score #aoe_cnt sb_var matches 0 run playsound minecraft:entity.sulfur_cube.bouncy.hit master @a ~ ~0.5 ~ 1.0 1.15
execute if score #aoe_cnt sb_var matches 0 run return 0

# 子情况 2B：落点半径内有存活墙列 -> 范围内每列各扣 1 HP，随后销毁补球
scoreboard players set #dmg sb_var 1
execute as @e[type=marker,tag=sb_aoe_col] at @s run function sb:arena/col_damage
execute as @e[type=marker,tag=sb_aoe_col] at @s run particle minecraft:electric_spark ~ ~1.1 ~ 0.3 0.6 0.3 0.2 14 force
tag @e[tag=sb_aoe_col] remove sb_aoe_col

particle minecraft:electric_spark ~ ~0.8 ~ 0.4 0.8 1.0 0.3 36 force
playsound minecraft:entity.lightning_bolt.impact master @a ~ ~1 ~ 0.8 1.35
playsound minecraft:block.respawn_anchor.deplete master @a ~ ~1 ~ 1.15 0.95
title @a[tag=sb_ingame] actionbar {text:"⚡ 蓝方背板震波！落点半径内残墙各 -1 HP！",color:"blue",bold:true}
function sb:cube/destroy_ball
function sb:arena/recalc_hp

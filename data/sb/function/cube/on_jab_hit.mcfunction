# ===== 单把无突进长矛：左键轻刺 (Jab) 命中硫方怪处理（无阵营归属，效果一视同仁） =====
execute if score @s sb_hit_cd matches 1.. run return 0
scoreboard players set @s sb_hit_cd 4
data modify entity @s Health set value 1024.0f

# 计算本次击球指向的东西半场方向 (#new_dir: +1 向东, -1 向西)
scoreboard players set #new_dir sb_var 1
execute if score #fx sb_var matches ..-1 run scoreboard players set #new_dir sb_var -1

# 对抽拍数判定：只有处于运动态 (状态 1/2)、已跨过中线 (sb_crossed=1) 且反向回抽时，拍数才 +1；
# 若是从空心球(0)/卸力球(3)起球，或门前左键稳挡早发的迎击重锤球(rally=1->2 < 3)，均按常规铁芯或满3拍自动升档结算！
scoreboard players set #valid_ret sb_var 0
execute if score @s sb_state matches 1..2 if score @s sb_crossed matches 1 unless score @s sb_strike_side = #new_dir sb_var run scoreboard players set #valid_ret sb_var 1

execute if score @s sb_state matches 0 run scoreboard players set @s sb_rally 1
execute if score @s sb_state matches 3 run scoreboard players set @s sb_rally 1
execute if score #valid_ret sb_var matches 1 run scoreboard players add @s sb_rally 1
scoreboard players operation @s sb_strike_side = #new_dir sb_var
scoreboard players set @s sb_crossed 0

# 满 3 拍跨中线连续往返对抽（且非泥砖修墙球）：自动升档为岩浆重锤超载芯！
scoreboard players set #go_heavy sb_var 0
execute if score @s sb_rally matches 3.. unless score @s sb_special matches 2 run scoreboard players set #go_heavy sb_var 1

execute if score #go_heavy sb_var matches 0 run function sb:cube/set_state_iron
execute if score #go_heavy sb_var matches 1 run function sb:cube/set_state_overload

# 计算出球基础水平速度（千分格/tick，随后由 set_horizontal 乘本局 #speed_pct）
scoreboard players set #spd sb_var 850
execute if score #go_heavy sb_var matches 0 if score @s sb_special matches 1 run scoreboard players set #spd sb_var 1190
execute if score #go_heavy sb_var matches 1 run scoreboard players set #spd sb_var 1150
execute if score #go_heavy sb_var matches 1 if score @s sb_rally matches 4 run scoreboard players set #spd sb_var 1220
execute if score #go_heavy sb_var matches 1 if score @s sb_rally matches 5 run scoreboard players set #spd sb_var 1290
execute if score #go_heavy sb_var matches 1 if score @s sb_rally matches 6.. run scoreboard players set #spd sb_var 1360

function sb:cube/shoot_forward
data modify entity @s Motion[1] set value 0.05d

execute if score #go_heavy sb_var matches 0 run playsound minecraft:entity.sulfur_cube.slow_flat.hit master @a ~ ~0.5 ~ 1.1 1.15
execute if score #go_heavy sb_var matches 0 run particle minecraft:crit ~ ~0.5 ~ 0.22 0.22 0.22 0.1 10 force
execute if score #go_heavy sb_var matches 1 run playsound minecraft:block.anvil.place master @a ~ ~0.5 ~ 0.9 1.35
execute if score #go_heavy sb_var matches 1 run particle minecraft:lava ~ ~0.5 ~ 0.25 0.25 0.25 0.1 12 force
execute if score #go_heavy sb_var matches 1 run title @a[tag=sb_hitter,limit=1] actionbar [{text:"🔥 ",color:"gold"},{score:{name:"@s",objective:"sb_rally"},color:"yellow",bold:true},{text:" 连拍过网升档！岩浆重锤超载球！",color:"gold",bold:true}]

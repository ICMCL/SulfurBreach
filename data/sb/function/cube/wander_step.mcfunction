# 状态 0 软围栏：严格将空心（及未激活突变）硫方怪限制在中央 5 格中立区 x ∈ [-1.45, +2.45] 内晃荡
execute store result score @s sb_px run data get entity @s Pos[0] 1000
execute store result score @s sb_pz run data get entity @s Pos[2] 1000
execute store result score @s sb_vx run data get entity @s Motion[0] 1000
execute store result score @s sb_vz run data get entity @s Motion[2] 1000

execute if score @s sb_px matches ..-1450 run tp @s -1.42 ~ ~ -90 0
execute if score @s sb_px matches ..-1450 run data modify entity @s Motion[0] set value 0.16d
execute if score @s sb_px matches 2450.. run tp @s 2.42 ~ ~ 90 0
execute if score @s sb_px matches 2450.. run data modify entity @s Motion[0] set value -0.16d

execute if score @s sb_pz matches ..-9350 run data modify entity @s Motion[2] set value 0.18d
execute if score @s sb_pz matches 10350.. run data modify entity @s Motion[2] set value -0.18d

# 保持中立区活泼蹦跶晃荡（尤其预装突变芯时原生漫游 AI 已停用，由周期微跳驱动）
scoreboard players operation #avx sb_var = @s sb_vx
execute if score #avx sb_var matches ..-1 run scoreboard players operation #avx sb_var *= #-1 sb_const
scoreboard players operation #avz sb_var = @s sb_vz
execute if score #avz sb_var matches ..-1 run scoreboard players operation #avz sb_var *= #-1 sb_const
scoreboard players operation #spd_m sb_var = #avx sb_var
scoreboard players operation #spd_m sb_var += #avz sb_var

execute if score #spd_m sb_var matches ..40 run scoreboard players add @s sb_idle_tmr 1
execute if score #spd_m sb_var matches 41.. run scoreboard players set @s sb_idle_tmr 0
execute if score @s sb_idle_tmr matches 22.. run function sb:cube/wander_hop

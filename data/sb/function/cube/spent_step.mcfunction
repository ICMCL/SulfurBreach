# 状态 3（凝灰岩卸力态）：按讲台设置 #cfg_recall_ticks 计时；设为 0（关闭）则留在原地绝不自动回中
execute if score #cfg_recall_ticks sb_var matches ..0 run return 0

scoreboard players add @s sb_idle_tmr 1
execute if score @s sb_idle_tmr < #cfg_recall_ticks sb_var run return 0

# 到时无人接管：清零残余水平动量，平滑传回中央 5 格共享中立区（自动避开可选紫水晶偏转柱）并恢复空心晃荡态
data modify entity @s Motion set value [0.0d,0.08d,0.0d]
scoreboard players set @s sb_vx 0
scoreboard players set @s sb_vz 0
tp @s 0.5 65.1 ~
execute if score #o_layout sb_var matches 1 if score @s sb_pz matches -5600..-3400 run tp @s 0.5 65.1 0.5
execute if score #o_layout sb_var matches 1 if score @s sb_pz matches 4400..6600 run tp @s 0.5 65.1 0.5
function sb:cube/set_state_empty
particle minecraft:poof ~ ~0.4 ~ 0.25 0.25 0.25 0.04 10 force
playsound minecraft:entity.sulfur_cube.squish master @a ~ ~0.5 ~ 0.8 1.3

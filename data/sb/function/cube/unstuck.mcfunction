# 防贴角停滞脱困：向球场几何中心 (0.5, 0.5) 轻推恢复运动
scoreboard players set @s sb_stuck 0
scoreboard players set #in_x sb_var 500
scoreboard players operation #in_x sb_var -= @s sb_px
scoreboard players set #in_z sb_var 500
scoreboard players operation #in_z sb_var -= @s sb_pz
scoreboard players set #target_spd sb_var 450
function sb:util/norm2d
function sb:cube/set_horizontal
data modify entity @s Motion[1] set value 0.06d

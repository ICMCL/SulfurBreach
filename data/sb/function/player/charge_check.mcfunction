execute unless score @s sb_charge_dur matches 1..200 run return 0
execute unless entity @e[type=sulfur_cube,tag=sb_ball,scores={sb_state=1..2},distance=..5.5] run return 0

function sb:player/shot_context
scoreboard players operation #pvx sb_var = @s sb_vx
scoreboard players operation #pvz sb_var = @s sb_vz

# 沿玩家水平面朝向在球高平面 (y=65.5) 投射 4.25 格迎击射线：平视疾跑无需低头看脚即可稳定迎击地面来球，且遇中场偏转柱自动阻挡
scoreboard players set #ray_steps sb_var 17
execute positioned ~ 65.5 ~ rotated ~ 0 positioned ^ ^ ^0.25 run function sb:player/charge_ray
tag @s remove sb_hitter

# 防肉身堵球（敌我一视同仁）：恢复硫方怪缓存动量穿透而过，并将贴身硬挡的玩家无伤震开 + 短暂失衡
execute unless entity @a[tag=sb_alive,scores={sb_bump_cd=0},distance=..1.25] run return 0
function sb:cube/restore_vel
execute as @a[tag=sb_alive,scores={sb_bump_cd=0},distance=..1.25] at @s run function sb:player/on_body_bump

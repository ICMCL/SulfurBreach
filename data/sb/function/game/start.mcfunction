# ===== 正式开始一场破壁比赛（主世界执行，开赛瞬间重置球场与两侧满血守护墙） =====
execute if score #state sb_var matches 1..2 run return 0
function sb:cfg/calc

scoreboard players add #gid sb_var 1
scoreboard players set #solo_mode sb_var 0

function sb:arena/reset_round
execute as @a[team=red] run function sb:player/enter_match
execute as @a[team=blue] run function sb:player/enter_match

scoreboard players operation #rem_sec sb_var = #cfg_dur sb_var
execute if score #cfg_dur sb_var matches 1.. run scoreboard players operation rem_sec sb_side = #rem_sec sb_var
execute if score #cfg_dur sb_var matches 0 run scoreboard players reset rem_sec sb_side
scoreboard players operation #rem_ticks sb_var = #cfg_dur sb_var
scoreboard players operation #rem_ticks sb_var *= #20 sb_const
scoreboard players set #elap_ticks sb_var 0

scoreboard objectives setdisplay sidebar sb_side
bossbar set sb:red_wall players @a
bossbar set sb:blue_wall players @a
bossbar set sb:red_wall visible true
bossbar set sb:blue_wall visible true

scoreboard players set #phase_tmr sb_var 60
scoreboard players set #state sb_var 1

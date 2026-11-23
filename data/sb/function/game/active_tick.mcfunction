# ===== 激战阶段每刻更新 =====
function sb:cube/spawner_step
execute if score #o_layout sb_var matches 1 run function sb:arena/bumpers_tick
function sb:cube/tick
execute unless score #state sb_var matches 2 run return 0

function sb:player/tick

scoreboard players operation #g10 sb_var = #gt sb_var
scoreboard players operation #g10 sb_var %= #10 sb_const
execute if score #g10 sb_var matches 0 run function sb:arena/fx_tick

execute if score #g20 sb_var matches 0 run effect give @a[tag=sb_alive] minecraft:resistance 3 4 true
execute if score #g20 sb_var matches 0 run effect give @a[tag=sb_alive] minecraft:saturation 3 0 true
execute if score #g20 sb_var matches 0 if score #solo_mode sb_var matches 0 run function sb:game/check_forfeit
execute unless score #state sb_var matches 2 run return 0

# 无尽拆完模式或突然死亡阶段：按已开战时长触发 5 阶双墙前推 (60s/70s/80s/90s/100s)
execute if score #cfg_dur sb_var matches 0 run return run function sb:game/endless_clock
execute if score #sudden_death sb_var matches 1 run return run function sb:game/endless_clock

# 限时模式倒计时与残局 5 阶双墙前推 (40s/32s/24s/16s/8s)
scoreboard players remove #rem_ticks sb_var 1

execute if score #rem_ticks sb_var matches 830 run function sb:arena/push_warn
execute if score #rem_ticks sb_var matches 670 run function sb:arena/push_warn
execute if score #rem_ticks sb_var matches 510 run function sb:arena/push_warn
execute if score #rem_ticks sb_var matches 350 run function sb:arena/push_warn
execute if score #rem_ticks sb_var matches 190 run function sb:arena/push_warn

execute if score #rem_ticks sb_var matches 800 run function sb:arena/push_step
execute if score #rem_ticks sb_var matches 640 run function sb:arena/push_step
execute if score #rem_ticks sb_var matches 480 run function sb:arena/push_step
execute if score #rem_ticks sb_var matches 320 run function sb:arena/push_step
execute if score #rem_ticks sb_var matches 160 run function sb:arena/push_step
execute unless score #state sb_var matches 2 run return 0

scoreboard players operation #rt20 sb_var = #rem_ticks sb_var
scoreboard players operation #rt20 sb_var %= #20 sb_const
execute if score #rt20 sb_var matches 0 run function sb:game/on_second
execute if score #rem_ticks sb_var matches ..0 if score #state sb_var matches 2 run function sb:game/timeout_judge

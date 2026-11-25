# ===== 单个硫方怪每刻状态机、中立区围栏、防肉身堵球、破墙与漏球检测 =====
execute if score @s sb_hit_cd matches 1.. run scoreboard players remove @s sb_hit_cd 1
execute if score @s sb_back_cd matches 1.. run scoreboard players remove @s sb_back_cd 1
execute if score @s sb_bumper_cd matches 1.. run scoreboard players remove @s sb_bumper_cd 1

# 防掉出下层竞技场高度兜底 (y=65..70)
execute if entity @s[y=-64,dy=126] run tp @s 0.5 65.2 0.5
execute if entity @s[y=71,dy=20] run tp @s 0.5 65.2 0.5
execute unless data entity @s {Health:1024.0f} run data modify entity @s Health set value 1024.0f

# 状态 0：仅允许在中央 5 格共享中立区 (x ∈ [-1.45, +2.45]) 晃荡
execute if score @s sb_state matches 0 run return run function sb:cube/wander_step

# 防肉身堵球：任何玩家未出矛用身体硬挡运动中的冲撞/重锤球时，恢复球动量并将玩家无伤震开
execute if score @s sb_state matches 1..2 if score @s sb_hit_cd matches 0 run function sb:cube/body_check

# 若刚从空旷背板反弹回场，确保斜向出洞时不卡入相邻实心墙背面
execute if score @s sb_back_cd matches 1.. run function sb:cube/back_exit_guard

# 先采样护栏校正后的坐标；保留上一刻 sb_vx，供墙边判断球是否刚反弹。
execute store result score @s sb_px run data get entity @s Pos[0] 1000
execute store result score @s sb_pz run data get entity @s Pos[2] 1000
execute if score @s sb_back_cd matches 0 run function sb:cube/wall_check
execute unless entity @s run return 0
execute unless score #state sb_var matches 2 run return 0

# 撞墙可能改变动量，速度必须在结算后采样。
execute store result score @s sb_vx run data get entity @s Motion[0] 1000
execute store result score @s sb_vz run data get entity @s Motion[2] 1000

# 记录跨中线状态 (x = 0.5 即 500；向东击出越过 600 或向西击出越过 400 即视为过网)
execute if score @s sb_state matches 1..2 if score @s sb_strike_side matches 1 if score @s sb_px matches 600.. run scoreboard players set @s sb_crossed 1
execute if score @s sb_state matches 1..2 if score @s sb_strike_side matches -1 if score @s sb_px matches ..400 run scoreboard players set @s sb_crossed 1

# 尾迹特效
execute if score @s sb_state matches 1 if score @s sb_special matches 0 run particle minecraft:dust{color:[0.9,0.95,1.0],scale:1.15} ~ ~0.45 ~ 0.15 0.15 0.15 0 2 force
execute if score @s sb_state matches 1 if score @s sb_special matches 1 run particle minecraft:snowflake ~ ~0.45 ~ 0.18 0.15 0.18 0.02 3 force
execute if score @s sb_state matches 1 if score @s sb_special matches 2 run particle minecraft:happy_villager ~ ~0.5 ~ 0.2 0.2 0.2 0.02 2 force
execute if score @s sb_state matches 2 run particle minecraft:flame ~ ~0.45 ~ 0.18 0.18 0.18 0.02 3 force
execute if score @s sb_state matches 2 run particle minecraft:electric_spark ~ ~0.5 ~ 0.2 0.2 0.2 0.05 2 force

# 状态 3（凝灰岩卸力态）：停滞或回中立区慢滑满 3 秒自动蜕回空心晃荡态
execute if score @s sb_state matches 3 run return run function sb:cube/spent_step

# 状态 1/2 防平行死球保护（|vx| < 95 持续满 24 tick = 1.2s 则注入横向推进）与防卡角脱困
scoreboard players operation #avx sb_var = @s sb_vx
execute if score #avx sb_var matches ..-1 run scoreboard players operation #avx sb_var *= #-1 sb_const
scoreboard players operation #avz sb_var = @s sb_vz
execute if score #avz sb_var matches ..-1 run scoreboard players operation #avz sb_var *= #-1 sb_const

execute if score #avx sb_var matches ..94 run scoreboard players add @s sb_dead_tmr 1
execute if score #avx sb_var matches 95.. run scoreboard players set @s sb_dead_tmr 0
execute if score @s sb_dead_tmr matches 24.. run function sb:cube/dead_ball_nudge

scoreboard players operation #spd_m sb_var = #avx sb_var
scoreboard players operation #spd_m sb_var += #avz sb_var
execute if score #spd_m sb_var matches ..75 run scoreboard players add @s sb_stuck 1
execute if score #spd_m sb_var matches 76.. run scoreboard players set @s sb_stuck 0
execute if score @s sb_stuck matches 18.. run function sb:cube/unstuck

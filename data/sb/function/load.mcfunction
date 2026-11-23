# ===== 硫方破壁 (Sulfur Breach) · 加载初始化 =====
scoreboard objectives add sb_var dummy
scoreboard objectives add sb_const dummy
scoreboard objectives add sb_tmp dummy
scoreboard objectives add sb_id dummy
scoreboard objectives add sb_gid dummy
scoreboard objectives add sb_team dummy
scoreboard objectives add sb_state dummy
scoreboard objectives add sb_special dummy
scoreboard objectives add sb_rally dummy
scoreboard objectives add sb_crossed dummy
scoreboard objectives add sb_strike_side dummy
scoreboard objectives add sb_hit_cd dummy
scoreboard objectives add sb_back_cd dummy
scoreboard objectives add sb_bumper_cd dummy
scoreboard objectives add sb_idle_tmr dummy
scoreboard objectives add sb_dead_tmr dummy
scoreboard objectives add sb_stuck dummy
scoreboard objectives add sb_px dummy
scoreboard objectives add sb_pz dummy
scoreboard objectives add sb_vx dummy
scoreboard objectives add sb_vz dummy
scoreboard objectives add sb_col dummy
scoreboard objectives add sb_hp dummy
scoreboard objectives add sb_charging dummy
scoreboard objectives add sb_charge_dur dummy
scoreboard objectives add sb_bump_cd dummy
scoreboard objectives add sb_warn_cd dummy
scoreboard objectives add sb_cfg trigger
scoreboard objectives add sb_set trigger
scoreboard objectives add sb_left minecraft.custom:minecraft.leave_game
scoreboard objectives add sb_side dummy {text:"🛡 硫方破壁 🛡",color:"gold",bold:true}

scoreboard players set #-1 sb_const -1
scoreboard players set #2 sb_const 2
scoreboard players set #3 sb_const 3
scoreboard players set #4 sb_const 4
scoreboard players set #5 sb_const 5
scoreboard players set #8 sb_const 8
scoreboard players set #10 sb_const 10
scoreboard players set #19 sb_const 19
scoreboard players set #20 sb_const 20
scoreboard players set #25 sb_const 25
scoreboard players set #50 sb_const 50
scoreboard players set #95 sb_const 95
scoreboard players set #100 sb_const 100
scoreboard players set #1000 sb_const 1000

# 默认配置（首次加载初始化，保留已有配置）
execute unless score #o_dur sb_var matches 0..3 run scoreboard players set #o_dur sb_var 1
execute unless score #o_balls sb_var matches 0..2 run scoreboard players set #o_balls sb_var 1
execute unless score #o_wall_hp sb_var matches 0..2 run scoreboard players set #o_wall_hp sb_var 1
execute unless score #o_speed sb_var matches 0..2 run scoreboard players set #o_speed sb_var 1
execute unless score #o_recall sb_var matches 0..3 run scoreboard players set #o_recall sb_var 0
execute unless score #o_depth sb_var matches 0..2 run scoreboard players set #o_depth sb_var 0
execute unless score #o_shrink sb_var matches 0..1 run scoreboard players set #o_shrink sb_var 0
execute unless score #o_layout sb_var matches 0..1 run scoreboard players set #o_layout sb_var 0
execute unless score #o_mutant sb_var matches 0..1 run scoreboard players set #o_mutant sb_var 0
function sb:cfg/calc
execute unless score #state sb_var matches 0..2 run scoreboard players set #state sb_var 0

# 队伍配置（红蓝仅分队与战袍色，硫方怪无阵营球权区分，全员关闭挤压碰撞）
team add red {text:"红队",color:"red"}
team add blue {text:"蓝队",color:"blue"}
team add sb_empty {text:"中立空心",color:"white"}
team add sb_iron {text:"铁芯冲撞",color:"aqua"}
team add sb_overload {text:"重锤超载",color:"gold"}
team add sb_spent {text:"撞墙卸力",color:"gray"}
team add sb_repair {text:"泥砖修墙",color:"green"}
team modify red color red
team modify blue color blue
team modify sb_empty color white
team modify sb_iron color white
team modify sb_overload color gold
team modify sb_spent color dark_gray
team modify sb_repair color green
team modify red friendlyFire false
team modify blue friendlyFire false
team modify red collisionRule never
team modify blue collisionRule never
team modify sb_empty collisionRule never
team modify sb_iron collisionRule never
team modify sb_overload collisionRule never
team modify sb_spent collisionRule never
team modify sb_repair collisionRule never
team modify red prefix {text:"[红] ",color:"red"}
team modify blue prefix {text:"[蓝] ",color:"blue"}

data modify storage sb:t red set value {team:"red",id:1,name:"红队",color:"red",c:16724787}
data modify storage sb:t blue set value {team:"blue",id:2,name:"蓝队",color:"blue",c:3949738}

function sb:cfg/templates

# 计分板侧栏显示名
scoreboard players display name r_hp sb_side {text:"红方守护墙(HP)",color:"red"}
scoreboard players display name b_hp sb_side {text:"蓝方守护墙(HP)",color:"blue"}
scoreboard players display name rem_sec sb_side {text:"剩余时间(秒)",color:"yellow"}

# 顶部双守护墙 Bossbar 初始化
bossbar add sb:red_wall {text:"红方守护墙",color:"red"}
bossbar add sb:blue_wall {text:"蓝方守护墙",color:"blue"}
bossbar set sb:red_wall color red
bossbar set sb:blue_wall color blue
execute if score #state sb_var matches 0 run bossbar set sb:red_wall visible false
execute if score #state sb_var matches 0 run bossbar set sb:blue_wall visible false

execute in minecraft:overworld run forceload add -48 -48 47 47
scoreboard players set #lobby_synced sb_var 0

# ===== 场上玩家每刻移动速度采样、半场软空气墙约束与状态维护 =====
execute if score @s sb_bump_cd matches 1.. run scoreboard players remove @s sb_bump_cd 1
execute if score @s sb_warn_cd matches 1.. run scoreboard players remove @s sb_warn_cd 1

# 采样当前帧真实水平位移速度（千分格/tick，供右键架矛闭合速度计算）
execute store result score #nx sb_var run data get entity @s Pos[0] 1000
execute store result score #nz sb_var run data get entity @s Pos[2] 1000
scoreboard players operation @s sb_vx = #nx sb_var
scoreboard players operation @s sb_vx -= @s sb_px
scoreboard players operation @s sb_vz = #nz sb_var
scoreboard players operation @s sb_vz -= @s sb_pz
scoreboard players operation @s sb_px = #nx sb_var
scoreboard players operation @s sb_pz = #nz sb_var

# 共享 5 格中立区软边界约束（红蓝皆可进入 x ∈ [-2..+2]，仅阻止越入对方专属半场）
function sb:player/zone_clamp

# 右键架矛松手归零
execute if score @s sb_charging matches 1.. run scoreboard players remove @s sb_charging 1
execute if score @s sb_charging matches 0 if score @s sb_charge_dur matches 1.. run scoreboard players set @s sb_charge_dur 0

function sb:player/refill_spear

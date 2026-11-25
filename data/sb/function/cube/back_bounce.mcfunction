# 大缺口打空：取缓存/即时横向速度的较大绝对值，以 95% 回弹，至少 0.48 格/tick。
scoreboard players set @s sb_back_cd 8
scoreboard players operation #bspd sb_var = @s sb_vx
execute if score #bspd sb_var matches ..-1 run scoreboard players operation #bspd sb_var *= #-1 sb_const
execute if score #cur_vx sb_var matches ..-1 run scoreboard players operation #cur_vx sb_var *= #-1 sb_const
scoreboard players operation #bspd sb_var > #cur_vx sb_var
scoreboard players operation #bspd sb_var *= #95 sb_const
scoreboard players operation #bspd sb_var /= #100 sb_const
execute if score #bspd sb_var matches ..479 run scoreboard players set #bspd sb_var 480
scoreboard players operation @s sb_vx = #bspd sb_var
$scoreboard players operation @s sb_vx *= #$(sign) sb_const
function sb:cube/restore_vel
particle minecraft:poof ~ ~0.5 ~ 0.2 0.25 0.2 0.05 8 force
playsound minecraft:entity.sulfur_cube.bouncy.hit master @a ~ ~0.5 ~ 1.0 1.15

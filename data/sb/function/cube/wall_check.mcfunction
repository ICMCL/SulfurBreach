# 中场无需读即时速度或查墙列；贴墙先结算背板，再判实心墙。
execute if score @s sb_px > #hit_r sb_var if score @s sb_px < #hit_b sb_var run return 0
scoreboard players operation #bcol_raw sb_var = @s sb_pz
scoreboard players operation #bcol_raw sb_var /= #1000 sb_const
execute store result score #cur_vx sb_var run data get entity @s Motion[0] 1000

execute if score @s sb_px <= #back_r_deep sb_var run return run function sb:cube/leak_base with storage sb:t red
execute if score @s sb_px <= #leak_r sb_var if score #cur_vx sb_var matches -30.. run return run function sb:cube/leak_base with storage sb:t red
execute if score @s sb_px >= #back_b_deep sb_var run return run function sb:cube/leak_base with storage sb:t blue
execute if score @s sb_px >= #leak_b sb_var if score #cur_vx sb_var matches ..30 run return run function sb:cube/leak_base with storage sb:t blue

execute unless score @s sb_state matches 1..2 run return 0
execute if score @s sb_px <= #hit_r sb_var run return run function sb:cube/hit_wall with storage sb:t red
execute if score @s sb_px >= #hit_b sb_var run return run function sb:cube/hit_wall with storage sb:t blue

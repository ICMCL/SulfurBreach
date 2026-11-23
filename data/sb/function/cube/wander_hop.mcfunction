scoreboard players set @s sb_idle_tmr 0
execute store result score #wx sb_var run random value -140..140
execute store result score #wz sb_var run random value -200..200
execute if score @s sb_px matches ..-700 if score #wx sb_var matches ..0 run scoreboard players operation #wx sb_var *= #-1 sb_const
execute if score @s sb_px matches 1700.. if score #wx sb_var matches 0.. run scoreboard players operation #wx sb_var *= #-1 sb_const
execute if score @s sb_pz matches ..-7500 if score #wz sb_var matches ..0 run scoreboard players operation #wz sb_var *= #-1 sb_const
execute if score @s sb_pz matches 8500.. if score #wz sb_var matches 0.. run scoreboard players operation #wz sb_var *= #-1 sb_const
execute store result entity @s Motion[0] double 0.001 run scoreboard players get #wx sb_var
execute store result entity @s Motion[2] double 0.001 run scoreboard players get #wz sb_var
data modify entity @s Motion[1] set value 0.24d

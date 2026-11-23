$summon marker $(rw) 65 $(z) {Tags:["sb_wcol","sb_wred","sb_wnew"]}
$execute as @e[type=marker,tag=sb_wnew] run scoreboard players set @s sb_col $(z)
execute as @e[type=marker,tag=sb_wnew] run scoreboard players operation @s sb_hp = #col_max_hp sb_var
execute as @e[type=marker,tag=sb_wnew] at @s run function sb:arena/col_render
tag @e[type=marker,tag=sb_wnew] remove sb_wnew

$summon marker $(bw) 65 $(z) {Tags:["sb_wcol","sb_wblue","sb_wnew"]}
$execute as @e[type=marker,tag=sb_wnew] run scoreboard players set @s sb_col $(z)
execute as @e[type=marker,tag=sb_wnew] run scoreboard players operation @s sb_hp = #col_max_hp sb_var
execute as @e[type=marker,tag=sb_wnew] at @s run function sb:arena/col_render
tag @e[type=marker,tag=sb_wnew] remove sb_wnew

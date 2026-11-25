# 每次从球的位置选最近的候选列；第一点补满后，第二点可补到下一列。
execute as @n[type=marker,tag=sb_need_rep] at @s run function sb:arena/repair_column
execute as @n[type=marker,tag=sb_need_rep] at @s run function sb:arena/repair_column
tag @e[type=marker,tag=sb_need_rep] remove sb_need_rep
tag @e[type=marker,tag=sb_hit_col] remove sb_hit_col
playsound minecraft:block.mud_bricks.place master @a ~ ~1 ~ 1.3 1.1
playsound minecraft:entity.player.levelup master @a ~ ~1 ~ 0.9 1.4
$title @a[tag=sb_ingame] actionbar {text:"🧱 $(message)",color:"green",bold:true}
function sb:cube/destroy_ball
function sb:arena/recalc_hp

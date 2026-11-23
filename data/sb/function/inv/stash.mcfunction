execute unless score @s sb_id matches 1.. run function sb:player/new_id
execute store result storage sb:tmp id.id int 1 run scoreboard players get @s sb_id
function sb:inv/stash_m with storage sb:tmp id
clear @s

clear @s
data remove storage sb:tmp list
data remove storage sb:tmp eq
execute store result storage sb:tmp id.id int 1 run scoreboard players get @s sb_id
function sb:inv/restore_m with storage sb:tmp id
execute unless block 0 58 0 chest run setblock 0 58 0 chest
execute if data storage sb:tmp list[0] run function sb:inv/put_loop
execute if data storage sb:tmp eq.head run function sb:inv/put_eq {k:"head",s:"armor.head"}
execute if data storage sb:tmp eq.chest run function sb:inv/put_eq {k:"chest",s:"armor.chest"}
execute if data storage sb:tmp eq.legs run function sb:inv/put_eq {k:"legs",s:"armor.legs"}
execute if data storage sb:tmp eq.feet run function sb:inv/put_eq {k:"feet",s:"armor.feet"}
execute if data storage sb:tmp eq.offhand run function sb:inv/put_eq {k:"offhand",s:"weapon.offhand"}
data modify block 0 58 0 Items set value []

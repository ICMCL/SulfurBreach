data modify storage sb:tmp it set from storage sb:tmp list[0]
data remove storage sb:tmp list[0]
execute store result storage sb:tmp sl.s int 1 run data get storage sb:tmp it.Slot
data modify storage sb:tmp it.Slot set value 0b
data modify block 0 58 0 Items set value []
data modify block 0 58 0 Items append from storage sb:tmp it
function sb:inv/put_slot with storage sb:tmp sl
execute if data storage sb:tmp list[0] run function sb:inv/put_loop

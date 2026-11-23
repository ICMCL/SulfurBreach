$data modify storage sb:tmp it set from storage sb:tmp eq.$(k)
data modify storage sb:tmp it.Slot set value 0b
data modify block 0 58 0 Items set value []
data modify block 0 58 0 Items append from storage sb:tmp it
$item replace entity @s $(s) from block 0 58 0 container.0

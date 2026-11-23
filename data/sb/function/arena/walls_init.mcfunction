# 初始化东西两侧各 19 列守护墙 (z = -9 .. +9) 与南北端不可破坏边柱 (z = -10, +10)
kill @e[type=marker,tag=sb_wcol]

execute store result storage sb:tmp wi.rw int 1 run scoreboard players get #r_wall_x sb_var
execute store result storage sb:tmp wi.rb int 1 run scoreboard players get #r_base_x sb_var
execute store result storage sb:tmp wi.bw int 1 run scoreboard players get #b_wall_x sb_var
execute store result storage sb:tmp wi.bb int 1 run scoreboard players get #b_base_x sb_var
function sb:arena/walls_pillars_m with storage sb:tmp wi

data modify storage sb:tmp wi.z set value -9
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value -8
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value -7
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value -6
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value -5
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value -4
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value -3
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value -2
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value -1
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value 0
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value 1
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value 2
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value 3
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value 4
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value 5
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value 6
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value 7
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value 8
function sb:arena/col_init_pair with storage sb:tmp wi
data modify storage sb:tmp wi.z set value 9
function sb:arena/col_init_pair with storage sb:tmp wi

function sb:arena/recalc_hp

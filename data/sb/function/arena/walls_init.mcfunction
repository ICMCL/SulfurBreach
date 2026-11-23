# 初始化东西两侧各 19 列守护墙 (z = -9 .. +9) 与南北端不可破坏边柱 (z = -10, +10)
kill @e[type=marker,tag=sb_wcol]

fill -13 65 -10 -13 67 -10 cut_sandstone
fill -13 65 10 -13 67 10 cut_sandstone
fill 13 65 -10 13 67 -10 cut_sandstone
fill 13 65 10 13 67 10 cut_sandstone
setblock -13 67 -10 chiseled_sandstone
setblock -13 67 10 chiseled_sandstone
setblock 13 67 -10 chiseled_sandstone
setblock 13 67 10 chiseled_sandstone
fill -13 68 -10 -13 70 -10 barrier
fill -13 68 10 -13 70 10 barrier
fill 13 68 -10 13 70 -10 barrier
fill 13 68 10 13 70 10 barrier
fill -14 65 -10 -14 67 -10 cut_sandstone
fill -14 65 10 -14 67 10 cut_sandstone
fill 14 65 -10 14 67 -10 cut_sandstone
fill 14 65 10 14 67 10 cut_sandstone
fill -14 68 -10 -14 70 -10 barrier
fill -14 68 10 -14 70 10 barrier
fill 14 68 -10 14 70 -10 barrier
fill 14 68 10 14 70 10 barrier

function sb:arena/col_init_pair {z:-9}
function sb:arena/col_init_pair {z:-8}
function sb:arena/col_init_pair {z:-7}
function sb:arena/col_init_pair {z:-6}
function sb:arena/col_init_pair {z:-5}
function sb:arena/col_init_pair {z:-4}
function sb:arena/col_init_pair {z:-3}
function sb:arena/col_init_pair {z:-2}
function sb:arena/col_init_pair {z:-1}
function sb:arena/col_init_pair {z:0}
function sb:arena/col_init_pair {z:1}
function sb:arena/col_init_pair {z:2}
function sb:arena/col_init_pair {z:3}
function sb:arena/col_init_pair {z:4}
function sb:arena/col_init_pair {z:5}
function sb:arena/col_init_pair {z:6}
function sb:arena/col_init_pair {z:7}
function sb:arena/col_init_pair {z:8}
function sb:arena/col_init_pair {z:9}

function sb:arena/recalc_hp

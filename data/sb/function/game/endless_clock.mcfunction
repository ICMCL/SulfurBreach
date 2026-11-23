scoreboard players add #elap_ticks sb_var 1
execute if score #elap_ticks sb_var matches 1170 run function sb:arena/push_warn
execute if score #elap_ticks sb_var matches 1370 run function sb:arena/push_warn
execute if score #elap_ticks sb_var matches 1570 run function sb:arena/push_warn
execute if score #elap_ticks sb_var matches 1770 run function sb:arena/push_warn
execute if score #elap_ticks sb_var matches 1970 run function sb:arena/push_warn

execute if score #elap_ticks sb_var matches 1200 run function sb:arena/push_step
execute if score #elap_ticks sb_var matches 1400 run function sb:arena/push_step
execute if score #elap_ticks sb_var matches 1600 run function sb:arena/push_step
execute if score #elap_ticks sb_var matches 1800 run function sb:arena/push_step
execute if score #elap_ticks sb_var matches 2000 run function sb:arena/push_step

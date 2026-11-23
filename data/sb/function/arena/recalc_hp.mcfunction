# 汇总两侧 19 列守护墙总剩余 HP，同步顶部双 Bossbar 与侧边栏，并检查破壁获胜或突然死亡决胜
scoreboard players set #r_hp sb_var 0
scoreboard players set #b_hp sb_var 0
execute as @e[type=marker,tag=sb_wred] run scoreboard players operation #r_hp sb_var += @s sb_hp
execute as @e[type=marker,tag=sb_wblue] run scoreboard players operation #b_hp sb_var += @s sb_hp

scoreboard players operation r_hp sb_side = #r_hp sb_var
scoreboard players operation b_hp sb_side = #b_hp sb_var

execute store result bossbar sb:red_wall max run scoreboard players get #wall_max_hp sb_var
execute store result bossbar sb:blue_wall max run scoreboard players get #wall_max_hp sb_var
execute store result bossbar sb:red_wall value run scoreboard players get #r_hp sb_var
execute store result bossbar sb:blue_wall value run scoreboard players get #b_hp sb_var
bossbar set sb:red_wall name [{text:"🔴 红方守护墙  ",color:"red",bold:true},{score:{name:"#r_hp",objective:"sb_var"},color:"white",bold:false},{text:" / ",color:"gray"},{score:{name:"#wall_max_hp",objective:"sb_var"},color:"gray"},{text:" HP",color:"gray"}]
bossbar set sb:blue_wall name [{text:"🔵 蓝方守护墙  ",color:"blue",bold:true},{score:{name:"#b_hp",objective:"sb_var"},color:"white",bold:false},{text:" / ",color:"gray"},{score:{name:"#wall_max_hp",objective:"sb_var"},color:"gray"},{text:" HP",color:"gray"}]

execute if score #state sb_var matches 2 run function sb:game/check_walls

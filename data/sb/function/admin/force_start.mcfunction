execute if score #state sb_var matches 1..2 run return run tellraw @s {text:"[硫方破壁] 当前已有比赛正在进行，可先输入 /function sb:admin/stop 终止。",color:"red"}
execute unless entity @a[team=red] unless entity @a[team=blue] as @p run function sb:lobby/join with storage sb:t red
execute in minecraft:overworld run function sb:game/start
scoreboard players set #solo_mode sb_var 1
tellraw @a [{text:"[硫方破壁] ",color:"gold",bold:true},{text:"已进入单人/调试强开模式（关闭空队判胜，可自由测试中立区争球、四态内容物、破墙过载与双墙前推，输入 /function sb:admin/stop 可随时返厅）。",color:"aqua",bold:false}]

scoreboard players set #r_on sb_var 0
scoreboard players set #b_on sb_var 0
execute as @a[tag=sb_alive,scores={sb_team=1}] run scoreboard players add #r_on sb_var 1
execute as @a[tag=sb_alive,scores={sb_team=2}] run scoreboard players add #b_on sb_var 1
execute if score #r_on sb_var matches 0 if score #b_on sb_var matches 0 run return run function sb:game/stop
execute if score #r_on sb_var matches 0 run return run function sb:game/finish {result:"🔵 红队全员离场 · 蓝队获胜！",color:"blue"}
execute if score #b_on sb_var matches 0 run return run function sb:game/finish {result:"🔴 蓝队全员离场 · 红队获胜！",color:"red"}

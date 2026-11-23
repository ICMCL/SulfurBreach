execute as @a[tag=sb_alive] run function sb:player/tp_spawn

execute if score #phase_tmr sb_var matches 60 run title @a[tag=sb_ingame] times 0 25 5
execute if score #phase_tmr sb_var matches 60 run title @a[tag=sb_ingame] title {text:"3",color:"yellow",bold:true}
execute if score #phase_tmr sb_var matches 60 run title @a[tag=sb_ingame] subtitle {text:"守护身后城墙 · 冲进中立区争球！",color:"gray"}
execute if score #phase_tmr sb_var matches 60 run playsound minecraft:block.note_block.hat master @a[tag=sb_ingame] ~ ~ ~ 1.0 1.0

execute if score #phase_tmr sb_var matches 40 run title @a[tag=sb_ingame] title {text:"2",color:"gold",bold:true}
execute if score #phase_tmr sb_var matches 40 run playsound minecraft:block.note_block.hat master @a[tag=sb_ingame] ~ ~ ~ 1.0 1.25

execute if score #phase_tmr sb_var matches 20 run title @a[tag=sb_ingame] title {text:"1",color:"red",bold:true}
execute if score #phase_tmr sb_var matches 20 run playsound minecraft:block.note_block.hat master @a[tag=sb_ingame] ~ ~ ~ 1.0 1.5

scoreboard players remove #phase_tmr sb_var 1
execute if score #phase_tmr sb_var matches ..0 run function sb:game/begin_fight

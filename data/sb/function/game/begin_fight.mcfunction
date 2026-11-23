scoreboard players set #state sb_var 2
scoreboard players set #spawn_cd sb_var 0
execute as @a[tag=sb_alive] store result score @s sb_px run data get entity @s Pos[0] 1000
execute as @a[tag=sb_alive] store result score @s sb_pz run data get entity @s Pos[2] 1000
execute as @a[tag=sb_alive] run scoreboard players set @s sb_vx 0
execute as @a[tag=sb_alive] run scoreboard players set @s sb_vz 0

function sb:cube/spawner_step

title @a[tag=sb_ingame] times 0 18 8
title @a[tag=sb_ingame] title {text:"破壁开战！",color:"green",bold:true}
title @a[tag=sb_ingame] subtitle {text:"中立区硫方怪已出现！撞哪面墙就扣哪面墙耐久！",color:"yellow"}
playsound minecraft:block.bell.use master @a[tag=sb_ingame] ~ ~ ~ 1.2 1.2

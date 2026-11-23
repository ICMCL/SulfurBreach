execute if block 0 69 -16 emerald_block as @a[tag=!sb_ingame,gamemode=adventure,x=-20,y=64,z=-10,dx=40,dy=6,dz=20] run function sb:lobby/arrive

execute if score #btn_cd sb_var matches 1.. run scoreboard players remove #btn_cd sb_var 1
execute as @a[tag=!sb_ingame,team=!red,x=-11,y=69,z=-17,dx=3,dy=1,dz=3] run function sb:lobby/join with storage sb:t red
execute as @a[tag=!sb_ingame,team=!blue,x=8,y=69,z=-17,dx=3,dy=1,dz=3] run function sb:lobby/join with storage sb:t blue
execute as @a[tag=!sb_ingame,team=!,x=13,y=69,z=-17,dx=2,dy=1,dz=2] run function sb:lobby/leave

execute if block 0 70 -16 stone_button[powered=true] run function sb:lobby/button
execute as @e[type=interaction,tag=sb_cfgnpc] if data entity @s interaction run function sb:cfg/npc
execute as @e[type=interaction,tag=sb_cfgnpc] if data entity @s attack run function sb:cfg/npc

execute if score #g20 sb_var matches 0 run effect give @a[tag=!sb_ingame] minecraft:saturation 2 0 true
execute if score #g20 sb_var matches 0 run effect give @a[tag=!sb_ingame] minecraft:resistance 2 4 true
execute if score #g20 sb_var matches 0 run effect give @a[tag=!sb_ingame] minecraft:regeneration 2 4 true
execute if block 0 69 -16 emerald_block as @a[tag=!sb_ingame,gamemode=adventure] at @s if entity @s[y=-64,dy=120] run function sb:lobby/arrive

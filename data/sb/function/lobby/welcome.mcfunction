tag @s add sb_seen
execute in minecraft:overworld if block 0 69 -16 emerald_block unless entity @s[tag=sb_ingame] run function sb:lobby/arrive
gamemode adventure @s
tellraw @s [{text:"[硫方破壁] ",color:"gold",bold:true},{text:"欢迎来到晴空海岸露天竞技岛！走入红/蓝海滨选队亭加入队伍，右键讲台可调整规则，前排竹木看台可无遮挡俯视露天赛场。",color:"white",bold:false}]

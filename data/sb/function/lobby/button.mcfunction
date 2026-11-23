execute if score #btn_cd sb_var matches 1.. run return 0
scoreboard players set #btn_cd sb_var 25
setblock 0 70 -16 stone_button[face=floor,facing=south,powered=false]

execute if score #state sb_var matches 1..2 run return run tellraw @p[x=-5,y=68,z=-19,dx=10,dy=5,dz=7] [{text:"[硫方破壁] ",color:"gold"},{text:"下方露天海岸赛场正在激战中！走到看台前排竹木步道即可无遮挡俯瞰全场。",color:"aqua"}]

scoreboard players set #r_cnt sb_var 0
scoreboard players set #b_cnt sb_var 0
execute as @a[team=red] run scoreboard players add #r_cnt sb_var 1
execute as @a[team=blue] run scoreboard players add #b_cnt sb_var 1

execute unless score #r_cnt sb_var matches 1.. run playsound minecraft:block.note_block.bass master @a ~ ~ ~ 1 0.8
execute unless score #r_cnt sb_var matches 1.. run return run tellraw @a [{text:"[硫方破壁] ",color:"gold"},{text:"无法开赛：红队至少需要 1 名玩家！（单人调试可用 /function sb:admin/force_start）",color:"red"}]
execute unless score #b_cnt sb_var matches 1.. run playsound minecraft:block.note_block.bass master @a ~ ~ ~ 1 0.8
execute unless score #b_cnt sb_var matches 1.. run return run tellraw @a [{text:"[硫方破壁] ",color:"gold"},{text:"无法开赛：蓝队至少需要 1 名玩家！（单人调试可用 /function sb:admin/force_start）",color:"red"}]

function sb:game/start

function sb:arena/recalc_hp
execute unless score #state sb_var matches 2 run return 0

execute if score #r_hp sb_var > #b_hp sb_var run return run function sb:game/finish {result:"🔴 时间到 · 红队守护墙领先获胜！",color:"red"}
execute if score #b_hp sb_var > #r_hp sb_var run return run function sb:game/finish {result:"🔵 时间到 · 蓝队守护墙领先获胜！",color:"blue"}

# 双方剩余总 HP 完全相等：开启突然死亡（Sudden Death）
scoreboard players set #sudden_death sb_var 1
scoreboard players reset rem_sec sb_side
playsound minecraft:entity.wither.spawn master @a ~ ~ ~ 0.65 1.35
title @a[tag=sb_ingame] times 5 50 10
title @a[tag=sb_ingame] title {text:"⚡ 突然死亡 ⚡",color:"gold",bold:true}
title @a[tag=sb_ingame] subtitle {text:"双方城墙耐久相同！下一击破损任意守护墙即决胜负！",color:"yellow"}
tellraw @a [{text:"[硫方破壁] ",color:"gold",bold:true},{text:"常规时间平分秋色！进入「突然死亡」——下一颗造成任意守护墙扣血的硫方怪立即一锤定音！",color:"yellow",bold:false}]

$data modify storage sb:game result set value {text:"$(result)",color:"$(color)",bold:true}
title @a[tag=sb_ingame] times 5 70 15
title @a[tag=sb_ingame] subtitle [{text:"剩余守护墙  ",color:"gray"},{score:{name:"#r_hp",objective:"sb_var"},color:"red"},{text:" HP : ",color:"gray"},{score:{name:"#b_hp",objective:"sb_var"},color:"blue"},{text:" HP",color:"blue"}]
title @a[tag=sb_ingame] title {nbt:"result",storage:"sb:game",interpret:true}
tellraw @a [{text:"[硫方破壁] ",color:"gold",bold:true},{nbt:"result",storage:"sb:game",interpret:true},{text:"　守护墙耐久（红 : 蓝） ",color:"gray",bold:false},{score:{name:"#r_hp",objective:"sb_var"},color:"red"},{text:" : ",color:"gray"},{score:{name:"#b_hp",objective:"sb_var"},color:"blue"}]
playsound minecraft:ui.toast.challenge_complete master @a ~ ~ ~ 0.9 1.0
function sb:game/stop

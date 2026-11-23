# 刷新大厅悬浮规则看板（需在 overworld 执行）
data modify storage sb:cfg txt.dur set value "120 秒"
execute if score #o_dur sb_var matches 0 run data modify storage sb:cfg txt.dur set value "90 秒"
execute if score #o_dur sb_var matches 2 run data modify storage sb:cfg txt.dur set value "180 秒"
execute if score #o_dur sb_var matches 3 run data modify storage sb:cfg txt.dur set value "无限时（拆光为止）"

data modify storage sb:cfg txt.balls set value "2 只"
execute if score #o_balls sb_var matches 0 run data modify storage sb:cfg txt.balls set value "1 只"
execute if score #o_balls sb_var matches 2 run data modify storage sb:cfg txt.balls set value "3 只"

data modify storage sb:cfg txt.recall set value "3 秒"
execute if score #o_recall sb_var matches 1 run data modify storage sb:cfg txt.recall set value "5 秒"
execute if score #o_recall sb_var matches 2 run data modify storage sb:cfg txt.recall set value "8 秒"
execute if score #o_recall sb_var matches 3 run data modify storage sb:cfg txt.recall set value "关闭(不回中)"

data modify storage sb:cfg txt.shrink set value "开启(5阶前推)"
execute if score #o_shrink sb_var matches 1 run data modify storage sb:cfg txt.shrink set value "关闭(固定29格)"

data modify storage sb:cfg txt.layout set value "无障碍纯球场"
execute if score #o_layout sb_var matches 1 run data modify storage sb:cfg txt.layout set value "紫水晶偏转柱"

data modify storage sb:cfg txt.mutant set value "关闭"
execute if score #o_mutant sb_var matches 1 run data modify storage sb:cfg txt.mutant set value "开启"

execute as @e[type=text_display,tag=sb_cfg_board] run data modify entity @s text set value [{text:"🛡 硫方破壁 (Sulfur Breach) 🛡\n",color:"gold",bold:true},{text:"站上 ",color:"white",bold:false},{text:"红区",color:"red"},{text:" / ",color:"white"},{text:"蓝区",color:"blue"},{text:" 选队，",color:"white"},{text:"灰区",color:"gray"},{text:" 旁观\n",color:"white"},{text:"时长: ",color:"gray"},{nbt:"txt.dur",storage:"sb:cfg",interpret:true,color:"yellow"},{text:" | 球数: ",color:"gray"},{nbt:"txt.balls",storage:"sb:cfg",interpret:true,color:"aqua"},{text:" | 球速: ",color:"gray"},{score:{name:"#speed_pct",objective:"sb_var"},color:"aqua"},{text:"%",color:"aqua"},{text:"\n墙耐久: ",color:"gray"},{score:{name:"#col_max_hp",objective:"sb_var"},color:"gold"},{text:"点/列 (总",color:"gray"},{score:{name:"#wall_max_hp",objective:"sb_var"},color:"gold"},{text:"HP)",color:"gray"},{text:" | 缩场: ",color:"gray"},{nbt:"txt.shrink",storage:"sb:cfg",interpret:true,color:"yellow"},{text:"\n回中: ",color:"gray"},{nbt:"txt.recall",storage:"sb:cfg",interpret:true,color:"aqua"},{text:" | 场地: ",color:"gray"},{nbt:"txt.layout",storage:"sb:cfg",interpret:true,color:"light_purple"},{text:" | 突变球: ",color:"gray"},{nbt:"txt.mutant",storage:"sb:cfg",interpret:true,color:"green"}]

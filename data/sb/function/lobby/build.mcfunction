# ===== 初始化大厅悬浮看板与讲台交互实体（大厅建筑已直接写入存档区块 .mca，不覆盖玩家手工改图） =====
setworldspawn 0 70 -15 0 18
kill @e[tag=sb_lobby]
summon text_display 0.5 71.55 -19.88 {Tags:["sb_lobby","sb_cfg_board"],billboard:"fixed",Rotation:[0.0f,0.0f],line_width:300,background:1073741824,brightness:{sky:15,block:15},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.75f,0.75f,0.75f]},text:{text:"硫方破壁",color:"gold"}}
function sb:cfg/lobby_board
summon text_display -9.0 70.6 -15.0 {Tags:["sb_lobby"],billboard:"center",brightness:{sky:15,block:15},text:[{text:"🔴 红队海滨亭\n",color:"red",bold:true},{text:"走入加入",color:"white",bold:false}]}
summon text_display 10.0 70.6 -15.0 {Tags:["sb_lobby"],billboard:"center",brightness:{sky:15,block:15},text:[{text:"🔵 蓝队海滨亭\n",color:"aqua",bold:true},{text:"走入加入",color:"white",bold:false}]}
summon text_display 14.0 70.4 -15.5 {Tags:["sb_lobby"],billboard:"center",brightness:{sky:15,block:15},text:[{text:"👁 观战席\n",color:"gray",bold:true},{text:"取消选队",color:"white",bold:false}]}
summon text_display -2.5 71.08 -19.88 {Tags:["sb_lobby"],billboard:"fixed",Rotation:[0.0f,0.0f],brightness:{sky:15,block:15},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.85f,0.85f,0.85f]},text:{text:"▶ 开始比赛",color:"green",bold:true}}
summon interaction 3.5 69.0 -19.5 {Tags:["sb_lobby","sb_cfgnpc"],width:1.1f,height:1.4f,response:1b}
summon text_display 3.5 70.65 -19.25 {Tags:["sb_lobby"],billboard:"center",brightness:{sky:15,block:15},text:{text:"⚙ 比赛设置（右键）",color:"yellow",bold:true}}

# 守护墙耐久归零或突然死亡分差即时判胜
execute if score #r_hp sb_var matches ..0 if score #b_hp sb_var matches ..0 run return run function sb:game/finish {result:"⚔ 双方守护墙同刻崩塌 · 平局！",color:"yellow"}
execute if score #r_hp sb_var matches ..0 run return run function sb:game/finish {result:"🔵 蓝队破壁获胜！",color:"blue"}
execute if score #b_hp sb_var matches ..0 run return run function sb:game/finish {result:"🔴 红队破壁获胜！",color:"red"}

execute if score #sudden_death sb_var matches 1 if score #r_hp sb_var > #b_hp sb_var run return run function sb:game/finish {result:"🔴 突然死亡一击定音 · 红队获胜！",color:"red"}
execute if score #sudden_death sb_var matches 1 if score #b_hp sb_var > #r_hp sb_var run return run function sb:game/finish {result:"🔵 突然死亡一击定音 · 蓝队获胜！",color:"blue"}

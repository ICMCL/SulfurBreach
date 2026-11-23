# 按当前纵深档位 (#o_depth: 0=+0, 1=+3, 2=+6) 将玩家传送至本队半场中央开球站位
execute if score #o_depth sb_var matches 0 if score @s sb_team matches 1 run tp @s -7.5 65.0 0.5 -90 0
execute if score #o_depth sb_var matches 0 if score @s sb_team matches 2 run tp @s 8.5 65.0 0.5 90 0
execute if score #o_depth sb_var matches 1 if score @s sb_team matches 1 run tp @s -9.5 65.0 0.5 -90 0
execute if score #o_depth sb_var matches 1 if score @s sb_team matches 2 run tp @s 10.5 65.0 0.5 90 0
execute if score #o_depth sb_var matches 2 if score @s sb_team matches 1 run tp @s -11.5 65.0 0.5 -90 0
execute if score #o_depth sb_var matches 2 if score @s sb_team matches 2 run tp @s 12.5 65.0 0.5 90 0

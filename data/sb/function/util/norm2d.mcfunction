# 二维向量归一化缩放工具：输入 #in_x, #in_z 与目标模长 #target_spd，输出 #out_x, #out_z
scoreboard players operation #ax sb_var = #in_x sb_var
execute if score #ax sb_var matches ..-1 run scoreboard players operation #ax sb_var *= #-1 sb_const
scoreboard players operation #az sb_var = #in_z sb_var
execute if score #az sb_var matches ..-1 run scoreboard players operation #az sb_var *= #-1 sb_const

scoreboard players operation #maxv sb_var = #ax sb_var
scoreboard players operation #minv sb_var = #az sb_var
execute if score #az sb_var > #ax sb_var run scoreboard players operation #maxv sb_var = #az sb_var
execute if score #az sb_var > #ax sb_var run scoreboard players operation #minv sb_var = #ax sb_var

scoreboard players operation #minv sb_var *= #2 sb_const
scoreboard players operation #minv sb_var /= #5 sb_const
scoreboard players operation #len sb_var = #maxv sb_var
scoreboard players operation #len sb_var += #minv sb_var
execute if score #len sb_var matches ..0 run scoreboard players set #len sb_var 1

scoreboard players operation #out_x sb_var = #in_x sb_var
scoreboard players operation #out_x sb_var *= #target_spd sb_var
scoreboard players operation #out_x sb_var /= #len sb_var

scoreboard players operation #out_z sb_var = #in_z sb_var
scoreboard players operation #out_z sb_var *= #target_spd sb_var
scoreboard players operation #out_z sb_var /= #len sb_var

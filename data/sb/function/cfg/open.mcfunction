scoreboard players operation #c sb_var = @s sb_cfg
scoreboard players set @s sb_cfg 0
execute unless score #c sb_var matches 1..3 run return run tellraw @s {text:"无效的菜单选项，请重新打开讲台。",color:"yellow"}
execute if score #state sb_var matches 1..2 unless score #c sb_var matches 2 run return run tellraw @s {text:"[硫方破壁] 比赛进行中无法修改规则设置！",color:"red"}
execute if score #c sb_var matches 1 run function sb:cfg/show_rules
execute if score #c sb_var matches 2 run dialog show @s sb:help
execute if score #c sb_var matches 3 run function sb:cfg/defaults
execute if score #c sb_var matches 3 if score #state sb_var matches 0 in minecraft:overworld run function sb:arena/reset_round
execute if score #c sb_var matches 3 in minecraft:overworld run function sb:cfg/lobby_board
execute if score #c sb_var matches 3 run tellraw @a [{text:"[硫方破壁] ",color:"gold"},{selector:"@s"},{text:" 已将比赛规则恢复为默认设置。",color:"yellow"}]

scoreboard players operation #n sb_var = @s sb_set
scoreboard players set @s sb_set 0
execute if score #state sb_var matches 1..2 run return run tellraw @s {text:"[硫方破壁] 比赛进行中无法修改规则设置！",color:"red"}
execute unless score #n sb_var matches 1000000000..1322232111 run return run tellraw @s {text:"设置未保存，请重新打开讲台菜单。",color:"red"}

scoreboard players set #bad_rule sb_var 0
function sb:cfg/read_digit {key:"mutant",max:1}
function sb:cfg/read_digit {key:"layout",max:1}
function sb:cfg/read_digit {key:"shrink",max:1}
function sb:cfg/read_digit {key:"depth",max:2}
function sb:cfg/read_digit {key:"recall",max:3}
function sb:cfg/read_digit {key:"speed",max:2}
function sb:cfg/read_digit {key:"wall_hp",max:2}
function sb:cfg/read_digit {key:"balls",max:2}
function sb:cfg/read_digit {key:"dur",max:3}
execute unless score #n sb_var matches 1 run scoreboard players set #bad_rule sb_var 1
execute if score #bad_rule sb_var matches 1 run return run tellraw @s {text:"设置选项无效，未保存。请重新打开讲台菜单。",color:"red"}

scoreboard players operation #prev_depth sb_var = #o_depth sb_var
scoreboard players operation #prev_layout sb_var = #o_layout sb_var
scoreboard players operation #prev_wall_hp sb_var = #o_wall_hp sb_var

scoreboard players operation #o_dur sb_var = #new_dur sb_var
scoreboard players operation #o_balls sb_var = #new_balls sb_var
scoreboard players operation #o_wall_hp sb_var = #new_wall_hp sb_var
scoreboard players operation #o_speed sb_var = #new_speed sb_var
scoreboard players operation #o_recall sb_var = #new_recall sb_var
scoreboard players operation #o_depth sb_var = #new_depth sb_var
scoreboard players operation #o_shrink sb_var = #new_shrink sb_var
scoreboard players operation #o_layout sb_var = #new_layout sb_var
scoreboard players operation #o_mutant sb_var = #new_mutant sb_var

function sb:cfg/calc
scoreboard players set #rebuild_preview sb_var 0
execute unless score #prev_depth sb_var = #o_depth sb_var run scoreboard players set #rebuild_preview sb_var 1
execute unless score #prev_layout sb_var = #o_layout sb_var run scoreboard players set #rebuild_preview sb_var 1
execute unless score #prev_wall_hp sb_var = #o_wall_hp sb_var run scoreboard players set #rebuild_preview sb_var 1
execute if score #state sb_var matches 0 if score #rebuild_preview sb_var matches 1 in minecraft:overworld run function sb:arena/reset_round
execute in minecraft:overworld run function sb:cfg/lobby_board
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.8 1.5
tellraw @a [{text:"[硫方破壁] ",color:"gold"},{selector:"@s"},{text:" 更新了比赛规则设置。",color:"yellow"}]

scoreboard players operation #rem_sec sb_var = #rem_ticks sb_var
scoreboard players operation #rem_sec sb_var /= #20 sb_const
scoreboard players operation rem_sec sb_side = #rem_sec sb_var

execute if score #rem_sec sb_var matches 24 run tellraw @a [{text:"[硫方破壁] ",color:"gold",bold:true},{text:"最后 24 秒决胜阶段！场上常驻硫方怪上限 +1！",color:"yellow",bold:false}]
execute if score #rem_sec sb_var matches 1..5 run playsound minecraft:block.note_block.hat master @a[tag=sb_ingame] ~ ~ ~ 0.9 1.8

# 右键架矛达速迎击成功：修墙球保留泥砖芯，其余升档为岩浆重锤超载芯
scoreboard players set @s sb_hit_cd 6
scoreboard players set @s sb_rally 1
scoreboard players set @s sb_crossed 0
scoreboard players set @s sb_strike_side 1
execute if score #fx sb_var matches ..-1 run scoreboard players set @s sb_strike_side -1

function sb:cube/set_state_overload
scoreboard players set #spd sb_var 1180
function sb:cube/shoot_forward
data modify entity @s Motion[1] set value 0.06d

playsound minecraft:item.trident.return master @a ~ ~0.5 ~ 1.4 1.2
playsound minecraft:block.respawn_anchor.charge master @a ~ ~0.5 ~ 0.9 1.4
particle minecraft:firework ~ ~0.5 ~ 0.35 0.35 0.35 0.22 24 force
execute unless score @s sb_special matches 2 run particle minecraft:lava ~ ~0.5 ~ 0.25 0.25 0.25 0.1 10 force
execute unless score @s sb_special matches 2 run title @a[tag=sb_hitter,limit=1] actionbar {text:"⚡ 重锤迎击成功！岩浆超载破城球！",color:"gold",bold:true}
execute if score @s sb_special matches 2 run title @a[tag=sb_hitter,limit=1] actionbar {text:"🧱 修墙球迎击成功！泥砖修补芯保持不变！",color:"green",bold:true}

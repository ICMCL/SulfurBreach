# 玩家未出矛被运动球撞中身体：无伤风弹震开 + 0.8s 失衡减速（硫方怪拥有 100% 爆炸击退抗性，完全不受风弹影响）
scoreboard players set @s sb_bump_cd 16
summon wind_charge ~ ~0.25 ~ {Motion:[0.0d,-1.5d,0.0d]}
effect give @s minecraft:slowness 1 1 true
playsound minecraft:entity.breeze.wind_burst master @s ~ ~ ~ 0.85 1.35
title @s actionbar {text:"💥 被高速硫方怪撞退失衡！请挥矛拦截来球",color:"red"}

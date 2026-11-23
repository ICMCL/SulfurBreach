advancement revoke @s only sb:using_spear
execute unless entity @s[tag=sb_alive] run return 0
execute unless items entity @s weapon.mainhand minecraft:diamond_spear[minecraft:custom_data~{sb_spear:1b}] run return 0
scoreboard players set @s sb_charging 2
scoreboard players add @s sb_charge_dur 1
execute if score @s sb_charge_dur matches 1 run playsound minecraft:item.armor.equip_iron master @s ~ ~ ~ 0.65 1.5
execute if score #state sb_var matches 2 at @s run function sb:player/charge_check

execute unless score #state sb_var matches 2 run return 0
execute unless entity @s[type=player,tag=sb_alive,scores={sb_team=1..2}] run return 0
execute unless items entity @s weapon.mainhand minecraft:diamond_spear[minecraft:custom_data~{sb_spear:1b}] run return 0
function sb:player/shot_context

$summon minecraft:sulfur_cube 0 65 $(z) {Tags:["sb_ball","sb_new"],Size:1,PersistenceRequired:1b,CanPickUpLoot:0b,Glowing:1b,drop_chances:{body:0.0f}}
execute as @e[type=sulfur_cube,tag=sb_new] at @s run tp @s ~ ~0.05 ~

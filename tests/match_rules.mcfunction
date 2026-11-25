# Isolated vanilla 26.3 GameTest assertions for Sulfur Breach (sb:)
scoreboard players set #errors sb_var 0

# 1. Verify Open-Air Sunny Coast Island Stadium (zero glass lid, 26.3 sulfur neutral zone, prismarine trenches, 38 HP walls)
execute unless block 0 71 0 air run scoreboard players add #errors sb_var 1
execute unless block -2 64 0 polished_sulfur run scoreboard players add #errors sb_var 1
execute unless block 2 64 0 polished_sulfur run scoreboard players add #errors sb_var 1
execute unless block 0 64 1 chiseled_sulfur run scoreboard players add #errors sb_var 1
execute unless block -13 65 0 red_concrete run scoreboard players add #errors sb_var 1
execute unless block 13 65 0 blue_concrete run scoreboard players add #errors sb_var 1
execute unless block -14 64 0 prismarine_bricks run scoreboard players add #errors sb_var 1
execute unless block 14 64 0 prismarine_bricks run scoreboard players add #errors sb_var 1
execute unless block 0 69 -16 emerald_block run scoreboard players add #errors sb_var 1
execute unless block 0 70 -16 stone_button run scoreboard players add #errors sb_var 1
execute unless block 0 70 -15 lectern[facing=north] run scoreboard players add #errors sb_var 1
execute unless block 0 69 -14 air run scoreboard players add #errors sb_var 1
execute unless block -9 68 -15 red_concrete run scoreboard players add #errors sb_var 1
execute unless block 9 68 -15 blue_concrete run scoreboard players add #errors sb_var 1
execute unless block 0 56 0 terracotta run scoreboard players add #errors sb_var 1
execute unless block 0 58 0 chest run scoreboard players add #errors sb_var 1
execute unless score #world_ready sb_var matches 1 run scoreboard players add #errors sb_var 1
execute unless entity @e[type=text_display,tag=sb_cfg_board,limit=1] run scoreboard players add #errors sb_var 1
execute store result score #board_zm sb_var run data get entity @n[type=text_display,tag=sb_cfg_board] Pos[2] 1000
execute unless score #board_zm sb_var matches -19950..-19500 run scoreboard players add #errors sb_var 1
execute unless data entity @n[type=text_display,tag=sb_cfg_board] {billboard:"fixed"} run scoreboard players add #errors sb_var 1
execute unless score #r_hp sb_var matches 38 run scoreboard players add #errors sb_var 1
execute unless score #b_hp sb_var matches 38 run scoreboard players add #errors sb_var 1

# 2. Verify all 9 lectern config keys & packed trigger round-trip (including 3 court depth tiers + recall duration / disable!)
data modify storage sb_test:menu a set from storage sb:dlg rules.inputs[0].key
data modify storage sb_test:menu b set from storage sb:dlg rules.inputs[1].key
data modify storage sb_test:menu c set from storage sb:dlg rules.inputs[2].key
data modify storage sb_test:menu d set from storage sb:dlg rules.inputs[3].key
data modify storage sb_test:menu e set from storage sb:dlg rules.inputs[4].key
data modify storage sb_test:menu f set from storage sb:dlg rules.inputs[5].key
data modify storage sb_test:menu g set from storage sb:dlg rules.inputs[6].key
data modify storage sb_test:menu h set from storage sb:dlg rules.inputs[7].key
data modify storage sb_test:menu i set from storage sb:dlg rules.inputs[8].key
execute unless data storage sb_test:menu {a:"du",b:"ba",c:"hp",d:"sp",e:"rc",f:"dp",g:"sh",h:"la",i:"mu"} run scoreboard players add #errors sb_var 1
execute if data storage sb:dlg rules.inputs[9] run scoreboard players add #errors sb_var 1

summon armor_stand 0 65 0 {Tags:["sb_test_host"],NoGravity:1b}
scoreboard players set @e[tag=sb_test_host] sb_set 1222222011
execute as @e[tag=sb_test_host] run function sb:cfg/apply_rules
execute unless score #cfg_dur sb_var matches 180 run scoreboard players add #errors sb_var 1
execute unless score #cfg_balls sb_var matches 3 run scoreboard players add #errors sb_var 1
execute unless score #col_max_hp sb_var matches 3 run scoreboard players add #errors sb_var 1
execute unless score #wall_max_hp sb_var matches 57 run scoreboard players add #errors sb_var 1
execute unless score #speed_pct sb_var matches 125 run scoreboard players add #errors sb_var 1
execute unless score #cfg_recall_sec sb_var matches 8 run scoreboard players add #errors sb_var 1
execute unless score #cfg_recall_ticks sb_var matches 160 run scoreboard players add #errors sb_var 1
execute unless score #o_depth sb_var matches 2 run scoreboard players add #errors sb_var 1
execute unless score #cfg_wall_x sb_var matches 19 run scoreboard players add #errors sb_var 1
execute unless score #cfg_base_x sb_var matches 20 run scoreboard players add #errors sb_var 1
execute unless score #cfg_court_len sb_var matches 41 run scoreboard players add #errors sb_var 1
execute unless score #r_wall_x sb_var matches -19 run scoreboard players add #errors sb_var 1
execute unless score #b_wall_x sb_var matches 19 run scoreboard players add #errors sb_var 1
execute unless block -19 65 0 red_concrete run scoreboard players add #errors sb_var 1
execute unless block 19 65 0 blue_concrete run scoreboard players add #errors sb_var 1
execute unless block -20 64 0 prismarine_bricks run scoreboard players add #errors sb_var 1
execute unless block 20 64 0 prismarine_bricks run scoreboard players add #errors sb_var 1
execute unless block -21 65 0 cut_sandstone run scoreboard players add #errors sb_var 1
execute unless block 21 65 0 cut_sandstone run scoreboard players add #errors sb_var 1
execute unless block -13 65 0 air run scoreboard players add #errors sb_var 1
execute unless block 13 65 0 air run scoreboard players add #errors sb_var 1
execute unless score #o_shrink sb_var matches 0 run scoreboard players add #errors sb_var 1
execute unless score #o_layout sb_var matches 1 run scoreboard players add #errors sb_var 1
execute unless score #o_mutant sb_var matches 1 run scoreboard players add #errors sb_var 1

scoreboard players set @e[tag=sb_test_host] sb_set 1111131000
execute as @e[tag=sb_test_host] run function sb:cfg/apply_rules
execute unless score #cfg_recall_sec sb_var matches 0 run scoreboard players add #errors sb_var 1
execute unless score #cfg_recall_ticks sb_var matches 0 run scoreboard players add #errors sb_var 1
execute unless score #o_depth sb_var matches 1 run scoreboard players add #errors sb_var 1
execute unless score #cfg_wall_x sb_var matches 16 run scoreboard players add #errors sb_var 1
execute unless score #cfg_court_len sb_var matches 35 run scoreboard players add #errors sb_var 1
execute unless score #r_wall_x sb_var matches -16 run scoreboard players add #errors sb_var 1
execute unless score #b_wall_x sb_var matches 16 run scoreboard players add #errors sb_var 1
execute unless block -16 65 0 red_concrete run scoreboard players add #errors sb_var 1
execute unless block 16 65 0 blue_concrete run scoreboard players add #errors sb_var 1
execute unless block -17 64 0 prismarine_bricks run scoreboard players add #errors sb_var 1
execute unless block 17 64 0 prismarine_bricks run scoreboard players add #errors sb_var 1
execute unless block -18 65 0 cut_sandstone run scoreboard players add #errors sb_var 1
execute unless block 18 65 0 cut_sandstone run scoreboard players add #errors sb_var 1
execute unless block -19 66 0 smooth_sandstone run scoreboard players add #errors sb_var 1
execute unless block 19 66 0 smooth_sandstone run scoreboard players add #errors sb_var 1
execute unless data storage sb:cfg {txt:{recall:"关闭(不回中)",depth:"加长(+3/侧·35×21)"}} run scoreboard players add #errors sb_var 1
kill @e[tag=sb_test_host]
function sb:cfg/defaults
execute unless score #o_depth sb_var matches 0 run scoreboard players add #errors sb_var 1
execute unless score #cfg_wall_x sb_var matches 13 run scoreboard players add #errors sb_var 1
execute unless score #cfg_dur sb_var matches 120 run scoreboard players add #errors sb_var 1
execute unless score #cfg_recall_ticks sb_var matches 60 run scoreboard players add #errors sb_var 1
execute unless score #wall_max_hp sb_var matches 38 run scoreboard players add #errors sb_var 1

# 3. Activate match state and test neutral-zone wandering soft fence (State 0)
function sb:arena/reset_round
scoreboard players set #state sb_var 2
scoreboard players set #solo_mode sb_var 1
scoreboard players set #cur_balls sb_var 7
function sb:cube/spawner_step
execute unless score #cur_balls sb_var matches 0 run scoreboard players add #errors sb_var 1
function sb:cube/spawn_one
execute unless entity @e[type=sulfur_cube,tag=sb_ball,scores={sb_state=0},limit=1] run scoreboard players add #errors sb_var 1
tag @e[type=sulfur_cube,tag=sb_ball,limit=1] add sb_tball
tp @e[tag=sb_tball] -1.9 65.05 0.5
execute as @e[tag=sb_tball] at @s run function sb:cube/step
execute store result score #tx sb_var run data get entity @n[tag=sb_tball] Pos[0] 1000
execute unless score #tx sb_var matches -1450..2450 run scoreboard players add #errors sb_var 1
tp @e[tag=sb_tball] 2.9 65.05 0.5
execute as @e[tag=sb_tball] at @s run function sb:cube/step
execute store result score #tx sb_var run data get entity @n[tag=sb_tball] Pos[0] 1000
execute unless score #tx sb_var matches -1450..2450 run scoreboard players add #errors sb_var 1

# 4. Cross-midline 3-rally escalation & indiscriminate Charge parry
tp @e[tag=sb_tball] 0.0 65.05 0.5
scoreboard players set #fx sb_var 1000
scoreboard players set #fz sb_var 0
execute as @e[tag=sb_tball] at @s run function sb:cube/on_jab_hit
execute unless entity @e[tag=sb_tball,scores={sb_state=1,sb_rally=1,sb_vx=850}] run scoreboard players add #errors sb_var 1

# Same-direction pass after crossing must NOT inflate rally count
scoreboard players set @e[tag=sb_tball] sb_hit_cd 0
tp @e[tag=sb_tball] 2.0 65.05 0.5
execute as @e[tag=sb_tball] at @s run function sb:cube/step
execute unless entity @e[tag=sb_tball,scores={sb_crossed=1}] run scoreboard players add #errors sb_var 1
execute as @e[tag=sb_tball] at @s run function sb:cube/on_jab_hit
execute unless entity @e[tag=sb_tball,scores={sb_state=1,sb_rally=1}] run scoreboard players add #errors sb_var 1

# Cross-midline return #2 -> rally=2 (still iron_block)
tp @e[tag=sb_tball] 2.0 65.05 0.5
execute as @e[tag=sb_tball] at @s run function sb:cube/step
scoreboard players set @e[tag=sb_tball] sb_hit_cd 0
scoreboard players set #fx sb_var -1000
execute as @e[tag=sb_tball] at @s run function sb:cube/on_jab_hit
execute unless entity @e[tag=sb_tball,scores={sb_state=1,sb_rally=2,sb_vx=-850}] run scoreboard players add #errors sb_var 1

# Cross-midline return #3 -> rally=3 -> auto-upgrades to State 2 (magma_block overload!)
tp @e[tag=sb_tball] -1.0 65.05 0.5
execute as @e[tag=sb_tball] at @s run function sb:cube/step
scoreboard players set @e[tag=sb_tball] sb_hit_cd 0
scoreboard players set #fx sb_var 1000
execute as @e[tag=sb_tball] at @s run function sb:cube/on_jab_hit
execute unless entity @e[tag=sb_tball,scores={sb_state=2,sb_rally=3,sb_vx=1150}] run scoreboard players add #errors sb_var 1

# Left-click cushion on an early Charge shot calms State 2 back down to State 1!
scoreboard players set @e[tag=sb_tball] sb_hit_cd 0
scoreboard players set @e[tag=sb_tball] sb_state 1
scoreboard players set #fx sb_var -1000
scoreboard players set #pvx sb_var 0
scoreboard players set #pvz sb_var 0
execute as @e[tag=sb_tball] run data modify entity @s Motion set value [0.274d,0.0d,0.0d]
execute as @e[tag=sb_tball] at @s run function sb:cube/try_charge_hit
execute unless entity @e[tag=sb_tball,scores={sb_state=1}] run scoreboard players add #errors sb_var 1
execute as @e[tag=sb_tball] run data modify entity @s Motion set value [0.275d,0.0d,0.0d]
execute as @e[tag=sb_tball] at @s run function sb:cube/try_charge_hit
execute unless entity @e[tag=sb_tball,scores={sb_state=2,sb_rally=1,sb_vx=-1180}] run scoreboard players add #errors sb_var 1

tp @e[tag=sb_tball] -1.0 65.05 0.5
execute as @e[tag=sb_tball] at @s run function sb:cube/step
scoreboard players set @e[tag=sb_tball] sb_hit_cd 0
scoreboard players set #fx sb_var 1000
execute as @e[tag=sb_tball] at @s run function sb:cube/on_jab_hit
execute unless entity @e[tag=sb_tball,scores={sb_state=1,sb_rally=2}] run scoreboard players add #errors sb_var 1

# 5. Indiscriminate Wall Damage, Spent State 3 Rebound, Breach Destruction, Heavy 3-Col Smash & Baseline Overload
# Normal hit on Red Wall (z=0): 2 HP -> 1 HP glazed terracotta, ball turns State 3 (tuff) & does NOT re-damage on next tick!
tp @e[tag=sb_tball] -11.49 65.05 0.5
execute as @e[tag=sb_tball] at @s run function sb:cube/step
execute unless score #r_hp sb_var matches 37 run scoreboard players add #errors sb_var 1
execute unless block -13 65 0 red_glazed_terracotta run scoreboard players add #errors sb_var 1
execute unless entity @e[tag=sb_tball,scores={sb_state=3}] run scoreboard players add #errors sb_var 1
tp @e[tag=sb_tball] -11.49 65.05 0.5
execute as @e[tag=sb_tball] at @s run function sb:cube/step
execute unless score #r_hp sb_var matches 37 run scoreboard players add #errors sb_var 1

# Second normal hit on Red Wall (z=0): 1 HP -> 0 HP air gap (barrier kept at y=67), ball destroyed!
execute as @e[tag=sb_tball] run function sb:cube/set_state_iron
tp @e[tag=sb_tball] -11.49 65.05 0.5
execute as @e[tag=sb_tball] at @s run function sb:cube/step
execute unless score #r_hp sb_var matches 36 run scoreboard players add #errors sb_var 1
execute unless block -13 65 0 air run scoreboard players add #errors sb_var 1
execute unless block -13 67 0 barrier run scoreboard players add #errors sb_var 1
execute if entity @e[tag=sb_tball] run scoreboard players add #errors sb_var 1

# 5B. Radius-bounded Backboard Shockwave (R=2 normal / R=3 heavy) & Bare-Backboard Bounce!
# First normal ball flying into 0 HP gap at z=0: does NOT clip z=+-1 on entry; hitting backboard at -13.45 damages ONLY z=-2,-1,+1,+2 (-4 HP -> 32), leaving z=+-3 intact!
function sb:cube/spawn_one
tag @e[type=sulfur_cube,tag=sb_ball,limit=1] add sb_leak_ball
execute as @e[tag=sb_leak_ball] run function sb:cube/set_state_iron
scoreboard players set @e[tag=sb_leak_ball] sb_vx -850
execute as @e[tag=sb_leak_ball] run data modify entity @s Motion set value [-0.85d,0.0d,0.0d]
tp @e[tag=sb_leak_ball] -11.49 65.05 0.5
execute as @e[tag=sb_leak_ball] at @s run function sb:cube/step
execute unless entity @e[tag=sb_leak_ball] run scoreboard players add #errors sb_var 1
execute unless score #r_hp sb_var matches 36 run scoreboard players add #errors sb_var 1
tp @e[tag=sb_leak_ball] -13.45 65.05 0.5
execute as @e[tag=sb_leak_ball] at @s run function sb:cube/step
execute if entity @e[tag=sb_leak_ball] run scoreboard players add #errors sb_var 1
execute unless score #r_hp sb_var matches 32 run scoreboard players add #errors sb_var 1
execute unless block -13 65 -2 red_glazed_terracotta run scoreboard players add #errors sb_var 1
execute unless block -13 65 2 red_glazed_terracotta run scoreboard players add #errors sb_var 1
execute unless block -13 65 -3 red_concrete run scoreboard players add #errors sb_var 1
execute unless block -13 65 3 red_concrete run scoreboard players add #errors sb_var 1

# Second normal ball at z=0 breaks z=-2,-1,+1,+2 to 0 HP (32 -> 28 HP); z=-2..+2 is now a 5-wide empty breach!
function sb:cube/spawn_one
tag @e[type=sulfur_cube,tag=sb_ball,limit=1] add sb_leak_ball2
execute as @e[tag=sb_leak_ball2] run function sb:cube/set_state_iron
tp @e[tag=sb_leak_ball2] -13.45 65.05 0.5
execute as @e[tag=sb_leak_ball2] at @s run function sb:cube/step
execute if entity @e[tag=sb_leak_ball2] run scoreboard players add #errors sb_var 1
execute unless score #r_hp sb_var matches 28 run scoreboard players add #errors sb_var 1
execute unless block -13 65 -2 air run scoreboard players add #errors sb_var 1
execute unless block -13 65 2 air run scoreboard players add #errors sb_var 1
execute unless block -13 65 -3 red_concrete run scoreboard players add #errors sb_var 1
execute unless block -13 65 3 red_concrete run scoreboard players add #errors sb_var 1

# Third normal ball (R=2) hitting bare backboard at z=0 (0 surviving cols in [-2..+2]): 0 HP deducted & bounces back eastward at 95% speed!
function sb:cube/spawn_one
tag @e[type=sulfur_cube,tag=sb_ball,limit=1] add sb_bounce_ball
execute as @e[tag=sb_bounce_ball] run function sb:cube/set_state_iron
scoreboard players set @e[tag=sb_bounce_ball] sb_vx -800
execute as @e[tag=sb_bounce_ball] run data modify entity @s Motion set value [-0.80d,0.0d,0.0d]
tp @e[tag=sb_bounce_ball] -13.45 65.05 0.5
execute as @e[tag=sb_bounce_ball] at @s run function sb:cube/step
execute unless entity @e[tag=sb_bounce_ball,scores={sb_state=1,sb_vx=760,sb_back_cd=8}] run scoreboard players add #errors sb_var 1
execute unless score #r_hp sb_var matches 28 run scoreboard players add #errors sb_var 1
tp @e[tag=sb_bounce_ball] -11.49 65.05 2.5
execute as @e[tag=sb_bounce_ball] at @s run function sb:cube/step
execute unless entity @e[tag=sb_bounce_ball,scores={sb_state=1}] run scoreboard players add #errors sb_var 1
execute unless score #r_hp sb_var matches 28 run scoreboard players add #errors sb_var 1

# Heavy Overload ball (R=3) hitting backboard at z=0 DOES reach z=-3 and z=+3 (-2 HP -> 26 HP), while leaving z=+-4 intact!
execute as @e[tag=sb_bounce_ball] run function sb:cube/set_state_overload
scoreboard players set @e[tag=sb_bounce_ball] sb_back_cd 0
tp @e[tag=sb_bounce_ball] -13.45 65.05 0.5
execute as @e[tag=sb_bounce_ball] at @s run function sb:cube/step
execute if entity @e[tag=sb_bounce_ball] run scoreboard players add #errors sb_var 1
execute unless score #r_hp sb_var matches 26 run scoreboard players add #errors sb_var 1
execute unless block -13 65 -3 red_glazed_terracotta run scoreboard players add #errors sb_var 1
execute unless block -13 65 3 red_glazed_terracotta run scoreboard players add #errors sb_var 1
execute unless block -13 65 -4 red_concrete run scoreboard players add #errors sb_var 1
execute unless block -13 65 4 red_concrete run scoreboard players add #errors sb_var 1

# Heavy Overload hit on Blue Wall (z=0): center -2 HP (air) + z=-1 & z=+1 each -1 HP (38 -> 34 HP)
function sb:cube/spawn_one
tag @e[type=sulfur_cube,tag=sb_ball,limit=1] add sb_heavy_ball
execute as @e[tag=sb_heavy_ball] run function sb:cube/set_state_overload
tp @e[tag=sb_heavy_ball] 12.49 65.05 0.5
execute as @e[tag=sb_heavy_ball] at @s run function sb:cube/step
execute if entity @e[tag=sb_heavy_ball] run scoreboard players add #errors sb_var 1
execute unless score #b_hp sb_var matches 34 run scoreboard players add #errors sb_var 1
execute unless block 13 65 0 air run scoreboard players add #errors sb_var 1
execute unless block 13 65 -1 blue_glazed_terracotta run scoreboard players add #errors sb_var 1
execute unless block 13 65 1 blue_glazed_terracotta run scoreboard players add #errors sb_var 1

# Mud-bricks repair ball heals 2 HP on whichever wall it hits (34 -> 36 HP on Blue wall!)
function sb:cube/spawn_one
tag @e[type=sulfur_cube,tag=sb_ball,limit=1] add sb_rep_ball
scoreboard players set @e[tag=sb_rep_ball] sb_special 2
execute as @e[tag=sb_rep_ball] run function sb:cube/set_state_iron

# Repair core survives Charge, a third cross-midline rally, and direct overload transitions.
scoreboard players set #fx sb_var -1000
scoreboard players set #fz sb_var 0
execute as @e[tag=sb_rep_ball] at @s run function sb:cube/on_charge_hit
execute unless entity @e[tag=sb_rep_ball,team=sb_repair,scores={sb_state=1,sb_special=2,sb_vx=-1180}] run scoreboard players add #errors sb_var 1
scoreboard players set @e[tag=sb_rep_ball] sb_hit_cd 0
scoreboard players set @e[tag=sb_rep_ball] sb_rally 2
scoreboard players set @e[tag=sb_rep_ball] sb_crossed 1
scoreboard players set #fx sb_var 1000
execute as @e[tag=sb_rep_ball] at @s run function sb:cube/on_jab_hit
execute unless entity @e[tag=sb_rep_ball,team=sb_repair,scores={sb_state=1,sb_special=2,sb_rally=3,sb_vx=850}] run scoreboard players add #errors sb_var 1
execute as @e[tag=sb_rep_ball] run function sb:cube/set_state_overload
execute unless entity @e[tag=sb_rep_ball,team=sb_repair,scores={sb_state=1,sb_special=2}] run scoreboard players add #errors sb_var 1
tp @e[tag=sb_rep_ball] 13.60 65.05 0.5
execute as @e[tag=sb_rep_ball] at @s run function sb:cube/step
execute unless score #b_hp sb_var matches 36 run scoreboard players add #errors sb_var 1

# 6. Test all 5 stages of Dual-Wall Push (Scheme A): preserves 26 Red HP & 36 Blue HP, breaches, & 5-block neutral zone!
function sb:arena/push_step
function sb:arena/push_step
function sb:arena/push_step
function sb:arena/push_step
function sb:arena/push_step
execute unless score #push_stage sb_var matches 5 run scoreboard players add #errors sb_var 1
execute unless score #r_wall_x sb_var matches -8 run scoreboard players add #errors sb_var 1
execute unless score #b_wall_x sb_var matches 8 run scoreboard players add #errors sb_var 1
execute unless score #r_hp sb_var matches 26 run scoreboard players add #errors sb_var 1
execute unless score #b_hp sb_var matches 36 run scoreboard players add #errors sb_var 1
execute unless block -8 65 0 air run scoreboard players add #errors sb_var 1
execute unless block -9 64 0 prismarine_bricks run scoreboard players add #errors sb_var 1
execute unless block -10 65 0 cut_sandstone run scoreboard players add #errors sb_var 1
execute unless block -2 64 0 polished_sulfur run scoreboard players add #errors sb_var 1
execute unless block 2 64 0 polished_sulfur run scoreboard players add #errors sb_var 1

# 7. Test Sudden Death on tied HP timeout, followed by single-hit victory!
function sb:arena/reset_round
scoreboard players set #state sb_var 2
scoreboard players set #solo_mode sb_var 1
function sb:game/timeout_judge
execute unless score #state sb_var matches 2 run scoreboard players add #errors sb_var 1
execute unless score #sudden_death sb_var matches 1 run scoreboard players add #errors sb_var 1
function sb:cube/spawn_one
tag @e[type=sulfur_cube,tag=sb_ball,limit=1] add sb_sd_ball
execute as @e[tag=sb_sd_ball] run function sb:cube/set_state_iron
tp @e[tag=sb_sd_ball] 12.49 65.05 0.5
execute as @e[tag=sb_sd_ball] at @s run function sb:cube/step
execute unless score #state sb_var matches 0 run scoreboard players add #errors sb_var 1
execute unless data storage sb:game {result:{color:"red"}} run scoreboard players add #errors sb_var 1

# 8. Test extended depth tiers (+3 -> +-16 walls, +6 -> +-19 walls) wall hit & Dual-Wall Push!
scoreboard players set #o_depth sb_var 2
function sb:arena/reset_round
scoreboard players set #state sb_var 2
scoreboard players set #solo_mode sb_var 1
function sb:cube/spawn_one
tag @e[type=sulfur_cube,tag=sb_ball,limit=1] add sb_deep_ball
execute as @e[tag=sb_deep_ball] run function sb:cube/set_state_iron
tp @e[tag=sb_deep_ball] 18.49 65.05 0.5
execute as @e[tag=sb_deep_ball] at @s run function sb:cube/step
execute unless score #b_hp sb_var matches 37 run scoreboard players add #errors sb_var 1
execute unless block 19 65 0 blue_glazed_terracotta run scoreboard players add #errors sb_var 1
function sb:arena/push_step
execute unless score #r_wall_x sb_var matches -18 run scoreboard players add #errors sb_var 1
execute unless score #b_wall_x sb_var matches 18 run scoreboard players add #errors sb_var 1
execute unless block 18 65 0 blue_glazed_terracotta run scoreboard players add #errors sb_var 1

# Just inside the new blue front there is no hit; the exact front is inclusive.
execute as @e[tag=sb_deep_ball] run function sb:cube/set_state_iron
tp @e[tag=sb_deep_ball] 17.34 65.05 0.5
execute as @e[tag=sb_deep_ball] at @s run function sb:cube/step
execute unless score #b_hp sb_var matches 37 run scoreboard players add #errors sb_var 1
tp @e[tag=sb_deep_ball] 17.35 65.05 0.5
execute as @e[tag=sb_deep_ball] at @s run function sb:cube/step
execute unless score #b_hp sb_var matches 36 run scoreboard players add #errors sb_var 1
execute if entity @e[tag=sb_deep_ball] run scoreboard players add #errors sb_var 1

# A ball already inside a bare blue trench rebounds west before the next push,
# even if it was still moving east; use the larger of live and cached speeds.
scoreboard players set @e[type=marker,tag=sb_wblue,scores={sb_col=-2..2}] sb_hp 0
execute as @e[type=marker,tag=sb_wblue,scores={sb_col=-2..2}] at @s run function sb:arena/col_render
function sb:cube/spawn_one
tag @n[type=sulfur_cube,tag=sb_ball] add sb_trench_ball
execute as @e[tag=sb_trench_ball] run function sb:cube/set_state_iron
tp @e[tag=sb_trench_ball] 18.6 65.05 0.5
scoreboard players set @e[tag=sb_trench_ball] sb_vx 500
execute as @e[tag=sb_trench_ball] run data modify entity @s Motion[0] set value 1.0d
execute as @e[tag=sb_trench_ball] at @s run function sb:cube/settle_trench
execute unless entity @e[tag=sb_trench_ball,scores={sb_vx=-950,sb_back_cd=8}] run scoreboard players add #errors sb_var 1

function sb:cube/spawn_one
scoreboard players set #cur_balls sb_var 0
function sb:cube/spawner_step
execute unless score #cur_balls sb_var matches 2 run scoreboard players add #errors sb_var 1
function sb:game/stop
function sb:cfg/defaults
function sb:arena/reset_round

execute if score #errors sb_var matches 0 run say SB_RULES_OK
execute unless score #errors sb_var matches 0 run say SB_RULES_FAILED

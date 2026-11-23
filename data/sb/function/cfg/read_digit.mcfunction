$scoreboard players operation #new_$(key) sb_var = #n sb_var
$scoreboard players operation #new_$(key) sb_var %= #10 sb_const
$execute unless score #new_$(key) sb_var matches 0..$(max) run scoreboard players set #bad_rule sb_var 1
scoreboard players operation #n sb_var /= #10 sb_const

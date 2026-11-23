$execute store result storage sb:dlgtmp o.i int 1 run scoreboard players get $(s) sb_var
$data modify storage sb:dlgtmp o.n set value $(n)
function sb:cfg/setopt2 with storage sb:dlgtmp o

$data modify storage sb:tmp list set from storage sb:inv p.p$(id).inv
$data modify storage sb:tmp eq set from storage sb:inv p.p$(id).eq
$data remove storage sb:inv p.p$(id)

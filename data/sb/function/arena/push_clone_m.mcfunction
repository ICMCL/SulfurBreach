# 原样迁移红蓝两面 19 列守护墙（含残砖、缺口与顶部屏障），重建海岸底线槽并以低矮砂岩城垛封实旧外墙（保持露天开阔视野）
$clone $(orw) 65 -10 $(orw) 70 10 $(nrw) 65 -10 replace move
$fill $(nrw) 64 -10 $(nrw) 64 10 chiseled_sandstone
$fill $(nrb) 64 -10 $(nrb) 64 10 prismarine_bricks
$fill $(nrb) 65 -9 $(nrb) 70 9 air
$fill $(nrb) 65 -10 $(nrb) 67 -10 cut_sandstone
$fill $(nrb) 65 10 $(nrb) 67 10 cut_sandstone
$fill $(nrb) 68 -10 $(nrb) 70 -10 barrier
$fill $(nrb) 68 10 $(nrb) 70 10 barrier
$fill $(orb) 64 -10 $(orb) 67 10 cut_sandstone
$fill $(orb) 66 -9 $(orb) 66 9 chiseled_sandstone
$fill $(orb) 68 -10 $(orb) 68 10 polished_sulfur
$setblock $(orb) 66 0 ochre_froglight
$fill $(orb) 69 -10 $(orb) 70 10 barrier

$clone $(obw) 65 -10 $(obw) 70 10 $(nbw) 65 -10 replace move
$fill $(nbw) 64 -10 $(nbw) 64 10 chiseled_sandstone
$fill $(nbb) 64 -10 $(nbb) 64 10 prismarine_bricks
$fill $(nbb) 65 -9 $(nbb) 70 9 air
$fill $(nbb) 65 -10 $(nbb) 67 -10 cut_sandstone
$fill $(nbb) 65 10 $(nbb) 67 10 cut_sandstone
$fill $(nbb) 68 -10 $(nbb) 70 -10 barrier
$fill $(nbb) 68 10 $(nbb) 70 10 barrier
$fill $(obb) 64 -10 $(obb) 67 10 cut_sandstone
$fill $(obb) 66 -9 $(obb) 66 9 chiseled_sandstone
$fill $(obb) 68 -10 $(obb) 68 10 polished_sulfur
$setblock $(obb) 66 0 ochre_froglight
$fill $(obb) 69 -10 $(obb) 70 10 barrier

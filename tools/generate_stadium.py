"""Procedural voxel builder for Sulfur Breach's Open-Air Sunny Coast Island Stadium.

Writes the island, lagoons, palm trees, bastions, bleachers, and lobby directly into
Minecraft 26.3 Anvil `.mca` chunks (`world/`), and generates only the inner-court
floor reset function (`data/sb/function/arena/floor.mcfunction`) for the bound datapack.
"""
from __future__ import annotations
import math
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
for _cand in (ROOT.parent / "mcbeef" / "src", ROOT.parent / "mcbeef", ROOT.parent):
    if (_cand / "mcbeef" / "__init__.py").is_file() and str(_cand) not in sys.path:
        sys.path.insert(0, str(_cand))

from mcbeef.anvil import write_world_save
from mcbeef.builder import VoxelBuilder


def build_island_and_surrounds(b: VoxelBuilder) -> list[str]:
    b.cmds.append("# ===== 晴空海岸浮空岛屿、碧海珊瑚礁、椰林、东西守城门楼与南侧遮阳看台 =====")

    # 1. Organic tapered sandstone cliff island (y = 52 .. 63), centered at (0, -2.5)
    # Generously scaled (~87×63 blocks) so the 3-tier stadium, widened lobby & bleachers sit amidst wide beaches & lagoons!
    for y in range(52, 64):
        grow = (y - 52) / 11.0  # 0.0 at deep cliff base -> 1.0 at top beach level y=63
        rx = 21.0 + 22.0 * (grow ** 0.58)  # up to 43.0 at y=63
        rz = 15.5 + 15.5 * (grow ** 0.58)  # up to 31.0 at y=63
        if y <= 57:
            mat = "terracotta"
        elif y <= 59:
            mat = "sandstone"
        elif y <= 61:
            mat = "smooth_sandstone"
        elif y == 62:
            mat = "cut_sandstone"
        else:
            mat = "sand"

        for z in range(-34, 30):
            dz = (z + 2.5) / rz
            if abs(dz) > 1.0:
                continue
            # Subtle organic coastal wave modulation
            wobble = 0.06 * math.sin(z * 0.38) + 0.04 * math.cos(z * 0.72)
            rem = max(0.0, 1.0 + wobble - dz * dz)
            if rem <= 0.0:
                continue
            half_x = int(math.floor(rx * math.sqrt(rem)))
            if half_x >= 1:
                b.fill(-half_x, y, z, half_x, y, z, mat)

    # Smooth sandstone inner resort promenade apron around stadium, wide North plaza & South bleachers at y=63
    b.fill(-28, 63, -25, 28, 63, 17, "smooth_sandstone")

    # 2. Sparkling Turquoise Lagoon Pools & Coral Reefs on West/East/South/North beaches (y=62..63)
    lagoons = [
        # Wide West & East tropical coral coves
        (-36, -29, -8, 8),
        (29, 36, -8, 8),
        # North-West & North-East coastal tide pools flanking the grand lobby
        (-31, -25, -21, -15),
        (25, 31, -21, -15),
        # South-West, South-Center & South-East sunny coral tide pools behind bleachers
        (-23, -15, 18, 22),
        (-9, 9, 18, 23),
        (15, 23, 18, 22),
    ]
    for lx1, lx2, lz1, lz2 in lagoons:
        b.fill(lx1, 62, lz1, lx2, 62, lz2, "prismarine")
        b.setblock((lx1 + lx2) // 2, 62, (lz1 + lz2) // 2, "ochre_froglight")
        b.fill(lx1, 63, lz1, lx2, 63, lz2, "water")
        # Coral & sea-lantern accents inside lagoon bed
        b.setblock(lx1 + 1, 62, lz1 + 1, "tube_coral_block")
        b.setblock(lx2 - 1, 62, lz2 - 1, "brain_coral_block")
        b.setblock(lx1 + 1, 62, lz2 - 1, "horn_coral_block")
        b.setblock(lx2 - 1, 62, lz1 + 1, "fire_coral_block")

    # Hidden inventory stash vault safely encased beneath court center
    b.fill(-1, 57, -1, 1, 59, 1, "smooth_sandstone")
    b.setblock(0, 58, 0, "chest")

    # 3. West Red Fortress Bastion & East Blue Fortress Bastion (x = -24..-21 & +21..+24)
    for side, sign, accent, roof_mat in (
        ("red", -1, "red_terracotta", "red_concrete"),
        ("blue", 1, "light_blue_terracotta", "blue_concrete"),
    ):
        bx_in = 21 * sign
        bx_out = 24 * sign
        x_lo, x_hi = min(bx_in, bx_out), max(bx_in, bx_out)

        # Raised bastion terrace behind outer backboard
        b.fill(x_lo, 64, -11, x_hi, 66, 11, "smooth_sandstone")
        b.fill(x_lo, 67, -8, x_hi, 67, 8, "cut_sandstone")
        # Team emblem mosaic behind backboard
        b.fill(22 * sign, 67, -5, 23 * sign, 67, 5, accent)
        b.fill(22 * sign, 67, -1, 23 * sign, 67, 1, "polished_sulfur")

        # Twin coastal watchtowers at z = -11..-8 and z = +8..+11
        for tz1, tz2 in ((-11, -8), (8, 11)):
            b.fill(x_lo, 64, tz1, x_hi, 71, tz2, "smooth_sandstone")
            # Corner cut_sandstone quoins
            for cx in (x_lo, x_hi):
                for cz in (tz1, tz2):
                    b.fill(cx, 64, cz, cx, 71, cz, "cut_sandstone")
            # Decorative frieze & glowing beacon window
            b.fill(x_lo, 68, tz1, x_hi, 68, tz2, "chiseled_sandstone")
            b.fill(x_lo, 70, tz1 + 1, x_hi, 70, tz2 - 1, accent)
            b.setblock((x_lo + x_hi) // 2, 70, (tz1 + tz2) // 2, "ochre_froglight")
            # Striped coastal cupola roof (y = 72..74)
            b.fill(x_lo - (1 if sign < 0 else 0), 72, tz1 - 1, x_hi + (1 if sign > 0 else 0), 72, tz2 + 1, roof_mat)
            b.fill(x_lo, 73, tz1, x_hi, 73, tz2, "white_concrete")
            b.fill(x_lo + (1 if sign < 0 else 0), 74, tz1 + 1, x_hi - (1 if sign > 0 else 0), 74, tz2 - 1, roof_mat)
            b.setblock((x_lo + x_hi) // 2, 75, (tz1 + tz2) // 2, "polished_sulfur")

        # Decorative sandstone triumphal arch spanning between the two watchtowers (z = -7..+7, y = 71..72)
        b.fill(22 * sign, 68, -7, 22 * sign, 71, -7, "cut_sandstone")
        b.fill(22 * sign, 68, 7, 22 * sign, 71, 7, "cut_sandstone")
        b.fill(22 * sign, 71, -7, 22 * sign, 71, 7, "cut_sandstone")
        b.fill(22 * sign, 72, -4, 22 * sign, 72, 4, accent)
        b.fill(22 * sign, 72, -1, 22 * sign, 72, 1, "polished_sulfur")

    # 4. Full-Span South Stepped Sunlit Bleachers & Striped Mediterranean Sun-Pergola (z = 12..16, x = -19..+19)
    b.fill(-19, 64, 12, 19, 65, 15, "smooth_sandstone")
    b.fill(-18, 66, 12, 18, 66, 12, "birch_planks")
    b.fill(-18, 66, 13, 18, 66, 15, "smooth_sandstone")
    b.fill(-18, 67, 13, 18, 67, 13, "birch_planks")
    b.fill(-18, 67, 14, 18, 67, 15, "smooth_sandstone")
    b.fill(-18, 68, 14, 18, 68, 14, "birch_planks")
    b.fill(-19, 68, 15, 19, 68, 15, "cut_sandstone")
    b.fill(-18, 69, 15, 18, 69, 15, "azalea_leaves[persistent=true]")
    for fx in (-15, -9, -3, 3, 9, 15):
        b.setblock(fx, 69, 15, "flowering_azalea_leaves[persistent=true]")

    # Pergola timber posts & sunny coral-orange / white awning at y = 72 spanning full South stand
    for px in (-18, -12, -6, 0, 6, 12, 18):
        b.fill(px, 66, 12, px, 71, 12, "stripped_birch_log")
        b.fill(px, 69, 15, px, 71, 15, "stripped_birch_log")
    for x in range(-19, 20):
        stripe = "orange_terracotta" if (x // 2) % 2 == 0 else "white_concrete"
        b.fill(x, 72, 12, x, 72, 15, stripe)
    b.fill(-19, 72, 11, 19, 72, 11, "bamboo_mosaic")

    # 5. Ten Curved Tropical Coconut Palm Trees framing the wide beaches, lagoons & plaza flanks
    b.add_palm_tree(-26, 64, -24, lean_x=-2, lean_z=-1, height=8)
    b.add_palm_tree(26, 64, -24, lean_x=2, lean_z=-1, height=8)
    b.add_palm_tree(-34, 64, -12, lean_x=-2, lean_z=-1, height=8)
    b.add_palm_tree(34, 64, -12, lean_x=2, lean_z=-1, height=8)
    b.add_palm_tree(-38, 64, 0, lean_x=-2, lean_z=0, height=7)
    b.add_palm_tree(38, 64, 0, lean_x=2, lean_z=0, height=7)
    b.add_palm_tree(-32, 64, 12, lean_x=-2, lean_z=2, height=8)
    b.add_palm_tree(32, 64, 12, lean_x=2, lean_z=2, height=8)
    b.add_palm_tree(-12, 64, 24, lean_x=-1, lean_z=2, height=7)
    b.add_palm_tree(12, 64, 24, lean_x=1, lean_z=2, height=7)

    return b.clear_cmds()


def build_perimeter(b: VoxelBuilder) -> list[str]:
    b.cmds.append("# ===== 露天开阔低矮高弹边墙 (x=-21..+21 兼容三档纵深，y=65..67 实体围板 + y=68..70 隐形屏障) =====")
    # North & South low bounce boards spanning full max court width (x = -21 .. +21, 3 blocks tall: y=65..67)
    b.fill(-21, 64, -11, 21, 65, -11, "cut_sandstone")
    b.fill(-21, 64, 11, 21, 65, 11, "cut_sandstone")
    b.fill(-21, 66, -11, 21, 66, -11, "smooth_sandstone")
    b.fill(-21, 66, 11, 21, 66, 11, "smooth_sandstone")
    b.fill(-20, 67, -11, 20, 67, -11, "polished_sulfur")
    b.fill(-20, 67, 11, 20, 67, 11, "polished_sulfur")
    for lx in (-15, -10, -5, 0, 5, 10, 15):
        b.setblock(lx, 66, -11, "ochre_froglight")
        b.setblock(lx, 66, 11, "ochre_froglight")
        b.setblock(lx, 67, -11, "chiseled_sandstone")
        b.setblock(lx, 67, 11, "chiseled_sandstone")
    b.fill(-21, 68, -11, 21, 70, -11, "barrier")
    b.fill(-21, 68, 11, 21, 70, 11, "barrier")

    # Permanent outer West & East solid backboards for max +6 tier (x = -21 & +21)
    b.fill(-21, 64, -11, -21, 67, 11, "cut_sandstone")
    b.fill(21, 64, -11, 21, 67, 11, "cut_sandstone")
    b.fill(-21, 66, -9, -21, 66, 9, "chiseled_sandstone")
    b.fill(21, 66, -9, 21, 66, 9, "chiseled_sandstone")
    b.fill(-21, 67, -6, -21, 67, 6, "red_terracotta")
    b.fill(21, 67, -6, 21, 67, 6, "light_blue_terracotta")
    b.fill(-21, 68, -10, -21, 68, 10, "polished_sulfur")
    b.fill(21, 68, -10, 21, 68, 10, "polished_sulfur")
    for lz in (-8, 0, 8):
        b.setblock(-21, 66, lz, "ochre_froglight")
        b.setblock(21, 66, lz, "ochre_froglight")
    b.fill(-21, 69, -11, -21, 70, 11, "barrier")
    b.fill(21, 69, -11, 21, 70, 11, "barrier")

    return b.clear_cmds()


def build_tier_court(b: VoxelBuilder, tier: int, *, apply_voxels: bool) -> list[str]:
    """Build inner court floor (y=64) & outer terrace/backboard step-in for depth tier 0 (+0), 1 (+3), or 2 (+6)."""
    ext = tier * 3
    goal_x = 12 + ext
    wall_x = 13 + ext
    base_x = 14 + ext
    court_len = 29 + ext * 2

    target = b if apply_voxels else VoxelBuilder()
    target.clear_cmds()
    target.cmds.append(f"# ===== {court_len}×21 晴空海岸露天球场地面与后翼台基 (纵深档位 {tier}: 两侧 +{ext} 格) =====")
    with target.record_commands():
        target.fill(-base_x, 64, -10, base_x, 64, 10, "smooth_sandstone")
        target.fill(-goal_x, 64, -10, goal_x, 64, -10, "birch_planks")
        target.fill(-goal_x, 64, 10, goal_x, 64, 10, "birch_planks")

        # Baselines (-base_x / +base_x) & Guardian Wall plinths (-wall_x / +wall_x)
        target.fill(-base_x, 64, -10, -base_x, 64, 10, "prismarine_bricks")
        target.fill(base_x, 64, -10, base_x, 64, 10, "prismarine_bricks")
        target.fill(-wall_x, 64, -10, -wall_x, 64, 10, "chiseled_sandstone")
        target.fill(wall_x, 64, -10, wall_x, 64, 10, "chiseled_sandstone")

        # Half-court goal lines & sunlit bamboo service boxes centered in each half-court
        target.fill(-goal_x, 64, -9, -goal_x, 64, 9, "cut_red_sandstone")
        target.fill(goal_x, 64, -9, goal_x, 64, 9, "prismarine_bricks")
        sb_in = 5 + (ext + 1) // 2   # tier 0 -> 5, tier 1 -> 7, tier 2 -> 8
        sb_out = 9 + ext // 2 + (1 if tier == 1 else 0)  # tier 0 -> 9, tier 1 -> 11, tier 2 -> 12
        target.fill(-sb_out, 64, -4, -sb_in, 64, 4, "bamboo_mosaic")
        target.fill(-(sb_out - 1), 64, -3, -(sb_in + 1), 64, 3, "smooth_sandstone")
        target.fill(sb_in, 64, -4, sb_out, 64, 4, "bamboo_mosaic")
        target.fill(sb_in + 1, 64, -3, sb_out - 1, 64, 3, "smooth_sandstone")

        # Central 5-block shared neutral zone (x = -2 .. +2): 26.3 Sulfur Brick Suite
        target.fill(-2, 64, -10, 2, 64, 10, "sulfur_bricks")
        target.fill(-2, 64, -10, -2, 64, 10, "polished_sulfur")
        target.fill(2, 64, -10, 2, 64, 10, "polished_sulfur")
        target.fill(0, 64, -10, 0, 64, 10, "chiseled_sulfur")
        for lz in (-10, -5, 0, 5, 10):
            target.setblock(0, 64, lz, "ochre_froglight")

        # For compact/medium tiers (base_x < 20), seal active backboards at +-(base_x+1) & fill outer bastion terraces
        if base_x < 20:
            ab = base_x + 1
            if ab < 20:
                for sign, accent in ((-1, "red_terracotta"), (1, "light_blue_terracotta")):
                    tx1 = (ab + 1) * sign
                    tx2 = 20 * sign
                    x_lo, x_hi = min(tx1, tx2), max(tx1, tx2)
                    target.fill(x_lo, 64, -10, x_hi, 67, 10, "smooth_sandstone")
                    target.fill(x_lo, 67, -8, x_hi, 67, 8, "cut_sandstone")
                    target.fill(x_lo, 67, -4, x_hi, 67, 4, accent)
                    target.fill(x_lo, 67, -1, x_hi, 67, 1, "polished_sulfur")

            target.fill(-ab, 64, -10, -ab, 67, 10, "cut_sandstone")
            target.fill(ab, 64, -10, ab, 67, 10, "cut_sandstone")
            target.fill(-ab, 66, -9, -ab, 66, 9, "chiseled_sandstone")
            target.fill(ab, 66, -9, ab, 66, 9, "chiseled_sandstone")
            target.fill(-ab, 67, -6, -ab, 67, 6, "red_terracotta")
            target.fill(ab, 67, -6, ab, 67, 6, "light_blue_terracotta")
            target.fill(-ab, 68, -10, -ab, 68, 10, "polished_sulfur")
            target.fill(ab, 68, -10, ab, 68, 10, "polished_sulfur")
            for lz in (-8, 0, 8):
                target.setblock(-ab, 66, lz, "ochre_froglight")
                target.setblock(ab, 66, lz, "ochre_froglight")
            target.fill(-ab, 69, -10, -ab, 70, 10, "barrier")
            target.fill(ab, 69, -10, ab, 70, 10, "barrier")

    return target.clear_cmds()


def build_lobby(b: VoxelBuilder) -> list[str]:
    b.cmds.append("# ===== 北侧全宽海滨拱廊看台大厅 (x=-22..+22 匹配 41×21 全长赛场，甲板 y=68，站立高度 y=69/70) =====")

    # Stepped sandstone amphitheater terrace substructure spanning full stadium width (x = -22 .. +22, z = -22 .. -12, y = 64 .. 68)
    b.fill(-22, 64, -22, 22, 67, -12, "smooth_sandstone")
    b.fill(-22, 68, -22, 22, 68, -12, "cut_sandstone")
    b.fill(-21, 68, -20, 21, 68, -12, "smooth_sandstone")

    # Full-width front boardwalk promenade overlooking the entire 41×21 court (z = -13 .. -12)
    b.fill(-21, 68, -13, 21, 68, -12, "bamboo_mosaic")
    for lx in (-18, -12, -6, 0, 6, 12, 18):
        b.setblock(lx, 68, -12, "ochre_froglight")

    # Central sunlit compass & 3x3 raised spawn dais (z = -17..-15, standing height Y = 70.0)
    b.fill(-3, 68, -19, 3, 68, -14, "polished_sulfur")
    b.fill(-1, 69, -17, 1, 69, -15, "smooth_sandstone")

    # West Red Beach Cabana (x = -11 .. -8, z = -17 .. -14)
    b.fill(-11, 68, -17, -8, 68, -14, "red_concrete")
    for px in (-11, -8):
        for pz in (-17, -14):
            b.fill(px, 69, pz, px, 72, pz, "stripped_birch_log")
    for x in range(-12, -7):
        mat = "red_concrete" if x % 2 == 0 else "white_concrete"
        b.fill(x, 73, -18, x, 73, -13, mat)

    # East Blue Beach Cabana (x = +8 .. +11, z = -17 .. -14)
    b.fill(8, 68, -17, 11, 68, -14, "blue_concrete")
    for px in (8, 11):
        for pz in (-17, -14):
            b.fill(px, 69, pz, px, 72, pz, "stripped_birch_log")
    for x in range(7, 13):
        mat = "light_blue_concrete" if x % 2 == 0 else "white_concrete"
        b.fill(x, 73, -18, x, 73, -13, mat)

    # East-side Spectator Opt-out Pad (x = 13..15, z = -17..-15)
    b.fill(13, 68, -17, 15, 68, -15, "light_gray_concrete")

    # Symmetrical coastal lounge wings & lush flower planters on West/East plaza flanks (x = -20..-15 & +17..+20)
    for fx1, fx2 in ((-20, -18), (-15, -14), (17, 18), (19, 20)):
        b.fill(fx1, 69, -19, fx2, 69, -18, "moss_block")
        b.setblock(fx1, 70, -19, "flowering_azalea_leaves[persistent=true]")
        b.setblock(fx2, 70, -18, "azalea_leaves[persistent=true]")
    b.fill(-19, 69, -15, -16, 69, -15, "birch_stairs[facing=north]")
    b.fill(17, 69, -15, 20, 69, -15, "birch_stairs[facing=north]")

    # Full-Span North Mediterranean Arched Pavilion Wall (z = -21, x = -21 .. +21, y = 69 .. 76)
    b.fill(-21, 69, -21, 21, 74, -21, "smooth_sandstone")
    b.fill(-21, 72, -21, 21, 72, -21, "chiseled_sandstone")
    for px in (-20, -15, -10, -5, 0, 5, 10, 15, 20):
        b.fill(px, 69, -21, px, 74, -21, "cut_sandstone")
        b.setblock(px, 73, -20, "ochre_froglight")
    # Sunny golden-yellow & white resort roof eave (z = -22 .. -20, y = 75 .. 76)
    for x in range(-22, 23):
        roof = "yellow_terracotta" if (x // 2) % 2 == 0 else "white_concrete"
        b.fill(x, 75, -22, x, 75, -20, roof)
    b.fill(-20, 76, -21, 20, 76, -21, "polished_sulfur")

    # Invisible safety barriers around North Plaza & front court overlook (open sky overhead!)
    b.fill(-22, 69, -22, 22, 75, -22, "barrier")
    b.fill(-22, 69, -22, -22, 75, -11, "barrier")
    b.fill(22, 69, -22, 22, 75, -11, "barrier")
    b.fill(-21, 68, -11, 21, 74, -11, "barrier")

    # Interactive lobby controls: Start button in the center of the raised dais, Lectern on the dais's court-side edge facing the player (north)
    b.setblock(0, 69, -16, "emerald_block")
    b.setblock(0, 70, -16, "stone_button[face=floor,facing=south]")
    b.setblock(0, 70, -15, "lectern[facing=north]")
    b.clear_cmds()


def build_voxel_world() -> tuple[VoxelBuilder, dict[str, list[str]]]:
    b = VoxelBuilder()
    build_island_and_surrounds(b)
    build_perimeter(b)
    floor_0_cmds = build_tier_court(b, tier=0, apply_voxels=True)
    floor_1_cmds = build_tier_court(b, tier=1, apply_voxels=False)
    floor_2_cmds = build_tier_court(b, tier=2, apply_voxels=False)
    build_lobby(b)

    # Initial 19 Red + 19 Blue Guardian Wall columns, end pillars, and upper barriers in `.mca` chunks (default tier 0)
    for wx in (-14, -13, 13, 14):
        for wz in (-10, 10):
            b.fill(wx, 65, wz, wx, 67, wz, "cut_sandstone", record_cmd=False)
            b.fill(wx, 68, wz, wx, 70, wz, "barrier", record_cmd=False)
    for wx in (-13, 13):
        for wz in (-10, 10):
            b.setblock(wx, 67, wz, "chiseled_sandstone", record_cmd=False)
    b.fill(-13, 65, -9, -13, 66, 9, "red_concrete", record_cmd=False)
    b.fill(-13, 67, -9, -13, 70, 9, "barrier", record_cmd=False)
    b.fill(13, 65, -9, 13, 66, 9, "blue_concrete", record_cmd=False)
    b.fill(13, 67, -9, 13, 70, 9, "barrier", record_cmd=False)

    floor_dispatch = [
        "# ===== 按讲台纵深档位 (#o_depth: 0=29×21, 1=35×21, 2=41×21) 重建地面与两侧后翼护壁 =====",
        "execute if score #o_depth sb_var matches 0 run function sb:arena/floor_0",
        "execute if score #o_depth sb_var matches 1 run function sb:arena/floor_1",
        "execute if score #o_depth sb_var matches 2 run function sb:arena/floor_2",
    ]
    files = {
        "data/sb/function/arena/floor.mcfunction": floor_dispatch,
        "data/sb/function/arena/floor_0.mcfunction": floor_0_cmds,
        "data/sb/function/arena/floor_1.mcfunction": floor_1_cmds,
        "data/sb/function/arena/floor_2.mcfunction": floor_2_cmds,
    }
    return b, files


def build_template_world(world_dir: Path | None = None, cfg=None) -> Path:
    from mcbeef.project import MapProjectConfig

    proj = cfg or MapProjectConfig.load(ROOT)
    target = world_dir or (ROOT / "world")
    builder, files = build_voxel_world()
    for rel, lines in files.items():
        path = ROOT / rel
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text("\n".join(lines) + "\n", encoding="utf-8")

    write_world_save(
        target,
        builder.voxels,
        level_name=proj.title,
        spawn_pos=proj.spawn_pos,
        spawn_yaw=proj.spawn_yaw,
        spawn_pitch=proj.spawn_pitch,
        biome=proj.biome,
        datapack_names=[proj.slug],
        noon_ticks=6000,
    )
    return target


def main() -> None:
    out = build_template_world()
    print(f"Generated 26.3 Anvil world directly at {out}")


if __name__ == "__main__":
    main()

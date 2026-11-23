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

    # 1. Organic tapered sandstone cliff island (y = 56 .. 63), centered at (0, -2)
    # Instead of thousands of single setblocks, emit horizontal Z-strips per Y slice!
    for y in range(56, 64):
        grow = (y - 56) / 7.0  # 0.0 at bottom -> 1.0 at top beach level y=63
        rx = 15.0 + 11.5 * (grow ** 0.62)  # up to 26.5 at y=63
        rz = 13.5 + 10.5 * (grow ** 0.62)  # up to 24.0 at y=63
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

        for z in range(-26, 22):
            dz = (z + 2.5) / rz
            if abs(dz) > 1.0:
                continue
            # Subtle organic coastal wave modulation
            wobble = 0.06 * math.sin(z * 0.45) + 0.04 * math.cos(z * 0.8)
            rem = max(0.0, 1.0 + wobble - dz * dz)
            if rem <= 0.0:
                continue
            half_x = int(math.floor(rx * math.sqrt(rem)))
            if half_x >= 1:
                b.fill(-half_x, y, z, half_x, y, z, mat)

    # Smooth sandstone inner promenade apron around stadium at y=63
    b.fill(-21, 63, -23, 21, 63, 16, "smooth_sandstone")

    # 2. Sparkling Turquoise Lagoon Pools & Coral Reefs on East/West/South beaches (y=62..63)
    lagoons = [
        # West tropical cove
        (-24, -20, -6, 6),
        # East tropical cove
        (20, 24, -6, 6),
        # South-West, South-Center & South-East sunny tide pools
        (-19, -14, 13, 17),
        (-8, 8, 17, 19),
        (14, 19, 13, 17),
    ]
    for lx1, lx2, lz1, lz2 in lagoons:
        b.fill(lx1, 62, lz1, lx2, 62, lz2, "prismarine")
        b.setblock((lx1 + lx2) // 2, 62, (lz1 + lz2) // 2, "ochre_froglight")
        b.fill(lx1, 63, lz1, lx2, 63, lz2, "water")
        # Coral & sea-lantern accents inside lagoon bed
        b.setblock(lx1 + 1, 62, lz1 + 1, "tube_coral_block")
        b.setblock(lx2 - 1, 62, lz2 - 1, "brain_coral_block")
        b.setblock(lx1 + 1, 62, lz2 - 1, "horn_coral_block")

    # Hidden inventory stash vault safely encased beneath court center
    b.fill(-1, 57, -1, 1, 59, 1, "smooth_sandstone")
    b.setblock(0, 58, 0, "chest")

    # 3. West Red Fortress Bastion & East Blue Fortress Bastion (x = -19..-15 & +15..+19)
    for side, sign, accent, roof_mat in (
        ("red", -1, "red_terracotta", "red_concrete"),
        ("blue", 1, "light_blue_terracotta", "blue_concrete"),
    ):
        bx_in = 15 * sign
        bx_out = 18 * sign
        x_lo, x_hi = min(bx_in, bx_out), max(bx_in, bx_out)

        # Raised bastion terrace behind backboard
        b.fill(x_lo, 64, -11, x_hi, 66, 11, "smooth_sandstone")
        b.fill(x_lo, 67, -8, x_hi, 67, 8, "cut_sandstone")
        # Team emblem mosaic behind backboard
        b.fill(16 * sign, 67, -5, 17 * sign, 67, 5, accent)
        b.fill(16 * sign, 67, -1, 17 * sign, 67, 1, "polished_sulfur")

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
        b.fill(16 * sign, 68, -7, 16 * sign, 71, -7, "cut_sandstone")
        b.fill(16 * sign, 68, 7, 16 * sign, 71, 7, "cut_sandstone")
        b.fill(16 * sign, 71, -7, 16 * sign, 71, 7, "cut_sandstone")
        b.fill(16 * sign, 72, -4, 16 * sign, 72, 4, accent)
        b.fill(16 * sign, 72, -1, 16 * sign, 72, 1, "polished_sulfur")

    # 4. South Stepped Sunlit Bleachers & Striped Mediterranean Sun-Pergola (z = 12..16, x = -13..+13)
    b.fill(-13, 64, 12, 13, 65, 15, "smooth_sandstone")
    b.fill(-12, 66, 12, 12, 66, 12, "birch_planks")
    b.fill(-12, 66, 13, 12, 66, 15, "smooth_sandstone")
    b.fill(-12, 67, 13, 12, 67, 13, "birch_planks")
    b.fill(-12, 67, 14, 12, 67, 15, "smooth_sandstone")
    b.fill(-12, 68, 14, 12, 68, 14, "birch_planks")
    b.fill(-13, 68, 15, 13, 68, 15, "cut_sandstone")
    b.fill(-12, 69, 15, 12, 69, 15, "azalea_leaves[persistent=true]")
    for fx in (-9, -3, 3, 9):
        b.setblock(fx, 69, 15, "flowering_azalea_leaves[persistent=true]")

    # Pergola timber posts & sunny coral-orange / white awning at y = 72
    for px in (-12, -6, 0, 6, 12):
        b.fill(px, 66, 12, px, 71, 12, "stripped_birch_log")
        b.fill(px, 69, 15, px, 71, 15, "stripped_birch_log")
    for x in range(-13, 14):
        stripe = "orange_terracotta" if (x // 2) % 2 == 0 else "white_concrete"
        b.fill(x, 72, 12, x, 72, 15, stripe)
    b.fill(-13, 72, 11, 13, 72, 11, "bamboo_mosaic")

    # 5. Six Curved Tropical Coconut Palm Trees framing the island corners & coves
    b.add_palm_tree(-21, 64, -18, lean_x=-2, lean_z=-1, height=8)
    b.add_palm_tree(21, 64, -18, lean_x=2, lean_z=-1, height=8)
    b.add_palm_tree(-21, 64, 12, lean_x=-2, lean_z=2, height=7)
    b.add_palm_tree(21, 64, 12, lean_x=2, lean_z=2, height=7)
    b.add_palm_tree(-23, 64, -1, lean_x=-2, lean_z=0, height=7)
    b.add_palm_tree(23, 64, -1, lean_x=2, lean_z=0, height=7)

    return b.clear_cmds()


def build_perimeter(b: VoxelBuilder) -> list[str]:
    b.cmds.append("# ===== 露天开阔低矮高弹边墙 (y=65..67 实体围板 + y=68..70 隐形屏障，南北看台视野 100% 通透无玻璃遮挡) =====")
    # North & South low bounce boards (3 blocks tall: y=65..67)
    b.fill(-15, 64, -11, 15, 65, -11, "cut_sandstone")
    b.fill(-15, 64, 11, 15, 65, 11, "cut_sandstone")
    b.fill(-15, 66, -11, 15, 66, -11, "smooth_sandstone")
    b.fill(-15, 66, 11, 15, 66, 11, "smooth_sandstone")
    b.fill(-14, 67, -11, 14, 67, -11, "polished_sulfur")
    b.fill(-14, 67, 11, 14, 67, 11, "polished_sulfur")
    for lx in (-10, -5, 0, 5, 10):
        b.setblock(lx, 66, -11, "ochre_froglight")
        b.setblock(lx, 66, 11, "ochre_froglight")
        b.setblock(lx, 67, -11, "chiseled_sandstone")
        b.setblock(lx, 67, 11, "chiseled_sandstone")
    b.fill(-15, 68, -11, 15, 70, -11, "barrier")
    b.fill(-15, 68, 11, 15, 70, 11, "barrier")

    # West & East solid backboards (x = -15 & +15)
    b.fill(-15, 64, -11, -15, 67, 11, "cut_sandstone")
    b.fill(15, 64, -11, 15, 67, 11, "cut_sandstone")
    b.fill(-15, 66, -9, -15, 66, 9, "chiseled_sandstone")
    b.fill(15, 66, -9, 15, 66, 9, "chiseled_sandstone")
    b.fill(-15, 67, -6, -15, 67, 6, "red_terracotta")
    b.fill(15, 67, -6, 15, 67, 6, "light_blue_terracotta")
    b.fill(-15, 68, -10, -15, 68, 10, "polished_sulfur")
    b.fill(15, 68, -10, 15, 68, 10, "polished_sulfur")
    for lz in (-8, 0, 8):
        b.setblock(-15, 66, lz, "ochre_froglight")
        b.setblock(15, 66, lz, "ochre_froglight")
    b.fill(-15, 69, -11, -15, 70, 11, "barrier")
    b.fill(15, 69, -11, 15, 70, 11, "barrier")

    return b.clear_cmds()


def build_floor(b: VoxelBuilder) -> list[str]:
    b.clear_cmds()
    b.cmds.append("# ===== 29×21 晴空海岸露天球场地面 (y=64) =====")
    with b.record_commands():
        b.fill(-14, 64, -10, 14, 64, 10, "smooth_sandstone")
        b.fill(-12, 64, -10, 12, 64, -10, "birch_planks")
        b.fill(-12, 64, 10, 12, 64, 10, "birch_planks")

        # Baselines (-14 / +14) & Guardian Wall plinths (-13 / +13)
        b.fill(-14, 64, -10, -14, 64, 10, "prismarine_bricks")
        b.fill(14, 64, -10, 14, 64, 10, "prismarine_bricks")
        b.fill(-13, 64, -10, -13, 64, 10, "chiseled_sandstone")
        b.fill(13, 64, -10, 13, 64, 10, "chiseled_sandstone")

        # Half-court goal lines & sunlit bamboo service boxes
        b.fill(-12, 64, -9, -12, 64, 9, "cut_red_sandstone")
        b.fill(12, 64, -9, 12, 64, 9, "prismarine_bricks")
        b.fill(-9, 64, -4, -5, 64, 4, "bamboo_mosaic")
        b.fill(-8, 64, -3, -6, 64, 3, "smooth_sandstone")
        b.fill(5, 64, -4, 9, 64, 4, "bamboo_mosaic")
        b.fill(6, 64, -3, 8, 64, 3, "smooth_sandstone")

        # Central 5-block shared neutral zone (x = -2 .. +2): 26.3 Sulfur Brick Suite
        b.fill(-2, 64, -10, 2, 64, 10, "sulfur_bricks")
        b.fill(-2, 64, -10, -2, 64, 10, "polished_sulfur")
        b.fill(2, 64, -10, 2, 64, 10, "polished_sulfur")
        b.fill(0, 64, -10, 0, 64, 10, "chiseled_sulfur")
        for lz in (-10, -5, 0, 5, 10):
            b.setblock(0, 64, lz, "ochre_froglight")

    return b.clear_cmds()


def build_lobby(b: VoxelBuilder) -> list[str]:
    b.cmds.append("# ===== 北侧海滨拱廊看台大厅 (甲板 y=68，站立高度 y=69/70，正面无玻璃直视露天赛场) =====")

    # Stepped sandstone amphitheater terrace substructure (z = -22 .. -12, y = 64 .. 68)
    b.fill(-16, 64, -22, 16, 67, -12, "smooth_sandstone")
    b.fill(-16, 68, -22, 16, 68, -12, "cut_sandstone")
    b.fill(-15, 68, -20, 15, 68, -12, "smooth_sandstone")

    # Front boardwalk promenade overlooking court (z = -13 .. -12)
    b.fill(-15, 68, -13, 15, 68, -12, "bamboo_mosaic")
    for lx in (-12, -6, 0, 6, 12):
        b.setblock(lx, 68, -12, "ochre_froglight")

    # Central sunlit compass & 3x3 raised spawn dais (standing height Y = 70.0)
    b.fill(-3, 68, -18, 3, 68, -14, "polished_sulfur")
    b.fill(-1, 69, -16, 1, 69, -14, "smooth_sandstone")
    b.setblock(0, 69, -15, "chiseled_sandstone")

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

    # East-side Spectator Opt-out Pad (x = 13..14, z = -17..-15)
    b.fill(13, 68, -17, 14, 68, -15, "light_gray_concrete")

    # Lush coastal flower planters on plaza flanks
    for fx1, fx2 in ((-15, -13),):
        b.fill(fx1, 69, -19, fx2, 69, -18, "moss_block")
        b.setblock(fx1, 70, -19, "flowering_azalea_leaves[persistent=true]")
        b.setblock(fx2, 70, -18, "azalea_leaves[persistent=true]")
    b.fill(13, 69, -19, 15, 69, -19, "moss_block")
    b.setblock(14, 70, -19, "flowering_azalea_leaves[persistent=true]")

    # North Mediterranean Arched Pavilion Wall (z = -21, x = -15 .. +15, y = 69 .. 76)
    b.fill(-15, 69, -21, 15, 74, -21, "smooth_sandstone")
    b.fill(-15, 72, -21, 15, 72, -21, "chiseled_sandstone")
    for px in (-15, -10, -5, 0, 5, 10, 15):
        b.fill(px, 69, -21, px, 74, -21, "cut_sandstone")
        b.setblock(px, 73, -20, "ochre_froglight")
    # Sunny golden-yellow & white resort roof eave (z = -22 .. -20, y = 75 .. 76)
    for x in range(-16, 17):
        roof = "yellow_terracotta" if (x // 2) % 2 == 0 else "white_concrete"
        b.fill(x, 75, -22, x, 75, -20, roof)
    b.fill(-14, 76, -21, 14, 76, -21, "polished_sulfur")

    # Invisible safety barriers around North Plaza & front court overlook (open sky overhead!)
    b.fill(-16, 69, -22, 16, 75, -22, "barrier")
    b.fill(-16, 69, -22, -16, 75, -11, "barrier")
    b.fill(16, 69, -22, 16, 75, -11, "barrier")
    b.fill(-15, 68, -11, 15, 74, -11, "barrier")

    # Interactive lobby controls
    b.setblock(-3, 70, -21, "emerald_block")
    b.setblock(-3, 70, -20, "stone_button[face=wall,facing=south]")
    b.setblock(3, 69, -20, "lectern[facing=south]")
    b.clear_cmds()


def build_voxel_world() -> tuple[VoxelBuilder, dict[str, list[str]]]:
    b = VoxelBuilder()
    build_island_and_surrounds(b)
    build_perimeter(b)
    floor_cmds = build_floor(b)
    build_lobby(b)

    # Initial 19 Red + 19 Blue Guardian Wall columns, end pillars, and upper barriers in `.mca` chunks
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

    files = {
        "data/sb/function/arena/floor.mcfunction": floor_cmds,
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

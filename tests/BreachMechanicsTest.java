import com.mojang.authlib.GameProfile;
import com.mojang.blaze3d.vertex.PoseStack;
import io.netty.channel.embedded.EmbeddedChannel;
import net.minecraft.client.model.effects.SpearAnimations;
import net.minecraft.core.component.DataComponents;
import net.minecraft.core.registries.Registries;
import net.minecraft.gametest.framework.GameTestHelper;
import net.minecraft.gametest.framework.TestFunctionLoader;
import net.minecraft.network.Connection;
import net.minecraft.network.protocol.PacketFlow;
import net.minecraft.network.protocol.game.ServerboundPlayerLoadedPacket;
import net.minecraft.resources.Identifier;
import net.minecraft.resources.ResourceKey;
import net.minecraft.server.level.ClientInformation;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.server.network.CommonListenerCookie;
import net.minecraft.world.InteractionHand;
import net.minecraft.world.entity.EquipmentSlot;
import net.minecraft.world.entity.HumanoidArm;
import net.minecraft.world.entity.ai.attributes.Attributes;
import net.minecraft.world.entity.monster.cubemob.SulfurCube;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.level.GameType;
import net.minecraft.world.level.entity.EntityTypeTest;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;

public class BreachMechanicsTest {
    static void copyTree(Path src, Path dst) {
        try (var stream = Files.walk(src)) {
            for (var p : stream.toList()) {
                var target = dst.resolve(src.relativize(p));
                if (Files.isDirectory(p)) {
                    Files.createDirectories(target);
                } else {
                    Files.createDirectories(target.getParent());
                    Files.copy(p, target, StandardCopyOption.REPLACE_EXISTING);
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) throws Exception {
        net.minecraft.SharedConstants.tryDetectVersion();
        TestFunctionLoader.registerLoader(register -> register.accept(
            ResourceKey.create(Registries.TEST_FUNCTION, Identifier.parse("sb_test:player")), BreachMechanicsTest::run));
        var templateProp = System.getProperty("sb.templateWorld");
        net.minecraft.gametest.framework.GameTestMainUtil.runGameTestServer(args, universe -> {
            if (templateProp != null && !templateProp.isEmpty()) {
                copyTree(Path.of(templateProp), Path.of(universe, "gametestworld"));
            }
        });
    }

    static void command(ServerPlayer p, String line) {
        var server = p.level().getServer();
        server.getCommands().performPrefixedCommand(
            server.createCommandSourceStack().withEntity(p).withPosition(p.position()).withSuppressedOutput(), line);
    }

    static int score(SulfurCube ball, String objective) {
        var board = ball.level().getScoreboard();
        return board.getPlayerScoreInfo(ball, board.getObjective(objective)).value();
    }

    static int varScore(ServerPlayer p, String holder) {
        var board = p.level().getScoreboard();
        return board.getPlayerScoreInfo(net.minecraft.world.scores.ScoreHolder.forNameOnly(holder), board.getObjective("sb_var")).value();
    }

    static SulfurCube spawnBall(ServerPlayer p, String tag, String pos) {
        command(p, "summon minecraft:sulfur_cube " + pos
            + " {Tags:[\"sb_ball\",\"" + tag + "\"],Size:1,PersistenceRequired:1b,CanPickUpLoot:0b,Glowing:1b,"
            + "Health:1024.0f,attributes:[{id:\"minecraft:max_health\",base:1024.0d}],drop_chances:{body:0.0f}}");
        command(p, "execute as @e[tag=" + tag + "] at @s run function sb:cube/init_spawned");
        return p.level().getEntities(EntityTypeTest.forClass(SulfurCube.class), c -> c.entityTags().contains(tag)).getFirst();
    }

    static void run(GameTestHelper h) {
        var p = (ServerPlayer) h.makeMockServerPlayer(GameType.ADVENTURE);
        var connection = new Connection(PacketFlow.SERVERBOUND);
        new EmbeddedChannel(connection);
        h.getLevel().getServer().getPlayerList().placeNewPlayer(
            connection, p, CommonListenerCookie.createInitial(p.getGameProfile(), false));
        p.connection.handleAcceptPlayerLoad(new ServerboundPlayerLoadedPacket());
        p.setGameMode(GameType.ADVENTURE);
        p.snapTo(0.5, 70.0, -15.0, 0, 18);
        h.getLevel().getChunkSource().tick(() -> true, true);
        command(p, "function sb_test:rules");
        h.assertTrue(varScore(p, "#errors") == 0, "sb_test:rules assertions failed: errors=" + varScore(p, "#errors"));

        p.getInventory().setItem(4, new ItemStack(Items.DIAMOND, 5));

        command(p, "team join red @s");
        command(p, "function sb:game/start");
        command(p, "scoreboard players set #solo_mode sb_var 1");
        command(p, "scoreboard players set #state sb_var 2");

        // 1. Verify single-spear kit (no second spear, no Lunge displacement) + +25% Speed Boots
        var spear = p.getInventory().getItem(0);
        h.assertTrue(spear.is(Items.DIAMOND_SPEAR), "missing Breach spear in slot 0");
        h.assertTrue(p.getInventory().getItem(1).isEmpty(), "slot 1 must be empty in single-spear design");
        for (int tick : new int[]{1, 5, 10, 40, 100, 160, 200}) {
            var actual = new PoseStack();
            var vanilla = new PoseStack();
            SpearAnimations.firstPersonUse(0, actual, tick, HumanoidArm.RIGHT, spear);
            SpearAnimations.firstPersonUse(0, vanilla, tick, HumanoidArm.RIGHT, new ItemStack(Items.DIAMOND_SPEAR));
            h.assertTrue(actual.last().pose().equals(vanilla.last().pose(), 0.00001f), "wrong spear charge pose at " + tick);
        }
        p.doTick();
        double baseSpeed = p.getAttributeBaseValue(Attributes.MOVEMENT_SPEED);
        double actualSpeed = p.getAttributeValue(Attributes.MOVEMENT_SPEED);
        h.assertTrue(Math.abs(actualSpeed - baseSpeed * 1.25) < 0.0005,
            "Speed Boots did not grant +25% movement speed: " + actualSpeed + " vs " + baseSpeed);

        // 2. Verify empty sulfur cube (State 0) survives native spear jab without dying/splitting & switches to iron_block!
        p.getInventory().setSelectedSlot(0);
        p.snapTo(0.5, 65.0, 0.5, -90, 22); // Facing East (+X), pitched down toward 0.98m floor cube
        p.setYHeadRot(-90);
        p.setDeltaMovement(0, 0, 0);
        var cube = spawnBall(p, "sb_p_ball", "2.4 65.05 0.5");
        h.assertTrue(cube.getItemBySlot(EquipmentSlot.BODY).isEmpty(), "State 0 cube must have empty body");

        var jab = spear.get(DataComponents.PIERCING_WEAPON);
        jab.attack(p, EquipmentSlot.MAINHAND);
        h.assertTrue(p.getDeltaMovement().horizontalDistanceSqr() < 0.0001, "single spear must not Lunge-displace player");
        h.assertTrue(cube.isAlive() && score(cube, "sb_state") == 1, "empty cube died or failed to enter State 1 on jab");
        h.assertTrue(cube.getItemBySlot(EquipmentSlot.BODY).is(Items.IRON_BLOCK), "State 1 body must be iron_block");
        cube.tick();
        h.assertTrue(Math.abs(cube.getAttributeValue(Attributes.BOUNCINESS) - 0.95) < 0.0001
                && Math.abs(cube.getAttributeValue(Attributes.FRICTION_MODIFIER) - 0.08) < 0.0001
                && Math.abs(cube.getAttributeValue(Attributes.KNOCKBACK_RESISTANCE) - 1.0) < 0.0001,
            "State 1 iron_block archetype physics not applied: bounce=" + cube.getAttributeValue(Attributes.BOUNCINESS)
                + ", fric=" + cube.getAttributeValue(Attributes.FRICTION_MODIFIER));

        // 3. Verify magma_block State 2 has custom overload archetype AND zero burning contact damage!
        command(p, "execute as @e[tag=sb_p_ball] run function sb:cube/set_state_overload");
        h.assertTrue(cube.getItemBySlot(EquipmentSlot.BODY).is(Items.MAGMA_BLOCK), "State 2 body must be magma_block");
        cube.tick();
        h.assertTrue(Math.abs(cube.getAttributeValue(Attributes.BOUNCINESS) - 0.95) < 0.0001
                && Math.abs(cube.getAttributeValue(Attributes.FRICTION_MODIFIER) - 0.06) < 0.0001,
            "State 2 magma_block still matched vanilla hot archetype instead of sb:overload");
        p.snapTo(cube.getX(), 65.0, cube.getZ(), 0, 0);
        cube.playerTouch(p);
        h.assertTrue(p.getHealth() == 20.0f && p.getRemainingFireTicks() <= 0, "magma_block cube burned player");

        // 4. Verify configurable unattended recall duration (default 3s=60t, 5s=100t) AND disable (#o_recall=3 -> never auto-returns)!
        command(p, "scoreboard players set #o_recall sb_var 3");
        command(p, "function sb:cfg/calc");
        command(p, "execute as @e[tag=sb_p_ball] run function sb:cube/set_state_spent");
        h.assertTrue(cube.getItemBySlot(EquipmentSlot.BODY).is(Items.TUFF), "State 3 body must be tuff");
        command(p, "tp @e[tag=sb_p_ball] -7.5 65.05 0.5");
        cube.setDeltaMovement(0, 0, 0);
        for (int i = 0; i < 200; i++) {
            command(p, "execute as @e[tag=sb_p_ball] at @s run function sb:cube/step");
        }
        h.assertTrue(score(cube, "sb_state") == 3 && cube.getItemBySlot(EquipmentSlot.BODY).is(Items.TUFF)
                && Math.abs(cube.getX() + 7.5) < 0.01,
            "disabled recall still returned unattended ball to center");

        command(p, "scoreboard players set #o_recall sb_var 1"); // 5 seconds = 100 ticks
        command(p, "function sb:cfg/calc");
        for (int i = 0; i < 99; i++) {
            command(p, "execute as @e[tag=sb_p_ball] at @s run function sb:cube/step");
        }
        h.assertTrue(score(cube, "sb_state") == 3 && Math.abs(cube.getX() + 7.5) < 0.01,
            "5s recall returned ball early before 100 ticks");
        command(p, "execute as @e[tag=sb_p_ball] at @s run function sb:cube/step");
        h.assertTrue(score(cube, "sb_state") == 0 && cube.getItemBySlot(EquipmentSlot.BODY).isEmpty()
                && Math.abs(cube.getX() - 0.5) < 0.01,
            "5s recall did not return unattended ball to center (0.5) as empty State 0 on tick 100");
        command(p, "function sb:cfg/defaults");

        // 5. Verify shared 5-block neutral zone boundaries: Red allowed up to +2.65, clamped above +2.70!
        p.snapTo(2.4, 65.0, 0.5, -90, 0);
        command(p, "function sb:player/alive_step");
        h.assertTrue(Math.abs(p.getX() - 2.4) < 0.01, "Red player was blocked from entering shared 5-block neutral zone");
        p.snapTo(3.4, 65.0, 0.5, -90, 0);
        command(p, "function sb:player/alive_step");
        h.assertTrue(p.getX() <= 2.70, "Red player crossed past neutral zone into Blue half: x=" + p.getX());

        // 6. Verify level-gaze (pitch=0) Right-Click Charge via using_spear advancement + PvP zero-damage/knockback + Blue neutral boundary!
        var pBlue = new ServerPlayer(h.getLevel().getServer(), h.getLevel(),
            new GameProfile(java.util.UUID.randomUUID(), "blue-player"), ClientInformation.createDefault());
        var connBlue = new Connection(PacketFlow.SERVERBOUND);
        new EmbeddedChannel(connBlue);
        h.getLevel().getServer().getPlayerList().placeNewPlayer(
            connBlue, pBlue, CommonListenerCookie.createInitial(pBlue.getGameProfile(), false));
        pBlue.connection.handleAcceptPlayerLoad(new ServerboundPlayerLoadedPacket());
        pBlue.setGameMode(GameType.ADVENTURE);
        pBlue.getInventory().setItem(2, new ItemStack(Items.GOLD_INGOT, 3));
        command(pBlue, "team join blue @s");
        command(pBlue, "function sb:player/enter_match");

        // Blue enters shared 5-block neutral zone up to -1.5 (allowed), clamped past -1.70!
        pBlue.snapTo(-1.5, 65.0, 0.5, 90, 0);
        command(pBlue, "function sb:player/alive_step");
        h.assertTrue(Math.abs(pBlue.getX() + 1.5) < 0.01, "Blue player blocked from shared 5-block neutral zone");
        pBlue.snapTo(-2.4, 65.0, 0.5, 90, 0);
        command(pBlue, "function sb:player/alive_step");
        h.assertTrue(pBlue.getX() >= -1.70, "Blue player crossed past neutral zone into Red half: x=" + pBlue.getX());

        // PvP immunity in shared neutral zone: Red jabs Blue -> 0 damage, 0 knockback!
        p.snapTo(0.0, 65.0, 0.5, -90, 0);
        p.setYHeadRot(-90);
        pBlue.snapTo(1.8, 65.0, 0.5, 90, 0);
        pBlue.setDeltaMovement(0, 0, 0);
        jab.attack(p, EquipmentSlot.MAINHAND);
        h.assertTrue(pBlue.getHealth() == 20.0f && pBlue.getDeltaMovement().horizontalDistanceSqr() < 0.0001,
            "PvP spear hit dealt damage or knockback in shared neutral zone");

        // Level-gaze (pitch=0) Right-Click Charge against incoming iron_block ball upgrades it to magma_block!
        cube.discard();
        pBlue.snapTo(6.0, 65.0, 0.5, 90, 0); // Facing West (-X), level gaze pitch=0!
        pBlue.setYHeadRot(90);
        var incoming = spawnBall(p, "sb_charge_live", "3.8 65.05 0.5");
        command(p, "execute as @e[tag=sb_charge_live] run function sb:cube/set_state_iron");
        incoming.setDeltaMovement(0.65, 0, 0); // Flying East toward pBlue at 13 m/s!
        var blueSpear = pBlue.getInventory().getItem(0);
        blueSpear.use(pBlue.level(), pBlue, InteractionHand.MAIN_HAND);
        pBlue.doTick();
        h.assertTrue(score(incoming, "sb_state") == 2 && incoming.getItemBySlot(EquipmentSlot.BODY).is(Items.MAGMA_BLOCK)
                && incoming.getDeltaMovement().x < -1.0,
            "level-gaze Right-Click Charge failed to parry incoming ball into magma_block overload");
        pBlue.releaseUsingItem();
        incoming.discard();

        var repair = spawnBall(p, "sb_repair_live", "3.8 65.05 0.5");
        command(p, "scoreboard players set @e[tag=sb_repair_live] sb_special 2");
        command(p, "execute as @e[tag=sb_repair_live] run function sb:cube/set_state_iron");
        pBlue.snapTo(6.0, 65.0, 0.5, 90, 0);
        pBlue.setYHeadRot(90);
        repair.setDeltaMovement(0.65, 0, 0);
        blueSpear.use(pBlue.level(), pBlue, InteractionHand.MAIN_HAND);
        pBlue.doTick();
        h.assertTrue(score(repair, "sb_hit_cd") == 6 && score(repair, "sb_state") == 1
                && score(repair, "sb_special") == 2 && repair.getItemBySlot(EquipmentSlot.BODY).is(Items.MUD_BRICKS)
                && repair.getTeam() != null && repair.getTeam().getName().equals("sb_repair")
                && repair.getDeltaMovement().x < -1.0,
            "Right-Click Charge converted repair ball into an attacking ball or failed to return it");
        pBlue.releaseUsingItem();
        repair.discard();

        // 7. Verify anti-body-block preserves cube horizontal velocity while bumping player
        var fast = spawnBall(p, "sb_fast_ball", "-5.0 65.05 0.5");
        command(p, "execute as @e[tag=sb_fast_ball] run function sb:cube/set_state_iron");
        command(p, "scoreboard players set @e[tag=sb_fast_ball] sb_vx -850");
        command(p, "scoreboard players set @e[tag=sb_fast_ball] sb_vz 0");
        fast.setDeltaMovement(-0.85, 0, 0);
        p.snapTo(-5.6, 65.0, 0.5, -90, 0);
        command(p, "scoreboard players set @s sb_bump_cd 0");
        command(p, "execute as @e[tag=sb_fast_ball] at @s run function sb:cube/step");
        h.assertTrue(Math.abs(fast.getDeltaMovement().x + 0.85) < 0.002,
            "player body-blocked or slowed active ball: vx=" + fast.getDeltaMovement().x);
        command(p, "kill @e[type=wind_charge]");
        fast.discard();

        // 8. Verify match end restores BOTH players' distinct inventories & returns both immediately to North coastal lobby (y=70)
        command(p, "scoreboard players set @e[type=marker,tag=sb_wblue] sb_hp 0");
        command(p, "function sb:arena/recalc_hp");
        h.assertTrue(varScore(p, "#state") == 0 && !p.entityTags().contains("sb_ingame") && p.getY() == 70.0
                && !pBlue.entityTags().contains("sb_ingame") && pBlue.getY() == 70.0,
            "match end did not immediately return both players to North coastal lobby");
        var restoredRed = p.getInventory().getItem(4);
        var restoredBlue = pBlue.getInventory().getItem(2);
        h.assertTrue(restoredRed.is(Items.DIAMOND) && restoredRed.getCount() == 5
                && restoredBlue.is(Items.GOLD_INGOT) && restoredBlue.getCount() == 3,
            "original inventories were not independently restored");

        System.out.println("SB_PLAYER_OK");
        h.succeed();
    }
}

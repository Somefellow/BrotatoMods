# BrotatoMods

Brotato mods by Lionheart.

## Mods

### [CurseEverything](https://steamcommunity.com/sharedfiles/filedetails/?id=3357048042)
Curses your character, starting gear, shop items, crate items, and enemies. Highly configurable — each curse type can be toggled individually.

### [HungryPotato](https://steamcommunity.com/sharedfiles/filedetails/?id=3384741148)
Attract consumables even when at full HP. Healing consumables that would deal damage to you at full health are still ignored.

### [PerfectSoldierMovement](https://steamcommunity.com/sharedfiles/filedetails/?id=3361813593)
When playing the Soldier character, forces a 1-frame standstill when a weapon is ready to fire at a target in range. Improves accuracy for weapons that require you to stop moving to shoot.

### [RemoveEnemyLimit](https://steamcommunity.com/sharedfiles/filedetails/?id=3359837939)
Removes the enemy spawn cap, allowing all enemies from the wave schedule to be alive at the same time.

---

## Repository Structure

```
original_pck/   — Place Brotato .pck files here before decompiling (not tracked)
recovered/      — Decompiled game source and mod source files
  mods-unpacked/
    Lionheart-*/  — Mod source code (tracked)
tools/          — GDRETools decompiler binary (not tracked)
mods/           — Packaged .zip files ready for distribution (not tracked)
scripts/        — Helper scripts for setup, decompiling, and packing
```

---

## Development Setup

### 1. Download the decompiler

```bash
bash scripts/init.sh
```

Downloads the latest [GDRETools](https://github.com/GDRETools/gdsdecomp) release into `tools/`.

### 2. Decompile the game

Place your `Brotato.pck` into `original_pck/`, then run:

```bash
bash scripts/decompile.sh
```

Output goes into `recovered/`. Since Brotato 1.2.0.0 all DLC content (Abyssal Terrors, Primal Dread) ships inside `Brotato.pck`; any extra `.pck` files placed alongside it (older game versions) are still decompiled on top of the base game.

To update for a new game version, move the old `recovered/` aside first (keeping `recovered/mods-unpacked/`) so removed files don't linger and you can diff old vs new source.

### 3. Pack mods for distribution

```bash
bash scripts/pack_mods.sh
```

Creates a `.zip` for each mod found in `recovered/mods-unpacked/` and places them in `mods/`. Each zip contains the mod inside a `mods-unpacked/<mod-name>/` directory as expected by the mod loader.

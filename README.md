# Skull Fall: Gravity Call 
# Here's my game on itch.io: https://illomanillo.itch.io/skull-fall-gravity-call
**GDD - Game Design Document** **Author:** Samuel Palomo Pacheco  
**Date:** 21/01/2026  
**Art Style:** 8-Bit NES Retro  

---

## 1. Game Overview
**Skull Fall: Gravity Call** is a 2D physics-puzzle platformer with a strict NES aesthetic. The player controls **Skully Bones**, a weary skeleton seeking his own graveyard for a final rest. The game takes place in enclosed, claustrophobic arenas filled with heavy, shifting tombstones.

The world is cursed by a chaotic gravity system that rotates every **6 seconds**. Skully must navigate the environment, manipulate loose tombstones, and time his movements to reach the exit before the world turns upside down.

## 2. Genre & Perspective
* **Genre:** Physics Puzzle / Platformer
* **Perspective:** 2D Side View
* **Players:** Single-player

## 3. Core Design Pillars
* **The World is your Floor:** Skully walks on walls and ceilings as the world rotates.
* **The Tombstone Door:** Gravity is the key; the exit gate only opens when the world is oriented in a specific direction.
* **Lethal Irony:** If Skully is crushed, he ends up in a random, anonymous grave instead of his own.
* **Cinematic Rotation:** The camera rotates with the world to keep the player’s perspective aligned with the current "down".

---

## 4. Core Mechanics

### 4.1 Global Gravity System
Gravity direction changes every 6 seconds to a new random cardinal direction (ensuring it never repeats the current one).
* **Directions:** Down, Up, Left, Right.
* **Universal Effect:** Affects Skully, tombstones, and the camera simultaneously.

### 4.2 Dynamic Camera
When gravity shifts, the camera smoothly rotates to match the new direction. This ensures that the current "floor" always appears at the bottom of the screen, maintaining intuitive controls for the player.

### 4.3 Skully Bones (Movement)
* **Adaptive Orientation:** Skully’s sprite and collision rotate to stand on whatever wall is currently "down".
* **Relative Controls:** Movement is relative to the screen (Left/Right always moves Skully across the player's monitor).
* **On-Floor Logic:** Skully can only jump or walk when grounded relative to the current gravity.

### 4.4 Gravity-Locked Door
The exit to the level is a magical gate that acts as a gravity-check.
* **Condition:** The door only opens if the gravity is pulling in a specific direction (e.g., "The door only opens when gravity is UP").
* **Visual Cue:** The door glows or changes state when the gravity condition is met.

---

## 5. The Player (Skully Bones)
* **Goal:** Reach his designated grave.
* **Death Condition:** If a tombstone lands on Skully or pins him against a wall, he is crushed.
* **Game Over Screen:** A somber 8-bit screen showing a lonely, generic grave. 
    > *"Here lies a stranger who never found his deserved rest."*
    > 
    > This emphasizes Skully's failure to find his own resting place.

## 6. Game Elements
* **Skully Bones:** The 8-bit skeleton protagonist.
* **Movable Tombstones:** Heavy `RigidBody2D` objects. Useful as platforms but lethal when falling.
* **The Shifting Door:** A portal that checks the gravity vector to allow passage.
* **Static Environment:** Fixed 8-bit stone walls and crypt structures.

---

## 7. Visual Style & Feedback
* **Aesthetic:** Gothic-Minimalist / NES Retro.
* **Palette:** Deep purples, greys.

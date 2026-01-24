# Frogger: 20 Games Challenge #3

This is the third project in my journey through the **20 Games Challenge**. This time, I took on the classic Frogger mechanics, focusing on building a solid movement system and handling tricky 2D physics in Godot 4. Everything you see in this game frog, cars, logs, and environment was **hand-drawn by me**. While I focused heavily on the code, I wanted the game to have a unique, personal aesthetic rather than just using placeholder blocks.

## The Mechanics
This project was more complex than it looks. The main goal was to solve the "Moving Platform" problem:
* **Log Drifting:** Implementing a system where the player inherits the velocity of the log without breaking the grid-based movement.
* **Smart Grid Snapping:** Even when moving against the direction of a log, the player always snaps back to the center of a tile to keep the movement feeling responsive and fair.
* **Spawner System:** Lanes for traffic and logs are automated to keep the game flowing infinitely.
* **Win/Loss Loop:** Complete with a "Lilypad" target system, score tracking, and the inevitable "Game Over" screen.

## Technical Specs
* **Engine:** Godot 4.5.1
* **Language:** GDScript
* **Approach:** Signal-based collision handling and `_physics_process` for stable movement synchronization.

## Controls
* **Arrow Keys / WASD:** Leap in any direction.
* **The Goal:** Reach all the empty lilypads at the top without getting flattened or taking a swim!

---

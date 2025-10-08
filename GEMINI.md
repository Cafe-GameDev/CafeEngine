# ☕ CafeEngine Suite & 🧠 StateCafe Plugin

This document provides an overview of the **CafeEngine** plugin suite and a detailed look into the **StateCafe** plugin, highlighting their core philosophies, architecture, and functionalities within the Godot Engine.

---

## ☕ CafeEngine Suite: Programming Oriented to Resources (ROP)

**CafeEngine** is a collection of plugins for Godot 4, built upon the philosophy of **Resource-Oriented Programming (ROP)**. This approach aims to create modular, reusable tools deeply integrated with the Godot editor.

### Core Philosophy:

The central idea is to treat Godot's `Resource` system not merely as data containers, but as **active and intelligent behavior objects**. This means:

-   **Encapsulated Logic:** Behavior logic (e.g., AI states, music albums, attack patterns) is self-contained within a `Resource`, moving away from monolithic scripts.
-   **Maximum Reusability:** A single behavior `Resource` can be configured differently in the Inspector and reused across multiple characters and systems without code duplication.
-   **Data-Oriented Design:** The "what" (logic and data within the `Resource`) is separated from the "how" (the `Node` in the scene executing the behavior). This fosters flexible and easily modifiable systems.
-   **"Godot-Native" Workflow:** All configuration and management are performed directly through the Godot FileSystem and Inspector, making the plugins intuitive for any Godot developer.

### Plugins in the Suite:

-   **🎵 AudioCafe:** A robust audio management system that automates the creation of `AudioStreamPlaylist`s, `AudioStreamRandomizer`s, and other dynamic audio `Resource`s from raw audio files.
-   **🧠 StateCafe:** A Layered and Parallel State Machine framework for building complex AI, character, and game flow logic in a modular and visual way using `StateBehavior` resources.

---

## 🧠 StateCafe Plugin: Layered and Parallel State Machines

**StateCafe** is an advanced framework for Godot Engine 4.x, designed to simplify and enhance the creation of complex behavior logic. It implements a **Layered and Parallel State Machine architecture**, where behaviors are encapsulated in reusable `Resource`s.

### Key Features:

-   **Parallel State Machines:** Execute multiple behaviors (e.g., Movement and Attack) simultaneously and synchronously, avoiding complex states for every combination.
-   **Resource-Based Behaviors:** Create, configure, and reuse state logic (e.g., Patrol, Jump, Dialogue) directly from the FileSystem and Inspector.
-   **Reactive Architecture:** Utilizes Godot's signal system for state transitions and for states to communicate their needs (e.g., play a sound, spawn an effect) in a decoupled manner.
-   **Global and Local Management:** Control both the game's scene flow (macro-level) and specific enemy AI (micro-level) using the same unified system.
-   **Visual Editor (Planned):** A future graph interface will allow for visual creation, connection, and debugging of state machines.

### Core Architecture:

StateCafe is built around three central components:

1.  **`StateComponent` (The Behavior Manager):**
    -   A `Node` that acts as the execution engine within a scene. It manages a set of active `StateBehavior`s simultaneously, organized into "layers" or "domains" (e.g., "movement", "action").
    -   It handles safe state transitions, propagates external events to active behaviors, and emits signals for state changes.

2.  **`StateBehavior` (The Sub-Machine / Functional Domain):**
    -   A `Resource` that encapsulates the complete logic of a functional domain (Movement, Combat, AI). It acts as a self-contained state machine managing its own internal micro-states.
    -   Communicates its intention to transition via a `transition_requested` signal and can react to external events through a `handle_event` method.

3.  **`StateMachine` (The Autoload Singleton):**
    -   A global `Node` that serves as a high-level orchestrator.
    -   **Role 1 (Entity Observer):** Keeps a registry of all active `StateComponent`s for debugging via the `StatePanel`.
    -   **Role 2 (Global State Executor):** Manages the overall game flow (menus, levels, pause) using high-level `StateBehavior`s like `GameStateScene`.

### Development Philosophy: `Resource` as an Active Object

The StateCafe architecture emphasizes that `StateBehavior` resources are not just data containers. They are intelligent objects with their own logic, internal state, and the ability to emit signals to communicate their intentions. This means states decide *when* to transition, rather than being constantly polled by an external manager.

### Compatibility:

-   Targeted for **Godot 4.5** and future versions. No backward compatibility with older Godot versions is planned.

---

## Contribution & License

Both CafeEngine and StateCafe are open-source projects. Contributions are welcome. The projects are distributed under the MIT License.
# zombie
MATLAB zombie apocalypse simulation

In a zombie apocalypse, we have 2 populations: humans and zombies.

The initial number of humans is `h0` and the initial number of zombies is `z0`.

Both populations can attack and move about. A zombie can attack a human if the human is within the zombie's `zAttackRadius`. 
Similarly, a human can attack a zombie if the zombie is within the human's `hAttackRadius`.

The probability of a human successfully killing a zombie is `ph` and the probability of a zombie successfully killing a human is `pz`. Fights are assumed to be simutaneous, so these 2 probabilities are independent of each other (the scenario where a human kills a zombie and the zombie infects the human is possible, also fights aren't always 1v1)

If a zombie sees a human, but is too far to attack, then the zombie will chase after the human. Similarly, humans run away from zombies when they see one. How far can zombies and humans see? These distances can be configured in `zSightRadius` and `hSightRadius` for zombies and humans respectively.

If a zombie doesn't see any human, then the movement of this zombie is assumed to be random. Similarly, humans move randomly when they don't see any zombies.


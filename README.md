# zombie
This is a more optimised version (**created by Kin Fai Franco Chan and Zakaria Achouri**) of the original MATLAB zombie apocalypse group project (https://github.com/UoMLegends/Zombie). This version uses vectorisation for movement increment, uses `knnsearch` for finding nearest enemy and preallocation for memory efficiency.

### To run the simulation, do the following steps:
1. save all the m files from this repository
2. execute `zombieBasic.m` using MATLAB
3. enjoy watching the zombie apocalypse simulation
4. execute `population.m` to plot the graphs of zombie population and human population versus time 


To simplify things, we modelled our zombie apocalypse based on a few simple behaviours of both zombies and humans.
### Basic behaviours of zombies and humans:
* If human and zombie are **far away** from each other, they simply **move randomly** (Brownian motion).
* If human and zombie are **relatively close** to each other, then the zombie would **chase** after the human, and the human would **run away**.
* If a zombie is close to **multiple humans**, then the zombie would chase after the **closest** human.
* If human and zombie are **very close** to each other, then they will **fight**. Sometimes the human wins the fight, which results in killing the zombie. And sometimes the zombie wins the fight, which results in turning the human into a zombie.


### Feel free to modify the parameters on `zombieBasic.m`:
Parameters | Descriptions
---------- | ------------
`z0` | the initial zombie population
`h0` | the initial human population
`zSpeed` | zombie movement top speed
`hSpeed` | human movement top speed
`zSightRadius` | maximum distance a zombie can sense the presence of a human (for chase)
`hSightRadius` | maximum distance a human can sense the presence of a zombie (for chase)
`zAttackRadius` | maximum distance a zombie can attack from (for fight)
`hAttackRadius` | maximum distance a human can attack from (for fight)
`lim` | the length and the width of the arena (square arena)
`pz`| the probability of zombie successfully converting a human to a zombie
`ph`| the probability of human successfully killing a zombie

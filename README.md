# Project FERLUDE

**Few shot evolutionary reinforcement learning in uncertain and dynamic environments** (FERLUDE) is a project funded within the [SMASH](https://smash.ung.si) postdoctoral program.

SMASH is an innovative, intersectoral, career-development training program co-funded by the Marie Skłodowska-Curie COFUND Actions (MSCA COFUND) for the 2023-2028 period.

This repo contains code for the research papers (and work in general) emanating from the FERLUDE project.

![Project FERLUDE Logo](images/ferlude_logo.jpg)
![Project SMASH Logo](images/smash_logo.jpg)

## Project Details

- **Full title**: Few shot evolutionary reinforcement learning in uncertain and dynamic environments
- **Acronym**: FERLUDE
- **Investigator**: Bruno Gašperov, PhD
- **Host institution**: University of Ljubljana, Faculty of Computer and Information Science, Laboratory for Adaptive Systems and Parallel Processing
- **Research area**: Data Science - Machine Learning for Scientific Applications (1)
- **SMASH supervisor**: Prof. Branko Šter
- **Duration of fellowship**: 19. 6. 2024 – 18. 6. 2026

## Extended Summary

Over the last several years, reinforcement learning (RL) has achieved a number of exciting breakthroughs in a wide variety of sequential decision-making tasks under uncertainty, especially in combination with deep learning (deep RL). However, the vast majority of such successes have been confined to highly controlled and static environments characterized by several favorable properties. These properties include the stationarity and determinism of the underlying state transition matrix and the reward function. Yet RL agents trained under such circumstances often fail to generalize to real-world environments. 

To a large extent, this problem stems from the fact that real-world problems often involve dynamic (non-stationary) and uncertain (noisy) environments, undergoing distributional shifts and exhibiting relatively low signal-to-noise ratios. RL agents deployed for real-world tasks must be capable of quickly (i.e., from only a few samples or interactions with the environment) adapting their behavior to environmental changes in order to minimize regret.

The ability to update existing knowledge and adapt to changes in the environment is argued to be a pivotal property of intelligent systems. Consequently, there is a need for novel (deep) RL approaches for training and deploying RL agents under such conditions in a few-shot manner.

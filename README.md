Ce projet est réalisé dans le cadre du module Communication Sans Fil en Licence 1 à l’Université de Valrose à Nice
# L1_Projet_ReactionTime
<p align="center">
  <img src="![Logo](https://github.com/user-attachments/assets/cf1b1466-6187-452f-ae81-30949c762fc3)" alt="Logo" width="150">
</p>

![projet photo](https://github.com/user-attachments/assets/5e745da1-13a1-480c-a7a9-08d013c4f19f)

# Description

Ce projet a pour but de tester la réactivité d’un utilisateur à l’aide d’un dispositif interactif. Le principe est simple : on appuie une première fois sur un bouton pour lancer une animation, puis, dès que les LEDs s’allument en vert, il faut réagir le plus vite possible en appuyant de nouveau. Le temps de réaction est mesuré en millisecondes et affiché sur un écran OLED, accompagné d’un nom d’animal choisi en fonction de la performance (par exemple un "Faucon" pour les plus rapides, ou une "Pierre" pour les plus lents). Le système conserve également le meilleur temps réalisé pendant la session, et si un nouveau record est battu, une animation spéciale se déclenche pour le mettre en valeur. Cela apporte un côté amusant au projet, en plus de l’aspect technique.


# Matériel utilisé

Pour réaliser ce projet, nous avons utilisé une carte Arduino Pro Mini fournie par l’Université Côte d’Azur (carte UCA). Elle intègre directement plusieurs LEDs que nous avons utilisées pour afficher des animations lumineuses au cours du jeu. L’interface utilisateur repose sur un simple bouton poussoir, qui permet de lancer une partie et d’arrêter le chrono. Un écran OLED est utilisé pour afficher les temps de réaction ainsi que l’animal correspondant. L’ensemble des composants est relié de manière simple, ce qui rend le montage compact, fonctionnel et facile à prendre en main. Nous avons choisi ce matériel car il est bien adapté pour un projet d’initiation à l’électronique et à la programmation embarquée.

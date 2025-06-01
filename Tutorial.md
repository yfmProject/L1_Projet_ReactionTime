# Tutoriel d’utilisation – Projet Reaction Time

Ce guide vous accompagne pas à pas pour utiliser, tester et comprendre le projet **Reaction Time**. Il complète la description générale donnée dans le README.

---

## 1. Matériel nécessaire

- Carte UCA 
- Écran OLED (modèle utilisé : Adafruit SSD1306)
- Bouton poussoir ( pas obligé il y a déjà un bouton intégré a la carte uca) 
- Câbles de connexion males
- Ordinateur avec Arduino IDE installé
- Câble USB pour programmer la carte

---

## 2. Installation du projet

1. **Prendre le code**  
   téléchargez ou copiez le dépôt GitHub depuis :  
   `https://github.com/yfmProject/L1_Projet_ReactionTime/blob/main/ArduinoCode.m`

2. **Ouvrir le projet dans Arduino IDE**  
   Lancez Arduino IDE et ouvrez le fichier `ReactionTime.ino` (ou équivalent en collant directement le code).

3. **Installer les bibliothèques nécessaires**  
   Assurez-vous d’avoir installé les bibliothèques suivantes via le gestionnaire de bibliothèques Arduino :  
   - FastLED  
   - Adafruit_GFX  
   - Adafruit_SSD1306

---

## 3. Montage matériel

- Soudez 2 fils sur le bouton (facultatif) puis connectez les sur GND ainsi qu'à la broche 2 de la carte UCA.  
- Branchez l’écran OLED comme ceci:
 # Connexions de l’écran OLED à la carte UCA21

| Broche écran OLED | Broche carte UCA21         | Description                  |
|-------------------|-----------------------------|------------------------------|
| GND               | GND                         | Masse                        |
| VCC               | 1 - V_mcu                   | Alimentation (3.3V ou 5V)    |
| D0                | D13 / SCK                   | Horloge SPI                  |
| D1                | D11                         | Donnée SPI (MOSI)           |
| RES               | D9                          | Reset de l’écran             |
| DC                | D8                          | Data/Commande                |
| CS                | D10                         | Chip Select (activation SPI) |
  
- La carte UCA dispose de LEDs intégrées, pas besoin de bande LED externe.

---

## 4. Utilisation du programme

1. **Démarrage**  
   Branchez la carte UCA21. L'écran OLED reste vide, prêt à démarrer une partie. Aucun éclairage LED n’est visible tant que la partie n’est pas lancée.

2. **Lancer une partie**  
   Appuyez sur le bouton. Une animation de démarrage s'affiche sur l'écran ("Prêt ?", "GO !") pendant que les LEDs rouges s’activent progressivement, suivies de rebonds lumineux.  
   Lorsque les LEDs passent au vert, le chronomètre démarre.

3. **Test de réaction**  
   Dès que les LEDs deviennent vertes, appuyez sur le bouton aussi vite que possible pour stopper le chrono.

4. **Résultats**  
   Le temps de réaction (en millisecondes) s’affiche à l'écran OLED, accompagné d’un nom d’animal correspondant à votre performance (ex. : "Guépard", "Chat", "Tortue marine"...).

5. **Record**  
   Si le temps est meilleur que le précédent record, il est enregistré et une animation spéciale est déclenchée.  
   Une fois les 10 secondes écoulées, le meilleur score (temps + animal) reste affiché jusqu’au lancement d’une nouvelle partie.

6. **Recommencer**  
   Appuyez à nouveau sur le bouton pour lancer une nouvelle partie. Le processus reprend depuis l'étape 2.


---

## 5. Personnalisation et amélioration

- Vous pouvez modifier les seuils des temps pour changer les animaux associés dans la fonction `getAnimalFromTime()` du code.  
- Adaptez les animations LED dans `runAnimation()` selon vos envies.  
- Changez la luminosité ou le nombre de LEDs si vous utilisez une autre carte.

---

## 6. Dépannage

- **Le bouton ne répond pas :** vérifiez les connexions et que le pin est configuré en `INPUT_PULLUP`.  
- **L’écran reste noir :** contrôlez les connexions SPI et que la bonne bibliothèque est installée.  
- **Pas d’animation LED :** assurez-vous que les LEDs intégrées sont bien supportées par la bibliothèque FastLED.

---

## 7. Remarques finales

Ce projet est un excellent moyen de se familiariser avec Arduino, la gestion des LEDs, des écrans OLED, et la programmation événementielle. N’hésitez pas à expérimenter et à améliorer le code !

---

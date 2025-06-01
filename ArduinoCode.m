
╔═══════════════════════════════════════════════════════╗
║          Projet Arduino – Réaction Time               ║
║───────────────────────────────────────────────────────║



#include <FastLED.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <SPI.h>

// OLED SPI settings
#define OLED_MOSI   11
#define OLED_CLK    13
#define OLED_DC     8
#define OLED_CS     10
#define OLED_RESET  9

// LED settings
#define BUTTON_PIN  2
#define DATA_PIN    4
#define NUM_LEDS    21
#define BRIGHTNESS  24

CRGB leds[NUM_LEDS];
bool animationStarted = false;

// Chronomètre
unsigned long chronoStart = 0;
bool chronoRunning = false;
bool chronoStopped = false;
unsigned long elapsedTime = 0;

// Meilleur score
unsigned long bestTime = 999999;
const char* bestAnimal = "";

// OLED object
Adafruit_SSD1306 display(128, 64, &SPI, OLED_DC, OLED_RESET, OLED_CS);

// Attente relâchement bouton
void waitForButtonRelease() {
  while (digitalRead(BUTTON_PIN) == LOW) {
    delay(10);
  }
  delay(50);  // anti-rebond
}

void setup() {
  pinMode(BUTTON_PIN, INPUT_PULLUP);
  FastLED.addLeds<WS2812B, DATA_PIN, GRB>(leds, NUM_LEDS);
  FastLED.setBrightness(BRIGHTNESS);
  fill_solid(leds, NUM_LEDS, CRGB::Black);
  FastLED.show();

  if (!display.begin(SSD1306_SWITCHCAPVCC)) while (true);
  display.clearDisplay();
  display.setTextSize(1);
  display.setTextColor(SSD1306_WHITE);
  Serial.begin(9600);
}

void loop() {
  if (digitalRead(BUTTON_PIN) == LOW && !animationStarted && !chronoRunning) {
    delay(50);
    if (digitalRead(BUTTON_PIN) == LOW) {
      animationStarted = true;
      runAnimation();
      waitForButtonRelease();
      animationStarted = false;
    }
  }

  if (digitalRead(BUTTON_PIN) == LOW && chronoRunning) {
    delay(50);
    if (digitalRead(BUTTON_PIN) == LOW) {
      chronoRunning = false;
      chronoStopped = true;
      elapsedTime = millis() - chronoStart;
      fill_solid(leds, NUM_LEDS, CRGB::Black);
      FastLED.show();
      waitForButtonRelease();
      displayTimeAndHandleRecord(elapsedTime);
    }
  }
}

void runAnimation() {
  display.clearDisplay();
  display.setTextSize(2);
  display.setCursor(25, 10);
  display.print("Pret ?");
  display.display();
  delay(800);

  display.clearDisplay();
  display.setCursor(40, 30);
  display.print("GO !");
  display.display();
  delay(500);
  display.clearDisplay();

  for (int i = 0; i < NUM_LEDS; i++) {
    leds[i] = CRGB(80, 0, 0);
    FastLED.show();
    delay(50);
    leds[i] = CRGB::Black;
  }

  byte rebounds = random(2, 5);
  for (int r = 0; r < rebounds; r++) {
    for (int i = NUM_LEDS - 1; i >= 0; i--) {
      leds[i] = CRGB(80, 0, 0);
      FastLED.show();
      delay(50);
      leds[i] = CRGB::Black;
    }
    for (int i = 0; i < NUM_LEDS; i++) {
      leds[i] = CRGB(80, 0, 0);
      FastLED.show();
      delay(50);
      leds[i] = CRGB::Black;
    }
  }

  fill_solid(leds, NUM_LEDS, CRGB(0, 50, 0));
  FastLED.show();

  chronoStart = millis();
  chronoRunning = true;
  chronoStopped = false;
}

void displayTimeAndHandleRecord(unsigned long timeMs) {
  const char* animal = getAnimalFromTime(timeMs);
  bool newRecord = false;

  if (timeMs < bestTime) {
    bestTime = timeMs;
    bestAnimal = animal;
    newRecord = true;
  }

  if (newRecord) {
    sparkleAnimation(4000);  //  animation spéciale record
  }

  unsigned long startTime = millis();
  while (millis() - startTime < 10000) {
    if (digitalRead(BUTTON_PIN) == LOW) {
      delay(50);
      if (digitalRead(BUTTON_PIN) == LOW) {
        waitForButtonRelease();
        chronoRunning = false;
        chronoStopped = false;
        animationStarted = true;
        runAnimation();
        waitForButtonRelease();
        animationStarted = false;
        return;
      }
    }

    int offsetX = random(-2, 3);
    int offsetY = random(-1, 2);

    char buffer[16];
    sprintf(buffer, "%lu ms", timeMs);

    display.clearDisplay();
    display.setTextSize(2);
    display.setCursor((display.width() - strlen(buffer) * 12) / 2 + offsetX, 20 + offsetY);
    display.print(buffer);

    display.setTextSize(1);
    int16_t ax1, ay1;
    uint16_t aw, ah;
    display.getTextBounds(animal, 0, 0, &ax1, &ay1, &aw, &ah);
    int animalX = (display.width() - aw) / 2;
    int animalY = 50;
    display.setCursor(animalX, animalY);
    display.print(animal);

    display.display();
    delay(80);
  }

  while (true) {
    if (digitalRead(BUTTON_PIN) == LOW) {
      delay(50);
      if (digitalRead(BUTTON_PIN) == LOW) {
        waitForButtonRelease();
        chronoRunning = false;
        chronoStopped = false;
        animationStarted = true;
        runAnimation();
        waitForButtonRelease();
        animationStarted = false;
        return;
      }
    }

    display.clearDisplay();
    display.setTextSize(2);
    display.setCursor(30, 5);
    display.print("RECORD");

    char buffer[16];
    sprintf(buffer, "%lu ms", bestTime);
    display.setCursor(40, 25);
    display.print(buffer);

    display.setTextSize(1);
    int16_t ax1, ay1;
    uint16_t aw, ah;
    display.getTextBounds(bestAnimal, 0, 0, &ax1, &ay1, &aw, &ah);
    int animalX = (display.width() - aw) / 2;
    int animalY = 50;
    display.setCursor(animalX, animalY);
    display.print(bestAnimal);

    display.display();
    delay(100);
  }
}

void sparkleAnimation(unsigned long durationMs) {
  unsigned long start = millis();
  bool showText = true;

  const char* msg = "New Record";
  int16_t x1, y1;
  uint16_t w, h;
  display.getTextBounds(msg, 0, 0, &x1, &y1, &w, &h);
  int16_t xPos = (display.width() - w) / 2;
  int16_t yPos = 24;

  while (millis() - start < durationMs) {
    fill_solid(leds, NUM_LEDS, CRGB::Black);
    for (int i = 0; i < 2; i++) {
      leds[random(NUM_LEDS)] = CRGB::White;
    }
    FastLED.show();

    display.clearDisplay();
    if (showText) {
      display.setCursor(xPos, yPos);
      display.setTextSize(2);
      display.print(msg);
    }
    display.display();

    showText = !showText;
    delay(300);
  }

  fill_solid(leds, NUM_LEDS, CRGB::Black);
  FastLED.show();
}

const char* getAnimalFromTime(unsigned long timeMs) {
  if (timeMs >= 175 && timeMs < 200) return "Faucon";
  else if (timeMs >= 200 && timeMs < 225) return "Guépard";
  else if (timeMs >= 225 && timeMs < 250) return "Dauphin";
  else if (timeMs >= 250 && timeMs < 275) return "Poisson";
  else if (timeMs >= 275 && timeMs < 300) return "Chat";
  else if (timeMs >= 300 && timeMs < 325) return "Renard";
  else if (timeMs >= 325 && timeMs < 350) return "Écureuil";
  else if (timeMs >= 350 && timeMs < 400) return "Pieuvre";
  else if (timeMs >= 400 && timeMs < 500) return "Tortue marine";
  else if (timeMs >= 500 && timeMs <= 800) return "Paresseux";
  else if (timeMs > 1000) return "Pierre";
  else return "Erreur.. SONIC";
}

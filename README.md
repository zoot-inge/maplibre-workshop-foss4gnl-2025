<p>
  <img src="https://github.com/user-attachments/assets/c1264791-f990-4cdc-9ab7-a3c84de27ff5" height="80"/>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/b281133a-5df0-4006-b813-661405731151" height="80"/>
</p>

---

# Workshop: MapLibre GL JS voor Dummies

https://talks.osgeo.org/foss4gnl-2025/talk/8PVQLR/

We gaan een simpele kaart maken met een wandelroute.

Eindresultaat: https://louwers.github.io/maplibre-workshop-foss4gnl-2025/

## Fork the repository en start de ontwikkelomgeving

1. Ga naar https://github.com/louwers/maplibre-workshop-foss4gnl-2025
2. Klik op Fork.
3. In je eigen fork, ga naar "Code", klik op de "Codespaces" tab en start een "GitHub CodeSpace".
4. Open de Terminal...

## PMTiles Extract maken van Wageningen

1. De PMTiles CLI is al geïnstalleerd in je ontwikelomgeving.
2. Zoek de URL van de meest recente PMTiles planet basemap. https://docs.protomaps.com/basemaps/downloads
3. Zoek uit wat de bbox van Wageningen is.
4. Gebruik `pmtiles extract ...` in de command line om `wageningen.pmtiles` te maken.
5. Drag and drop je PMTiles-bestand in de [PMTiles Viewer](https://pmtiles.io/) om te controleren of het extracten gelukt is. Check ook `pmtiles show wageningen.pmtiles`.

---

<details>
  <summary>Bekijk antwoord</summary>

```
  "bounds": {
    "minlat": 51.9364055,
    "minlon": 5.6058239,
    "maxlat": 52.0007083,
    "maxlon": 5.7243627
  },
```

```
pmtiles extract https://build.protomaps.com/20250629.pmtiles wageningen.pmtiles --minzoom=10 --maxzoom=16 --bbox=5.6058239,51.9364055,5.7243627,52.0007083
```
</details>

## Wandelroute GeoJSON

TODO

## Assets voorbereiden

Maak een nieuwe directory:

```
mkdir assets
```

Plaats het `wanderling.geojson` document dat je in de vorige stap hebt gemaakt in die directory.

MapLibre heeft naast (vector)data verder nog nodig:

- Lettertypes (fonts) in een specifiek formaat
- Sprites voor icoontjes

```sh
# maak nieuwe map
mkdir assets
cd assets
wget https://github.com/protomaps/basemaps-assets/archive/refs/heads/main.zip
unzip main.zip
mv basemaps-assets-main/* .
rm main.zip
rmdir basemaps-assets-main
ls
```

## Stijl Downloaden en voorbereiden

## Web Development Omgeving Klaarmaken

Complexe JavaScript projecten moeten vaan gecompilieerd worden met een zogenaamde build tool.

Wij houden het simpel bij deze workshop, we gaan niks bouwen, we gebruiken twee bestanden: een `index.html` en een `main.js` bestand.

Eerst starten we echter een simpele web server met Python. Ga naar de terminal en typ het volgende.

```
python3 -m http.server
```

Nu start een web server op poort 8000. Als het goed is krijg je een popup, klik open in browser. Als je geen popup krijgt, ga naar de 'PORTS' tab en zorg dat je bij poort 8000 kan.

Als het goed is zie je nu een lijst bestanden.

<img width="359" alt="image" src="https://github.com/user-attachments/assets/c045be80-5268-48b6-bdb1-17921d411706" />

Maak nu een `index.html` bestand:

```html
<!doctype html>
<html>
  <head>
    <title>Mijn titel</title>
  </head>
  <body>
    <p>Hallo wereld!</p>
  </body>
</html>
```

Als je de pagina ververst zou je "Hallo wereld!" moeten zien.

Maak een `main.js` bestand en laad deze in `index.html` door de volgende lijn toe te voegen aan de `head`:

```html
<script type="module" src="main.js"></script>
```

Schrijf dit in je `main.js` bestand:

```js
console.log("Ook hallo wereld vanaf Javascript!");
```

Open de developer console in je browser. Waar dit precies moet verschilt per browser.

Als je dit ziet, dan heb je succesvol je web development omgeving opgezet!

<img width="988" alt="image" src="https://github.com/user-attachments/assets/cddcb40a-1c7b-4953-a9f9-a5e7cce37923" />

Nu ben je klaar op MapLibre GL JS toe te voegen aan je website. Maar eerst nog wat anders...

Zorg dat alle bestanden zijn gecommit en gepushed voordat je naar de volgende website gaat.

## Deploy je website

Ook al is je website nog niet heel spannend, we gaan hem nu al online zetten!

Ga naar de instellingen van je repository en zet GitHub Pages aan voor de `main` branch.

Als je nu naar de volgende URL gaat:

```
https://<gebruikersnaam>.github.io/maplibre-workshop-foss4gnl-2025/
```

Zou je als het goed is Hello world! moeten zien (en ook het bericht in de developer console).

## MapLibre GL JS voegen aan website

TODO

## Protomaps Basemap Style

In deze stap gaan we een interessantere stijl laden.

TODO

## Wandeling toevoegen aan kaart

- GeoJSON source toevoegen
- Line layer maken
- Leuke stijl toevoegen aan line layer

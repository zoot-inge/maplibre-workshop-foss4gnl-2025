<p>
  <img src="https://github.com/user-attachments/assets/c1264791-f990-4cdc-9ab7-a3c84de27ff5" height="80"/>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/b281133a-5df0-4006-b813-661405731151#gh-light-mode-only" height="80"/>
  <img src="https://github.com/user-attachments/assets/aa120a74-d6c3-43e2-8de0-d3a46a194647#gh-dark-mode-only" height="80"/>
</p>

---

# Workshop: MapLibre GL JS voor Dummies

https://talks.osgeo.org/foss4gnl-2025/talk/8PVQLR/

We gaan een simpele kaart maken met een wandelroute.

Eindresultaat: https://louwers.github.io/maplibre-workshop-foss4gnl-2025/

## Delen

Om het overzicht te bewaren hebben we de workshop opgedeeld in verschillende delen.

Zorg ervoor dat je een deel hebt afgerond voordat je naar het volgende gaat.

- [Deel 1: Ontwikkelomgeving opzetten](./deel_01.md).
- [Deel 2: Website Deployen](./deel_02.md).

## PMTiles Extract maken van Wageningen

> [!TIP]
> Het is handig als je de bbox van Wageningen weet. Er zijn veel wegen die naar Rome leiden. Ik heb de [OSM relatie](https://www.openstreetmap.org/relation/418758) opgezocht en de volgende Overpass query gebruikt (volgende workshop!).
> ```
> [out:json];
> rel(334228);
> out bb;
> ```
>
> Of ga naar de website http://bboxfinder.com/ (er is geen https), zoom naar Wageningen, zet de EPSG code op 4326 (ipv 3857), klik het vierkant icoon, teken een bbox
> en kopieër deze in de "lon,lat,lon,lat" volgorde.
>
1. De PMTiles CLI, het programma `pmtiles`, is al geïnstalleerd in je ontwikkelomgeving.
2. Doe `pmtiles --help` om de verschillende commando's te zien.
3. Zoek de URL van de meest recente PMTiles planet basemap. https://docs.protomaps.com/basemaps/downloads
4. Zoek uit wat de bbox van Wageningen is. 
5. Gebruik `pmtiles extract <PMTiles URL> wageningen.pmtiles --bbox=...` in de command line om `wageningen.pmtiles` te maken.
6. Het bestand zal (linksboven) te zien zijn. Check met `ls -lh wageningen.pmtiles` en ` pmtiles show wageningen.pmtiles`.
7. Drag and drop je PMTiles-bestand in de [PMTiles Viewer](https://pmtiles.io/) om te controleren of het extracten gelukt is. Daartoe moet je het bestand (paar MB) even downloaden naar je computer: rechtermuis op bestand, dan `Download...`.

<img width="1483" alt="image" src="https://github.com/user-attachments/assets/47b1667a-bb28-48bf-8b01-e99a9c2cc1d8#gh-light-mode-only" />

<img width="1483" alt="image" src="https://github.com/user-attachments/assets/a6e697c7-038f-4840-98f2-936c27f7faad#gh-dark-mode-only" />

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

Zoek een wandelroute in/rond Wageningen. Om deze straks in MapLibre te tonen hebben we de route als GeoJSON bestand nodig. 
Er zijn meerdere mogelijkheden om daartoe te komen. Hieronder de weg die @justb4 gevolgd heeft:

1. Ga naar [hiking.waymarkedtrails.org](https://hiking.waymarkedtrails.org/). Dit zijn alle wandelroutes in OSM.
2. Linksonder in de Search box voer in "Wageningen".
3. In resultaat verschillende routes, m.n. "Wageningen On The Move" (WOTM). Kies bijvoorbeeld (rechtsboven) de Rode Route. Je kunt de route als GPX of KML bestand downloaden, maar dan zul je zelf moeten converteren. Met de OSM "Overpass" API kun je direct GeoJSON opvragen.
4. Rechtsboven zie je "Relation <nummer>" 
5. Kopieër dat Relatie Nummer
6. Ga naar de website: https://overpass-turbo.eu/#
7. Voer daar in linker venster de volgende code in:

```
/* Wageningen On The Move Rood Trail */
[out:json][timeout:25];

// Store the relation
rel(<RELATIE_NUMMER>)->.rel;

// Get member ways and their nodes
(
  way(r.rel);
  node(w); // nodes of the ways
)->.ways_and_nodes;

// Get member nodes that are *direct* members of the relation
node(r.rel)->.standalone_nodes;

// Combine all
(
  .ways_and_nodes;
  .standalone_nodes;
);
out body;
```

In `<RELATIE_NUMMER>` vul je het route OSM Relation nummer in. Klik op `Run` button.

8. Als gelukt is, gaan we de GeoJSON via clipboard in een nieuw bestand brengen.

9. Klik op `Export` en kies data 'GeoJSON' 'Copy'
10. Maak nieuw bestand aan, bijv `wageningen.geojson`.
11. Open dit lege bestand in editor. 
12. 'Paste' de GeoJSON uit clipboard in de editor

Nu hebben we een wandelroute als GeoJSON bestand!

## Assets voorbereiden

Maak een nieuwe directory:

```
mkdir assets
```

Plaats het `wandeling.geojson` document dat je in de vorige stap hebt gemaakt in die directory.

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

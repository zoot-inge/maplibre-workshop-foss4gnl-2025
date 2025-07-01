<p>
  <img src="https://github.com/user-attachments/assets/c1264791-f990-4cdc-9ab7-a3c84de27ff5" height="80"/>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/b281133a-5df0-4006-b813-661405731151#gh-light-mode-only" height="80"/>
  <img src="https://github.com/user-attachments/assets/aa120a74-d6c3-43e2-8de0-d3a46a194647#gh-dark-mode-only" height="80"/>
</p>

---

# Workshop: MapLibre GL JS voor Dummies

https://talks.osgeo.org/foss4gnl-2025/talk/8PVQLR/

We gaan een simpele self-hosted kaart maken met een wandelroute.

Eindresultaat: https://louwers.github.io/maplibre-workshop-foss4gnl-2025/

## Delen

Om het overzicht te bewaren hebben we de workshop opgedeeld in verschillende delen.

Zorg ervoor dat je een deel hebt afgerond voordat je naar het volgende gaat.

- [Deel 1: Ontwikkelomgeving opzetten](./deel_01.md).
- [Deel 2: Website Deployen](./deel_02.md).
- [Deel 3: PMTiles Extract maken van Wageningen](./deel_03.md).

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

## Protomaps Basemap Style

In deze stap gaan we een interessantere stijl laden.

TODO

## Wandeling toevoegen aan kaart

- GeoJSON source toevoegen
- Line layer maken
- Leuke stijl toevoegen aan line layer

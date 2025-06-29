<p>
  <img src="https://github.com/user-attachments/assets/c1264791-f990-4cdc-9ab7-a3c84de27ff5" height="80"/>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/b281133a-5df0-4006-b813-661405731151" height="80"/>
</p>

---

# Workshop: MapLibre GL JS voor Dummies

https://talks.osgeo.org/foss4gnl-2025/talk/8PVQLR/


We gaan een simpele kaart maken met een wandelroute.

## PMTiles Extract maken van Wageningen

1. Download en installeer de PMTiles CLI tool.
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

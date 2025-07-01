## Deel 3: PMTiles Extract maken van Wageningen

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

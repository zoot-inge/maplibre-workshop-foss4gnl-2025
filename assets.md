# Protomaps Assets Toevoegen

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

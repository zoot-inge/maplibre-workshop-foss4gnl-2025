console.log("Ook hallo wereld vanaf Javascript!");
import * as maplibregl from "https://cdn.skypack.dev/maplibre-gl";//"https://esm.sh/maplibre-gl";

const map = new maplibregl.Map({
    container: 'mijnkaart', // container id
    style: 'https://demotiles.maplibre.org/style.json', // style URL
    center: [0, 0], // starting position [lng, lat]
    zoom: 1 // starting zoom
});
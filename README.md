# LoRaWAN
LoRaWAN signal quality

### Note

Please update the paths for the following image files in the `app.jl.html` file according to your folder structure:

- `/aircentre_logo.png`
- `/partners.png`

Azorean LoRaWAN Coverage Test Dashboard
This project is a replication and enhancement of the AIRCentre - Azorean LoRaWAN Network Coverage Tests application, originally visualizing LoRaWAN signal quality across land-based gateways in the Azores. It was developed using Genie.jl (a Julia web framework) to process, visualize, and interact with LoRaWAN communication data.

📡 Project Overview
The goal of this application is to provide a clear and interactive map-based representation of LoRaWAN signal quality across the Azores region using data from land-based gateways.

Signal quality is categorized based on RSSI (Received Signal Strength Indicator) and SNR (Signal-to-Noise Ratio), according to the following scale:

Signal Quality	RSSI	SNR
Very Poor	< -120 dBm	< -20 dB
Poor	-120 to -110 dBm	-20 to -10 dB
Fair	-110 to -100 dBm	-10 to 0 dB
Good	-100 to -90 dBm	0 to 10 dB
Excellent	> -90 dBm	> 10 dB

Note: If the RSSI and SNR fall into different categories, the lower signal quality category is used.

🌍 Features
Interactive map using Leaflet.js and Esri tiles

Visual classification of signal quality using color-coded markers

Real-time updates with signal measurement logs

Coordinates support using WGS84 format (decimal degrees with dots)

📍 Example Coordinates
Latitude: 38.637839

Longitude: -27.225527

🛠️ Tech Stack
Genie.jl – Julia full-stack web framework

Leaflet.js – Interactive maps

Esri Tiles – Basemap provider

Julia – Data processing and backend logic

🚀 Deployment
This project is designed for researchers, developers, and network engineers working with LoRaWAN technology and network coverage in remote or archipelagic regions like the Azores.

📁 Repository Structure
/app.jl – Julia backend logic

/public – Static assets (JS, CSS, images)

/app.jl.html – Frontend templates

/db_connection.jl - Connect to Database

config/ – Application configuration

Project.toml – Julia project environment


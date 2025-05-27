# # using Genie, Genie.Renderer.Html, Genie.Renderer.Json
# using MySQL, DBInterface

# include("db_connection.jl")

# # Enable CORS for development
# Genie.config.cors_headers["Access-Control-Allow-Origin"] = "*"
# Genie.config.cors_headers["Access-Control-Allow-Methods"] = "GET, POST, OPTIONS"
# Genie.config.cors_headers["Access-Control-Allow-Headers"] = "Content-Type"

# function show_map()
#     try
#         result = DBInterface.execute(DB, """
#         SELECT dev_eui, gw_eui, rssi_dbm, signal_quality, distance_to_gw_km, timestamp_utc_iso_string, dev_lat_deg_wgs84, dev_lon_deg_wgs84
#         FROM Vessel_location.events
#         WHERE dev_lat_deg_wgs84 IS NOT NULL AND dev_lon_deg_wgs84 IS NOT NULL
#         LIMIT 50
#         """)
#         points = [(row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8]) for row in result]
        
#         points_js = "[" * join(["""["$(point[1])","$(point[2])",$(point[3]),"$(point[4])",$(point[5]),"$(point[6])",$(point[7]),$(point[8])]""" for point in points], ", ") * "]"

#         # Read the HTML template
#         html_template = read("app.jl.html", String)
#         # Replace placeholder with points_js
#         html_content = replace(html_template, "<% points_js %>" => points_js)

#         return html(html_content)
#     catch e
#         @error "Error in show_map: $e"
#         return html("Error loading map: $e", status = 500)
#     end
# end

# route("/", show_map)

# route("/lookup", method = GET) do
#     try
#         lat = parse(Float64, params(:lat, "0"))
#         lon = parse(Float64, params(:lon, "0"))

#         # Validate input coordinates
#         if lat == 0.0 || lon == 0.0 || abs(lat) > 90 || abs(lon) > 180
#             return json(Dict("error" => "Invalid latitude or longitude"), status = 400)
#         end

#         # Query with Haversine formula for distance (in kilometers)
#         radius_km = 0.000005
#         result = DBInterface.execute(DB, """
#         SELECT 
#             dev_eui, 
#             gw_eui, 
#             rssi_dbm, 
#             signal_quality, 
#             distance_to_gw_km, 
#             timestamp_utc_iso_string, 
#             dev_lat_deg_wgs84, 
#             dev_lon_deg_wgs84
#         FROM Vessel_location.events
#         WHERE dev_lat_deg_wgs84 IS NOT NULL 
#         AND dev_lon_deg_wgs84 IS NOT NULL

#         LIMIT 50
#         """
#         )

#         points = [(row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8]) for row in result]
#         json(Dict("points" => points))
#     catch e
#         @error "Error processing lookup: $e"
#         json(Dict("error" => "Internal server error: $e"), status = 500)
#     end
# end

# # Health check route for debugging
# route("/health") do
#     json(Dict("status" => "Server running", "time" => now()))
# end

# Genie.config.run_as_server = true
# Genie.config.server_host = "127.0.0.1"
# Genie.config.server_port = 10101

# try
#     Genie.startup()
# catch e
#     @error "Failed to start server: $e"
#     rethrow(e)
# end




# using Genie, Genie.Renderer.Html, Genie.Renderer.Json
using MySQL, DBInterface

include("db_connection.jl")

# Enable CORS for development
Genie.config.cors_headers["Access-Control-Allow-Origin"] = "*"
Genie.config.cors_headers["Access-Control-Allow-Methods"] = "GET, POST, OPTIONS"
Genie.config.cors_headers["Access-Control-Allow-Headers"] = "Content-Type"

function show_map()
    try
        result = DBInterface.execute(DB, """
        SELECT dev_eui, gw_eui, rssi_dbm, signal_quality, distance_to_gw_km, timestamp_utc_iso_string, dev_lat_deg_wgs84, dev_lon_deg_wgs84
        FROM Vessel_location.events
        WHERE dev_lat_deg_wgs84 IS NOT NULL AND dev_lon_deg_wgs84 IS NOT NULL
        LIMIT 50
        """)
        points = [(row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8]) for row in result]
        
        points_js = "[" * join(["""["$(point[1])","$(point[2])",$(point[3]),"$(point[4])",$(point[5]),"$(point[6])",$(point[7]),$(point[8])]""" for point in points], ", ") * "]"

        # Read the HTML template
        html_template = read("app.jl.html", String)
        # Replace placeholder with points_js
        html_content = replace(html_template, "<% points_js %>" => points_js)

        return html(html_content)
    catch e
        @error "Error in show_map: $e"
        return html("Error loading map: $e", status = 500)
    end
end

route("/", show_map)

route("/lookup", method = GET) do
    try
        lat = parse(Float64, params(:lat, "0"))
        lon = parse(Float64, params(:lon, "0"))

        # Validate input coordinates
        if lat == 0.0 || lon == 0.0 || abs(lat) > 90 || abs(lon) > 180
            return json(Dict("error" => "Invalid latitude or longitude"), status = 400)
        end

        # Query with Haversine formula for distance (in kilometers)
        radius_km = 0.000005
        result = DBInterface.execute(DB, """
        SELECT 
            dev_eui, 
            gw_eui, 
            rssi_dbm, 
            signal_quality, 
            distance_to_gw_km, 
            timestamp_utc_iso_string, 
            dev_lat_deg_wgs84, 
            dev_lon_deg_wgs84
        FROM Vessel_location.events
        WHERE dev_lat_deg_wgs84 IS NOT NULL 
        AND dev_lon_deg_wgs84 IS NOT NULL

        LIMIT 50
        """
        )

        points = [(row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8]) for row in result]
        json(Dict("points" => points))
    catch e
        @error "Error processing lookup: $e"
        json(Dict("error" => "Internal server error: $e"), status = 500)
    end
end

# Health check route for debugging
route("/health") do
    json(Dict("status" => "Server running", "time" => now()))
end

Genie.config.run_as_server = true
Genie.config.server_host = "127.0.0.1"
Genie.config.server_port = 10101

try
    Genie.startup()
catch e
    @error "Failed to start server: $e"
    rethrow(e)
end


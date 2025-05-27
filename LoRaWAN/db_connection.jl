# db_connection.jl
using DBInterface, MySQL

const DB = DBInterface.connect(
    MySQL.Connection,
    "db-ro-mysql-lon1-81994-do-user-7425280-0.b.db.ondigitalocean.com",
    "AC-m2m",
    "evxbqyfc9yhv12vj";
    db = "Vessel_location",
    port = 25060,
    sslmode = "REQUIRED"
)
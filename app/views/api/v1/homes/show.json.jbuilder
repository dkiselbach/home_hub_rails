# frozen_string_literal: true

json.id @home.id
json.name @home.nw_lat
json.home_name @home.name
json.home_nw_lat_long [@home.nw_lat, @home.nw_long]
json.home_se_lat_long [@home.se_lat, @home.se_long]
json.created_at @home.created_at
json.updated_at @home.updated_at
json.user_ids @home.users.ids

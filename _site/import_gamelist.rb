require 'json'
require 'active_support/core_ext/hash'
require 'fileutils'

### CONFIG
platform = "c64"
export_path = "./test"
import_path = "./#{platform}-games-master"
### END CONFIG


cd = File.dirname(__FILE__)
roms_path = File.join(export_path, "roms/#{platform}")
data_path = File.join(export_path, "_data/roms")
roms_index = File.join(data_path, "#{platform}.json")
gamelist_path = File.join(import_path, "gamelist.xml")

[export_path, roms_path, data_path].each { |p| FileUtils.mkdir_p p }

doc = Hash.from_xml(File.read(gamelist_path))

games = doc["gameList"]["game"]

converted_games = games.map { |game|
  rom_path = File.join(import_path, game["path"])
  key = File.basename(rom_path, File.extname(game["path"]))
  base_dir = File.join(roms_path, key)
  screenshots_dir = File.join(base_dir, "screenshots")
  [base_dir, screenshots_dir].each { |p| FileUtils.mkdir_p p }

  #copy files
  files_to_copy = Dir[File.join(import_path, "#{key}.*")]
  screenshots = []
  files_to_copy.each do |filename|
    is_screenshot = File.extname(filename) == ".png"
    file_basename = File.basename(filename)
    screenshots.push("/roms/#{platform}/#{key}/screenshots/#{file_basename}") if is_screenshot

    dest_dir = if is_screenshot then screenshots_dir else base_dir end
    dest_path = File.join(dest_dir, file_basename)

    FileUtils.cp(filename, dest_path)
  end

  min_players = if /\d-\d/.match(game["players"]) then game["players"].split('-')[0] else game["players"] end
  max_players = if /\d-\d/.match(game["players"]) then game["players"].split('-')[1] else game["players"] end

  ext = File.extname(game["path"])

  #return json for index
  {
    "added" => Date.today().to_s,
    "key" => key,
    "platform" => platform,
    "title" => game["name"],
    "released" => Date.parse(game["releasedate"]).to_s,
    "description" => game["desc"],
    "screenshots" => screenshots,
    "detailsLink" => "/roms/#{platform}/#{key}/",
    "romLink" => "/roms/#{platform}/#{key}/#{key}#{ext}",
    "authorString" => game["developer"],
    "minPlayers" => min_players.to_i,
    "maxPlayers" => max_players.to_i
  }
}

existing_roms = if File.exists?(roms_index) then JSON.parse(File.read(roms_index)) else [] end

existing_keys = existing_roms.map { |rom| rom["key"] }

converted_games.take_while { |rom| existing_keys.include?(rom["key"]) }.each do |rom|
  title = rom["title"]
  key = rom["key"]
  puts "\"#{title}\" not added: key \"#{key}\" already exists"
end

all_roms = existing_roms + converted_games.drop_while { |rom| existing_keys.include?(rom["key"]) }

File.open(roms_index,"w+") do |f|
  puts "Writing to #{roms_index}"
  f.write(all_roms.to_json)
end

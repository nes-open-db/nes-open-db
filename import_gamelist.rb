require 'json'
require 'active_support/core_ext/hash'
require 'fileutils'


cd = File.dirname(__FILE__)

export_path = File.join(cd, "test")
roms_path = File.join(export_path, "roms")
data_path = File.join(export_path, "_data")
roms_index = File.join(data_path, "roms_index.json")
import_path = "./nes-games-master"
gamelist_path = File.join(import_path, "gamelist.xml")

[export_path, roms_path, data_path].each { |p| FileUtils.mkdir_p p }

#puts "Platform?"
platform = "nes" #gets.chomp
rom_extension = "nes"

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
    screenshots.push("/roms/#{key}/screenshots/#{file_basename}") if is_screenshot

    dest_dir = if is_screenshot then screenshots_dir else base_dir end
    dest_path = File.join(dest_dir, file_basename)

    FileUtils.cp(filename, dest_path)
  end

  #return json for index
  {
    "key" => key,
    "platform" => platform,
    "title" => game["name"],
    "description" => game["desc"],
    "screenshots" => screenshots,
    "romLink" => "/roms/#{key}/#{key}.#{rom_extension}"
  }
}

File.open(roms_index,"w") do |f|
  puts "Writing to #{roms_index}"
  f.write(converted_games.to_json)
end


#doc.xpath('//gameList/game').each do |node|
#    puts .to_json
#end

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

doc = Hash.from_xml(File.read(gamelist_path))


games = doc["gameList"]["game"]

converted_games = games.map { |game|
  rom_path = File.join(import_path, game["path"])
  key = File.basename(rom_path, File.extname(game["path"]))

  #copy files
  dest_dir = File.join(roms_path, key)
  FileUtils.mkdir_p dest_dir
  files_to_copy = Dir[File.join(import_path, "#{key}.*")]
  files_to_copy.each do |filename|
    FileUtils.cp(filename, File.join(dest_dir, File.basename(filename)))
  end

  #return json for index
  {
    "key" => key,
    "platform" => platform,
    "title" => game["name"],
    "description" => game["desc"]
  }
}

File.open(roms_index,"w") do |f|
  puts "Writing to #{roms_index}"
  f.write(converted_games.to_json)
end


#doc.xpath('//gameList/game').each do |node|
#    puts .to_json
#end

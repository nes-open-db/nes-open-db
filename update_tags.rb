require 'json'

tags = JSON.parse(File.read("./_data/roms/nes.json"))
  .map { |rom| rom["tags"] or [] }
  .flatten
  .uniq
  .map { | tag | { "tag" => tag } }

File.open("./_data/tags.json", "w") { |f|
  f.puts tags.to_json
}
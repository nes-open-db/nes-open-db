
for f in _data/roms/*.json
do
  ajv validate -s _data/roms_index.schema.json -d $f --all-errors --verbose
done

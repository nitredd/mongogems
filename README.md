# Mongo Gems

## Installing

Install by running:

`gem install mongogems`

Needs Ruby installed.

## compass2mongosh

Converts the MongoDB saved pipeline to a Mongo shell script

Example: `compass2mongosh --input=19031955.js --output=20091983.js`

See notes for the filesystem path of the saved pipelines.

## mongoindex2file

Generates a script to re-create indexes for a collection

Example: `mongoindex2file --uri='mongodb://localhost' -d test -c person -o person_idx.js` 

## mongolog2file

Fetches the log from the MongoDB instance and writes to a file

Example: `mongolog2file --uri='mongodb://localhost' -o mongod.log`

# Notes

Paths for the MongoDB Compass Saved Aggregation Pipelines
* **Windows**: `%APPDATA%/MongoDB Compass/SavedPipelines`
* **macOS**:  `~/Library/Application Support/MongoDB Compass/SavedPipelines`
* **Linux**: `~/.config/MongoDB Compass/SavedPipelines`

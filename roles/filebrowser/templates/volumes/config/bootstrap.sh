/filebrowser version

if [ ! -f database.db ]; then
  /filebrowser config import /config/settings.json
fi

# Remove default config
rm /.filebrowser.json

/filebrowser

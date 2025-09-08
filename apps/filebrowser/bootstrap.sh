filebrowser version

if [ ! -f /database/database.db ]; then
  filebrowser config import /config/settings.json
fi

exec filebrowser
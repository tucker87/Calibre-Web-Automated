#!/bin/bash

# Make required directories and files for metadata enforcment
make_dirs () {
    mkdir /app/calibre-web-automated/metadata_change_logs
    chown -R abc:abc /app/calibre-web-automated/metadata_change_logs
    mkdir /app/calibre-web-automated/metadata_temp
    chown -R abc:abc /app/calibre-web-automated/metadata_temp
    mkdir /app/calibre-web-automated/cwa-import
    chown -R abc:abc /app/calibre-web-automated/cwa-import
    mkdir /cwa-book-ingest
    chown abc:abc /cwa-book-ingest
    mkdir /calibre-library
    chown abc:abc /calibre-library
    mkdir /config/.cwa_conversion_tmp
    chown abc:abc /config/.cwa_conversion_tmp
    mkdir /config/processed_books
    chown abc:abc /config/processed_books
    mkdir /config/processed_books/imported
    chown abc:abc /config/processed_books/imported
    mkdir /config/processed_books/failed
    chown abc:abc /config/processed_books/failed
    mkdir /config/processed_books/converted
    chown abc:abc /config/processed_books/converted
}

# Change ownership & permissions as required
change_script_permissions () {
    chmod +x /app/calibre-web-automated/scripts/check-cwa-install.sh
    chmod +x /etc/s6-overlay/s6-rc.d/cwa-ingest-service/run
    # chmod +x /etc/s6-overlay/s6-rc.d/new-book-detector/run
    chmod +x /etc/s6-overlay/s6-rc.d/metadata-change-detector/run
    chmod +x /etc/s6-overlay/s6-rc.d/cwa-set-perms/run
    chmod +x /etc/s6-overlay/s6-rc.d/auto-library/run
    chmod 775 /app/calibre-web/cps/editbooks.py
    chmod 775 /app/calibre-web/cps/admin.py
}

# Add aliases to .bashrc
add_aliases () {
    echo "" | cat >> ~/.bashrc
    echo "# Calibre-Web Automated Aliases" | cat >> ~/.bashrc
    echo "alias cwa-check='bash /app/calibre-web-automated/scripts/check-cwa-install.sh'" | cat >> ~/.bashrc
    echo "alias cwa-change-dirs='nano /app/calibre-web-automated/dirs.json'" | cat >> ~/.bashrc
    
    echo "cover-enforcer () {" | cat >> ~/.bashrc
    echo '    python3 /app/calibre-web-automated/scripts/cover-enforcer.py "$@"' | cat >> ~/.bashrc
    echo "}" | cat >> ~/.bashrc
    
    echo "convert-library () {" | cat >> ~/.bashrc
    echo '    python3 /app/calibre-web-automated/scripts/convert-library.py "$@"' | cat >> ~/.bashrc
    echo "}" | cat >> ~/.bashrc
    
    source ~/.bashrc
}

echo "Running docker image setup script..."
make_dirs
change_script_permissions
add_aliases
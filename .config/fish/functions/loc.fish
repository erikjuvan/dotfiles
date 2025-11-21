# -----------------------------------------------------------------------------
# loc.fish
#
# A "locate"-style helper function for MSYS2 / WSL / fish on Windows.
# 
# Features:
#   - Maintains a separate locate database per folder (based on folder path hash)
#   - Quick filename searches using the cached database
#   - Supports `--update` flag to force regeneration of the database
#   - Ignores case in searches
#
# Usage:
#   loc <search_term>             # Search using the cached DB for the current folder
#   loc --update <search_term>    # Force update of the DB and then search
#
# Implementation notes:
#   - Uses md5sum of the current folder path to generate a unique DB file
#   - Stores DB files in /tmp
#   - Tested under MSYS2 on Windows, using fish shell
#   - Compatible with long Windows paths mounted in MSYS2
#
# Example:
#   cd /e/Books/Programming
#   loc --update main.c
# -----------------------------------------------------------------------------
function loc
    # Unique DB filename per folder
    set dir_hash (echo (pwd) | md5sum | cut -d' ' -f1)
    set db_file /tmp/loc_$dir_hash.db

    # Check for --update flag
    set force_update 0
    set new_argv
    for arg in $argv
        if test $arg = '--update'
            set force_update 1
        else
            set new_argv $new_argv $arg
        end
    end
    set argv $new_argv

    # Update DB if it doesn't exist OR --update passed
    if not test -f $db_file; or test $force_update -eq 1
        echo "Updating locate DB for (pwd)..."
        updatedb --localpaths=(pwd) --output=$db_file
        echo "Done updating DB: $db_file"
    end

    # Run locate using this folder’s DB
    locate --ignore-case --database=$db_file $argv
end
funcsave loc

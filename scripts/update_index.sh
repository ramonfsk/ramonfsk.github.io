#!/bin/bash

CONTENT_DIR="../content"
INDEX_FILE="$CONTENT_DIR/_index.md"

# Create header of index file
cat > "$INDEX_FILE" << EOF
---
title: Ramon's Blog
---
EOF

# Find all markdown files (excluding _index.md), sort them by date
find "$CONTENT_DIR" -name "*.md" ! -name "_index.md" | while read -r file; do
    # Extract date from path (YYYY/MM/DD)
    if [[ $file =~ ([0-9]{4})/([0-9]{2})/([0-9]{2}) ]]; then
        year="${BASH_REMATCH[1]}"
        month="$(date -j -f "%m" "${BASH_REMATCH[2]}" "+%B")"
        
        # Extract title from frontmatter - looking for the line after "title: "
        title=$(sed -n '/^title:/s/^title: //p' "$file")
        
        # Get relative path without 'index' at the end
        rel_path=${file#"$CONTENT_DIR/"}
        rel_path=${rel_path%/index.md}
        
        # Store in array with date for sorting
        if [ ! -z "$title" ]; then
            echo "$year $month|$title|$rel_path"
        fi
    fi
done | sort -r | awk -F'|' '
    {
        year_month = $1
        if (year_month != prev_year_month) {
            print "\n## " year_month
            prev_year_month = year_month
        }
        print "- [" $2 "](" $3 ")"
    }
' >> "$INDEX_FILE"
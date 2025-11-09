#!/bin/bash

CONTENT_DIR="../content"
INDEX_FILE="$CONTENT_DIR/_index.md"

# Enable debug mode
set -x

# Create header of index file
cat > "$INDEX_FILE" << EOF
---
title: Ramon's Blog
---
EOF

# First, collect and sort all year/month combinations in reverse order (newest first)
find "$CONTENT_DIR" -type f -name "*.md" ! -name "_index.md" | while read -r file; do
    if [[ $file =~ ([0-9]{4})/([0-9]{2}) ]]; then
        # Create sortable string with year and month
        year="${BASH_REMATCH[1]}"
        month="${BASH_REMATCH[2]}"
        month_name="$(date -j -f "%m" "$month" "+%B")"
        echo "${year}${month}|${year} ${month_name}"
    fi
done | sort -nr | uniq > /tmp/months.txt

# Then process files for each month
while IFS='|' read -r sort_key year_month; do
    echo -e "\n## $year_month" >> "$INDEX_FILE"
    
    year=${sort_key:0:4}
    month=${sort_key:4:2}
    
    # Find and sort posts for this month
    find "$CONTENT_DIR" -type f -name "*.md" ! -name "_index.md" | while read -r file; do
        if [[ $file =~ $year/$month/([0-9]{2}) ]]; then
            day="${BASH_REMATCH[1]}"
            title=$(grep -m 1 "^title:" "$file" | sed 's/^title: *//')
            rel_path=${file#"$CONTENT_DIR/"}
            rel_path=${rel_path%/index.md}
            
            if [ ! -z "$title" ]; then
                echo "${day}|${title}|${rel_path}"
            fi
        fi
    done | sort -nr | while IFS='|' read -r day title path; do
        echo "- [$title]($path)" >> "$INDEX_FILE"
    done
done < /tmp/months.txt

rm /tmp/months.txt
set +x
#!/bin/bash

# Get todays date.
post_date=$(date +"%Y-%m-%d")

# Grab the post title from the user's input.
read -p "Enter post title: " post_title

# Slugify the post title.
slugified_title=$(echo "$post_title" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

# Create a directory for the post.
mkdir "$post_date-$slugified_title"

# Add a .md using the below template.
touch "$post_date-$slugified_title/$slugified_title.md"
cat > "$post_date-$slugified_title/$slugified_title.md" <<EOF
---
title: "$post_title"
description: "This is a description."
date: $post_date
---
EOF

# Done.

#!/bin/bash


####################################
# SETUP
####################################

# Set the path to the Retail World of Warcraft Addons folder
WOW_ADDONS_FOLDER="D:/World of Warcraft/_retail_/Interface/AddOns"

WEBSITE_URL="https://www.tukui.org/download.php?ui=elvui"

####################################
# PART 1
####################################
# Download the website's HTML
curl -L $WEBSITE_URL -o website.html

# Use grep to find all links in the HTML
LINKS=$(grep -oP '(?<=<a).*?(?=">)' website.html)

# Extract the hrefs from the links
HREFS=$(echo "$LINKS" | grep -oP '(?<=href=").*?(?=")')

# Print all the hrefs to the console
ZIP_URL="https://www.tukui.org$(echo "$HREFS" | grep -P '\.zip$')"

# Clean up by deleting the downloaded HTML file
rm website.html

####################################
# PART 2
####################################

# Download the latest version of ElvUI
echo "downloading $ZIP_URL"
curl -L $ZIP_URL -o elvui-latest.zip

# Extract the downloaded file
echo "extracting to $WOW_ADDONS_FOLDER"
unzip -o elvui-latest.zip -d "$WOW_ADDONS_FOLDER"

# Clean up by deleting the downloaded and extracted files
echo "cleaning up..."
rm -rf elvui-latest.zip
echo "done!"
#!/bin/sh
echo "Previous tag of image:"
read previous_tag
echo "New tag of image:"
read new_tag

docker build -t alisoltanics/vision:$new_tag .
docker push alisoltanics/vision:$new_tag
echo "✅ New image 'vision:$new_tag' pushed to the Docker Hub."

# replace old tag with new tag in all files
grep -rl $vision:$previous_tag . | xargs sed -i "s/$vision:$previous_tag/$vision:$new_tag/g"
echo "✅ Tags changed in all files."

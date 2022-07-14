#!/bin/sh
previous_tag='1.1'

echo "New tag of image:"
read new_tag

# set previous_tag, don't change line 2.
sed -i "2s/^.*$/previous_tag='${new_tag}'/" scripts/push-new-image.sh

docker build -t alisoltanics/vision:$new_tag .
docker push alisoltanics/vision:$new_tag
echo "⁓	⁓	⁓	⁓	⁓	⁓	⁓	⁓	⁓	⁓	"
echo "✅ New image 'vision:$new_tag' pushed to the Docker Hub."

# replace old tag with new tag in all files
grep -rl $vision:$previous_tag . | xargs sed -i "s/$vision:$previous_tag/$vision:$new_tag/g"
echo "✅ Tags changed in all files."

echo "⁓	⁓	⁓	⁓	⁓	⁓	⁓	⁓	⁓	⁓	"
kubectl apply -f kubernetes/postgres/
echo "⁓	⁓	⁓	⁓	⁓	⁓	⁓	⁓	⁓	⁓	"
kubectl delete -f kubernetes/django/migration.yml
echo "⁓	⁓	⁓	⁓	⁓	⁓	⁓	⁓	⁓	⁓	"
kubectl apply -f kubernetes/django/

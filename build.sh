# Build dependencies:
# * sh
# * compiler.jar - Google closure js minifier
# * CoffeeScript

echo "Building dombrew.js..."
coffee -p dombrew.coffee > dombrew.js

echo "Building dombrew.min.js..."
java -jar compiler.jar --js dombrew.js > dombrew.min.js

echo "Building dombrew.min.js.gz to check the size..."
gzip -c9 dombrew.min.js > dombrew.min.js.gz

echo "Done:"
du -bh dombrew.js dombrew.min.js dombrew.min.js.gz
rm dombrew.min.js.gz
# Build dependencies:
# * sh
# * compiler.jar - Google closure js minifier
# * CoffeeScript

echo "Building dombrew.js..."
coffee -p dombrew.coffee > dombrew.js

echo "Building dombrew.min.js..."
java -jar compiler.jar --js dombrew.js > dombrew.min.js

echo "Done:"
du -bh dombrew.js dombrew.min.js
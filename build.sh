# Build dependencies:
# * sh
# * UglifyJS (npm install uglify-js)
# * CoffeeScript

echo "Building dombrew.js..."
coffee -bp dombrew.coffee > dombrew.js

echo "Building dombrew.min.js..."
#java -jar compiler.jar --js dombrew.js > dombrew.min.js
uglify-js -nc --unsafe dombrew.js > dombrew.min.js

echo "Building dombrew.min.js.gz to check the size..."
gzip -c9 dombrew.min.js > dombrew.min.js.gz

echo "Done:"
du -bh dombrew.js dombrew.min.js dombrew.min.js.gz
rm dombrew.min.js.gz

# DOMBrew

You probably should be using client-side templating instead of building DOM directly.
Still, if you have to, here is DOMBrew, a tiny dom builder:

*[CoffeeScript](http://jashkenas.github.com/coffee-script/) below*

    # DOMBrew builds DOM from a css like selector and a hash of attributes.
    # 1. alias it to a short variable
    $b = DOMBrew

    # 2. Construct an element like this:
    $b('span#hello.notice', 'Hello World').dom()
    # => <span id="hello" class="notice">Hello World</span>

    #    or like this:
    $b('form#search-user-by-email')
      .append(        
        $b 'input.autocomplete', name: 'email', type: 'text', data: { autocompleteSource: '/users/search-by-email.json' }
        $b 'button', 'Search'
      ).dom()
    
    # <form id="search-user-by-email">​
    #   <input class="autocomlpete' name="email" type="text" data-autocomplete-source"="/users/search-by-email.json">
    #   <button>Search</button>
    #  </form>
    
    # Or build on the existing DOM element
    $b($('#item-title')[0])
      .prepend($b 'button.icon.fav-star', title: 'Add to favourites')
      .append($b 'button.hide', 'Hide')

    # To get html as a string:
    $b('#container').html() 
    # => "<div id="container"></div>"
    
    # To get as a dom node/fragment:
    $b('#container').dom()
    # => HTMLDivElement

    # == TL;DR: ==
    #
    #= Build nodes:
    #
    #  $b "a#my-id.some-class", "hello world!", href: "/hello.html"
    #  $b "#cont", class: ["cls1", "cls2"], data: { someProp: "hi", dat2: "hello" }
    #  $b "text", "hello world!" # <- to build a text node
    #
    #= Append/prepend children:
    #
    #  .append(children... or [children...])
    #  .prepend(children... or [children...])
    #
    #= Access existing nodes as a DOMBrew object:
    #
    #  $b document.getElementById("my-elem") # <- 1 DOM node
    #  $b(nodes... or [nodes...])            # <- wrap multiple DOMBrew nodes (uses awesome DocumentFragment internally)
    #
    #= Get results:
    #
    #  .dom()   # => result as DOM
    #  .html()  # => result as html in a string

---
## Contribute

Fork. Develop. Extra points for tests (see test.html). :)

You will need node and coffee-script installed:

* Follow these instructions to install node and npm: https://github.com/joyent/node/wiki/Installation
* npm install -g coffee-script

# Changelog / What's new

v1.4.6

* css: null and undefined values are skipped

v1.4.5

* #append and #prepend skip falsy values

v1.4.4

* $b(nodes...) supports mixed DOMBrew/HTMLElement

v1.4.3:

* more IE compat

v1.4.2:

* IE6 compat

v1.4.1:

* IE7 $b(nodes...) fix

v1.4:

* Complete support for data attributes ( { data: {someProp: "x"} } => (data-some-prop="x") )
* Deprecated: .asDOM() and .asHTML()
* Removed: experimental jQueryIntegrate
* Default minifier changed to UglifyJS (from Google Closure)
* Documentation update

v1.3:

* css attribute support
* $b(nodeName, test, attr) API
* $b(DOMElement) API

v1.2:

* .prepend(children... or [children...])
* experimental jQuery integration (opt-in)

v1.1:

* $b(nodes...) syntax
* performance improvements
* tests
* 2.2 KB minified

v1.0:

Initial release

# Credits:

* DOMBrew started off as a CoffeeScript rewrite of skyzyx's DOMBuilder https://github.com/skyzyx/dombuilder

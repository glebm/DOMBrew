# DOMBrew

You probably should be using client-side templating instead of building DOM directly. If not, here is DOMBrew, a tiny dom builder:

*Introduction with [CoffeeScript](http://jashkenas.github.com/coffee-script/) examples*

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
        
### build nodes
    
    # it's your responsibility to alias DOMBrew to a short variable:        
    $b = DOMBrew
    
    # build with css-like selector, (optional) text content, and attributes
    node = $b "a#my-id.some-class", "hello world!", href: "/hello.html"
    # classes will be flattened and joined, data- will be hyphenized 
    node = $b "#cont", class: ["cls1", "cls2"], data: { someProp: "hi", dat2: "hello" }
    # use 'text' to build a simple text node
    node = $b "text", "hello world!" # <- to build a text node

    # you can wrap a dom element as $b node
    $b document.getElementById("my-elem") # <- 1 DOM node
    $b(nodes... or [nodes...])            # <- wrap multiple DOMBrew nodes (uses awesome DocumentFragment internally)

### append / prepend children
    
    # append / prepend children ($b nodes and / or dom elements)    
    node.append(children... or [children...])
    node.prepend(children... or [children...])
        
### get the data
    
    node.dom()   # result as DOM
    node.html()  # result as html in a string
    
    # you can add jq() if you use jQuery
    $b::jq = -> jQuery @dom()
    node.jq() # now you can


## Inspiration

* DOMBrew started off as a CoffeeScript rewrite of skyzyx's DOMBuilder https://github.com/skyzyx/dombuilder

## Contribute

Tests are in `test.html`
You will need node and coffee-script installed:

* Follow these instructions to install node and npm: https://github.com/joyent/node/wiki/Installation
* npm install -g coffee-script


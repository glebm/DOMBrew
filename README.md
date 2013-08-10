# DOMBrew

You probably should be using client-side templating instead of building DOM directly. If not, here is DOMBrew, a tiny dom builder:

### DOMBrew is kind of long, but you can alias it
        
    $b = DOMBrew 

### build nodes
    
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
    
    # now you can
    node.jq() 


Some more examples below

   
    $b('form#search-user-by-email')
      .append(        
        $b 'input.autocomplete', name: 'email', type: 'text', data: { emailSrc: '/user-emails.json' }
        $b 'button', 'Search', class: %w(btn btn-primary)
      ).dom()
    
    # <form id="search-user-by-email">​
    #   <input class='autocomplete' name='email' type='text' data-email-src='/user-emails.json'>
    #   <button class='btn btn-primary'>Search</button>
    #  </form>
    
    # prepend / append
    $b(document.getElementById 'item-title')
      .prepend($b 'button.icon.fav-star', title: 'Add to favourites')
      .append($b 'button.hide', 'Hide')

    # get
    $b('#container').html() # "<div id="container"></div>"        
    $b('#container').dom()  #  HTMLDivElement
        

## Inspiration

* DOMBrew started off as a CoffeeScript rewrite of skyzyx's DOMBuilder https://github.com/skyzyx/dombuilder

## Contribute

Tests are in `test.html`
You will need node and coffee-script installed:

* Follow these instructions to install node and npm: https://github.com/joyent/node/wiki/Installation
* npm install -g coffee-script


# DOMBrew

You probably should be using client-side templating instead of building DOM directly. If not, here is DOMBrew, a tiny dom builder:

```coffeescript        
# alias to a short variable
$b = DOMBrew 
```    

### build nodes
    
```coffeescript
# build with css-like selector, (optional) text content, and attributes
node = $b "a#my-id.some-class", "hello world!", href: "/hello.html"
# classes will be flattened and joined, data- will be hyphenized 
node = $b "#cont", class: ["cls1", "cls2"], data: { someProp: "hi", dat2: "hello" }
# use .text to build a text node
node = $b.text('hello world!') # <- builds a text node
# same as
node = $b('', 'hello world!') # <- builds a text node

# you can wrap a dom element as $b node
$b document.getElementById("my-elem") # <- 1 DOM node
$b(nodes... or [nodes...])            # <- wrap multiple DOMBrew nodes (uses awesome DocumentFragment internally)
```

### append / prepend children
    
```coffeescript
# append / prepend children ($b nodes and / or dom elements)    
node.append(children... or [children...])
node.prepend(children... or [children...])
```
### get the data
    
```coffeescript    
node.dom()   # result as DOM
node.html()  # result as html in a string
```

### jQuery

```coffeescript    
# .$() to get as jquery node: node.$()
$b::$ = -> $ @dom()
$b.text('hello').$().wrap('<p>').appendTo(document.body)
```

More examples

```coffeescript       
$b('form#search-user-by-email')
  .append(        
    $b 'input.autocomplete', name: 'email', type: 'text', data: { emailSrc: '/user-emails.json' }
    $b 'button', 'Search', class: %w(btn btn-primary)
  ).html()
    
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
```        

## Inspiration

* DOMBrew started off as a CoffeeScript rewrite of skyzyx's DOMBuilder https://github.com/skyzyx/dombuilder

## Contribute

Tests are in `test.html`
You will need node and coffee-script installed:

* Follow these instructions to install node and npm: https://github.com/joyent/node/wiki/Installation
* npm install -g coffee-script


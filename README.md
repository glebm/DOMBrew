# DOMBrew

DOMBrew is a DOM builder written entirely in [CoffeeScript](http://jashkenas.github.com/coffee-script/)
The easiest way to install it is to grab dombrew.js from the repository.

    # DOMBrew builds DOM from a css like selector and a hash of attributes.
    # Normally you would alias it to a short variable
    $b = DOMBrew

    # Construct an element like this:
    $b('span#the-span.classy', 'Hello World').dom()
    # => <span id="the-span" class="classy">Hello World</span>

    # Or like this:
    $b('ul#container', html: 'My <b>awesome</b> list')
      .append(
        $b 'li#first', 'One'
        $b 'li', 'Two', data: { someProp: 'abc', otherProp: 'def' }
        $b 'li', 'Three', css: { display: 'none' }
        $b 'text', 'That is all'
      ).dom()
    
    # <ul id=​"container">​
    #   My <b>​awesome​</b>​ list
    #   <li id="first">
    #     ​One​
    #   </li>​
    #   <li data-some-prop=​"abc" data-other-prop=​"def">
    #     Two
    #   ​</li>​
    #   <li style="display: none">​
    #     Three​
    #   </li>​
    #   That is all
    # </ul>​

    # Or build on the existing DOM element
    $b($('#item-title')[0])
      .prepend($b 'button.icon.fav-star', title: 'Add to favourites')
      .append($b 'button.hide', 'Hide')

    # To get html as a string:
    $b('#container').html() 
    # => "<div id="container"></div>"

    # == TL;DR: ==
    #= Build nodes:
    #  $b "a#my-id.some-class", "hello world!", href: "/hello.html"
    #  $b "#cont", class: ["cls1", "cls2"], data: { someProp: "hi", dat2: "hello" }
    #  $b "text", "hello world!" # <- to build a text node
    #= Append/prepend children:
    #  .append(children... or [children...])
    #  .prepend(children... or [children...])
    #= Access existing nodes as a DOMBrew object:
    #  $b document.getElementById("my-elem") # <- 1 DOM node
    #  $b(nodes... or [nodes...])            # <- wrap multiple DOMBrew nodes (uses awesome DocumentFragment internally)
    #= Get results:
    #  .dom()   # => result as DOM
    #  .html()  # => result as html in a string

---
## Contribute

Fork. Develop. Extra points for tests (see test.html). :)

You will need node and coffee-script installed:

* Follow these instructions to install node and npm: https://github.com/joyent/node/wiki/Installation
* npm install -g coffee-script

# Changelog / What's new

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

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
        $b 'li#first', 'one'
        $b 'li', 'two', css: { display: 'none' }
        $b 'li', 'three', data: { stuff: 'abc', more: 'def' }
        $b 'text', 'That is all'                                    
      ).dom()
    
    # <ul id=​"container">​
    #   My <b>​awesome​</b>​ list
    #   <li id="first">​one​</li>​
    #   <li style="display: none">​two​</li>​
    #   <li data-stuff=​"abc" data-more=​"def">
    #     ​three
    #   ​</li>​
    #   That is all
    # </ul>​

    # Or build on the existing DOM element
    $b($('#item-title')[0])
      .prepend($b 'button.icon.fav-star', title: 'Add to favourites')
      .append($b 'button.hide', 'Hide').dom()

    # To get html as a string:
    $b('#container').html() 
    # => "<div id="container"></div>"

    # == Recap ==
    #= Build nodes:
    #  $b "a#my-id.some-class", "hello world!", href: "/hello.html"
    #  $b "#cont", class: ["cls1", "cls2"], data: { dat1: "hi", dat2: "hello" }
    #  $b "text", "hello world!"
    #  $b $("#my-elem")[0]
    #  $b(nodes... or [nodes...])
    #= Append/prepend children:
    #  .append(children... or [children...])
    #  .prepend(children... or [children...])
    #= Integrate with jQuery (experimental)
    #  1. Call $b.jQueryIntegrate() to enable full jQuery integration
    #  2. jQuery($b 'li.awesome').is('.awesome') #=> true
    #= Get results:
    #  .dom()  or .asDOM()    # => result as DOM
    #  .html() or .asHTML()   # => result as html in a string

---
## Contribute

Fork. Develop. Extra points for tests (see test.html). :)

You will need node and coffee-script installed:

* Follow these instructions to install node and npm: https://github.com/joyent/node/wiki/Installation
* npm install -g coffee-script

# Changelog / What's new

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

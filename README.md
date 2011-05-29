# DOMBrew

DOMBrew is a DOM builder written entirely in [CoffeeScript](http://jashkenas.github.com/coffee-script/)
The easiest way to install it is to grab dombrew.js from the repository.

    # DOMBrew builds DOM from a css like selector and a hash of attributes.
    # Normally you would alias it to a short variable
    $b = DOMBrew

    # Construct an element like this:
    $b('span#the-span.classy', 'Hello World').asDOM()
    # => <span id="the-span" class="classy">Hello World</span>

    # Or like this:
    $b('ul#container', html: 'My <b>awesome</b> list')
      .append(
        $b 'li#first', 'one'
        $b 'li', 'two'
        $b 'li', text: "three", data: { stuff: 'abc', more: 'def' } # html5 data attributes
        $b 'text', 'That is all'                                    # text nodes
      ).asDOM()
    # =>
    # <ul id=​"container">​
    #   My <b>​awesome​</b>​ list
    #   <li id="first">​one​</li>​
    #   <li>​two​</li>​
    #   <li data-stuff=​"abc" data-more=​"def">
    #     ​three
    #   ​</li>​
    #   That is all
    # </ul>​


    # If at any point you want to get the html as a string:
    # $b('#container').html() # => "<div id="container"></div>"

    # Review:
    # .append(...)           # => append children
    # .dom()  or .asDOM()    # => result as DOM
    # .html() or .asHTML()   # => result as html in a string

---
## Contribute

Fork. Develop. Extra points for tests. :)

You will need node and coffee-script installed:

* Follow these instructions to install node and npm: https://github.com/joyent/node/wiki/Installation
* npm install -g coffee-script

# Changelog / What's new

v1.5.0

* To build text nodes: was `$b('text', 'hello')` now `$b('', 'hello')` or `$b.text('hello')`
* Fixed for ie11

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

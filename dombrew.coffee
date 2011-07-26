# DOMBrew builds DOM from a css like selector and a hash of attributes.
# @url https://github.com/glebm/DOMBrew
# @author Gleb Mazovetskiy
d = document
class Node
  # Identification property
  _brew: 1

  # {data: {someProp: 1}} => {"data-some-prop" => 1}
  flattenHash = (attr) ->
    for name, obj of attr
      if typeof attr[name] == 'object'
        attr[name + '-' + sub.replace(/([a-z])([A-Z])/g, "$1-$2").toLowerCase()] = val for sub, val of obj
        delete attr[name]
    return

  # Parses out css classes and id from string like:
  #   p#warning.big.yellow # => p   # attr will contain {"id": "warning", "class": ['big', 'yellow']}
  #   #container                # => div # attr will contain {"id": "container"}
  # @returns node name (e.g. "span")
  dotHashRe = /[.#]/
  parseElem = (elem, attr) ->
    return elem unless dotHashRe.test elem
    attr['class'] ||= []
    attr['class'] = [attr['class']] if typeof attr['class'] == 'string'
    elem     = "div#{elem}" if dotHashRe.test(elem.charAt(0))
    pieces   = elem.split(dotHashRe)
    elemType = pieces.shift()
    pos      = elemType.length
    classes  = attr['class']
    for piece in pieces
      if elem.charAt(pos) == '#'
        attr['id'] = piece
      else
        classes.push(piece)
      pos += piece.length + 1
    delete attr['class'] unless attr['class'].length
    elemType

  # joinValues(['a', 'b', 'c', null, '', undefined, true, 1]) => "a b c true 1"
  # joinValues('a') => 'a'
  joinValues = (value) ->
    return value if typeof value != 'object'
    r = []
    i = -1
    length = value.length
    while (++i < length)
      r.push(value[i]) if value[i]
    r.join(' ')


  constructor: (elem, attr, more) ->
    attr = {} if !attr?
    if elem.nodeType
      @e = elem
      return
    else if elem == 'text'
      @e = d.createTextNode attr
      return
    else
      if typeof attr == "string"
        more ||= {}
        more.text = attr
        attr = more

      @e = d.createElement parseElem(elem, attr)

    attr['class'] && (@e.className = joinValues(attr['class'])) && delete attr['class']
    attr['text'] && (@e.innerText = joinValues(attr['text'])) && delete attr['text']
    attr['html'] && (@e.innerHTML = joinValues(attr['html'])) && delete attr['html']
    (s[prop] = value for prop, value of css) if attr['css'] && (s = @e.style) && (css = attr['css']) && delete attr['css']

    flattenHash(attr)
    @e.setAttribute(name, value) for name, value of attr

  # append(children... or [children])
  append: ->
    a = arguments
    a = a[0] if "splice" of a[0]
    for node in a
      ('_brew' of node) && (node = node.dom())
      @e.appendChild node
    @

  # prepend(children... or [children])
  prepend: ->
    a = arguments
    a = a[0] if "splice" of a[0]
    for node in a
      ('_brew' of node) && (node = node.dom())
      @e.insertBefore(node, @e.firstChild)
    @

  dom  : -> @e
  html : -> div = d.createElement('div'); div.appendChild(@e); div.innerHTML

Node::asDOM  = Node::dom
Node::asHTML = Node::html

# DOMbrew(nodes... or [nodes])
@DOMBrew = D = ->
  a = arguments
  # If passed an array, wrap it in a DocumentFragment
  if (typeof a[0] == 'object') && ('splice' of a[0]) # $b([nodes...]) form
    nodes = a[0]
  else if a.length > 1 && (typeof a[1] == 'object') && ('_brew' of a[1]) # $b(nodes...) form
    nodes = a
  if nodes
    frag = d.createDocumentFragment()
    frag.appendChild(node.e) for node in nodes
    a = [frag]
  new Node(a[0], a[1], a[2])

D.VERSION = D.version = '1.4.3'

# innerText fix (Firefox)
if (navigator.appName != 'Microsoft Internet Explorer') && !HTMLElement::innerText && HTMLElement::__defineGetter__
  HTMLElement::__defineGetter__ "innerText", -> @textContent
  HTMLElement::__defineSetter__ "innerText", (value) -> @textContent = value








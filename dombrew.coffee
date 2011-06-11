#  Awesomely fast
#  $x = DOMBrew
#  $x('p', text: "DOMBrew says: ").append(
#    $x('strong', 'Hello'), $x('em', text: 'world!', class: ['important', 'stuff'])
#  )
# $x('div').append($x 'text', 'hi').append($x 'em', 'world').asHTML() => "<div>hi<em>world</em></div>"
d = document
class Node
  flattenData = (attr) ->
    return if !attr.data || typeof attr.data != 'object'
    attr["data-#{name}"] = val for name, val of attr['data']
    delete attr['data']

  dotHashRe = /[.#]/

  # Parses out css classes and id from string like:
  #   p#warning.big.yellow # => p   # attr will contain {"id": "warning", "class": ['big', 'yellow']}
  #   #container                # => div # attr will contain {"id": "container"}
  parseElem = (elem, attr) ->
    return elem unless dotHashRe.test elem
    attr['class'] ||= []
    attr['class'] = [attr['class']] if typeof attr['class'] == 'string'
    elem     = "div#{elem}" if dotHashRe.test(elem[0])
    pieces   = elem.split(dotHashRe)
    elemType = pieces.shift()
    pos      = elemType.length
    classes  = attr['class']
    for piece in pieces
      (elem[pos] == '#') && (attr['id'] = piece) || classes.push(piece)
      pos += piece.length + 1

    delete attr['class'] if attr['class'].length == 0

    elemType

  # joinValues(['a', 'b', 'c', null, '', undefined, true, 1]) => "a b c true 1"
  # joinValues('a') => 'a'
  joinValues = (value) ->
    return value if typeof value != 'object'
    (piece for piece in value when piece).join(' ')

  constructor: (elem, attr = {}) ->
    # Cannot check 'elem.constructor == DocumentFragment' due to IE bug
    if elem.constructor.name == "DocumentFragment"
      @e = elem
      return
    else if elem == 'text'
      @e = d.createTextNode attr
      return
    else
      attr = {text: attr} if typeof attr == "string"
      elem = parseElem(elem, attr)
      flattenData(attr)
      @e = d.createElement elem

    attr['class'] && (@e.className = joinValues(attr['class'])) && delete attr['class']
    attr['text'] && (@e.innerText = joinValues(attr['text'])) && delete attr['text']
    attr['html'] && (@e.innerHTML = joinValues(attr['html'])) && delete attr['html']

    @e.setAttribute(name, value) for name, value of attr

  # append(children...)
  append: ->
    a = arguments
    a = a[0] if "splice" of a[0]
    for node in a
      ("asDOM" of node) && (node = node.asDOM())
      @e.appendChild node
    @

  dom  : -> @e
  html : -> div = d.createElement('div'); div.appendChild(@e); div.innerHTML

Node::asDOM  = Node::dom
Node::asHTML = Node::html

@DOMBrew = D = ->
  a = arguments
  # If passed an array, wrap it in a DocumentFragment
  if (typeof a[0])[0] == 'o' && 'splice' of a[0] # $b([nodes...]) form
    nodes = a[0]
  else if a.length > 1 && (typeof a[1])[0] == 'o' && ('asDOM' of a[1]) # $b(nodes...) form
    nodes = a
  if nodes
    frag = d.createDocumentFragment()
    frag.appendChild(node.e) for node in nodes
    a = [frag]
  new Node(a[0], a[1])

D.VERSION = D.version = '1.1'

# innerText fix (Firefox)
if (H = HTMLElement) && !H::innerText && H::__defineGetter__ && H::__defineSetter__
  H::__defineGetter__ "innerText", -> @textContent
  H::__defineSetter__ "innerText", (value) -> @textContent = value

# DocumentFragment constructor fix (Firefox)
# Can't reference directly as DocumentFragment because IE does not expose it
d.createDocumentFragment().constructor.name = "DocumentFragment"











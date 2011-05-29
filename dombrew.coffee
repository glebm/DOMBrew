#  Awesomely fast
#  $x = DOMBrew
#  $x('p', text: "DOMBrew says: ").append(
#    $x('strong', 'Hello'), $x('em', text: 'world!', class: ['important', 'stuff'])
#  )
# $x('div').append($x 'text', 'hi').append($x 'em', 'world').asHTML() => "<div>hi<em>world</em></div>"
class Node
  d       = document
  special =
    class: 'className'
    text : 'innerText'
    html : 'innerHTML'
  specials = (name for own name, v of special)

  flattenData = (attr) ->
    return if !attr.data || typeof attr.data != 'object'
    attr["data-#{name}"] = val for own name, val of attr['data']
    delete attr['data']



  dotHashRe = /[.#]/

  # Parses out css classes and id from string like:
  #   p#warning.big.yellow # => p   # attr will contain {"id": "warning", "class": ['big', 'yellow']}
  #   #container                # => div # attr will contain {"id": "container"}
  parseElem = (elem, attr) ->
    return elem unless dotHashRe.test elem
    attr['class'] ||= []
    attr['class'] = [attr['class']] if attr['class'] && typeof attr['class'].splice == 'undefined'
    
    classes = attr['class']
    elem     = "div#{elem}" if dotHashRe.test(elem[0])
    pieces   = elem.split(dotHashRe)
    elemType = pieces.shift()
    pos      = elemType.length
    for piece in pieces
      if elem[pos] == '#'
        attr['id'] = piece
      else if elem[pos] == '.'
        classes.push(piece)
      pos += piece.length + 1

    delete attr['class'] if !attr['class'] || attr['class'].length == 0

    elemType

  # joinValues(['a', 'b', 'c', null, '', undefined, true, 1]) => "abctrue1"
  # joinValues('a') => 'a'
  joinValues = (value) ->
    return value if typeof value in ['string', 'number', 'boolean']
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


    @e[method] = joinValues(value) for own name, method of special when typeof(value = attr[name]) != 'undefined'
    delete attr[name] for name in specials
    @e.setAttribute(name, value) for own name, value of attr
    

  append: (children...) ->
    children = children[0] if children.length == 1 && children[0] && typeof children[0].splice != 'undefined'
    for node in children
      node = node.asDOM() if node.asDOM?
      @e.appendChild node
    @

  dom  : -> @e
  html : -> div = d.createElement('div'); div.appendChild(@e); div.innerHTML

Node::asDOM  = Node::dom
Node::asHTML = Node::html

@DOMBrew = (elem, attr) ->
  # If passed an array, wrap it in a DocumentFragment
  if typeof elem.splice != 'undefined'
    nodes = new Node('div').append(elem).asDOM().childNodes
    frag = document.createDocumentFragment()
    frag.appendChild(nodes[0]) while (nodes.length)
    elem = frag
  new Node(elem, attr)


# innerText fix (Firefox)
if !HTMLElement::innerText && HTMLElement::__defineGetter__? && HTMLElement::__defineSetter__?
  HTMLElement::__defineGetter__ "innerText", -> @textContent
  HTMLElement::__defineSetter__ "innerText", (value) -> @textContent = value













(function() {
  var D, H, Node, d;
  d = document;
  Node = (function() {
    var dotHashRe, flattenData, joinValues, parseElem;
    flattenData = function(attr) {
      var name, val, _ref;
      if (!attr.data || typeof attr.data !== 'object') {
        return;
      }
      _ref = attr['data'];
      for (name in _ref) {
        val = _ref[name];
        attr["data-" + name] = val;
      }
      return delete attr['data'];
    };
    dotHashRe = /[.#]/;
    parseElem = function(elem, attr) {
      var classes, elemType, piece, pieces, pos, _i, _len;
      if (!dotHashRe.test(elem)) {
        return elem;
      }
      attr['class'] || (attr['class'] = []);
      if (typeof attr['class'] === 'string') {
        attr['class'] = [attr['class']];
      }
      if (dotHashRe.test(elem[0])) {
        elem = "div" + elem;
      }
      pieces = elem.split(dotHashRe);
      elemType = pieces.shift();
      pos = elemType.length;
      classes = attr['class'];
      for (_i = 0, _len = pieces.length; _i < _len; _i++) {
        piece = pieces[_i];
        (elem[pos] === '#') && (attr['id'] = piece) || classes.push(piece);
        pos += piece.length + 1;
      }
      if (attr['class'].length === 0) {
        delete attr['class'];
      }
      return elemType;
    };
    joinValues = function(value) {
      var piece;
      if (typeof value !== 'object') {
        return value;
      }
      return ((function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = value.length; _i < _len; _i++) {
          piece = value[_i];
          if (piece) {
            _results.push(piece);
          }
        }
        return _results;
      })()).join(' ');
    };
    function Node(elem, attr) {
      var name, value;
      if (attr == null) {
        attr = {};
      }
      if (elem.constructor.name === "DocumentFragment") {
        this.e = elem;
        return;
      } else if (elem === 'text') {
        this.e = d.createTextNode(attr);
        return;
      } else {
        if (typeof attr === "string") {
          attr = {
            text: attr
          };
        }
        elem = parseElem(elem, attr);
        flattenData(attr);
        this.e = d.createElement(elem);
      }
      attr['class'] && (this.e.className = joinValues(attr['class'])) && delete attr['class'];
      attr['text'] && (this.e.innerText = joinValues(attr['text'])) && delete attr['text'];
      attr['html'] && (this.e.innerHTML = joinValues(attr['html'])) && delete attr['html'];
      for (name in attr) {
        value = attr[name];
        this.e.setAttribute(name, value);
      }
    }
    Node.prototype.append = function() {
      var a, node, _i, _len;
      a = arguments;
      if ("splice" in a[0]) {
        a = a[0];
      }
      for (_i = 0, _len = a.length; _i < _len; _i++) {
        node = a[_i];
        ("asDOM" in node) && (node = node.asDOM());
        this.e.appendChild(node);
      }
      return this;
    };
    Node.prototype.dom = function() {
      return this.e;
    };
    Node.prototype.html = function() {
      var div;
      div = d.createElement('div');
      div.appendChild(this.e);
      return div.innerHTML;
    };
    return Node;
  })();
  Node.prototype.asDOM = Node.prototype.dom;
  Node.prototype.asHTML = Node.prototype.html;
  this.DOMBrew = D = function() {
    var a, frag, node, nodes, _i, _len;
    a = arguments;
    if ((typeof a[0])[0] === 'o' && 'splice' in a[0]) {
      nodes = a[0];
    } else if (a.length > 1 && (typeof a[1])[0] === 'o' && ('asDOM' in a[1])) {
      nodes = a;
    }
    if (nodes) {
      frag = d.createDocumentFragment();
      for (_i = 0, _len = nodes.length; _i < _len; _i++) {
        node = nodes[_i];
        frag.appendChild(node.e);
      }
      a = [frag];
    }
    return new Node(a[0], a[1]);
  };
  D.VERSION = D.version = '1.1';
  if ((H = HTMLElement) && !H.prototype.innerText && H.prototype.__defineGetter__ && H.prototype.__defineSetter__) {
    H.prototype.__defineGetter__("innerText", function() {
      return this.textContent;
    });
    H.prototype.__defineSetter__("innerText", function(value) {
      return this.textContent = value;
    });
  }
  d.createDocumentFragment().constructor.name = "DocumentFragment";
}).call(this);

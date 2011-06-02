(function() {
  var Node;
  var __hasProp = Object.prototype.hasOwnProperty, __slice = Array.prototype.slice;
  Node = (function() {
    var d, dotHashRe, flattenData, joinValues, name, parseElem, special, specials, v;
    d = document;
    special = {
      "class": 'className',
      text: 'innerText',
      html: 'innerHTML'
    };
    specials = (function() {
      var _results;
      _results = [];
      for (name in special) {
        if (!__hasProp.call(special, name)) continue;
        v = special[name];
        _results.push(name);
      }
      return _results;
    })();
    flattenData = function(attr) {
      var name, val, _ref;
      if (!attr.data || typeof attr.data !== 'object') {
        return;
      }
      _ref = attr['data'];
      for (name in _ref) {
        if (!__hasProp.call(_ref, name)) continue;
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
      if (attr['class'] && typeof attr['class'].splice === 'undefined') {
        attr['class'] = [attr['class']];
      }
      classes = attr['class'];
      if (dotHashRe.test(elem[0])) {
        elem = "div" + elem;
      }
      pieces = elem.split(dotHashRe);
      elemType = pieces.shift();
      pos = elemType.length;
      for (_i = 0, _len = pieces.length; _i < _len; _i++) {
        piece = pieces[_i];
        if (elem[pos] === '#') {
          attr['id'] = piece;
        } else if (elem[pos] === '.') {
          classes.push(piece);
        }
        pos += piece.length + 1;
      }
      if (!attr['class'] || attr['class'].length === 0) {
        delete attr['class'];
      }
      return elemType;
    };
    joinValues = function(value) {
      var piece, _ref;
      if ((_ref = typeof value) === 'string' || _ref === 'number' || _ref === 'boolean') {
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
      var method, name, value, _i, _len;
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
      for (name in special) {
        if (!__hasProp.call(special, name)) continue;
        method = special[name];
        if (typeof (value = attr[name]) !== 'undefined') {
          this.e[method] = joinValues(value);
        }
      }
      for (_i = 0, _len = specials.length; _i < _len; _i++) {
        name = specials[_i];
        delete attr[name];
      }
      for (name in attr) {
        if (!__hasProp.call(attr, name)) continue;
        value = attr[name];
        this.e.setAttribute(name, value);
      }
    }
    Node.prototype.append = function() {
      var children, node, _i, _len;
      children = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      if (children.length === 1 && children[0] && typeof children[0].splice !== 'undefined') {
        children = children[0];
      }
      for (_i = 0, _len = children.length; _i < _len; _i++) {
        node = children[_i];
        if (node.asDOM != null) {
          node = node.asDOM();
        }
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
  this.DOMBrew = function(elem, attr) {
    var frag, nodes;
    if (typeof elem.splice !== 'undefined') {
      nodes = new Node('div').append(elem).asDOM().childNodes;
      frag = document.createDocumentFragment();
      while (nodes.length) {
        frag.appendChild(nodes[0]);
      }
      elem = frag;
    }
    return new Node(elem, attr);
  };
  if (!HTMLElement.prototype.innerText && (HTMLElement.prototype.__defineGetter__ != null) && (HTMLElement.prototype.__defineSetter__ != null)) {
    HTMLElement.prototype.__defineGetter__("innerText", function() {
      return this.textContent;
    });
    HTMLElement.prototype.__defineSetter__("innerText", function(value) {
      return this.textContent = value;
    });
  }
  document.createDocumentFragment().constructor.name = "DocumentFragment";
}).call(this);

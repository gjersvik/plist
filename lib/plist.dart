library plist;

import 'dart:typed_data';
import 'package:xml/xml.dart' as libxml;
import 'package:crypto/crypto.dart' show CryptoUtils;

parse(String xml){
  var doc = libxml.parse(xml);
  return _handleElem(doc.rootElement);
}

_handleElem(libxml.XmlElement elem){
  switch (elem.name.local){
    case 'string':
      return elem.text;
    case 'real':
      return double.parse(elem.text);
    case 'integer':
      return int.parse(elem.text);
    case 'true':
      return true;
    case 'false':
      return false;
    case 'date':
      return DateTime.parse(elem.text);
    case 'data':
      return new Uint8List.fromList(CryptoUtils.base64StringToBytes(elem.text));
    case 'array':
      return elem.children
          .where((node) => node is libxml.XmlElement)
          .map(_handleElem)
          .toList();
    case 'dict':
      return _handleDict(elem);
  }
}

Map _handleDict(libxml.XmlElement elem){
  var children = elem.children.where((node) => node is libxml.XmlElement);
  var key = children
      .where((elem) => elem.name.local == 'key')
      .map((elem) => elem.text);
  var values = children
      .where((elem) => elem.name.local != 'key')
      .map(_handleElem);
  return new Map.fromIterables(key, values);
}
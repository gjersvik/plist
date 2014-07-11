library plist;

import 'dart:typed_data';
import 'package:xml/xml.dart' as libxml;
import 'package:crypto/crypto.dart' show CryptoUtils;

/**
 * Takes a xml string of Property list.
 * Will in most praticaly situation return an Map.
 * Coverts property list types to these dart types:
 * 
 * * <string> to [String].
 * * <real> to [double].
 * * <integer> to [int].
 * * <true> to true.
 * * <false> to false.
 * * <date> to [DateTime].
 * * <data> to [Uint8List].
 * * <array> to [List].
 * * <dict> to [Map].
 */
Object parse(String xml){
  var doc = libxml.parse(xml);
  return _handleElem(doc.rootElement.children.where(_isElemet).first);
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
          .where(_isElemet)
          .map(_handleElem)
          .toList();
    case 'dict':
      return _handleDict(elem);
  }
}

Map _handleDict(libxml.XmlElement elem){
  var children = elem.children.where(_isElemet);
  var key = children
      .where((elem) => elem.name.local == 'key')
      .map((elem) => elem.text);
  var values = children
      .where((elem) => elem.name.local != 'key')
      .map(_handleElem);
  return new Map.fromIterables(key, values);
}

bool _isElemet(libxml.XmlNode node) => node is libxml.XmlElement;
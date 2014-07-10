import 'dart:typed_data';
import 'package:unittest/unittest.dart';

//Package under test.
import '../lib/plist.dart';

void main(){
  test('Plist parses <string> to String.', (){
    var plist = parse('<string>testdata</string>');
    expect(plist, 'testdata');
  });
  
  test('Plist parses <real> to double.', (){
    var plist = parse('<real>1.7</real>');
    expect(plist, 1.7);
  });
  
  test('Plist parses <integer> to int.', (){
    var plist = parse('<integer>42</integer>');
    expect(plist, 42);
  });
  
  test('Plist parses <true> literal true.', (){
    var plist = parse('<true/>');
    expect(plist, isTrue);
  });
  
  test('Plist parses <false> literal false.', (){
    var plist = parse('<false/>');
    expect(plist, isFalse);
  });
  
  test('Plist parses <date> to Date.', (){
    var plist = parse('<date>2014-07-09T04:23:04+00:00</date>');
    expect(plist, new DateTime.utc(2014,07,09,04,23,04));
  });
  
  test('Plist parses <data> to Uint8List.', (){
    var plist = parse('<data>AQIDBAUGBwgJ</data>');
    expect(plist, new Uint8List.fromList([1,2,3,4,5,6,7,8,9]));
  });
  
  test('Plist parses <array> to List.', (){
    var plist = parse('<array><string>anser</string><integer>42</integer></array>');
    expect(plist, ['anser', 42]);
  });
  
  test('Plist parses <dict> to Map.', (){
    var str = '''
      <dict>
        <key>anser</key>
        <integer>42</integer>
        <key>evil</key>
        <integer>666</integer>
      </dict>
    ''';
    var plist = parse(str);
    expect(plist, {'anser': 42, 'evil':666});
  });
}
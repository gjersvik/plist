import 'dart:typed_data';
import 'package:unittest/unittest.dart';

//Package under test.
import '../lib/plist.dart';

void main(){
  test('Plist parses <string> to String.', (){
    var plist = parse('<plist><string>testdata</string></plist>');
    expect(plist, 'testdata');
  });
  
  test('Plist parses <real> to double.', (){
    var plist = parse('<plist><real>1.7</real></plist>');
    expect(plist, 1.7);
  });
  
  test('Plist parses <integer> to int.', (){
    var plist = parse('<plist><integer>42</integer></plist>');
    expect(plist, 42);
  });
  
  test('Plist parses <true> literal true.', (){
    var plist = parse('<plist><true/></plist>');
    expect(plist, isTrue);
  });
  
  test('Plist parses <false> literal false.', (){
    var plist = parse('<plist><false/></plist>');
    expect(plist, isFalse);
  });
  
  test('Plist parses <date> to Date.', (){
    var plist = parse('<plist><date>2014-07-09T04:23:04+00:00</date></plist>');
    expect(plist, new DateTime.utc(2014,07,09,04,23,04));
  });
  
  test('Plist parses <data> to Uint8List.', (){
    var plist = parse('<plist><data>AQIDBAUGBwgJ</data></plist>');
    expect(plist, new Uint8List.fromList([1,2,3,4,5,6,7,8,9]));
  });
  
  test('Plist parses <array> to List.', (){
    var plist = parse('<plist><array><string>anser</string><integer>42</integer></array></plist>');
    expect(plist, ['anser', 42]);
  });
  
  test('Plist parses <dict> to Map.', (){
    var xml = '''
      <plist>
        <dict>
          <key>anser</key>
          <integer>42</integer>
          <key>evil</key>
          <integer>666</integer>
        </dict>
      </plist>
    ''';
    var plist = parse(xml);
    expect(plist, {'anser': 42, 'evil':666});
  });
  
  test('readme exsample', (){
      var xml = '''
        <plist>
          <dict>
            <key>String</key>
            <string>test</string>
            <key>double</key>
            <real>3.14</real>
            <key>int</key>
            <integer>42</integer>
            <key>bool</key>
            <true/>
            <key>DateTime</key>
            <date>2011-10-10T12:44:21+00:00</date>
            <key>Uint8List</key>
            <data>AQIDBAUGBwgJ</data>
            <key>List</key>
            <array>
              <string>one</string>
              <string>two</string>
              <string>tree</string>
              <string>four</string>
              <string>five</string>
            </array>
          </dict>
        </plist>
      ''';
      var plist = parse(xml);
      expect(plist, {
        'String': 'test',
        'double': 3.14,
        'int': 42,
        'bool': true,
        'DateTime': new DateTime.utc(2011,10,10,12,44,21),
        'Uint8List': new Uint8List.fromList([1,2,3,4,5,6,7,8,9]),
        'List': ['one','two','tree','four','five']
      });
    });
}
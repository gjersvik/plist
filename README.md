Xml property file parser for dart.
----------------------------------

```dart
import 'package:plist/plist.dart' as plist;

main(){
  var xml = '''
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
  ''';
  
  print(plist.parse(xml));
}
```
It should return (newline added for readability):
```
{
    String: test,
    double: 3.14,
    int: 42,
    bool: true,
    DateTime: 2011-10-10 12:44:21.000Z,
    Uint8List: [1, 2, 3, 4, 5, 6, 7, 8, 9],
    List: [one, two, tree, four, five]
}
```

[ ![Codeship Status for gjersvik/plist](https://www.codeship.io/projects/db84ccb0-eb39-0131-cf93-06c96fb7e135/status)](https://www.codeship.io/projects/26483)
_This project is licensed under the BSD 2-Clause License._
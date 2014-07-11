import 'package:plist/plist.dart' as plist;

main(){
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
  
  print(plist.parse(xml));
}
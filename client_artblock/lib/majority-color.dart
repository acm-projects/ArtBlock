import 'package:palette_generator/palette_generator.dart';

// add palette_generator to pubspec.yaml
Future<PaletteGenerator>_updatePaletteGenerator ()async
{
  paletteGenerator = await PaletteGenerator.fromImageProvider( // until image is given
    Image.asset("assets/images/").image,
  );
return paletteGenerator;
}

FutureBuilder<PaletteGenerator>(
                  future: _updatePaletteGenerator(),
                  builder: (BuildContext context, AsyncSnapshot<PaletteGenerator> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting: return Center(child:CircularProgressIndicator());
                      default:
                        if (snapshot.hasError)
                          return new Text('Error: ${snapshot.error}');
                        else {
                          face=snapshot.data.dominantColor.color;
                           return new ${face.toString()};
                              }}})

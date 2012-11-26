library spaceinvader;

import 'dart:html';
import 'package:js/js.dart' as js;

// core classes
part 'state.dart';
part 'stagable.dart';
part 'drawable.dart';
part 'stage.dart';

// states
part 'states/menu.dart';
part 'states/playing.dart';
part 'states/gameover.dart';

// models
part '../images.dart';
part '../resource_loader.dart';
part '../publisher.dart';

part '../ship.dart';
part '../alien.dart';
part '../bad_alien.dart';
part '../projectile.dart';
library spaceinvader;

import 'dart:html';
import 'package:js/js.dart' as js;
import 'dart:mirrors';

// core classes
part '../spaceinvader.dart';
part 'state.dart';
part 'stagable.dart';
part 'drawable.dart';
part 'stage.dart';
part 'utils.dart';

// states
part 'states/preloading.dart';
part 'states/menu.dart';
part 'states/playing.dart';
part 'states/gameover.dart';

// models
part '../images.dart';
part '../ship.dart';
part '../alien.dart';
part '../bad_alien.dart';
part '../projectile.dart';
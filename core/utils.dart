part of spaceinvaders;

hasMethod (instance, methodName){
  InstanceMirror resIM = reflect(instance);
  ClassMirror resCM = resIM.type;
  return resCM.methods[methodName] != null;
}

initStepFlags(){
  var it = currentMirrorSystem().libraries.values.iterator();
  flags.clear();
  while (it.hasNext) {
    LibraryMirror lib = it.next();
    if (lib.qualifiedName == "spaceinvaders"){
      lib.classes.values.forEach((ClassMirror clazz){
        if (clazz.constructors['Ship'] != null &&
            clazz.superclass.qualifiedName == "spaceinvaders.Drawable"){
          flags.add('shipIsInstanciable');
        }
        else if (clazz.constructors['Alien'] != null &&
            clazz.superclass.qualifiedName == "spaceinvaders.Drawable"){
          flags.add('alienIsInstanciable');
          return;
        }
      });
      //flags.forEach((flag) => print('$flag'));
      return;
    }
  }
}

Set flags = new Set();
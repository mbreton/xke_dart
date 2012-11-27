part of spaceinvader;

hasMethod (instance, methodName){
  InstanceMirror resIM = reflect(instance);
  ClassMirror resCM = resIM.type;
  return resCM.methods[methodName] != null;
}

triggerKeyBoardEvent ([code= KeyCode.LEFT]){
  js.scoped((){
    var e = js.context.jQuery.Event("keyup");
    e.which = code;
    js.context.jQuery("body").trigger(e);
  });
}
part of spaceinvader;

hasMethod (instance, methodName){
  InstanceMirror resIM = reflect(instance);
  ClassMirror resCM = resIM.type;
  return resCM.methods[methodName] != null;
}
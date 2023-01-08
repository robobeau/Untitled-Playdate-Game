<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimTransition" class="Animation" tilewidth="80" tileheight="80" tilecount="1" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimTransition.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="80" height="80" source="../source/images/Kim/KimTransition1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="26" y="2" width="42" height="78"/>
   <object id="2" name="Pushbox" class="Pushbox" x="4" y="-4" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>

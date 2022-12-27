<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimJumpTransition" class="Animation" tilewidth="40" tileheight="40" tilecount="1" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimJumpTransition.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="40" height="40" source="../source/images/Kim/KimJumpTransition1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="13" y="1" width="21" height="39"/>
   <object id="2" name="Pushbox" class="Pushbox" x="2" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>

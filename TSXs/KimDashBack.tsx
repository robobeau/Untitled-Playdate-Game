<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimDashBack" class="Animation" tilewidth="40" tileheight="48" tilecount="1" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimDashBack.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="40" height="48" source="../source/images/Kim/KimDashBack1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="7" y="4" width="20" height="34"/>
   <object id="2" name="Pushbox" class="Pushbox" x="2" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>

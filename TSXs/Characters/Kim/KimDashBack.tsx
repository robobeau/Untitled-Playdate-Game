<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimDashBack" class="Animation" tilewidth="80" tileheight="96" tilecount="1" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimDashBack.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="8"/>
  </properties>
  <image width="80" height="96" source="../../../source/images/characters/Kim/KimDashBack1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="14" y="8" width="40" height="68"/>
   <object id="2" name="Pushbox" class="Pushbox" x="4" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>

<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimDashForward" class="Animation" tilewidth="32" tileheight="56" tilecount="1" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimDashForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="6"/>
  </properties>
  <image width="32" height="56" source="../source/images/Kim/KimDashForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="8" y="6" width="22" height="43"/>
   <object id="2" name="Pushbox" class="Pushbox" x="-2" y="14" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>

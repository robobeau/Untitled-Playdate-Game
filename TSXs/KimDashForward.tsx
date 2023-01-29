<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimDashForward" class="Animation" tilewidth="64" tileheight="112" tilecount="1" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimDashForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="8"/>
  </properties>
  <image width="64" height="112" source="../source/images/Kim/KimDashForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="16" y="12" width="44" height="86"/>
   <object id="2" name="Pushbox" class="Pushbox" x="-4" y="28" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>

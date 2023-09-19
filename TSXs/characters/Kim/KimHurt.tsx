<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimHurt" class="Animation" tilewidth="112" tileheight="80" tilecount="3" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../tsjs/KimHurt.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="112" height="80" source="../../../source/characters/Kim/images/KimHurt1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="34" y="-4" width="40" height="84"/>
   <object id="3" name="Center" type="Center" x="54" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="hitstunnable" type="bool" value="true"/>
  </properties>
  <image width="112" height="80" source="../../../source/characters/Kim/images/KimHurt2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="56" y="-4" width="40" height="84"/>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="34" y="6" width="64" height="74"/>
   <object id="3" name="Center" type="Center" x="76" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="2097152"/>
   <property name="velocityX" type="int" value="0"/>
  </properties>
  <image width="112" height="80" source="../../../source/characters/Kim/images/KimHurt1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="34" y="-4" width="40" height="84"/>
   <object id="5" name="Hurtbox (Mid)" type="Hurtbox" x="24" y="26" width="58" height="54"/>
   <object id="4" name="Center" type="Center" x="54" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>

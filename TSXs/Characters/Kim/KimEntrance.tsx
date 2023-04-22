<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimEntrance" class="Animation" tilewidth="80" tileheight="96" tilecount="4" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimEntrance.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="false"/>
 </properties>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="80" height="96" source="../../../source/images/characters/Kim/KimEntrance1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="22" y="12" width="38" height="84"/>
   <object id="2" name="Pushbox" class="Pushbox" x="4" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="8"/>
  </properties>
  <image width="80" height="96" source="../../../source/images/characters/Kim/KimEntrance2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="26" y="10" width="38" height="86"/>
   <object id="2" name="Pushbox" class="Pushbox" x="6" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="8"/>
  </properties>
  <image width="80" height="96" source="../../../source/images/characters/Kim/KimEntrance3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="24" y="12" width="38" height="84"/>
   <object id="2" name="Pushbox" class="Pushbox" x="6" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="20"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="1048576"/>
  </properties>
  <image width="80" height="96" source="../../../source/images/characters/Kim/KimEntrance4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="24" y="10" width="38" height="86"/>
   <object id="2" name="Pushbox" class="Pushbox" x="6" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>

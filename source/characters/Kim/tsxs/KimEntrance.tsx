<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimEntrance" class="Animation" tilewidth="80" tileheight="96" tilecount="4" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimEntrance.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="false"/>
 </properties>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="80" height="96" source="../images/KimEntrance1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="22" y="12" width="40" height="84"/>
   <object id="1" name="Hurtbox (Body)" type="Hurtbox" x="12" y="42" width="64" height="54"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="22" y="12" width="38" height="38"/>
   <object id="3" name="Center" type="Center" x="42" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="8"/>
  </properties>
  <image width="80" height="96" source="../images/KimEntrance2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="24" y="12" width="40" height="84"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="14" y="44" width="58" height="52"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="26" y="10" width="38" height="42"/>
   <object id="6" name="Center" type="Center" x="44" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="8"/>
  </properties>
  <image width="80" height="96" source="../images/KimEntrance3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="24" y="12" width="40" height="84"/>
   <object id="3" name="Hurtbox (Body)" type="Hurtbox" x="14" y="44" width="58" height="52"/>
   <object id="4" name="Hurtbox (Head)" type="Hurtbox" x="24" y="12" width="38" height="42"/>
   <object id="5" name="Center" type="Center" x="44" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="20"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="2097152"/>
  </properties>
  <image width="80" height="96" source="../images/KimEntrance4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="24" y="12" width="40" height="84"/>
   <object id="3" name="Hurtbox (Body)" type="Hurtbox" x="14" y="42" width="58" height="54"/>
   <object id="4" name="Hurtbox (Head)" type="Hurtbox" x="24" y="10" width="38" height="40"/>
   <object id="5" name="Center" type="Center" x="44" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>

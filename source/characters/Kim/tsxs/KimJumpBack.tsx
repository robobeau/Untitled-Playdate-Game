<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimJumpBack" class="Animation" tilewidth="112" tileheight="128" tilecount="5" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../../../source/tsj/characters/Kim/KimJumpBack.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="1" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="112" height="128" source="../images/KimJumpBack2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="7" name="Pushbox" type="Pushbox" x="36" y="28" width="40" height="76"/>
   <object id="8" name="Hurtbox (Body)" type="Hurtbox" x="24" y="58" width="62" height="56"/>
   <object id="9" name="Hurtbox (Head)" type="Hurtbox" x="40" y="28" width="44" height="40"/>
   <object id="10" name="Center" type="Center" x="56" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="112" height="128" source="../images/KimJumpBack3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="8" name="Pushbox" type="Pushbox" x="36" y="22" width="40" height="76"/>
   <object id="9" name="Hurtbox (Body)" type="Hurtbox" x="30" y="56" width="50" height="56"/>
   <object id="10" name="Hurtbox (Head)" type="Hurtbox" x="36" y="22" width="40" height="38"/>
   <object id="11" name="Center" type="Center" x="56" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="112" height="128" source="../images/KimJumpBack4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="36" y="44" width="40" height="42"/>
   <object id="3" name="Hurtbox (Body)" type="Hurtbox" x="36" y="56" width="60" height="40"/>
   <object id="1" name="Hurtbox (Head)" type="Hurtbox" x="4" y="64" width="32" height="40"/>
   <object id="4" name="Center" type="Center" x="56" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="112" height="128" source="../images/KimJumpBack5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="36" y="44" width="40" height="42"/>
   <object id="3" name="Hurtbox (Body)" type="Hurtbox" x="36" y="12" width="40" height="60"/>
   <object id="1" name="Hurtbox (Head)" type="Hurtbox" x="44" y="72" width="40" height="32"/>
   <object id="4" name="Center" type="Center" x="56" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="5" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="frameDuration" type="int" value="4"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="3"/>
  </properties>
  <image width="112" height="128" source="../images/KimJumpBack6.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="36" y="44" width="40" height="42"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="14" y="56" width="60" height="40"/>
   <object id="3" name="Hurtbox (Head)" type="Hurtbox" x="74" y="48" width="32" height="40"/>
   <object id="5" name="Center" type="Center" x="56" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>

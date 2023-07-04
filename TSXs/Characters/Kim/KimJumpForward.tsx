<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimJumpForward" class="Animation" tilewidth="80" tileheight="128" tilecount="6" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../../../source/tsj/characters/Kim/KimJumpForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="1" type="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="blockCancellable" type="bool" value="true"/>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="frameDuration" type="int" value="2"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="80" height="128" source="../../../source/images/characters/Kim/KimJumpForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="6" name="Pushbox" type="Pushbox" x="20" y="28" width="40" height="76"/>
   <object id="7" name="Hurtbox (Body)" type="Hurtbox" x="8" y="58" width="62" height="56"/>
   <object id="8" name="Hurtbox (Head)" type="Hurtbox" x="24" y="28" width="44" height="40"/>
   <object id="9" name="Center" type="Center" x="40" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="blockCancellable" type="bool" value="true"/>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="frameDuration" type="int" value="2"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="80" height="128" source="../../../source/images/characters/Kim/KimJumpForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="6" name="Pushbox" type="Pushbox" x="20" y="22" width="40" height="76"/>
   <object id="7" name="Hurtbox (Body)" type="Hurtbox" x="14" y="56" width="50" height="56"/>
   <object id="8" name="Hurtbox (Head)" type="Hurtbox" x="20" y="22" width="40" height="38"/>
   <object id="9" name="Center" type="Center" x="40" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="blockCancellable" type="bool" value="true"/>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="frameDuration" type="int" value="2"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="80" height="128" source="../../../source/images/characters/Kim/KimJumpForward3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="9" name="Pushbox" type="Pushbox" x="20" y="22" width="40" height="76"/>
   <object id="10" name="Hurtbox (Body)" type="Hurtbox" x="8" y="44" width="62" height="54"/>
   <object id="11" name="Hurtbox (Head)" type="Hurtbox" x="20" y="22" width="40" height="38"/>
   <object id="12" name="Center" type="Center" x="40" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4" type="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="blockCancellable" type="bool" value="true"/>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="frameDuration" type="int" value="4"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="80" height="128" source="../../../source/images/characters/Kim/KimJumpForward4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="20" y="44" width="40" height="42"/>
   <object id="1" name="Hurtbox (Body)" type="Hurtbox" x="2" y="28" width="64" height="62"/>
   <object id="3" name="Hurtbox (Head)" type="Hurtbox" x="42" y="48" width="38" height="36"/>
   <object id="4" name="Center" type="Center" x="40" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="5" type="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="blockCancellable" type="bool" value="true"/>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="frameDuration" type="int" value="4"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="80" height="128" source="../../../source/images/characters/Kim/KimJumpForward5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="20" y="44" width="40" height="42"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="8" y="44" width="62" height="54"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="20" y="22" width="40" height="38"/>
   <object id="6" name="Center" type="Center" x="40" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="6" type="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="blockCancellable" type="bool" value="true"/>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="frameDuration" type="int" value="4"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="1"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="80" height="128" source="../../../source/images/characters/Kim/KimJumpForward6.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="20" y="44" width="40" height="42"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="14" y="28" width="64" height="62"/>
   <object id="3" name="Hurtbox (Head)" type="Hurtbox" x="0" y="34" width="38" height="36"/>
   <object id="5" name="Center" type="Center" x="40" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>

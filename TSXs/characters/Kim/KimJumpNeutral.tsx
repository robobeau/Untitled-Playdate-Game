<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimJumpNeutral" class="Animation" tilewidth="80" tileheight="128" tilecount="3" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../../../source/tsj/characters/Kim/KimJumpNeutral.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="1" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="duration" type="int" value="2"/>
  </properties>
  <image width="80" height="128" source="../../../source/characters/Kim/images/KimJumpNeutral1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="6" name="Pushbox" type="Pushbox" x="20" y="28" width="40" height="76"/>
   <object id="7" name="Hurtbox (Mid)" type="Hurtbox" x="8" y="58" width="62" height="56"/>
   <object id="8" name="Hurtbox (High)" type="Hurtbox" x="24" y="28" width="44" height="40"/>
   <object id="9" name="Center" type="Center" x="40" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="duration" type="int" value="2"/>
  </properties>
  <image width="80" height="128" source="../../../source/characters/Kim/images/KimJumpNeutral2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="6" name="Pushbox" type="Pushbox" x="20" y="22" width="40" height="76"/>
   <object id="7" name="Hurtbox (Mid)" type="Hurtbox" x="14" y="56" width="50" height="56"/>
   <object id="8" name="Hurtbox (High)" type="Hurtbox" x="20" y="22" width="40" height="38"/>
   <object id="9" name="Center" type="Center" x="40" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="duration" type="int" value="10"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="1"/>
  </properties>
  <image width="80" height="128" source="../../../source/characters/Kim/images/KimJumpNeutral3.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="6" name="Pushbox" type="Pushbox" x="20" y="22" width="40" height="76"/>
   <object id="7" name="Hurtbox (Mid)" type="Hurtbox" x="8" y="44" width="62" height="54"/>
   <object id="8" name="Hurtbox (High)" type="Hurtbox" x="20" y="22" width="40" height="38"/>
   <object id="9" name="Center" type="Center" x="40" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>

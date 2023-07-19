<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimKickJumpNeutral" class="Animation" tilewidth="112" tileheight="128" tilecount="3" columns="0">
 <editorsettings>
  <export target="../../../source/tsj/characters/Kim/KimKickJumpNeutral.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="112" height="128" source="../../../source/characters/Kim/images/KimKickJumpNeutral1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="36" y="66" width="40" height="42"/>
   <object id="2" name="Hurtbox (Body)" type="Hurtbox" x="34" y="62" width="48" height="56"/>
   <object id="4" name="Hurtbox (Head)" type="Hurtbox" x="36" y="44" width="38" height="32"/>
   <object id="5" name="Center" type="Center" x="56" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="8"/>
  </properties>
  <image width="112" height="128" source="../../../source/characters/Kim/images/KimKickJumpNeutral2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="16" y="60" width="40" height="42"/>
   <object id="2" name="Hurtbox (Body)" type="Hurtbox" x="4" y="60" width="58" height="46"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="18" y="38" width="38" height="36"/>
   <object id="1" name="Hitbox" type="Hitbox" x="58" y="70" width="58" height="30">
    <properties>
     <property name="damage" type="int" value="75"/>
     <property name="dizzy" type="int" value="75"/>
     <property name="hits" propertytype="Attack" value="HIGH"/>
     <property name="hitstun" type="int" value="5"/>
     <property name="pushback" type="int" value="5"/>
     <property name="super" type="int" value="75"/>
     <property name="velocityX" type="int" value="16"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="36" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="1"/>
  </properties>
  <image width="112" height="128" source="../../../source/characters/Kim/images/KimKickJumpNeutral1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="36" y="66" width="40" height="42"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="34" y="62" width="48" height="56"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="36" y="44" width="38" height="32"/>
   <object id="6" name="Center" type="Center" x="56" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>

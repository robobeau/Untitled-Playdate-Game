<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimPunchJumpForward" class="Animation" tilewidth="64" tileheight="96" tilecount="1" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimPunchJumpForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="8"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="1"/>
  </properties>
  <image width="64" height="96" source="../../../source/images/characters/Kim/KimPunchJumpForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="12" y="8" width="40" height="60"/>
   <object id="4" name="Pushbox" class="Pushbox" x="-4" y="12" width="72" height="84"/>
   <object id="5" name="Hitbox" class="Hitbox" x="34" y="68" width="34" height="32">
    <properties>
     <property name="velocityX" type="int" value="12"/>
     <property name="velocityY" type="int" value="16"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
</tileset>

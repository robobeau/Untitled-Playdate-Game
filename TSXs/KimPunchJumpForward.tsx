<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimPunchJumpForward" class="Animation" tilewidth="96" tileheight="128" tilecount="3" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimPunchJumpForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="8"/>
  </properties>
  <image width="64" height="96" source="../source/images/Kim/KimPunchJumpForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="12" y="8" width="40" height="60"/>
   <object id="4" name="Pushbox" class="Pushbox" x="-4" y="12" width="72" height="84"/>
   <object id="5" name="Hitbox" class="Hitbox" x="34" y="68" width="34" height="32">
    <properties>
     <property name="velocityX" type="int" value="6"/>
     <property name="velocityY" type="int" value="2"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="96" height="128" source="../source/images/Kim/KimPunchJumpForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="28" y="44" width="40" height="74"/>
   <object id="2" name="Pushbox" class="Pushbox" x="12" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="loops" type="bool" value="true"/>
  </properties>
  <image width="96" height="128" source="../source/images/Kim/KimPunchJumpForward3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="28" y="22" width="40" height="90"/>
   <object id="2" name="Pushbox" class="Pushbox" x="12" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>

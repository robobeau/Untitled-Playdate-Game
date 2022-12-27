<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimDiveKick" class="Animation" tilewidth="40" tileheight="56" tilecount="2" columns="0">
 <editorsettings>
  <export target="../source/tsj/KimDiveKick.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
   <property name="ignoreGravity" type="bool" value="true"/>
   <property name="velocityX" type="int" value="4"/>
   <property name="velocityY" type="int" value="8"/>
  </properties>
  <image width="40" height="56" source="../source/images/Kim/KimDiveKick1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Hitbox" class="Hitbox" x="10" y="43" width="27" height="13">
    <properties>
     <property name="velocityX" type="int" value="4"/>
     <property name="velocityY" type="int" value="4"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox" class="Hurtbox" x="10" y="5" width="20" height="38"/>
   <object id="1" name="Pushbox" class="Pushbox" x="2" y="14" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
   <property name="ignoreGravity" type="bool" value="true"/>
  </properties>
  <image width="40" height="56" source="../source/images/Kim/KimDiveKick2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Hitbox" class="Hitbox" x="10" y="43" width="27" height="13">
    <properties>
     <property name="velocityX" type="int" value="4"/>
     <property name="velocityY" type="int" value="4"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox" class="Hurtbox" x="10" y="5" width="20" height="38"/>
   <object id="1" name="Pushbox" class="Pushbox" x="2" y="14" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>

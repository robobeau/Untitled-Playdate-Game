<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimDiveKick" class="Animation" tilewidth="80" tileheight="112" tilecount="2" columns="0">
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
  <image width="80" height="112" source="../source/images/Kim/KimDiveKick1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Hitbox" class="Hitbox" x="20" y="86" width="54" height="26">
    <properties>
     <property name="velocityX" type="int" value="12"/>
     <property name="velocityY" type="int" value="12"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox" class="Hurtbox" x="20" y="10" width="40" height="76"/>
   <object id="1" name="Pushbox" class="Pushbox" x="4" y="28" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
   <property name="ignoreGravity" type="bool" value="true"/>
  </properties>
  <image width="80" height="112" source="../source/images/Kim/KimDiveKick2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Hitbox" class="Hitbox" x="20" y="86" width="54" height="26">
    <properties>
     <property name="velocityX" type="int" value="12"/>
     <property name="velocityY" type="int" value="12"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox" class="Hurtbox" x="20" y="10" width="40" height="76"/>
   <object id="1" name="Pushbox" class="Pushbox" x="4" y="28" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>

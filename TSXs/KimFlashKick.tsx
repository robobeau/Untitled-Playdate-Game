<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimFlashKick" class="Animation" tilewidth="56" tileheight="64" tilecount="9" columns="0">
 <editorsettings>
  <export target="../source/tsj/KimFlashKick.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="velocityX" type="int" value="0"/>
  </properties>
  <image width="56" height="64" source="../source/images/Kim/KimFlashKick2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="20" y="25" width="21" height="39"/>
   <object id="1" name="Pushbox" class="Pushbox" x="10" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="velocityX" type="int" value="2"/>
   <property name="velocityY" type="int" value="-12"/>
  </properties>
  <image width="56" height="64" source="../source/images/Kim/KimFlashKick3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="15" y="23" width="19" height="41"/>
   <object id="1" name="Pushbox" class="Pushbox" x="10" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="56" height="64" source="../source/images/Kim/KimFlashKick3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="15" y="23" width="19" height="41"/>
   <object id="1" name="Pushbox" class="Pushbox" x="10" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="56" height="64" source="../source/images/Kim/KimFlashKick4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="41" y="37" width="15" height="19">
    <properties>
     <property name="velocityX" type="int" value="2"/>
     <property name="velocityY" type="int" value="6"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox" class="Hurtbox" x="2" y="32" width="46" height="20"/>
   <object id="1" name="Pushbox" class="Pushbox" x="10" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="5" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="6"/>
  </properties>
  <image width="56" height="64" source="../source/images/Kim/KimFlashKick5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Hitbox" class="Hitbox" x="31" y="32" width="22" height="22">
    <properties>
     <property name="velocityX" type="int" value="4"/>
     <property name="velocityY" type="int" value="4"/>
    </properties>
   </object>
   <object id="2" name="Hitbox" class="Hitbox" x="3" y="3" width="50" height="29">
    <properties>
     <property name="velocityX" type="int" value="2"/>
     <property name="velocityY" type="int" value="6"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox" class="Hurtbox" x="13" y="30" width="18" height="24"/>
   <object id="1" name="Pushbox" class="Pushbox" x="10" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="6" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="56" height="64" source="../source/images/Kim/KimFlashKick6.png"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Hitbox" class="Hitbox" x="31" y="32" width="22" height="22">
    <properties>
     <property name="velocityX" type="int" value="4"/>
     <property name="velocityY" type="int" value="4"/>
    </properties>
   </object>
   <object id="5" name="Hitbox" class="Hitbox" x="3" y="3" width="50" height="29">
    <properties>
     <property name="velocityX" type="int" value="2"/>
     <property name="velocityY" type="int" value="6"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox" class="Hurtbox" x="13" y="26" width="23" height="28"/>
   <object id="1" name="Pushbox" class="Pushbox" x="10" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="7" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="56" height="64" source="../source/images/Kim/KimFlashKick7.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="10" y="33" width="37" height="18"/>
   <object id="1" name="Pushbox" class="Pushbox" x="10" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="8" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="56" height="64" source="../source/images/Kim/KimFlashKick8.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="18" y="16" width="20" height="37"/>
   <object id="1" name="Pushbox" class="Pushbox" x="10" y="16" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="9" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="loops" type="bool" value="true"/>
  </properties>
  <image width="56" height="64" source="../source/images/Kim/KimFlashKick9.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="18" y="11" width="20" height="45"/>
   <object id="1" name="Pushbox" class="Pushbox" x="10" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>

<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimKickNeutral" class="Animation" tilewidth="96" tileheight="96" tilecount="4" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimKickNeutral.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="96" height="96" source="../source/images/Kim/KimKickNeutral1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="50" y="18" width="34" height="78"/>
   <object id="3" name="Pushbox" class="Pushbox" x="24" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="96" height="96" source="../source/images/Kim/KimKickNeutral2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="26" y="6" width="40" height="90"/>
   <object id="4" name="Pushbox" class="Pushbox" x="24" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="9"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="96" height="96" source="../source/images/Kim/KimKickNeutral3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="50" y="8" width="52" height="48">
    <properties>
     <property name="velocityX" type="int" value="16"/>
     <property name="velocityY" type="int" value="-16"/>
    </properties>
   </object>
   <object id="1" name="Hurtbox" class="Hurtbox" x="10" y="8" width="40" height="88"/>
   <object id="3" name="Pushbox" class="Pushbox" x="24" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="96" height="96" source="../source/images/Kim/KimKickNeutral4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Hurtbox" class="Hurtbox" x="50" y="18" width="34" height="78"/>
   <object id="5" name="Pushbox" class="Pushbox" x="24" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>

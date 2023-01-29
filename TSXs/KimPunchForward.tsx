<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimPunchForward" class="Animation" tilewidth="128" tileheight="80" tilecount="3" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimPunchForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="128" height="80" source="../source/images/Kim/KimPunchForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="22" y="2" width="42" height="78"/>
   <object id="4" name="Pushbox" class="Pushbox" x="0" y="-4" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="9"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="128" height="80" source="../source/images/Kim/KimPunchForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="90" y="26" width="42" height="30">
    <properties>
     <property name="velocityX" type="int" value="6"/>
    </properties>
   </object>
   <object id="1" name="Hurtbox" class="Hurtbox" x="48" y="6" width="42" height="74"/>
   <object id="3" name="Pushbox" class="Pushbox" x="0" y="-4" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="128" height="80" source="../source/images/Kim/KimPunchForward3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="22" y="2" width="42" height="78"/>
   <object id="2" name="Pushbox" class="Pushbox" x="0" y="-4" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>

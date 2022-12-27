<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimKickJumpNeutral" class="Animation" tilewidth="56" tileheight="64" tilecount="5" columns="0">
 <editorsettings>
  <export target="../source/tsj/KimKickJumpNeutral.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="56" height="64" source="../source/images/Kim/KimKickJumpNeutral1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="18" y="22" width="19" height="37"/>
   <object id="3" name="Pushbox" class="Pushbox" x="10" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="8"/>
  </properties>
  <image width="56" height="64" source="../source/images/Kim/KimKickJumpNeutral2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hitbox" class="Hitbox" x="34" y="35" width="24" height="15">
    <properties>
     <property name="velocityX" type="int" value="6"/>
     <property name="velocityY" type="int" value="4"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox" class="Hurtbox" x="9" y="19" width="19" height="34"/>
   <object id="3" name="Pushbox" class="Pushbox" x="0" y="19" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="56" height="64" source="../source/images/Kim/KimKickJumpNeutral1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="18" y="22" width="19" height="37"/>
   <object id="1" name="Pushbox" class="Pushbox" x="10" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="56" height="64" source="../source/images/Kim/KimKickJumpNeutral4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="18" y="22" width="20" height="37"/>
   <object id="2" name="Pushbox" class="Pushbox" x="10" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="loops" type="bool" value="true"/>
  </properties>
  <image width="56" height="64" source="../source/images/Kim/KimKickJumpNeutral5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="18" y="11" width="20" height="45"/>
   <object id="2" name="Pushbox" class="Pushbox" x="10" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>

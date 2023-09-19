<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimPunchForward" class="Animation" tilewidth="128" tileheight="80" tilecount="3" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../../../source/characters/Kim/TSJs/KimPunchForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="128" height="80" source="../../../source/characters/Kim/images/KimPunchForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Pushbox" type="Pushbox" x="16" y="-4" width="40" height="84"/>
   <object id="7" name="Hurtbox (Low)" type="Hurtbox" x="4" y="64" width="64" height="16">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="8" name="Hurtbox (MId)" type="Hurtbox" x="8" y="22" width="50" height="42">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="1" name="Hurtbox (High)" type="Hurtbox" x="22" y="2" width="42" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="5" name="Center" type="Center" x="36" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="0"/>
   <property name="frameDuration" type="int" value="9"/>
  </properties>
  <image width="128" height="80" source="../../../source/characters/Kim/images/KimPunchForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="16" y="-4" width="40" height="84"/>
   <object id="6" name="Hurtbox (Low)" type="Hurtbox" x="10" y="66" width="78" height="14">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="5" name="Hurtbox (Mid)" type="Hurtbox" x="28" y="26" width="54" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="1" name="Hurtbox (High)" type="Hurtbox" x="48" y="6" width="42" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="2" name="Hitbox" type="Hitbox" x="82" y="26" width="50" height="30">
    <properties>
     <property name="damage" type="int" value="100"/>
     <property name="hitstun" type="int" value="5"/>
     <property name="pushback" type="int" value="5"/>
     <property name="super" type="int" value="100"/>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
     <property name="velocityX" type="int" value="16"/>
     <property name="velocityY" type="int" value="-8"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="36" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="128" height="80" source="../../../source/characters/Kim/images/KimPunchForward3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="16" y="-4" width="40" height="84"/>
   <object id="7" name="Hurtbox (Low)" type="Hurtbox" x="4" y="64" width="64" height="16">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="8" name="Hurtbox (MId)" type="Hurtbox" x="8" y="22" width="50" height="42">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="5" name="Hurtbox (High)" type="Hurtbox" x="22" y="2" width="42" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="6" name="Center" type="Center" x="36" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>

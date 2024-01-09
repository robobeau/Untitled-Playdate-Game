<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimPunchForward" class="Animation" tilewidth="128" tileheight="80" tilecount="3" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../../../source/characters/Kim/TSJs/KimPunchForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="66" height="78" source="../../../source/characters/Kim/images/KimPunchForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Pushbox" type="Pushbox" x="14" y="-6" width="40" height="84"/>
   <object id="7" name="Hurtbox (Low)" type="Hurtbox" x="2" y="62" width="64" height="16">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="8" name="Hurtbox (MId)" type="Hurtbox" x="6" y="20" width="50" height="42">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="1" name="Hurtbox (High)" type="Hurtbox" x="20" y="0" width="42" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="5" name="Center" type="Center" x="34" y="78">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="118" height="74" source="../../../source/characters/Kim/images/KimPunchForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="6" y="-10" width="40" height="84"/>
   <object id="6" name="Hurtbox (Low)" type="Hurtbox" x="0" y="60" width="78" height="14">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="5" name="Hurtbox (Mid)" type="Hurtbox" x="18" y="20" width="54" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="1" name="Hurtbox (High)" type="Hurtbox" x="38" y="0" width="42" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="2" name="Hitbox" type="Hitbox" x="72" y="20" width="50" height="30">
    <properties>
     <property name="damage" type="int" value="25"/>
     <property name="hitstun" type="int" value="4"/>
     <property name="pushback" type="int" value="2"/>
     <property name="super" type="int" value="100"/>
     <property name="type" type="int" propertytype="CollisionType" value="4"/>
     <property name="velocityX" type="int" value="16"/>
     <property name="velocityY" type="int" value="-8"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="26" y="74">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="66" height="78" source="../../../source/characters/Kim/images/KimPunchForward3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="14" y="-6" width="40" height="84"/>
   <object id="7" name="Hurtbox (Low)" type="Hurtbox" x="2" y="62" width="64" height="16">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="8" name="Hurtbox (MId)" type="Hurtbox" x="6" y="20" width="50" height="42">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="5" name="Hurtbox (High)" type="Hurtbox" x="20" y="0" width="42" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="6" name="Center" type="Center" x="34" y="78">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>

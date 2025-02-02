<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimHurt" class="Animation" tilewidth="112" tileheight="80" tilecount="2" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../../../source/characters/Kim/animations/KimHurt.lua" format="lua"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
  </properties>
  <image width="112" height="80" source="../../../source/characters/Kim/images/KimHurt1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="34" y="-4" width="40" height="84"/>
   <object id="3" name="Center" type="Center" x="54" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="duration" type="int" value="1"/>
   <property name="loops" type="bool" value="true"/>
  </properties>
  <image width="112" height="80" source="../../../source/characters/Kim/images/KimHurt2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="56" y="-4" width="40" height="84"/>
   <object id="4" name="Hurtbox (Low)" type="Hurtbox" x="50" y="60" width="54" height="20">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="5" name="Hurtbox (Mid)" type="Hurtbox" x="40" y="10" width="52" height="50">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="4"/>
    </properties>
   </object>
   <object id="6" name="Hurtbox (High)" type="Hurtbox" x="8" y="14" width="36" height="42">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="3" name="Center" type="Center" x="76" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>

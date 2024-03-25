<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimStand" class="Animation" tilewidth="80" tileheight="96" tilecount="4" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimStand.lua" format="lua"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="0" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="251"/>
   <property name="duration" type="int" value="3"/>
  </properties>
  <image width="72" height="84" source="../../../source/characters/Kim/images/KimStand1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="16" y="0" width="40" height="84"/>
   <object id="6" name="Hurtbox (Low)" type="Hurtbox" x="4" y="68" width="64" height="16">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (Mid)" type="Hurtbox" x="10" y="30" width="46" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="1" name="Hurtbox (High)" type="Hurtbox" x="16" y="0" width="40" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="36" y="84">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="251"/>
   <property name="duration" type="int" value="4"/>
  </properties>
  <image width="72" height="86" source="../../../source/characters/Kim/images/KimStand2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="16" y="2" width="40" height="84"/>
   <object id="7" name="Hurtbox (Low)" type="Hurtbox" x="4" y="68" width="64" height="18">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="10" y="30" width="46" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="16" y="0" width="40" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="5" name="Center" type="Center" x="36" y="86">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="251"/>
   <property name="duration" type="int" value="5"/>
  </properties>
  <image width="72" height="86" source="../../../source/characters/Kim/images/KimStand3.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="16" y="2" width="40" height="84"/>
   <object id="6" name="Hurtbox (Low)" type="Hurtbox" x="4" y="68" width="64" height="18">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="10" y="28" width="46" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="16" y="0" width="40" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="5" name="Center" type="Center" x="36" y="86">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="251"/>
   <property name="duration" type="int" value="3"/>
  </properties>
  <image width="72" height="84" source="../../../source/characters/Kim/images/KimStand1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="16" y="0" width="40" height="84"/>
   <object id="6" name="Hurtbox (Low)" type="Hurtbox" x="4" y="68" width="64" height="16">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (Mid)" type="Hurtbox" x="10" y="30" width="46" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="4" name="Hurtbox (High)" type="Hurtbox" x="16" y="0" width="40" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="5" name="Center" type="Center" x="36" y="84">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>

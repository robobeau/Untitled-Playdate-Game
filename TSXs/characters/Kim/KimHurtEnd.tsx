<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimHurtEnd" class="Animation" tilewidth="62" tileheight="72" tilecount="1" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../../../source/characters/Kim/TSJs/KimHurtEnd.lua" format="lua"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="4194304"/>
  </properties>
  <image width="62" height="72" source="../../../source/characters/Kim/images/KimHurtEnd1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="9" name="Pushbox" type="Pushbox" x="10" y="-12" width="40" height="84"/>
   <object id="10" name="Hurtbox (Low)" type="Hurtbox" x="0" y="58" width="58" height="14">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="11" name="Hurtbox (Mid)" type="Hurtbox" x="2" y="18" width="44" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="12" name="Hurtbox (High)" type="Hurtbox" x="16" y="0" width="40" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="13" name="Center" type="Center" x="30" y="72">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>

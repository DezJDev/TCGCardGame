<?php
error_reporting(0);
function getAllCards($langue){
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_CAINFO, 'C:\Users\Jérémy\Php\php-8.3.0\cacert.pem');
    curl_setopt($ch, CURLOPT_URL, "https://api.tcgdex.net/v2/$langue/cards");
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    $response = curl_exec($ch);
    if ($response === false){echo 'getAllCards - cURL error: ' . curl_error($ch);}
    curl_close($ch);
    return json_decode($response, true);
}
function getIdVersionsByVersion($version, $langue):array{
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_CAINFO, 'C:\Users\Jérémy\Php\php-8.3.0\cacert.pem');
    curl_setopt($ch, CURLOPT_URL, "https://api.tcgdex.net/v2/$langue/series/$version");
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    $response = curl_exec($ch);
    if ($response === false){echo 'getIdVersionsByVersion - cURL error: ' . curl_error($ch);}
    curl_close($ch);

    $data = json_decode($response, true);
    $versions = [];
    foreach($data["sets"] as $valeur)
        $versions[] = $valeur["id"];
    return $versions;
}

function getCardIdbyIdVersion($ids, $data):array{
    $resultat = [];
    foreach($data as $val){
        foreach($ids as $IdVersion){
            if(str_contains($val["id"], $IdVersion))
            {$resultat[] = $val;}
        }
    }
    return $resultat;
}

function getDetailsbyIdCard($id, $langue){
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_CAINFO, 'C:\Users\Jérémy\Php\php-8.3.0\cacert.pem');
    curl_setopt($ch, CURLOPT_URL, "https://api.tcgdex.net/v2/$langue/cards/$id");
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    $response = curl_exec($ch);
    if ($response === false){echo 'getDetailsbyIdCard - cURL error: ' . curl_error($ch);}
    curl_close($ch);
    return json_decode($response, true);
}

function getNameVersionByIdVersion($id, $langue): string{
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_CAINFO, 'C:\Users\Jérémy\Php\php-8.3.0\cacert.pem');
    curl_setopt($ch, CURLOPT_URL, "https://api.tcgdex.net/v2/$langue/sets");
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    $response = curl_exec($ch);
    if ($response === false){echo 'getDetailsbyIdCard - cURL error: ' . curl_error($ch);}
    curl_close($ch);
    $tab = json_decode($response, true);
    $taille = sizeof($tab);
    for($i = 0; $i<$taille; $i++){
        if($tab[$i]["id"] == $id){
            return $tab[$i]["name"];
        }
    }
    return "null";
}
function filterDataFromCardtoArray($Card, $langue): array{
    $id = $Card["id"];
    $category = $Card["category"];
    if($category == "Pokémon" or $category == "Pokemon") $nom = preg_replace('/Niv \d+/', '', $Card["name"]);
    else $nom = $Card["name"];
    $pv = $Card["hp"];
    $rarete = $Card["rarity"];
    $linkImg = $Card["image"]."/high.webp";
    $type = $Card["types"][0];
    $extension = getNameVersionByIdVersion(strstr($Card["id"], '-', true), $langue);
    $retrait = $Card["retreat"];

    //if(($category != "Pokémon" and $langue != "fr") or ($category != "Pokemon" and $langue != "en")) {$nomAbility = null; $effectAbility = $Card["effect"];}
    /*else{*/$nomAbility = $Card["abilities"][0]["name"]; $effectAbility = $Card["abilities"][0]["effect"];//}

    $Attaque1_cost = $Card["attacks"][0]["cost"][0].$Card["attacks"][0]["cost"][1].$Card["attacks"][0]["cost"][2].$Card["attacks"][0]["cost"][3];
    $Attaque1_name = $Card["attacks"][0]["name"];
    $Attaque1_effect = $Card["attacks"][0]["effect"];
    $Attaque1_damage = $Card["attacks"][0]["damage"];

    $Attaque2_cost = $Card["attacks"][1]["cost"][0].$Card["attacks"][1]["cost"][1].$Card["attacks"][1]["cost"][2].$Card["attacks"][1]["cost"][3];
    $Attaque2_name = $Card["attacks"][1]["name"];
    $Attaque2_effect = $Card["attacks"][1]["effect"];
    $Attaque2_damage = $Card["attacks"][1]["damage"];

    $Resistance_type = $Card["resistances"][0]["type"];
    $Resistance_value = $Card["resistances"][0]["value"];

    $Faiblesse_type = $Card["weaknesses"][0]["type"];
    $Faiblesse_value = $Card["weaknesses"][0]["value"];





    return array("cardId" => $id,"cardCategory" => $category, "cardName" => $nom, "cardHP" => $pv,"cardRarity" => $rarete, "cardImg" => $linkImg, "cardType" => $type, "cardExtension" => $extension, "cardRetreat" => $retrait, "cardLang" => "$langue", "abilityName" => $nomAbility, "abilityEffect" => $effectAbility, "attackName1" => $Attaque1_name, "attackCost1" => $Attaque1_cost, "attackDamage1" => $Attaque1_damage, "attackEffect1" => $Attaque1_effect, "attackName2" => $Attaque2_name, "attackCost2" => $Attaque2_cost, "attackDamage2" => $Attaque2_damage, "attackEffect2" => $Attaque2_effect, "resistanceType" => $Resistance_type, "resistanceValue" => $Resistance_value, "weaknessType" => $Faiblesse_type, "weaknessValue" => $Faiblesse_value);

    /*array("id" => $Card["id"], "category" => $Card["category"], "nom" => $Card["name"], "pv" => $Card["hp"], "rarete" => $Card["rarity"], "linkImg" => $Card["image"] . "/high.webp", "types" => $Card["types"],
    "ability" => $Card["abilities"], "attaques" => $Card["attacks"], "faiblesses" => $Card["weaknesses"], "resistances" => $Card["resistances"], "retrait" => $Card["retreat"]);}*/

}

function addAllCardsinFile($path, $version, $langue): void{
    $data = getAllCards($langue);
    $identifiants = getIdVersionsByVersion($version, $langue);
    $versionCards = getCardIdbyIdVersion($identifiants, $data);
    $i = 0;
    $taille = sizeof($versionCards);
    while($i < $taille){
        $Card = filterDataFromCardtoArray(getDetailsbyIdCard($versionCards[$i]["id"], $langue), $langue);
        $chaine = "";
        foreach($Card as $key => $value) {
            if($value == "")$value = "null";
            if($key == array_key_last($Card)){
                $chaine .= $key .":" . $value."\n";}
            else {
                $chaine .= $key .":" . $value . "|";}
        }

        file_put_contents($path, $chaine, FILE_APPEND);
        echo $chaine;
        $i = $i + 1;}}


$version = "Black%20&%20White";
$langue = "en";
$path = "C:\Users\Jérémy\Documents\L3 Informatique\Etude\Bases de Données\\$langue-DataBlackWhite.txt";
addAllCardsinFile($path, $version, $langue);



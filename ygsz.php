<?php
for ($i = 0; $i < 5; $i++) {
    task();
}
 
function task() {
    $url = "http://www.monsterbook.com.cn/invite/?userid=1067372&cid=0";
    $ip = "100.".rand(1, 255).".".rand(1, 255).".".rand(1, 255);
    $headers = array("X-FORWARDED-FOR:$ip");
 
    $curl = curl_init($url);
    curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($curl, CURLOPT_USERAGENT,  "Mozilla/4.0");
    $src = curl_exec($curl);
    curl_close($curl);
    $str="finished !";
    echo $str;
}
?>

<?php

function activeMenu($url, $class = 'active')
{
    $ci = &get_instance();
    $active = false;
    if ($ci->uri->uri_string() == $url) {
        $active = true;
    }
    $return = null;
    if ($active) {
        $return = $class;
    }
    return $return;
}

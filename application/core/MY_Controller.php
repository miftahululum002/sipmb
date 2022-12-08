<?php
defined('BASEPATH') or exit('No direct script access allowed');

class BaseController extends CI_Controller
{

    public function render($filename, $data)
    {
        $this->load->view('template/app_top', $data);
        $this->load->view('template/template_scripts', $data);
        $this->load->view($filename, $data);
        $this->load->view('template/app_bottom', $data);
    }
}

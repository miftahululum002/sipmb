<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Index extends BaseController
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('M_pmb', 'm_pmb');
    }

    public function index()
    {
        $data['title'] = 'Dashboard';
        $this->render('index/index', $data);
    }

    public function pendaftarprodi1()
    {
        $data['title'] = 'Grafik Berdasarkan Prodi 1';
        $prodi = $this->m_pmb->listProdi();
        foreach ($prodi as $key => $p) {
            $prodi[$key]['jumlah'] = $this->m_pmb->jumlahPendaftarProdi1($p['id_prodi']);
            $prodi[$key]['jumlah2'] = $this->m_pmb->jumlahPendaftarProdi2($p['id_prodi']);
            $prodi[$key]['size'] = rand(10, 30);
        }

        //grafik pertama
        $result = null;
        foreach ($prodi as $p => $prod) {
            // if ($prod['jumlah'] > $sum) {
            //     $sum = $prod['jumlah'];
            //     $sliced = true;
            //     $selected = true;
            // }
            $result[$p] = [
                "name"  => $prod['nama_prodi'],
                "jumlah" => $prod['jumlah'],
                "y"     => $prod['size'],
                // "sliced" => $sliced,
                // 'selected' => $selected
            ];
        }

        $data['pendaftar'] = $prodi;
        $data['grafik1'] = json_encode($result);
        $this->render('index/grafik_satu', $data);
    }

    public function pendaftarprodi2()
    {
        $data['title'] = 'Grafik Berdasarkan Prodi 2';
        $prodi = $this->m_pmb->listProdi();
        foreach ($prodi as $key => $p) {
            $prodi[$key]['jumlah'] = $this->m_pmb->jumlahPendaftarProdi1($p['id_prodi']);
            $prodi[$key]['jumlah2'] = $this->m_pmb->jumlahPendaftarProdi2($p['id_prodi']);
            $prodi[$key]['size'] = rand(10, 30);
        }

        //grafik kedua
        $hasil = null;
        foreach ($prodi as $p => $prod) {
            $hasil[$p] = [
                "name"  => $prod['nama_prodi'],
                "jumlah" => $prod['jumlah2'],
                "y"     => $prod['size'],
                // "sliced" => $sliced,
                // 'selected' => $selected
            ];
        }

        $data['pendaftar'] = $prodi;
        $data['grafik2'] = json_encode($hasil);
        $this->render('index/grafik_dua', $data);
    }
}

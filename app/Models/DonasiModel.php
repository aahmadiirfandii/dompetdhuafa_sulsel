<?php

namespace App\Models;

use CodeIgniter\Model;

class DonasiModel extends Model
{
    protected $table = 'data_donasi';
    protected $primaryKey = 'id_donasi';

    protected $returnType = 'object';

    protected $allowedFields = ['id_donasi', 'id_donatur', 'id_jenis_donasi', 'id_subjenis_donasi', 'id_target_donasi', 'id_metode_pembayaran', 'nominal', 'kode_unik', 'total_pembayaran', 'status'];


    protected $useTimestamps = true;
    protected $createdField  = 'iat';
    protected $updatedField  = 'uat';
    protected $deletedField  = '';

    protected $validationRules = [
        'id_donasi'             => 'required',
        'id_donatur'            => 'required',
        'id_jenis_donasi'       => 'required',
        'id_metode_pembayaran'  => 'required',
        'nominal'               => 'required',
        'kode_unik'             => 'required',
        'total_pembayaran'      => 'required',
    ];
    protected $validationMessages = [];
    protected $skipValidation     = false;

    public function getData($primaryKey = false)
    {
        if ($primaryKey === false) {
            return $this->findAll();
        }

        return $this->asArray()
            ->where(['id_donasi' => $primaryKey])
            ->first();
    }

	public function getDataWithRelations($primaryKey = false){
		$db      = \Config\Database::connect();
		$builder = $db->table($this->table);
		if ($primaryKey === false) {
			// return $this->findAll();
			$builder->select("*");
			$builder->join('master_jenis_donasi', 'master_jenis_donasi.id_jenis_donasi = data_donasi.id_jenis_donasi');
			$builder->join('master_subjenis_donasi', 'master_subjenis_donasi.id_subjenis_donasi = data_donasi.id_subjenis_donasi');
			$builder->join('master_target_donasi', 'master_target_donasi.id_target_donasi = data_donasi.id_target_donasi');
			$builder->join('data_donatur', 'data_donatur.id_donatur = data_donasi.id_donatur');
			$query = $builder->get();
			return $query->getResult();
		}

		$builder->select("*");
		$builder->join('master_jenis_donasi', 'master_jenis_donasi.id_jenis_donasi = data_donasi.id_jenis_donasi');
		$builder->join('master_subjenis_donasi', 'master_subjenis_donasi.id_subjenis_donasi = data_donasi.id_subjenis_donasi');
		$builder->join('master_target_donasi', 'master_target_donasi.id_target_donasi = data_donasi.id_target_donasi');
		$builder->join('data_donatur', 'data_donatur.id_donatur = data_donasi.id_donatur');
		$builder->where("data_donasi.id_donasi", $primaryKey);
		$query = $builder->get();
		return $query->getRow();
	}

    public function getNewPK()
    {
        do {
            $id = mt_rand(1, 9) . random_string('numeric', 15);
        } while ($this->where(['id_donasi' => $id])->countAllResults() > 0);
        return $id;
    }
}

<?php

namespace App\Repositories;

use Illuminate\Pagination\Paginator;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use App\TokenModel;
use DateTime;

class APIServiceRepository
{

  public function __construct()
  { }

  // Usuario
  public function getUser($nombre, $contrasena)
  {
    $user = DB::select('SELECT * FROM `al_user` WHERE alias_name ="' . strtolower($nombre) . '" and  user_password = "' . strtolower($contrasena) . '"');
    return $user;
  }

  // Validacion completa login
  public function getUser_validate($nombre)
  {
    $user = DB::select('SELECT * FROM `al_user` WHERE alias_name ="' . strtolower($nombre) . '" ');
    return $user;
  }
  // *** INDICADORES ****
  // getArea
  public function getArea()
  {
    $areas = DB::select('select name from al_area');
    return $areas;
  }

  // getArea
  public function getAreaDescription($area)
  {
    $factor_area = DB::select('select al_f.name from al_factor as al_f inner join al_area as al_a on al_f.al_area_id = al_a.al_area_id where al_a.description = "' . $area . '"');
    return $factor_area;
  }

  //
  public function getIndicatorByFactor($factor)
  {
    $indicator = DB::select('select al_i.name from al_indicators as al_i inner join al_factor as al_f on al_i.al_factor_id = al_f.al_factor_id where al_f.name ="' . $factor . '"');
    return $indicator;
  }
  // *** MONTHLY**
  // Q.1
  public function getMonthly($anio, $nombre)
  {
    $monthCurrentYear = DB::select('SELECT SUM(current_year) as sumaActual, SUM(last_year) as sumaAnterior FROM `al_indicators_years` WHERE name = "' . $nombre . '" and year = "' . $anio . '"');
    return  $monthCurrentYear;
  }
  //Q.2
  public function getMonthlyMonth($mes, $anio, $nombre)
  {
    $monthCurrentYearMonth = DB::select('select last_month, current_month, variation_between_months, criterial, description from al_indicators_years where month ="' . $mes . '" and year = ' . "$anio" . ' and name = "' . $nombre . '"');
    return  $monthCurrentYearMonth;
  }
  // Interpretacion COmparacion
  public function comparation($nombre)
  {
    $resp_comparation = DB::select('select txt_affirmative from al_indicators where name = "' . $nombre . '"');
    return $resp_comparation;
  }
  public function comparationGetAll()
  {
    $comparacionData = DB::select('select * from al_token_user');
    return $comparacionData;
  }
  // INSERT TOKEN MODEL 
  public function insertDataToken($indicador, $mes, $anio, $tokenEncript)
  {
    $tokenEncript = str_replace('-', '/', $tokenEncript);
    $user_id = $this->decryptToken($tokenEncript); // Desecriptar el toquen y obtener el ID
    $dataToken = new TokenModel;
    // $dataToken->al_token_id = '3'; // auotincrement
    $dataToken->al_user_id = $user_id;
    $dataToken->consumido = 0;  // UPDATE
    $dataToken->token = $tokenEncript; //Guardar token encryptado
    $dataToken->nombre_indicador = $indicador; // param
    $dataToken->anio = $anio; //param
    $dataToken->mes = $mes; //param
    date_default_timezone_set('America/Guayaquil'); //configuro un nuevo timezone
    $fecha = new DateTime('NOW');
    $dataToken->created_at =  $fecha->format('Y-m-d H:i:s'); //param
    $dataToken->save();
  }
  public function decryptToken($tokenEncript)
  {

    $key = hex2bin("0123456789abcdef0123456789abcdef");
    $iv =  hex2bin("abcdef9876543210abcdef9876543210");
    $decrypted = openssl_decrypt($tokenEncript, 'AES-128-CBC', $key, OPENSSL_ZERO_PADDING, $iv);
    $decrypted = trim($decrypted);
    $idUsuario = explode('_', $decrypted);
    $idUsuario[1]; //1
    if (isset($idUsuario[1])) {
      // echo $decrypted = trim($decrypted);
      // echo "EL USUARIO Y TOKEN COINCIDEN";
      return $idUsuario[1];
    } else {
      return 0; 
    }
  }
  // **** VALIDAR LA HORA DE CADUCAION ****
  public function getUserValidateToken($token)
  {
    $userTokenExist = DB::select('select * from al_token_user where token = "' . $token . '"');
    return $userTokenExist;
  }
  public function updateConsumido($userId)
  {
    $update = DB::table('al_token_user')
    ->where('al_user_id', $userId)
    ->update(['consumido' => 1]);
    return $update;
  }

  // **** ss_configuration ****
  public function configurationData($id_org)
  {
    $configData = DB::select('select * from ss_configuration where al_org_id = ' . $id_org . '');
    return $configData;
  }

}   


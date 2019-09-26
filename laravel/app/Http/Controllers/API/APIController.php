<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Repositories\APIServiceRepository;
use App\Http\Controllers\API\BaseController;
use App\TokenModel;
class APIController extends BaseController
{
  public function getUser($nombre, $contrasena)
  {
    $api = new  APIServiceRepository();
    $usuario = $api->getUser($nombre, $contrasena);
    if (empty($usuario)) {
      return $this->sendError('Usuario no encontrado');

    }else{
      $data = [
        'id_user' => $usuario[0]->al_user_id,
        'email' => $usuario[0]->email,
        'name' => $usuario[0]->name,
      ];
      return $this->sendResponse($data, '');
  
    }
    
  }
//usuario -- valdiacion
 public function getUser_validate($nombre)
  {
    $api = new  APIServiceRepository();
    $usuario = $api->getUser_validate($nombre);
    if (empty($usuario)) {
      return $this->sendError('Usuario no encontrado');
    }else{
      $data = [
        'mensaje' => "Usuario encontrado",
        
      ];
      return $this->sendResponse($data, '');
    }
    
  }
  
  
  // Area
  public function getArea(){
      
      $api = new APIServiceRepository();
      $areas_name = $api->getArea();
      //validacion
      if(empty($areas_name)){
        return $this->sendError('Area no encontrada');
      }else{

          $nombres_areas= array();
          for( $i= 0 ; $i < count($areas_name) ; $i++){
              array_push($nombres_areas,$areas_name[$i]->name);
          }
          $data = [
            'areas' => $nombres_areas,
         
          ];
          return $this->sendResponse($data, '');         
      }
  }
  
  // GET FACTORES MEDIANTE AREAS DESCRIPTION
     public function getAreaDescription($description)
  {
    $api = new  APIServiceRepository();
    $factores = $api->getAreaDescription($description);
    if (empty($factores)) {
      return $this->sendError('Factores segun el area no encontradas');
    }else{
          $factoresPorArea= array();
          for( $i= 0 ; $i < count($factores) ; $i++){
              array_push($factoresPorArea,$factores[$i]->name);
          }
          $data = [
            'factoresPorArea' => $factoresPorArea,
           
           ];
          return $this->sendResponse($data, '');         
    }
    
  }
  // indicadores mediante factor nombre
  public function getIndicatorByFactor($factor){
     
      $api = new  APIServiceRepository();
    $indicadores = $api->getIndicatorByFactor($factor);
    if (empty($indicadores)) {
      return $this->sendError('Indicadore segun factor no encontrado');
    }else{
         $indicadorPorFactor= array();
          for( $i= 0 ; $i < count($indicadores) ; $i++){
              array_push($indicadorPorFactor,$indicadores[$i]->name);
              }
              $data = [
                'factor' => $factor,
                'indicadores' => $indicadorPorFactor,
               
               ];
              return $this->sendResponse($data, '');  
    } 
  } 

  // *****  MONTHLY ****
  // YEAR
   public function getMonthly($anio, $nombre)
  {
    $api = new  APIServiceRepository();
    $monthly = $api->getMonthly($anio, $nombre);
    if ($monthly[0]->sumaActual === null) {
      return $this->sendError('No monthly');
    }else{
         $anio = "año";
         $data = [
          'indicator' => $nombre,
          'monthly' => $monthly,
          'resta'=> round($monthly[0]->sumaActual - $monthly[0]->sumaAnterior, 2),
          'variacion' => round((($monthly[0]->sumaActual-$monthly[0]->sumaAnterior)/$monthly[0]->sumaAnterior)*100,2),
          'definicion' =>'es de ' .$monthly[0]->sumaActual. ', versus el '.$anio.'  anterior, que fue de ' .$monthly[0]->sumaAnterior. ' . La variacion es de ' .round($monthly[0]->sumaActual - $monthly[0]->sumaAnterior, 2). ', correspondiente al ' .round((($monthly[0]->sumaActual-$monthly[0]->sumaAnterior)/$monthly[0]->sumaAnterior)*100,2). ' %',
         
         ];
         return $this->sendResponse($data, '');  
    }
    
  }

    //MONTH
      public function getMonthlyMonth($mes,$anio, $nombre)
    {
    $api = new  APIServiceRepository();
    $monthlyMonth = $api->getMonthlyMonth($mes,$anio, $nombre);
    
    
    if (empty($monthlyMonth)) {
      return $this->sendError('No monthly');
    }else{
      $data = [
        'indicator' => $nombre,
        'monthly' => $monthlyMonth,
        'resta'=> round($monthlyMonth[0]->current_month -$monthlyMonth[0]->last_month, 2),
        'variacion' => $monthlyMonth[0]->variation_between_months,
        'definicion' =>'es de ' .$monthlyMonth[0]->current_month. ', versus el mes anterior, que fue de ' .$monthlyMonth[0]->last_month. ' . La variacion es de ' .round($monthlyMonth[0]->current_month - $monthlyMonth[0]->last_month, 2). ', correspondiente al ' .$monthlyMonth[0]->variation_between_months. ' %',
       
      ];
      return $this->sendResponse($data, '');  
    }
    
  }
    public function comparation($indicador){
    $api = new  APIServiceRepository();
    $comparation = $api->comparation($indicador);
    if (empty($comparation)) {
      return $this->sendError('No comparation');
    }else{
      $data = [
        'indicator' => $indicador,
        'txt_affirmative'=> $comparation[0]->txt_affirmative,

      ];
      return $this->sendResponse($data, '');  
    }
    }

    public function comparationGetAll(){
      $api = new  APIServiceRepository();
      $comparationData = $api->comparationGetAll();
      if (empty($comparation)) {
        return $this->sendError('No data comparation');
      }else{
        return $this->sendResponse($comparationData, '');  
      }
    }
    public function getAllTEST(){
      $api = new  APIServiceRepository();
      $data = $api->test();
      return $data;
    }

    //********************  TOKEN *********************
    public function insertToken($indicador , $mes, $anio, $tokenEncript){
      $api = new  APIServiceRepository();
      $data = $api->insertDataToken($indicador , $mes, $anio, $tokenEncript);
      return $data;
    }
    
    public function configurationData($id_org){
      
      $api = new  APIServiceRepository();
      $data = $api->configurationData($id_org);
      if (empty($data)) {
        return $this->sendError('No data config');
      }else{
    
      return $this->sendResponse($data[0], '');
          
          
    }
    }

}

<?php

namespace App\Http\Controllers;

use App\Repositories\DataServiceRepository;
use App\Repositories\APIServiceRepository;

use App\Http\Controllers\API\BaseController;


class Indicador extends BaseController
{

    public function indicatorMonthYear($indicador, $mes, $anio, $token)
    {
        $gestionBase =  new BaseController();
        $visitarpagina = $gestionBase->validateUserToken($token);
        $gestion =  new DataServiceRepository();
        $urlConsumida = $gestion->urlConsumido($token); // TAMBN EL ID de USUARIO
      
      
      if (empty($visitarpagina) || $urlConsumida[0]->consumido == 1) {
            return view('404');
        } else {
            $gestion =  new DataServiceRepository();
            //DATA
            $indicadores = $gestion->indicatorMonthYear($indicador, $mes, $anio);
            $factor = $indicadores[0]->description;
            $indicator = $indicadores[0]->name;
            $mes = $indicadores[0]->month; // actual    
            $mes_anterior_name = $gestion->mes_anterior_name($mes);
    
            // DATA VALORES
            $mes_actual = $indicadores[0]->current_month;
            $mes_anterior = $indicadores[0]->last_month; // funcion determina el mes
            $variacion = $indicadores[0]->current_month - $indicadores[0]->last_month;
    
            // CALCULO 
            $valor = $indicadores[0]->current_month;
    
            // CALCULO DEL PROPORSIONAL
            $base_total = $gestion->proporcionalTotalMonth($indicadores[0]->name, $indicadores[0]->year); // SUMATORIA
            $proporcionla_data = $this->proporsionales_Year($indicadores[0]->name, $indicadores[0]->year); // [{"marzo":18.232706917233},{"agosto":100}]
            // *********************** INTERPRETACION *******************
            $valores_interpretacion = $gestion->interpretacionIndicador($indicadores[0]->name); // SUMATORIA
            $valor_interpretacion = $valores_interpretacion[0]->txt_affirmative;
            //************** VALORES GRAFICO MAX Y MIN *****************/
            $data_chart = $gestion->valoresGraficoIndicador($indicadores[0]->name);
    
            return view('index', compact('factor', 'indicator', 'mes', 'mes_anterior_name', 'mes_actual', 'mes_anterior', 'variacion', 'valor', 'base_total', 'proporcionla_data', 'valor_interpretacion', 'data_chart'));
        
        }
       
        /*
        http://www.sidesoft.com.ec/app_indicadores/indicadorMY/liquidez%20corriente/enero/2019
        */
        // Funcionalidad => F1.

    }

    // Todos los indicadores en el año
    public function indicatorYear($indicator, $anio, $token)
    {
        $gestionBase =  new BaseController();
        $visitarpagina = $gestionBase->validateUserToken($token);
        $gestion =  new DataServiceRepository();
        $urlConsumida = $gestion->urlConsumido($token); // TAMBN EL ID de USUARIO
      
      
      if (empty($visitarpagina) || $urlConsumida[0]->consumido == 1) {
            return view('404');
        } else {
            $gestion =  new DataServiceRepository();
            //DATA
            $indicadores = $gestion->indicatorYear($indicator,  $anio);
            $factor = $indicadores[0]->description;
            $indicator = 'Indicador ' . $indicadores[0]->name . ' respecto al año ' . $indicadores[0]->year;     //$indicadores[0]->name;
            $mes = '';
            $año = $indicadores[0]->year; //2019
            $año_anterior = $indicadores[0]->year - 1; // 2018
    
    
            //DATA VALORES
            $valoresCurrent = $gestion->indicatorYearValuesCurrent($indicadores[0]->name, $indicadores[0]->year);
            $anio_actual_value = $valoresCurrent[0]->current_year;  // Sumatoria del valor del año actual
    
            $valoresLast = $gestion->indicatorYearValuesLast($indicadores[0]->name, $indicadores[0]->year);
            $anio_anterior_value = $valoresLast[0]->last_year;  // Sumatoria del valor del año actual
    
            $variacion = $anio_actual_value - $anio_anterior_value;
            $valor = $indicadores[0]->current_month;
    
            // CALCULO DEL PROPORSIONAL
            $base_total = $gestion->proporcionalTotalYear($indicadores[0]->name, $indicadores[0]->year); // SUMATORIA
            $proporcionla_data = $this->proporsionales_Year($indicadores[0]->name, $indicadores[0]->year); // [{"marzo":18.232706917233},{"agosto":100}]
    
        // *********************** INTERPRETACION *******************
            $valores_interpretacion = $gestion->interpretacionIndicador($indicadores[0]->name); // SUMATORIA
            $valor_interpretacion = $valores_interpretacion[0]->txt_affirmative;
        //************** VALORES GRAFICO MAX Y MIN *****************/
            $data_chart = $gestion->valoresGraficoIndicador($indicadores[0]->name);
    
            return view('index', compact('factor', 'indicator', 'mes', 'anio', 'año_anterior', 'anio_actual_value', 'anio_anterior_value', 'variacion', 'valor', 'proporcionla_data', 'base_total', 'valor_interpretacion', 'data_chart'));
        }
        /*
        http://www.sidesoft.com.ec/app_indicadores/indicadorT/endeudamiento%20del%20activo/septiembre/2018
     
        // Funcionalidad => F2.
*/
    }


    // PRPORCIONAL TOTAL AÑO     INDICADOR/YEAR
    public function proporsionales_Year($indicador, $anio)
    {
        $gestion =  new DataServiceRepository();
        // respecto al YEAR
        $valor_proporcional_total = $gestion->proporcionalTotalYear($indicador, $anio); // SUMATORIA
        $total_proporcional_data = $gestion->calcularProporcional($indicador, $anio); //DATA

        // respecto al MES mayor
        $valor_proporcional_total_m = $gestion->proporcionalTotalMonth($indicador, $anio); //MAX VALOR
        $total_proporcional_data_m = $gestion->calcularProporcional($indicador, $anio); //DATA

        $array_data = array();
        // the array


        for ($i = 0; $i < count($total_proporcional_data); $i++) {

            $arrX = array("aqua", "red", "green", "blue", "yellow", "orange", "brown");

            // get random index from array $arrX
            $randIndex = array_rand($arrX);

            // output the value for the random index


            $other = array(
                "mes" => $total_proporcional_data[$i]->month,
                "valor_año" => round(($total_proporcional_data[$i]->current_month * 100) / $valor_proporcional_total[0]->total_months, 2),
                "baseTotal_año" => $valor_proporcional_total[0]->total_months,
                "porcentaje_año" => (round(($total_proporcional_data[$i]->current_month * 100) / $valor_proporcional_total[0]->total_months, 2) * 100) / $valor_proporcional_total[0]->total_months,
                // MES MAYOR
                "mes_mes" => $total_proporcional_data_m[$i]->month,
                "valor_mes_unico" => $total_proporcional_data_m[$i]->current_month,

                "valor_mes" => round(($total_proporcional_data_m[$i]->current_month * 100) / $valor_proporcional_total_m[0]->maxCurrentMonth, 2),
                "baseTotal_mes" => $valor_proporcional_total_m[0]->maxCurrentMonth,
                "porcentaje_mes" => (round(($total_proporcional_data_m[$i]->current_month * 100) / $valor_proporcional_total_m[0]->maxCurrentMonth, 2) * 100) / $valor_proporcional_total_m[0]->maxCurrentMonth,
                "color_bar" => $arrX[$randIndex]

            );
            array_push($array_data, $other);
        }
        return $array_data;
    }



    public function push($token)
    {
        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => "https://fcm.googleapis.com/fcm/send?=",
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "POST",
            CURLOPT_POSTFIELDS => "{\n  \"notification\":{\n    
                                        \"title\":\"Ionic 4 Notification\",\n    
                                        \"body\":\"Notificacion enviada por Alexa indicadores\",\n    
                                        \"sound\":\"default\",\n    
                                        \"click_action\":\"FCM_PLUGIN_ACTIVITY\",\n    
                                        \"icon\":\"fcm_push_icon\"\n  
                                    },\n  
                                    \"data\":{\n    
                                        \"indicador\":\"liquidez corriente\",\n    
                                        \"mes\":\"enero\"\n  
                                    },\n    
                                    \"to\":\"" . $token . "\",\n    
                                    \"priority\":\"high\",\n    
                                    \"restricted_package_name\":\"\"\n}",
            CURLOPT_HTTPHEADER => array(
                "Authorization: key=AIzaSyD3LPdIRzp0LD2CPKhstrGwAasI6x2GcQQ",
                "Content-Type: application/json",
                "Postman-Token: ca5e9f46-ebe0-4062-ae08-cf165aa2a71f",
                "cache-control: no-cache"
            ),
        ));

        $response = curl_exec($curl);
        $err = curl_error($curl);

        curl_close($curl);

        if ($err) {
            echo "cURL Error #:" . $err;
        } else {
            echo $response;
        }
    }

    // *** Funcionalidades ***

    // F1. ) Cuando en la url se ingresa tres parametros indicador/mes/año => valor del CHART = VALOR DEL MES

    // F2. ) Cuando en la url se ingresa dos parametros indicadir/año => valor del CHART = SUMATORIA DE TODOS LOS MESES / # 

    public function defaultT($id=1, $date=null){
        return 1;
    }
      public function indicatorMonthYearV1($indicador, $mes, $anio)
    {
        $gestion =  new DataServiceRepository();
        //DATA
        $indicadores = $gestion->indicatorMonthYear($indicador, $mes, $anio);
        $factor = $indicadores[0]->description;
        $indicator = $indicadores[0]->name;
        $mes = $indicadores[0]->month; // actual    
        $mes_anterior_name = $gestion->mes_anterior_name($mes);

        // DATA VALORES
        $mes_actual = $indicadores[0]->current_month;
        $mes_anterior = $indicadores[0]->last_month; // funcion determina el mes
        $variacion = $indicadores[0]->current_month - $indicadores[0]->last_month;

        // CALCULO 
        $valor = $indicadores[0]->current_month;

        // CALCULO DEL PROPORSIONAL
        $base_total = $gestion->proporcionalTotalMonth($indicadores[0]->name, $indicadores[0]->year); // SUMATORIA
        $proporcionla_data = $this->proporsionales_Year($indicadores[0]->name, $indicadores[0]->year); // [{"marzo":18.232706917233},{"agosto":100}]
        // *********************** INTERPRETACION *******************
        $valores_interpretacion = $gestion->interpretacionIndicador($indicadores[0]->name); // SUMATORIA
        $valor_interpretacion = $valores_interpretacion[0]->txt_affirmative;
        //************** VALORES GRAFICO MAX Y MIN *****************/
        $data_chart = $gestion->valoresGraficoIndicador($indicadores[0]->name);

        return view('index', compact('factor', 'indicator', 'mes', 'mes_anterior_name', 'mes_actual', 'mes_anterior', 'variacion', 'valor', 'base_total', 'proporcionla_data', 'valor_interpretacion', 'data_chart'));
    

      /*  $gestion =  new DataServiceRepository();
        
        //DATA
        $indicadores = $gestion->indicatorMonthYear($indicador, $mes, $anio);
        $factor = $indicadores[0]->description;
        $indicator = $indicadores[0]->name;
        $mes = $indicadores[0]->month; // actual    
        $mes_anterior_name = $gestion->mes_anterior_name($mes);
       
        // DATA VALORES
        $mes_actual = $indicadores[0]->current_month;
        $mes_anterior = $indicadores[0]->last_month; // funcion determina el mes
        $variacion = $indicadores[0]->current_month - $indicadores[0]->last_month;

        // CALCULO 
        $valor = $indicadores[0]->current_month;
      
        return view('index', compact('factor', 'indicator', 'mes','mes_anterior_name', 'mes_actual', 'mes_anterior', 'variacion', 'valor'));
       */ /*
        http://www.sidesoft.com.ec/app_indicadores/indicadorMY/liquidez%20corriente/enero/2019
        */
        // Funcionalidad => F1.

    }

    // Todos los indicadores en el año
    public function indicatorYearV1($indicator, $anio)
    {

        $gestion =  new DataServiceRepository();
            //DATA
            $indicadores = $gestion->indicatorYear($indicator,  $anio);
            $factor = $indicadores[0]->description;
            $indicator = 'Indicador ' . $indicadores[0]->name . ' respecto al año ' . $indicadores[0]->year;     //$indicadores[0]->name;
            $mes = '';
            $año = $indicadores[0]->year; //2019
            $año_anterior = $indicadores[0]->year - 1; // 2018
    
    
            //DATA VALORES
            $valoresCurrent = $gestion->indicatorYearValuesCurrent($indicadores[0]->name, $indicadores[0]->year);
            $anio_actual_value = $valoresCurrent[0]->current_year;  // Sumatoria del valor del año actual
    
            $valoresLast = $gestion->indicatorYearValuesLast($indicadores[0]->name, $indicadores[0]->year);
            $anio_anterior_value = $valoresLast[0]->last_year;  // Sumatoria del valor del año actual
    
            $variacion = $anio_actual_value - $anio_anterior_value;
            $valor = $indicadores[0]->current_month;
    
            // CALCULO DEL PROPORSIONAL
            $base_total = $gestion->proporcionalTotalYear($indicadores[0]->name, $indicadores[0]->year); // SUMATORIA
            $proporcionla_data = $this->proporsionales_Year($indicadores[0]->name, $indicadores[0]->year); // [{"marzo":18.232706917233},{"agosto":100}]
    
        // *********************** INTERPRETACION *******************
            $valores_interpretacion = $gestion->interpretacionIndicador($indicadores[0]->name); // SUMATORIA
            $valor_interpretacion = $valores_interpretacion[0]->txt_affirmative;
        //************** VALORES GRAFICO MAX Y MIN *****************/
            $data_chart = $gestion->valoresGraficoIndicador($indicadores[0]->name);
    
            return view('index', compact('factor', 'indicator', 'mes', 'anio', 'año_anterior', 'anio_actual_value', 'anio_anterior_value', 'variacion', 'valor', 'proporcionla_data', 'base_total', 'valor_interpretacion', 'data_chart'));
          /*
        http://www.sidesoft.com.ec/app_indicadores/indicadorT/endeudamiento%20del%20activo/septiembre/2018
     
        // Funcionalidad => F2.
*/
    }
}


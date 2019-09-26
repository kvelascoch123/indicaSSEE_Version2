<?php

namespace App\Http\Controllers;


use Illuminate\Support\Facades\DB;

class Indicador extends Controller
{

    // ****************SEGUNDA ETAPA***************************************** //

    // Indicador por mes    //3 parametros  $indicator, $mes, $a���o

    // IndicadorMesAño 
    public function indicatorMonthYear($indicador, $mes, $anio)
    {
        $indicadores = DB::select('SELECT * FROM `al_indicators_years` WHERE name ="' . $indicador . '" and  month = "' . $mes . '" and year =  ' . $anio . '');
        //DATA
        $factor = $indicadores[0]->description;
        $indicator = $indicadores[0]->name;
        $mes = $indicadores[0]->month;
        $mes_actual = $indicadores[0]->current_month;
        $mes_anterior = $indicadores[0]->last_month;
        $variacion = $indicadores[0]->variation_between_months;

        return view('index', compact('factor', 'indicator', 'mes', 'mes_actual', 'mes_anterior', 'variacion'));
        /*
        http://www.sidesoft.com.ec/app_indicadores/indicadorT/endeudamiento%20del%20activo/septiembre/2018
        */ 
    }



}

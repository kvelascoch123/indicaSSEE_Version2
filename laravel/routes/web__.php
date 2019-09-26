<?php
Route::get('/', function () {
    return view('welcome');
});


// -------- SEGUNDA ETAPA ---------------
// Con Plantilla
// ***************************************************** //
Route::get('indicadorT/{nombre}/{mes}/{anio}','Indicador@indicatorMonthYear'); //http://www.sidesoft.com.ec/app_indicadores/indicadorT/liquidez%20corriente/enero/2019




//--------- PRIMERA ETAPA -----------------------
// TODOS   factor
/*
Route::get('factor/{nombre}','Indicador@todos_por_tipo');
Route::get('factor_mes/{nombre}/{mes}','Indicador@todos_por_tipo_mes');// TODOS factor-params
Route::get('factor_anio/{nombre}/{anio}','Indicador@todos_por_tipo_año');// TODOS factor-params
// Unico   indicador
Route::get('indicador/{nombre}','Indicador@un_indicador');
Route::get('indicador_mes/{nombre}/{mes}','Indicador@un_por_tipo_mes');// TODOS factor-params
Route::get('indicador_anio/{nombre}/{anio}','Indicador@un_por_tipo_año');// TODOS factor-params
*/




/*
//**** TEST DE PRUEBA ****
// envio de parametros
Route::get('chart_params/{nombre}/{valor}', function($nombre, $valor){
    return $nombre. $valor; });
// get data
Route::get('char_data','Indicador@chart_data');
*/
<?php
Route::get('/', function () {
    return view('welcome');
});


// -------- SEGUNDA ETAPA ---------------
// Con Plantilla
// ***************************************************** //
Route::get('indicadorMY/{nombre}/{mes}/{anio}/{token}','Indicador@indicatorMonthYear'); //http://www.sidesoft.com.ec/app_indicadores/indicadorT/liquidez%20corriente/enero/2019
Route::get('indicadorY/{nombre}/{anio}/{token}','Indicador@indicatorYear'); //http://www.sidesoft.com.ec/app_indicadores/indicadorT/liquidez%20corriente/enero/2019


Route::get('push/{token}','Indicador@push'); //http://www.sidesoft.com.ec/app_indicadores/indicadorT/liquidez%20corriente/enero/2019

Route::get('indicadorMYv1/{nombre}/{mes}/{anio}','Indicador@indicatorMonthYearV1'); //http://www.sidesoft.com.ec/app_indicadores/indicadorT/liquidez%20corriente/enero/2019
Route::get('indicadorYv1/{nombre}/{anio}','Indicador@indicatorYearV1'); //http://www.sidesoft.com.ec/app_indicadores/indicadorT/liquidez%20corriente/enero/2019


//--------- PRIMERA ETAPA -----------------------
// TODOS   factor
/*
Route::get('factor/{nombre}','Indicador@todos_por_tipo');
Route::get('factor_mes/{nombre}/{mes}','Indicador@todos_por_tipo_mes');// TODOS factor-params
Route::get('factor_anio/{nombre}/{anio}','Indicador@todos_por_tipo_a
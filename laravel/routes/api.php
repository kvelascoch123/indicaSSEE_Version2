<?php

use Illuminate\Http\Request;
use App\TokenModel;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::prefix('alexa')->group(function () {
    //***** USER 
    //login
    Route::get('user/{nombre}/{contrasena}','API\APIController@getUser'); 
    //usuario name
    Route::get('user/{nombre}','API\APIController@getUser_validate'); 

    // ***** INDICADORES
    // area
    Route::get('areas','API\APIController@getArea'); 
    Route::get('area/{description}','API\APIController@getAreaDescription'); 
    Route::get('indicadores/{nombreFactor}','API\APIController@getIndicatorByFactor');

    //***** MONTHLY
    Route::get('monthly/{anio}/{nombre}','API\APIController@getMonthly'); 
    Route::get('monthly/{mes}/{anio}/{nombre}','API\APIController@getMonthlyMonth'); 
    
    // *** TABLA TOKEN TEST PRUEBA GET DATA

   Route::get('tokenInsert/{indicador}/{mes}/{anio}/{tokenEncrpt}','API\APIController@insertToken');
   Route::get('validateTokenUser/{token}/{idUser}','API\BaseController@validateUserToken');

  // *** SS_CONFIGURACION ***
    Route::get('configuration/{id_org}','API\APIController@configurationData'); 


    //**** COMPARATION
    Route::get('comparationGetAll','API\APIController@comparationGetAll'); 

    Route::get('comparation/{nombre}','API\APIController@comparation'); 
   
   
    
});

/* 
// ******************* URL WEB ****************************
INDICADOR MES AÑO => 4 params (indicador , mes , año, TOKEN)

http://www.sidesoft.com.ec/app_indicadores/indicadorMY/liquidez%20corriente/enero/2019/fTUsnJgJgOBx+UcV9um73t2ImqqOLctq4HT7Eh+0Z0Q0rhTHzlmxdsjXMGNj8PNV574UFBfZ0Z5woBTWA8G6ulvDmC9OhwmxvhvOQuUUxCmA9RYOCeiRScnpKB4agATj

INDICADOR AÑO => 3 params (indicador , año, TOKEN)
http://www.sidesoft.com.ec/app_indicadores/indicadorY/liquidez%20corriente/2019/fTUsnJgJgOBx+UcV9um73t2ImqqOLctq4HT7Eh+0Z0Q0rhTHzlmxdsjXMGNj8PNV574UFBfZ0Z5woBTWA8G6ulvDmC9OhwmxvhvOQuUUxCmA9RYOCeiRScnpKB4agATj


// ****************** URL API  *****************************

Login => 2 parmas (nombreUser, contraseña)
http://www.sidesoft.com.ec/app_indicadores/api/alexa/user/kevin/abcd

UserGet => 1 param (nombreUser)
http://www.sidesoft.com.ec/app_indicadores/api/alexa/user/kevin

** INDICADORES Respuestas de Alexa

AreasGet => 0 params
http://www.sidesoft.com.ec/app_indicadores/api/alexa/areas

AreaGet => 1 param (nombreArea)
http://www.sidesoft.com.ec/app_indicadores/api/alexa/area/area%20financiera

IndicadoresGet => 1 param (nombreFactor)
http://www.sidesoft.com.ec/app_indicadores/api/alexa/indicadores/Liquidez

** Monthly Respuestas Alexa

MonthlyByYear => 2 params (anio, indicador)
http://www.sidesoft.com.ec/app_indicadores/api/alexa/monthly/2019/liquidez%20corriente

MonthlyByMonth => 3 params(mes, anio, indicador)
http://www.sidesoft.com.ec/app_indicadores/api/alexa/monthly/enero/2019/liquidez%20corriente


// **** TOKEN *******

InsertDataToken => 4 params(indicador, mes, anio, tokenEncrypt)
http://www.sidesoft.com.ec/app_indicadores/api/alexa/tokenInsert/liquidez%20corriente/enero/2019/fTUsnJgJgOBx+UcV9um73t2ImqqOLctq4HT7Eh+0Z0Q0rhTHzlmxdsjXMGNj8PNV574UFBfZ0Z5woBTWA8G6ulvDmC9OhwmxvhvOQuUUxCmA9RYOCeiRScnpKB4agATj

ValidarTokenDB
http://www.sidesoft.com.ec/app_indicadores/api/alexa/validateTokenUser/fTUsnJgJgOBx+UcV9um73t2ImqqOLctq4HT7Eh+0Z0Q0rhTHzlmxdsjXMGNj8PNV574UFBfZ0Z5woBTWA8G6ulvDmC9OhwmxvhvOQuUUxCmA9RYOCeiRScnpKB4agATj/1




*/


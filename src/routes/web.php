<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

// Route::get('/', function () {
//     return view('welcome');
// });

Route::get('/', function () {
    return view('createUser', ['message' => '']);
});
Route::post('/create/user', 'AvaController@createUser');

Route::get('/create/address', function () {
    return view('createAddress', ['message' => '']);
});
Route::post('/create/address', 'AvaController@createAddress');

Route::get('/balance', function () {
    return view('balance', ['message' => '']);
});
Route::post('/balance', 'AvaController@getBalance');

Route::get('/send', function () {
    return view('send', ['message' => '']);
});
Route::post('/send', 'AvaController@send');

Route::get('/create/asset', function () {
    return view('createAsset', ['message' => '']);
});
Route::post('/create/asset', 'AvaController@createAsset');

Route::get('/asset/balance', function () {
    return view('assetBalance', ['message' => '']);
});
Route::post('/asset/balance', 'AvaController@getAssetBalance');

Route::get('/asset/send', function () {
    return view('sendAsset', ['message' => '']);
});
Route::post('/asset/send', 'AvaController@sendAsset');
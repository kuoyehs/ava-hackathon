<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use GuzzleHttp\Client;

class AvaController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        
    }

    public function createUser(Request $request)
    {
        $client = new Client();
        $result = $client->post(env('GECKO_HOST').'/ext/keystore', [
            
            'json' => [
                "jsonrpc" => "2.0",
                "id"     => 1,
                "method" => "keystore.createUser",
                "params" => [
                    "username" => $request->input('username'),
                    "password" => $request->input('password'),
                ]
            ]
        ]);

        $result = json_decode($result->getBody());        
        
        $res = isset($result->result) ? 'Success!' : $result->error->message;
        return view('createUser', [
            'message' => $res
        ]);
    }

    public function createAddress(Request $request)
    {
        $client = new Client();
        $result = $client->post(env('GECKO_HOST').'/ext/bc/X', [
            
            'json' => [
                "jsonrpc" => "2.0",
                "id"     => 2,
                "method" => "avm.createAddress",
                "params" => [
                    "username" => $request->input('username'),
                    "password" => $request->input('password'),
                ]
            ]
        ]);

        $result = json_decode($result->getBody());        
        
        $res = isset($result->result) ? 'Address: '.$result->result->address : $result->error->message;
        return view('createAddress', [
            'message' => $res
        ]);
    }

    public function getBalance(Request $request)
    {
        $client = new Client();
        $result = $client->post(env('GECKO_HOST').'/ext/bc/X', [
            
            'json' => [
                "jsonrpc" => "2.0",
                "id"     => 2,
                "method" => "avm.getBalance",
                "params" => [
                    "address" => $request->input('address'),
                    "assetID" => "AVA"
                ]
            ]
        ]);

        $result = json_decode($result->getBody());        
        
        $res = isset($result->result) ? 'Balance: '.$result->result->balance.' nAVA' : $result->error->message;
        return view('balance', [
            'message' => $res
        ]);
    }

    public function send(Request $request)
    {
        $client = new Client();
        $result = $client->post(env('GECKO_HOST').'/ext/bc/X', [
            
            'json' => [
                "jsonrpc" => "2.0",
                "id"     => 3,
                "method" =>"avm.send",
                "params" =>[
                    "username" => $request->input('username'),
                    "password" => $request->input('password'),
                    "assetID" => "AVA",
                    "amount"  => $request->input('amount'),
                    "to"      => $request->input('address')
                ]
            ]
        ]);

        $result = json_decode($result->getBody());        
        
        $res = isset($result->result) ? 'Success!' : $result->error->message;
        return view('send', [
            'message' => $res
        ]);
    }

    /**
     * Show the application dashboard.
     *
     * @return Response
     */
    public function createAsset(Request $request)
    {
        $client = new Client();
        // $result = $client->post('api-uri', [
        //     'form_params' => [
        //         'data-name' => 'value'
        //     ]
        // ]);
        $result = $client->post(env('GECKO_HOST').'/ext/bc/X', [
            
            'json' => [
                "jsonrpc" => "2.0",
                "id"     => 1,
                "method" =>"avm.createFixedCapAsset",
                "params" => [
                    "name"=> "VisualNext",
                    "symbol"=>"VN",
                    "initialHolders"=> [
                        [
                            "address"=> $request->input('address'),
                            "amount"=> $request->input('amount')
                        ]
                    ],
                    "username"=>"yourUsername",
                    "password"=>"yourPassword"
                ]
            ]
        ]);

        $result = json_decode($result->getBody());        
        
        $res = isset($result->result) ? 'Success! assetID: ' . $result->result->assetID: $result->error->message;
        return view('createAsset', [
            'message' => $res
        ]);
    }

    public function getAssetBalance(Request $request)
    {
        $client = new Client();
        $result = $client->post(env('GECKO_HOST').'/ext/bc/X', [
            
            'json' => [
                "jsonrpc" => "2.0",
                "id"     => 2,
                "method" => "avm.getBalance",
                "params" => [
                    "address" => $request->input('address'),
                    "assetID" => $request->input('assetID')
                ]
            ]
        ]);

        $result = json_decode($result->getBody());        
        
        $res = isset($result->result) ? 'Balance: ' . $result->result->balance . ' VN': $result->error->message;
        return view('assetBalance', [
            'message' => $res
        ]);
    }

    public function sendAsset(Request $request)
    {
        $client = new Client();
        $result = $client->post(env('GECKO_HOST').'/ext/bc/X', [
            
            'json' => [
                "jsonrpc"=>"2.0",
                "id"     =>3,
                "method" =>"avm.send",
                "params" =>[
                    "username" => $request->input('username'),
                    "password" => $request->input('password'),
                    "assetID" => $request->input('assetID'),
                    "amount"  => $request->input('amount'),
                    "to"      => $request->input('address')
                ]
            ]
        ]);

        $result = json_decode($result->getBody());        
        
        $res = isset($result->result) ? 'Success!' : $result->error->message;
        return view('sendAsset', [
            'message' => $res
        ]);
    }
}

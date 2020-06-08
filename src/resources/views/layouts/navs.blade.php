<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VisualNext</title>
    <style>
        html, body {
            background-color: #fff;
            color: #636b6f;
            font-family: 'Nunito', sans-serif;
            font-weight: 200;
            height: 100vh;
            margin: 0;
        }

        .content {
            text-align: center;
        }

        .title {
            font-size: 48px;
        }

        .links {
            margin: 20px;
        }

        .links > a {
            color: #636b6f;
            padding: 0 25px;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: .1rem;
            text-decoration: none;
        }

        form > label {
            width: 30%;  
        }

        form > input {
            width: 50%;
            height: 30px;
            margin: 10px 0;
        }

        form > input[type="submit"] {
            width: 150px;
            height: 40px;
            padding:5px 15px; 
            cursor:pointer;
            -webkit-border-radius: 5px;
            border-radius: 5px;
            margin: 10px 0;
        }

        .note {
            margin: 15px auto;
            width: 50%;
            text-align: left;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="links">
        <a href="{{ url('/') }}">Create User</a>
        <a href="{{ url('/create/address') }}">Create Address</a>
        <a href="https://192.168.0.19:8080" target="_blank">AVA Faucet</a>
        <a href="{{ url('/balance') }}">Balance AVA</a>
        <a href="{{ url('/send') }}">Send AVA</a>
        <a href="{{ url('/create/asset') }}">Create Asset</a>
        <a href="{{ url('/asset/balance') }}">Balance Asset</a>
        <a href="{{ url('/asset/send') }}">Send Asset</a>
        
        {{-- <a href="https://forge.laravel.com">Forge</a>
        <a href="https://github.com/laravel/laravel">GitHub</a> --}}
    </div>
    <div class="title">
        @yield('title')
    </div>
    @yield('content')
    <div class="note">
        This app allows you to generate the address of the AVA network, and you can use this address to get the AVA token from the AVA faucet. This address can also create your own assets, and you can also send your own assets to others.<br><br>
        1. Create User：Create a new user with username and password<br>
        2. Create Address：Create an address that using username and password<br>
        3. AVA Faucet：Obtain test AVA<br>
        4. Balance AVA：Inquire how many AVA<br>
        5. Send AVA：Give AVA to others<br>
        6. Create Asset：Create your own assets<br>
        7. Balance Asset：Check your own assets<br>
        8. Send Asset：Give your own assets to others<br>
    </div>
</div>
</body>
</html>
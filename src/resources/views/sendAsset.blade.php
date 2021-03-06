@extends('layouts.navs')
@section('title')
Send Asset
@endsection
@section('content')
<form method="POST" action="/asset/send">
    @csrf
    <label for="username">Username</label>
    <input id="username" type="text" name="username"><br>
    <label for="password">Password</label>
    <input id="password" type="password" name="password"><br>
    <label for="assetID">assetID</label>
    <input id="assetID" type="text" name="assetID"><br>
    <label for="amount">Amount</label>
    <input id="amount" type="text" name="amount"><br>
    <label for="address">To Address</label>
    <input id="address" type="text" name="address"><br>
    <div class="alert alert-danger">{{ $message }}</div><br>
    <input id="submit" type="submit" name="" value="Send">
</form>
@endsection
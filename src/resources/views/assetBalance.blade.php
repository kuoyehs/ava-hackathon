@extends('layouts.navs')
@section('title')
Balance Asset
@endsection
@section('content')
<form method="POST" action="/asset/balance">
    @csrf
    <label for="address">address</label>
    <input id="address" type="text" name="address"><br>
    <label for="assetID">assetID</label>
    <input id="assetID" type="text" name="assetID"><br>
    <div class="alert alert-danger">{{ $message }}</div><br>
    <input id="submit" type="submit" name="" value="Balance">
</form>
@endsection
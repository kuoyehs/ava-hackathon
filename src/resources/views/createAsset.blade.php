@extends('layouts.navs')
@section('title')
Create Asset
@endsection
@section('content')
<form method="POST" action="/create/asset">
    @csrf
    <label for="address">address</label>
    <input id="address" type="text" name="address"><br>
    <label for="amount">amount</label>
    <input id="amount" type="text" name="amount"><br>
    <div class="alert alert-danger">{{ $message }}</div><br>
    <input id="submit" type="submit" name="" value="Create Asset">
</form>
@endsection
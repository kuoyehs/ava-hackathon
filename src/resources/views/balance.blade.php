@extends('layouts.navs')
@section('title')
Balance AVA
@endsection
@section('content')
<form method="POST" action="/balance">
    @csrf
    <label for="address">address</label>
    <input id="address" type="text" name="address"><br>
    <div class="alert alert-danger">{{ $message }}</div><br>
    <input id="submit" type="submit" name="" value="Balance">
</form>
@endsection
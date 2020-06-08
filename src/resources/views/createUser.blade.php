@extends('layouts.navs')
@section('title')
Create User
@endsection
@section('content')
<form method="POST" action="/create/user">
    @csrf
    <label for="username">Username</label>
    <input id="username" type="text" name="username"><br>
    <label for="password">Password</label>
    <input id="password" type="password" name="password"><br>
    <div class="alert alert-danger">{{ $message }}</div><br>
    <input id="submit" type="submit" name="" value="Create User">
</form>
@endsection

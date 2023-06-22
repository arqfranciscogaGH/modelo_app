//  librerias internas de flutter

import 'dart:io';

import 'package:flutter/material.dart';

//  librerias importadas flutter

import 'package:http/http.dart' as http;

//  librerias  proyecto

class ServicioRest {
  static String token = "";
  static Map<String, String> _headers = {
    "Accept": "application/json",
    "content-type": "application/json",
    "authorization": "Bearer  $token"
    //  "authorization": "basic  $token"
  };
  //  Map<String, String> header =  Map();
  // header["token"]= "" ;
  static Future<dynamic> get(Uri uri) async {
    dynamic respuesta = await http.get(uri, headers: _headers);
    return respuesta;
  }

  static Future<dynamic> post(Uri uri, String cuerpo) async {
    var respuesta = await http.post(uri, body: cuerpo, headers: _headers);
    return respuesta;
  }

  static Future<dynamic> put(Uri uri, String cuerpo) async {
    var respuesta = await http.put(uri, body: cuerpo, headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
    return respuesta;
  }

  static Future<dynamic> delete(Uri uri, String cuerpo) async {
    var respuesta = await http.delete(uri, headers: _headers);
    return respuesta;
  }

  static Future<dynamic> read(Uri uri, String cuerpo) async {
    var respuesta = await http.read(uri, headers: _headers);
    return respuesta;
  }
}

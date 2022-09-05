import 'package:flutter/material.dart';


final authFieldsDecoration=InputDecoration(
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIconColor: Colors.white,
                  suffixIconColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white, width: 2)
                  ),
              );


final searchFieldDecoration=InputDecoration(
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIconColor: Colors.white,
                  hintText: 'Look for other users',
                  suffixIconColor: Colors.white,
                  focusColor: Colors.white,
                  prefixIcon: Icon(Icons.search,color: Colors.white,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white, width: 2)
                  ),
              );





const primaryColor=Colors.teal;
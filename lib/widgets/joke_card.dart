import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JokeTypeCard extends StatelessWidget{
  final String type;
  const JokeTypeCard({super.key,required this.type});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        enableFeedback: true,
        splashColor: Colors.black45,
        onTap: ()=>{
          Navigator.pushNamed(context, '/jokes',arguments:type)
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
             border: Border.all(color: Colors.lime,width: 3),
             borderRadius: BorderRadius.circular(40),
             color: Colors.green[300]
          ),
          child:
                Center(child: Text(type,style: const TextStyle(fontSize: 20,fontStyle: FontStyle.italic,color: Colors.white,fontWeight: FontWeight.bold))),
          ),
      )
    );
  }

}
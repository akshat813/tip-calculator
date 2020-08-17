import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage=0;
  int _personCounter=1;
  double _billAmount=0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.shade100,
                borderRadius: BorderRadius.circular(30)
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Total  per person",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),)
                    ,Text("\$${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),)
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blueGrey,
                  style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                      prefixText: "Bill Amount : "
                    ),
                    onChanged: (String value)
                    {
                      try
                      {
                        _billAmount=double.parse(value);
                      }
                      catch(exception){
                        _billAmount=0.0;
                    }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Split",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                      Row(
                   children: <Widget>[
                     InkWell(
                       onTap: ()
                       {
                         setState(() {
                           if(_personCounter>1){
                           _personCounter--;}
                         });

                       },
                       child: Container(
                         width: 40,
                         height: 40,
                         padding: EdgeInsets.all(10),
                         margin: EdgeInsets.only(top: 7),
                         decoration: BoxDecoration(
                           color: Colors.lightBlueAccent.withOpacity(0.1),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         child: Center(
                           child: Text(
                             "-",style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 20,
                               color: Colors.black
                           ),
                           ),
                         ),
                       ),
                     ),
                     Text(" $_personCounter ",style: TextStyle(
                       fontSize:20
                       ,fontWeight: FontWeight.bold
                     ) ,),
                     InkWell(
                       onTap: ()
                       {
                         setState(() {
                           _personCounter++;
                         });

                       },
                       child: Container(
                         width: 40,
                         height: 40,
                         padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 7),
                         decoration: BoxDecoration(
                           color: Colors.lightBlueAccent.withOpacity(0.1),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         child: Center(
                           child: Text(
                             "+",style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 20,
                             color: Colors.black
                           ),
                           ),
                         ),
                       ),
                     ),

                   ],
                      )
                    ],
                  ),
                  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Tip",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),

                        child: Text(
                          "\$${(calculateTotalTip(_billAmount,_personCounter,_tipPercentage))}",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                      )
                    ],
                  ),

                Column(
                  children: <Widget>[
                    Text("$_tipPercentage%",style: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold
                    ),),
                    Slider(
                        min: 0,
                        max: 100,
                        activeColor: Colors.blueAccent,
                        inactiveColor: Colors.grey,
                        divisions: 10,
                        value: _tipPercentage.toDouble(),
                        onChanged: (double newValue)
                    {
                      setState(() {
                        _tipPercentage=newValue.round();
                      });
                    })
                  ],
                )],
              ),
            )

          ],
        ),
      ),

    );
  }
  calculateTotalPerPerson( double billAmount, int splitBy,int tipPercentage)
  {
    var totalPerPerson=(calculateTotalTip( billAmount,splitBy,tipPercentage)+billAmount)/splitBy;
    return totalPerPerson;
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage)
  {
    double totalTip=0.0;
    if(billAmount<0 || billAmount.toString().isEmpty || billAmount==null)
      {
        //empty
      }
    else{
      totalTip=(billAmount*tipPercentage)/100;
    }
    return totalTip;
  }
}

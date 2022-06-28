import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thoughts_creator/utils/AppColors.dart';
import 'package:thoughts_creator/utils/screen_util.dart';



// ignore: must_be_immutable
class WidgetFontFamilyContainer extends StatelessWidget {
    List<TextStyle> fontFamilyList =  <TextStyle>[

    GoogleFonts.abel(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.aBeeZee(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.abhayaLibre(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.aguafinaScript(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.alike(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.aclonica(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.alef(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.adamina(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.abel(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.barlow(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.bahianita(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.badScript(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.bitter(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.b612(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.chivo(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.cabin(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.cabinSketch(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.cherrySwash(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.chelseaMarket(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.dokdo(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.hind(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.elMessiri(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.elsie(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.oswald(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.lato(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.dancingScript(textStyle: TextStyle(color: Colors.white, fontSize: FontSize.s16)),
    GoogleFonts.lobster(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.newRocker(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16 )),
    GoogleFonts.b612(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.b612Mono(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.bahianita(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.baloo(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.barlow(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.balooBhai(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.varela(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.scada(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.cherrySwash(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.chivo(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.daysOne(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.dynalight(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.eagleLake(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.eastSeaDokdo(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.exo(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.firaSans(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.gabriela(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.iceland(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.jura(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.kranky(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.k2d(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.laila(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.lemon(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.monda(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.neucha(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.overlockSc(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.peddana(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.qwigley(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.sahitya(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.roboto(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.zillaSlab(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.rajdhani(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.raleway(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.lacquer(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.firaSans(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.fahkwang(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.farro(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.firaMono(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.playfairDisplay(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.farsan(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.gamjaFlower(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.gayathri(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.glassAntiqua(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.gaegu(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.geo(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.blackHanSans(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.halant(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.inter(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.itim(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.imFellDoublePica(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.imFellDwPicaSc(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.mali(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.manjari(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.monoton(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.mallanna(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.niconne(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.notoSans(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.novaOval(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.oregano(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.fugazOne(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.offside(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.pattaya(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.pangolin(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.peralta(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.rosarivo(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.shanti(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.sourceSansPro(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.ultra(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.caudex(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.coda(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),
    GoogleFonts.codaCaption(textStyle: TextStyle(color: Colors.white,fontSize: FontSize.s16)),



];

  WidgetFontFamilyContainer({this.onPressed,this.onTextStyleChange});

  final GestureTapCallback onPressed;

  final Function(TextStyle) onTextStyleChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
          height: MediaQuery.of(context).size.height/12.0,
          width: MediaQuery.of(context).size.width,
       /* child: GridView.builder(
            shrinkWrap: true,
            itemCount: fontFamilyList.length,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,childAspectRatio: 2.0),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: InkWell(
                  onTap: (){
                    onTextStyleChange(fontFamilyList[index]);
                  },
                  child: Container(

                    child: Padding(
                      padding: const EdgeInsets.all(1.5),
                      child: Container(

                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.white,width: Constant.size1),
                        ),
                        child: Center(
                          child: Text("ABC",
                            style:fontFamilyList[index],
                          ),
                        ),

                      ),
                    ),
                  ),
                ),
              );
            }),*/



          child: ListView.builder(
              itemCount: fontFamilyList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder:(context,index){
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: InkWell(
                    onTap: (){
                      onTextStyleChange(fontFamilyList[index]);
                    },
                    child: Container(

                      child: Padding(
                        padding: const EdgeInsets.all(1.5),
                        child: Center(
                          child: Container(
                            height:44.0,
                            width:50.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.white,width: Constant.size1),
                            ),
                            padding:EdgeInsets.all(4.0),
                            child: Center(
                              child: Text("ABC",
                                style:fontFamilyList[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              })
      ),
    );
  }

}

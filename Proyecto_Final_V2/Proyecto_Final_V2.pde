import controlP5.*;
import static javax.swing.JOptionPane.*;
PImage car, semaforo;

ControlP5 cp5;

Textlabel velocidad;
Textlabel fRozamiento;
Textlabel tReaccion;
Textlabel dReaccion;
Textlabel dFrenado;
Textlabel dDetencion;
Textlabel mtrSegVelocidad;
Textlabel sReaccion;
Textlabel mReaccion;
Textlabel mFrenado;
Textlabel mDetencion;
Textlabel labelSeco;
Textlabel labelMojado;

Textarea rReaccion;
Textarea rFrenado;
Textarea rDetencion;
Textarea rLabel;

float vReaccion;
float vFrenado;
float vDetencion;
float factorRozamiento;
float kxh;
float mxs;
float segundos;
float factorConversion = 0.277;
float g = 9.81;

color myBackground = #f7f7f7;
color main = #3BEA15;
color bar = #404a3b;
color dataFields = #a3af9e;
color bCalcular = #0099e5;
color bReset = #EB3A2D;

String dataVelocidad = "0";
String dataTReaccion = "0";

boolean validInput1 = false;
boolean validInput2 = false;
boolean valorNull = false;

void setup()
{
  size(1200, 600);
  smooth();
  car = loadImage("car.png");
  semaforo = loadImage("semaforo1.png");
  
  cp5 = new ControlP5(this);
  
  // Labels Left
  velocidad = cp5.addTextlabel("velocidad")
                    .setText("Velocidad")
                    .setPosition(150,300)
                    .setColorValue(bar)
                    .setFont(createFont("Georgia",24))
                    ;
  mtrSegVelocidad = cp5.addTextlabel("mtrSegVelocidad")
                    .setText("K/h")
                    .setPosition(430,300)
                    .setColorValue(bar)
                    .setFont(createFont("Georgia",24))
                    ;                  
  fRozamiento = cp5.addTextlabel("fRozamiento")
                      .setText("Factor de rozamiento")
                      .setPosition(25,370)
                      .setColorValue(bar)
                      .setFont(createFont("Georgia",24))
                    ;
  tReaccion = cp5.addTextlabel("tReaccion")
                      .setText("Tiempo de reacción")
                      .setPosition(42,440)
                      .setColorValue(bar)
                      .setFont(createFont("Georgia",24))
                    ;
  sReaccion = cp5.addTextlabel("sReaccion")
                    .setText("s")
                    .setPosition(430,440)
                    .setColorValue(bar)
                    .setFont(createFont("Georgia",24))
                    ;
                    
// Labels Right
  dReaccion = cp5.addTextlabel("dReaccion")
                      .setText("Distancia de reacción")
                      .setPosition(700,300)
                      .setColorValue(bar)
                      .setFont(createFont("Georgia",24))
                    ;
  mReaccion = cp5.addTextlabel("mReaccion")
                    .setText("m")
                    .setPosition(1100,300)
                    .setColorValue(bar)
                    .setFont(createFont("Georgia",24))
                    ;                  
  dFrenado = cp5.addTextlabel("dfrenado")
                      .setText("Distancia de frenado")
                      .setPosition(705,370)
                      .setColorValue(bar)
                      .setFont(createFont("Georgia",24))
                    ;
  mFrenado = cp5.addTextlabel("mFrenado")
                    .setText("m")
                    .setPosition(1100,370)
                    .setColorValue(bar)
                    .setFont(createFont("Georgia",24))
                    ;                  
  dDetencion = cp5.addTextlabel("dDetencion")
                      .setText("Distancia de detención")
                      .setPosition(685,440)
                      .setColorValue(bar)
                      .setFont(createFont("Georgia",24))
                    ;
  mDetencion = cp5.addTextlabel("mDetencion")
                    .setText("m")
                    .setPosition(1100,440)
                    .setColorValue(bar)
                    .setFont(createFont("Georgia",24))
                    ;                  

// Result Fields
  rReaccion = cp5.addTextarea("rReaccion")
                  .setPosition(970,290)
                  .setSize(120 ,50)
                  .setFont(createFont("Georgia",24))
                  .setLineHeight(14)
                  .setColor(bar)
                  .setColorBackground(dataFields)
                  ;
  rReaccion.setText("   " + vReaccion)
                    .getValueLabel().align(ControlP5.CENTER, ControlP5.CENTER)
                    ;
  rFrenado = cp5.addTextarea("rFrenado")
                  .setPosition(970,360)
                  .setSize(120,50)
                  .setFont(createFont("Georgia",24))
                  .setLineHeight(14)
                  .setColor(bar)
                  .setColorBackground(dataFields)
                  ; 
  rFrenado.setText("   " + vFrenado)
                  .getValueLabel().align(ControlP5.CENTER, ControlP5.CENTER) 
                   ;                 
  rDetencion = cp5.addTextarea("rDetencion")
                  .setPosition(970,430)
                  .setSize(120,50)
                  .setFont(createFont("Georgia",24))
                  .setLineHeight(14)
                  .setColor(bar)
                  .setColorBackground(dataFields)
                  ;
  rDetencion.setText("   " + vDetencion)
                  .getValueLabel().align(ControlP5.CENTER, ControlP5.CENTER)
                  ;

// Data Fields
  cp5.addTextfield("vVelocidad")
     .setCaptionLabel("")
     .setPosition(300,290)
     .setSize(120,50)
     .setFont(createFont("Georgia",24))
     .setColor(0)
     .setColorBackground(dataFields)
     .setColorActive(#FFFFFF)
     .setAutoClear(false)
     .getValueLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
  cp5.addBang("vVelocidadClear")
     .setCaptionLabel("CLEAR")
     .setPosition(490,290)
     .setSize(100,50)
     .setFont(createFont("Georgia",24))
     .setColorCaptionLabel(#FFFFFF)
     .setColorForeground(bCalcular)
     .setColorActive(#e60000)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
  cp5.addTextfield("vTReaccion")
     .setCaptionLabel("")
     .setPosition(300,430)
     .setSize(120,50)
     .setFont(createFont("Georgia",24))
     .setColor(0)
     .setColorBackground(dataFields)
     .setColorActive(#FFFFFF)
     .setAutoClear(false)
     .getValueLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
       
  cp5.addBang("vTReaccionClear")
     .setCaptionLabel("CLEAR")
     .setPosition(490,430)
     .setSize(100,50)
     .setFont(createFont("Georgia",24))
     .setColorCaptionLabel(#FFFFFF)
     .setColorForeground(bCalcular)
     .setColorActive(#e60000)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
     
// Toggle Switch
  cp5.addToggle("toggle")
     .setCaptionLabel("")
     .setPosition(300,360)
     .setSize(120,50)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setColorBackground(dataFields)
     .setColorActive(bCalcular)
     ;
     
// Push Buttons
  cp5.addButton("reset")
     .setValue(0)
     .setPosition(325,520)
     .setSize(150,50)
     .setColorBackground(#EB3A2D)
     .setColorActive(#ff4d4d)
     .setColorForeground(#e60000)
     .setFont(createFont("Georgia",24))
     ;
  cp5.addButton("calcular")
     .setValue(0)
     .setPosition(725,520)
     .setSize(150,50)
     .setColorBackground(bCalcular)
     .setFont(createFont("Georgia",24))
     ;
     
// Slider
  cp5.addSlider("slider")
     .setPosition(440,180)
     .setSize(490,30)
     .setRange(0,490)
     .setFont(createFont("Georgia",12))
     .setCaptionLabel("")
     .setColorBackground(bar)
     .setColorLabel(bCalcular)
     ;
  // reposition the Label for controller 'slider'
  cp5.getController("slider").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
}

void draw()
{
  background(myBackground);
  fill(main);
  strokeWeight(0);
  rect(0, 250, 1200, 400);
  image(car, -10, 100, 450, 150);
  image(semaforo, 950, 35, 200, 200);
  textSize(28);
  fill(#070A06);

  dataVelocidad = cp5.get(Textfield.class,"vVelocidad").getText();
  dataTReaccion = cp5.get(Textfield.class,"vTReaccion").getText();
  
}

public void vTReaccionClear() {
  cp5.get(Textfield.class,"vTReaccion").clear();
}

public void vVelocidadClear() {
  cp5.get(Textfield.class,"vVelocidad").clear();
}

void toggle(boolean theFlag) {
  if(theFlag==true) {
    rLabel = cp5.addTextarea("rLabel")
                  .setPosition(490,370)
                  .setSize(100 ,30)
                  .setFont(createFont("Georgia",19.4))
                  .setLineHeight(5)
                  .setColor(bar)
                  .setColorBackground(dataFields)
                  .setColorForeground(#077dfa)
                  .setText("SECO")
                  ;
  factorRozamiento = 0.8;
  } else {
    rLabel.setText("MOJADO")
                    ;
    factorRozamiento = 0.25;                
  }
}

boolean checkNull(String strNumber) {
   if (strNumber != null && strNumber.length() > 0) {
       return false;
   } else 
       return true;
}

float convertToMs(float kxh) {
  float mxs = kxh * factorConversion;
  return mxs;
}

void calcularValores(float fRozamiento) {
  valorNull = false;
  if ((checkNull(dataVelocidad) || checkNull(dataTReaccion))) {
    showMessageDialog(null, "Por favor, llenar todos los campos", 
    "Alert", ERROR_MESSAGE);
    valorNull = true;
    resetValores();
  } else {
    validInput1 = validarString(dataVelocidad);
    validInput2 = validarString(dataTReaccion);
  } 
  if (validInput1 && validInput2 && !valorNull) {
      kxh = convertString(dataVelocidad);
      mxs = convertToMs(kxh);
      segundos = convertString(dataTReaccion);
      vReaccion = mxs * segundos;
      vFrenado = ((mxs * mxs) / (2 * fRozamiento * g));
      vDetencion = vReaccion + vFrenado;
      rReaccion.setText("  " + vReaccion);
      rFrenado.setText("  " + vFrenado);
      rDetencion.setText("  " + vDetencion);
      cp5.getController("slider").setCaptionLabel("Distancia de frenado  " + vFrenado + " m");
      cp5.getController("slider").setColorValue(bReset);
      cp5.getController("slider").setColorForeground(bReset);
      cp5.getController("slider").setValue((vReaccion * 490) / vDetencion);
      cp5.getController("slider").setValueLabel("Distancia de reacción " + vReaccion + " m");
      cp5.getController("slider").setColorBackground(bCalcular);
    } else {
        if (!valorNull) {
          showMessageDialog(null, "Favor ingresar solo números con punto digital", 
          "Alert", ERROR_MESSAGE);
          resetValores();
        }
      }
}

void calcular(int theValue) {
  calcularValores(factorRozamiento);
}

void resetValores() {
  vReaccion = 0.0;
  vFrenado = 0.0;
  vDetencion = 0.0;
  rReaccion.setText("  " + vReaccion);
  rFrenado.setText("  " + vFrenado);
  rDetencion.setText("  " + vDetencion);
  vTReaccionClear();
  vVelocidadClear();
  cp5.getController("slider").setCaptionLabel("");
  cp5.getController("slider").setColorValue(myBackground);
  cp5.getController("slider").setValue(0);
  cp5.getController("slider").setColorBackground(bar);
}

void reset(int theValue) {
  resetValores();
} 

boolean validarString(String inputString) {
   String input = inputString;
   boolean valid = false;
   valorNull = false;
   
   if (checkNull(input)) {
     valorNull = true;
   } else {
       for (int i = 0; i < input.length(); i++) {
         char d = '.';
         char e = ',';
         char c = input.charAt(i);
         
         if(c >= '0' && c <= '9') {
          valid = true;
          } else if(Character.compare(c, d) == 0) {
            valid = true; 
            } else if (Character.compare(c, e) == 0) {
               valid = false; 
               return valid;
            } else {
                valid = false;
              }
       }
   }
   return valid;
}

float convertString(String valueData) {
 float value = 0;
 value = Float.parseFloat(valueData);
 return value;
}

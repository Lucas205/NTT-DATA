/*
_____________________________________________________________    
@author: Lucas Araujo.
@description: Class Utils for validations. 
_____________________________________________________________
*/
public class Utils {
    public static Boolean isValide;

    public static Boolean  validaCPF(String CPF) {
        if(CPF.isNumeric() && CPF.length() == 11 ){
            isValide = true;
        }else {
            isValide = false;
        }
        return isValide;
    }
    
    public static Boolean  validaCNPJ(String CNPJ) {
        if(CNPJ.isNumeric() && CNPJ.length() == 14 ){
            isValide = true;
        }else {
            isValide = false;
        }
        return isValide;
    }
}
public with sharing class CurrencyAPI {
    @AuraEnabled(cacheable=true)
    public static string getExchangeRates(String country){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response;
        request.setEndpoint('https://api.frankfurter.app/latest?from='+country);
        request.setMethod('GET');
        response = http.send(request);
        return response.getBody();
    }
    @AuraEnabled(cacheable=true)
    public static string getCountries(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response;
        request.setEndpoint('https://api.frankfurter.app/currencies');
        request.setMethod('GET');
        response = http.send(request);
        return response.getBody();
    }
}
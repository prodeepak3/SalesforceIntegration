public with sharing class CurrencyAPI {
    @AuraEnabled(cacheable=true)
    public static string getExchangeRates(String country){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response;
        request.setEndpoint('https://api.frankfurter.app/latest?from='+country);
        request.setMethod('GET');
        response = http.send(request);
        System.debug('Response: '+response.getBody()+'Status:'+response.getStatus()+'Status Code:'+response.getStatusCode());
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
        System.debug('Response: '+response.getBody());
        System.debug('Status:'+response.getStatus());
        System.System.debug('Status Code:'+response.getStatusCode());
        return response.getBody();
    }
}
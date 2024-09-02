import { LightningElement, wire, track } from 'lwc';
import getCurrencyExchangeRate from '@salesforce/apex/CurrencyAPI.getExchangeRates';
import getCountries from '@salesforce/apex/CurrencyAPI.getCountries';



export default class CurrencyExchangeRate extends LightningElement {
    options=[ ];
    currencyData=[];
    visibleData=[];
    toCurrency='';
    resultCount=5;
    show=false;
    countryData={};
    columns = [
        { label: 'Currency', fieldName: 'Currency' },
        { label: 'Exchange Rate', fieldName: 'Rate' }];

    @wire(getCountries,{})
    countries({error,data}) {
        if(data){
            console.log('data:',data);
            this.countryData=JSON.parse(data);
            for(let country of Object.keys(this.countryData)){
                this.options.push({ label: this.countryData[country], value: country });
            }

            this.show=true;
        }
        else if(error){
            console.log(error);
        } 
    }  

    handleCurrencyChange(event){
        this.toCurrency=event.target.value;
        getCurrencyExchangeRate({country: this.toCurrency}).then(data => {
            data=JSON.parse(data);
            this.currencyData=[];
            for(let currency of Object.keys(data['rates'])){
                this.currencyData.push({ Currency: this.countryData[currency], Rate: data['rates'][currency] });
            }
            this.visibleData=this.resultCount==0?this.currencyData:this.currencyData.slice(0,this.resultCount);
        }).catch(error => {
            console.log(error);
        })
    }

    handleCountChange(event){
        this.resultCount=event.target.value;
        this.visibleData=this.resultCount==0?this.currencyData:this.currencyData.slice(0,this.resultCount);
    }

    
}
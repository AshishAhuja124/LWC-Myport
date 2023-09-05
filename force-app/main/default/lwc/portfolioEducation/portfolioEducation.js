import { LightningElement, wire, api } from 'lwc';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';

const COLUMNS = [
    { label: 'Education', fieldName: 'Education' },
    { label: 'Institution Name', fieldName: 'Institution' },
    { label: 'Passing Year', fieldName: 'PassingYear' },
    
];
export default class PortfolioEducation extends LightningElement {
    tableData = []
    columns = COLUMNS
    @api recordId

    @wire(getRelatedListRecords, {
        parentRecordId:"$recordId",
        relatedListId:'Educations__r',
        fields:['Education__c.Institution__c','Education__c.Title__c','Education__c.PassingYear__c'],
        sortBy:['Education__c.PassingYear__c']
    })EducationHandler({data, error}){
        if(data){
            console.log("EducationHandler data", JSON.stringify(data))
            this.formatData(data)
        }
        if(error){
            console.error("EducationHandler error", error)
        }
    }

    formatData(data){
        this.tableData = [...data.records].reverse().map(item=>{
            let Id = item.id
            const {Institution__c, PassingYear__c, Title__c} = item.fields
            let Education = Title__c.value
            let Institution = Institution__c.value
            let PassingYear = PassingYear__c.value
            return {
                Id,Education, Institution, PassingYear
            }
        })

        console.log("this.tableData", JSON.stringify(this.tableData))
    }

}
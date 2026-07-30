public class ApplicationTriggerHandler {
    public static void beforeInsert(List<Application__c> newApplications) {

        // Collect Student and Job IDs
        Set<Id> studentIds = new Set<Id>();
        Set<Id> jobIds = new Set<Id>();

        for (Application__c app : newApplications) {
            if (app.Student__c != null) {
                studentIds.add(app.Student__c);
            }
            if (app.Job__c != null) {
                jobIds.add(app.Job__c);
            }
        }

        // Query Students
        Map<Id, Student__c> studentMap = new Map<Id, Student__c>(
            [
                SELECT Id, CGPA__c
                FROM Student__c
                WHERE Id IN :studentIds
            ]
        );

        // Query Jobs
        Map<Id, Job__c> jobMap = new Map<Id, Job__c>(
            [
                SELECT Id, Minimum_CGPA__c, Last_Date__c
                FROM Job__c
                WHERE Id IN :jobIds
            ]
        );

        // Query Existing Applications
        Set<String> existingApplications = new Set<String>();

        for (Application__c app : [
            SELECT Student__c, Job__c
            FROM Application__c
            WHERE Student__c IN :studentIds
            AND Job__c IN :jobIds
        ]) {
            existingApplications.add(app.Student__c + '-' + app.Job__c);
        }

        // Process each new application
        for (Application__c app : newApplications) {

            Student__c student = studentMap.get(app.Student__c);
            Job__c job = jobMap.get(app.Job__c);

            if (student == null || job == null) {
                continue;
            }

            // Rule 1 - CGPA Check
            if (student.CGPA__c < job.Minimum_CGPA__c) {
                app.addError('Student CGPA is below the required minimum CGPA.');
            }

            // Rule 2 - Last Date Check
            if (Date.today() > job.Last_Date__c) {
                app.addError('Application deadline has passed.');
            }

            // Rule 3 - Duplicate Check
            String key = app.Student__c + '-' + app.Job__c;

            if (existingApplications.contains(key)) {
                app.addError('Student has already applied for this job.');
            }

            // Rule 4 - Default Status
            app.Status__c = 'Applied';
        }
    }
}

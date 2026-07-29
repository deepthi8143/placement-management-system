# Placement Management System using Apex Trigger

## Project Overview

This project automates the student job application process using Apex Triggers in Salesforce. The trigger validates each application before it is saved and ensures that all business rules are followed.

### Project Architecture

```text
Student
   │
   │
Application
   │
   │
 Job
```

## Objects Used

### Student__c

* Student Name
* CGPA

### Job__c

* Job Title
* Minimum CGPA
* Last Date

### Application__c

* Application Number
* Student (Lookup)
* Job (Lookup)
* Status

## Business Rules Implemented

* Student CGPA must be greater than or equal to the Job's minimum CGPA.
* A student cannot apply for the same job more than once.
* Applications submitted after the job's last date are rejected.
* Every valid application automatically receives the status **Applied**.
* Meaningful error messages are displayed whenever validation fails.

## Why did you choose a Trigger?

A Trigger was chosen because the business rules must execute automatically whenever an Application record is created. It ensures that validations are enforced regardless of whether records are created through the Salesforce UI, Data Loader, APIs, or other integrations.

## Why Before Insert?

A Before Insert Trigger allows validations and default field assignments before the record is saved to the database. This improves performance by avoiding additional DML operations and prevents invalid records from being inserted.

## How did you bulkify your code?

The trigger was bulkified by:
* Processing all records from `Trigger.new` together.
* Using **Sets** to collect unique Student and Job IDs.
* Using **Maps** to retrieve Student and Job records efficiently.
* Executing SOQL queries outside loops.
* Avoiding DML statements inside loops.

This approach ensures the trigger can handle bulk record operations while remaining within Salesforce Governor Limits.

## Trigger Handler Pattern

```text
ApplicationTrigger
        │
        ▼
ApplicationTriggerHandler
```

### Responsibilities

**ApplicationTrigger**

* Executes before an Application record is inserted.
* Calls the handler class.

**ApplicationTriggerHandler**

* Receives `Trigger.new`.
* Performs all business validations.
* Checks student eligibility.
* Prevents duplicate applications.
* Validates the application deadline.
* Sets the default Status to **Applied**.

## Testing

The following scenarios were tested:
* Successful application creation.
* Student with CGPA below the required minimum.
* Duplicate application prevention.
* Application after the last date.
* Automatic assignment of the **Applied** status.

## What I Learned Today

Through this project, I learned how to build production-ready Apex Triggers using the Trigger Handler Pattern. I gained practical experience with Governor Limits, bulkification, and Apex collections such as List, Set, and Map. I also learned how to design scalable trigger logic and apply Salesforce best practices for maintainable code.

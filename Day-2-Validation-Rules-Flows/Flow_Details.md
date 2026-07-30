# Record-Triggered Flow

## Definition
A Record-Triggered Flow is a Salesforce automation tool that runs automatically when a record is created, updated, or deleted. It allows you to automate business processes without writing Apex code.

## Objective
Automate the application process in the Placement Management System.

## Flow Type
Record-Triggered Flow

## Object
Application__c

## Trigger
- Runs when an Application record is created.

## Business Requirements
- Automatically populate the **Application Date**.
- Send a confirmation email to the Placement Officer.

## Implementation

### Before Save Flow
- Sets the **Application Date** to the current date before the record is saved.
- Uses an **Assignment** element.

### After Save Flow
- Sends a confirmation email to the Placement Officer after the record is successfully created.
- Uses the **Send Email** action.

## Why Record-Triggered Flow?
- No Apex code required.
- Faster and easier to maintain.
- Follows Salesforce's **Clicks Before Code** best practice.

## Learning Outcome
- Understood how to build Record-Triggered Flows.
- Automated business processes using declarative tools.

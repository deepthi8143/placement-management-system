# Validation Rules

A Validation Rule is a Salesforce feature that checks whether the data entered by a user follows business rules. If the data is invalid, Salesforce prevents the record from being saved and displays an error message.

## Purpose
Validation Rules help maintain data accuracy and consistency by preventing invalid data from being stored.

## Example Business Requirements

### 1. Prevent Duplicate Applications
**Requirement**
- A student should not apply for the same job more than once.

**Solution**
- Validation Rule

**Reason**
- Prevents duplicate records from being saved.

---

### 2. Reject Low CGPA
**Requirement**
- Students with a CGPA below the minimum required CGPA should not be allowed to apply.

**Solution**
- Validation Rule (if the comparison can be done directly) or Flow (if complex cross-object logic is required).

**Reason**
- Ensures only eligible students can apply.

---

## Benefits
- Improves data quality.
- Prevents invalid records.
- Easy to maintain.
- No coding required.

## Interview Points
- Validation Rules only validate data.
- They cannot create, update, or delete records.
- They cannot send emails.
- They cannot perform automation tasks.

## Learning Outcome
- Learned how Validation Rules enforce business rules.
- Understood when to use Validation Rules instead of Flows or Apex Triggers.

// @Name: Profile
// @Description: Example of a profile of the Patient resource. This example includes a few of the most commonly used constraints and documentation features of FHIR profiles.

Profile:     FoodAllergy
Id:          FoodAllergyProfile
Parent:      AllergyIntolerance
Title:       "Food Allergy profile"
Description: "Food allergy profile for reported food allergies"
// The `Title` keyword defines the human-readable title on the profile's page in the built
// Implementation Guide. This is also visible in on the Artifacts page and in the Table of Contents
// in the built Implementation Guide.
//
// The `Description` keyword defines a short summary of the profile that appears at the top of the
// profile page under "Definition" and on the Artifacts page in the built Implementation Guide.
//
// Note that FSH files do not typically have extra white space between rules, but due to the large
// number of comments in this example, extra white space is included for better readability.

// ----- Begin rules:

// Require at least one value inside the `name` element
* name 1..*

// Mark elements as MustSupport
*patient MS
* code 1..1
*clinicalStatus 1..1
*recordedDate MS

*participant 

*participant contains recorder 0..1 and asserter 0..1

*participant[recorder]
  * function - #enter

  *participant[asserter]
  * function - #informant

// Provide custom prose descriptions of the `name` element:
//
// The contents of `^short` appears in the "Description & Constraints" column in the differential or
// snapshot tables of a built Implementation Guide.
//
// The `^definition` displays when clicking on an element's name in the differential or snapshot
// tables when building a built Implementation Guide. This can also be accessed in the "Detailed
// Descriptions" tab on a profile page.
* name ^short = "Official name (i.e., legal name) of patient"
* name ^definition = "Official name (i.e., legal name) of the patient, corresponding to `official` in [this value set](https://www.hl7.org/fhir/valueset-name-use.html)."

// The contents of `^comment` are also displayed on the "Detailed Descriptions" tab
// in the built Implementation Guide.
* birthDate ^comment = "If exact date of birth is partially or completely unknown, Implementers SHALL populate this element with the date of birth information listed on the patient's government-issued identification."

// Do not allow `gender` to be included.
* gender 0..0

// Require a value from a specific value set be used for an element
* maritalStatus from http://hl7.org/fhir/ValueSet/marital-status (required)

// Restrict `something[x]` to a specific type -- in this case only allowing dateTime to be used
* deceased[x] only dateTime
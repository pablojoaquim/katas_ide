#ifndef PERSON_H
#define PERSON_H

/*===========================================================================*/
/**
 * @file person.h
 *
 *------------------------------------------------------------------------------
 *
 * @section DESC DESCRIPTION: API for the Person module
 *
 * @todo Add full description here
 *
 * @section ABBR ABBREVIATIONS:
 *   - @todo List any abbreviations, precede each with a dash ('-').
 *
 * @section TRACE TRACEABILITY INFO:
 *   - Design Document(s):
 *     - @todo Update list of design document(s).
 *
 *   - Requirements Document(s):
 *     - @todo Update list of requirements document(s)
 *
 *   - Applicable Standards (in order of precedence: highest first):
 *     - @todo Update list of other applicable standards
 *
 */
/*==========================================================================*/

/*===========================================================================*
 * Header Files
 *===========================================================================*/
#include <string>

#   ifdef __cplusplus
extern "C"
{ /* ! Inclusion of header files should NOT be inside the extern "C" block */
#   endif /* __cplusplus */
/*===========================================================================*
 * Exported Preprocessor #define Constants
 *===========================================================================*/

/*===========================================================================*
 * Exported Preprocessor #define MACROS
 *===========================================================================*/

/*===========================================================================*
 * Exported Type Declarations
 *===========================================================================*/

/*===========================================================================*
 * Exported Classes
 *===========================================================================*/
class Person {
private:
    std::string name;
    int age;

public:
    Person(const std::string& name, int age);
    int greet() const;
};

/*===========================================================================*
 * Exported Function Prototypes
 *===========================================================================*/

#   ifdef __cplusplus
}         /* extern "C" */
#   endif /* __cplusplus */
/*===========================================================================*/
/*===========================================================================*/
#endif /* PERSON_H */


#ifndef PERSON_H
#define PERSON_H





#endif

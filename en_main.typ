// HSE Presentation Template using Touying (EN)
// Based on the HSE FCS graduation thesis presentation template

#import "lib.typ": *
#import themes.hse: *

// Configure the HSE theme with branding colors and logo
#show: hse-theme.with(
  aspect-ratio: "16-9",
  config-info(
    institution: [Faculty of Computer Science],
    program: [Department of Software Engineering],
    short_program: [Software Engineering],
    program_code: [09.03.04],
    title: [GRADUATION THESIS TITLE],
    type: [Research Graduation Thesis],
    author: [FULL NAME],
    short_author: [I. O. Surname],
    group: [BSE123],
    supervisor_title: [POSITION, ACADEMIC DEGREE],
    supervisor: [Supervisor Name],
    consultant_role: [Co-supervisor],
    consultant_title: [],
    consultant: [Consultant Name],
    city: [Moscow],
    year: [2026],
    lang: "en",
    email: "your_email@edu.hse.ru",
    logo: image("logos/01_Logo_HSE_full_rus_CMYK_for_dark_1.svg"),
  ),
)

// Set heading numbering for Level 1 only
#set heading(numbering: (..n) => if n.pos().len() == 1 { numbering("1.", ..n) })

// Title slide
#title-slide()

= Basic Concepts
== Definitions

Term 1
: Definition of term 1

Term 2
: Definition of term 2

Term 3
: Definition of term 3

It is recommended to arrange alphabetically (by ASCII)

= Subject Area

Description of the subject area

- Brief description of the field of application
- Description of the main processes
- Existing analogues and their limitations

= Problem and Task Statement

Informal task statement:

1. Description of the problem
2. Goal of the work
3. Tasks to be solved

Requirements for the solution being developed:


= Relevance of the Work

Why this work is important:

- Current state of the subject area
- Disadvantages of existing solutions
- Practical significance


= Goal of the Work

The goal of this work is...

= Tasks of the Work

To achieve this goal, it is necessary to solve the following tasks:

1. Conduct analysis of the subject area
2. Develop system architecture
3. Implement the software product
4. Conduct testing

= Overview of Existing Solutions

Existing solutions:

- *Solution 1:* description, pros, cons
- *Solution 2:* description, pros, cons
- *Solution 3:* description, pros, cons

Comparative table:


= System Architecture

Description of the architecture of the solution being developed

// #image("architecture.png", width: 80%)

= System Components

Main components:

- Component 1: description
- Component 2: description
- Component 3: description



= Technology Stack

Technologies used:

- Programming language: ...
- Framework: ...
- Database: ...
- Development tools: ...

= Key Code Snippets

```python
# Code example
def main():
    print("Hello, HSE!")
```


= Testing

Testing methods:

- Unit testing
- Integration testing
- System testing

Testing results:


= Results of the Work

Main results:

1. Developed software product
2. Research conducted
3. Conclusions obtained

= Demo

Demonstration of main functions:



= Conclusion

During the implementation of the graduation thesis, the following results were achieved:

- Subject area analysis performed
- System architecture developed
- Software product implemented
- Testing conducted

Directions for further development:


// #bibliography-slide("references.bib")


= Appendix A: Listings

Additional code listings

= Appendix B: Screenshots

Additional interface screenshots

#final-slide()
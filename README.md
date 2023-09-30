# Purpose
For ENGR 468/568 Students to share any HDL code from in-class examples. They can either be rudimentary versions or apply more HDL syntax/functionalities. The hope is to accelerate learning and for this to be maintained for future years.

# How to Contribute
1. Fork the repo
2. For each example you want to contribute, create a branch for it
3. Implement your design and simulation HDL code
4. Be sure to rebase and squash unecessary commits for a clean git history on top the latest commit 
5. Create a pull request
6. It will be reviewed to ensure that it abides by the repo's structure and for code review (optional) by the repo's maintainers
7. After each review pass, it may be necessary to repeat 4 - 6.

# Commit Message Guidelines
When writing commit messages, follow these guidelines to make them meaningful and concise:

1. For a new project being added:
   - NEW: Implementing <project> by <github-username>

2. For an improvement made on an existing project:
   - IMP: Adding define statements for async/sync resets

Use a 3-4 letter code to describe the action, followed by a brief explanation.

# Structure of the Repo
```
|-- <project>
|   |-- <project>-<git-username>
|       |-- design.v / design.sv
|       |-- tb_design.v / design.sv
|       |-- if using VUnit: run_design.py
|       |-- (Other project-specific files, such as a README.md)
```

# Setting up VUnit
This is optional, but preferred. It's a unit test automation framework for HDL to be used in Python with ModelSim as the backend. For instructions and example usage refer to https://vunit.github.io/index.html or see the Need Help Secition. 

# Need help?
Contact me: efirmans@student.ubc.ca
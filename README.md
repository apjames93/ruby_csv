Scaffold the project to get started quickly with ‘bundle gems’.

### Goals
- [x] Trim extra white space for all fields
- [x] Transform phone_numbers to E.164 format
- [x] Transform ALL dates to (YYYY-MM-DD) format
- [x] write `output.csv` 
- [x] write `report.txt` 

### Testing
- run `rspec`

### run 
- in irb `require './lib/ruby_csv.rb'`
- in irb run `RubyCsv.parse` to generate `output.csv` and `report.txt`

### TODOS: 
    - pass a path arg to the `parse` to change csv. 
    - work more on formatting dates and validating data entry for a better solution.
    - Add more testing around `create_csv` and `parse`

# Bowling Scorer
CLI app that scores games of ten-pin bowling.

It takes a text file as input and outputs the scoring for the associated games to the stdout.

## Installation
This project requires:
- ruby `3.2.2`
- Bundler compatible with version `2.4.10`

To install first clone or download the project to your local machine then run:

```bash
bundle install
``` 

This will install the required gems to run the project.

## Running the project

To run the project you need to run the following command

```bash 
./bin/bowling-scorer.rb -f <path_to_file>
```

Where `<path_to_file>` is the path to the file containing the bowling scores.

> There are some example files in the `spec/fixtures` folder that you can use to test the project.

If you want more information you can run the following command to get the help menu:

```bash
./bin/bowling-scorer.rb -h
```


## Quality Assurance

If you want to run tests and coverage you need to run `bundle config set --local with development` and then `bundle install` first to install the required gems.

### Unit and Integration tests
This project uses Rspec as test suit. To run the tests you need to run the following command:

```bash
bundle exec rspec
```
### Coverage 
Upon running the test you will get a coverage report in the `coverage` folder. You can open the `index.html` file in your browser to see the coverage report.

### Linter
This project uses Rubocop as linter. To run the linter you need to run the following command:

```bash
bundle exec rubocop
```

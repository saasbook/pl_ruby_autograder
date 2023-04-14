# Ruby autograding for PrairieLearn

This autograder assumes a Docker container with `rvm` installed and
the necessary versions of Ruby and all gems to grade a question.  The
`Dockerfile` in this repo, while not used by the gem, is used to build
the image `saasbook/pl-ruby-autograder` on Dockerhub.

This gem includes RSpec and Cucumber test formatters whose JSON
output matches what PrairieLearn wants, and `rake` tasks to run RSpec
and Cucumber that know where to look for
various files PrairieLearn provides or expects.

When the autograder wakes up, `/grade/student/` will contain file(s)
submitted by the student, `/grade/tests/` will contain everything in
the `tests/` directory of your PL question.

(note to self: where does FPP element put student file(s)?
see a highly stripped version in ruby-autograder/tests/basic/data.json)

## Creating a Ruby coding question for autograding

To autograde a Ruby question by running some collection of specs and
features, configure your PL question directory as follows:

In `info.json`:

```json
"gradingMethod": "External",
"externalGradingOptions": {
    "enabled": true,
    "image" : "saasbook/pl-ruby-autograder",
    "entrypoint": "/grader/run.py",  #### THIS IS WRONG
    "timeout" : 60
}
```

Make sure your autograder's Gemfile includes `gem 'pl-ruby-autograder` in at least the `test` gemset.

In the `tests/` directory in your question, create a file called `meta.json` that includes the following
```json
{
    "submission_file": "file/to/submit/to.rb",
    "submission_root": "location/to/submit/additional/files/",
    "submit_to_line" : 3,
    "pre-text" : "any lines to precede\n  the student's submission\n", 
    "post-text": "any lines to succeed\n  the student's submission\n",
    "grading_exclusions" : [
        "Any test names that should not be included in grading"
    ]
}
```

In the `tests/` directory in your question, include the complete application that the student submits to. Note: do not include the text included in `meta.json`'s `"pre-text"` and `"post-text"` fields as those will be inserted during grading.


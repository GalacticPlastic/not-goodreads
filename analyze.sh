#!/bin/bash

echo 'Running Consistency Fail ->'
bundle exec consistency_fail
echo 'Running NullAlign ->'
bundle exec nullalign
echo 'Running Brakeman ->'
bundle exec brakeman -qz --skip-libs
echo 'Running Rails Best Practices ->'
bundle exec rails_best_practices
echo 'Running Flay ->'
bundle exec flay app
echo 'Running Rubocop ->'
bundle exec rubocop
echo 'Running RSpec ->'
bundle exec rspec
echo 'Analyzers completed.'

#!/bin/sh

# Installing prereqs
pip install -r requirements.txt

# Fixing stuff
echo "Updating old syntax"
pyupgrade --py3-plus

echo "Fixing syntax"
black .

echo "Fixing import order"
isort .

echo "Formatting docstrings"
docformatter -i --wrap-summaries=120 -r .

# Run tests

echo "Static Analysis - mypy"
mypy .

echo "Static Analysis - flake"
flake8

echo "Static Analysis - pydocstyle"
pydocstyle --count

echo "Security Analysis - bandit"
bandit -r .

echo "Your unit tests"
pytest -v

echo "Your test coverage"
coverage run -m pytest

# Define the virtual environment name
VENV_NAME?=cd

# Define the python version
PYTHON_VERSION?=3.9.7

# Define the python interpreter
PYTHON_INTERPRETER=$(VENV_NAME)/bin/python$(PYTHON_VERSION)

# Define the requirements file
REQUIREMENTS=requirements.txt

# Define the Makefile targets
.PHONY: help clean clean-pyc clean-build clean-test clean-venv venv install test lint format

help:
    @echo "clean - remove all build, test, coverage and Python artifacts"
    @echo "clean-pyc - remove Python file artifacts"
    @echo "clean-build - remove build artifacts"
    @echo "clean-test - remove test and coverage artifacts"
    @echo "clean-venv - remove virtual environment"
    @echo "venv - create a virtual environment"
    @echo "install - install the package in development mode"
    @echo "test - run tests quickly with the default Python"
    @echo "lint - check style with flake8"
    @echo "format - format code with black"

clean: clean-build clean-pyc clean-test clean-venv

clean-pyc:
    find . -name '*.pyc' -exec rm --force {} +
    find . -name '*.pyo' -exec rm --force {} +
    find . -name '*~' -exec rm --force {} +
    find . -name '__pycache__' -exec rm -rf --force {} +

clean-build:
    rm --force --recursive build/
    rm --force --recursive dist/
    rm --force --recursive *.egg-info

clean-test:
    rm --force --recursive .tox/
    rm --force --recursive .pytest_cache
    rm --force --recursive htmlcov/

clean-venv:
    rm --force --recursive $(VENV_NAME)

venv:
    python$(PYTHON_VERSION) -m venv $(VENV_NAME)
    $(PYTHON_INTERPRETER) -m pip install --upgrade pip setuptools wheel

install:
    $(PYTHON_INTERPRETER) -m pip install --editable .

test:
    $(PYTHON_INTERPRETER) -m pytest

lint:
    $(PYTHON_INTERPRETER) -m flake8

format:
    $(PYTHON_INTERPRETER) -m black .

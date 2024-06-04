# Packaging Notes for verademo

This one has been designed to be easy to package.
Just run `mvn clean package` and take the output `war` file.

## Build Environment

`Java 17` has been used to build the repository.

## Auto-Package

The project can be auto-packages with the following command (from the root of the project):

```bash
veracode package --source . --type directory --output .veracode/output/auto --trust
```

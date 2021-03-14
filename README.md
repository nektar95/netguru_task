# Netguru Task

Core values viewer

## Getting Started 🚀

Project flavors:

- development
- production


```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

---

## Testing

Running unit test:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To be able to view the generated coverage report you have to use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```


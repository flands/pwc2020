# pwc2020

Part of the [day 3 keynote](https://2020.pythonwebconf.com/presentations/importance-of-tracing-in-python).

This is a [demo Python Flask application](https://github.com/gurkanakdeniz/example-flask-crud) that is
instrumented with [OpenTelemetry Python](https://github.com/open-telemetry/opentelemetry-python)
auto-instrumentation. It is configured to send to the
[OpenTelemetry Collector](https://github.com/open-telemetry/opentelemetry-collector) which sends to a
[Jaeger](https://www.jaegertracing.io/docs/1.18/getting-started/#all-in-one) back-end.

## License

This project is licensed under the [MIT License](LICENSE)

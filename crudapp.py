from app import app

from opentelemetry import trace
from opentelemetry.ext.otlp.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import (
    ConsoleSpanExporter,
    SimpleExportSpanProcessor,
)

trace.set_tracer_provider(TracerProvider())
trace.get_tracer_provider().add_span_processor(
    SimpleExportSpanProcessor(ConsoleSpanExporter())
)
trace.get_tracer_provider().add_span_processor(
    SimpleExportSpanProcessor(OTLPSpanExporter())
)

app.run()

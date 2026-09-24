// OpenTelemetry bootstrap — loaded via `node --require ./tracing.js server.js`.
// Auto-instruments Express, HTTP, MongoDB/Mongoose, Redis, pg, etc.
// Configuration is driven entirely by OTEL_* environment variables:
//   OTEL_SERVICE_NAME            e.g. "user-service"
//   OTEL_EXPORTER_OTLP_ENDPOINT  e.g. "http://jaeger-collector:4318"
const { NodeSDK } = require('@opentelemetry/sdk-node');
const { getNodeAutoInstrumentations } = require('@opentelemetry/auto-instrumentations-node');
const { OTLPTraceExporter } = require('@opentelemetry/exporter-trace-otlp-http');

const sdk = new NodeSDK({
  // Exporter reads OTEL_EXPORTER_OTLP_ENDPOINT and appends /v1/traces automatically.
  traceExporter: new OTLPTraceExporter(),
  instrumentations: [
    getNodeAutoInstrumentations({
      // Health checks are noisy and not useful as traces.
      '@opentelemetry/instrumentation-fs': { enabled: false },
    }),
  ],
});

sdk.start();

process.on('SIGTERM', () => {
  sdk.shutdown()
    .catch((err) => console.error('Error shutting down OpenTelemetry SDK', err))
    .finally(() => process.exit(0));
});

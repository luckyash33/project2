#!/bin/bash

echo "OpenTelemetry Demo - Component Access"
echo "======================================"
echo ""
echo "1. E-commerce Application (Direct Access):"
echo "   http://a1c7b30e1a5244e29b81b9f1c3726cb8-736745387.ap-south-1.elb.amazonaws.com:8080"
echo ""
echo "2. Grafana (Port-forward required):"
echo "   kubectl port-forward svc/grafana -n otel-demo 3000:80"
echo "   Then access: http://localhost:3000 (admin/admin)"
echo ""
echo "3. Jaeger (Port-forward required):"
echo "   kubectl port-forward svc/jaeger-query -n otel-demo 16686:16686"
echo "   Then access: http://localhost:16686"
echo ""
echo "4. Prometheus (Port-forward required):"
echo "   kubectl port-forward svc/prometheus -n otel-demo 9090:9090"
echo "   Then access: http://localhost:9090"
echo ""
echo "5. OpenSearch (Port-forward required):"
echo "   kubectl port-forward svc/opensearch -n otel-demo 9200:9200"
echo "   Then access: http://localhost:9200"
echo ""
echo "6. Load Generator (Port-forward required):"
echo "   kubectl port-forward svc/load-generator -n otel-demo 8089:8089"
echo "   Then access: http://localhost:8089"
echo ""
echo "Select component to access (1-6) or 'q' to quit:"
read -r choice

case $choice in
    1)
        echo "Opening frontend in browser..."
        open "http://a1c7b30e1a5244e29b81b9f1c3726cb8-736745387.ap-south-1.elb.amazonaws.com:8080" 2>/dev/null || \
        xdg-open "http://a1c7b30e1a5244e29b81b9f1c3726cb8-736745387.ap-south-1.elb.amazonaws.com:8080" 2>/dev/null || \
        echo "Please open: http://a1c7b30e1a5244e29b81b9f1c3726cb8-736745387.ap-south-1.elb.amazonaws.com:8080"
        ;;
    2)
        echo "Starting Grafana port-forward..."
        kubectl port-forward svc/grafana -n otel-demo 3000:80
        ;;
    3)
        echo "Starting Jaeger port-forward..."
        kubectl port-forward svc/jaeger-query -n otel-demo 16686:16686
        ;;
    4)
        echo "Starting Prometheus port-forward..."
        kubectl port-forward svc/prometheus -n otel-demo 9090:9090
        ;;
    5)
        echo "Starting OpenSearch port-forward..."
        kubectl port-forward svc/opensearch -n otel-demo 9200:9200
        ;;
    6)
        echo "Starting Load Generator port-forward..."
        kubectl port-forward svc/load-generator -n otel-demo 8089:8089
        ;;
    q|Q)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

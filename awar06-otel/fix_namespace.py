import re

with open('opentelemetry-demo.yaml', 'r') as f:
    content = f.read()

# Pattern to match Deployment without namespace
# We need to add namespace after "name: <deployment-name>" in metadata
pattern = r'(kind: Deployment\nmetadata:\n  name: (?!grafana|otel-collector)[\w-]+\n)(  labels:)'

replacement = r'\1  namespace: otel-demo\n\2'

fixed_content = re.sub(pattern, replacement, content)

with open('opentelemetry-demo.yaml', 'w') as f:
    f.write(fixed_content)

print("Fixed namespace for deployments")

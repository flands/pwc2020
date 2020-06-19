#!/usr/bin/env bash

# Configure python web app
git clone https://github.com/gurkanakdeniz/example-flask-crud.git
cd example-flask-crud/
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
export FLASK_APP=crudapp.py
flask db init
flask db migrate -m "entries table"
flask db upgrade

# Install OpenTelemetry dependencies
pip install opentelemetry-api \
    opentelemetry-sdk \
    opentelemetry-instrumentation \
    opentelemetry-ext-flask \
    opentelemetry-ext-otlp \
    opentelemetry-ext-requests \
    opentelemetry-ext-sqlalchemy \
    opentelemetry-ext-sqlite3

# Deploy collector and backend
docker run --rm -d -p 55678:55678 \
    -v "${PWD}/../otel.yaml":/otel.yaml --name otel \
    otel/opentelemetry-collector:0.4.0 --config=otel.yaml
docker run --rm -d -p 9411:9411 -p 16686:16686 \
    -e COLLECTOR_ZIPKIN_HTTP_PORT=9411 \
    --name jaeger jaegertracing/all-in-one:latest

echo
echo "Test 1: Run uninstrumented app..."
echo
flask run

echo
echo "Test 2: Run instrumented app..."
echo
echo diff crudapp.py ../crudapp.py
echo
diff crudapp.py ../crudapp.py
cp ../crudapp.py crudapp.py
opentelemetry-instrument python crudapp.py

docker stop jaeger >/dev/null
docker stop otel >/dev/null

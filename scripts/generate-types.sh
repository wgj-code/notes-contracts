#!/usr/bin/env bash
# Generate TypeScript types from OpenAPI spec
# Usage: ./scripts/generate-types.sh

set -euo pipefail

cd "$(dirname "$0")/.."

mkdir -p dist

npx openapi-typescript openapi/notes-api.yaml -o dist/notes-api.d.ts

echo "✓ Generated dist/notes-api.d.ts"

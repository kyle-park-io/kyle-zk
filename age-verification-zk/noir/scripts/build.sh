#!/bin/bash

# Noir Age Verification ZK Circuit Build Script
echo "🏗️  Starting Noir Age Verification ZK Circuit build..."

# Navigate to project directory
cd "$(dirname "$0")/.."

# Execute build
echo "📦 Building with Nargo..."
nargo build

if [ $? -eq 0 ]; then
    echo "✅ Build completed successfully!"
    echo "📁 Build artifacts:"
    echo "   - Bytecode: target/age_verification_zk.json"
    echo "   - Circuit info: target/age_verification_zk.toml"
else
    echo "❌ Build failed with errors."
    exit 1
fi

# Check circuit information
echo "📊 Circuit Information:"
if [ -f "target/age_verification_zk.toml" ]; then
    echo "   - Constraints count: $(grep -o 'num_constraints = [0-9]*' target/age_verification_zk.toml | cut -d' ' -f3)"
    echo "   - Variables count: $(grep -o 'num_variables = [0-9]*' target/age_verification_zk.toml | cut -d' ' -f3)"
else
    echo "   - Constraints count: ~50 (estimated)"
    echo "   - Variables count: ~25 (estimated)"
fi

echo "🎉 Build complete!"

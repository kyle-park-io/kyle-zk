#!/bin/bash

# Cairo Age Verification ZK Circuit Build Script
echo "🏗️  Starting Cairo Age Verification ZK Circuit build..."

# Navigate to project directory
cd "$(dirname "$0")/.."

# Execute build
echo "📦 Building with Scarb..."
scarb build

if [ $? -eq 0 ]; then
    echo "✅ Build completed successfully!"
    echo "📁 Build artifacts saved to target/ directory."
else
    echo "❌ Build failed with errors."
    exit 1
fi

echo "🎉 Build complete!"

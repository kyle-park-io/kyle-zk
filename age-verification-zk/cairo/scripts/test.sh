#!/bin/bash

# Cairo Age Verification ZK Circuit Test Script
echo "🧪 Starting Cairo Age Verification ZK Circuit tests..."

# Navigate to project directory
cd "$(dirname "$0")/.."

# Execute tests
echo "🔍 Running unit tests..."
scarb test

if [ $? -eq 0 ]; then
    echo "✅ All tests passed successfully!"
    echo ""
    echo "📊 Test Results Summary:"
    echo "   - Success cases: 25 years, 20 years age verification ✓"
    echo "   - Failure cases: 19 years underage verification ✓"
    echo "   - Security tests: Invalid commitment verification ✓"
    echo "   - Counter functionality: Verification count tracking ✓"
else
    echo "❌ Tests failed with errors."
    exit 1
fi

echo "🎉 Tests complete!"

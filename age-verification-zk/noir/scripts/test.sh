#!/bin/bash

# Noir Age Verification ZK Circuit Test Script
echo "🧪 Starting Noir Age Verification ZK Circuit tests..."

# Navigate to project directory
cd "$(dirname "$0")/.."

# Execute tests
echo "🔍 Running unit tests..."
nargo test

if [ $? -eq 0 ]; then
    echo "✅ All tests passed successfully!"
    echo ""
    echo "📊 Test Results Summary:"
    echo "   - Success cases: 25 years, 20 years age verification ✓"
    echo "   - Failure cases: 19 years, 18 years underage verification ✓"
    echo "   - Commitment integrity verification ✓"
    echo "   - Age range validation ✓"
    echo "   - Multiple scenario testing ✓"
else
    echo "❌ Tests failed with errors."
    exit 1
fi

# Detailed test information
echo ""
echo "🔬 Detailed Test Information:"
echo "   - Hash function: Field arithmetic (demo)"
echo "   - Constraints: Minimum age comparison + commitment verification"
echo "   - Security features: Age range validation included"
echo "   - Performance: Lightweight circuit design"

echo "🎉 Tests complete!"

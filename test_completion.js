-- Test file to validate completion and documentation behavior
console.log("Testing completion behavior");

-- This should trigger JavaScript completion when typing console.
-- The goal is to make documentation less intrusive while still showing Copilot suggestions

function testFunction() {
    console.log("Testing");
    // When typing this, documentation should be less intrusive
    // Copilot suggestions should appear with Alt+L to accept
}

// Test various scenarios:
// 1. Type "console." - should show completion but documentation shouldn't block view
// 2. Copilot suggestions should work with Alt+L
// 3. Documentation should only show when explicitly requested (Ctrl+Space)
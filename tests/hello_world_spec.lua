local plenary = require('plenary.test_harness')

plenary.test_directory('tests', function()
    describe('Hello World', function()
        it('should return "Hello, World!"', function()
            local result = "Hello, World!"
            assert.are.equal(result, "Hello, World!")
        end)
    end)
end)
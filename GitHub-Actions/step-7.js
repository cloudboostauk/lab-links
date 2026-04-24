const { add, subtract, multiply, divide } = require('./math');
 
describe('add', () => {
  test('adds two positive numbers', () => {
    expect(add(2, 3)).toBe(5);
  });
 
  test('adds a positive and a negative number', () => {
    expect(add(5, -3)).toBe(2);
  });
});
 
describe('subtract', () => {
  test('subtracts two numbers', () => {
    expect(subtract(10, 4)).toBe(6);
  });
});
 
describe('multiply', () => {
  test('multiplies two numbers', () => {
    expect(multiply(3, 4)).toBe(12);
  });
});
 
describe('divide', () => {
  test('divides two numbers', () => {
    expect(divide(10, 2)).toBe(5);
  });
 
  test('throws an error when dividing by zero', () => {
    expect(() => divide(5, 0)).toThrow('Cannot divide by zero');
  });
});


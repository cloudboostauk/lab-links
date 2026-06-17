
# test_calculator.py
# Tests for the NovaPay Fee Calculator.
# Uses Python's built-in unittest module — no packages to install.
 
import unittest
from calculator import calculate_fee
 
 
class TestCalculateFee(unittest.TestCase):
 
    def test_domestic_fee(self):
        """10,000 NGN domestic should give a 50 NGN fee (0.5%)"""
        self.assertEqual(calculate_fee(10000, 'domestic'), 50.0)
 
    def test_international_fee(self):
        """10,000 NGN international should give a 150 NGN fee (1.5%)"""
        self.assertEqual(calculate_fee(10000, 'international'), 150.0)
 
    def test_rounding(self):
        """Result should be rounded to 2 decimal places"""
        self.assertEqual(calculate_fee(333, 'domestic'), 1.67)
 
    def test_negative_amount_raises(self):
        """Negative amounts should raise a ValueError"""
        with self.assertRaises(ValueError):
            calculate_fee(-500, 'domestic')
 
    def test_zero_amount_raises(self):
        """Zero is not a valid transfer amount"""
        with self.assertRaises(ValueError):
            calculate_fee(0, 'domestic')
 
    def test_unknown_type_raises(self):
        """An unrecognised transfer type should raise a ValueError"""
        with self.assertRaises(ValueError):
            calculate_fee(1000, 'crypto')
 
 
if __name__ == '__main__':
    unittest.main()

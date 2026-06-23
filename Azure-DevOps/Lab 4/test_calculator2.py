    def test_wire_transfer_fee(self):
        """10,000 NGN wire should give a 200 NGN fee (2.0%)"""
        self.assertEqual(calculate_fee(10000, 'wire'), 200.0)
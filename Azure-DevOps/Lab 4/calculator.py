
# calculator.py
# NovaPay Fee Calculator
# Calculates transaction fees for different transfer types.
 
RATES = {
    'domestic':      0.005,   # 0.5%  for domestic transfers
    'international': 0.015,   # 1.5%  for international transfers
}
 
 
def calculate_fee(amount, transfer_type):
    """
    Calculate the fee for a transfer.
 
    Args:
        amount (float):        The transfer amount in NGN.
        transfer_type (str):   Either 'domestic' or 'international'.
 
    Returns:
        float: The fee rounded to 2 decimal places.
 
    Raises:
        ValueError: If amount is not positive, or transfer_type is unknown.
    """
    if not isinstance(amount, (int, float)) or amount <= 0:
        raise ValueError('Amount must be a positive number.')
 
    if transfer_type not in RATES:
        raise ValueError(f'Unknown transfer type: {transfer_type}')
 
    fee = amount * RATES[transfer_type]
    return round(fee, 2)


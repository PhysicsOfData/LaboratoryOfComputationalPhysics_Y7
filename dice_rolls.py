import random

def dice_roll(attempts):
    return [random.randrange(1, 7) for i in range(attempts)]
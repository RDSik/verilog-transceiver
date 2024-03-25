import sys
import numpy as np

# def float_to_binary(float_num):
    # import struct
    # return ''.join(format(c, '08b') for c in struct.pack('!f', float_num))

def float_to_binary(float_num):
    from bitstring import BitArray
    bit_array = BitArray(float=float_num, length=16)
    return bit_array.bin

polarity = sys.argv[1]

if polarity == 'pos':
    file_name = 'sin_value.dat'
    with open(file_name, 'w') as s:
        t = np.arange(0, 2*np.pi-2*np.pi/256, 2*np.pi/256)
        sin_array = np.sin(t)
        for i in range(255):
            s.write(float_to_binary(sin_array[i]) + '\n')
elif polarity == 'neg':
    file_name = polarity + '_sin_value.dat'
    with open(file_name, 'w') as s:
        t = np.arange(0, 2*np.pi-2*np.pi/256, 2*np.pi/256)
        sin_array = -np.sin(t)
        for i in range(255):
            s.write(float_to_binary(sin_array[i]) + '\n')
# 対象: symmetrized_transfer_matrix_on_sectors の CPV2C = CV2PC
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_sector_representation_prelude.sage'))


def sides(data):
    return data['C'] * data['P'] * data['V2'] * data['C'], data['C'] * data['V2'] * data['P'] * data['C']


check_sector_representation_identity("CPV2C = CV2PC", sides)

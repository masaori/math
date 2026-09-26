# 対象: symmetrized_transfer_matrix_on_sectors の WP = BV2BP
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_sector_representation_prelude.sage'))


def sides(data):
    return data['W'] * data['P'], data['B'] * data['V2'] * data['B'] * data['P']


check_sector_representation_identity("WP = BV2BP", sides)

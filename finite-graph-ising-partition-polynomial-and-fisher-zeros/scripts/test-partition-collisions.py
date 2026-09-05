"""Reject incomplete or false finite certificates without changing the stored record."""
from copy import deepcopy
import importlib.util
import json
from pathlib import Path
import unittest

spec = importlib.util.spec_from_file_location('collisions', Path(__file__).with_name('partition-collisions.py'))
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


class CertificateRejection(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.data = json.loads(module.OUTPUT.read_text())

    def test_missing_graph(self):
        data = deepcopy(self.data)
        data['graphs'].pop()
        with self.assertRaises((AssertionError, KeyError)):
            module.verify(data)

    def test_wrong_coefficient(self):
        data = deepcopy(self.data)
        data['graphs'][0]['coefficients'][0] += 1
        with self.assertRaises(AssertionError):
            module.verify(data)

    def test_missing_collision(self):
        data = deepcopy(self.data)
        data['collisions'].pop()
        with self.assertRaises(AssertionError):
            module.verify(data)

    def test_missing_permutation(self):
        data = deepcopy(self.data)
        data['collisions'][0]['nonisomorphism'].pop()
        with self.assertRaises(AssertionError):
            module.verify(data)

    def test_false_mismatch(self):
        data = deepcopy(self.data)
        collision = data['collisions'][0]
        by_key = {g['canonical']: g for g in data['graphs']}
        a, b = (by_key[collision[k]]['adjacency'] for k in ('left', 'right'))
        witness = collision['nonisomorphism'][0]
        p = witness['permutation']
        witness['differing_pair'] = next([u, v] for u in range(len(a)) for v in range(u+1, len(a))
                                         if a[u][v] == b[p[u]][p[v]])
        with self.assertRaises(AssertionError):
            module.verify(data)


if __name__ == '__main__':
    unittest.main()

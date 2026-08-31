import json
import os
import tempfile
import unittest

import sweep_all_checks


class SummarizeResultsTest(unittest.TestCase):
    def summarize_single_record(self, seconds):
        files = [os.path.join(sweep_all_checks.check_root(), 'fake.sage')]
        record = {
            'index': 0,
            'file': 'fake.sage',
            'status': 'PASS',
            'seconds': seconds,
            'detail': '',
            'worker': 0,
        }
        with tempfile.TemporaryDirectory() as outdir:
            result_path = os.path.join(outdir, 'result-0.jsonl')
            with open(result_path, 'w') as fh:
                fh.write(json.dumps(record) + '\n')
            return sweep_all_checks.summarize_results(
                files, outdir, jobs=1, codes=[0], timeout=900)

    def test_accepts_nonnegative_numeric_seconds(self):
        self.assertTrue(self.summarize_single_record(1.25))

    def test_rejects_non_numeric_seconds(self):
        self.assertFalse(self.summarize_single_record('broken'))

    def test_rejects_negative_seconds(self):
        self.assertFalse(self.summarize_single_record(-1))

    def test_rejects_boolean_seconds(self):
        self.assertFalse(self.summarize_single_record(True))


if __name__ == '__main__':
    unittest.main()

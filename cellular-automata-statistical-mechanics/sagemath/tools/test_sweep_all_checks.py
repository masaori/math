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

    def test_rejects_not_a_number_seconds(self):
        self.assertFalse(self.summarize_single_record(float('nan')))

    def test_rejects_infinite_seconds(self):
        self.assertFalse(self.summarize_single_record(float('inf')))


class MalformedLiteralTest(unittest.TestCase):
    def test_rejects_not_a_number_literal_in_result_file(self):
        # json.loads は既定で NaN / Infinity の literal を受理するため、
        # 壊れた結果ファイルがそのまま健全な記録として通らないことを確認する。
        files = [os.path.join(sweep_all_checks.check_root(), 'fake.sage')]
        line = ('{"index": 0, "file": "fake.sage", "status": "PASS", '
                '"seconds": NaN, "detail": "", "worker": 0}')
        with tempfile.TemporaryDirectory() as outdir:
            with open(os.path.join(outdir, 'result-0.jsonl'), 'w') as fh:
                fh.write(line + '\n')
            self.assertFalse(sweep_all_checks.summarize_results(
                files, outdir, jobs=1, codes=[0], timeout=900))


if __name__ == '__main__':
    unittest.main()

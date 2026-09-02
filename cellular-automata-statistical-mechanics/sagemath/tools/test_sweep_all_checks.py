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

    def test_rejects_integer_too_large_for_elapsed_time_arithmetic(self):
        self.assertFalse(self.summarize_single_record(10 ** 400))


class MalformedLiteralTest(unittest.TestCase):
    def test_rejects_boolean_index(self):
        files = [
            os.path.join(sweep_all_checks.check_root(), 'first.sage'),
            os.path.join(sweep_all_checks.check_root(), 'second.sage'),
        ]
        line = ('{"index": true, "file": "second.sage", "status": "PASS", '
                '"seconds": 1, "detail": "", "worker": 0}')
        with tempfile.TemporaryDirectory() as outdir:
            with open(os.path.join(outdir, 'result-0.jsonl'), 'w') as fh:
                fh.write(line + '\n')
            self.assertFalse(sweep_all_checks.summarize_results(
                files, outdir, jobs=1, codes=[0], timeout=900))

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


class EmptySweepTest(unittest.TestCase):
    def test_rejects_sweep_with_no_target_files(self):
        # 対象が 0 本の掃引は、全件成功と同じ出力になったまま成功として通ってしまう。
        with tempfile.TemporaryDirectory() as outdir:
            open(os.path.join(outdir, 'result-0.jsonl'), 'w').close()
            self.assertFalse(sweep_all_checks.summarize_results(
                [], outdir, jobs=1, codes=[0], timeout=900))


class CollectFilesTest(unittest.TestCase):
    """収集が「検算が存在するのに一度も実行されない」状態を黙って通さないことを固定する。"""

    def test_collects_sage_files_under_check_directories(self):
        with tempfile.TemporaryDirectory() as root:
            os.makedirs(os.path.join(root, 'example'))
            path = os.path.join(root, 'example', 'check.sage')
            open(path, 'w').close()
            open(os.path.join(root, 'example', 'overview.md'), 'w').close()
            self.assertEqual(sweep_all_checks.collect_files(root), [path])

    def test_rejects_missing_check_root(self):
        with tempfile.TemporaryDirectory() as root:
            with self.assertRaises(sweep_all_checks.CollectionError):
                sweep_all_checks.collect_files(os.path.join(root, 'missing'))

    def test_rejects_check_root_that_is_a_symlink(self):
        with tempfile.TemporaryDirectory() as base:
            target = os.path.join(base, 'target')
            os.makedirs(os.path.join(target, 'example'))
            open(os.path.join(target, 'example', 'check.sage'), 'w').close()
            link = os.path.join(base, 'link')
            os.symlink(target, link)
            with self.assertRaises(sweep_all_checks.CollectionError):
                sweep_all_checks.collect_files(link)

    def test_rejects_symlinked_check_directory(self):
        # os.walk は symlink のディレクトリへ降りないため、中の検算が一本も走らない。
        with tempfile.TemporaryDirectory() as base:
            target = os.path.join(base, 'target')
            os.makedirs(target)
            open(os.path.join(target, 'check.sage'), 'w').close()
            root = os.path.join(base, 'root')
            os.makedirs(os.path.join(root, 'real'))
            open(os.path.join(root, 'real', 'check.sage'), 'w').close()
            os.symlink(target, os.path.join(root, 'linked'))
            with self.assertRaises(sweep_all_checks.CollectionError):
                sweep_all_checks.collect_files(root)

    def test_rejects_symlinked_sage_file(self):
        # 検算木の外を指す symlink を実行対象として受理してはならない。
        with tempfile.TemporaryDirectory() as base:
            root = os.path.join(base, 'root')
            os.makedirs(root)
            target = os.path.join(base, 'external.sage')
            open(target, 'w').close()
            os.symlink(target, os.path.join(root, 'linked.sage'))
            with self.assertRaises(sweep_all_checks.CollectionError):
                sweep_all_checks.collect_files(root)

    def test_rejects_special_sage_file(self):
        # FIFO などを検算として開くと、実行前の読み取りで停止し得る。
        with tempfile.TemporaryDirectory() as root:
            os.mkfifo(os.path.join(root, 'blocked.sage'))
            with self.assertRaises(sweep_all_checks.CollectionError):
                sweep_all_checks.collect_files(root)

    def test_rejects_unreadable_check_directory(self):
        # os.walk は既定で走査中のエラーを捨てるため、読めないディレクトリの検算が黙って消える。
        with tempfile.TemporaryDirectory() as root:
            locked = os.path.join(root, 'locked')
            os.makedirs(locked)
            open(os.path.join(locked, 'check.sage'), 'w').close()
            os.chmod(locked, 0o000)
            try:
                with self.assertRaises(sweep_all_checks.CollectionError):
                    sweep_all_checks.collect_files(root)
            finally:
                os.chmod(locked, 0o755)

    def test_rejects_check_root_without_any_sage_file(self):
        with tempfile.TemporaryDirectory() as root:
            os.makedirs(os.path.join(root, 'example'))
            open(os.path.join(root, 'example', 'overview.md'), 'w').close()
            with self.assertRaises(sweep_all_checks.CollectionError):
                sweep_all_checks.collect_files(root)


if __name__ == '__main__':
    unittest.main()

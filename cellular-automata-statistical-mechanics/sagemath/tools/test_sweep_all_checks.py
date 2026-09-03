import json
import os
import subprocess
import sys
import tempfile
import unittest

import sweep_all_checks


def summarize_records(files, records):
    with tempfile.TemporaryDirectory() as outdir:
        result_path = os.path.join(outdir, 'result-0.jsonl')
        with open(result_path, 'w') as fh:
            for record in records:
                fh.write(json.dumps(record) + '\n')
        return sweep_all_checks.summarize_results(
            files, outdir, jobs=1, codes=[0], timeout=900)


def pass_record(index, relative_path, assertions=1, seconds=1.0):
    return {
        'index': index,
        'file': relative_path,
        'status': 'PASS',
        'seconds': seconds,
        'assertions': assertions,
        'detail': '',
        'worker': 0,
    }


class SummarizeResultsTest(unittest.TestCase):
    def summarize_single_record(self, seconds):
        files = [os.path.join(sweep_all_checks.check_root(), 'fake.sage')]
        record = {
            'index': 0,
            'file': 'fake.sage',
            'status': 'PASS',
            'seconds': seconds,
            'assertions': 1,
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


class ExecutedAssertionTest(unittest.TestCase):
    """例外を出さずに終わっただけの検算を成功として通さないことを確かめる。"""

    def summarize_one(self, relative_path, **kwargs):
        files = [os.path.join(sweep_all_checks.check_root(), relative_path)]
        return summarize_records(files, [pass_record(0, relative_path, **kwargs)])

    def test_accepts_check_that_executed_an_assertion(self):
        self.assertTrue(self.summarize_one('dir/check_x.sage', assertions=3))

    def test_rejects_check_that_executed_no_assertion(self):
        self.assertFalse(self.summarize_one('dir/check_x.sage', assertions=0))

    def test_accepts_shared_definition_file_without_assertions(self):
        self.assertTrue(self.summarize_one('dir/_common.sage', assertions=0))

    def test_accepts_exploratory_file_without_assertions(self):
        self.assertTrue(self.summarize_one('dir/explore_support.sage', assertions=0))

    def test_rejects_missing_assertion_count(self):
        files = [os.path.join(sweep_all_checks.check_root(), 'dir/check_x.sage')]
        record = pass_record(0, 'dir/check_x.sage')
        del record['assertions']
        self.assertFalse(summarize_records(files, [record]))

    def test_rejects_boolean_assertion_count(self):
        self.assertFalse(self.summarize_one('dir/check_x.sage', assertions=True))

    def test_rejects_negative_assertion_count(self):
        self.assertFalse(self.summarize_one('dir/check_x.sage', assertions=-1))

    def test_rejects_non_integer_assertion_count(self):
        self.assertFalse(self.summarize_one('dir/check_x.sage', assertions=1.5))

    def test_rejects_vacuous_check_even_when_other_checks_assert(self):
        files = [
            os.path.join(sweep_all_checks.check_root(), 'dir/check_x.sage'),
            os.path.join(sweep_all_checks.check_root(), 'dir/check_y.sage'),
        ]
        self.assertFalse(summarize_records(files, [
            pass_record(0, 'dir/check_x.sage', assertions=100),
            pass_record(1, 'dir/check_y.sage', assertions=0),
        ]))


class InstrumentedCodeTest(unittest.TestCase):
    """assert の実行件数が、実際に実行された文だけを数えていることを確かめる。"""

    def run_source(self, source, preparse=lambda text: text):
        with tempfile.TemporaryDirectory() as workdir:
            path = os.path.join(workdir, 'check_sample.sage')
            with open(path, 'w') as fh:
                fh.write(source)
            hits = []
            namespace = {
                sweep_all_checks.ASSERT_HIT_NAME:
                    lambda source_path: hits.append(source_path)
            }
            exec(sweep_all_checks.instrumented_code(path, preparse), namespace)
            return len(hits)

    def test_counts_each_executed_assertion(self):
        self.assertEqual(self.run_source('assert 1 == 1\nassert 2 == 2\n'), 2)

    def test_counts_assertions_executed_in_a_loop(self):
        self.assertEqual(self.run_source('for i in range(5):\n    assert i >= 0\n'), 5)

    def test_does_not_count_assertions_that_never_run(self):
        self.assertEqual(
            self.run_source('def unused():\n    assert False\nassert True\n'), 1)

    def test_counts_nothing_for_a_file_without_assertions(self):
        self.assertEqual(self.run_source('x = 1\n'), 0)

    def test_failing_assertion_still_raises(self):
        with self.assertRaises(AssertionError):
            self.run_source('assert False\n')

    def test_applies_the_given_preparser_before_parsing(self):
        # Sage の前処理を通してから構文木を書き換えることを、置換で代用して確かめる。
        self.assertEqual(
            self.run_source('MARK\n', preparse=lambda text: text.replace('MARK', 'assert True')),
            1)

    def test_keeps_assertions_active_under_python_optimize(self):
        # 起動した python が -O / PYTHONOPTIMIZE のとき、既定の compile は assert 文を
        # 取り除く。差し込んだ計数の呼び出しは残るので、件数が正のまま何も検査しない掃引が
        # 全件 PASS になる。掃引の worker は driver の環境をそのまま引き継ぐため、
        # 最適化水準に依存せず assert が実行されることを別プロセスで固定する。
        with tempfile.TemporaryDirectory() as workdir:
            path = os.path.join(workdir, 'check_sample.sage')
            with open(path, 'w') as fh:
                fh.write('assert False\n')
            program = (
                'import sys\n'
                'sys.path.insert(0, {tools!r})\n'
                'import sweep_all_checks\n'
                'namespace = {{sweep_all_checks.ASSERT_HIT_NAME: lambda source_path: None}}\n'
                'try:\n'
                '    exec(sweep_all_checks.instrumented_code({path!r}, lambda text: text),'
                ' namespace)\n'
                'except AssertionError:\n'
                '    print("RAISED")\n'
                'else:\n'
                '    print("NOT RAISED")\n'
            ).format(tools=os.path.dirname(os.path.abspath(sweep_all_checks.__file__)),
                     path=path)
            completed = subprocess.run(
                [sys.executable, '-O', '-c', program],
                capture_output=True, text=True, check=True)
            self.assertEqual(completed.stdout.strip(), 'RAISED')

    def test_attributes_loaded_assertions_to_the_loaded_file(self):
        with tempfile.TemporaryDirectory() as workdir:
            main_path = os.path.join(workdir, 'check_main.sage')
            common_path = os.path.join(workdir, '_common.sage')
            with open(main_path, 'w') as fh:
                fh.write('value = 1\n')
            with open(common_path, 'w') as fh:
                fh.write('assert True\n')
            hits = {}

            def hit(source_path):
                hits[source_path] = hits.get(source_path, 0) + 1

            namespace = {sweep_all_checks.ASSERT_HIT_NAME: hit}
            exec(sweep_all_checks.instrumented_code(common_path, lambda text: text), namespace)
            exec(sweep_all_checks.instrumented_code(main_path, lambda text: text), namespace)
            self.assertEqual(hits.get(os.path.realpath(common_path)), 1)
            self.assertEqual(hits.get(os.path.realpath(main_path), 0), 0)


class AssertionRequiredTest(unittest.TestCase):
    def test_requires_assertions_from_check_files(self):
        self.assertTrue(sweep_all_checks.assertion_required('dir/check_x.sage'))
        self.assertTrue(sweep_all_checks.assertion_required('_dir/check_x.sage'))

    def test_exempts_shared_definition_files(self):
        self.assertFalse(sweep_all_checks.assertion_required('dir/_common.sage'))
        self.assertFalse(sweep_all_checks.assertion_required('dir/_prelude.sage'))

    def test_exempts_exploratory_files(self):
        self.assertFalse(sweep_all_checks.assertion_required('dir/explore_support.sage'))

    def test_requires_assertions_from_unknown_file_names(self):
        self.assertTrue(sweep_all_checks.assertion_required('dir/helper.sage'))

    def test_uses_the_shared_specification_file(self):
        # 免除の宣言は verify-check-linkage.ts と共有する一つのファイルだけから来る。
        # 掃引の中に免除を書き写すと、片方だけが緩んだときに食い違いが黙って通る。
        exact, prefixes = sweep_all_checks.load_exempt_spec()
        self.assertEqual(exact, frozenset({'_common.sage', '_prelude.sage'}))
        self.assertEqual(prefixes, ('explore_',))


class ExemptSpecTest(unittest.TestCase):
    """免除の宣言が読めないときに、免除を空にして通すのではなく失敗することを固定する。"""

    def _load(self, text):
        with tempfile.TemporaryDirectory() as root:
            path = os.path.join(root, 'assertion-exempt.json')
            with open(path, 'w') as fh:
                fh.write(text)
            return sweep_all_checks.load_exempt_spec(path)

    def test_accepts_a_well_formed_specification(self):
        exact, prefixes = self._load('{"exactNames": ["_common.sage"], "namePrefixes": ["explore_"]}')
        self.assertEqual(exact, frozenset({'_common.sage'}))
        self.assertEqual(prefixes, ('explore_',))

    def test_rejects_broken_json(self):
        with self.assertRaises(sweep_all_checks.ExemptSpecError):
            self._load('{')

    def test_rejects_non_object(self):
        with self.assertRaises(sweep_all_checks.ExemptSpecError):
            self._load('["_common.sage"]')

    def test_rejects_missing_key(self):
        with self.assertRaises(sweep_all_checks.ExemptSpecError):
            self._load('{"exactNames": []}')

    def test_rejects_non_string_element(self):
        with self.assertRaises(sweep_all_checks.ExemptSpecError):
            self._load('{"exactNames": [1], "namePrefixes": []}')

    def test_rejects_empty_prefix_that_exempts_every_name(self):
        with self.assertRaises(sweep_all_checks.ExemptSpecError):
            self._load('{"exactNames": [], "namePrefixes": [""]}')

    def test_rejects_exact_name_that_is_not_a_sage_file(self):
        with self.assertRaises(sweep_all_checks.ExemptSpecError):
            self._load('{"exactNames": ["_common"], "namePrefixes": []}')

    def test_rejects_exact_name_that_matches_the_check_convention(self):
        # 検算本体の基底名は例外なく `check_` で始まる。そこへ一致する免除は、
        # 覆われた検算が assert を一つも要求されない状態を作る。
        with self.assertRaises(sweep_all_checks.ExemptSpecError):
            self._load('{"exactNames": ["check_x.sage"], "namePrefixes": []}')

    def test_rejects_prefix_that_covers_every_check_file(self):
        with self.assertRaises(sweep_all_checks.ExemptSpecError):
            self._load('{"exactNames": [], "namePrefixes": ["check_"]}')

    def test_rejects_prefix_that_covers_some_check_files(self):
        # ディレクトリごとの対応検査は「全ての .sage が免除」でしか落ちないため、
        # 一部だけを覆う接頭辞は両方の入口を黙って通る。宣言だけで弾く。
        with self.assertRaises(sweep_all_checks.ExemptSpecError):
            self._load('{"exactNames": [], "namePrefixes": ["check_a"]}')

    def test_rejects_prefix_that_is_a_proper_prefix_of_the_check_convention(self):
        with self.assertRaises(sweep_all_checks.ExemptSpecError):
            self._load('{"exactNames": [], "namePrefixes": ["ch"]}')

    def test_rejects_missing_specification_file(self):
        with tempfile.TemporaryDirectory() as root:
            with self.assertRaises(sweep_all_checks.ExemptSpecError):
                sweep_all_checks.load_exempt_spec(os.path.join(root, 'absent.json'))

    def test_rejects_specification_file_that_is_a_symlink(self):
        with tempfile.TemporaryDirectory() as root:
            real = os.path.join(root, 'real.json')
            with open(real, 'w') as fh:
                fh.write('{"exactNames": [], "namePrefixes": []}')
            link = os.path.join(root, 'assertion-exempt.json')
            os.symlink(real, link)
            with self.assertRaises(sweep_all_checks.ExemptSpecError):
                sweep_all_checks.load_exempt_spec(link)


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

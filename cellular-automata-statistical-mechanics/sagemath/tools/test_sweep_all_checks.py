import ast
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

    def run_with_recorder(self, source, preparse=lambda text: text):
        # 掃引の worker と同じ記録経路（AssertionRecorder）で走らせる。
        with tempfile.TemporaryDirectory() as workdir:
            path = os.path.join(workdir, 'check_sample.sage')
            with open(path, 'w') as fh:
                fh.write(source)
            recorder = sweep_all_checks.AssertionRecorder('token-for-the-test')
            namespace = {'__file__': path}
            namespace = recorder.install(namespace)
            exec(sweep_all_checks.instrumented_code(path, preparse, recorder.token), namespace)
            return recorder, namespace, os.path.realpath(path)

    def run_source_counts(self, source, preparse=lambda text: text):
        recorder, _namespace, _path = self.run_with_recorder(source, preparse)
        return sum(recorder.hits.values()), sum(recorder.failures.values())

    def run_verdict(self, source):
        recorder, namespace, _path = self.run_with_recorder(source)
        return recorder.verdict(namespace)

    def run_source(self, source, preparse=lambda text: text):
        hits, failures = self.run_source_counts(source, preparse)
        self.assertEqual(failures, 0)
        return hits

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
                'recorder = sweep_all_checks.AssertionRecorder("token")\n'
                'namespace = {{}}\n'
                'namespace = recorder.install(namespace)\n'
                'try:\n'
                '    exec(sweep_all_checks.instrumented_code({path!r}, lambda text: text,'
                ' recorder.token), namespace)\n'
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
            recorder = sweep_all_checks.AssertionRecorder('token-for-the-test')
            namespace = {}
            namespace = recorder.install(namespace)
            exec(sweep_all_checks.instrumented_code(
                common_path, lambda text: text, recorder.token), namespace)
            exec(sweep_all_checks.instrumented_code(
                main_path, lambda text: text, recorder.token), namespace)
            self.assertEqual(recorder.hits.get(os.path.realpath(common_path)), 1)
            self.assertEqual(recorder.hits.get(os.path.realpath(main_path), 0), 0)

    def test_records_failure_swallowed_around_an_indirect_call(self):
        source = (
            'def check():\n    assert False\n'
            'try:\n    check()\nexcept AssertionError:\n    pass\n'
            'assert True\n')
        self.assertEqual(self.run_source_counts(source), (2, 1))

    def test_records_failure_swallowed_by_context_manager(self):
        source = (
            'from contextlib import suppress\n'
            'with suppress(AssertionError):\n    assert False\n'
            'assert True\n')
        self.assertEqual(self.run_source_counts(source), (2, 1))

    def test_records_failure_suppressed_by_finally_return(self):
        source = (
            'def check():\n'
            '    try:\n        assert False\n'
            '    finally:\n        return None\n'
            'check()\nassert True\n')
        self.assertEqual(self.run_source_counts(source), (2, 1))


class AssertionRecorderTest(unittest.TestCase):
    """記録の経路そのものを検算ファイルが改変できないことを確かめる。"""

    def run_verdict(self, source):
        with tempfile.TemporaryDirectory() as workdir:
            path = os.path.join(workdir, 'check_sample.sage')
            with open(path, 'w') as fh:
                fh.write(source)
            recorder = sweep_all_checks.AssertionRecorder(
                'token-for-the-test', os.path.join(workdir, 'failures.log'))
            namespace = {'__file__': path}
            namespace = recorder.install(namespace)
            exec(sweep_all_checks.instrumented_code(path, lambda text: text, recorder.token),
                 namespace)
            return recorder, recorder.verdict(namespace)

    def test_accepts_a_check_whose_assertions_all_hold(self):
        recorder, (recorded, reason) = self.run_verdict('assert 1 == 1\n')
        self.assertTrue(recorded)
        self.assertEqual(reason, '')
        self.assertEqual(sum(recorder.hits.values()), 1)

    def test_rejects_a_check_that_rebinds_the_failure_recorder(self):
        # 記録先を自分で束ね直せば、握り潰した失敗は記録されない。件数は正のままなので、
        # 前 tick の実装ではこの検算が PASS になった（実測で件数 1・失敗 0）。
        recorder, (recorded, reason) = self.run_verdict(
            '__sweep_assert_failure__ = lambda *args: None\n'
            'def check():\n    assert False\n'
            'try:\n    check()\nexcept AssertionError:\n    pass\n'
            'assert True\n')
        # 守られた名前空間は束ね直しをその場で拒むので、記録器は本物のまま失敗も数える。
        self.assertEqual(sum(recorder.failures.values()), 1)
        self.assertFalse(recorded)
        self.assertIn('rebound', reason)

    def test_rejects_a_check_that_restores_the_recorder_after_rebinding_it(self):
        # 実行の終わりに元へ戻せば、実行後の同一性照合だけでは束ね直しを検出できない。
        # 実測でも、守りを入れる前の実装はこの検算を PASS・件数 1 で受理した。
        recorder, (recorded, reason) = self.run_verdict(
            'assert 1 == 1\n'
            'saved_hit = __sweep_assert_hit__\n'
            'saved_failure = __sweep_assert_failure__\n'
            '__sweep_assert_hit__ = lambda *args: None\n'
            '__sweep_assert_failure__ = lambda *args: None\n'
            'def check():\n    assert 1 == 2\n'
            'try:\n    check()\nexcept Exception:\n    pass\n'
            '__sweep_assert_hit__ = saved_hit\n'
            '__sweep_assert_failure__ = saved_failure\n')
        self.assertFalse(recorded)
        self.assertIn('rebound', reason)
        self.assertEqual(sum(recorder.failures.values()), 1)

    def test_rejects_a_check_that_deletes_and_restores_the_hit_recorder(self):
        recorder, (recorded, reason) = self.run_verdict(
            'assert 1 == 1\n'
            'saved_hit = __sweep_assert_hit__\n'
            'del __sweep_assert_hit__\n'
            '__sweep_assert_hit__ = saved_hit\n'
            'assert 2 == 2\n')
        self.assertFalse(recorded)
        self.assertIn('deleted', reason)
        # 削除も拒むので、以後の assert も数え落とさない。
        self.assertEqual(sum(recorder.hits.values()), 2)

    def test_namespace_guard_is_effective_on_this_python(self):
        # 守りは STORE_GLOBAL / DELETE_GLOBAL が dict 派生の __setitem__ / __delitem__ を
        # 通ることに依存する。依存が崩れた処理系で黙って守りが外れないことを固定する。
        sweep_all_checks.verify_namespace_guard()

    def test_check_can_still_bind_its_own_names(self):
        recorder, (recorded, reason) = self.run_verdict(
            'value = 1\nassert value == 1\ndel value\n')
        self.assertTrue(recorded)
        self.assertEqual(reason, '')
        self.assertEqual(sum(recorder.hits.values()), 1)

    def test_rejects_a_check_that_deletes_the_hit_recorder(self):
        _recorder, (recorded, reason) = self.run_verdict(
            'assert True\ndel __sweep_assert_hit__\n')
        self.assertFalse(recorded)
        self.assertIn('deleted', reason)

    def test_rejects_a_fabricated_hit_from_a_check_without_assertions(self):
        # assert を一つも書かず、差し込んだ計数の関数を直接呼ぶだけで件数を正にできた。
        recorder, (recorded, reason) = self.run_verdict(
            'import os\n'
            '__sweep_assert_hit__("guessed", os.path.realpath(__file__))\n')
        self.assertEqual(sum(recorder.hits.values()), 0)
        self.assertFalse(recorded)
        self.assertIn('outside an assert statement', reason)

    def test_rejects_a_fabricated_failure_call(self):
        _recorder, (recorded, reason) = self.run_verdict(
            'import os\n'
            'assert True\n'
            '__sweep_assert_failure__("guessed", os.path.realpath(__file__))\n')
        self.assertFalse(recorded)
        self.assertIn('outside an assert statement', reason)

    def test_rejects_a_check_that_clears_the_failure_record_through_the_recorder(self):
        # 名前空間へ置いた束縛メソッドの __self__ から記録器へ辿れる。実測では記憶上の
        # 失敗を消すだけで PASS になった。追記ファイルに残った失敗で判定する。
        recorder, (recorded, reason) = self.run_verdict(
            'r = __sweep_assert_hit__.__self__\n'
            'def check():\n    assert False\n'
            'try:\n    check()\nexcept AssertionError:\n    pass\n'
            'r.failures.clear()\nassert True\n')
        # 記憶上の記録は消えている。判定は追記ファイルに残った 1 件だけを根拠にしている。
        self.assertEqual(sum(recorder.failures.values()), 0)
        self.assertFalse(recorded)
        self.assertIn('false 1 time(s)', reason)
        self.assertIn('swallowed', reason)

    def test_instruments_every_real_check_file(self):
        # 記録経路の変更が実在の検算 336 本の書き換えを壊していないことを、掃引と同じ
        # 収集経路で確かめる（構文木の書き換えとコンパイルまで。実行はしない）。
        instrumented = 0
        for path in sweep_all_checks.collect_files():
            try:
                sweep_all_checks.instrumented_code(path, lambda text: text, 'token')
            except SyntaxError:
                continue  # Sage の前処理を要する書き方は掃引の実行時に判定される
            instrumented += 1
        self.assertGreater(instrumented, 0)

    def test_reports_a_swallowed_failure_when_the_recorder_is_intact(self):
        _recorder, (recorded, reason) = self.run_verdict(
            'def check():\n    assert False\n'
            'try:\n    check()\nexcept AssertionError:\n    pass\n'
            'assert True\n')
        self.assertFalse(recorded)
        self.assertIn('swallowed', reason)


class SwallowedAssertionTest(unittest.TestCase):
    """assert の失敗を検算ファイル自身が握り潰す書き方を、実行前に拒むことを確かめる。"""

    def instrument(self, source):
        with tempfile.TemporaryDirectory() as workdir:
            path = os.path.join(workdir, 'check_sample.sage')
            with open(path, 'w') as fh:
                fh.write(source)
            return sweep_all_checks.instrumented_code(
                path, lambda text: text, 'token-for-the-test')

    def assert_rejected(self, source):
        with self.assertRaises(sweep_all_checks.SwallowedAssertionError):
            self.instrument(source)

    def assert_accepted(self, source):
        self.instrument(source)

    def test_rejects_assertion_error_handler(self):
        # 件数だけを見る掃引では、この書き方は「assert を 1 回実行した PASS」になる。
        self.assert_rejected('try:\n    assert False\nexcept AssertionError:\n    pass\n')

    def test_rejects_broad_exception_handler(self):
        self.assert_rejected('try:\n    assert False\nexcept Exception:\n    pass\n')

    def test_rejects_base_exception_handler(self):
        self.assert_rejected('try:\n    assert False\nexcept BaseException:\n    pass\n')

    def test_rejects_bare_handler(self):
        self.assert_rejected('try:\n    assert False\nexcept:\n    pass\n')

    def test_rejects_handler_tuple_that_includes_assertion_error(self):
        self.assert_rejected(
            'try:\n    assert False\nexcept (ValueError, AssertionError):\n    pass\n')

    def test_rejects_handler_that_cannot_be_judged_by_name(self):
        # 変数・属性・呼び出しで指定された例外型は、捕まえうるものとして扱う（fail-closed）。
        self.assert_rejected('E = Exception\ntry:\n    assert False\nexcept E:\n    pass\n')

    def test_rejects_assertion_nested_deeper_in_the_try_body(self):
        self.assert_rejected(
            'try:\n    for i in range(3):\n        assert False\nexcept Exception:\n    pass\n')

    def test_accepts_handler_that_cannot_catch_assertion_error(self):
        self.assert_accepted('try:\n    assert True\nexcept ValueError:\n    pass\n')

    def test_accepts_assertion_outside_the_try_body(self):
        # 例外の送出を確かめる書き方は、assert が try の本体に無いので通る。
        self.assert_accepted(
            'def f():\n    raise ValueError\n'
            'try:\n    f()\nexcept ValueError:\n    pass\nelse:\n    assert False\n')

    def test_accepts_try_without_any_assertion(self):
        self.assert_accepted('try:\n    x = 1\nexcept Exception:\n    pass\n')

    def test_real_check_files_satisfy_the_rule(self):
        # 実在の検算 336 本がこの規則に触れないこと（規則の導入が既存を壊さないこと）を、
        # 掃引と同じ収集経路で確かめる。
        checked = 0
        for path in sweep_all_checks.collect_files():
            with open(path) as fh:
                source = fh.read()
            try:
                tree = ast.parse(source, filename=path)
            except SyntaxError:
                continue  # Sage の前処理を要する書き方は掃引の実行時に判定される
            sweep_all_checks.reject_swallowed_assertions(tree, path)
            checked += 1
        self.assertGreater(checked, 0)


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

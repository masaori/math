#!/usr/bin/env python3
"""プログラミングによる検証: 実際の起動部分へ偽 CLI を渡し、モデル・失敗伝播を判定する。"""

import json
import os
from pathlib import Path
import re
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parent.parent
TICKS = [
    "cellular-automata-statistical-mechanics/scripts/auto-loop-tick.sh",
    "scripts/research-supervision/supervisor-tick.sh",
    "exact-solution-of-2d-ising-model-lambda/scripts/auto-loop-tick.sh",
    "countable-core-of-3d-ising/scripts/auto-loop-tick.sh",
    "countable-ising-on-hyperbolic-surfaces/scripts/auto-loop-tick.sh",
    "finite-graph-ising-partition-polynomial-and-fisher-zeros/scripts/auto-loop-tick.sh",
]


class TickModels(unittest.TestCase):
    def test_actual_invocation_and_exit_status(self):
        for tick in TICKS:
            source = (ROOT / tick).read_text()
            assignment = re.findall(r'^CODEX_TICK_HOME=.*$', source, re.M)
            self.assertEqual(len(assignment), 1, tick)
            invocation = re.findall(r'^set \+e\n(.*?)^set -e$', source, re.M | re.S)
            self.assertEqual(len(invocation), 1, tick)
            self.assertNotRegex(source, r"claude\s+-p|run_claude|gpt-5\.", tick)
            self.assertNotIn("BLOCKED_MARK", source, tick)
            self.assertRegex(source, r"PROMPT=(?:\$\(cat <<'EOF'\n|')\[\[AI_AGENT_MESSAGE\]\]\n", tick)
            for code in (0, 42, 124, 137):
                with self.subTest(tick=tick, exit_status=code), tempfile.TemporaryDirectory() as tmp:
                    work = Path(tmp)
                    cli = work / "timeout"
                    cli.write_text(
                        "#!/usr/bin/env python3\n"
                        "import json, os, sys\n"
                        "from pathlib import Path\n"
                        "with Path(os.environ['CAPTURE']).open('a') as out:\n"
                        "    out.write(json.dumps({'argv': sys.argv[1:], 'home': os.environ['CODEX_HOME'], "
                        "'prompt': sys.stdin.read()}) + '\\n')\n"
                        "raise SystemExit(int(os.environ['TEST_EXIT']))\n"
                    )
                    cli.chmod(0o755)
                    env = dict(os.environ, HOME=tmp, CODEX_HOME=str(work / "selected account"),
                               PATH=tmp + os.pathsep + os.environ["PATH"],
                               CAPTURE=str(work / "calls.jsonl"), TEST_EXIT=str(code),
                               LOG_FILE=str(work / "run.log"), TICK_TIMEOUT_SECONDS="17", LOOP_WORKTREE=tmp,
                               PROMPT="[[AI_AGENT_MESSAGE]]\nモデル起動の試験")
                    result = subprocess.run(
                        ["bash", "-c", "set -euo pipefail\n" + assignment[0] +
                         "\nset +e\n" + invocation[0] + "set -e\nexit \"$status\""],
                        env=env, capture_output=True, text=True, timeout=10,
                    )
                    self.assertEqual(result.returncode, code, result.stderr)
                    calls = [json.loads(line) for line in (work / "calls.jsonl").read_text().splitlines()]
                    self.assertEqual(len(calls), 1, "失敗後も別の呼び出しをしてはならない")
                    self.assertEqual(calls[0]["home"], env["CODEX_HOME"])
                    self.assertEqual(calls[0]["prompt"], env["PROMPT"])
                    self.assertEqual(calls[0]["argv"], [
                        "-k", "60", "17", "codex", "exec", "-m", "gpt-6-astra",
                        "-c", "model_reasoning_effort=medium",
                        "--dangerously-bypass-approvals-and-sandbox",
                        *(["-C", tmp] if tick.startswith(("countable-ising-on-hyperbolic-surfaces/", "finite-graph-ising-partition-polynomial-and-fisher-zeros/")) else []), "-",
                    ])

    def test_missing_or_empty_account_fails_before_invocation(self):
        for tick in TICKS:
            source = (ROOT / tick).read_text()
            assignment = re.findall(r'^CODEX_TICK_HOME=.*$', source, re.M)
            self.assertEqual(len(assignment), 1, tick)
            for value in (None, ""):
                with self.subTest(tick=tick, account=value), tempfile.TemporaryDirectory() as tmp:
                    env = dict(os.environ, HOME=tmp)
                    env.pop("CODEX_HOME", None)
                    if value is not None:
                        env["CODEX_HOME"] = value
                    marker = Path(tmp) / "invoked"
                    result = subprocess.run(
                        ["bash", "-c", "set -eu\n" + assignment[0] + '\ntouch "$HOME/invoked"'],
                        env=env, capture_output=True, text=True, timeout=10,
                    )
                    self.assertNotEqual(result.returncode, 0)
                    self.assertIn("CODEX_HOME", result.stderr)
                    self.assertFalse(marker.exists())

    def test_paused_research_does_not_invoke_cli(self):
        with tempfile.TemporaryDirectory() as tmp:
            project = Path(tmp)
            (project / "scripts").mkdir()
            (project / "docs/tasks").mkdir(parents=True)
            (project / "docs/tasks/auto-loop-paused.md").write_text("停止中")
            script = project / "scripts/auto-loop-tick.sh"
            script.write_text((ROOT / TICKS[3]).read_text())
            result = subprocess.run(["bash", str(script)], capture_output=True, text=True, timeout=10)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(result.stdout.strip(), "3次元 Ising の自動 tick は人間指示により停止中である。")


if __name__ == "__main__":
    unittest.main()

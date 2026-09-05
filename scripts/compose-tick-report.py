#!/usr/bin/env python3
"""自動研究ループの Slack 報告本文を、各プロジェクトの正本から組み立てる（全プロジェクト共通）。

報告は四項目——**最終ゴール / 最終ゴールに対する現在地 / 今回の一歩 / 次の一手**——を必ず含む。
2026-09-05 に、Λ 版の 2 次元 Ising とセルオートマトン統計力学の報告が「今回の一歩」しか
書いていなかったため、人間から「今どういう状況か・ゴール設定が分からない」と指摘された。

固定文をここへ写さない。ゴールは README から、現在地と次の一手は進捗の正本（状態台帳）の
表から毎回抽出するので、正本が変われば報告も変わる。**抽出できない項目が 1 つでもあれば
何も出力せず異常終了する**（空欄のまま報告しない＝fail-closed）。

どのファイルのどの節を読むかは、プロジェクトごとの宣言
`<project>/docs/tasks/tick-report-sources.json` に置く。書式は次のとおり。

    {
      "readme": "README.md",
      "goalSection": "ゴール",            // 省略時は README の冒頭（最初の見出しの前）
      "progress": "docs/tasks/auto-loop-state.md",
      "queueSection": "現在地",           // 残作業の表を含む節
      "doneMarkers": ["done", "完了", "済"],
      "titleColumns": [0, 1]
    }

使い方: compose-tick-report.py <プロジェクトディレクトリ> <今回の一歩の一文>
"""
import json
import os
import re
import sys

FIXED_DONE_MARKERS = ("done", "完了", "済", "DONE")

# 報告は人間が読む。TeX の記法は日本語へ開いてから渡す（記号の羅列を人へ見せない）。
LATEX_WORDS = (                              # 長い綴りから先に置換する（部分一致で壊れるため）
    (r"\overline{\mathbb{Q}}", "代数的数"),
    (r"\mathbb{Z}[x]", "整係数多項式"),
    (r"\mathbb{N}", "自然数"), (r"\mathbb{Z}", "整数"), (r"\mathbb{Q}", "有理数"),
    (r"\mathbb{R}", "実数"), (r"\mathbb{C}", "複素数"),
    (r"\Lambda", "対数順序群"), (r"\subset", "⊂"),
)


def die(reason: str) -> None:
    print(f"報告本文を組み立てられない: {reason}", file=sys.stderr)
    raise SystemExit(2)


def read(path: str) -> str:
    try:
        return open(path, encoding="utf-8").read()
    except OSError as exc:
        die(f"{path} を読めない ({exc})")


def tidy(text: str) -> str:
    return re.sub(r"\s+", " ", text.replace("**", "")).strip()


def plain(text: str) -> str:
    """数式混じりの原文を、人間が読める日本語へ開く。"""
    for tex, word in LATEX_WORDS:
        text = text.replace(tex, word)
    text = re.sub(r"\\[a-zA-Z]+", "", text)      # 残りの制御綴りは落とす
    text = text.replace("$", "").replace("{", "").replace("}", "")
    text = text.replace("実数/複素数", "実数・複素数")
    text = tidy(text)
    # 原文の折り返しが日本語の途中に空白を残すので詰める（人が読む文にしてから渡す）。
    return re.sub(r"(?<=[^\x00-\x7F]) (?=[^\x00-\x7F])", "", text)


def section(text: str, heading: str, path: str) -> str:
    """指定した見出しの節（次の同レベル以上の見出しの手前まで）。"""
    opened = re.search(rf"^(#{{2,3}}) {re.escape(heading)}\s*$", text, re.M)
    if opened is None:
        die(f"{path} に「{heading}」の節が無い")
    level = len(opened.group(1))
    rest = text[opened.end():]
    # 節は「同じか上の水準の見出し」まで。下位の小見出し（### 等）はこの節の中身である。
    closed = re.search(rf"^#{{1,{level}}} ", rest, re.M)
    body = (rest[: closed.start()] if closed else rest).strip()
    if not body:
        die(f"{path} の「{heading}」の節が空")
    return body


def preamble(text: str, path: str) -> str:
    """最初の見出しの前（README の導入）。"""
    body = re.split(r"^## ", text, maxsplit=1, flags=re.M)[0]
    body = re.sub(r"^# .*\n", "", body, count=1)
    if not body.strip():
        die(f"{path} の冒頭が空")
    return body


def final_goal(readme_text: str, path: str, heading) -> str:
    """README のゴール文＝強調された段落。プロジェクトの最終ゴールの正本。"""
    body = section(readme_text, heading, path) if heading else preamble(readme_text, path)
    # 強調を含む最初の段落をそのまま使う（強調だけを切り出すと、ゴールが二文に分かれて
    # 書かれているプロジェクトで後半が落ちる）。
    paragraphs = [p for p in re.split(r"\n\s*\n", body) if p.strip()]
    # 強調された段落があればそれがゴール文。強調で書いていないプロジェクトは節の冒頭段落を使う。
    paragraph = next((p for p in paragraphs if "**" in p), paragraphs[0] if paragraphs else None)
    if paragraph is None:
        die(f"{path} の{'「' + heading + '」節' if heading else '冒頭'}にゴール文が無い")
    goal = plain(paragraph)
    if not goal:
        die(f"{path} のゴール文が空")
    return goal


def queue_rows(progress_text: str, path: str, heading: str, done_markers, title_columns):
    """進捗の正本にある残作業表の行を、上から順に（題名, 完了か）で返す。

    表のセルには $|E|$ のような数式が入り、列区切りの縦棒と区別できない。そのため
    「どの列が状態か」を位置で決めず、**どのセルかが完了の印で始まるか**で判定する。
    """
    body = section(progress_text, heading, path)
    rows = []
    for line in body.splitlines():
        line = line.strip()
        if not line.startswith("|") or not line.endswith("|"):
            continue
        cells = [c.strip() for c in line.strip("|").split("|")]
        if len(cells) < 2:
            continue
        if set("".join(cells)) <= set("-: "):          # 区切り行
            continue
        if cells[0] in ("章", "層", "セクション", "作業", ""):   # 見出し行
            continue
        title = "／".join(
            plain(cells[i]) for i in title_columns if i < len(cells) and cells[i]
        )
        if not title:
            continue
        # 「done（2026-09-03 …）」のように印へ註釈が続く書き方もあるので前方一致で見る。
        done = any(c.startswith(m) for c in cells for m in done_markers)
        rows.append((title, done))
    if not rows:
        die(f"{path} の「{heading}」節に残作業の表が無い")
    return rows


def whereabouts(rows) -> str:
    remaining = [r for r in rows if not r[1]]
    if not remaining:
        return (
            f"表に挙げた {len(rows)} 件はすべて完了の印が付いている"
            "（次の的は台帳へ立て直す段階）。"
        )
    done = len(rows) - len(remaining)
    return (
        f"現在の作業表に残る作業は {len(remaining)} 件"
        f"（表に挙げた {len(rows)} 件のうち完了は {done} 件）。"
        f"いま取り組んでいるのは「{remaining[0][0]}」。"
    )


def next_move(rows) -> str:
    remaining = [r for r in rows if not r[1]]
    if not remaining:
        # 表が全て完了なのは正常な状態（次の的を立て直す段階）。ここは落とさない。
        # 落とすのは節や表そのものが無いとき＝正本の構造が壊れたときだけである。
        return "残作業の表に未完了の行が無い。次に何を進めるかを台帳へ立てる。"
    return f"「{remaining[0][0]}」を進める。"


def load_config(project_dir: str):
    path = os.path.join(project_dir, "docs/tasks/tick-report-sources.json")
    try:
        config = json.loads(open(path, encoding="utf-8").read())
    except OSError as exc:
        die(f"報告の出どころの宣言を読めない ({exc})")
    except json.JSONDecodeError as exc:
        die(f"{path} が JSON として読めない ({exc})")
    for key in ("readme", "progress", "queueSection"):
        if not config.get(key):
            die(f"{path} に {key} が無い")
    return config


def main() -> None:
    if len(sys.argv) != 3:
        die("引数はプロジェクトディレクトリと今回の一歩の二つ")
    project_dir, step = sys.argv[1], tidy(sys.argv[2])
    if not step:
        die("今回の一歩が空")
    config = load_config(project_dir)
    readme_path = os.path.join(project_dir, config["readme"])
    progress_path = os.path.join(project_dir, config["progress"])
    rows = queue_rows(
        read(progress_path), progress_path, config["queueSection"],
        tuple(config.get("doneMarkers", FIXED_DONE_MARKERS)),
        tuple(config.get("titleColumns", (0, 1))),
    )
    print(f"最終ゴール: {final_goal(read(readme_path), readme_path, config.get('goalSection'))}")
    print(f"現在地: {whereabouts(rows)}")
    print(f"今回の一歩: {step}")
    print(f"次の一手: {next_move(rows)}")


if __name__ == "__main__":
    main()

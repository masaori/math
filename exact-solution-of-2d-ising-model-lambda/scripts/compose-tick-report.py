#!/usr/bin/env python3
"""自動ループの Slack 報告本文（四項目）を、README と状態台帳から組み立てる。

四項目は「最終ゴール」「最終ゴールに対する現在地」「今回の一歩」「次の一手」。
固定文をここへ写さない。README の「ゴール」節と台帳の「現在地」「残っているもの」の表から
毎回抽出するので、正本が変われば報告も変わる。抽出できない項目が 1 つでもあれば
何も出力せず異常終了する（空欄のまま報告しない＝fail-closed）。

使い方: compose-tick-report.py <README.md> <auto-loop-state.md> <今回の一歩の一文>
"""
import re
import sys


def die(reason: str) -> None:
    print(f"報告本文を組み立てられない: {reason}", file=sys.stderr)
    raise SystemExit(2)


def read(path: str) -> str:
    try:
        return open(path, encoding="utf-8").read()
    except OSError as exc:
        die(f"{path} を読めない ({exc})")


def section(text: str, heading: str, path: str) -> str:
    found = re.search(rf"^## {re.escape(heading)}\n(.*?)(?=^## |\Z)", text, re.S | re.M)
    if found is None:
        die(f"{path} に「{heading}」の節が無い")
    body = found.group(1).strip()
    if not body:
        die(f"{path} の「{heading}」の節が空")
    return body


# 台帳の表は $|E|$ のような数式を含み、セル区切りの縦棒と区別できない。
# そのため状態列は「未着手」「保留」「完了」の決め打ちの語に一致するときだけ状態とみなす。
FIXED_STATES = ("未着手", "保留", "完了")

# 報告は人間が読む。TeX の記法は日本語へ開いてから渡す（記号の羅列を人へ見せない）。
LATEX_WORDS = (                              # 長い綴りから先に置換する（部分一致で壊れるため）
    (r"\overline{\mathbb{Q}}", "代数的数"),
    (r"\mathbb{Z}[x]", "整係数多項式"),
    (r"\mathbb{N}", "自然数"), (r"\mathbb{Z}", "整数"), (r"\mathbb{Q}", "有理数"),
    (r"\mathbb{R}", "実数"), (r"\mathbb{C}", "複素数"),
    (r"\Lambda", "対数順序群"), (r"\subset", "⊂"),
)


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


def final_goal(readme_text: str, path: str) -> str:
    """README「ゴール」節の冒頭の強調段落＝プロジェクトの最終ゴール。"""
    body = section(readme_text, "ゴール", path)
    bold = re.search(r"\*\*(.+?)\*\*", body, re.S)
    if bold is None:
        die(f"{path} の「ゴール」節に強調されたゴール文が無い")
    goal = tidy(bold.group(1))
    if not goal:
        die(f"{path} の「ゴール」節のゴール文が空")
    return plain(goal)


def remaining_rows(state_text: str, path: str):
    """台帳「残っているもの」の表の行（章・セクション・状態）。先頭行が次に進める的。"""
    body = section(state_text, "現在地", path)
    rows = []
    for line in body.splitlines():
        line = line.strip()
        if not line.startswith("|") or not line.endswith("|"):
            continue
        cells = [c.strip() for c in line.strip("|").split("|")]
        if len(cells) < 3:
            continue
        if cells[0] in ("章", "") or set(cells[0]) <= set("-: "):
            continue
        state = cells[2] if cells[2] in FIXED_STATES else "着手済み"
        rows.append((tidy(cells[0]), tidy(cells[1]), state))
    if not rows:
        die(f"{path} の「現在地」節に残作業の表が無い")
    return rows


def whereabouts(rows) -> str:
    pending = sum(1 for r in rows if r[2] == "未着手")
    held = sum(1 for r in rows if r[2] == "保留")
    ongoing = len(rows) - pending - held
    chapter, sec, _ = rows[0]
    return (
        f"最終ゴールまでに残る作業は {len(rows)} 件"
        f"（着手済みで継続中 {ongoing} 件・未着手 {pending} 件・保留 {held} 件）。"
        f"いま取り組んでいるのは章「{chapter}」の「{sec}」。"
    )


def next_move(rows) -> str:
    chapter, sec, state = rows[0]
    return f"章「{chapter}」の「{sec}」を進める（現在の状態は{state}）。"


def main() -> None:
    if len(sys.argv) != 4:
        die("引数は README・状態台帳・今回の一歩の三つ")
    readme_path, state_path, step = sys.argv[1], sys.argv[2], sys.argv[3]
    step = tidy(step)
    if not step:
        die("今回の一歩が空")
    readme_text, state_text = read(readme_path), read(state_path)
    rows = remaining_rows(state_text, state_path)
    print(f"最終ゴール: {final_goal(readme_text, readme_path)}")
    print(f"現在地: {whereabouts(rows)}")
    print(f"今回の一歩: {step}")
    print(f"次の一手: {next_move(rows)}")


if __name__ == "__main__":
    main()

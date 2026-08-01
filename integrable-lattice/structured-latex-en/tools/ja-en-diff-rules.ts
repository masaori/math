/**
 * **日英で数式に差が出てよい理由を「規則」として持つ。**
 *
 * なぜこれが要るか（cycle 21 で実地に露見した検査の穴）:
 * `ja-en-exceptions.ts` は当初「ブロック id → 理由の文字列」だった。登録すると
 * **そのブロックの数式の照合が丸ごと免除される**。cycle 21 step 4 は、`\text{}` の中の日本語を
 * 英訳するために登録済みだったブロックで、整形の途中に**インライン数式ノードを 11 個落とし**
 * （`\ell` 3 個、`\ell=2` 4 個、`0` `2` `n=1` `n\ge2` `\le3` 各 1 個）、
 * それが日英対応検証をすり抜けた。**例外表への登録は検査に穴を開ける操作である。**
 *
 * そこで免除の単位を「ブロック」から「**差分 1 つ**」へ落とす。ブロックは
 * 「どの種類の差なら出てよいか」を宣言するだけで、その規則で説明できない差が 1 つでも残れば違反になる。
 * 11 個の落とした数式は、下のどの規則でも説明できない（対応する英語側の数式が存在しない）ので、
 * この形なら必ず違反として出る（`verify-ja-en-detection-test.ts` が再現データで確かめている）。
 */

import {
  maskTextMacroBodies,
  meaningfulTokens,
  normalizeSpaces,
  sameMultiset,
} from "../../structured-latex/tools/tex-atoms.ts";

export type DiffRule =
  /**
   * `\text{}` 系の**中身だけ**が英訳されている。中身を伏せると日英で 1 文字も違わないこと、
   * が条件である。記号の増減も並べ替えも許さない。
   */
  | "text-body-translated"
  /**
   * `\text{}` 系の中身が日本語の後置修飾（「〜の次数」「〜なる δ 上」）であるために、
   * 英訳すると `\text{}` の**前後にある記号の順序**が変わる場合。
   * `\text{}` を取り除いた残りが**多重集合として一致**することを条件にする
   * （記号を 1 つも足しても消してもいないことの検査。句読点と括弧は数えない）。
   */
  | "text-body-translated-reordered"
  /**
   * `\texttt{}` だけからなるノード（リポジトリ内部のパスやフィールド名）を投稿稿から落とした。
   * 投稿先の読者はこのリポジトリを開けないので、内部パスは投稿稿では意味を持たない。
   * **`\texttt{}` だけからなるノードにしか適用しない**（数式を落とす言い訳には使えない）。
   */
  | "repo-internal-texttt-removed";

export const DIFF_RULES: readonly DiffRule[] = [
  "text-body-translated",
  "text-body-translated-reordered",
  "repo-internal-texttt-removed",
];

/** 例外の登録。**理由と、許す差の種類**の両方が要る。 */
export type MathDifferenceException = {
  /** なぜその差が訳し落としでも数学の書き換えでもないのか。空文字は認めない。 */
  reason: string;
  /** その差を説明してよい規則。ここに無い規則では説明させない。 */
  allow: readonly DiffRule[];
};

/** 差分 1 つの説明の結果。 */
export type Explanation = {
  rule: DiffRule;
  ja: string;
  en: string | null;
};

export type ExplainResult = {
  explained: Explanation[];
  /** どの規則でも説明できずに残った差。1 つでもあれば違反。 */
  unexplainedJaOnly: string[];
  unexplainedEnOnly: string[];
  /** 宣言されているのに 1 度も使われなかった規則（登録が古い印）。 */
  unusedRules: DiffRule[];
};

/**
 * 日本語版だけにある数式と英語版だけにある数式を、許された規則で 1 つずつ説明する。
 * 説明できずに残ったものが違反である。
 */
export function explainDifferences(
  jaOnly: readonly string[],
  enOnly: readonly string[],
  allow: readonly DiffRule[],
): ExplainResult {
  const ja = [...jaOnly];
  const en = [...enOnly];
  const explained: Explanation[] = [];
  const used = new Set<DiffRule>();

  // 強い規則から順に当てる（弱い規則で説明できてしまうものを、強い規則が先に説明する）。
  for (const rule of ["text-body-translated", "text-body-translated-reordered"] as const) {
    if (!allow.includes(rule)) continue;
    for (let i = ja.length - 1; i >= 0; i -= 1) {
      const match = en.findIndex((candidate) => pairMatches(rule, ja[i]!, candidate));
      if (match < 0) continue;
      explained.push({ rule, ja: ja[i]!, en: en[match]! });
      used.add(rule);
      ja.splice(i, 1);
      en.splice(match, 1);
    }
  }

  if (allow.includes("repo-internal-texttt-removed")) {
    for (let i = ja.length - 1; i >= 0; i -= 1) {
      if (!isTexttOnly(ja[i]!)) continue;
      explained.push({ rule: "repo-internal-texttt-removed", ja: ja[i]!, en: null });
      used.add("repo-internal-texttt-removed");
      ja.splice(i, 1);
    }
  }

  return {
    explained,
    unexplainedJaOnly: ja,
    unexplainedEnOnly: en,
    unusedRules: allow.filter((rule) => !used.has(rule)),
  };
}

function pairMatches(rule: DiffRule, ja: string, en: string): boolean {
  if (rule === "text-body-translated") {
    return normalizeSpaces(maskTextMacroBodies(ja)) === normalizeSpaces(maskTextMacroBodies(en));
  }
  if (rule === "text-body-translated-reordered") {
    return sameMultiset(meaningfulTokens(ja), meaningfulTokens(en));
  }
  return false;
}

/** `\texttt{...}` だけからなるノードか（前後の空白は許す）。 */
export function isTexttOnly(tex: string): boolean {
  return /^\s*\\texttt\{[^{}]*\}\s*$/.test(tex);
}

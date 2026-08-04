/**
 * **空集合になりうる最小・最大の検査（検査 M）の型と判定**。
 *
 * ## なぜこの検査が要るのか
 *
 * $\min$ / $\max$ を集合や添字族の上で取るとき、**その集合が空になりうるのに読み方を
 * 書いていない**と、主張の意味が読み手の流儀で変わる。$\min\emptyset=0$ と読む流儀
 * （多くの計算機代数系と形式化ライブラリの既定）と $+\infty$ と読む流儀では、
 * 同じ文が別の主張になる。
 *
 * この事故は本論文で**すでに 4 回起きている**。
 *
 * | いつ | どこ | 落ちたもの |
 * |---|---|---|
 * | cycle 25 step 1 | 定理 G2 $(3.2)$ | $\ell=3$ だけ |
 * | cycle 26 step 6 | 命題 G′ の $m_1$ | $\ell=3$ だけ |
 * | cycle 27 step 1 | 命題 G の (G1′) の $\delta$ | **一般の塔すべて**（$k=k_{\min}$） |
 * | cycle 27 step 1 | 命題 G の (G6)・命題 J の $\theta$ | **仮定が偽から真へ反転** |
 *
 * 最初の 2 件で落ちたのが 1 つの素数だけだったことが、この型の事故の性質をよく表している——
 * **目視でも数値検証でも見つからない。** 実際、cycle 26 総括は「同型の事故が 2 例目なので
 * 全数走査が要る」と書いて cycle 27 へ送った。本検査がその全数走査である。
 *
 * ## 何を機械で見るか（および見られないか）
 *
 * **空になりうるかどうかそのものは機械で判定できない。** 「この添字族は行列の固有値を走るので
 * 空でない」は数学の判断であって、$\LaTeX$ の文字列からは出てこない。
 * したがってこの検査は次の 2 段に分ける。
 *
 * 1. **形の分類は機械がやる。** `\min` / `\max` の出現を、演算子として集合・添字族へ
 *    適用しているもの（判断が要る）と、そうでないもの（記号の飾り `\theta^{\max}`、
 *    2 引数の `\min(a,b)`、地の文で演算子に言及しているだけのもの）へ分ける。
 * 2. **判断は台帳に書かせる。** 判断が要る出現は 1 つ残らず
 *    `extremum-allowances.ts` に根拠つきで登録する。**未登録の出現は即座に赤**になる。
 *    新しく `\min\{\dots\}` を書けば、登録するまで `npm run check` が通らない。
 *
 * 台帳の根拠のうち、**空でないことを本文が実際に論じている型と、規約を書いている型は
 * 目印の実在を機械で確かめる**（本文からその一文が消えれば赤くなる）。
 * 「構成から空でない」型だけは機械で確かめられないので、件数を毎回印字する。
 *
 * ## 限界（正直に書く）
 *
 * - **「構成から空でない」の判定そのものは機械化していない。** 上記のとおり件数だけ出す。
 * - 見るのは `math` / `displayMath` の `tex` だけである。地の文で「最小」と日本語で
 *   書いてある箇所は対象外（本論文では記号で書く規律があるので実害は無いが、限界ではある）。
 * - 分類は `\min` / `\max` の直後の並びだけで決める。`\operatorname{min}` のような別綴りは
 *   拾わない（本論文には 1 件も無いことを実測している）。
 */

import { maskTextMacroBodies, normalizeSpaces } from "./tex-atoms.ts";

/**
 * 出現の形。**判断が要るのは `set-builder` と `indexed` の 2 つだけ**である。
 *
 * - `set-builder`: `\min\{\dots\}`。条件を満たす元が 1 つも無いことがありうる。
 * - `indexed`: `\min_m(\dots)`、`\max_{P\in S}\dots`。添字の走る範囲が空でありうる。
 * - `tuple`: `\min(a,b)`。引数が並んでいるので空にならない。
 * - `decoration`: `\theta^{\max}`、`\rho_{\max}`、`\mu_{\min}`。記号の名前の一部であり演算ではない。
 * - `bare-mention`: 地の文で演算子そのものに言及している（「この `\min` は…」）。適用ではない。
 * - `about-convention`: `\min\emptyset=0` のように、規約そのものを書いている。
 */
export type ExtremumForm =
  | "set-builder"
  | "indexed"
  | "tuple"
  | "decoration"
  | "bare-mention"
  | "about-convention";

export const formsNeedingJudgement: readonly ExtremumForm[] = ["set-builder", "indexed"];

export type ExtremumSite = {
  readonly locale: string;
  readonly blockId: string;
  readonly file: string;
  readonly where: "statement" | "proof";
  readonly op: "min" | "max";
  readonly form: ExtremumForm;
  /** 台帳の照合キー。`\text{}` の中身は伏せるので、日本語版と英語版で同じ値になる。 */
  readonly fingerprint: string;
};

/**
 * 台帳が書く根拠。**空にならない理由か、空のときの読み方か、のどちらかしかない。**
 *
 * `marker` を持つ型は、その文字列が当該ブロック（`elsewhere` なら指定したラベルのブロック）の
 * 中に実在することを機械が確かめる。本文からその一文が消えれば検査が赤くなる。
 */
export type ExtremumGround =
  | {
      /**
       * 構成から空にならない。**判断そのものは tex の文字列からは出ない型**。
       *
       * `leanTheorem` を書けば、その判断を Lean の定理として述べたことになる
       * （検査は定理が `lean/` に実在することを確かめ、裏を取れた件数を印字する）。
       * 書かなければ、その件は人の判断のまま残る。
       */
      readonly type: "nonempty-by-construction";
      readonly why: string;
      /** 空でないことを述べた Lean の定理名。`IntegrableLattice.…` の完全名。 */
      readonly leanTheorem?: string;
    }
  | {
      /** 空でないことを、このブロック自身が論じている。 */
      readonly type: "nonempty-argued-here";
      readonly marker: string;
    }
  | {
      /** 空でないことを、別のブロックが論じている（前方参照）。 */
      readonly type: "nonempty-argued-elsewhere";
      readonly label: string;
      readonly marker: string;
    }
  | {
      /** 空になりうるので、空のときの読み方を書いている。 */
      readonly type: "empty-convention-stated";
      readonly marker: string;
    };

export type ExtremumAllowance = {
  readonly block: string;
  readonly op: "min" | "max";
  readonly form: "set-builder" | "indexed";
  readonly fingerprint: string;
  /** この指紋を持つ出現が原文にいくつあるか。増減すれば赤くなる。 */
  readonly count: number;
  readonly ground: ExtremumGround;
  /** 目印だけでは伝わらない事情（なぜその目印で足りるか等）。任意。 */
  readonly note?: string;
};

const OPEN_DELIMITERS = /^\s*(?:\\(?:bigl|Bigl|biggl|Biggl|left)\s*)?(\\\{|\(|\\emptyset)/;
const SUBSCRIPT = /^\s*_\s*(\{(?:[^{}]|\{[^{}]*\})*\}|\\[a-zA-Z]+|[A-Za-z0-9])/;

/** 直前が `_` または `^` なら、それは演算ではなく記号の飾りである。 */
const isDecoration = (before: string): boolean => /[_^]\s*\{?\s*$/.test(before);

export const fingerprintOf = (raw: string): string =>
  normalizeSpaces(maskTextMacroBodies(raw)).slice(0, 60);

/** 1 つの数式から `\min` / `\max` の出現を拾い、形を決める。 */
export const classifyTex = (
  tex: string,
): { op: "min" | "max"; form: ExtremumForm; fingerprint: string }[] => {
  const found: { op: "min" | "max"; form: ExtremumForm; fingerprint: string }[] = [];
  const pattern = /\\(min|max)(?![a-zA-Z])/g;
  let match: RegExpExecArray | null;
  while ((match = pattern.exec(tex)) !== null) {
    const op = match[1] as "min" | "max";
    const before = tex.slice(Math.max(0, match.index - 14), match.index);
    if (isDecoration(before)) {
      found.push({ op, form: "decoration", fingerprint: "" });
      continue;
    }
    let rest = tex.slice(match.index + 1 + op.length);
    const subscript = rest.match(SUBSCRIPT);
    const index = subscript?.[1] ?? "";
    if (subscript) rest = rest.slice(subscript[0].length);
    const opens = rest.match(OPEN_DELIMITERS);
    const form: ExtremumForm = subscript
      ? "indexed"
      : opens === null
        ? "bare-mention"
        : opens[1] === "\\{"
          ? "set-builder"
          : opens[1] === "("
            ? "tuple"
            : "about-convention";
    found.push({ op, form, fingerprint: fingerprintOf(index + rest) });
  }
  return found;
};

export const needsJudgement = (form: ExtremumForm): form is "set-builder" | "indexed" =>
  formsNeedingJudgement.includes(form);

export const keyOf = (value: {
  blockId?: string;
  block?: string;
  op: string;
  form: string;
  fingerprint: string;
}): string => `${value.blockId ?? value.block} ${value.op} ${value.form} ${value.fingerprint}`;

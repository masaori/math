/**
 * **「残りを閉じる定理」の両端の棚卸し**（cycle 39 step 4 で新設。検査 E）。
 *
 * ## なぜこれが要るか
 *
 * **「残りが N 件」と書かれた欄に入ると N 件ではない、が 4 サイクル続いた**
 * （cycle 35・36・38・39）。4 件を全数で読むと、外れ方は 1 つの形に集まる。
 *
 * > **残りを閉じたと書いた定理が、実は含意である。**
 * > その仮定を誰が与えるのかを、書き手が数えていない。
 *
 * 実例。cycle 38 step 1 は 命題 W\* の「残り 1 件」を書いたと記録したが、
 * 書いた定理は「$\rho$ が無平方**かつ** $\mu$ が零因子でない**ならば** $\det G\neq0$」であり、
 * その 2 つの仮定はどちらも本文が構成で与えているものだった。**両端が数から落ちていた。**
 * cycle 39 step 3 はその 2 つを書いたが、今度は族 $f_i$ を受け取る形だったので、
 * $\chi$ から族を取り出す段が外側に残った。**同じ形が続けて起きている。**
 *
 * ## 塞ぎ方: 束縛子を全数で分類させる
 *
 * 散文に「残りは N 件」と書かせるだけでは、**書き手が数え落としたものは検査にも見えない。**
 * そこで数える対象を散文から**定理の署名**へ移す。
 *
 * 台帳は、残りを閉じたと言う定理ごとに、**その署名に現れる束縛子を 1 つ残らず**列挙し、
 * 各々を次の 3 つへ分類する。
 *
 * - `データ` — 主張が語る対象そのもの（多項式・行列・添字など）。閉じる対象ではない。
 * - `構成で与える` — その仮定を作る定理がこちらにある。**その定理名を型で要求する。**
 * - `受け取る` — こちらでは作っていない。**残りである。**
 *
 * **機械は、列挙した名前の集合が、ソースから読み取った束縛子の名前の集合と一致することを見る。**
 * したがって**書き落とすと赤くなる。**「残り」を含意として数える道はこれで塞がる。
 *
 * ## 限界（正直に書く）
 *
 * - **分類そのものは人の判断である。** 「受け取る」を「データ」と書けば静かに通る。
 *   塞げるのは**数え落とし**であって、**言い換え**ではない。
 * - 読み取るのは束縛子の名前だけで、その型が何を言っているかは読まない。
 * - **`構成で与える` が指す定理が本当にその仮定を与えるかは確かめられない**
 *   （実在することだけを確かめる）。これは検査 F の限界と同じ形である。
 * - 対象はこの台帳に登録した定理だけである。**登録の網羅性は測れない**
 *   （狭めたのであって塞いだのではない。cycle 34 step 4 の登録の網羅性と同じ性質）。
 */

export type EndKind = "データ" | "構成で与える" | "受け取る";

export type TheoremEnd =
  | { readonly binder: string; readonly kind: "データ"; readonly why: string }
  | {
      readonly binder: string;
      readonly kind: "構成で与える";
      /** その仮定を作る定理。`lean/` に実在することを機械が確かめる。 */
      readonly suppliedBy: string;
    }
  | {
      readonly binder: string;
      readonly kind: "受け取る";
      /** なぜまだ作っていないか。残り一覧に現れるべき事柄である。 */
      readonly why: string;
    };

export type ClosingTheorem = {
  /** `lean/IntegrableLattice/` からの相対ファイル名。 */
  readonly file: string;
  /** 定理の名前（名前空間を除いた、ソースに現れる形）。 */
  readonly theorem: string;
  /** どの欄の残りを閉じたと言っているか（検査 F の台帳の `block` か外部定理の名前）。 */
  readonly entry: string;
  /** 署名に現れる束縛子の全数。ソースから読み取ったものと集合として一致すること。 */
  readonly ends: readonly TheoremEnd[];
};

/**
 * **署名から束縛子の名前を読み取る。**
 *
 * `theorem NAME` の直後から、**括弧の外に出た最初の `:`** までが束縛子の並びである。
 * そこに現れる `(...)` と `{...}` の中の、`:` より前の名前を取る。
 * `[...]`（インスタンス）は名前を持たないことが多いので対象外にする。
 */
export const readBinders = (source: string, theoremName: string): string[] | null => {
  const head = new RegExp(`\\b(?:theorem|lemma)\\s+${theoremName}\\b`).exec(source);
  if (head === null) return null;
  let i = head.index + head[0].length;
  let depth = 0;
  const groups: { open: string; body: string }[] = [];
  let current: { open: string; body: string } | null = null;
  while (i < source.length) {
    const c = source[i];
    if (depth === 0 && c === ":") break;
    if (c === "(" || c === "{" || c === "[") {
      if (depth === 0) current = { open: c, body: "" };
      else if (current !== null) current.body += c;
      depth += 1;
    } else if (c === ")" || c === "}" || c === "]") {
      depth -= 1;
      if (depth === 0 && current !== null) {
        groups.push(current);
        current = null;
      } else if (current !== null) current.body += c;
    } else if (current !== null) current.body += c;
    i += 1;
  }
  const names: string[] = [];
  for (const g of groups) {
    if (g.open === "[") continue;
    const colon = g.body.indexOf(":");
    const head = colon === -1 ? g.body : g.body.slice(0, colon);
    for (const name of head.trim().split(/\s+/)) {
      if (name.length > 0) names.push(name);
    }
  }
  return names;
};

/**
 * **台帳。** 残りを閉じたと言う定理を登録する。
 *
 * 初期値は cycle 39 step 4 の実測。**4 サイクル続いた外れ方の当事者を先に入れてある**
 * （cycle 38 step 1 と cycle 39 step 3 の 2 本）。
 * 対比のために、仮定を 1 つも受け取っていない定理も 1 本入れてある
 * （検査が「受け取る」を数えていることを、緑の側からも見えるようにするため）。
 */
export const CLOSING_THEOREMS: readonly ClosingTheorem[] = [
  {
    // cycle 38 step 1。**掲げた残り 1 件を書いたのに、両端が数から落ちていた当の定理である。**
    file: "WStarSquarefreeNonzero.lean",
    theorem: "det_weightedGram_ne_zero_of_squarefree",
    entry: "paper_046_theorem_wstar_different",
    ends: [
      { binder: "K", kind: "データ", why: "商体。$\\mathbb{Q}$ を当てる" },
      { binder: "m", kind: "データ", why: "次数から 1 を引いたもの" },
      { binder: "ρ", kind: "データ", why: "本文の $\\rho=\\mathrm{rad}(\\chi)$" },
      {
        binder: "hmonic",
        kind: "構成で与える",
        suppliedBy: "rad_monic",
      },
      { binder: "hdeg", kind: "データ", why: "次数の指定。閉じる対象ではない" },
      {
        binder: "hsq",
        kind: "構成で与える",
        suppliedBy: "squarefree_rad",
      },
      { binder: "μ", kind: "データ", why: "本文の重複度の元" },
      {
        binder: "hμ",
        kind: "構成で与える",
        suppliedBy: "multWeight_mem_nonZeroDivisors",
      },
    ],
  },
  {
    // cycle 39 step 3。上の 2 つの仮定を構成で与えた形。**今度は族の側が受け取りになった。**
    file: "WStarRadicalMultiplicity.lean",
    theorem: "det_weightedGram_ne_zero_of_factorization",
    entry: "paper_046_theorem_wstar_different",
    ends: [
      { binder: "K", kind: "データ", why: "商体。$\\mathbb{Q}$ を当てる" },
      { binder: "m", kind: "データ", why: "次数から 1 を引いたもの" },
      { binder: "f", kind: "データ", why: "相異なる既約因子の族" },
      { binder: "a", kind: "データ", why: "重複度" },
      {
        binder: "hprime",
        kind: "受け取る",
        why:
          "族が素元であることは、$\\chi$ の一意分解から出るはずのものである。" +
          "本ファイルは族を受け取る形なので、ここは作っていない",
      },
      {
        binder: "hndvd",
        kind: "受け取る",
        why: "族が相異なることも同じく、$\\chi$ の一意分解から出るはずのものである",
      },
      {
        binder: "hmonic",
        kind: "受け取る",
        why:
          "モニックな $\\chi$ の因子がモニックに取れることは、" +
          "先頭係数が正の整数で積が $1$ であることから出るはずだが、書いていない",
      },
      { binder: "hdeg", kind: "データ", why: "因子が定数でないこと。族の与え方の指定" },
      { binder: "ha", kind: "データ", why: "重複度が $0$ でないこと。族の与え方の指定" },
      { binder: "hdegrad", kind: "データ", why: "次数の指定。閉じる対象ではない" },
    ],
  },
  {
    // cycle 39 step 1。**対比。仮定を 1 つも受け取っていない形はこう見える。**
    file: "NewtonPolytopeAdditivity.lean",
    theorem: "newt_mul",
    entry: "Newton 多面体の加法性（Ostrowski の定理）",
    ends: [
      { binder: "f", kind: "データ", why: "Laurent 多項式" },
      { binder: "g", kind: "データ", why: "Laurent 多項式" },
    ],
  },
];

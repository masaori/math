/**
 * **残り一覧の照合（`lean/` の一覧と検査 F の台帳）の型と台帳**。
 *
 * ## なぜこれが要るのか（cycle 32 が見つけた穴）
 *
 * `lean/` の各ファイルは冒頭に「形式化しなかったもの」の一覧を自分で書いている。
 * 検査 F の台帳（`formalization-coverage.ts`）も「残り」を書いている。
 * **この 2 つがずれていても、これまで誰も気づかなかった。**
 *
 * cycle 32 の実測で、実際に 2 件ずれていた——
 * 命題 Q は Lean 側が 3 件を挙げているのに台帳は 1 件しか写しておらず、命題 R も同じ形だった。
 * **検査 F は台帳と本文の食い違いは見るが、台帳と `lean/` の記述の食い違いは見ていない。**
 * その穴をここで塞ぐ。
 *
 * ## 形の分類は機械が、判断は台帳が持つ
 *
 * 箇条書きが何件あるかは機械が数える。**その 1 件が「まだ残っている項目」なのか、
 * 「もう書いた項目」なのか、「調査ログへの参照」でしかないのかは人の判断**なので台帳が持つ。
 * この分け方は検査 O（極値の規約）・検査 Λ（記号）と同じ形である。
 *
 * ## 機械が確かめること
 *
 * 1. **残り一覧の節を持つ `lean/` のファイルが、1 つ残らずこの台帳にあること。**
 *    黙って新しいファイルを足して一覧を書き散らす道を塞ぐ。
 * 2. **台帳の項目数が、実際の箇条書きの数と一致すること。**
 *    ここが cycle 32 の事故（Lean 側 3 件・台帳 1 件）を捕まえる。
 * 3. **各項目の `leanFragment` が、対応する箇条書きに実在すること。**
 *    Lean 側の文言が書き換わったら台帳が腐るので、腐りが赤くなる。
 * 4. **`未形式化` の項目は、`ledgerFragment` が検査 F の台帳の当該エントリに実在すること。**
 *    ここが本題——**台帳が `lean/` より少なく書いていたら赤くなる。**
 * 5. **`未形式化` の項目を持つファイルに対応するエントリが `完了` でないこと。**
 *    残りがあるのに完了と書く道を塞ぐ。
 *
 * ## 機械が確かめられないこと（正直に書く）
 *
 * - **その箇条書きの分類（未形式化か・形式化済みか・参照だけか）は人の判断である。**
 *   `参照だけ` と書けば `ledgerFragment` を要求されないので、**そこは逃げ道になりうる。**
 *   逃げ道を狭めるため、分類の内訳を毎回件数で印字する。
 * - **`ledgerFragment` が台帳に在ることは確かめられるが、それが同じ事柄を指しているかは
 *   確かめられない。** 検査の強さの上限は、台帳の書き手が選んだ語の妥当性である
 *   （検査 O・検査 F の限界と同じ形）。
 * - 台帳と `lean/` の**両方が同じだけ古い**場合は、一致したまま静かに通る。
 */

export type LeanRemainingKind = "未形式化" | "形式化済み" | "参照だけ";

/**
 * **「参照だけ」の指し先**（cycle 34 step 3 で追加）。
 *
 * cycle 33 は「`参照だけ` と書けば台帳への反映を要求されない」ことを逃げ道として記録していた。
 * 塞ぎ方は、**`参照だけ` にも実在を確かめられる指し先を要求する**ことである。
 * 何も指していない「参照だけ」は書けなくなる。
 */
export type LeanRemainingReferent =
  /** 同じ `lean/IntegrableLattice/` の別ファイル（実在を確かめる）。 */
  | { readonly kind: "lean ファイル"; readonly target: string }
  /** `lean/logs/` の走査ログ（実在を確かめる）。 */
  | { readonly kind: "ログ"; readonly target: string }
  /** mathlib に在るもの。走査ログのどれかにその語が現れることを確かめる。 */
  | { readonly kind: "mathlib"; readonly target: string };

export type LeanRemainingItem =
  | {
      /** その箇条書きに実在すべき文字列（実在を機械が確かめる）。 */
      readonly leanFragment: string;
      readonly kind: "未形式化";
      /** 検査 F の台帳の当該エントリに実在すべき文字列。**未形式化では型で必須**。 */
      readonly ledgerFragment: string;
    }
  | {
      readonly leanFragment: string;
      readonly kind: "形式化済み";
      /**
       * **型で必須**（cycle 35 step 5）。その項目を形式化した定理の名前。
       * `lean/` に実在することを機械が確かめる。
       *
       * **これが無いと、台帳と `lean/` の両方が同じだけ古い場合に静かに通る**——
       * 「形式化済み」と書いた当の定理を消しても、どちらの側も文章のままなので誰も気づかない。
       * 実在する宣言を第三の情報源として要求することで、その一致が偶然でなくなる。
       */
      readonly witness: string;
    }
  | {
      readonly leanFragment: string;
      readonly kind: "参照だけ";
      /** **型で必須**。何も指さない「参照だけ」を書けなくする。 */
      readonly referent: LeanRemainingReferent;
    };

export type LeanRemainingFile = {
  /** `lean/IntegrableLattice/` からの相対ファイル名。 */
  readonly file: string;
  /**
   * 節の見出し（`## ` の後ろ）。**宣言と実物が違えば赤くなる**ので、
   * 見出しを書き換えて検査から逃げる道が塞がる。
   */
  readonly heading: string;
  /**
   * **本文の主張へ紐づかないファイルの受け皿**（cycle 34 step 3 で追加）。
   *
   * cycle 33 の照合は、本文の `lean` 紐づけからファイル→主張の対応を導いていたので、
   * どの主張にも紐づかないファイル（matrix-tree の部品など）の未形式化項目を
   * **突き合わせずに件数だけ出していた**。そこが穴だった。
   *
   * そういうファイルは、代わりに**外部定理の台帳のどのエントリに属するか**を宣言する。
   * 宣言があれば `ledgerFragment` はそのエントリの本文と突き合わせる。
   * **紐づけも宣言も無ければ違反**にする（黙って照合対象の外に置けなくなる）。
   */
  readonly externalEntry?: string;
  /**
   * **そのファイルを最後に読み直したときの宣言の数**（cycle 36 step 4 で追加）。
   *
   * ## なぜこれが要るか（3 サイクル持ち越していた穴の、残っていた側）
   *
   * cycle 35 step 5 で `形式化済み` の項目には証拠（実在する宣言の名前）を要求するようにした。
   * 残っていたのは `未形式化` の側である——**「まだ書いていない」ことを実在する宣言では示せない**
   * ので、実際には書けているのに台帳と `lean/` の両方が古いままなら静かに通る。
   *
   * **塞ぎ方を変えた。** 「書いていないこと」を機械に言わせるのは諦め、
   * **危険が生じた瞬間に人へ読み直しを強制する**形にする。
   * 残り一覧が古くなるのは、そのファイルに宣言が増えた（または消えた）ときだけである。
   * そこで**宣言の数を台帳に持ち、実際の数と食い違ったら違反にする。**
   * 書き足した人は、残り一覧を読み直して、まだ未形式化かを確かめてからこの数を直すことになる。
   *
   * これは cycle 35・36 で 4 件見つかった「書き足したのに要約を直していない」事故と同じ形への、
   * 検査の側からの手当てである。
   *
   * ## 限界（正直に書く）
   *
   * - **数を直すときに本当に読み直したかは確かめられない。** 数だけ合わせて通すことはできる。
   *   強制できるのは「読み直す機会が必ず訪れること」だけである。
   * - **ファイルに宣言を足さずに項目が形式化される場合は捕まらない**
   *   （別ファイルに書いた場合。そこは人の読みのままである）。
   */
  readonly declarationsAtReview: number;
  /** 箇条書きと同じ順序で並べる。件数の一致を機械が見る。 */
  readonly items: readonly LeanRemainingItem[];
};

/**
 * 初期値は cycle 33 step 1 完了時点の実測（`lean/` の 13 ファイル・箇条書き 28 件）。
 * 分類は 1 件ずつ Lean 側の本文を読んで付けた。
 */
export const LEAN_REMAINING_LEDGER: readonly LeanRemainingFile[] = [
  {
    file: "BouquetClosedForm.lean",
    declarationsAtReview: 23,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "の独立計算（Matrix-Tree 定理）",
        kind: "未形式化",
        ledgerFragment: "matrix-tree",
      },
      { leanFragment: "定理 X の付値計算そのもの", kind: "未形式化", ledgerFragment: "付値" },
    ],
  },
  {
    file: "CoefficientsDE.lean",
    declarationsAtReview: 39,
    heading: "形式化しなかったもの（mathlib の欠落か配線か）",
    items: [],
  },
  {
    file: "Cycle24Corrections.lean",
    declarationsAtReview: 29,
    heading: "形式化しなかったもの",
    items: [
      { leanFragment: "系 Q7 の $r=2$ そのもの", kind: "未形式化", ledgerFragment: "系 Q7" },
      {
        leanFragment: "欠落調査は",
        kind: "参照だけ",
        referent: { kind: "ログ", target: "mathlib-gap-survey-cycle24.log" },
      },
    ],
  },
  {
    file: "Cycle25Corrections.lean",
    declarationsAtReview: 33,
    heading: "形式化しなかったもの",
    items: [
      { leanFragment: "定理 G2 の 1", kind: "未形式化", ledgerFragment: "定理 G2 の 1" },
      { leanFragment: "系 Q7 の $r=2$", kind: "未形式化", ledgerFragment: "系 Q7" },
      { leanFragment: "そのもの（voltage グラフのラプラシアン行列式）", kind: "未形式化", ledgerFragment: "matrix-tree" },
    ],
  },
  {
    file: "CyclotomicValuationQ4a.lean",
    declarationsAtReview: 9,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "が素元であること自体は mathlib",
        kind: "参照だけ",
        referent: { kind: "mathlib", target: "zeta_sub_one_prime" },
      },
      {
        leanFragment: "は `PropQLaurentLift.lean`",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "PropQLaurentLift.lean" },
      },
    ],
  },
  {
    file: "DigitBranchRecursion.lean",
    declarationsAtReview: 11,
    heading: "形式化した残りの段（cycle 35 step 1 で 2 件とも書いた）",
    items: [
      { leanFragment: "指数の $(1+x)^\\gamma$", kind: "形式化済み", witness: "coeff_zellPow_eq" },
      {
        leanFragment: "についての帰納法そのもの",
        kind: "形式化済み",
        witness: "exists_coeff_ne_zero_of_sepAt",
      },
    ],
  },
  {
    file: "DigitBranchZellExponent.lean",
    declarationsAtReview: 18,
    heading: "形式化した残りの段（cycle 35 step 1 で 2 件とも書いた）",
    items: [
      { leanFragment: "指数の $(1+x)^\\gamma$", kind: "形式化済み", witness: "zellPow" },
      {
        leanFragment: "についての帰納法",
        kind: "形式化済み",
        witness: "exists_coeff_ne_zero_lt_pow_sep",
      },
    ],
  },
  {
    file: "DigitTheorem.lean",
    declarationsAtReview: 18,
    heading: "形式化しなかったもの",
    items: [{ leanFragment: "命題 J2′ の", kind: "未形式化", ledgerFragment: "命題 J2′" }],
  },
  {
    file: "DropAssumptionBStar.lean",
    declarationsAtReview: 14,
    heading: "形式化した残りの段（cycle 33 step 1 で 2 件とも書いた）",
    items: [
      { leanFragment: "補題 Q0", kind: "形式化済み", witness: "crudeBound_le_mul_logb_of_pow_le" },
      {
        leanFragment: "補題 Q4a",
        kind: "形式化済み",
        witness: "associated_sub_one_pow_totient",
      },
      { leanFragment: "補題 Q1′", kind: "形式化済み", witness: "lemma_Q1'" },
    ],
  },
  {
    file: "EllTwoClosedForm.lean",
    declarationsAtReview: 23,
    heading: "形式化しなかったもの（理由）",
    items: [
      { leanFragment: "の**導出**", kind: "未形式化", ledgerFragment: "導出" },
      { leanFragment: "matrix-tree 定理が要り", kind: "未形式化", ledgerFragment: "matrix-tree" },
    ],
  },
  {
    file: "GeneralTowerClosedForm.lean",
    declarationsAtReview: 24,
    heading: "形式化しなかったもの（mathlib の欠落か配線か）",
    items: [
      { leanFragment: "定理 G2 の 1", kind: "未形式化", ledgerFragment: "定理 G2 の 1" },
      { leanFragment: "定理 G2 の 3", kind: "未形式化", ledgerFragment: "定理 G2 の 3" },
      { leanFragment: "非依存性", kind: "未形式化", ledgerFragment: "非依存性" },
      { leanFragment: "Matrix–Tree 定理", kind: "未形式化", ledgerFragment: "matrix-tree" },
    ],
  },
  {
    file: "EulerDualBasisCommRing.lean",
    declarationsAtReview: 27,
    heading: "形式化しなかったもの",
    externalEntry:
      "可換環の上の Euler の双対基底公式（トレース双対 $\\operatorname{Tr}_{A/R}(c_i\\theta^j)=\\delta_{ij}$）",
    items: [
      {
        leanFragment: "段 2 から段 6 までは cycle 36 step 1 で書いた",
        kind: "形式化済み",
        witness: "sum_eulerC_mul_pow",
      },
      {
        leanFragment: "段 7（$\\det G=\\pm N_{A/R}(\\eta)$ の可換環版）は cycle 37 step 1 で書いた",
        kind: "形式化済み",
        witness: "det_weightedGram",
      },
      {
        leanFragment: "を満たすことの当てはめも",
        kind: "形式化済み",
        witness: "isPowerBasisOf_adjoinRoot",
      },
      {
        leanFragment: "命題 W\\* は依然 部分的である。残っているのは 1 つで",
        kind: "未形式化",
        ledgerFragment: "無平方であることから",
      },
    ],
  },
  {
    file: "WStarReducibleDescent.lean",
    declarationsAtReview: 4,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "が実際に零因子でないこと",
        kind: "未形式化",
        ledgerFragment: "無平方であることから",
      },
      {
        leanFragment: "の可約な場合",
        kind: "形式化済み",
        witness: "det_weightedGram",
      },
      {
        leanFragment: "の値を存在の形で述べる",
        kind: "未形式化",
        ledgerFragment: "整域でないので当たらない",
      },
    ],
  },
  {
    file: "WStarPowerBasisInstance.lean",
    declarationsAtReview: 4,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "を直接導く段",
        kind: "未形式化",
        ledgerFragment: "無平方であることから",
      },
    ],
  },
  {
    file: "KirchhoffCounting.lean",
    declarationsAtReview: 4,
    heading: "形式化しなかったもの",
    externalEntry: "Kirchhoff の matrix-tree 定理（グラフの全域木を数える定理）",
    items: [
      {
        leanFragment: "でないことと「全域木であること」の同値は cycle 37 step 2 で入った",
        kind: "形式化済み",
        witness: "det_submatrix_ne_zero_iff_reach",
      },
      { leanFragment: "指標分解", kind: "未形式化", ledgerFragment: "指標分解" },
    ],
  },
  {
    file: "SpanningConnectivity.lean",
    declarationsAtReview: 30,
    heading: "形式化しなかったもの",
    externalEntry: "Kirchhoff の matrix-tree 定理（グラフの全域木を数える定理）",
    items: [
      {
        leanFragment: "葉を除いた小さいグラフへの帰納は cycle 37 step 2 で書いた",
        kind: "形式化済み",
        witness: "det_submatrix_eq_one_or_neg_one",
      },
      { leanFragment: "指標分解", kind: "未形式化", ledgerFragment: "指標分解" },
    ],
  },
  {
    file: "ResultantValuationR4.lean",
    declarationsAtReview: 22,
    heading: "形式化した残りの段（cycle 35 step 1 で書いた）",
    items: [
      {
        leanFragment: "へ $\\pi$ を送る環準同型があること",
        kind: "形式化済み",
        witness: "exists_ringHom_sub_one",
      },
      {
        leanFragment: "がモニックであることと分解すること",
        kind: "形式化済み",
        witness: "splits_psi",
      },
      {
        leanFragment: "整数の割り切りが反映されること",
        kind: "形式化済み",
        witness: "int_dvd_of_algebraMap_dvd",
      },
      {
        leanFragment: "のレベル分解と 命題 W の積の公式",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "PropW.lean" },
      },
    ],
  },
  {
    file: "PropQLaurentLift.lean",
    declarationsAtReview: 7,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "の分解 $(1.2)$ そのもの",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "SInfinityDecision.lean" },
      },
      {
        leanFragment: "が一意分解環であること",
        kind: "参照だけ",
        referent: { kind: "ログ", target: "mathlib-gap-survey-cycle22.log" },
      },
    ],
  },
  {
    file: "SInfinityDecision.lean",
    declarationsAtReview: 23,
    heading: "形式化しなかったもの（mathlib の欠落か配線か）",
    items: [
      { leanFragment: "補題 W2 の (iv)", kind: "未形式化", ledgerFragment: "補題 W2" },
      { leanFragment: "定理 W4 の", kind: "未形式化", ledgerFragment: "定理 W4" },
      { leanFragment: "系 W7", kind: "未形式化", ledgerFragment: "系 W7" },
    ],
  },
  {
    file: "TowerTypeCoefficients.lean",
    declarationsAtReview: 8,
    heading: "形式化しなかったもの（なぜ足りないのか）",
    items: [
      { leanFragment: "定理 J7 の主張そのもの", kind: "未形式化", ledgerFragment: "定理 J7" },
      { leanFragment: "の係数を「読み取る」段の一般形", kind: "未形式化", ledgerFragment: "読み取る" },
    ],
  },
];

/** 節の見出しと箇条書きを取り出す。箇条書きは行頭 `* ` で始まる塊とする。 */
export function parseRemainingSection(
  source: string,
): { heading: string; bullets: string[] } | null {
  const match =
    /^## (形式化しなかったもの[^\n]*|形式化した残りの段[^\n]*)$([\s\S]*?)(?=^-\/$|^## )/m.exec(
      source,
    );
  if (!match) return null;
  const body = match[2]!;
  const bullets = [...body.matchAll(/^\* ([\s\S]+?)(?=^\* |\s*$)/gm)].map((m) =>
    m[1]!.replace(/\s+/g, " ").trim(),
  );
  return { heading: match[1]!, bullets };
}

export type LeanRemainingAuditInput = {
  readonly entry: LeanRemainingFile;
  readonly section: { heading: string; bullets: string[] };
  /** そのファイルに対応する台帳エントリ（本文の紐づけ経由で導いたもの）。 */
  readonly linked: readonly { block: string; text: string; state: string }[];
  /** `externalEntry` が指す外部定理の台帳エントリの本文（無ければ `null`）。 */
  readonly externalText?: string | null;
  /** 参照先の実在（`参照だけ` の指し先を解決した結果）。呼び出し側が IO で作る。 */
  readonly referentExists?: (referent: LeanRemainingReferent) => boolean;
  /** 宣言名が `lean/` に実在するか（`形式化済み` の証拠を確かめる。cycle 35 step 5）。 */
  readonly declarationExists?: (name: string) => boolean;
};

/**
 * 1 ファイル分の判定。IO を持たないので検出テストからそのまま呼べる。
 * 返すのは違反の一覧と分類の内訳。
 */
export function auditLeanRemaining(input: LeanRemainingAuditInput): {
  violations: string[];
  counts: Record<LeanRemainingKind, number>;
  unlinked: number;
} {
  const { entry, section, linked, externalText = null, referentExists, declarationExists } = input;
  const violations: string[] = [];
  const counts: Record<LeanRemainingKind, number> = { 未形式化: 0, 形式化済み: 0, 参照だけ: 0 };
  let unlinked = 0;
  if (section.heading !== entry.heading) {
    violations.push(
      `[見出しが宣言と違う] ${entry.file} — 台帳「${entry.heading}」/ 実物「${section.heading}」`,
    );
  }
  if (section.bullets.length !== entry.items.length) {
    violations.push(
      `[項目数が合わない] ${entry.file} — 台帳 ${entry.items.length} 件 / 実物 ${section.bullets.length} 件` +
        `（cycle 32 の事故はこの形だった: Lean 側 3 件・台帳 1 件）`,
    );
    return { violations, counts, unlinked };
  }
  entry.items.forEach((item, index) => {
    counts[item.kind] += 1;
    const bullet = section.bullets[index]!;
    if (!bullet.includes(item.leanFragment.replace(/\s+/g, " "))) {
      violations.push(
        `[宣言が Lean 側に実在しない] ${entry.file} #${index + 1} — 「${item.leanFragment}」が箇条書きに無い`,
      );
    }
    if (item.kind === "参照だけ") {
      // cycle 34 step 3: 「参照だけ」にも指し先の実在を要求する（逃げ道を塞ぐ）。
      if (referentExists && !referentExists(item.referent)) {
        violations.push(
          `[参照だけの指し先が実在しない] ${entry.file} #${index + 1} — ` +
            `${item.referent.kind}「${item.referent.target}」が見つからない`,
        );
      }
      return;
    }
    if (item.kind === "形式化済み") {
      // cycle 35 step 5: 「形式化済み」にも証拠（実在する宣言）を要求する。
      // **これが 2 サイクル持ち越していた「両方が同じだけ古い」穴の、塞げる側である。**
      if (declarationExists && !declarationExists(item.witness)) {
        violations.push(
          `[形式化済みの証拠が実在しない] ${entry.file} #${index + 1} — ` +
            `宣言「${item.witness}」が lean/ に無い（消えたか改名された）`,
        );
      }
      return;
    }
    if (item.kind !== "未形式化") return;
    if (linked.length === 0) {
      // cycle 34 step 3: 紐づかないファイルは、外部定理の台帳のエントリと突き合わせる。
      if (externalText === null) {
        violations.push(
          `[照合先が無い] ${entry.file} #${index + 1} — ` +
            `本文の主張へ紐づかないのに externalEntry の宣言も無い（照合の外に置けない）`,
        );
        return;
      }
      unlinked += 1;
      if (!externalText.includes(item.ledgerFragment)) {
        violations.push(
          `[外部定理の台帳が lean/ より少なく書いている] ${entry.file} #${index + 1} — ` +
            `「${item.ledgerFragment}」が ${entry.externalEntry} の欄に無い`,
        );
      }
      return;
    }
    if (!linked.some((l) => l.text.includes(item.ledgerFragment))) {
      violations.push(
        `[台帳が lean/ より少なく書いている] ${entry.file} #${index + 1} — ` +
          `「${item.ledgerFragment}」が ${linked.map((l) => l.block).join(" / ")} の欄に無い`,
      );
    }
    for (const l of linked) {
      if (l.state === "完了") {
        violations.push(`[残りがあるのに完了] ${l.block} — ${entry.file} が未形式化の項目を挙げている`);
      }
    }
  });
  return { violations, counts, unlinked };
}

/**
 * **宣言の数の再確認**（cycle 36 step 4）。IO を持たないので検出テストからそのまま呼べる。
 *
 * 台帳が持っている数と実際の数が違えば、そのファイルに書き足し（または削除）があったのに
 * 残り一覧を読み直していない、ということである。
 */
export function auditDeclarationCount(
  entry: LeanRemainingFile,
  actual: number,
): string | null {
  if (actual === entry.declarationsAtReview) return null;
  return (
    `[宣言が増減したのに残り一覧を読み直していない] ${entry.file} — ` +
    `台帳は ${entry.declarationsAtReview} 件と書いているが実際は ${actual} 件。` +
    `残り一覧を読み直し、まだ未形式化かを確かめてから declarationsAtReview を直すこと`
  );
}

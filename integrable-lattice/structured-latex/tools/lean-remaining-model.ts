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
  /**
   * **`lean/` に置いた規約の文書**（cycle 38 step 4 で追加。実在を確かめる）。
   * 「これは命題ではないので Lean の定理にしていない」という**対象外の判断**を指すための種別である。
   * 自由文の逃げ道にしないため、判断が記録されている実在のファイルを指すことを型で要求する。
   */
  | { readonly kind: "規約"; readonly target: string }
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
      /**
       * **別のファイルがその事柄を書いていないかを見るための語**（cycle 37 step 4 で追加）。
       *
       * ## なぜこれが要るか（cycle 36 step 4 が残した穴）
       *
       * cycle 36 step 4 は「残り一覧が古くなるのは、そのファイルに宣言が増減したときだけである」
       * という観察に基づいて、宣言の数を台帳に持たせた。
       * **その観察は誤りである。cycle 37 が同じサイクルの中で 2 回反例を作った**——
       * `EulerDualBasisCommRing.lean` が未形式化と書いていた「当てはめ」は
       * `WStarPowerBasisInstance.lean` という**別のファイル**に書かれ、
       * `TracePeriodAssembly.lean` が仮定として出していた段は
       * `TracePeriodWStarLift.lean` に書かれた。
       * **どちらも元のファイルの宣言は 1 つも増えないので、鈴は鳴らなかった。**
       *
       * ## 塞ぎ方
       *
       * 項目ごとに語を宣言し、**他のファイルの本文（そのファイル自身の残り一覧を除く）に
       * その語が現れたら違反にする。** 別のファイルがその事柄について書いているなら、
       * 書いた側が形式化したのかもしれないので、状態を確かめさせる。
       *
       * **逃げ道は 1 つだけ用意してある**——現れた側のファイルも同じ語を
       * `未形式化` として宣言しているなら、2 つが「まだ書いていない」で一致しているので通す。
       * この逃げ道は、実際に形式化したファイルを黙らせるためには使えない
       * （形式化したなら `未形式化` とは書けない）。
       *
       * ## 限界（正直に書く）
       *
       * - **語の選び方が検査の強さの上限である。** 別のファイルが違う言い方で書けば素通りする。
       * - **語が広すぎると偽陽性が出る。** 関係ない文脈で同じ語が使われれば赤くなる。
       * - 「同じ語について書いている」ことは分かるが、「形式化した」ことは分からない
       *   （読み直しを強制するだけである。cycle 36 step 4 の鈴と同じ性質）。
       */
      readonly crossFilePhrase: string;
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
        crossFilePhrase: "$\\kappa_n$ の独立計算",
      },
      { leanFragment: "定理 X の付値計算そのもの", kind: "未形式化", ledgerFragment: "付値",
        crossFilePhrase: "定理 X の付値計算", },
    ],
  },
  {
    // cycle 50 step 2 で新設。塔の全域木数を指標ごとの行列式の積へ繋ぐ段の芯を書いた file。
    file: "KappaProductFormula.lean",
    declarationsAtReview: 20,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "$\\kappa_n$ の独立計算 に残るのは、2 通りのラプラシアンの同定である",
        kind: "未形式化",
        ledgerFragment: "$\\kappa_n$ の独立計算",
        // Bouquet / EllTwo の側も同じ語を未形式化として挙げている（2 つが「まだ書いていない」で一致する）。
        crossFilePhrase: "$\\kappa_n$ の独立計算",
      },
      {
        leanFragment: "の 2 変数の塔への当てはめ",
        kind: "未形式化",
        ledgerFragment: "2 変数の塔への当てはめ",
        crossFilePhrase: "本ファイルの結論を 2 回当てる",
      },
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
      { leanFragment: "系 Q7 の $r=2$ そのもの", kind: "未形式化", ledgerFragment: "系 Q7",
        crossFilePhrase: "系 Q7 の $r=2$", },
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
      { leanFragment: "定理 G2 の 1", kind: "未形式化", ledgerFragment: "定理 G2 の 1",
        crossFilePhrase: "定理 G2 の 1（Galois 不変性）", },
      { leanFragment: "系 Q7 の $r=2$", kind: "未形式化", ledgerFragment: "系 Q7",
        crossFilePhrase: "系 Q7 の $r=2$", },
      { leanFragment: "そのもの（voltage グラフのラプラシアン行列式）", kind: "未形式化", ledgerFragment: "matrix-tree",
        crossFilePhrase: "voltage グラフのラプラシアン行列式", },
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
    items: [{ leanFragment: "命題 J2′ の", kind: "未形式化", ledgerFragment: "命題 J2′",
        crossFilePhrase: "命題 J2′ の同値", }],
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
      { leanFragment: "の**導出**", kind: "未形式化", ledgerFragment: "導出",
        crossFilePhrase: "4 通りの閉形式の導出", },
      { leanFragment: "matrix-tree 定理が要り", kind: "未形式化", ledgerFragment: "matrix-tree",
        crossFilePhrase: "$\\kappa_n$ の独立計算", },
    ],
  },
  {
    file: "GeneralTowerClosedForm.lean",
    declarationsAtReview: 24,
    heading: "形式化しなかったもの（mathlib の欠落か配線か）",
    items: [
      { leanFragment: "定理 G2 の 1", kind: "未形式化", ledgerFragment: "定理 G2 の 1",
        crossFilePhrase: "定理 G2 の 1（Galois 不変性）", },
      { leanFragment: "定理 G2 の 3", kind: "未形式化", ledgerFragment: "定理 G2 の 3",
        crossFilePhrase: "定理 G2 の 3", },
      { leanFragment: "非依存性", kind: "未形式化", ledgerFragment: "非依存性",
        crossFilePhrase: "$A_{\\mathrm{gen}}$ の $L$ 非依存性", },
      { leanFragment: "Matrix–Tree 定理", kind: "未形式化", ledgerFragment: "matrix-tree",
        crossFilePhrase: "voltage グラフのラプラシアン行列式", },
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
        // cycle 38 step 1 で $\det G\neq0$ を、cycle 46 step 1 で Gauss 降下の配線を書いた。
        leanFragment: "命題 W\\* は依然 部分的である。残っているのは 1 つで",
        kind: "形式化済み",
        witness: "det_weightedGram_mu_of_integral",
      },
    ],
  },
  {
    file: "WStarReducibleDescent.lean",
    declarationsAtReview: 4,
    heading: "形式化しなかったもの",
    items: [
      {
        // cycle 39 step 3 で $\eta$ が零因子でないことが無平方性から出た。
        leanFragment: "が実際に零因子でないこと",
        kind: "形式化済み",
        witness: "det_weightedGram_ne_zero_of_factorization",
      },
      {
        leanFragment: "の可約な場合",
        kind: "形式化済み",
        witness: "det_weightedGram",
      },
      {
        // cycle 46 step 1: 本文が述べているのは最小元の形であり、それは書いてある。
        // 正準な代表を選ぶことは本文の主張の内容ではない。
        leanFragment: "の値を存在の形で述べる",
        kind: "形式化済み",
        witness: "isLeast_isPLevel",
      },
    ],
  },
  {
    file: "WStarPowerBasisInstance.lean",
    declarationsAtReview: 4,
    heading: "形式化しなかったもの",
    items: [
      {
        // cycle 38 step 1 で `WStarSquarefreeNonzero.lean` に書いた。
        // 本ファイルには無いままなので、指し先を明示して「参照だけ」へ移す。
        leanFragment: "を直接導く段",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "WStarSquarefreeNonzero.lean" },
      },
    ],
  },
  {
    // cycle 38 step 4 の「見出しの棚卸し」が見つけた 10 本目。
    // **こちらの手作業の走査は 9 本しか数えておらず、この 1 本を落としていた。そう書く。**
    file: "PropBTracePeriod.lean",
    declarationsAtReview: 17,
    heading: "形式化していない段（正直に明記する）",
    items: [
      {
        leanFragment: "への係数拡大",
        kind: "参照だけ",
        referent: { kind: "規約", target: "README.md" },
      },
      {
        leanFragment: "ことは**手計算**",
        kind: "参照だけ",
        referent: { kind: "規約", target: "README.md" },
      },
    ],
  },
  // --- cycle 38 step 4: 見出しの言い方で照合から外れていた 9 本を登録する ---
  {
    file: "DualityPAdicFiniteL.lean",
    declarationsAtReview: 25,
    heading: "形式化していないもの（正直に書く）",
    items: [
      {
        // 本文の「有限手続きで計算できる」は命題ではないので Lean の定理にしていない
        // （命題 A (4) と同じ扱い。判断は lean/README.md の表に記録してある）。
        leanFragment: "計算可能性の言明そのもの",
        kind: "参照だけ",
        referent: { kind: "規約", target: "README.md" },
      },
      {
        leanFragment: "本文の $a^{\\mathrm{red}}_L$ は $d$ 変数の主張である",
        kind: "未形式化",
        ledgerFragment: "$d\\ge2$",
        crossFilePhrase: "簡約周期点数の $d\\ge2$ の場合",
      },
      {
        leanFragment: "の塔の非自明性の判定",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "PropV.lean" },
      },
    ],
  },
  {
    file: "MultigraphLaplacian.lean",
    declarationsAtReview: 7,
    heading: "何が入っていないか（matrix-tree 定理までに残る段）",
    externalEntry: "Kirchhoff の matrix-tree 定理（グラフの全域木を数える定理）",
    items: [
      {
        leanFragment: "Cauchy–Binet の公式",
        kind: "形式化済み",
        witness: "det_mul_eq_sum_over_subsets",
      },
      {
        leanFragment: "符号付き接続行列の小行列式が $0$ か $\\pm1$ であること",
        kind: "形式化済み",
        witness: "det_submatrix_eq_one_or_neg_one",
      },
      {
        leanFragment: "から出る Kirchhoff の定理",
        kind: "形式化済み",
        witness: "det_mul_transpose_eq_card_spanning",
      },
      {
        leanFragment: "導来グラフのラプラシアンを指標で分解し",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "CharacterDecomposition.lean" },
      },
    ],
  },
  {
    file: "PeriodicPointResultant.lean",
    declarationsAtReview: 19,
    heading: "形式化していないもの（正直に書く）",
    items: [
      {
        leanFragment: "が 1 の冪根の組で零点をもたなければ",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "DualityPAdicFiniteL.lean" },
      },
      {
        // 同上。手続きの主張は命題ではない。
        leanFragment: "という決定可能性の主張",
        kind: "参照だけ",
        referent: { kind: "規約", target: "README.md" },
      },
    ],
  },
  {
    file: "PropB.lean",
    declarationsAtReview: 4,
    heading: "形式化していない主張（**逆方向＝ $\\pi(p,1)\\mid\\operatorname{lcm}$**）",
    items: [
      {
        // 命題 B そのものは `PropBTracePeriod.lean` が両方向を持つ（本文の紐づけもそちら）。
        // 本ファイルの記述は、その前段の部分的な形式化についてのものである。
        leanFragment: "は形式化していない",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "PropBTracePeriod.lean" },
      },
      {
        leanFragment: "障害は mathlib の欠落ではない",
        kind: "参照だけ",
        referent: { kind: "ログ", target: "mathlib-gap-survey-cycle24.log" },
      },
      {
        leanFragment: "組み立ての作業量",
        kind: "参照だけ",
        referent: { kind: "ログ", target: "mathlib-gap-survey-cycle24.log" },
      },
      {
        leanFragment: "等式は未形式化",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "PropBTracePeriod.lean" },
      },
    ],
  },
  {
    file: "PropCPeriod.lean",
    declarationsAtReview: 14,
    heading: "形式化していない主張",
    items: [
      {
        // 台帳は 命題 C について「等号は人手証明のとおり一般に偽なので形式化対象ではない」と
        // 判断している。対象外の判断なので規約を指す。
        leanFragment: "は形式化していない",
        kind: "参照だけ",
        referent: { kind: "規約", target: "README.md" },
      },
      {
        // 最小周期そのものは `TracePeriodAssembly.lean` が `IsLeast` で持っている。
        leanFragment: "という概念自体を",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "TracePeriodAssembly.lean" },
      },
    ],
  },
  {
    file: "PropCTracePeriod.lean",
    declarationsAtReview: 22,
    heading: "形式化していない主張（理由つき）",
    items: [
      {
        leanFragment: "は形式化していない",
        kind: "形式化済み",
        witness: "isLeast_isPLevel",
      },
      {
        leanFragment: "そのものの最小性・純周期性",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "PropCPeriod.lean" },
      },
    ],
  },
  {
    file: "TracePeriodAssembly.lean",
    declarationsAtReview: 24,
    heading: "形式化していないもの（正直に書く）",
    items: [
      {
        leanFragment: "は cycle 37 step 3 で埋めた",
        kind: "形式化済み",
        witness: "dvd_of_mulVec_dvd_of_isPLevel",
      },
      {
        // cycle 44 step 1（射影の同定）と cycle 48 step 1（$w^*=0$ の同値）で入った。
        leanFragment: "命題 C′ の $\\det G=\\operatorname{disc}",
        kind: "形式化済み",
        witness: "algHomOfDvd_mu_eq_multiplicity",
      },
      {
        leanFragment: "の最良性と",
        kind: "未形式化",
        ledgerFragment: "のしきい値 $w^*+1$ の最良性",
        crossFilePhrase: "しきい値 $w^*+1$ の最良性（反例の族）",
      },
    ],
  },
  {
    file: "WStarElementaryDivisors.lean",
    declarationsAtReview: 19,
    heading: "何が入って、何が入っていないか（命題 W\\* の 3 段のうち第 2 段）",
    items: [
      { leanFragment: "の定義そのもの（`wStarOfCoeffs`）", kind: "形式化済み",
        witness: "isLeast_isPLevel" },
      { leanFragment: "（`det_weightedGram`）", kind: "形式化済み", witness: "det_weightedGram" },
      { leanFragment: "を行列の等式にしたもの", kind: "形式化済み",
        witness: "eulerMatrix_mul_weightedGram" },
      { leanFragment: "可逆な取り替えで像に対する $p$ 進の条件が変わらないこと", kind: "形式化済み",
        witness: "isPLevel_range_comp" },
      {
        leanFragment: "の整数への降下",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "WStarIntegralDescent.lean" },
      },
      {
        leanFragment: "が可約な場合",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "EulerDualBasisCommRing.lean" },
      },
    ],
  },
  {
    file: "WStarIntegralDescent.lean",
    declarationsAtReview: 11,
    heading: "何が入っていないか（命題 W\\* が完了でない理由）",
    items: [
      {
        leanFragment: "その可換環版は cycle 36 step 1 で書いた",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "EulerDualBasisCommRing.lean" },
      },
    ],
  },
  {
    // cycle 38 step 3 で新設。命題 C″ (3) の構造の主張を書いた。
    file: "TracePeriodStructure.lean",
    declarationsAtReview: 1,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "の最良性",
        kind: "未形式化",
        ledgerFragment: "のしきい値 $w^*+1$ の最良性",
        crossFilePhrase: "しきい値 $w^*+1$ の最良性（反例の族）",
      },
      {
        leanFragment: "として構成する段",
        kind: "未形式化",
        ledgerFragment: "付値の最小として構成する段は書いておらず",
        crossFilePhrase: "$g_m$ を付値の最小として構成する段",
      },
    ],
  },
  {
    // cycle 38 step 2 で新設。巡回群による指標分解の芯を書いた。
    // cycle 39 step 2 で残していた 3 つを `CharacterDecompositionTwoVariable.lean` へ書いたので、
    // この節の残りは「一般の $\Gamma$」と「基礎グラフの型」の 2 つになった。
    file: "CharacterDecomposition.lean",
    declarationsAtReview: 19,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "一般の有限アーベル群",
        kind: "未形式化",
        ledgerFragment: "一般の有限アーベル群",
        crossFilePhrase: "一般の有限アーベル群による指標分解",
      },
      {
        leanFragment: "基礎グラフを型として持っていない",
        kind: "未形式化",
        ledgerFragment: "基礎グラフを型として持っていない",
        crossFilePhrase: "voltage グラフの基礎グラフの型",
      },
    ],
  },
  {
    // cycle 39 step 2 で新設。2 変数へ重ね、導来グラフのラプラシアンへ当て、評価値と結んだ。
    file: "CharacterDecompositionTwoVariable.lean",
    declarationsAtReview: 18,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "一般の有限アーベル群",
        kind: "未形式化",
        ledgerFragment: "一般の有限アーベル群",
        crossFilePhrase: "一般の有限アーベル群による指標分解",
      },
      {
        leanFragment: "基礎グラフを型として持っていない",
        kind: "未形式化",
        ledgerFragment: "基礎グラフを型として持っていない",
        crossFilePhrase: "voltage グラフの基礎グラフの型",
      },
    ],
  },
  {
    // cycle 39 step 3 で新設。rad(χ) と μ の構成を書いた。
    // cycle 40 step 1 で、残っていた「χ から族を取り出す段」が別ファイルで書かれたので状態を改めた。
    file: "WStarRadicalMultiplicity.lean",
    declarationsAtReview: 15,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "から族",
        kind: "形式化済み",
        witness: "exists_monic_prime_factorization",
      },
    ],
  },
  {
    // cycle 40 step 4 で新設。岩澤分解の μ の段（Monsky と Cuoco–Monsky の第 1 段）を書いた。
    file: "IwasawaMuInvariant.lean",
    declarationsAtReview: 3,
    externalEntry: "Monsky の p 進冪級数の定理",
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "Monsky の Theorem 5.6 そのものは書いていない",
        kind: "未形式化",
        ledgerFragment: "残っているのは Theorem 5.6 の主張そのもの",
        crossFilePhrase: "Monsky の Theorem 5.6 の主張そのもの",
      },
      {
        leanFragment: "$\\mathbb{Z}_p^d$（$d\\ge2$）の場合は扱っていない",
        kind: "参照だけ",
        referent: { kind: "ログ", target: "mathlib-gap-survey-cycle40-external-engines.log" },
      },
    ],
  },
  {
    // cycle 41 step 3 で新設。岩澤分解を組み立て、λ が g から決まることを書いた。
    file: "IwasawaDecomposition.lean",
    declarationsAtReview: 5,
    externalEntry: "Monsky の p 進冪級数の定理",
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "Monsky の Theorem 5.6 の主張そのものは書いていない",
        kind: "未形式化",
        ledgerFragment: "残っているのは $\\mathrm{ord}$ の漸近そのものである",
        crossFilePhrase: "$\\mathrm{ord}$ の漸近を数える段",
      },
      {
        leanFragment: "$\\mathbb{Z}_p^d$（$d\\ge2$）は扱っていない",
        kind: "参照だけ",
        referent: { kind: "ログ", target: "mathlib-gap-survey-cycle40-external-engines.log" },
      },
    ],
  },
  {
    // cycle 40 step 3 で新設。命題 C″ (1) のしきい値の最良性の反例を書いた。
    file: "TracePeriodThresholdSharp.lean",
    declarationsAtReview: 22,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "全ての $k$ で破れる、という形にはしていない",
        kind: "未形式化",
        ledgerFragment: "全ての $k$ で破れる形",
        crossFilePhrase: "しきい値より下の全てのレベルで階段が破れること",
      },
      {
        leanFragment: "一般の $T$ についての配線",
        kind: "未形式化",
        ledgerFragment: "一般の $T$ についての配線",
        crossFilePhrase: "Gram 行列が一般の $T$ のトレースから来ることの配線",
      },
    ],
  },
  {
    // cycle 40 step 1 で新設。χ から相異なる既約因子の族と重複度を取り出す段を書いた。
    file: "WStarFactorExtraction.lean",
    declarationsAtReview: 10,
    heading: "形式化しなかったもの",
    items: [
      {
        // cycle 41 step 1 で $\mu$ の構成のほうは書いたので、残っているのは $G$ の同定である。
        // cycle 46 step 1 で $G$ の同定を書いた（WStarGramAssembly.lean）。
        leanFragment: "残っているのは $G$ の同定のほうである",
        kind: "形式化済み",
        witness: "trace_pow_eq_trace_mu_all",
      },
      {
        // cycle 46 step 1 で組み立てた（WStarGramAssembly.lean）。
        leanFragment: "$w^*$ の等式を組み立てる段",
        kind: "形式化済み",
        witness: "trace_pow_eq_trace_mu",
      },
    ],
  },
  {
    // cycle 41 step 1 で新設。本文の $\mu$ を構成し、$\det G=\pm N(\eta)$ を出した。
    file: "WStarMuGram.lean",
    declarationsAtReview: 12,
    heading: "形式化しなかったもの",
    items: [
      {
        // cycle 46 step 1 で書いた。
        leanFragment: "$\\chi$ の根の $N$ 乗和",
        kind: "形式化済み",
        witness: "trace_pow_eq_trace_mu_all",
      },
      {
        // cycle 46 step 1 で配線した（WStarGaussDescent.lean）。
        leanFragment: "その降下（Gauss）は仮定として受け取っている",
        kind: "形式化済み",
        witness: "squarefree_map",
      },
    ],
  },
  {
    // cycle 43 step 4 で新設。評価写像の構成（mathlib の eval₂Hom を線形位相の側から受け取る）。
    file: "IwasawaEvaluation.lean",
    externalEntry: "Monsky の p 進冪級数の定理",
    declarationsAtReview: 5,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "$\\sum_{\\zeta}v(\\varphi_\\zeta(f))=\\lambda n+O(1)$ の側",
        kind: "未形式化",
        ledgerFragment: "の側（Theorem 5.6 に残る最後の中身）",
        crossFilePhrase: "Theorem 5.6 に残る最後の中身",
      },
      {
        leanFragment: "$\\zeta-1$ が極大イデアルに属することの数論側の同定",
        kind: "形式化済み",
        witness: "IntegrableLattice.IwasawaRootOfUnity.sub_one_mem_maximalIdeal_of_pow_eq_one",
      },
    ],
  },
  {
    // cycle 44 step 4 で新設。zeta-1 が極大イデアルに属することを書いた。
    file: "IwasawaRootOfUnity.lean",
    externalEntry: "Monsky の p 進冪級数の定理",
    declarationsAtReview: 2,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "$\\sum_{\\zeta}v(\\varphi_\\zeta(f))=\\lambda n+O(1)$ の側",
        kind: "未形式化",
        ledgerFragment: "$\\sum_\\zeta v(\\varphi_\\zeta(f))=\\lambda n+O(1)$ の側である",
        crossFilePhrase: "Theorem 5.6 に残る最後の中身",
      },
    ],
  },
  {
    // cycle 42 step 5 で新設。Monsky の ord の漸近の第 3 段の半分を書いた。
    file: "IwasawaOrdCounting.lean",
    externalEntry: "Monsky の p 進冪級数の定理",
    declarationsAtReview: 2,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "評価写像そのものの構成",
        kind: "未形式化",
        ledgerFragment: "その評価が実際に存在すること",
        crossFilePhrase: "$\\mathbb{Z}_p[[X]]$ の元を $\\zeta-1$ で評価する写像の構成",
      },
      {
        leanFragment: "$\\sum_{\\zeta}v(\\varphi_\\zeta(f))=\\lambda n+O(1)$ の側",
        kind: "未形式化",
        ledgerFragment: "の側である",
        crossFilePhrase: "distinguished 多項式の $1$ の冪根での値の付値を数える段",
      },
    ],
  },
  {
    // cycle 42 step 4 で新設。命題 U の (U6) の残る側のうち、切り捨て付値の安定性を書いた。
    file: "TruncatedValuationStability.lean",
    declarationsAtReview: 3,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "$\\Phi^{[k]}$ が $\\mathcal{O}_k$ 係数の線形式であることの配線",
        kind: "未形式化",
        ledgerFragment: "$\\Phi^{[k]}$ が $\\mathcal{O}_k$ 係数の線形式であることの配線",
        crossFilePhrase: "$\\Phi^{[k]}$ が $\\mathcal{O}_k$ 係数の線形式であることの配線",
      },
    ],
  },
  {
    // cycle 42 step 3 で新設。代数側のトレースを行列のトレースへ移す橋を架けた。
    file: "WStarTracePowerBridge.lean",
    declarationsAtReview: 3,
    heading: "形式化しなかったもの",
    items: [
      {
        // cycle 45 step 4 で書いた（NewtonInitialValues.lean）。
        leanFragment: "同じ特性多項式をもつ 2 つの行列のトレース冪が一致すること",
        kind: "形式化済み",
        witness: "trace_pow_eq_of_charpoly_eq",
      },
      {
        // cycle 46 step 1 で書いた（WStarGramAssembly.trace_mu_pow_eq_sum）。
        leanFragment: "成分ごとの分解",
        kind: "形式化済み",
        witness: "trace_mu_pow_eq_sum",
      },
    ],
  },
  {
    // cycle 42 step 2 で新設。命題 T の段 3（不分岐性と Hensel 持ち上げ）を書いた。
    file: "PropTHenselLift.lean",
    declarationsAtReview: 4,
    heading: "形式化しなかったもの",
    items: [
      {
        // cycle 49 step 3: 根の側そのものは cycle 44 step 2 で入っており、
        // 残っているのは舞台の同定だけである（`PropTResidueRoot.lean` の項目と同じもの）。
        leanFragment: "剰余体が原始 $L$ 乗根を持つことの同定",
        kind: "未形式化",
        ledgerFragment: "完備化がこの舞台の形をしていること",
        crossFilePhrase: "2 の上での完備化が、この舞台の形",
      },
      {
        leanFragment: "段 4 との接続（$v(m_j)=1$）",
        kind: "未形式化",
        ledgerFragment: "段 4（Newton 多角形）との接続はこの段の内容ではない",
        crossFilePhrase: "段 4 との接続（$v(m_j)=1$）",
      },
    ],
  },
  {
    // cycle 42 step 1 で新設。$\det G$ を判別式と重み（ノルム）へ分ける段を書いた。
    file: "WStarGramDiscriminant.lean",
    declarationsAtReview: 4,
    heading: "形式化しなかったもの（実測つき）",
    items: [
      {
        // cycle 43 step 1・2 と cycle 44 step 1 で入った。
        leanFragment: "可約な場合の $N(\\mu)=\\prod_\\lambda m_\\lambda$",
        kind: "形式化済み",
        witness: "norm_mu_eq_prod_pow_natDegree",
      },
      {
        // cycle 47 step 1・cycle 48 step 1 で入った。
        leanFragment: "`Algebra.discr` と `Polynomial.discr` の一致",
        kind: "形式化済み",
        witness: "algebra_discr_eq_polynomial_discr",
      },
    ],
  },
  {
    // cycle 43 step 5 で新設。トレース冪の線形漸化式（Cayley–Hamilton の道）。
    file: "TracePowerRecurrence.lean",
    declarationsAtReview: 3,
    heading: "形式化しなかったもの",
    items: [
      {
        // cycle 45 step 4 で初期値が落ちた（NewtonInitialValues.lean）。
        leanFragment: "初期値の側",
        kind: "形式化済み",
        witness: "trace_pow_eq_of_charpoly_eq",
      },
    ],
  },
  {
    // cycle 44 step 3 で新設。対数微分の道が要求する Jacobi の公式を書いた。
    file: "JacobiFormula.lean",
    declarationsAtReview: 3,
    heading: "形式化しなかったもの",
    items: [
      {
        // cycle 45 step 4 で書いた（NewtonInitialValues.neg_derivative_charpolyRev_expand）。
        leanFragment: "対数微分から冪和を取り出す段",
        kind: "形式化済み",
        witness: "neg_derivative_charpolyRev_expand",
      },
    ],
  },
  {
    // cycle 43 step 3 で新設。命題 T の段 3 が要求する舞台（Hensel 的な局所環）を構成した。
    file: "HenselianStage.lean",
    declarationsAtReview: 5,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "その舞台の剰余体が原始 $L$ 乗根を持つこと",
        kind: "形式化済み",
        witness: "IntegrableLattice.PropTResidueRoot.isPrimitiveRoot_residue_of_odd",
      },
    ],
  },
  {
    // cycle 44 step 2 で新設。命題 T に残っていた「剰余体が原始 L 乗根を持つこと」を書いた。
    file: "PropTResidueRoot.lean",
    declarationsAtReview: 5,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "の 2 の上での完備化が、この舞台の形をしていること",
        kind: "未形式化",
        ledgerFragment: "完備化がこの舞台の形をしていること",
        crossFilePhrase: "2 の上での完備化が、この舞台の形",
      },
    ],
  },
  {
    // cycle 43 step 2 で新設。step 1 の素材を本文の $\mathbb{Q}[x]/(\rho)$ へ当てた。
    file: "PropCCrtWiring.lean",
    declarationsAtReview: 6,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "成分への射影で $\\mu$ の像が $a_i$ であること",
        kind: "形式化済み",
        witness: "IntegrableLattice.PropCMuComponent.algHomOfDvd_mu_eq_multiplicity",
      },
    ],
  },
  {
    // cycle 44 step 1 で新設。命題 C′ に残っていた「成分への射影で mu の像が a_i」を書いた。
    file: "PropCMuComponent.lean",
    declarationsAtReview: 10,
    heading: "形式化しなかったもの",
    items: [
      {
        // cycle 48 step 1 で組み立てた（部品は cycle 45・46 で揃っていた）。
        leanFragment: "が分離的、かつ全ての重複度で",
        kind: "形式化済み",
        witness: "wStar_eq_zero_iff_separable_and_not_dvd",
      },
      {
        leanFragment: "本文の整数行列 $(\\operatorname{Tr}T^{i+j})$ との同定",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "TracePowerRecurrence.lean" },
      },
    ],
  },
  {
    // cycle 46 step 3 で新設。命題 T の段 3 の舞台を混標数（Witt ベクトル環）で与えた。
    file: "PropTMixedWitness.lean",
    declarationsAtReview: 8,
    heading: "形式化しなかったもの",
    items: [
      {
        // cycle 48 step 2 で測り直した。同型は要らず、要るのは付値の位相が m 進位相であることである。
        leanFragment: "の完備化がこの舞台であることの同定",
        kind: "未形式化",
        ledgerFragment: "付値の位相が $\\mathfrak m$ 進位相であること",
        crossFilePhrase: "付値の位相が $\\mathfrak m$ 進位相であること",
      },
    ],
  },
  {
    // cycle 46 step 2 で新設。判別式と分離性の同値を書いた。
    file: "PropCDiscSeparable.lean",
    declarationsAtReview: 4,
    heading: "形式化しなかったもの",
    items: [
      {
        // cycle 47 step 1・cycle 48 step 1 で入った。
        leanFragment: "本文の $\\operatorname{disc}(\\rho)$ が `Polynomial.discr` であること",
        kind: "形式化済み",
        witness: "algebra_discr_eq_polynomial_discr",
      },
    ],
  },
  {
    // cycle 47 step 4 で新設。格子周長の第 1 段（線分の格子長とその加法性）を書いた。
    file: "LatticeSegmentLength.lean",
    declarationsAtReview: 5,
    heading: "形式化しなかったもの（実測つき）",
    items: [
      {
        leanFragment: "**格子周長そのもの**（凸格子多角形の辺への分解と、その総和）",
        kind: "未形式化",
        ledgerFragment: "系 W7",
        crossFilePhrase: "系 W7",
      },
      {
        leanFragment: "の不等式そのもの**（$b\\le\\frac12\\operatorname{per}$）",
        kind: "未形式化",
        ledgerFragment: "系 W7",
        crossFilePhrase: "$b\\le\\frac12\\operatorname{per}$",
      },
    ],
  },
  {
    // cycle 47 step 3 で新設。命題 J2′ の同値のうち代数だけで閉じる側を書いた。
    file: "PropJ2PrimePolarization.lean",
    declarationsAtReview: 4,
    heading: "形式化しなかったもの（実測つき）",
    items: [
      {
        leanFragment: "と $k=2$（$\\bar g$ の最低次数が $2$ であること）の同値",
        kind: "未形式化",
        ledgerFragment: "命題 J2′ の同値",
        crossFilePhrase: "命題 J2′ の同値",
      },
      {
        // $\ell=2$ の側（$\bar A_2$ が平方でないことの判定）。同じ配線の先にある。
        leanFragment: "の側**（破れる $\\iff\\bar A_2$ が $\\mathbb{F}_2[T,S]$ の平方でない）",
        kind: "未形式化",
        ledgerFragment: "命題 J2′ の同値",
        crossFilePhrase: "$\\ell=2$ の側（平方かどうかの判定）",
      },
    ],
  },
  {
    // cycle 47 step 1 で新設。判別式とノルムの関係を分離性なしで書いた。
    file: "PropCDiscrIdentification.lean",
    declarationsAtReview: 3,
    heading: "形式化しなかったもの（実測つき）",
    items: [
      {
        // 段 3 と `Polynomial.resultant_deriv` を繋ぐと 2 つの判別式が一致する。
        // その手前の 1 段（終結式が剰余環のノルムであること）が残っている。
        // cycle 48 step 1 で書いた。命題 C′ はこれで閉じた。
        leanFragment: "N_{A/R}(g(\\theta))=\\operatorname{Res}(\\rho,g)$（モニックな $\\rho$ について）",
        kind: "形式化済み",
        witness: "norm_aeval_eq_resultant",
      },
    ],
  },
  {
    // cycle 46 step 1 で新設。$\mathbb{Q}[x]$ 側の無平方性への降下（Gauss）を配線した。
    file: "WStarGaussDescent.lean",
    declarationsAtReview: 4,
    heading: "形式化しなかったもの",
    items: [
      {
        // 根基の構成と無平方性は cycle 39 step 3 で書いてある。
        leanFragment: "が $\\mathbb{Z}[x]$ の側で無平方であること自体",
        kind: "形式化済み",
        witness: "squarefree_rad",
      },
    ],
  },
  {
    // cycle 46 step 1 で新設。本文の $G$ と代数の Gram 行列の同定を書いた。
    file: "WStarGramAssembly.lean",
    declarationsAtReview: 19,
    heading: "形式化しなかったもの",
    items: [
      {
        // 本文の転送行列の構成そのものは 命題 C′ の側の事柄である。
        leanFragment: "が本文の転送行列であること",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "TracePeriodStructure.lean" },
      },
    ],
  },
  {
    // cycle 43 step 1 で新設。直積代数のノルムの分解（中国剰余の代数側）を書いた。
    file: "ProductAlgebraNorm.lean",
    declarationsAtReview: 6,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "互いに素なイデアルの族として与える段",
        kind: "形式化済み",
        witness: "IntegrableLattice.PropCCrtWiring.pairwise_isCoprime_of_irreducible",
      },
    ],
  },
  {
    // cycle 38 step 1 で新設。無平方性から $\det G\neq0$ を出す段を書いた。
    file: "WStarSquarefreeNonzero.lean",
    declarationsAtReview: 4,
    heading: "形式化しなかったもの",
    items: [
      {
        // cycle 39 step 3 で構成と零因子でないことを書いた。
        leanFragment: "重複度 $a_i$ をとる元）が零因子でないこと",
        kind: "形式化済み",
        witness: "multWeight_mem_nonZeroDivisors",
      },
      {
        // cycle 39 step 3 で根基の構成と無平方性を書いた。
        leanFragment: "が無平方であること自体",
        kind: "形式化済み",
        witness: "squarefree_rad",
      },
    ],
  },
  {
    file: "TracePeriodWStarLift.lean",
    declarationsAtReview: 6,
    heading: "形式化しなかったもの",
    items: [
      {
        // cycle 49 step 2 で入った（鎖は仮定として受け取る。Smith 標準形の存在は使わない）。
        leanFragment: "の言う「$G$ の最大単因子」であること",
        kind: "形式化済み",
        witness: "wStarOfCoeffs_eq_factorization_last",
      },
      {
        // cycle 44 step 1 で入った。
        leanFragment: "成分への射影で $\\mu$ の像が $a_i$ であることの同定",
        kind: "形式化済み",
        witness: "algHomOfDvd_mu_eq_multiplicity",
      },
    ],
  },
  {
    // cycle 49 step 2 で新設。本文の単因子の鎖の言葉との一致を書いた file。
    file: "PropCElementaryDivisorChain.lean",
    declarationsAtReview: 9,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "Smith 標準形の鎖の存在そのもの",
        kind: "参照だけ",
        referent: { kind: "ログ", target: "mathlib-gap-survey-cycle49-smith-chain.log" },
      },
    ],
  },
  {
    // cycle 49 step 3 で新設。m 進完備化の側から舞台を書き下した file。
    file: "PropTAdicStage.lean",
    declarationsAtReview: 4,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "本文の付値による完備化が、この $\\mathfrak m$ 進完備化と同じものであること",
        kind: "未形式化",
        ledgerFragment: "付値の位相が $\\mathfrak m$ 進位相であること",
        crossFilePhrase: "付値の位相が $\\mathfrak m$ 進位相であること",
      },
    ],
  },
  {
    // cycle 49 step 4 で新設。全余因子が等しいことの代数の側を書いた file。
    file: "AllCofactorsEqual.lean",
    declarationsAtReview: 10,
    heading: "形式化しなかったもの",
    items: [
      // cycle 50 step 1 で連結性の側を書いたので、未形式化から形式化済みへ移す。
      {
        leanFragment: "核が定数ベクトルだけであること（連結性の側）",
        kind: "形式化済み",
        witness: "ker_eq_const_of_reachOn",
      },
    ],
  },
  {
    // cycle 50 step 1 で新設。全余因子が等しいことの連結性の側を書いた file。
    file: "LaplacianKernelConnected.lean",
    declarationsAtReview: 8,
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "余因子の値そのものが全域木数であること",
        kind: "形式化済み",
        witness: "det_mul_transpose_eq_card_spanning",
      },
      {
        leanFragment: "連結でない場合",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "SpanningConnectivity.lean" },
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
      // cycle 38 step 2 で `CharacterDecomposition.lean` に芯を書いたので、指し先を持つ形へ移す。
      { leanFragment: "指標分解", kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "CharacterDecomposition.lean" }, },
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
      // cycle 38 step 2 で `CharacterDecomposition.lean` に芯を書いたので、指し先を持つ形へ移す。
      { leanFragment: "指標分解", kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "CharacterDecomposition.lean" }, },
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
    // cycle 48 step 3 で新設。補題 W2 の (iv) ⇒ (iii) を書いた。
    file: "PropKW2Converse.lean",
    declarationsAtReview: 12,
    heading: "形式化しなかったもの",
    items: [
      {
        // 判定を通る u が S_infty の点であることは SInfinityDecision.lean の側である。
        leanFragment: "(iv) の判定と $S_\\infty$ の点との対応",
        kind: "参照だけ",
        referent: { kind: "lean ファイル", target: "SInfinityDecision.lean" },
      },
      {
        leanFragment: "$j^*$（重複度）",
        kind: "未形式化",
        ledgerFragment: "(K4) の重複度の主張",
        crossFilePhrase: "$j^*$（重複度）",
      },
    ],
  },
  {
    file: "SInfinityDecision.lean",
    declarationsAtReview: 23,
    heading: "形式化しなかったもの（mathlib の欠落か配線か）",
    items: [
      // cycle 48 step 3 で書いた（PropKW2Converse.lean）。
      { leanFragment: "補題 W2 の (iv)", kind: "形式化済み", witness: "dvd_of_psi_eq_zero" },
      { leanFragment: "定理 W4 の", kind: "未形式化", ledgerFragment: "定理 W4",
        crossFilePhrase: "定理 W4 の主張そのもの", },
      { leanFragment: "系 W7", kind: "未形式化", ledgerFragment: "系 W7",
        crossFilePhrase: "系 W7", },
    ],
  },
  {
    file: "TowerTypeCoefficients.lean",
    declarationsAtReview: 8,
    heading: "形式化しなかったもの（なぜ足りないのか）",
    items: [
      { leanFragment: "定理 J7 の主張そのもの", kind: "未形式化", ledgerFragment: "定理 J7",
        crossFilePhrase: "定理 J7 の主張そのもの", },
      { leanFragment: "の係数を「読み取る」段の一般形", kind: "未形式化", ledgerFragment: "読み取る",
        crossFilePhrase: "$O$ 記法を型にしていない", },
    ],
  },
];

/** 節の見出しと箇条書きを取り出す。箇条書きは行頭 `* ` で始まる塊とする。 */
/**
 * **残り一覧の節と認める見出しの語**（cycle 38 step 4 で全数へ広げた）。
 *
 * cycle 37 総括は「照合の外に居るファイルが 1 つある」と書いていたが、
 * **cycle 38 の着手時の実測では 9 本あった。** 認めていた見出しが
 * 「形式化しなかったもの…」と「形式化した残りの段…」の 2 通りだけで、
 * それ以外の言い方で形式化していない事柄を書いているファイルが、
 * 節を持たないものとして素通りしていたためである。
 *
 * **見出しの言い方で検査から外れる道を塞ぐには、認める語を実態に合わせて広げ、
 * 広げた結果として現れたファイルを全部台帳へ登録するしかない。**
 * ここに語を足すたびに、その語を使っているファイルが登録を要求される
 * （登録しなければ「台帳に無いファイル」で赤くなる）。
 *
 * **限界**: これは網羅ではない。**まったく新しい言い方をすれば、やはり素通りする。**
 * 塞げるのは「いま実在する言い方」までであり、`verify-lean-remaining.ts` の
 * 「見出しの棚卸し」がその外側を人へ見せる役をもつ。
 */
export const REMAINING_SECTION_HEADINGS = [
  "形式化しなかったもの",
  "形式化した残りの段",
  "形式化していないもの",
  "形式化していない主張",
  "何が入っていないか",
  "何が入って、何が入っていないか",
  "形式化していない段",
] as const;

/**
 * **見出しが残り一覧を宣言しているかの判定に使う語**（`verify-lean-remaining.ts` の棚卸し）。
 * これに当たるのに `REMAINING_SECTION_HEADINGS` のどれでも始まらない見出しは、
 * **新しい言い方で書かれた残り一覧の疑いがある**ので人へ見せる。
 */
export const GAP_HEADING_HINTS = [
  "形式化していない",
  "形式化しなかった",
  "入っていない",
  "残る段",
  "未形式化",
] as const;

export function parseRemainingSection(
  source: string,
): { heading: string; bullets: string[] } | null {
  const alternatives = REMAINING_SECTION_HEADINGS.map((h) => `${h}[^\\n]*`).join("|");
  const match = new RegExp(`^## (${alternatives})$([\\s\\S]*?)(?=^-\\/$|^## )`, "m").exec(source);
  if (!match) return null;
  const body = match[2]!;
  // 箇条書きの記号は `*` `-` と番号付き（`1.`）を認める（実測で 3 通りとも使われている）。
  const bullets = [...body.matchAll(/^(?:[*-] |\d+\. )([\s\S]+?)(?=^(?:[*-] |\d+\. )|\s*$)/gm)].map((m) =>
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
  /**
   * その欄について、この語が 対象外（別の欄で数えている）と宣言されているか（cycle 49 step 2）。
   * 同じ file が 2 つの欄へ紐づき、項目が片方の欄の残りでしかない場合に使う。
   * 宣言先の実在は「閉じる前提の検査」が確かめている。
   */
  readonly closingExempt?: (block: string, phrase: string) => boolean;
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
  const { entry, section, linked, externalText = null, referentExists, declarationExists,
    closingExempt } = input;
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
      if (l.state !== "完了") continue;
      // cycle 49 step 2: 同じ file が 2 つの欄へ紐づくとき、項目が片方の欄の残りでしかない場合がある。
      // 「閉じる前提の検査」がその欄について 対象外（別の欄で数えている）を宣言していれば通す
      // （宣言先の実在はあちらが確かめている。ここで二重に赤くしない）。
      if (closingExempt?.(l.block, item.crossFilePhrase) === true) continue;
      violations.push(`[残りがあるのに完了] ${l.block} — ${entry.file} が未形式化の項目を挙げている`);
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
/**
 * **別のファイルが同じ事柄を書いていないか**（cycle 37 step 4）。
 *
 * `未形式化` の項目の語が、他のファイルの本文（そのファイル自身の残り一覧を除く）に現れたら違反。
 * ただし現れた側も同じ語を `未形式化` として宣言しているなら、2 つが一致しているので通す。
 */
export function auditCrossFilePhrase(
  owner: string,
  phrase: string,
  otherFile: string,
  otherDeclaresUnformalized: boolean,
): string | null {
  if (otherDeclaresUnformalized) return null;
  return (
    `[別のファイルが同じ事柄を書いている] ${owner} の「${phrase}」— ` +
    `${otherFile} が同じ語について書いている。` +
    `そちらで形式化したのなら、この項目の状態を直すこと（未形式化のままなら語を絞ること）`
  );
}

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

/**
 * **検査 F（形式化の被覆）の型と台帳**。
 *
 * ## 目標（2026-08-03 ユーザー方針。解除されるまで有効）
 *
 * > **論文の主張を全数 Lean 形式化することを目標とする。**
 *
 * 一部の形式化で足れりとしない。したがって**未形式化の件数を毎サイクル出す**——
 * 証明の欠落や機械検証できない免除の件数を毎回出しているのと同じ扱いにして、
 * 放置されたら見えるようにする。
 *
 * ## 状態の 3 語（`lean/README.md` の表と同じ語彙）
 *
 * - `完了` — その主張の内容が Lean で証明されている。
 * - `部分的` — 一部だけ。**何が残っているかを `remaining` に書く**（型で必須）。
 * - `未着手` — まだ手を付けていない、または原理的に難しい。
 *   **なぜかを `reason` に書く**（型で必須）。「難しそう」は理由ではない。
 *   mathlib に無いことが理由なら、**何をどう調べて無いと判断したか**を書く
 *   （先例: `lean/README.md` の「mathlib 欠落調査の一次情報」。8264 ファイルを 3 段で引いている）。
 *
 * ## 機械が確かめること
 *
 * 1. **本文の `theorem` / `claim` ブロックが 1 つ残らず台帳にあること。** 黙って落とせない。
 * 2. **台帳の登録が本文に実在すること。** 改名・削除で宣言が浮いたら赤くなる。
 * 3. **`完了` と `部分的` は、そのブロックが Lean の定理名を 1 つ以上持つこと。**
 *    形式化したと言うなら、読者が辿れる先が要る。
 * 4. **`未着手` は Lean の定理名を持たないこと。** 持っているなら少なくとも `部分的` である。
 * 5. **本文が宣言する Lean の定理名が、`lean/` に実在すること。**
 *
 * ## 機械が確かめられないこと（正直に書く）
 *
 * - **`完了` が本当に完了かは機械で確かめられない。** 「その主張の内容が形式化されている」は
 *   人の判断である。この検査が保証するのは、判断が**書かれていること**と、
 *   書かれた判断が**腐っていないこと**だけである。
 * - 同じ理由で、`部分的` の `remaining` が実態と合っているかも確かめられない。
 */

export type CoverageState = "完了" | "部分的" | "未着手";

export type CoverageEntry =
  | { readonly block: string; readonly state: "完了"; readonly note?: string }
  | { readonly block: string; readonly state: "部分的"; readonly remaining: string }
  | { readonly block: string; readonly state: "未着手"; readonly reason: string };

/**
 * 初期値は cycle 27 の実測。状態は `lean/README.md` の命題ごとの表を正本として写し、
 * 表に無いもの（本文にしかないブロック）はその場で判定した。
 */
export const FORMALIZATION_COVERAGE: readonly CoverageEntry[] = [
  {
    block: "paper_022_claim_resultant",
    state: "部分的",
    remaining:
      "cycle 29 で「1 の冪根の上の積＝終結式」という claim の内容そのものを d = 1 と d = 2 で" +
      "形式化した（PeriodicPointResultant.lean）。d = 2 は d = 1 の補題を 2 回使う形で書いてあり、" +
      "「終結式を d 回入れ子にすればよい」の中身がそこに出ている。" +
      "残るのは一般の d である。素材の欠落は無い（`Polynomial.resultant_eq_prod_eval` は mathlib に在る）が、" +
      "反復多項式環 $R[z_1]\\cdots[z_d]$ を $d$ について再帰で作る型" +
      "（型とその環構造を同時に決める）をこちらが持っていない。" +
      "なお PropV.lean は $a_L$ を終結式そのものとして定義したうえで " +
      "$a_{p^n}\\equiv P(1,\\dots,1)^{p^{dn}}\\pmod p$ を d = 1, 2 で証明している。",
  },
  {
    block: "paper_031_theorem_lsw",
    state: "未着手",
    reason:
      "エントロピー＝Mahler 測度（Lind–Schmidt–Ward）は本論文の外の既知定理であり、本論文は引用しかしていない。" +
      "**mathlib の欠落は「Mahler 測度が無い」ではなく「多変数の Mahler 測度が無い」である**" +
      "（2026-08-03 実測。lean/README.md と同じ 3 段の引き方、mathlib `520045ab14` の 8264 ファイル: " +
      "連結語 `MahlerMeasure` 3 件・語幹 `mahler` の内容 5 件・ファイル名 3 件。" +
      "`Mathlib/Analysis/Polynomial/MahlerMeasure.lean` は 1 変数 `ℂ[X]`、" +
      "`Mathlib/NumberTheory/MahlerMeasure.lean` は 1 変数 `ℤ[X]` で、" +
      "**どちらも `MvPolynomial` を 1 度も使っていない**）。" +
      "本論文が要るのは 2 変数のスペクトル曲線の Mahler 測度なので、そこから要る。",
  },
  {
    block: "paper_041_theorem_periodicity",
    state: "完了",
    note: "命題 A (1)(2)(3)。(4) は計算可能性の主張であって命題ではないので対象外。",
  },
  {
    block: "paper_042_theorem_pi_p1",
    state: "完了",
    note: "命題 B の訂正後のステートメントについて等式・両方向。原ステートメントが偽であることも形式化してある。",
  },
  {
    block: "paper_043_theorem_bound",
    state: "完了",
    note: "命題 C の整除方向。等号は人手証明のとおり一般に偽なので形式化対象ではない。",
  },
  {
    block: "paper_043b_theorem_trace_bound",
    state: "部分的",
    remaining:
      "cycle 29 で上界の主張そのものを組み立てた（TracePeriodAssembly.lean の tracePeriod_propC_bound）。" +
      "$\\pi_{\\mathrm{tr}}(p,k)\\mid p^{k-1}\\pi_{\\mathrm{tr}}(p,w^*+1)$ を、" +
      "$k>w^*+1$ では梯子の反復から、$k\\le w^*+1$ では単調性から出す形で書いてある。" +
      "その途中で、人手証明が暗黙に使っていた「最小周期は任意の周期を割る」を独立に証明した。" +
      "残るのは $w^*$ の側である——Gram 行列 $G$ の最大単因子という定義そのものと、" +
      "$\\det G=\\operatorname{disc}(\\rho)\\cdot\\prod_\\lambda m_\\lambda$、および " +
      "$w^*=0$ の同値。いずれも整数行列の単因子（Smith 標準形）が要り、mathlib に無い" +
      "（`Module.Basis.SmithNormalForm` は部分加群の基底の形であって行列の単因子ではない。" +
      "cycle 29 の欠落調査で再確認）。上界の証明で $w^*$ が果たす役割は仮定として型に出してある。",
  },
  {
    block: "paper_044_theorem_newton",
    state: "部分的",
    remaining:
      "命題 N は下界方向のみ。上界方向は Skolem–Mahler–Lech / Strassmann が mathlib に無く、" +
      "鋭い下界は Newton 恒等式の行列トレースへの接続が要り、Newton 多角形と固有値の接続は " +
      "$\\overline{\\mathbb{Q}_p}$ の付値が要る。",
  },
  { block: "paper_045_theorem_lte", state: "完了", note: "命題 L の 4 分岐すべて。" },
  {
    block: "paper_045_theorem_trace_ladder",
    state: "部分的",
    remaining:
      "命題 C″ は核と反例、cycle 27 で加えた $g_m\\ge m+1$ の持ち上げ、および cycle 29 で加えた " +
      "(2) 改良した上界（tracePeriod_dvd_pow_mul）と (4) 閉形式が存在しないことの主張そのもの" +
      "（no_affine_trace_period_exponent。本文の $t_k=1,2,2,4,8,16$ も tThree_values で出した）まで。" +
      "残るのは (1) のしきい値 $w^*+1$ の最良性と (3) の $e_k=\\min\\{m:g_m\\ge k\\}$ の同値で、" +
      "どちらも $w^*$ の定義に整数行列の単因子が要る（命題 C′ と同じ壁）。",
  },
  {
    block: "paper_046_theorem_wstar_different",
    state: "部分的",
    remaining:
      "cycle 28 で 3 段のうち 2 段を形式化した（PropWStarDifferent.lean）。" +
      "微分の段（$\\chi'=h\\cdot\\sum_i a_i f_i'(\\rho/f_i)$）と、" +
      "付値の段（$\\min\\{j:\\forall\\mathfrak p,\\ j\\,e_\\mathfrak p\\ge v_\\mathfrak p\\}" +
      "=\\max_\\mathfrak p\\lceil v_\\mathfrak p/e_\\mathfrak p\\rceil$、および従順分岐・不分岐の系）である。" +
      "残るのは双対の段——$A^\\vee=\\rho'(\\theta)^{-1}A$（Euler の双対基底公式）から " +
      "$\\operatorname{coker}(G)\\cong A/\\eta A$ を経て「$G$ の単因子＝$A/\\eta A$ の不変量」へ至る部分である。" +
      "mathlib に `traceDual` / `differentIdeal` / `aeval_derivative_mem_differentIdeal` は在るが" +
      "（`PropCTracePeriod.lean` が cycle 19 に実在を確認済み）、" +
      "それらを重み付きトレース形式の Gram 行列の最大単因子へ結ぶ配線が無く、" +
      "整数行列の Smith 標準形も無い（`Basis.SmithNormalForm` は部分加群の基底の形であって" +
      "行列の単因子の形ではない）。",
  },
  {
    block: "paper_051_theorem_duality",
    state: "未着手",
    reason:
      "双対命題 D は本論文の中心だが、アルキメデス側の主張（自由エネルギー密度＝Mahler 測度）を含むので、" +
      "命題 LSW と同じ理由（mathlib の Mahler 測度が 1 変数だけで、多変数が無い）で片側が形式化できない。" +
      "$p$ 素点側だけを切り出して形式化する形にできるかは未検討。",
  },
  {
    block: "paper_052_theorem_l0_computable",
    state: "部分的",
    remaining:
      "cycle 28 で (F1) の心臓部を形式化した（PropFFiniteSupport.lean）。" +
      "すなわち「すべてのファイバーの係数和が消えるなら分類写像は台の上で単射でない」という数え上げの一点と、" +
      "そこから出る「割りうる方向は有限集合 $V(E)=\\{\\mathrm{prim}(e-e'):e\\ne e'\\in E\\}$ に入る」" +
      "という包含である（非可算な $\\mathbb{P}^{d-1}(\\mathbb{Z}_p)$ を走らなくてよいことの中身）。" +
      "残るのは 2 つ。(1) $(\\gamma_v-1)\\mid\\bar f$ と係数和の消滅の同値そのもの。" +
      "これは $d$ 変数の完備群環 $\\mathbb{F}_p[[\\Gamma]]$ とその素イデアルの記述が要るが、" +
      "mathlib には岩澤代数の一般論が `PowerSeries` の断片としてしか無い（配線ではなく素材から要る）。" +
      "(2) (F2 境界) の停止問題への帰着。mathlib に `Nat.Partrec` / `Turing` は在るが、" +
      "「係数を計算する手続きで与えられた $f$」という入力の与え方を型にする設計をこちらが持っていない" +
      "（mathlib の欠落ではなく、こちらの未設計である）。",
  },
  {
    block: "paper_053_theorem_lower_order",
    state: "未着手",
    reason:
      "命題 G の 4 部（低位項・退化点の計数・トーラス塔・消滅深度による一般の退化塔）は、" +
      "いずれも塔の全域木数の漸近に依る。matrix-tree 定理が mathlib に無い" +
      "（`kirchhoff` 0 件・`matrixTree` 0 件・全域木を数える定理 0 件。lean/README.md の欠落調査）。",
  },
  {
    block: "paper_055_theorem_theta_infinity",
    state: "部分的",
    remaining:
      "命題 G′ は (G′3) の閉形式と、cycle 26 が形式化した証明の主要 6 ステップまで。" +
      "Newton 多面体・$\\pi$ 進評価・例外直線の決定は未形式化。",
  },
  {
    block: "paper_056_theorem_ell2_family",
    state: "部分的",
    remaining:
      "命題 G″ は閉形式の形・場合分けの排反と網羅・$n=1$ の但し書き、および cycle 27 が形式化した " +
      "(G″1) の付値の議論まで。4 通りの閉形式の導出そのものは未形式化。",
  },
  { block: "paper_061_theorem_V", state: "完了", note: "命題 V は $d=1$ と $d=2$。" },
  {
    block: "paper_062_theorem_T",
    state: "部分的",
    remaining:
      "命題 T は代数的な段と算術の段まで。matrix-tree の段（mathlib に無い）と、" +
      "2 の不分岐性・Hensel 持ち上げの段（Hensel は mathlib に在るが円分体の完備化への配線が無い）が残る。",
  },
  {
    block: "paper_063_theorem_W",
    state: "部分的",
    remaining:
      "命題 W は非退化性の判定（`Decidable`）と $\\nu$ の帰属まで。閉形式本体は " +
      "Cuoco–Monsky の岩澤型漸近に依り、それが mathlib に無い（`iwasawa` の調査で該当なし）。",
  },
  {
    block: "paper_091_theorem_theta_padic",
    state: "部分的",
    remaining:
      "命題 J は (J1)(J1′) の桁定理が完了、(J4) の総和と係数の取り出しが部分的。" +
      "(J2)(J3)(J5)(J6) の各主張と、cycle 27 で形式化した (J1) の代数的な芯の外側が残る。",
  },
  {
    block: "paper_101_theorem_s_infinity_decision",
    state: "部分的",
    remaining:
      "命題 K は (K2)(K3)(K6) と、cycle 27 が形式化した (K5) の一意性・$r_0$ の書き換えまで。" +
      "(K1) の対応と (K4) の重複度の主張は未形式化。",
  },
  {
    block: "paper_101_theorem_digit_branch",
    state: "部分的",
    remaining:
      "命題 R は (R1)(R2)(R3) の核まで（cycle 27 が (R2) の打ち消しの不在を別経路で形式化した）。" +
      "終結式による付値の主張そのものは未形式化。",
  },
  {
    block: "paper_106_theorem_drop_assumption",
    state: "部分的",
    remaining:
      "命題 Q は組合せ・数え上げ・最小点の一意性・誤差の組み立てまで。" +
      "(Q4) の粗上界は複素絶対値を使う段があり、その形式化が残る。",
  },
  {
    block: "paper_111_theorem_general_closed_form",
    state: "部分的",
    remaining:
      "命題 M は (M1) の規約・(M2) の $\\lambda$・(M3) の $L$ 非依存性・(M5)(M6)、および " +
      "cycle 27 が形式化した $K(P_0)$ の存在と有界性まで。閉形式の導出そのものは未形式化。",
  },
  {
    block: "paper_112_theorem_coefficient_layers",
    state: "部分的",
    remaining:
      "命題 U は (U1) の $c$・$d$ が (M3)+(M4) から出ること、(U2)(U4)(U6)、および " +
      "cycle 27 が形式化した $\\ell=2$ の 5 係数の突き合わせまで。(U1) の式そのものの導出と " +
      "(U3)(U5) は未形式化。",
  },
];

/**
 * **本文が書いている被覆の数値の在り処**。
 *
 * 本文（形式検証の到達点）は「主張 24 件のうち 完了 5・部分的 16・未着手 3」と数で述べている。
 * **形式化が進めばこの数は古くなるが、古くなったことは本文を読まないと分からない。**
 * cycle 27 は「本文に書いた数と台帳の数が一致することは検査していない」を限界として記録し、
 * cycle 28 step 6 でここを塞いだ。
 *
 * 各ロケールについて、**台帳から数えた実測値を入れた文字列が本文に実在すること**を確かめる。
 * 本文を言い換えたときも赤くなる（そのときは、ここの組み立て方を本文に合わせて直す）。
 * 数だけ直して検査を通す道は無い——**数の出どころが台帳だからである。**
 */
export type CoverageNumberSite = {
  readonly locale: string;
  /** 数値を書いているブロックのラベル。 */
  readonly label: string;
  /** 実測値から、本文に実在すべき文字列を組み立てる。 */
  readonly phrases: (counts: {
    readonly total: number;
    readonly done: number;
    readonly partial: number;
    readonly untouched: number;
  }) => readonly string[];
};

export const COVERAGE_NUMBER_SITES: readonly CoverageNumberSite[] = [
  {
    locale: "ja",
    label: "paper_remark_formalization",
    phrases: ({ total, done, partial, untouched }) => [
      `本論文の主張 ${total} 件のうち、内容が形式化されているのは ${done} 件、`,
      `一部が形式化されているのは ${partial} 件、未着手が ${untouched} 件である。`,
    ],
  },
  {
    locale: "en",
    label: "paper_remark_formalization",
    phrases: ({ total, done, partial, untouched }) => [
      `Of the ${total} assertions of this paper, ${done} have their content `,
      `formalised, ${partial} are formalised in part, and ${untouched} have not been started.`,
    ],
  },
];

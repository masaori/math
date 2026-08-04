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
    state: "完了",
    note:
      "claim の内容（1 の冪根の組の上の積＝入れ子の終結式）を、本文が明示する d = 2 だけでなく" +
      "**一般の d** について形式化した（PeriodicPointResultant.lean の `nestedRes_eq_tupleProd`）。" +
      "cycle 29 step 1 が壁とした「反復多項式環 $R[z_1]\\cdots[z_d]$ を再帰で作る型」は要らなかった——" +
      "変数を 1 つだけ外へ出す `MvPolynomial.finSuccEquiv` を d 段回せばよい。" +
      "仮定（$z^L-1$ が $K$ 上で分解する）が空でないことも確かめてある" +
      "（$\\mathbb{Q}$・L = 2・d = 3 で積が $2^3=8$ 項を走る: `nestedRes_rat_two_three`）。" +
      "定義そのもの（$a_L$ が Galois 不変で整数であること、単項式倍で不変であること）は" +
      "この claim ではなく直前の definition ブロックの内容なので対象外。" +
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
      "cycle 29 step 3 で $w^*$ の定義そのものが入った（WStarElementaryDivisors.lean）。" +
      "**step 1 の仕分けが「素材が無い」と判定したのは誤りだった。** " +
      "整除の鎖 $a_1\\mid a_2\\mid\\cdots$ は確かに mathlib に無いが" +
      "（2026-08-04 実測、`lean/logs/mathlib-gap-survey-cycle29.log` の「整数行列の Smith 標準形」の段。" +
      "mathlib `520045ab14` の 8264 ファイルを 3 段で引き、連結語 `Matrix.smithNormalForm` 0 件・" +
      "語幹 `smith normal` 3 件。ただし **`Ideal.smithCoeffs` の整除補題そのものを名指しで走った走査は" +
      "残っていない**——鎖が無いことのこの一点だけは、上のログではなく cycle 29 step 1 の読みに依っている）、" +
      "$w^*$ を取り出すのに鎖は要らない——" +
      "適合基底（`Ideal.smithNormalForm` が返す形）の係数の $p$ 進付値の最大値として書け、" +
      "それが $\\min\\{j:\\ p^jA\\subseteq\\eta A\\ (p\\ \\text{の外で})\\}$ に等しいことを証明した" +
      "（isLeast_isPLevel / isLeast_isPLevel_ideal）。$w^*=0$ の判定も入った" +
      "（wStarOfCoeffs_eq_zero_iff。ただし本文の「$\\rho\\bmod p$ が分離的かつ $p\\nmid m_\\lambda$」" +
      "への翻訳は入っていない）。" +
      "残るのは 2 つ。(1) 本文が $w^*$ を Gram 行列 $G$ の側で定義していること——" +
      "$G$ の単因子が $A/\\eta A$ の不変量に等しいという同一視は、" +
      "体の上では行列の等式 $C\\,G=M_\\eta$ と $(\\det C)^2=1$ として入ったが" +
      "（命題 W\\* の欄を見よ）、その整数への降下を書いていない。" +
      "(2) $\\det G=\\operatorname{disc}(\\rho)\\cdot\\prod_\\lambda m_\\lambda$ の" +
      "重複度の積の形（ノルムの形 $\\det G=\\pm N(\\eta)$ は入った）。" +
      "上界の証明で $w^*$ が果たす役割は仮定として型に出してある。",
  },
  {
    block: "paper_044_theorem_newton",
    state: "部分的",
    remaining:
      "命題 N は下界方向のみ。上界方向は Skolem–Mahler–Lech / Strassmann が mathlib に無く" +
      "（2026-08-04 実測、`lean/logs/mathlib-gap-survey-cycle29.log`。" +
      "mathlib `520045ab14` の 8264 ファイルを 3 段で引き、`SkolemMahlerLech` 連結語 0 件・" +
      "語幹 `skolem` は 30 件当たるがログが挙げている先はモデル理論の Skolem 関数" +
      "（ログの一覧は先頭 8 件までなので、30 件すべてを見たわけではない）、" +
      "`Strassmann` は 3 段とも 0 件、" +
      "`NewtonPolytope` / 語幹 `newton polytope` も 3 段とも 0 件）、" +
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
      "残るのは (1) のしきい値 $w^*+1$ の最良性と (3) の $e_k=\\min\\{m:g_m\\ge k\\}$ の同値。" +
      "cycle 29 step 3 で $w^*$ の定義そのものは入った（WStarElementaryDivisors.lean。" +
      "**「整数行列の単因子が mathlib に無いから書けない」という step 1 の判定は覆った**——" +
      "適合基底の係数の $p$ 進付値の最大値として書ける）。" +
      "残っているのは、その $w^*$ をトレース列の周期の主張へ結ぶ段である（命題 C′ と同じ壁）。",
  },
  {
    block: "paper_046_theorem_wstar_different",
    state: "部分的",
    remaining:
      "cycle 28 で 3 段のうち 2 段を形式化した（PropWStarDifferent.lean）。" +
      "微分の段（$\\chi'=h\\cdot\\sum_i a_i f_i'(\\rho/f_i)$）と、" +
      "付値の段（$\\min\\{j:\\forall\\mathfrak p,\\ j\\,e_\\mathfrak p\\ge v_\\mathfrak p\\}" +
      "=\\max_\\mathfrak p\\lceil v_\\mathfrak p/e_\\mathfrak p\\rceil$、および従順分岐・不分岐の系）である。" +
      "cycle 29 step 3 で双対の段の大半が入った（WStarElementaryDivisors.lean）。" +
      "**step 1 の仕分けが「素材が無い（整数行列の Smith 標準形が無い）」と判定したのは誤りだった。** " +
      "整除の鎖は確かに無いが $w^*$ に鎖は要らず、適合基底の係数の $p$ 進付値の最大値で書ける。" +
      "入ったのは (a) $w^*=\\min\\{j:\\ p^j\\eta^{-1}\\in A_{(p)}\\}$ の右辺が意味をもち" +
      "最小元が適合基底の係数で書けること（isLeast_isPLevel_ideal / exists_isPLevel_ideal）、" +
      "(b) **本文の $\\det G=\\pm N_{A/\\mathbb{Q}}(\\eta)$**（det_weightedGram。" +
      "重み付き Gram 行列がトレース形式の Gram 行列と $\\mu$ 倍の行列の積に分解することと、" +
      "判別式が $\\rho'(\\theta)$ のノルムに等しいことから）、" +
      "(c) **Euler の双対基底公式を行列の等式にしたもの** $C\\,G=M_\\eta$ と $(\\det C)^2=1$" +
      "（eulerMatrix_mul_weightedGram / det_eulerMatrix_sq。" +
      "心臓部は $\\operatorname{Tr}(c_i w)=[\\theta^i](\\rho'(\\theta)w)$＝trace_coeff_minpolyDiv_mul）、" +
      "(d) 可逆な取り替えで像に対する $p$ 進の条件が変わらないこと（isPLevel_range_comp）。" +
      "cycle 30 step 1 で **(1) 整数への降下が入った**（WStarIntegralDescent.lean）。" +
      "cycle 29 が予定していた道（`coeff_minpolyDiv_mem_adjoin` で所属を言い、座標へ翻訳する）ではなく、" +
      "**$C$ の成分が $\\rho$ の係数そのもの $C_{ij}=\\rho_{i+j+1}$ である**ことを等式で書いた" +
      "（coeff_minpolyDiv_eq_sum / eulerMatrix_eq_eulerHankel）。" +
      "したがって $C$ は反対角線が $\\rho_r=1$ の Hankel 行列で、$\\det C=\\pm1$ が三角行列の行列式ひとつで出る" +
      "（isUnit_det_eulerHankel。可換環の上で成立し、体も分離性も既約性も使わない）。" +
      "「行列の像と $\\eta A$ を基底で同一視する配線」も入った" +
      "（range_mulLeft_eq_span / isLeast_isPLevel_range_of_euler）。" +
      "これで人手証明の「$\\operatorname{coker}(G)\\cong A/\\eta A$ だから $G$ の単因子は $A/\\eta A$ の不変量」が" +
      "$C\\,G=M_\\eta$ を仮定として与えたときに Lean で通る。" +
      "**残っているのは 1 つ、$\\rho$ が可約な場合の $C\\,G=M_\\eta$ そのものである。** " +
      "(b)(c) は `PowerBasis K L`（$L$ は体）を使っており $\\rho$ が既約な場合しか覆っていない。" +
      "$\\rho$ が可約なとき $A\\otimes\\mathbb{Q}$ は体でなく体の積である。" +
      "**これは配線の欠落ではなく素材の欠落である**（2026-08-04 実測、" +
      "`lean/logs/mathlib-gap-survey-cycle30-euler.log`。mathlib 8264 ファイル走査で" +
      "可換環の上のトレース双対・双対基底・Euler の双対基底公式・Frobenius 代数はいずれも連結語 0 件、" +
      "実在する `Module.Basis.traceDual` は宣言が `[Field K] [Field L] [FiniteDimensional K L] " +
      "[Algebra.IsSeparable K L]` を要求していることを宣言行で直接確認した）。" +
      "埋めるには可換環の上の Euler の双対基底公式 " +
      "$\\operatorname{Tr}_{A/R}(c_i\\theta^j)=\\delta_{ij}$ を自前で書くことになる。" +
      "**cycle 36 step 1 でそれを書き、外部定理の側は完了した**（`EulerDualBasisCommRing.lean` の " +
      "段 2–5 と、本文の $C\\,G=M_\\eta$ の可換環版 `eulerMatrix_mul_weightedGram`。" +
      "$C$ が $\\rho$ の係数の Hankel 行列であること `eulerMatrix_apply` も可換環の上で書いたので、" +
      "`isUnit_det_eulerHankel` と繋いで $\\det C=\\pm1$ も出る）。" +
      "**それでもこの主張は完了しない。cycle 36 step 1 の実測で、残りが 1 件ではなかったことが分かった。** " +
      "台帳は cycle 30 から「残っているのは 1 つ、可約な $\\rho$ での $C\\,G=M_\\eta$ そのもの」と書き続けていたが、" +
      "その 1 件を埋めても下流が塞がったままだった。**実測で見つかった残りは 3 件である。** " +
      "(1) **降下そのものが整域を要求していた**——`WStarIntegralDescent.isLeast_isPLevel_range_of_euler` は " +
      "`[IsDomain S]` を仮定しており、$\\rho$ が可約なとき $A=\\mathbb{Z}[x]/(\\rho)$ は整域でないので当たらない。" +
      "**cycle 36 step 1 でこれは埋めた**（`WStarReducibleDescent.lean` の " +
      "`exists_isLeast_isPLevel_range_of_euler`。整域は本質でなく $\\eta$ が零因子でないことへ落ちる。" +
      "適合基底は `Submodule.exists_smith_normal_form_of_rank_eq` で作れて、PID を要求されるのは係数環 " +
      "$\\mathbb{Z}$ の側だけである）。" +
      "(2) **$\\det G=\\pm N_{A/\\mathbb{Q}}(\\eta)$ が可約な場合に無い**——`det_weightedGram` は " +
      "`PowerBasis K L`（$L$ は体）で書かれており、本文の 2 つめの等式は既約な場合しか覆っていない" +
      "（2026-08-05 実測、宣言行で直読）。**未形式化である。**" +
      "(3) **$\\eta=(\\chi\'/h)(\\theta)$ が零因子でないこと**と、$A=\\mathbb{Z}[x]/(\\rho)$ が " +
      "`IsPowerBasisOf` / `IsReductionOf` を満たすことの当てはめ。どちらも仮定として受け取っている。" +
      "**未形式化である。**",
  },
  {
    block: "paper_051_theorem_duality",
    state: "部分的",
    remaining:
      "**cycle 35 step 4 の照合で、この欄が本文の部を全部覆っていないことが分かったので足す**——" +
      "本文は (∞ 素点)・(p 素点, 有限 L)・(p 素点, 塔の漸近) の 3 部に分かれているが、" +
      "この欄は (∞ 素点) という部の名前に 1 度も触れず「アルキメデス側」とだけ書いていた。" +
      "**(∞ 素点) は未形式化である**（下記 (1)）。" +
      "cycle 34 step 5 の検査がこれを見落としていたのは、部の記号を英数字の形でしか拾っていなかったためで、" +
      "この主張のように素点の名前で部を切っているものが素通りしていた。" +
      "cycle 29 で $p$ 素点側の切り出しを実際にやり、**(p 素点, 有限 L) の段**を $d=1$ で形式化した" +
      "（DualityPAdicFiniteL.lean）。入ったのは、本文の簡約周期点数 " +
      "$a^{\\mathrm{red}}_L=\\prod_{\\zeta^L=1,\\ P(\\zeta)\\neq0}P(\\zeta)$ の定義そのもの" +
      "（Lean のどこにも無かった。既存の PropV.lean と PeriodicPointResultant.lean は簡約しない $a_L$ だけを扱う）と、" +
      "$a^{\\mathrm{red}}_L\\neq0$、$a^{\\mathrm{red}}_L=\\mathrm{Res}(h,P)$（$h$ は $X^L-1$ の monic な因子）、" +
      "$h=(X^L-1)/\\gcd(X^L-1,P)$ が $\\mathbb{Z}[X]$ に属すること（Gauss）、" +
      "その $h$ の根がちょうど本文の「良い根」であること、" +
      "したがって $a^{\\mathrm{red}}_L$ が $\\mathbb{Z}$ 係数の終結式ひとつで書ける $0$ でない整数であること" +
      "（＝本文の $v_p(a^{\\mathrm{red}}_L)\\in\\mathbb{Z}_{\\ge0}$ が意味をもつことの中身）である。" +
      "$L=p^n$ の塔の非自明性の判定は PropV.lean が $d=1,2$ で既に持っている。" +
      "残るのは 3 つ。(1) **アルキメデス側**（自由エネルギー密度＝Mahler 測度）。" +
      "命題 LSW と同じ理由で素材が無い——mathlib の Mahler 測度は 1 変数だけで多変数が無い" +
      "（`MvPolynomial.mahlerMeasure` の連結語 grep 0 件。語幹 `mahler measure` の 3 件は" +
      "いずれも 1 変数。lean/logs/mathlib-gap-survey-cycle29-duality.log）。" +
      "しかも本論文はこの段を証明せず外部定理を引用している。" +
      "(2) **(p 素点, 塔の漸近)**。Monsky の定理と Cuoco–Monsky の定理の適用であり、本論文は証明しない。" +
      "素材も無い——`Monsky` / `CuocoMonsky` / `semialgebraic` / $\\mathbb{Z}_p^d$ 拡大は 3 段すべて 0 件、" +
      "岩澤代数は mathlib の p 進測度の章の散文に 1 行触れられているだけ（1 変数の測度）、" +
      "Weierstrass 準備定理は 1 変数版だけ（同じログ、mathlib 8264 ファイル走査）。" +
      "(3) 有限 $L$ の段の $d\\ge2$。cycle 29 step 2 はここを「反復多項式環の型」と書いたが、" +
      "その壁は step 3b で消えた（周期点数の終結式表示は一般の $d$ で書けた）。" +
      "残っているのは別のことで、簡約周期点数は $P$ が消える組だけを除く量であり、" +
      "その除去は変数ごとに剥がす形にならない。書き方は未着手で、書けるかどうかも確かめていない。",
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
      "mathlib には岩澤代数の一般論が `PowerSeries` の断片としてしか無い（配線ではなく素材から要る。" +
      "2026-08-04 実測、`lean/logs/mathlib-gap-survey-cycle29-duality.log` の「d 変数の完備群環」の段。" +
      "mathlib `520045ab14` の 8264 ファイルを 3 段で引き、連結語 `MvPowerSeries.completion` 0 件・" +
      "語幹 `iwasawa algebra` は p 進測度の章の 1 ファイルだけ）。" +
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
      "（cycle 30 step 2 で自前で書くと判断し、入口＝多重グラフの符号付き接続行列と " +
      "$L=D\,D^{\mathsf T}$ を書いた。MultigraphLaplacian.lean。" +
      "**cycle 32 step 1 で Cauchy–Binet が完了したので、残るのは小行列式の $\pm1$ 性・" +
      "Kirchhoff・指標分解の 3 段である**（cycle 31 総括は 2 段と書いていたが実測は 3 段）。" +
      "**小行列式の段は cycle 32 step 3 で半分入った**（全単模性。`IncidenceUnimodular.lean`）。" +
      "`outputs/reports/cycle30_ops_matrix_tree_decision.md` に段取りがある。" +
      "**この主張は matrix-tree だけでは完了しない**——Cuoco–Monsky の岩澤型漸近も要る）。" +
      "不在の根拠は 2026-08-04 実測、`lean/logs/mathlib-gap-survey-cycle30-matrixtree.log`" +
      "（mathlib `520045ab14` の 8264 ファイルを 3 段で引き、`matrixTree` / 語幹 `matrix tree` / " +
      "`kirchhoff` / `CauchyBinet` はいずれも 3 段とも 0 件。" +
      "全域木そのものは語幹 `spanning tree` で 3 ファイルに現れるが、" +
      "個数を数える定理の連結語 `numSpanningTrees` は 0 件）。",
  },
  {
    block: "paper_055_theorem_theta_infinity",
    state: "部分的",
    remaining:
      "命題 G′ は (G′3) の閉形式と、cycle 26 が形式化した証明の主要 6 ステップまで。" +
      "Newton 多面体・$\\pi$ 進評価・例外直線の決定は未形式化。" +
      "**cycle 33 step 2 の照合で、この欄が `lean/` の記述より少なく書いていたことが分かったので足す**——" +
      "`BouquetClosedForm.lean` は残りとして (a) $\\kappa_n$ の独立計算（matrix-tree 定理。" +
      "$\\ell^{2n}\\times\\ell^{2n}$ 行列式で、mathlib に全域木数の公式が無い。**配線ではなく素材の欠落**。" +
      "2026-08-04 実測、`lean/logs/mathlib-gap-survey-cycle30-matrixtree.log`。mathlib `520045ab14` の " +
      "8264 ファイルを 3 段で引き、`matrixTree` / 語幹 `matrix tree` / `kirchhoff` がいずれも 3 段とも 0 件）と " +
      "(b) 定理 X の付値計算そのもの（$v_\\ell(h^N-1)=\\ell^{\\nu(N)}/\\varphi_m$。" +
      "$\\mathbb{Q}(\\zeta_{\\ell^m})$ の $\\ell$ の上の素点への**配線**。円分体も分岐も mathlib に在る）を挙げている。" +
      "`GeneralTowerClosedForm.lean` はさらに 定理 G2 の 1（Galois 不変性。配線）・定理 G2 の 3（配線）・" +
      "$A_{\\mathrm{gen}}$ の $L$ 非依存性・Matrix–Tree 定理を挙げている。" +
      "**cycle 34 step 5 の照合で、この欄が本文の部を全部覆っていないことが分かったので足す**——(G′1) と (G′2) は、この欄が 1 度も触れていなかった。どちらも未形式化である。",
  },
  {
    block: "paper_056_theorem_ell2_family",
    state: "部分的",
    remaining:
      "命題 G″ は閉形式の形・場合分けの排反と網羅・$n=1$ の但し書き、および cycle 27 が形式化した " +
      "(G″1) の付値の議論まで。4 通りの閉形式の導出そのものは未形式化。" +
      "**cycle 34 step 3 の照合で、`EllTwoClosedForm.lean` が挙げている matrix-tree 定理も足す**" +
      "（$\\kappa_n$ の独立計算に要る。外部定理の台帳を見よ）。" +
      "**cycle 34 step 5 の照合で足す**——本文の (G″2)(G″3)(G″4)(G″5) は、この欄が 1 度も触れていなかった。いずれも未形式化である（形式化してあるのは (G″1) の付値の議論だけである）。",
  },
  { block: "paper_061_theorem_V", state: "完了", note: "命題 V は $d=1$ と $d=2$。" },
  {
    block: "paper_062_theorem_T",
    state: "部分的",
    remaining:
      "命題 T は代数的な段と算術の段まで。matrix-tree の段（mathlib に無い。" +
      "2026-08-04 実測、`lean/logs/mathlib-gap-survey-cycle30-matrixtree.log`。" +
      "mathlib `520045ab14` の 8264 ファイルを 3 段で引き、`matrixTree` / `kirchhoff` / `CauchyBinet` が" +
      "いずれも 3 段とも 0 件。cycle 30 step 2 で自前で書くと判断し入口を書いた。" +
      "MultigraphLaplacian.lean。**cycle 32 step 1 で Cauchy–Binet は完了し、" +
      "残るのは小行列式の $\pm1$ 性・Kirchhoff・指標分解の 3 段である。" +
      "うち小行列式の段は cycle 32 step 3 で半分入った**＝全単模性。" +
      "残るのは「$\pm1$ になるのが全域木のときに限る」という組合せの側）と、" +
      "2 の不分岐性・Hensel 持ち上げの段（Hensel は mathlib に在るが円分体の完備化への配線が無い）が残る。",
  },
  {
    block: "paper_063_theorem_W",
    state: "部分的",
    remaining:
      "命題 W は非退化性の判定（`Decidable`）と $\\nu$ の帰属まで。閉形式本体は " +
      "Cuoco–Monsky の岩澤型漸近に依り、それが mathlib に無い" +
      "（2026-08-04 実測、`lean/logs/mathlib-gap-survey-cycle29-duality.log`。" +
      "mathlib `520045ab14` の 8264 ファイルを 3 段で引き、`Monsky` / `CuocoMonsky` はいずれも 3 段とも 0 件。" +
      "語幹 `iwasawa` は 6 ファイルに当たるが、名前に iwasawa を持つファイルは群論の岩澤分解の 1 本だけで、" +
      "岩澤不変量の漸近ではない）。",
  },
  {
    block: "paper_091_theorem_theta_padic",
    state: "部分的",
    remaining:
      "命題 J は (J1)(J1′) の桁定理が完了、(J4) の総和と係数の取り出しが部分的。" +
      "(J2)(J3)(J5)(J6) の各主張と、cycle 27 で形式化した (J1) の代数的な芯の外側が残る。" +
      "**cycle 34 step 3 の照合で、`Cycle24Corrections.lean` が挙げている 系 Q7 の $r=2$ そのもの（2 変数 Laurent 環の一意分解性が要る配線）を、この欄が書いていなかったので足す。**" +
      "**cycle 33 step 2 の照合で、この欄が `lean/` の記述より少なく書いていたことが分かったので足す**——" +
      "`DigitTheorem.lean` は 命題 J2′ の同値（$\\ell$ 奇なら 破れる $\\iff k=2$ 等）を残りに挙げており、" +
      "`TowerTypeCoefficients.lean` は (a) 定理 J7 の主張そのもの" +
      "（$b=\\sum_{P\\in S_\\infty}j^*(P)$。形式冪級数・Hasse 微分・$\\mathbb{Z}_\\ell$ 冪の**配線**が要る。" +
      "`PowerSeries` も二項冪級数も mathlib に在る）と " +
      "(b) $\\Theta_{M'}$ から $M'\\ell^{M'}$ の係数を読み取る段の一般形（$O$ 記法を型にしていない）を挙げている。",
  },
  {
    block: "paper_101_theorem_s_infinity_decision",
    state: "部分的",
    remaining:
      "命題 K は (K2)(K3)(K6) と、cycle 27 が形式化した (K5) の一意性・$r_0$ の書き換えまで。" +
      "(K1) の対応と (K4) の重複度の主張は未形式化。" +
      "**cycle 34 step 3 の照合で、`SInfinityDecision.lean` が挙げている 3 件を足す**——補題 W2 の (iv)、定理 W4 の主張そのもの、系 W7。" +
      "**cycle 34 step 5 の照合で足す**——本文の (K7) は、この欄が 1 度も触れていなかった。未形式化である。",
  },
  {
    block: "paper_101_theorem_digit_branch",
    state: "完了",
    note:
      "cycle 35 step 1 で残り 4 件を全部書いたので、命題 R は完了である。" +
      "**cycle 34 総括はここを「残りは 1 つだけ」と書いていたが、それは誤りだった**——" +
      "cycle 34 step 1 が書いた「残っているのは 1 つ」という文は、" +
      "同じサイクルの step 3 が同じ欄へ 2 件書き足した時点で古くなっており、" +
      "書き足した側がその文を直さなかった。cycle 35 の着手時の実測で 4 件と分かり、4 件とも書いた。" +
      "内訳は次のとおり。" +
      "(1) **$\\Psi_M$ の各根へ $\\pi$ を送る環準同型の供給**" +
      "（`ResultantValuationR4.lean` の `exists_ringHom_sub_one`）。" +
      "**Galois 群の記述は要らなかった**——効くのは冪基底の普遍性だけで、" +
      "$\\zeta$ の最小多項式の根ひとつごとに $\\zeta\\mapsto\\xi$ の環準同型が 1 つ決まる。" +
      "台帳が素材として挙げていた `IsCyclotomicExtension.autEquivPow` は使っていない" +
      "（その同型を作るときに使われている普遍性の側だけを使う）。" +
      "円分拡大であることも $K/\\mathbb{Q}$ が Galois であることも整数環の理論も使わない。" +
      "(2) **$\\Psi_M$ がモニックであることと分解すること**" +
      "（`monic_psi` / `splits_psi`。段 4c の `psi_eq_prod` が分解そのものを与えていた）。" +
      "併せて段 5 が仮定として受け取っていた「整数の割り切りが反映されること」も供給した" +
      "（`int_dvd_of_algebraMap_dvd`。$\\mathbb{Z}$ が直和因子であることだけを使う）。" +
      "(3)(4) **$\\mathbb{Z}_\\ell$ 指数の $(1+x)^\\gamma$** と **$\\mathrm{sep}$ についての帰納法**" +
      "（`DigitBranchZellExponent.lean`。cycle 34 step 3 の照合が `DigitBranchRecursion.lean` から写した 2 件）。" +
      "**書いてみると 2 件は同じ 1 本の補題に載っていた**——" +
      "$\\mathbb{Z}_\\ell$ の指数に意味を与えているのは $\\ell$ 進の位相でも完備性でも二項冪級数でもなく、" +
      "$(1+x)^{\\ell^t}=1+x^{\\ell^t}$ という 1 本の等式である" +
      "（指数が $\\ell^t$ を法として等しければ次数 $<\\ell^t$ の係数は一致する）。" +
      "そして $\\mathrm{sep}$ はまさに「代表元へ取り替えてよい深さ」なので、" +
      "$\\mathbb{Z}_\\ell$ 指数の族は $\\mathrm{sep}$ の深さまでは $\\mathbb{N}$ 指数の族と同じ多項式を与える。" +
      "台帳が別々の 2 件として挙げていたのは、その繋がりを見ていなかったためである。" +
      "$\\mathrm{sep}$ そのものも取ってあるので (R3) は仮定を置かない形で言えている" +
      "（`exists_sepAt` / `sep` / `exists_coeff_ne_zero_lt_pow_sep`）。",
  },
  {
    block: "paper_106_theorem_drop_assumption",
    state: "完了",
    note:
      "cycle 33 step 1 で残り 2 件（補題 Q4a・補題 Q1′）を書いたので、命題 Q は完了である。" +
      "内訳は 組合せ・数え上げ・最小点の一意性・誤差の組み立て（`DropAssumptionBStar.lean`）、" +
      "補題 Q0（アルキメデス粗上界。`CrudeArchimedeanBound.lean`。" +
      "**本プロジェクトで複素絶対値を使う唯一の箇所**）、" +
      "補題 Q4a（`CyclotomicValuationQ4a.lean`）、補題 Q1′（`PropQLaurentLift.lean`）。" +
      "**完了と呼ぶ射程を明示する**——" +
      "(1) 補題 Q4a は付値 $v_{\\mathfrak l}$ ではなく **$\\pi=\\zeta-1$ の冪との同伴**で書いた。" +
      "$v_{\\mathfrak l}(\\pi)=1$ なので内容は同じだが、**証明が使うのは $\\pi$ の素元性と整域性だけ**で、" +
      "Dedekind 性も類数も一意分解性も使わない（$\\mathcal{O}_K$ は一般には一意分解環でないので " +
      "$a^N\\sim b^N\\Rightarrow a\\sim b$ は使えない。`dvd_prime_pow` で迂回した）。" +
      "(2) `Prime (ζ - 1)` は仮定として受け取り、それが円分体の整数環で成り立つことを " +
      "mathlib の `zeta_sub_one_prime` で名指ししてある（`prime_zeta_sub_one_ofInteger`）。" +
      "(3) 補題 Q1′ の 2 変数 Laurent 環は `AddMonoidAlgebra ℤ (ℤ × ℤ)`（群環 $\\mathbb{Z}[\\mathbb{Z}^2]$）" +
      "で置いた。**新しい型は作っていない。** " +
      "(4) $\\bar{\\tilde E}$ の分解 $(1.2)$ そのもの（cycle 20 の定理 W1・W4）は補題 Q1′ の主張ではないので、" +
      "仮定として型に出してある。**形式化して分かったのは、補題 Q1′ の証明が " +
      "$\\mathbb{F}_\\ell[z^{\\pm},w^{\\pm}]$ の一意分解性を 1 度も使わないこと**である——" +
      "使うのは「単元倍は割り切りを変えない」だけで、一意分解性は $(1.2)$ を作る側の要求である。" +
      "**mathlib の見立ては 1 件外れていた**: cycle 22 のログは補題 Q4a に " +
      "`ramificationIdx`・`inertiaDeg` が要ると読んでいたが、実際には使わずに済んだ。" +
      "代わりに要ったのは `(ζ-1)^{φ(ℓ^j)} ∼ ℓ` の**素数冪版**で、" +
      "mathlib にあるのは素数版（`associated_zeta_sub_one_pow_prime`）だけだったので自分で書いた" +
      "（`associated_sub_one_pow_totient`）。",
  },
  {
    block: "paper_111_theorem_general_closed_form",
    state: "部分的",
    remaining:
      "命題 M は (M1) の規約・(M2) の $\\lambda$・(M3) の $L$ 非依存性・(M5)(M6)、および " +
      "cycle 27 が形式化した $K(P_0)$ の存在と有界性まで。閉形式の導出そのものは未形式化。" +
      "**cycle 34 step 3 の照合で、`Cycle25Corrections.lean` が挙げている 3 件を足す**——定理 G2 の 1（Galois 不変性。配線）、系 Q7 の $r=2$（2 変数 Laurent 環の一意分解性）、および voltage グラフのラプラシアン行列式そのもの（matrix-tree 定理。外部定理の台帳を見よ）。" +
      "**cycle 34 step 5 の照合で足す**——本文の (M4) は、この欄が 1 度も触れていなかった。未形式化である。",
  },
  {
    block: "paper_112_theorem_coefficient_layers",
    state: "部分的",
    remaining:
      "命題 U は (U1) の $c$・$d$ が (M3)+(M4) から出ること、(U2)(U4)(U6)、および " +
      "cycle 27 が形式化した $\\ell=2$ の 5 係数の突き合わせまで。(U1) の式そのものの導出と " +
      "(U3)(U5) は未形式化。" +
      "**cycle 35 step 4 の照合で、この欄が本文の部を全部覆っていないことが分かったので足す**——" +
      "(U1a)（飽和深度を大きめに取ってもよいこと）は、この欄が 1 度も触れていなかった。未形式化である。" +
      "cycle 34 step 5 の検査がこれを見落としていたのは、部の記号を `[A-Z][0-9]+` の形でしか" +
      "拾っていなかったためで、`U1a` のように後ろに小文字が付く形が素通りしていた。",
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
    /** 外部定理のうち「自分で証明する」に振り分けた件数。 */
    readonly externalOwn: number;
    /** そのうち完了した件数。**cycle 32 step 1 で追加した。** */
    readonly externalOwnDone: number;
  }) => readonly string[];
};

export const COVERAGE_NUMBER_SITES: readonly CoverageNumberSite[] = [
  {
    locale: "ja",
    label: "paper_remark_formalization",
    phrases: ({ total, done, partial, untouched, externalOwn, externalOwnDone }) => [
      `本論文の主張 ${total} 件のうち、内容が形式化されているのは ${done} 件、`,
      `一部が形式化されているのは ${partial} 件、未着手が ${untouched} 件である。`,
      `自分で証明することにした外部定理は ${externalOwn} 件であり、`,
      `そのうち証明を書き終えたのは ${externalOwnDone} 件である。`,
    ],
  },
  {
    locale: "en",
    label: "paper_remark_formalization",
    phrases: ({ total, done, partial, untouched, externalOwn, externalOwnDone }) => [
      `Of the ${total} assertions of this paper, ${done} have their content `,
      `formalised, ${partial} are formalised in part, and ${untouched} have not been started.`,
      `we have undertaken to prove ${externalOwn} of the external theorems ourselves; `,
      `the number of those proofs that are complete is ${externalOwnDone}.`,
    ],
  },
];

/* ------------------------------------------------------------------------- *
 * 台帳が本文の部を全部覆っているか（cycle 34 step 5）
 * ------------------------------------------------------------------------- */

/**
 * **`部分的` の欄が、その主張の部を 1 つ残らず扱っているかを見る。**
 *
 * cycle 34 の着手時の実測で、**命題 R の欄が (R4) しか書いておらず (R5) を落としていた**
 * ことが分かった。本文の命題 R は (R1)–(R5) の 5 部からなる。
 * 同じ形の書き落としは他にもありうるので、機械が見る。
 *
 * ## 規則
 *
 * 本文の `statement` に `(R1 …` のような**部の見出し**が現れるとき、
 * **`部分的` の欄はその部の記号を 1 つ残らず含んでいなければならない。**
 * `部分的` は「一部だけ形式化した」という意味なので、
 * **どの部がどちら側なのかを書かない限り、その主張は情報を持たない。**
 *
 * `完了` と `未着手` は対象外である——前者は部ごとに書く必要が無く、
 * 後者は「なぜ手が付いていないか」を書く欄であって部の一覧ではないからである。
 *
 * ## 機械が確かめられないこと（正直に書く）
 *
 * - **部の記号が欄に在ることは確かめられるが、そこに書いてある状態が正しいかは確かめられない。**
 *   （検査 F の他の部分と同じ限界である。）
 * - 部の見出しを持たない主張は対象外なので、そこは人の読みのままである。
 */
export function partLabelsInStatement(statementText: string): string[] {
  // 形 1（cycle 34 step 5）: 地の文の途中に現れる `(R1 …` のような英数字の部の記号。
  const inline = [...statementText.matchAll(/\(([A-Z]′?″?[0-9]+[′″]?)\s/g)].map((m) => m[1]!);
  // 形 2（cycle 35 step 4）: 段落の先頭に置かれた括弧つきの見出し。
  // **形 1 だけでは、英数字の記号を使わない部が素通りしていた**——実測すると
  // 双対命題 D が「(∞ 素点)」「(p 素点, 有限 L)」「(p 素点, 塔の漸近)」で部を切っており、
  // 部を持つ主張 11 件のうちこの 1 件だけが検査の外にいた。
  // 目印は原理からではなく実測から決めた（本文の全 theorem / claim を走査し、
  // 段落の先頭にある括弧つきの見出し 11 件がすべて実際に部の見出しであることを確かめた）。
  const leading = [...statementText.matchAll(/(?:^|\n)\s*\(([^)\n]{1,28})\)?/g)].map((m) => {
    const inner = m[1]!.trim();
    // 英数字の記号で始まるものは、その記号だけを部の名前とする（形 1 と同じ粒度に揃える）。
    const head = inner.split(/\s/)[0]!;
    // 末尾に小文字が付く枝番（`U1a`）も記号として扱う。
    // **cycle 34 step 5 の形はここを見ておらず、`U1a` が素通りしていた。**
    return /^[A-Z]′?″?[0-9]+[a-z]?[′″]?$/.test(head) ? head : inner;
  });
  return [...new Set([...inline, ...leading])];
}

/** 判定。IO を持たないので検出テストからそのまま呼べる。 */
export function auditPartCoverage(input: {
  readonly entries: readonly {
    readonly block: string;
    readonly state: CoverageState;
    readonly text: string;
    readonly statementText: string;
  }[];
}): { violations: string[]; checked: number; parts: number } {
  const violations: string[] = [];
  let checked = 0;
  let parts = 0;
  for (const entry of input.entries) {
    if (entry.state !== "部分的") continue;
    const labels = partLabelsInStatement(entry.statementText);
    if (labels.length === 0) continue;
    checked += 1;
    parts += labels.length;
    const missing = labels.filter((label) => !entry.text.includes(label));
    if (missing.length > 0) {
      violations.push(
        `[台帳が本文の部を覆っていない] ${entry.block} — ` +
          `${missing.join("・")} に 1 度も触れていない（cycle 34 の実測はこの形で (R5) の落ちを見つけた）`,
      );
    }
  }
  return { violations, checked, parts };
}

/**
 * **外部定理の振り分け台帳**（検査 F の第 2 部）。
 *
 * ## なぜこれがあるか
 *
 * 2026-08-04 のユーザー判断で、全数 Lean 形式化の対象に
 * **本論文が証明せず引用している外部定理も含める**ことになった。引用で済ませる道は採らない。
 * ただし無制限に広げると際限がないので、どこまでを自分で証明するかの基準を定めた。
 * 基準の正本は `docs/external-theorem-criterion.md`。ここはその基準を当てた実測の結果である。
 *
 * ## 四つの種別（基準の要約。導出は正本を読むこと）
 *
 * - `自分で証明する` — 本文の証明が根拠として引いていて、可算側の内容を担い、mathlib に無い。
 * - `mathlib から引く` — 同じだが mathlib に在る。引く。**引いたことは隠さない。**
 * - `R 脱出として隔離する` — 本文が引いているが、主張の本体が $\mathbb{R}/\mathbb{C}$ の解析である。
 *   証明しないが、**可算側の主張がそれに依存していないこと**を根拠つきで書く（型で必須）。
 *   依存しているなら隔離できていないので `自分で証明する` へ落とす。
 * - `対象外` — 証明の根拠として引いていない（位置づけ・既出性・landscape）。
 *   **「引いていない」と主張する以上その根拠を書く**（型で必須）。
 *
 * ## 機械が確かめること
 *
 * 1. **`citedIn` に挙げた本文ブロックが実在すること。** 改名・削除で浮いたら赤くなる。
 * 2. **`自分で証明する` が宣言する Lean の定理名が `lean/` に実在すること。**
 * 3. **`R 脱出として隔離する` は隔離の根拠を持つこと**（型で必須）。
 * 4. **`対象外` は「根拠として引いていない」根拠を持つこと**（型で必須）。
 * 5. **`mathlib から引く` は mathlib のどこに在るかを持つこと**（型で必須）。
 *
 * ## 機械が確かめられないこと（正直に書く）
 *
 * - **種別の振り分けそのものは人の読みである。** ある引用が「証明の根拠」なのか
 *   「位置づけ」なのかは、本文を読んで決めている。機械が見るのは、書かれた判断が腐っていないことだけ。
 * - **隔離できていることも人の読みである。** 3 が要求するのは根拠が書かれていることであって、
 *   その根拠が実際に隔離を示しているかではない。
 * - **mathlib の在る／無いは版に依存する。** だから走査ログのコミットを記録する。
 */

export type ExternalKind =
  | "自分で証明する"
  | "mathlib から引く"
  | "R 脱出として隔離する"
  | "対象外";

type Common = {
  /** 定理の名前。人が読んで何の話か分かる名前にする（識別子ではない）。 */
  readonly name: string;
  /** 出典。原論文・巻号・定理番号まで書く。 */
  readonly source: string;
  /** 本文のどのブロックが引いているか。実在を機械が確かめる。 */
  readonly citedIn: readonly string[];
};

/** `自分で証明する` に共通の欄。 */
type OwnProof = Common & {
  readonly kind: "自分で証明する";
  /** mathlib に無いことの実測（走査の段と件数）。 */
  readonly absence: string;
};

export type ExternalEntry =
  | (OwnProof & {
      /**
       * **完了。** cycle 32 step 1 で入れた。
       * これが無いと、外部定理は何段書いても「残り」の件数が一生動かなかった
       * （台帳に完了を書く場所が無かった。cycle 31 は 3 段書いて件数 0 減である）。
       */
      readonly state: "完了";
      /** 完了と言う以上、読者が辿れる先が要る。型で必須にしてある。 */
      readonly leanNames: readonly string[];
      /** どこまでを完了と呼んでいるか（射程）。完了の誇張を防ぐために書かせる。 */
      readonly note: string;
    })
  | (OwnProof & {
      readonly state: "部分的";
      /** 書き始めた以上、読者が辿れる先が要る。型で必須にしてある。 */
      readonly leanNames: readonly string[];
      /** 何が残っているか。 */
      readonly remaining: string;
    })
  | (OwnProof & {
      readonly state: "未着手";
      /** 何が残っているか。 */
      readonly remaining: string;
    })
  | (Common & {
      readonly kind: "mathlib から引く";
      /** mathlib のどこに在るか（実測）。型で必須にしてある。 */
      readonly presence: string;
      /** 引くにあたって残っている配線があれば書く。 */
      readonly wiring?: string;
    })
  | (Common & {
      readonly kind: "R 脱出として隔離する";
      /** なぜ主張の本体が R/C の解析なのか。 */
      readonly analytic: string;
      /** 可算側の主張がこれに依存していないことの根拠。型で必須にしてある。 */
      readonly isolation: string;
    })
  | (Common & {
      readonly kind: "対象外";
      /** 証明の根拠として引いていないことの根拠。型で必須にしてある。 */
      readonly notAGround: string;
    });

/**
 * 初期値は cycle 31 step 1 の実測。
 * mathlib の在る／無いは `lean/logs/mathlib-gap-survey-cycle31-external.log`
 * （走査スクリプトは `lean/scripts/mathlib-gap-survey-cycle31-external.sh`）による。
 * 引いている場所は本文 `content/*.ts` を全数走査して決めた。
 */
export const EXTERNAL_THEOREM_COVERAGE: readonly ExternalEntry[] = [
  // ---------- 自分で証明する ----------
  {
    name: "Kirchhoff の matrix-tree 定理（グラフの全域木を数える定理）",
    source: "古典（Kirchhoff 1847）。本文は命題 T の証明で「指標による対角化と Kirchhoff の matrix-tree 定理から」と引く",
    citedIn: ["paper_062_theorem_T", "paper_063_theorem_W", "paper_053_theorem_lower_order"],
    kind: "自分で証明する",
    absence:
      "2026-08-04 実測。mathlib 520045ab14 の 8264 ファイルを 3 段で引き、" +
      "`matrixTree` / 語幹 `matrix tree` / `kirchhoff` がいずれも 3 段とも 0 件" +
      "（`lean/logs/mathlib-gap-survey-cycle31-external.log`。cycle 30 の matrixtree ログと同じ結果）。" +
      "全域木そのものは語幹 `spanning tree` で当たるが、個数を数える定理は無い。",
    state: "部分的",
    leanNames: [
      "incMatrixSigned",
      "lapMatrixOfInc",
      "lapMatrix_row_sum",
      "det_eq_zero_or_one_or_neg_one_of_incidenceColumns",
      "isIncidenceColumn_incMatrixSigned",
    ],
    remaining:
      "cycle 30 step 2 で入口（多重グラフの符号付き接続行列と $L=D\\,D^{\\mathsf T}$）だけ書いた。" +
      "**cycle 32 step 1 で Cauchy–Binet が完了したので、残りは 3 段である**" +
      "（小行列式の $\\pm1$ 性・Kirchhoff 本体・指標分解）。" +
      "**そのうち小行列式の段は cycle 32 step 3 で半分入った**（`IncidenceUnimodular.lean`）——" +
      "「どんな正方小行列でも行列式は $0,1,-1$ のいずれか」（全単模性）を証明した。" +
      "Cauchy–Binet と合わせると $\\det L_0=\\sum_S\\det(D_S)^2$ の各項が $0$ か $1$ になるので、" +
      "**Kirchhoff の右辺が「ある性質をもつ辺集合の個数」であることはこれで確定する。**" +
      "**cycle 33 step 3 でその「確定する」を主張として書いた**（`KirchhoffCounting.lean`）——" +
      "cycle 32 は report にそう書いただけで主張にしておらず、限界の欄に" +
      "「全単模性と『接続行列がその形をしている』を繋いだ主張は書いていない」と明記していた。" +
      "書いたのは $\\det(D_0D_0^{\\mathsf T})$ が「小行列式が $0$ でない辺集合」の個数に等しいこと" +
      "（`det_mul_transpose_eq_card`）で、Cauchy–Binet と全単模性だけから出る。" +
      "残るのはその性質が「全域木であること」だと同定する組合せの側であった。" +
      "**cycle 34 step 2 でその同定へ入り、半分を書いた**（`SpanningConnectivity.lean`）——" +
      "辺集合が全体を連結にしないなら小行列式は $0$ である" +
      "（`det_submatrix_eq_zero_of_not_reach`）。対偶が数え上げに効く形で、" +
      "**小行列式が $0$ でない辺集合は必ず全体を連結にする**。" +
      "証明の中身は「根を含まない連結成分の行の和が消える」ことで、" +
      "成分の外へ出る辺が無いので各辺の寄与が $+1$ と $-1$ で打ち消し合う。" +
      "**着手時の見立てが 1 つ外れた**——cycle 33 総括は「連結性と閉路を型に用意することになる」と" +
      "書いていたが、**閉路は要らなかった**。辺の本数を $|V|-1$ に固定すると" +
      "「閉路を持たない」と「連結」は同値なので、連結性だけを用意すれば足りる。" +
      "連結性は `Relation.ReflTransGen` で書けるので、閉路・道・長さの型は 1 つも作っていない。" +
      "**残るのは逆向き（連結なら小行列式が $\\pm1$。葉に沿った展開の帰納法）と 指標分解 である。**" +
      "したがって **matrix-tree は依然 部分的**である。" +
      "cycle 31 総括は「Cauchy–Binet が入っても 2 段残る」と書いていたが、" +
      "同じ文が挙げている項目は 3 つで、3 が正しい（cycle 32 着手時の実測で訂正した）。" +
      "段取りは `outputs/reports/cycle30_ops_matrix_tree_decision.md`。",
  },
  {
    name: "Cauchy–Binet の公式（非正方行列の積の行列式）",
    source:
      "古典。**本文は引いていない**——matrix-tree を自分で証明すると決めた以上、その内部段として要るものである。" +
      "台帳へ入れたのは、書く量を隠さないため。",
    citedIn: ["paper_062_theorem_T"],
    kind: "自分で証明する",
    absence:
      "2026-08-04 実測。mathlib 520045ab14 の 8264 ファイルを 3 段で引き、" +
      "`CauchyBinet` / 語幹 `cauchy binet` が 3 段とも 0 件。",
    state: "完了",
    leanNames: [
      "det_mul_eq_sum_over_maps",
      "det_submatrix_eq_zero_of_not_injective",
      "det_mul_eq_sum_over_injective",
      "det_mul_eq_zero_of_card_lt",
      "orderEmbOfFin_comp_injOn",
      "exists_orderEmbOfFin_comp",
      "det_mul_eq_sum_over_subsets",
    ],
    note:
      "cycle 31 step 3 が 3 段、cycle 32 step 1 が最後の 1 段を書いた（`CauchyBinet.lean`）。" +
      "完成形 $\\det(AB)=\\sum_{s}\\det(A_{\\cdot s})\\det(B_{s\\cdot})$（$s$ は列の $k$ 元部分集合）まで通っている" +
      "（`det_mul_eq_sum_over_subsets`）。" +
      "最後の段の中身は、mathlib に無かった「単射 $\\leftrightarrow$（順序埋め込み, 置換）」の同値であり、" +
      "一意性（`orderEmbOfFin_comp_injOn`）と存在（`exists_orderEmbOfFin_comp`）に分けて自前で書いた。" +
      "材料の `Finset.orderEmbOfFin` と `Finset.range_orderEmbOfFin` は mathlib に在る。" +
      "**完了と呼ぶ射程**: 一般の可換環の上で成立し、体も整域も要らない。" +
      "第 4 段だけは行の添字を $\\mathrm{Fin}\\,k$ に取り、列の型に線形順序を仮定する" +
      "（部分集合から代表を選ぶためであって、主張の内容が順序を要求しているのではない）。" +
      "**matrix-tree 本体はこれとは別で、まだ 3 段残っている**（Kirchhoff の欄を見よ）。",
  },
  {
    name: "可換環の上の Euler の双対基底公式（トレース双対 $\\operatorname{Tr}_{A/R}(c_i\\theta^j)=\\delta_{ij}$）",
    source: "古典（Euler）。本文は命題 W\\* の証明で「$\\rho$ は分離的なので Euler の双対基底公式より」と引く",
    citedIn: ["paper_046_theorem_wstar_different"],
    kind: "自分で証明する",
    absence:
      "2026-08-04 実測。連結語 `traceDual` は 3 件当たるが、**在るものが体の上にしかない**。" +
      "`Module.Basis.traceDual`（`Mathlib/RingTheory/Trace/Basic.lean` 553 行）の宣言が " +
      "`[Field K] [Field L] [FiniteDimensional K L] [Algebra.IsSeparable K L]` を要求していることを" +
      "宣言行で直読した（cycle 30 の euler ログと同じ結果）。$\\rho$ が可約なとき " +
      "$A\\otimes\\mathbb{Q}$ は体でなく体の積なので、この形では届かない。",
    state: "部分的",
    leanNames: ["eulerMatrix_mul_weightedGram", "det_eulerMatrix_sq"],
    remaining:
      "既約な $\\rho$ の場合は入っている（`WStarElementaryDivisors.lean`。ただし `PowerBasis K L` を使うので $L$ は体）。" +
      "残るのは可約な $\\rho$ での $C\\,G=M_\\eta$ そのもの。" +
      "見通しは $\\operatorname{Tr}(\\theta^m)$ が満たす Newton 型の関係へ帰着する道だが、書いて通したものではない。",
  },
  {
    name: "Newton 多面体の加法性（Ostrowski の定理）",
    source: "Ostrowski。本文は命題 G′ と命題 K (K7) の証明で「Laurent 多項式の Newton 多面体の加法性（Ostrowski の定理）より」と引く",
    citedIn: ["paper_055_theorem_theta_infinity", "paper_101_theorem_s_infinity_decision"],
    kind: "自分で証明する",
    absence:
      "2026-08-04 実測。`newtonPolytope` / 語幹 `newton polytope` が 3 段とも 0 件。" +
      "mathlib の `Newton` はニュートン法（`Mathlib/Dynamics/Newton.lean`）であって多面体ではない（宣言行で直読）。",
    state: "未着手",
    remaining: "未着手。可算側（有限個の格子点の Minkowski 和）で閉じるので機械にかかる形である。",
  },
  {
    name: "Skolem–Mahler–Lech の定理（線形回帰数列の零点集合）",
    source: "Skolem–Mahler–Lech。本文は命題 N の証明で「Skolem–Mahler–Lech 型の相殺により例外が生じる」と引く",
    citedIn: ["paper_044_theorem_newton"],
    kind: "自分で証明する",
    absence:
      "2026-08-04 実測。`SkolemMahlerLech` / 語幹 `skolem mahler` が 3 段とも 0 件。" +
      "（語幹 `skolem` 単独では 30 件当たるが、当たっているのはモデル理論の Skolem 函数である。cycle 29 のログと同じ。）",
    state: "未着手",
    remaining:
      "未着手。**本文がこれを引いているのは上界方向の例外を述べるためであり、主張を成り立たせる向きに使っている。**" +
      "したがって対象外にはできない。",
  },
  {
    name: "Monsky の p 進冪級数の定理",
    source: "P. Monsky, *On p-adic power series*, Math. Ann. 255(2), 217–227 (1981), Theorem 5.6",
    citedIn: ["paper_051_theorem_duality"],
    kind: "自分で証明する",
    absence:
      "2026-08-04 実測。`Monsky` / 語幹 `monsky` が 3 段とも 0 件。" +
      "岩澤代数の一般論も mathlib には `PowerSeries` の断片としてしか無い（cycle 29 の duality ログ）。",
    state: "未着手",
    remaining:
      "未着手。主張は $\\mathrm{ord}_\\ell$ の漸近（整数値の増大則）であり可算側の内容を担うので、" +
      "$\\mathbb{R}$ 脱出として隔離する側には置けない。",
  },
  {
    name: "Cuoco–Monsky の類数の漸近（$\\mathbb{Z}_p^d$ 拡大の岩澤型漸近）",
    source:
      "A. A. Cuoco – P. Monsky, *Class numbers in $\\mathbb{Z}_p^d$-extensions*, Math. Ann. 255, 235–258 (1981), " +
      "Theorem 1.7（および Definitions 1.1, 1.2）",
    citedIn: [
      "paper_051_theorem_duality",
      "paper_063_theorem_W",
      "paper_091_theorem_theta_padic",
      "paper_101_theorem_s_infinity_decision",
      "paper_106_theorem_drop_assumption",
      "paper_111_theorem_general_closed_form",
    ],
    kind: "自分で証明する",
    absence:
      "2026-08-04 実測。`CuocoMonsky` / 語幹 `cuoco` が 3 段とも 0 件。" +
      "語幹 `iwasawa` は当たるが、名前に iwasawa を持つファイルは群論の岩澤分解 1 本だけで、岩澤不変量の漸近ではない（cycle 29 のログ）。",
    state: "未着手",
    remaining:
      "未着手。**本論文が最も広く借りている外部定理である**（6 ブロックが引く）。" +
      "$\\mu,\\lambda$ の定義（Definitions 1.1, 1.2）は可算側の組合せ量として書けるので、そこから測る。",
  },

  // ---------- mathlib から引く ----------
  {
    name: "Newton の公式（冪和と基本対称式の関係）",
    source: "古典。本文は命題 C のトレース列版の証明で「$\\chi_S=\\chi_T$ なので Newton の公式より」と引く",
    citedIn: ["paper_043b_theorem_trace_bound"],
    kind: "mathlib から引く",
    presence:
      "2026-08-04 実測。`Mathlib/RingTheory/MvPolynomial/Symmetric/NewtonIdentities.lean` に在る" +
      "（連結語 `NewtonIdentities` が 1 ファイル、ファイル名検索も 1 件）。",
    wiring: "本論文が要るのは同伴行列のトレース列の形なので、対称式の言葉からの翻訳が要る。",
  },
  {
    name: "Artin の指標の一次独立性",
    source: "古典（Artin）。本文は命題 L の証明で「相異なる $\\lambda$ について一次独立（Artin の指標の一次独立性）」と引く",
    citedIn: ["paper_042_theorem_pi_p1"],
    kind: "mathlib から引く",
    presence: "2026-08-04 実測。連結語 `linearIndependent_monoidHom` が 4 ファイルに在る。",
  },
  {
    name: "Cayley–Hamilton の定理",
    source: "古典。本文は命題 N の注で「この条件だけから Cayley–Hamilton により」と引く",
    citedIn: ["paper_044_theorem_newton"],
    kind: "mathlib から引く",
    presence: "2026-08-04 実測。連結語 `aeval_self_charpoly` が 6 ファイルに在る。",
  },
  {
    name: "Hensel の補題",
    source: "古典。本文は命題 T の証明で「Hensel により $r_j\\equiv\\zeta^j$ なる根が取れる」と引く",
    citedIn: ["paper_062_theorem_T", "paper_072_remark_qp_free"],
    kind: "mathlib から引く",
    presence: "2026-08-04 実測。語幹 `henselian` が当たり、ファイル名検索でも 1 件。",
    wiring:
      "**在るのに引けていない。** 本文自身が「後者は円分体の完備化への配線が要る」と書いており、" +
      "残っているのは mathlib の欠落ではなく配線である。",
  },
  {
    name: "Vandermonde 行列式",
    source: "古典。本文は命題 C のトレース列版の決定可能性の議論で「代数的数の Vandermonde」と引く",
    citedIn: ["paper_043b_theorem_trace_bound"],
    kind: "mathlib から引く",
    presence: "2026-08-04 実測。連結語 `det_vandermonde` が 3 ファイル、ファイル名検索 2 件。",
  },
  {
    name: "Cramer の規則",
    source: "古典。本文は命題 C のトレース列版の決定可能性の議論で「整数行列上の線形代数（Cramer 則・Smith 標準形）」と引く",
    citedIn: ["paper_043b_theorem_trace_bound"],
    kind: "mathlib から引く",
    presence: "2026-08-04 実測。連結語 `Matrix.cramer` が 1 ファイル、語幹 `cramer` が 7 ファイル。",
  },
  {
    name: "整数行列の Smith 標準形（適合基底の形）",
    source: "古典。本文は命題 C のトレース列版と命題 F で決定可能性の根拠として引く",
    citedIn: ["paper_043b_theorem_trace_bound", "paper_052_theorem_l0_computable"],
    kind: "mathlib から引く",
    presence:
      "2026-08-04 実測。`Submodule.smithNormalForm` ほかが `Mathlib/LinearAlgebra/FreeModule/PID.lean` に在る（宣言行で直読）。" +
      "**整除の鎖 $a_1\\mid a_2\\mid\\cdots$ は無い**が、cycle 29 step 3 で本論文には鎖が要らないことを確かめてある" +
      "（$w^*$ は適合基底の係数の $p$ 進付値の最大値として書ける）。",
  },

  // ---------- R 脱出として隔離する ----------
  {
    name: "エントロピー＝Mahler 測度（Lind–Schmidt–Ward）",
    source: "D. Lind – K. Schmidt – T. Ward, Invent. math. 101 (1990) 593–629, Theorem 3.1 / Theorem 7.1",
    citedIn: ["paper_031_theorem_lsw", "paper_051_theorem_duality"],
    kind: "R 脱出として隔離する",
    analytic:
      "主張の本体は $\\frac{1}{L^d}\\log|a^{\\mathrm{red}}_L|\\to\\log m(P)$ という $\\mathbb{R}$ の極限であり、" +
      "Mahler 測度そのものが複素単位トーラス上の積分で定義される。可算の言葉では述べられない。",
    isolation:
      "本文はこの定理を第 3 章（アルキメデス素点側）に隔離し、章の見出しが「ここだけが $\\mathbb{R}$ を使う」と述べている。" +
      "双対命題 D でも $\\infty$ 素点の段でだけ引き、$p$ 素点側の段（cycle 29 が形式化した簡約周期点数の終結式表示）は" +
      "この定理を 1 度も使わない。**したがって可算側の主張はこれに依存していない。**",
  },
  {
    name: "周期点の増大率（Lind–Schmidt–Verbitskiy）",
    source: "D. Lind – K. Schmidt – E. Verbitskiy, arXiv:1108.4989, Theorem 1.2 / Theorem 1.3",
    citedIn: ["paper_031_theorem_lsw"],
    kind: "R 脱出として隔離する",
    analytic:
      "上と同じ極限の主張を、より広い条件（$P$ が atoral でない場合を含む）で述べたものである。本体は $\\mathbb{R}$ の極限。",
    isolation:
      "上と同じ。第 3 章の内側にあり、本文は規約の差（$\\mathbb{Z}^d$ 周期成分の個数と本論文の $a^{\\mathrm{red}}_L$ が" +
      "因子だけずれること）まで書いて隔離している。",
  },

  // ---------- 対象外（証明の根拠として引いていない） ----------
  {
    name: "Monsky の低位項の評価",
    source: "P. Monsky, *Fine estimates for the growth of $e_n$ in $\\mathbb{Z}_p^d$-extensions*, ASPM 17 (1989), 309–330, Theorem 1.20",
    citedIn: ["paper_054_remark_limits", "paper_063_theorem_W"],
    kind: "対象外",
    notAGround:
      "本文はこれを**既知の限界を示すために**引いている——Monsky 自身が Introduction で「$c$ には easy な記述が無い」と書き、" +
      "同論文が明示的に同定した係数は 2 つだけであることを述べる文脈である。" +
      "本論文のどの主張もこの定理を根拠として使っていない（引いている 2 ブロックはいずれも既出性・限界の記述である）。",
  },
  {
    name: "Kataoka の $\\mathbb{Z}_p^d$ グラフ被覆の主要係数の明示公式",
    source: "Kataoka, arXiv:2606.03579, Theorem 1.1（および Definition 2.2, 6.1, Proposition 4.4）",
    citedIn: ["paper_051_theorem_duality", "paper_056_theorem_ell2_family"],
    kind: "対象外",
    notAGround:
      "既出性の調査結果として引いている（「漸近形は Kataoka Theorem 1.1 で既知であり」）。" +
      "定義の参照（Definition 2.2 が $\\mu$ をどう定めているか）は用語の突き合わせであって、証明の根拠ではない。",
  },
  {
    name: "DuBose–Vallières の数値例",
    source: "DuBose–Vallières, Algebraic Combinatorics 6 (2023), alco.304, §7",
    citedIn: ["paper_055_theorem_theta_infinity", "paper_063_theorem_W"],
    kind: "対象外",
    notAGround:
      "既出性の記録として引いている。本文自身が「同 §7 は 5 層からの数値フィットであり、著者自身が証明ではないと明記している」" +
      "と書いており、根拠として使えないことを本文が述べている。",
  },
  {
    name: "Vallières の非退化な塔の閉形式",
    source: "Vallières, arXiv:2006.14012, Corollary 5.7",
    citedIn: ["paper_063_theorem_W"],
    kind: "対象外",
    notAGround:
      "既出性の調査結果（「『非退化なら閉形式』という形そのものは $d=1$ で既出である」）。本論文の証明はこれを経由しない。",
  },
  {
    name: "Kwon–Mednykh–Mednykh の全域木数の偶奇",
    source: "Kwon–Mednykh–Mednykh（本文は命題 T の弱い形が既出であることの出典として挙げる）",
    citedIn: ["paper_081_remark_scope"],
    kind: "対象外",
    notAGround:
      "既出性の調査結果の一覧の中にあり、「命題 T は弱い形（$v_2$ が偶数）が既出」と述べる文脈である。" +
      "命題 T の証明はこれを引かない（証明が引くのは matrix-tree・Hensel・Newton 多角形である）。",
  },
  {
    name: "Byszewski–Graff–Ward の Dold 列の定義",
    source: "Byszewski–Graff–Ward, *Dold sequences, periodic points, and dynamics*, Bull. LMS 53 (2021), Definition 2.1",
    citedIn: ["paper_061_theorem_V"],
    kind: "対象外",
    notAGround:
      "命題 V が $d=1$ で既出であることを示すために引いている定義であって、命題 V の証明の根拠ではない" +
      "（本文は「新規性を主張しない」の括弧の中でこれを述べている）。命題 V 自身は `PropV.lean` で形式化済みである。",
  },
  {
    name: "Cuoco の $\\mathbb{Z}_p^d$ 拡大の類数",
    source: "A. Cuoco, Compositio Math. 41 (1980), 415–437, Theorem 1.1 周辺",
    citedIn: ["paper_091_theorem_theta_padic"],
    kind: "対象外",
    notAGround:
      "既出性調査で**何を読んだかの記録**として挙げている（「読んだのは……Cuoco, Compositio Math. 41 (1980) の Introduction と Theorem 1.1 の周辺である」）。" +
      "証明の根拠ではない。",
  },
  {
    name: "Ferrero–Washington の定理（岩澤 $\\mu$ の消滅）",
    source: "Ferrero–Washington（本文は非対称性の地図の中で言及する）",
    citedIn: ["paper_072_remark_qp_free"],
    kind: "対象外",
    notAGround:
      "双対の $\\Lambda$ 側に Lehmer 型の連続ギャップが立たないことを述べる landscape の記述であり、" +
      "本文自身が「これは既知の 2 つの理論が双対のどちらの素点に乗るかの地図であって、新しい定理ではない」と書いている。",
  },
  {
    name: "Lehmer 問題",
    source: "D. H. Lehmer 1933（未解決問題）",
    citedIn: ["paper_072_remark_qp_free"],
    kind: "対象外",
    notAGround:
      "未解決問題であって定理ではない。$\\mathbb{R}$ 側に固有のギャップが在ることを述べる landscape の記述である。" +
      "本文は「スケール違いの偶然であって接続ではない」と、接続として使わないことまで明記している。",
  },
  {
    name: "2 次元 Ising 模型に現れる Hasse–Weil $L$ 函数・Dirichlet $L$ 函数",
    source: "統計力学側の既知結果（本文は注記で言及する）",
    citedIn: ["paper_032_remark_ising_known"],
    kind: "対象外",
    notAGround:
      "「統計力学側の既知結果」という題の remark の中の背景説明であり、本論文のどの主張の根拠でもない。",
  },
  {
    name: "構成的な Henselization",
    source: "Alonso García–Lombardi–Perdry, MLQ 54 (2008)",
    citedIn: ["paper_081_remark_scope"],
    kind: "対象外",
    notAGround:
      "「非可算対象を可算符号で扱う移動は標準手法である」という既出性の調査結果として引いている。証明の根拠ではない。",
  },
];

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
    state: "完了",
    leanNames: [
      "incMatrixSigned",
      "lapMatrixOfInc",
      "lapMatrix_row_sum",
      "det_eq_zero_or_one_or_neg_one_of_incidenceColumns",
      "isIncidenceColumn_incMatrixSigned",
      "det_mul_transpose_eq_card",
      "det_submatrix_eq_zero_of_not_reach",
      "det_submatrix_eq_one_or_neg_one",
      "det_submatrix_ne_zero_iff_reach",
      "det_mul_transpose_eq_card_spanning",
    ],
    note:
      "**完了と呼ぶ射程**: 根の行を落としたラプラシアンの行列式が、" +
      "**根から全頂点へ届く辺集合の個数に等しい**ところまで（`det_mul_transpose_eq_card_spanning`）。" +
      "辺の本数を $|V|-1$ に固定してあるので、この条件はちょうど全域木であることである" +
      "（本数を固定すると「連結」と「閉路を持たない」が同値になるので、閉路を型に持たなくてよい。" +
      "cycle 34 step 2 の観察）。多重辺と自己ループを許す形で書いてあり、体も整域も使わない" +
      "（係数は $\\mathbb{Z}$）。" +
      "**cycle 30 step 2 から cycle 37 step 2 まで 8 サイクルかけて 4 段で書いた**——" +
      "(1) 多重グラフの符号付き接続行列と $L=D\\,D^{\\mathsf T}$（cycle 30、`MultigraphLaplacian.lean`）、" +
      "(2) Cauchy–Binet（cycle 31–32、別エントリで完了）、" +
      "(3) 小行列式が $0,\\pm1$ のいずれかであること＝全単模性（cycle 32、`IncidenceUnimodular.lean`）と、" +
      "右辺が「小行列式が $0$ でない辺集合の個数」であること（cycle 33、`KirchhoffCounting.lean`）、" +
      "(4) その条件を全域木として同定する組合せの側" +
      "（cycle 34 で「連結でなければ $0$」、cycle 35–37 で逆向き。`SpanningConnectivity.lean`）。" +
      "**最後の逆向きは cycle 37 step 2 で入った。** cycle 36 step 2 は「頂点の型を固定して " +
      "`Fintype.card` で数えているので、葉を取り除くと型が変わり帰納法の仮定を当てられない」と書いて" +
      "止めていた。**頂点集合を引数に持つ形へ書き直したら当たった**（`sum_degOn_on` / " +
      "`exists_leaf_ne_root_on` / `det_submatrix_eq_one_or_neg_one`）。" +
      "**書き直しは破壊的ではない**——段 4 までの主張は頂点集合として全体を取った特別な場合として出る。" +
      "帰納法の芯は 2 つで、葉を取り除いても残りが根から届くこと（`reachOn_erase_of_leaf`。" +
      "葉の次数が $1$ なので、歩みが葉へ入ったら同じ辺で出るしかなく、迂回は取り除ける）と、" +
      "葉の行に沿った展開の残りがちょうど葉を取り除いたグラフの小行列式になること" +
      "（行と列の並べ方が `Fin.succAbove` で 1 つずつ縮む）である。" +
      "**指標分解はこのエントリの残りではない。** cycle 30 の段取りは 段 4 に" +
      "「さらに導来グラフのラプラシアンを指標で分解する段」を併記しており、" +
      "cycle 31 以降この欄はそれを残りとして数え続けていたが、" +
      "**本文自身が「指標による対角化と Kirchhoff の matrix-tree 定理から」と 2 つを並べて引いている**" +
      "（`paper_062_theorem_T` の証明。2026-08-05 に本文を直読して確かめた）。" +
      "指標分解は Kirchhoff の定理の内容ではなく、本文がそれを塔へ当てるための段である。" +
      "**したがってその段は本文の主張の側の残りとして数える**（命題 T ほかの欄を見よ）。" +
      "**この壁が塞いでいた本文の主張は、cycle 35・36 の数え直しと同じく実測は 6 件である**（機械が台帳を数え直す。命題 G・命題 G′・命題 G″・命題 T・命題 M・命題 W）。**cycle 47 step 2 で 命題 W が加わって 5 件から 1 件増えた。そう書く**——同 step が本文の proof を読み直したところ、命題 W の証明も $(★_2)$ の積公式で matrix-tree を引いており、この欄はそれを数えていなかった。**6 件とも matrix-tree は外れたが、いずれも別の残りを持つので完了はしない。そう書く。** " +
      "**この読み替えで全数までの残りが 1 件減る。基準を緩めたのではなく、" +
      "本文の引き方を読んで振り分け先を直したのである。そう書く。** " +
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
      "**matrix-tree 本体はこれとは別で、まだ残りがある。段数はここに書かない**——cycle 36 step 2 の実測で、この文が Kirchhoff の欄の残りと食い違っていることが分かった（この欄は 3 段と書いていたが、Kirchhoff の欄が挙げている残りは 2 つである）。**同じ数を 2 箇所で持つと、片方だけが古くなる。** これは cycle 35・36 で 3 件見つかった事故と同じ形なので、数を持つ場所を 1 つに寄せた。残りの段は Kirchhoff の欄が正本である。",
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
    state: "完了",
    leanNames: [
      "eulerMatrix_mul_weightedGram",
      "det_eulerMatrix_sq",
      "psi_eulerC_mul_pow",
      "sum_eulerC_mul_pow",
      "trace_eq_sum_coord",
      "trace_eq_psi_derivative_mul",
      "trace_eulerC_mul",
      "eulerMatrix_apply",
    ],
    note:
      "既約な $\\rho$ の場合は入っている（`WStarElementaryDivisors.lean`。ただし `PowerBasis K L` を使うので $L$ は体）。" +
      "**cycle 35 step 2 で、可約な場合の心臓部を書いた**（`EulerDualBasisCommRing.lean` の `psi_eulerC_mul_pow`）——" +
      "$\\psi$ を「$\\theta^{m}$ の係数を取る」線形写像とすると、$\\psi(c_i\\theta^j)=\\delta_{ij}$ が" +
      "**可換環の上でそのまま成り立つ**。**分離性も体も整域も使わない。**" +
      "使うのは $\\rho$ がモニックであること（$\\theta^{m+1}$ が低次へ落ちること）だけで、" +
      "上から降りる帰納法で出る。$\\rho$ が可約でも重根を持ってもよい。" +
      "**cycle 30 以降「素材が無い」と書き続けていた箇所の中身はこれである**——" +
      "体の上の証明が分離性を要求していたのは $\\rho\'(\\theta)$ で割ってから双対基底を作っていたからで、" +
      "割らずに $\\psi$ の対で書けば仮定が落ちる。" +
      "**cycle 36 step 1 で残りの 4 段をすべて書き、この外部定理は完了した。** " +
      "(2) $\\sum_i c_i\\theta^i=\\rho\'(\\theta)$（`sum_eulerC_mul_pow`。$c_i$ の明示形 `eulerC_eq_sum` を経由し、" +
      "二重和を $k=i+t$ で入れ替えると各 $k$ の重複度がちょうど $k+1$ になって $\\rho\'$ の係数が出る）、" +
      "(3) $\\mathrm{Tr}(z)=\\sum_j[\\theta^j](z\\theta^j)$（`trace_eq_sum_coord`。配線）、" +
      "(4) $\\mathrm{Tr}(z)=\\psi(\\rho\'(\\theta)z)$（`trace_eq_psi_derivative_mul`）、" +
      "(5) $\\mathrm{Tr}(c_i w)=[\\theta^i](\\rho\'(\\theta)w)$（`trace_eulerC_mul`）。" +
      "**併せて本文の $C\\,G=M_\\eta$ の可換環版も書いた**（`eulerMatrix_mul_weightedGram`）。" +
      "**cycle 34 までの見通し（$\\operatorname{Tr}(\\theta^m)$ の Newton 型の関係へ帰着する道）は要らなかった**——" +
      "段 1 と段 2 から段 4 が直接出るので、冪和の関係を経由しない。" +
      "**完了と呼ぶ射程**: 可換環 $R$ 上の代数 $A$ が $1,\\theta,\\dots,\\theta^m$ を基底にもち、" +
      "モニックな $\\rho$ について $\\theta^{m+1}$ が低次へ落ちること（`IsPowerBasisOf` / `IsReductionOf`）だけを仮定する。" +
      "体も整域も分離性も既約性も使わない。**ただしこの外部定理が完了しても 命題 W\\* は完了しない**——" +
      "cycle 36 step 1 の実測で、命題 W\\* にはこれとは別の残りがあることが分かった（命題 W\\* の欄を見よ）。",
  },
  {
    name: "Newton 多面体の加法性（Ostrowski の定理）",
    source: "Ostrowski。本文は命題 G′ と命題 K (K7) の証明で「Laurent 多項式の Newton 多面体の加法性（Ostrowski の定理）より」と引く",
    citedIn: ["paper_055_theorem_theta_infinity", "paper_101_theorem_s_infinity_decision"],
    kind: "自分で証明する",
    absence:
      "2026-08-04 実測。`newtonPolytope` / 語幹 `newton polytope` が 3 段とも 0 件。" +
      "mathlib の `Newton` はニュートン法（`Mathlib/Dynamics/Newton.lean`）であって多面体ではない（宣言行で直読）。",
    state: "完了",
    leanNames: [
      "mem_convexHull_erase_of_midpoint",
      "convexHull_eq_of_midpoint",
      "mem_support_of_unique_add",
      "midpoint_of_two_decompositions",
      "emb_injective",
      "newt_mul",
    ],
    note:
      "**cycle 39 step 1 で書いた**（`NewtonPolytopeAdditivity.lean`）。" +
      "**cycle 38 step 5 が入れた検査 I の予告どおり、書けない理由は無かった**——" +
      "同じ走査が名指ししていた `convexHull_add`（凸包が Minkowski 和と可換であること）はそのまま使えた。" +
      "ただし**それだけでは足りず、書く量の大半は別のところにあった。そう書く。** " +
      "`convexHull_add` が与えるのは右辺の書き換え（$\mathrm{Newt}(f)+\mathrm{Newt}(g)=\mathrm{conv}(A+B)$、$A,B$ は台）だけで、" +
      "本体は $\mathrm{conv}(A+B)=\mathrm{conv}(\mathrm{supp}(fg))$ のほうである。" +
      "**完了と呼ぶ射程**: 2 変数 Laurent 多項式（`AddMonoidAlgebra R (ℤ × ℤ)`）について、" +
      "係数環 $R$ が整域であれば成り立つ形で書いた（`newt_mul`）。$f$ や $g$ が $0$ の場合も込みで、仮定は要らない（両辺とも空集合）。" +
      "**$\mathbb{R}$ へは 1 度も出ない**——指数は $\mathbb{Z}\times\mathbb{Z}$ に住み、凸包は $\mathbb{Q}\times\mathbb{Q}$ の中で $\mathbb{Q}$ 係数で取る。" +
      "凸包に要るのは順序体であることだけで、完備性も位相も使わない。**この点は設計の結果であって偶然ではない**——" +
      "頂点を取り出す標準の道（超平面による分離、Krein–Milman）は mathlib では $\mathbb{R}$ の位相を要求するので、" +
      "使えば主張は可算側にあるのに証明が $\mathbb{R}$ へ出る。そこで**分離定理を使わない道を取った。** " +
      "芯は 2 つである。(1) **分解が一意な指数は積の台に入る**（`mem_support_of_unique_add`。" +
      "積の係数の二重和にその 1 項しか残らず、整域なので $0$ でない。**この file が整域を使うのはここだけである**）。" +
      "(2) **分解が一意でない指数は、台の和の相異なる 2 点の中点である**（`midpoint_of_two_decompositions`。" +
      "$p=a+b=a'+b'$ なら $q=a+b'$ と $r=a'+b$ が $q+r=p+p$ を満たす。$q\neq r$ は $\mathbb{Z}\times\mathbb{Z}$ に捻れが無いことから出る）。" +
      "**この 2 つで、頂点を超平面で取り出す代わりに「頂点でない点は中点として書ける」という組合せの事実だけで済む。** " +
      "仕上げは、凸包を与える部分集合のうち**要素数が最小のもの**を取り、その各点が中点では書けないことを言う段である" +
      "（`convexHull_eq_of_midpoint`。使うのは台が有限であることだけで、位相も分離定理も使わない）。" +
      "**限界**: 本文が下流で使っている「Minkowski 和の辺方向は各因子の辺方向の合併」（命題 G′ の有限性の段）と" +
      "「格子周長が Minkowski 和について加法的」（命題 K の (K7)）は、この外部定理の内容ではなく本文の主張の側の残りである。" +
      "どちらも未形式化であり、そう書く（命題 G′・命題 K の欄を見よ）。",
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
      "2026-08-04 実測。`Monsky` / 語幹 `monsky` が 3 段とも 0 件（定理そのものは無い）。" +
      "**ただし 2026-08-05（cycle 40 step 4）に engine の側から引き直すと、証明に使う道具は在った**" +
      "（`lean/logs/mathlib-gap-survey-cycle40-external-engines.log`）——" +
      "完備局所環の上の Weierstrass 準備定理（`PowerSeries.exists_isWeierstrassFactorization`。" +
      "出典として Washington の *Introduction to Cyclotomic Fields* を挙げている）と " +
      "distinguished 多項式（`Polynomial.IsDistinguishedAt`）である。" +
      "**cycle 29・31 の走査が 0 件だったのは、探した語が定理の名前だったからである。**" +
      "定理の名前で引くと、その定理を証明する道具が在っても見えない。",
    state: "部分的",
    leanNames: [
      "weierstrass_over_padicInt",
      "dvd_coeff_of_pow_dvd",
      "exists_greatest_pow_dvd",
      "dvd_of_forall_coeff_dvd",
      "map_residue_eq_zero_iff",
      "exists_iwasawa_factorization",
      "degree_eq_order_map",
    ],
    remaining:
      "**cycle 40 step 4 で第 1 段を書いた**（`IwasawaMuInvariant.lean`）。" +
      "Monsky の定理も Cuoco–Monsky の $\\mu,\\lambda$ も出発点は同じ岩澤分解 " +
      "$g=p^{\\mu}fh$（$f$ は distinguished 多項式、$h$ は単元）であり、" +
      "**Weierstrass 準備定理が与えるのは $fh$ の部分だけで、$p^{\\mu}$ を括り出す段は与えない。** " +
      "その段（$\\mu$ 不変量の存在）を書いた（`exists_greatest_pow_dvd`。" +
      "有界性の中身は「$p^k$ は各係数を割るので、$k$ は $0$ でない係数の $p$ 進付値を超えられない」だけである）。" +
      "併せて **Weierstrass 準備定理が $\\mathbb{Z}_p[[X]]$ へインスタンスの補い無しに当たること**を" +
      "実在する宣言として残した（`weierstrass_over_padicInt`）。" +
      "**残っているのは Theorem 5.6 の主張そのもの**（$\\mathrm{ord}_\\ell$ の漸近）である。" +
      "$\\mathrm{ord}_\\ell$ の漸近は整数値の増大則であり可算側の内容を担うので、" +
      "$\\mathbb{R}$ 脱出として隔離する側には置けない。" +
      "**cycle 41 step 3 で第 2 段を書いた**（`IwasawaDecomposition.lean`）。" +
      "**第 1 段の 2 つはまだ繋がっていなかった。そう書く**——Weierstrass 準備定理は" +
      "「$\\bmod\\ p$ 還元が $0$ でない」ことを仮定として要求するので、$p$ で割り切れる $g$ には当たらない。" +
      "$\\mu$ を括り出した残り $g_1$ が $p$ で割れないことを $\\mu$ の最大性から出し" +
      "（割り切りの取り消しに $\\mathbb{Z}_p[[X]]$ が整域であることを使う）、" +
      "還元が $0$ であることと $p$ で割れることが同じである（`map_residue_eq_zero_iff`）" +
      "ことを経由して準備定理へ渡した。**これで岩澤分解 $g=p^{\\mu}fh$ が出る**（`exists_iwasawa_factorization`）。" +
      "併せて **$\\lambda=\\deg f$ が分解の取り方に依らず $g$ から決まること**を書いた" +
      "（`degree_eq_order_map`。$g_1$ の $\\bmod\\ p$ 還元の位数に等しい）。" +
      "**それでもこの外部定理は完了しない。残っているのは $\\mathrm{ord}$ の漸近そのものである。そう書く**——" +
      "$1$ の冪根での評価と、その積の付値を数える段が要る。本 step はその手前までである。" +
      "**cycle 42 step 5 で第 3 段の半分を書いた**（`IwasawaOrdCounting.lean`）。**着手して測ると、この段は 2 つに割れた。そう書く**——(a) 評価を環準同型として受け取れば付値は分解に沿って足し算になること（`emultiplicity_eval_iwasawa`。$g=p^{\\mu}fh$ で $\\varphi(h)$ が単元・$\\varphi(p)$ が素元なら $v(\\varphi(g))=\\mu+v(\\varphi(f))$。単元の付値が $0$ であるというだけの内容である）と、その和の形（`sum_emultiplicity_eval_iwasawa`。$1$ の冪根を走る有限集合 $s$ について $\\sum_\\zeta v(\\varphi_\\zeta(g))=|s|\\mu+\\sum_\\zeta v(\\varphi_\\zeta(f))$。**$\\mu$ の側が $|s|$ に比例し、$\\lambda$ の側が $f$ の評価の和に落ちるという、漸近の骨格そのものである**）。(b) **その評価が実際に存在すること**——$\\mathbb{Z}_p[[X]]$ の元を $\\zeta-1$ で評価する写像の構成である。**冪級数の収束が要るので代数だけでは出ない。書いていない。そう書く。**本ファイルは評価を仮定として型に出しており、`PropT.lean` の段 5 と同じ受け取り方である。**残っているのはこの (b) と、$\\sum_\\zeta v(\\varphi_\\zeta(f))=\\lambda n+O(1)$ の側である。**" +
      "**cycle 43 step 4 で (b) を書いた**（`IwasawaEvaluation.lean`）。" +
      "**この記録の射程が実測で狭まった。そう書く**——「収束が要る」という側は正しいが、「代数だけでは出ない=書けない」という側は誤りだった。" +
      "**mathlib は評価写像を持っている**（`PowerSeries.eval₂Hom`、`Mathlib/RingTheory/PowerSeries/Evaluation.lean` 160 行。2026-08-05 実測）。" +
      "cycle 42 step 5 が見つけられなかったのは、探した語が「収束」の側だったためである（cycle 40・41 の「定理の名前で引くと道具が見えない」の、概念の名前の側の版である）。" +
      "**併せて $\\mathbb{R}$ 脱出かどうかの判定が実測で決まった**——`eval₂Hom` が要求している収束は `IsTopologicallyNilpotent`（$a^n\\to0$）で、位相は線形位相（$0$ の近傍がイデアルの基本系をなす）である。" +
      "アルキメデス的な順序も絶対値も距離も使わない。**$p$ 進の位相はまさにこの形なので、この段は $\\mathbb{R}$ へ出ない。**" +
      "書いたのは 4 つで、イデアルに属する元が評価点として使えること（`hasEval_of_mem`。**本文の $\\zeta-1$ がこの形である**）、評価写像そのもの（`evalHom`）、$X$ と定数の行き先（`evalHom_X` / `evalHom_C`）、" +
      "そして cycle 42 step 5 の付値の足し算にこの評価を実際に渡した形（`emultiplicity_evalHom_iwasawa`。**仮定として受け取っていた環準同型が構成したもので埋まる**）である。" +
      "**それでもこの外部定理は完了しない。残っているのは 2 つである。そう書く**——$\\sum_\\zeta v(\\varphi_\\zeta(f))=\\lambda n+O(1)$ の側（Theorem 5.6 に残る最後の中身）と、" +
      "$1$ の $p^n$ 乗根 $\\zeta$ について $\\zeta-1$ が極大イデアルに属することの数論側の同定である。" +
      "**cycle 44 step 4 で後者を書いた**（`IwasawaRootOfUnity.lean`）。" +
      "**中身は Frobenius ひとつである**——剰余体の標数が $p$ なら " +
      "$(\\bar\\zeta-1)^{p^n}=\\bar\\zeta^{p^n}-1=0$ であり、体には冪零元が無いので $\\bar\\zeta=1$、" +
      "すなわち $\\zeta-1$ は極大イデアルに入る（`sub_one_mem_maximalIdeal_of_pow_eq_one`）。" +
      "これで cycle 43 step 4 の評価写像に評価点が実際に渡る" +
      "（`hasEval_sub_one_of_pow_eq_one`。**本文が $\\varphi_\\zeta$ と書いている評価はこれである**）。" +
      "**同じサイクルの step 2 と対になっている。そう書く**——あちらは位数が剰余標数と素な根が" +
      "剰余体でも位数を保つこと、こちらは位数が剰余標数の冪である根が剰余体で $1$ に潰れることで、" +
      "**「剰余体へ落としたときに根がどうなるか」の互いに補い合う 2 つの場合である。** " +
      "**それでもこの外部定理は完了しない。残っているのは 1 つである。そう書く**——" +
      "$\\sum_\\zeta v(\\varphi_\\zeta(f))=\\lambda n+O(1)$ の側である。" +
      "**2026-08-05 実測でその段の材料を測った**（mathlib `520045ab14` の 8264 ファイル）——" +
      "`Polynomial.IsDistinguishedAt` は 2 ファイルに在るが" +
      "（`Mathlib/RingTheory/PowerSeries/WeierstrassPreparation.lean` と " +
      "`Mathlib/RingTheory/Polynomial/Eisenstein/Distinguished.lean`）、後者に `Valuation` は 1 度も現れず、" +
      "**Newton 多角形（`NewtonPolygon`）は 1 ファイルも無い。** " +
      "**したがってここは配線ではなく素材の側である。**",
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

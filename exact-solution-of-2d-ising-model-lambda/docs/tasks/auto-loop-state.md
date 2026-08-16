# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-16 の tick 334 は、台帳の先頭行「部分正方形との比較の対数化と密度の挟み込み（$\Lambda_{\mathbb Q}$ 版。倍数でない辺への拡張）」を二つに割り、前半「開境界正方形と部分正方形の比較の対数化（$\Lambda$ の鎖。$q$ は 1 以下）」を本文・SageMath・Lean（具体版・必要十分版は共有・導出版）まで書き、四層で閉じた。**
  `claim_open_square_subsquare_comparison_log_le_one`（`claim_open_square_subsquare_comparison_rational_le_one` の直後、住処 Lambda）で、$1\le a<L$、$0<q\le1$ に対し
  $(a+L)\log q+\log Z^{\mathrm{op}}_{a,a}(q)\le_\Lambda\log Z^{\mathrm{op}}_{L,L}(q)\le_\Lambda(L^2-a^2)\ell_2+2(L^2-a^2)\log(1+q)+\log Z^{\mathrm{op}}_{a,a}(q)$。
  準備 3 つ（正値性・$\log2=\ell_2$・下端の対数を開く二段と上端の対数を開く四段）と、`claim_rational_log_order_iff` で値の比較を移す 4 段の鎖 1 本。
  SageMath `check/open-square-subsquare-comparison-log/`（形 $(a,L)\in\{(1,2),(1,3),(2,3)\}$ × 有理点 6 点、216 検査）。
  Lean 具体版 `ThermodynamicLimit/OpenSquareSubsquareComparisonLog.lean`、必要十分版は `twoSided_bounds_transport_through_monotone_map_necSuf` を共有、導出版 `OpenSquareSubsquareComparisonLogFromNecSuf.lean`。sorry 検査 1241 件。
  次は後半「部分正方形との比較による密度の挟み込み（$\Lambda_{\mathbb Q}$ 版。倍数でない辺への拡張）」。

- **2026-08-16 の tick 333 は、「開境界長方形の接合不等式の対数化（$\Lambda$ の鎖）」を本文・SageMath・Lean（具体版・必要十分版は共有・導出版）まで書き、四層で閉じた。**
  台帳の先頭行「有限系の密度の接合不等式（$\Lambda_{\mathbb Q}$ 版）」は、密度 $\Psi^{\mathrm{op}}$ が正方形にしか定義されておらず「$\Psi$ どうしの不等式」は長方形の接合では書けない
  （正方形どうしの $\Psi$ の不等式は既に `claim_open_square_block_tiling_density` が担う）ので、接合不等式そのものの対数化に割り直して実行した。
  `claim_open_rectangle_gluing_inequality_log`（`claim_open_rectangle_gluing_inequality_rational` の直後、住処 Lambda）で、二つの座標の向き × 二場合の四つ:
  $0<q\le1$: $b\log q+\log Z^{\mathrm{op}}_{a,b}(q)+\log Z^{\mathrm{op}}_{c,b}(q)\le_\Lambda\log Z^{\mathrm{op}}_{a+c,b}(q)\le_\Lambda\log Z^{\mathrm{op}}_{a,b}(q)+\log Z^{\mathrm{op}}_{c,b}(q)$、$1\le q$: 反転、第二の座標の向きは $b\to a$ 等。
  準備 2 つ（正値性・下端の対数を開く三段と上端の一段）と、`claim_rational_log_order_iff` で接合不等式を移す 4 段の鎖 2 本。
  SageMath `check/open-rectangle-gluing-inequality-log/`（形 10 通り × 有理点 9 点 × 二向き、1700 検査、10 秒）。
  Lean 具体版 `ThermodynamicLimit/OpenRectangleGluingInequalityLog.lean`、必要十分版は `twoSided_bounds_transport_through_monotone_map_necSuf` を共有、導出版 `OpenRectangleGluingInequalityLogFromNecSuf.lean`。sorry 検査 1237 件。
  次は「部分正方形との比較の対数化と密度の挟み込み（$\Lambda_{\mathbb Q}$ 版。倍数でない辺への拡張）」。

- **2026-08-16 の tick 332 は、「有理係数の対数順序群の Cauchy 列」の定義を本文・SageMath・Lean まで書き、台帳の「極限の存在を $\Lambda\otimes\mathbb{Q}$ の Cauchy 性として述べる」を閉じた。**
  `def_rational_log_order_group_cauchy_sequence`（`claim_open_square_block_tiling_density` の直後・`remark_real_escape_plan` の直前、住処 Lambda）で、
  $\Lambda_{\mathbb Q}$ の元の列 $(\lambda_L)_{L\ge1}$ が Cauchy 列であるとは、$0\le_{\Lambda_{\mathbb Q}}\varepsilon$ かつ $\varepsilon\ne0$ なる任意の $\varepsilon\in\Lambda_{\mathbb Q}$ に対し
  ある $N\ge1$ があって $N\le L,M$ なるすべての $L,M$ で $-\varepsilon\le_{\Lambda_{\mathbb Q}}\lambda_L-\lambda_M\le_{\Lambda_{\mathbb Q}}\varepsilon$ が成り立つこと、と定めた
  （$\varepsilon$ は $\Lambda_{\mathbb Q}$ の元のまま。単位 $\iota(\ell_2)$ の有理数倍に限定しない。$N$ は $\varepsilon$ に依存してよく、Cauchy 性を主張する証明では $\varepsilon\mapsto N$ の手続きを明示する、と本文に書いた。
  極限が $\Lambda_{\mathbb Q}$ に存在することは主張せず、極限に名前を与える段は `remark_real_escape_plan` の脱出に置く）。
  SageMath `check/rational-log-order-group-cauchy-sequence/`（決定手続きの一致 21051 回、定数列、$(1/L)\iota(\ell_2)$ の $N$ の探索と窓 40 での検査、$L\iota(\ell_2)$ が破ること。6 秒）。
  Lean `ThermodynamicLimit/RationalLogOrderGroupCauchySequence.lean`（`IsCauchyRationalLogOrder`・`rationalLogOrderLE_neg_of_nonneg`・`isCauchyRationalLogOrder_const`。定義なので必要十分版は無し）。sorry 検査 1227 件。
  次は「有限系の密度の接合不等式（$\Lambda_{\mathbb Q}$ 版）」。

- **2026-08-16 の tick 331 は、「部分正方形との比較（$0<q\le1$。$\mathbb Q$ 版）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで完成させ、四層で閉じた。**
  `claim_open_square_subsquare_comparison_rational_le_one`（`claim_open_rectangle_value_upper_bound_at_positive_rational` の直後・`claim_open_square_free_entropy_density_upper_bound` の直前、住処 Q）で、
  $1\le a<L$、$q\in\mathbb Q$、$0<q\le1$ に対し $q^{a+L}Z^{\mathrm{op}}_{a,a}(q)\le Z^{\mathrm{op}}_{L,L}(q)\le2^{L^2-a^2}(1+q)^{2(L^2-a^2)}Z^{\mathrm{op}}_{a,a}(q)$。
  削除済みの実数値版（上界 $2^{L^2-a^2}$）と同じ論法だが、$\mathbb Q$ 側にある上からの評価は一様な $2^{ab}(1+q)^{2ab}$（`claim_open_rectangle_value_upper_bound_at_positive_rational`）なので上界に $(1+q)^{2(L^2-a^2)}$ が付く。
  準備 3 つ（$c=L-a$・$ac+cL=L^2-a^2$・正値性）、下側 7 段（$1\le Z$ 二回と二方向の接合の下側）、上側 8 段（二方向の接合の上側と値の上からの評価二回）。
  SageMath `check/open-square-subsquare-comparison-rational/`（形 $(a,L)\in\{(1,2),(1,3),(2,3)\}$ × 有理点 6 点、270 検査、4 秒）。
  Lean 具体版 `OpenSquareSubsquareComparisonRational.lean`（`openPartitionValueRat_square_subsquare_bounds_of_le_one`）、必要十分版は実数版の `split_twice_bounds_necSuf` をそのまま共有
  （可換半環の順序と非負元の乗法単調性だけなので $\mathbb Q$ でも通る。**旧実数値経路の Lean を片付けるときこの必要十分版は残すこと**）、導出版 `OpenSquareSubsquareComparisonRationalFromNecSuf.lean`。sorry 検査 1225 件。
  次は「極限の存在を $\Lambda\otimes\mathbb{Q}$ の Cauchy 性として述べる」。

- **2026-08-16 の tick 330 は、「ブロック敷き詰めの密度の挟み込み（$\Lambda_{\mathbb Q}$ 版）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで完成させ、四層で閉じた。**
  `claim_open_square_block_tiling_density`（`claim_open_square_block_tiling_log` の直後・`remark_real_escape_plan` の直前、住処 Lambda）で、
  $a,k\ge1$、$q\in\mathbb Q_{>0}$ に対し $0<q\le1$: $\frac{2(k-1)}{ka}\cdot\iota(\log q)+\Psi^{\mathrm{op}}_a(q)\le_{\Lambda_{\mathbb Q}}\Psi^{\mathrm{op}}_{ka}(q)\le_{\Lambda_{\mathbb Q}}\Psi^{\mathrm{op}}_a(q)$、$1\le q$: その反転。
  証明は準備 3 つ（正値性と $(ka)^2\ne0$ と $n\cdot\iota(\nu)=\iota(n\nu)$・上からの評価の側の四段・下からの評価の側の六段）と、二場合とも左右の不等式を 3 段の鎖 2 本ずつ
  （準備の等式・`claim_scaled_embedding_order_transfer` を $L:=ka$ で読んで `claim_open_square_block_tiling_log` を移す・`def_open_square_free_entropy_density`）。
  SageMath は前 tick の下書きを `check/open-square-block-tiling-density/` へ移して overview を付けた（556 検査 PASS、所要 10 秒。$4\times4$ を含む形は外したまま）。
  Lean 具体版 `OpenSquareBlockTilingDensity.lean`（`scaled_blockTilingUpperForm_eq`・`scaled_blockTilingLowerForm_eq`・
  `rationalLogOrderLE_openSquareBlockTilingDensity_bounds_of_le_one`／`_of_one_le`）、必要十分版は前々 tick の `twoSided_bounds_transport_through_monotone_map_necSuf` を
  `ell := λ ↦ (1/(ka)²)·ι(λ)` で共有、導出版 `OpenSquareBlockTilingDensityFromNecSuf.lean`。sorry 検査 1223 件。PDF の題名に組めない文字 ℚ があったので「Λ_Q 版」へ直した。
  次は「部分正方形との比較（$0<q\le1$。$\mathbb Q$ 版）」。

（これより古い 287 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

## セクション台帳

**済んだ範囲**（章ごとの件数。個々の内訳は [auto-loop-archive.md](auto-loop-archive.md) と
MEMORY.md にある。番号で呼ばないので、ここでは章と件数だけを持つ）。

- 固有値の代数性: 128 セクション
- Fisher 零点: 44 セクション
- 分配多項式: 4 セクション
- 転送行列: 4 セクション
- 有限系の自由エントロピー: 11 セクション
- 形式検証の土台: 1 セクション
- 零点の詰め寄り: 5 セクション
- 熱力学極限: 55 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 部分正方形との比較による密度の挟み込み（$\Lambda_{\mathbb{Q}}$ 版。倍数でない辺への拡張） | todo | `claim_open_square_subsquare_comparison_log_le_one` の三つの元を $\frac1{L^2}\iota$ で移し（`claim_scaled_embedding_order_transfer`）、$\Psi^{\mathrm{op}}_L$ を $\frac{a+L}{L^2}\iota(\log q)+\frac{a^2}{L^2}\Psi^{\mathrm{op}}_a$ と $\frac{L^2-a^2}{L^2}(\iota(\ell_2)+2\iota(\log(1+q)))+\frac{a^2}{L^2}\Psi^{\mathrm{op}}_a$ で挟む（$\frac1{L^2}\iota(\log Z^{\mathrm{op}}_{a,a}(q))=\frac{a^2}{L^2}\Psi^{\mathrm{op}}_a(q)$ は `claim_open_square_block_tiling_density` の準備と同じ約分）。書き方は `claim_open_square_block_tiling_density`。必要十分版は `twoSided_bounds_transport_through_monotone_map_necSuf` を共有できる見込み。本文末尾「開境界自由エネルギー密度の極限（倍数でない辺への拡張）」に対応する行 |
| 熱力学極限 | 密度の列の Cauchy 性 | todo | $\bigl(\Psi_L(q)\bigr)_L$ の差を有理数で抑える。完備性も極限論も使わない |
| 熱力学極限 | 切断による実数体への一度きりの脱出 | todo | Cauchy 列が定める $\mathbb{Q}$ 上の切断として自由エネルギー密度を取る。引くのは「切断は実数を定める」ことだけ |
| 熱力学極限 | 削除した実数値経路の Lean の後片付け | todo | 2026-08-16 に本文から消した実数値経路（実対数・上限／下限による極限）の Lean ファイルが孤立して残っている。入口からの import と sorry 検査は通るが、対応する本文が無いので消す |
| 熱力学極限 | 周期境界自由エネルギー密度への移送 | todo | 周期境界と開境界の境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録

- 2026-08-16（tick 334）: 台帳の先頭行「部分正方形との比較の対数化と密度の挟み込み（$\Lambda_{\mathbb Q}$ 版。倍数でない辺への拡張）」を、$\Lambda$ の鎖と $\Lambda_{\mathbb Q}$ の挟み込みで論法が二つあるので
  「開境界正方形と部分正方形の比較の対数化（$\Lambda$ の鎖。$q$ は 1 以下）」と「部分正方形との比較による密度の挟み込み（$\Lambda_{\mathbb Q}$ 版。倍数でない辺への拡張）」の二行へ割り、前半を実行した。
  `claim_open_square_subsquare_comparison_log_le_one` を `claim_open_square_subsquare_comparison_rational_le_one` の直後に置いた。証明は `claim_open_rectangle_gluing_inequality_log` と同じ型
  （準備: 正値性・$\log2=\ell_2$（`claim_finite_free_entropy_density_upper_bound` の準備を引く）・両端の対数を開く二段と四段、本体は `claim_rational_log_order_iff` で移す 4 段の鎖 1 本）。
  SageMath `open-square-subsquare-comparison-log`（`ZZ`/`QQ`・有限台辞書。一辺 4 以上は含めない）。Lean 具体版・導出版を書き、入口 import・sorry 検査へ 4 件登録（計 1241 件）。
  式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 333）: 台帳の先頭行「有限系の密度の接合不等式（$\Lambda_{\mathbb Q}$ 版）」を「開境界長方形の接合不等式の対数化（$\Lambda$ の鎖）」へ割り直して実行した
  （$\Psi^{\mathrm{op}}$ は正方形にしか定義が無く、長方形の接合を $\Psi$ で書くには長方形の密度の定義が要る。正方形どうしの $\Psi$ の不等式は既に
  `claim_open_square_block_tiling_density` が担い、倍数でない辺は次の行が担うので、この行の中身は接合不等式の $\Lambda$ 版に尽きる）。
  `claim_open_rectangle_gluing_inequality_log` を `claim_open_rectangle_gluing_inequality_rational` の直後に置いた。証明は `claim_open_square_block_tiling_log` と同じ型
  （準備 2 つ・`claim_rational_log_order_iff` で移す鎖）。第二の座標の向きは置き換えで同じ段（本文は置き換えの対応を書いた。Lean は四つとも別定理として書いた）。
  SageMath `open-rectangle-gluing-inequality-log`（`ZZ`/`QQ`・有限台辞書。$4\times4$ を含む形は外した）。Lean 具体版・導出版を書き、入口 import・sorry 検査へ 10 件登録（計 1237 件）。
  式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 332）: `def_rational_log_order_group_cauchy_sequence` を `claim_open_square_block_tiling_density` の直後（`remark_real_escape_plan` の直前）に置いた。
  台帳の行「極限の存在を $\Lambda\otimes\mathbb{Q}$ の Cauchy 性として述べる」は「述べる」だけの行なので定義ブロック 1 つとして実行した（Cauchy 性の証明は後続の行「密度の列の Cauchy 性」）。
  $\varepsilon$ の範囲は $\Lambda_{\mathbb Q}$ の正の元全体にした（単位 $\iota(\ell_2)$ の有理数倍に限る形も考えたが、それは切断の段で単位を選ぶときに決めればよく、定義に単位を埋め込む理由が無い。
  どちらの形でも Cauchy 性の証明には「$\mu,\varepsilon>0$ に対し $\mu\le n\cdot\varepsilon$ となる $n$」の形の補題（$\mathbb Q$ の Bernoulli 不等式で示せる）が要る——後続の行で用意すること）。
  厳密な順序 $<_{\Lambda_{\mathbb Q}}$ は本文に定義が無いので「$0\le\varepsilon$ かつ $\varepsilon\ne0$」と書いた。
  SageMath `rational-log-order-group-cauchy-sequence`（`ZZ`/`QQ`・有限台辞書）、Lean 具体版（列は `ℕ → RationalLogOrderGroup` で $L=0$ の値は $N\ge1$ のため参照されない）。
  入口 import・sorry 検査へ 2 件登録（計 1227 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 331）: `claim_open_square_subsquare_comparison_rational_le_one` を `claim_open_rectangle_value_upper_bound_at_positive_rational` の直後
  （`claim_open_square_free_entropy_density_upper_bound` の直前）に置き四層で閉じた。git 履歴の実数値版 `claim_open_square_subsquare_comparison_le_one`（2026-08-15）の証明を
  $\mathbb Q$ 版の道具（`claim_open_rectangle_gluing_inequality_rational`・`claim_open_rectangle_value_ge_one_at_positive_rational`・
  `claim_open_rectangle_value_upper_bound_at_positive_rational`）で書き直した。上界の因子は $\mathbb Q$ 版の値の上からの評価が一様な $2^{ab}(1+q)^{2ab}$ なので
  $2^{L^2-a^2}(1+q)^{2(L^2-a^2)}$（実数値版の $2^{L^2-a^2}$ より緩い。密度の極限へ渡すとき $L^2-a^2$ の項が $L^2$ に対して消える性質は変わらない）。
  SageMath `open-square-subsquare-comparison-rational`（下側 7 段・上側 8 段を段ごとに。一辺 4 以上は含めない）。Lean 具体版 `ThermodynamicLimit/OpenSquareSubsquareComparisonRational.lean`
  （実数版と同じ段。`open NecSuf.ThermodynamicLimit` が要る——`pow_pos_by_induction` がそこにある）、必要十分版は `split_twice_bounds_necSuf` を共有、
  導出版 `OpenSquareSubsquareComparisonRationalFromNecSuf.lean`。入口 import・sorry 検査へ 2 件登録（計 1225 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 330）: `claim_open_square_block_tiling_density` を `claim_open_square_block_tiling_log` の直後（`remark_real_escape_plan` の直前）に置き四層で閉じた。
  準備 3 つ（第一: 正値性・$(ka)^2\ne0$・`claim_scaled_free_entropy_denominator_clearing` の末尾の $n\cdot\iota(\nu)=\iota(n\nu)$。第二: 上からの評価の側の四段
  （$n\cdot\iota(\nu)=\iota(n\nu)$ 逆向き・結合則・約分 $\frac{k^2}{k^2a^2}=\frac1{a^2}$・定義）。第三: 下からの評価の側の六段（`claim_rational_log_order_group_embedding` の加法・分配則・
  $n\cdot\iota(\nu)=\iota(n\nu)$ 逆向き・結合則・約分 $\frac{2k(k-1)a}{k^2a^2}=\frac{2(k-1)}{ka}$・第二））。本体は二場合とも左右の不等式を 3 段の鎖 2 本ずつ。
  SageMath `open-square-block-tiling-density`（前 tick の下書きを移動。形 $(a,k)\in\{(1,1),(1,2),(1,3),(2,1)\}$ × 正の有理点 9 点、556 検査、10 秒。`ZZ`/`QQ`・有限台辞書）。
  Lean 具体版 `ThermodynamicLimit/OpenSquareBlockTilingDensity.lean`（`NeZero (k*a)` は mathlib の `NeZero.mul` 実例で `[NeZero a] [NeZero k]` から。約分は `push_cast; field_simp`。
  $k-1$ は自然数のまま、係数は $\frac{2\cdot((k-1:\mathbb N):\mathbb Q)}{k\cdot a}$）、必要十分版は `twoSided_bounds_transport_through_monotone_map_necSuf` を共有、
  導出版 `OpenSquareBlockTilingDensityFromNecSuf.lean`。入口 import・sorry 検査へ 6 件登録（計 1223 件）。式変形統一は一時停止中のため実施せず。

（これより古い 297 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

## 式変形の書き方の統一（並列の作業ストリーム。毎 tick 1 件）

規則は両プロジェクトの README にある「式変形は一続きにする。根拠は行末に $(\because\ \dots)$ で書く」。
**毎 tick 1 件だけ**書き換え、検証を通し、ここへ記録する。中身は変えない（書き方だけ）。

### 本プロジェクト（`exact-solution-of-2d-ising-model-lambda`）

| 証明 | 状態 |
|---|---|
| 分配多項式の係数は多重度である | 済（2026-08-08） |
| 多重度の総和は配位の総数に等しい | 済（2026-08-08） |
| すべての配位を等しく数える点での自由エントロピー | 済（2026-08-08） |

（済んだ分の一覧は [auto-loop-archive.md](auto-loop-archive.md)。）

## レビュー記録

- 2026-08-16（tick 334）: 前 tick の「開境界長方形の接合不等式の対数化（$\Lambda$ の鎖）」の本文（準備 2 つ・第一の座標の向きの鎖 2 本・第二の座標の向きの置き換え）・SageMath overview・
  Lean 具体版（準備の等式 2 本と 4 定理）・導出版（入口 import・sorry 検査への登録）を突き合わせ、根拠が一致した。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 333）: 前 tick の「有理係数の対数順序群の Cauchy 列」の本文（定義・$N$ の依存・極限の非主張）・SageMath overview・Lean（`IsCauchyRationalLogOrder`・定数列）を突き合わせ、一致した。
  本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 332）: 前 tick の「部分正方形との比較（$0<q\le1$。$\mathbb Q$ 版）」の本文（準備 3 つ・下側 7 段・上側 8 段）・SageMath overview・Lean 具体版（人手証明との対応表）・
  必要十分版（実数版と共有）・導出版（入口 import・sorry 検査への登録）を突き合わせ、接合不等式の向きと $b:=a$／$b:=L$ の読み替えを含め根拠が一致した。
  本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 331）: 前 tick の「ブロック敷き詰めの密度の挟み込み（$\Lambda_{\mathbb Q}$ 版）」の本文（準備 3 つと二場合の 3 段の鎖 2 本ずつ）・SageMath overview・
  Lean 具体版・必要十分版（共有）・導出版（入口 import・sorry 検査への登録）を突き合わせ、根拠が一致した。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。
  台帳の todo が指していた `claim_open_square_subsquare_comparison_le_one` は 2026-08-16 の実数値経路の削除で本文から消えており（Lean は孤立して残存）、
  git 履歴（コミット c205c4ed）から原本を読んで $\mathbb Q$ 版を書いた。本文末尾の「開境界自由エネルギー密度の極限（倍数でない辺への拡張）」に対応する行がセクション表に無かったので、
  「部分正方形との比較の対数化と密度の挟み込み（$\Lambda_{\mathbb{Q}}$ 版。倍数でない辺への拡張）」を「密度の列の Cauchy 性」の直前へ足した。本文の修正は無い。

- 2026-08-16（tick 330）: 前 tick の SageMath 下書き `sagemath/drafts/open-square-block-tiling-density.check.sage` を、決めてあった証明の骨格（準備 3 つと二場合の鎖）と突き合わせ、
  段の並びと根拠が一致した。下書きの見出し（「まだ check/ に置かない」）は移動に伴い対象ラベル宣言へ書き換えた。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。他に修正は無い。

（これより古い 318 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

## 判断待ち（人間に問うべき論点）

- **content のファイルを分けるときの文書順の決め方。** システムは `content/` のファイル名昇順を
  文書順とみなすが、リポジトリの規約はファイル名の連番を禁じている。
  2026-08-08（tick 5）に 2 つめの章を書くときこれに当たった。連番は振らず、章ごとにファイルを
  分けることもせず、**本文を 1 ファイル `content/main-text.ts` へまとめて章を見出しブロックで
  区切る**形にした（ファイルが 1 つなら配列順がそのまま文書順になり、論点に当たらないため。
  旧ファイル名 `partition-polynomial.ts` は 1 章分しか指さないので改名した）。
  これは論点の解決ではなく回避である。本文が育ってファイルを分けたくなった時点で決着が要る。
  → **決着の案（人間の判断を待つ）**: システム側（リポジトリ直下 `structured-latex/`）に
  文書順の明示的な宣言（例えば `content/order.ts` にファイル名を並べる）を入れ、
  ファイル名昇順という暗黙の規則をやめる。この変更はシステム側の入力言語に触るため、
  他プロジェクト（`exact-solution-of-2d-ising-model/` 等）にも影響する。

## cron（launchd）

- ラベル: `com.masaori.ising-lambda-auto-loop`
- 定義: `~/Library/LaunchAgents/com.masaori.ising-lambda-auto-loop.plist`
- 実体: `scripts/auto-loop-tick.sh`（毎時 5 分、見送られたときの再試行が 35 分。45 分で打ち切る）
- ログ: `logs/auto-loop.log`（git 管理外）
- 各 tick は**独立した新しいセッション**として走る（文脈を持ち越さない。持ち越すのは
  この台帳とリポジトリの中身だけ）。使うエージェントは **Claude と Codex の交互**
  （Claude は `claude-fable-5` の effort medium、Codex は `gpt-5.6-sol` の reasoning medium）。
  片方が使用量の上限に当たった間は、期限を `logs/claude-blocked-until` へ記録してもう片方だけで回す。
- 監査は別ジョブ（毎時 55 分の軽い監査 `scripts/audit-light.sh`、毎日 04:20 の重い監査
  `scripts/audit-loop.sh`）。PDF は `scripts/refresh-pdf.sh` が 5 分おきに最新へ保つ。

停止・再開・頻度変更は、**自分で `launchctl` を叩かず** tmux セッション `local-pc-management` の
ウィンドウ `tick窓口` へ依頼する（2026-08-16 に経路が固定された。`launchd-tick-loop` skill）。

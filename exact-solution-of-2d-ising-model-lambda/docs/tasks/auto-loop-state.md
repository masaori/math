# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-16 の tick 336 は、台帳の先頭行「何も言っていない主張の一掃（既存分）」を実行し、「有限系の密度の分母は整数倍で払える」（$L^2M^2\cdot\frac1{L^2}\iota(\lambda)=M^2\iota(\lambda)$。$\mathbb Q$ の四則だけ）を本文から消した。**
  この主張を引いていた 7 箇所はすべて証明末尾の補助等式 $n\cdot\iota(\nu)=\iota(n\nu)$ だけを使っていたので、その等式を
  `claim_rational_embedding_commutes_with_integer_multiple`（「対数順序群から有理係数の対数順序群への写像は整数倍と交換する」。`claim_rational_log_order_group_embedding` の直後、住処 Lambda。各素数での値の五段の鎖）として残し、7 箇所の参照を付け替えた。
  SageMath `check/rational-embedding-commutes-with-integer-multiple/`（旧 `scaled-free-entropy-denominator-clearing` を作り直し。$n\in\{-6,\dots,6\}$ × 有限台 5 組、247 検査）。
  Lean は具体版 `scaledFreeEntropy_clear_denominator`・必要十分版 `two_scaled_denominators_cancel_necSuf`・導出版の 3 ファイルを削除し、残す `toRational_intSmul` に必要十分版 `NecSuf.pointwise_lift_intSmul_necSuf`（加法群上の有限台写像への値ごとの持ち上げは整数倍と交換する）と導出版 `toRational_intSmul_from_necSuf` を足した。sorry 検査 1245 件。
  全 284 件の主張を題名で走査し、証明の短い順にも見たが、他に体の四則だけのブロックは無かった（`claim_qbar_no_zero_divisors` は 10 箇所が引くので残す。所属・表示・well-defined 性を言う短い主張は残す）。以後は毎 tick のレビュー観点で見る。
  次は「密度の列の Cauchy 性」（着手時に論法の数で割ること。Archimedes 型の補題「$\mu,\varepsilon>0$ に対し $\mu\le_{\Lambda_{\mathbb Q}}n\cdot\varepsilon$ となる $n$」が要る）。

- **2026-08-16 の tick 335 は、「部分正方形との比較による密度の挟み込み（$\Lambda_{\mathbb Q}$ 版。倍数でない辺への拡張）」を本文・SageMath・Lean（具体版・必要十分版は共有・導出版）まで書き、四層で閉じた。**
  `claim_open_square_subsquare_comparison_density_le_one`（`claim_open_square_subsquare_comparison_log_le_one` の直後、住処 Lambda）で、$1\le a<L$、$0<q\le1$ に対し
  $\frac{a+L}{L^2}\iota(\log q)+\frac{a^2}{L^2}\Psi^{\mathrm{op}}_a(q)\le_{\Lambda_{\mathbb Q}}\Psi^{\mathrm{op}}_L(q)\le_{\Lambda_{\mathbb Q}}\frac{L^2-a^2}{L^2}\iota(\ell_2)+\frac{2(L^2-a^2)}{L^2}\iota(\log(1+q))+\frac{a^2}{L^2}\Psi^{\mathrm{op}}_a(q)$。
  $L$ が $a$ の倍数でなくてもよい。準備 4 つ（正値性と分母・$\frac1{L^2}\iota(\log Z^{\mathrm{op}}_{a,a})=\frac{a^2}{L^2}\Psi^{\mathrm{op}}_a$ の三段・下端の像の六段・上端の像の六段）と、
  `claim_scaled_embedding_order_transfer` で `claim_open_square_subsquare_comparison_log_le_one` を移す 3 段の鎖 2 本。
  SageMath `check/open-square-subsquare-comparison-density/`（形 $(a,L)\in\{(1,2),(1,3),(2,3)\}$ × 有理点 6 点、396 検査、4 秒。$\le_{\Lambda_{\mathbb Q}}$ の決定手続きの共通分母を分母の積から最小公倍数へ変えた——積だと $\mathrm{rat}_\Lambda$ の冪の指数が巨大になり 10 分で終わらなかった）。
  Lean 具体版 `ThermodynamicLimit/OpenSquareSubsquareComparisonDensity.lean`、必要十分版は `twoSided_bounds_transport_through_monotone_map_necSuf` を共有、導出版 `OpenSquareSubsquareComparisonDensityFromNecSuf.lean`。sorry 検査 1246 件。
  本文末尾「この先に書くこと」の済んだ項目（密度の可算側への畳み込み・Cauchy 性の記述・倍数でない辺への拡張）を消した。
  次は「密度の列の Cauchy 性」（Archimedes 型の補題「$\mu,\varepsilon>0$ に対し $\mu\le_{\Lambda_{\mathbb Q}}n\cdot\varepsilon$ となる $n$」が要る。着手時に論法の数で割ること）。

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

（これより古い 289 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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
- 熱力学極限: 56 セクション
- 全章（何も言っていない主張の一掃）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 密度の列の Cauchy 性 | todo | $\bigl(\Psi_L(q)\bigr)_L$ の差を有理数で抑える。完備性も極限論も使わない |
| 熱力学極限 | 切断による実数体への一度きりの脱出 | todo | Cauchy 列が定める $\mathbb{Q}$ 上の切断として自由エネルギー密度を取る。引くのは「切断は実数を定める」ことだけ |
| 熱力学極限 | 削除した実数値経路の Lean の後片付け | todo | 2026-08-16 に本文から消した実数値経路（実対数・上限／下限による極限）の Lean ファイルが孤立して残っている。入口からの import と sorry 検査は通るが、対応する本文が無いので消す |
| 熱力学極限 | 周期境界自由エネルギー密度への移送 | todo | 周期境界と開境界の境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録

- 2026-08-16（tick 336）: 台帳の先頭行「何も言っていない主張の一掃（既存分）」を実行した。消したのは `claim_scaled_free_entropy_denominator_clearing`（「有限系の密度の分母は整数倍で払える」）1 件。
  その本体（$L^2M^2$ を掛けて分母を払う二段）はどこからも引かれておらず、引かれていたのは証明末尾の補助等式 $n\cdot\iota(\nu)=\iota(n\nu)$ だけだったので、
  補助等式を `claim_rational_embedding_commutes_with_integer_multiple` として独立させ（証明の内容は変えず五段の鎖をそのまま本体にした）、7 箇所の参照を付け替えた。
  SageMath 検査を作り直し（`rational-embedding-commutes-with-integer-multiple`）、Lean の分母払いの 3 ファイルを削除、`toRational_intSmul` へ必要十分版と導出版を追加（sorry 検査 1246→1245 件）。
  題名の全走査と証明の短い順の走査で他に該当は無し。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 335）: 台帳の先頭行「部分正方形との比較による密度の挟み込み（$\Lambda_{\mathbb Q}$ 版。倍数でない辺への拡張）」を実行した。
  `claim_open_square_subsquare_comparison_density_le_one` を `claim_open_square_subsquare_comparison_log_le_one` の直後に置いた。証明は `claim_open_square_block_tiling_density` と同じ型
  （準備: 正値性と分母・部分正方形の対数の像を $\frac{a^2}{L^2}\Psi^{\mathrm{op}}_a$ へ整える三段・下端の像の六段・上端の像の六段、本体は `claim_scaled_embedding_order_transfer` を $L:=L$ で読む 3 段の鎖 2 本）。
  上端は $\frac{L^2-a^2}{L^2}\iota(\ell_2)+\frac{2(L^2-a^2)}{L^2}\iota(\log(1+q))$ と二つの係数で書いた（台帳の備考の括弧でくくる形より一段少ない）。
  SageMath `open-square-subsquare-comparison-density`（`ZZ`/`QQ`・有限台辞書。一辺 4 以上は含めない。共通分母は最小公倍数）。Lean 具体版・導出版を書き、入口 import・sorry 検査へ 5 件登録（計 1246 件）。
  式変形統一は一時停止中のため実施せず。

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

（これより古い 299 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

- 2026-08-16（tick 336）: 前 tick の「部分正方形との比較による密度の挟み込み（$\Lambda_{\mathbb Q}$ 版。倍数でない辺への拡張）」の本文（準備 4 つ・3 段の鎖 2 本）・SageMath overview・
  Lean 具体版・導出版を突き合わせ、根拠が一致した。「何も言っていない主張」の観点では、この tick の前進そのものが該当ブロックの削除（下の前進の記録）。
  本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。他の修正は無い。

- 2026-08-16（tick 335）: 前 tick の「開境界正方形と部分正方形の比較の対数化（$\Lambda$ の鎖。$q$ は 1 以下）」の本文（準備 3 つ・4 段の鎖）・SageMath overview・
  Lean 具体版（準備の等式 2 本と本体）・導出版（入口 import・sorry 検査への登録）を突き合わせ、根拠が一致した。本文の修正は無い。
  本文末尾「この先に書くこと」に済んだ項目（「有限系の密度を可算側へ畳むこと」「極限の存在の Cauchy 性としての記述」、および今回済んだ「倍数でない辺への拡張」）が残っていたので、
  残っている行だけ（Cauchy 性・切断と旧経路撤去・周期境界への移送・零点密度）に書き換えた（前進のコミットに同梱）。

- 2026-08-16（tick 334）: 前 tick の「開境界長方形の接合不等式の対数化（$\Lambda$ の鎖）」の本文（準備 2 つ・第一の座標の向きの鎖 2 本・第二の座標の向きの置き換え）・SageMath overview・
  Lean 具体版（準備の等式 2 本と 4 定理）・導出版（入口 import・sorry 検査への登録）を突き合わせ、根拠が一致した。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 333）: 前 tick の「有理係数の対数順序群の Cauchy 列」の本文（定義・$N$ の依存・極限の非主張）・SageMath overview・Lean（`IsCauchyRationalLogOrder`・定数列）を突き合わせ、一致した。
  本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 332）: 前 tick の「部分正方形との比較（$0<q\le1$。$\mathbb Q$ 版）」の本文（準備 3 つ・下側 7 段・上側 8 段）・SageMath overview・Lean 具体版（人手証明との対応表）・
  必要十分版（実数版と共有）・導出版（入口 import・sorry 検査への登録）を突き合わせ、接合不等式の向きと $b:=a$／$b:=L$ の読み替えを含め根拠が一致した。
  本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

（これより古い 320 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

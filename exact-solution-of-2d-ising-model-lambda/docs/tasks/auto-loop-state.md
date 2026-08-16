# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

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

- **2026-08-16 の tick 329 は、「ブロック敷き詰めの密度の挟み込み（$\Lambda_{\mathbb Q}$ 版）」の SageMath 検査の下書きまでで締切に当たり、本文・Lean は未着手のまま止めた（コミットは下書きと台帳のみ）。**
  証明の骨格は決めた: 準備 3 つ（正値性と $(ka)^2\ne0$・上からの評価の側 $\frac1{(ka)^2}\iota(k^2\log Z^{\mathrm{op}}_{a,a}(q))=\Psi^{\mathrm{op}}_a(q)$ の四段・
  下からの評価の側 $\frac1{(ka)^2}\iota(2k(k-1)a\log q+k^2\log Z^{\mathrm{op}}_{a,a}(q))=\frac{2(k-1)}{ka}\iota(\log q)+\Psi^{\mathrm{op}}_a(q)$ の六段）と、
  二場合とも左右の不等式を 3 段の鎖 2 本ずつ（準備の等式・`claim_scaled_embedding_order_transfer` を $L:=ka$ で読んで `claim_open_square_block_tiling_log` を移す・`def_open_square_free_entropy_density`）。
  Lean の必要十分版は前 tick の `twoSided_bounds_transport_through_monotone_map_necSuf` を `ell := λ ↦ (1/(ka)^2)·ι(λ)` で共有できる見込み。
  SageMath の下書き `sagemath/drafts/open-square-block-tiling-density.check.sage`（形 4 通り × 正の有理点 9 点、556 検査 PASS）は、対象ラベルの本文が無いので
  `check/` に置かず `drafts/` に置いた（検証↔証明の対応検査に掛からないため）。**形 $(a,k)=(2,2)$（$4\times4$）を含めると 10 分を超えた**ので外した
  （前 tick の `open-square-block-tiling-log` も同じ形を含む——所要時間を次 tick で確かめること）。次 tick はこのセクションの本文・Lean を書き、下書きを `check/` へ移す。

- **2026-08-16 の tick 328 は、「開境界正方形のブロック敷き詰め評価の対数化（$\Lambda$ の鎖）」の残り（Lean 必要十分版・導出版）を書き、セクションを四層で完成させた。**
  必要十分版 `twoSided_bounds_transport_through_monotone_map_necSuf`（`NecSuf/ThermodynamicLimit/OpenSquareBlockTilingLog.lean`）は、二側の評価を順序を保つ写像 1 本で運び、
  両端の像を等式で目標の形へ整えるだけの形（順序の反映も像の側の加法も値の側の乗法も仮定しない。二場合は lower・upper と両端の等式の入れ替えで同じ定理から得る）。
  導出版 `OpenSquareBlockTilingLogFromNecSuf.lean` は値の側を正の有理数の部分型に取り `ell := logRat`・`logRat_le_iff` の → で特殊化。
  lake build・sorry 検査 1217 件 OK。前 tick の $\Lambda$ の鎖（本文・SageMath・Lean 具体版）のレビューに不一致なし。
  次は「ブロック敷き詰めの密度の挟み込み（$\Lambda_{\mathbb Q}$ 版）」。

- **2026-08-16 の tick 327 は、「開境界正方形のブロック敷き詰め評価の対数化（$\Lambda$ の鎖）」を本文・SageMath・Lean 具体版まで進めた（必要十分版・導出版は次 tick）。**
  台帳の「ブロック敷き詰めの対数化（$\Lambda_{\mathbb Q}$ 版）」は論法が 2 つ（$\Lambda$ の中で両側の対数を開く計算と、$\Lambda_{\mathbb Q}$ への順序移送・有理数倍の約分）なので割り、前半を実行した。
  `claim_open_square_block_tiling_log`（`claim_open_square_free_entropy_density_upper_bound` の直後・`remark_real_escape_plan` の直前、住処 Lambda）で、
  $a,k\ge1$、$q\in\mathbb Q_{>0}$ に対し $0<q\le1$: $2k(k-1)a\log q+k^2\log Z^{\mathrm{op}}_{a,a}(q)\le_\Lambda\log Z^{\mathrm{op}}_{ka,ka}(q)\le_\Lambda k^2\log Z^{\mathrm{op}}_{a,a}(q)$、$1\le q$: その反転。
  証明は準備 3 つ（値と両側の評価の値の正値性・下からの評価の側の対数を開く六段・上からの評価の側の三段）と、`claim_rational_log_order_iff` で
  `claim_open_square_block_tiling_rational` の二場合を移す各 4 段の鎖。SageMath 650 検査（形 5 通り × 正の有理点 9 点、`ZZ`/`QQ`・素因数分解・有限台辞書）、
  Lean 具体版 `OpenSquareBlockTilingLog.lean`（`logRat_blockTilingLowerValue_eq`・`logRat_blockTilingUpperValue_eq`・
  `logOrderLE_openSquareBlockTilingLog_bounds_of_le_one`／`_of_one_le`）、sorry 検査 1214 件。前 tick の密度の上界のレビューに不一致なし。
  次はこのセクションの必要十分版・導出版を書き、そのあと「ブロック敷き詰めの密度の挟み込み（$\Lambda_{\mathbb Q}$ 版）」。

（これより古い 284 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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
- 熱力学極限: 52 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 極限の存在を $\Lambda\otimes\mathbb{Q}$ の Cauchy 性として述べる | todo | 完備性（上限の存在）を使わずに、可算側の主張として収束の速さつきで述べる。各段の比較は有理数の比較なので決定可能 |
| 熱力学極限 | 有限系の密度の接合不等式（$\Lambda_{\mathbb{Q}}$ 版） | todo | 値の接合不等式（有理点）の両辺の対数を取り、$\Lambda_{\mathbb{Q}}$ の順序で $\Psi$ どうしの不等式にする |
| 熱力学極限 | 部分正方形との比較の対数化と密度の挟み込み（$\Lambda_{\mathbb{Q}}$ 版。倍数でない辺への拡張） | todo | `claim_open_square_subsquare_comparison_rational_le_one` の両辺の対数を取り $\frac1{L^2}\iota$ で移し、$\Psi^{\mathrm{op}}_L$ を $\Psi^{\mathrm{op}}_a$ と $\frac{L^2-a^2}{L^2}$ の項で挟む。本文末尾「開境界自由エネルギー密度の極限（倍数でない辺への拡張）」に対応する行 |
| 熱力学極限 | 密度の列の Cauchy 性 | todo | $\bigl(\Psi_L(q)\bigr)_L$ の差を有理数で抑える。完備性も極限論も使わない |
| 熱力学極限 | 切断による実数体への一度きりの脱出 | todo | Cauchy 列が定める $\mathbb{Q}$ 上の切断として自由エネルギー密度を取る。引くのは「切断は実数を定める」ことだけ |
| 熱力学極限 | 削除した実数値経路の Lean の後片付け | todo | 2026-08-16 に本文から消した実数値経路（実対数・上限／下限による極限）の Lean ファイルが孤立して残っている。入口からの import と sorry 検査は通るが、対応する本文が無いので消す |
| 熱力学極限 | 周期境界自由エネルギー密度への移送 | todo | 周期境界と開境界の境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録

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

- 2026-08-16（tick 329）: セクション「ブロック敷き詰めの密度の挟み込み（$\Lambda_{\mathbb Q}$ 版）」は SageMath の下書き（`sagemath/drafts/`、556 検査 PASS）まで。
  本文・Lean は未着手（締切 14:10 で打ち切り。SageMath の $4\times4$ を含む形が 10 分超で二度走らせたことが原因）。セクション表は todo のまま。
  次 tick: 本文ブロック `claim_open_square_block_tiling_density`（`claim_open_square_block_tiling_log` の直後・`remark_real_escape_plan` の直前、住処 Lambda）を
  下書きの冒頭に書いた鎖のとおりに書き、下書きを `check/open-square-block-tiling-density/` へ移して overview を付け、Lean 具体版（`OpenSquareBlockTilingDensity.lean`。
  準備の等式 2 本と `rationalLogOrderLE_scaled_toRational_iff (k*a)` の ←）・必要十分版は共有・導出版を書く。

- 2026-08-16（tick 328）: セクション「ブロック敷き詰めの対数化（$\Lambda$ の鎖）」の残りの Lean 必要十分版・導出版を書き、四層で閉じた。
  必要十分版 `twoSided_bounds_transport_through_monotone_map_necSuf`（`NecSuf/ThermodynamicLimit/OpenSquareBlockTilingLog.lean`）: 具体版の証明が実際に使うのは
  (1) 二側の評価を写像が順序を保って運ぶこと（`logRat_le_iff` は同値だが使うのは → の一方向だけ）、(2) 下側・上側の値の像が目標の形に等しいこと
  （準備の第二の六段・第三の三段は等式一つに畳む。展開の内部は具体版の補題）だけであり、像の側の加法も値の側の乗法も仮定に残らない。
  既存の共有候補（`scaled_map_twoSided_bounds_necSuf` は尺度作用込みの密度版、`upperBound_transport_through_two_monotone_maps_necSuf` は写像二段の片側版）は
  形が合わないので新設した。導出版 `OpenSquareBlockTilingLogFromNecSuf.lean`（`logOrderLE_openSquareBlockTilingLog_bounds_of_le_one_from_necSuf`／`_of_one_le_from_necSuf`。
  値の側を正の有理数の部分型に取り、二場合は lower・upper と両端の等式の入れ替えで同じ必要十分版を引く）。入口 import・sorry 検査へ 3 件登録（計 1217 件）。
  本文の `lean:` 欄と SageMath overview へ必要十分版・導出版を追記。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 327）: セクション「ブロック敷き詰めの対数化（$\Lambda_{\mathbb Q}$ 版）」は論法が 2 つ（$\Lambda$ の対数の計算と $\Lambda_{\mathbb Q}$ への移送）なので
  「$\Lambda$ の鎖」と「密度の挟み込み（$\Lambda_{\mathbb Q}$ 版）」へ割り、前半の `claim_open_square_block_tiling_log` を
  `claim_open_square_free_entropy_density_upper_bound` の直後（`remark_real_escape_plan` の直前）に置いた。準備 3 つ
  （正値性・下からの評価の側の値の対数を開く六段: `claim_log_additive`・`claim_log_power`・整数倍の分配則と結合則・$n\lambda+m\lambda=(n+m)\lambda$ と
  $(k-1)(ka)+k(k-1)a=2k(k-1)a$・上からの評価の側の三段）、本体は二場合とも準備の等式と `claim_rational_log_order_iff` による移送の 4 段の鎖。
  SageMath `open-square-block-tiling-log`（形 $(a,k)\in\{(1,1),(1,2),(1,3),(2,1),(2,2)\}$ × 正の有理点 9 点、650 検査。準備の各段を $\Lambda$ の有限台辞書の等号で、
  本体は $\operatorname{rat}_\Lambda$ を通した $\mathbb Q$ の比較と順序の移送。`ZZ`/`QQ`）。Lean 具体版
  `ThermodynamicLimit/OpenSquareBlockTilingLog.lean`（`logRat_blockTilingLowerValue_eq`・`logRat_blockTilingUpperValue_eq`・
  `logOrderLE_openSquareBlockTilingLog_bounds_of_le_one`／`_of_one_le`。`OpenSquareBlockTilingRational.lean` の二場合と `logRat_le_iff`・`logRat_mul`・`logRat_pow` から組む）。
  必要十分版・導出版は未着手（セクション表に残した）。sorry 検査 1214 件。式変形統一は一時停止中のため実施せず。

（これより古い 294 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

- 2026-08-16（tick 331）: 前 tick の「ブロック敷き詰めの密度の挟み込み（$\Lambda_{\mathbb Q}$ 版）」の本文（準備 3 つと二場合の 3 段の鎖 2 本ずつ）・SageMath overview・
  Lean 具体版・必要十分版（共有）・導出版（入口 import・sorry 検査への登録）を突き合わせ、根拠が一致した。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。
  台帳の todo が指していた `claim_open_square_subsquare_comparison_le_one` は 2026-08-16 の実数値経路の削除で本文から消えており（Lean は孤立して残存）、
  git 履歴（コミット c205c4ed）から原本を読んで $\mathbb Q$ 版を書いた。本文末尾の「開境界自由エネルギー密度の極限（倍数でない辺への拡張）」に対応する行がセクション表に無かったので、
  「部分正方形との比較の対数化と密度の挟み込み（$\Lambda_{\mathbb{Q}}$ 版。倍数でない辺への拡張）」を「密度の列の Cauchy 性」の直前へ足した。本文の修正は無い。

- 2026-08-16（tick 330）: 前 tick の SageMath 下書き `sagemath/drafts/open-square-block-tiling-density.check.sage` を、決めてあった証明の骨格（準備 3 つと二場合の鎖）と突き合わせ、
  段の並びと根拠が一致した。下書きの見出し（「まだ check/ に置かない」）は移動に伴い対象ラベル宣言へ書き換えた。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。他に修正は無い。

- 2026-08-16（tick 329）: 前 tick の「開境界正方形のブロック敷き詰め評価の対数化（$\Lambda$ の鎖）」の必要十分版・導出版（入口 import・sorry 検査への登録・overview の記載）を
  本文の `lean:` 欄と突き合わせ、仮定の説明（順序の移送 1 本と両端の等式のみ）が Lean の実体と一致した。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 328）: 前 tick の「開境界正方形のブロック敷き詰め評価の対数化（$\Lambda$ の鎖）」の本文・SageMath（overview の対象ラベル・実行日・帰属・650 検査）・
  Lean 具体版（入口 import・sorry 検査への登録）を突き合わせ、準備 3 つ（正値性・第二の六段・第三の三段）と二場合の 4 段の鎖の根拠が一致した。
  本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 327）: 前 tick の「開境界正方形の自由エントロピー密度の上からの評価（$\Lambda_{\mathbb Q}$ 版）」の本文・SageMath（overview の対象ラベル・実行日・帰属）・
  Lean 具体版・必要十分版（周期境界と共有）・導出版（入口 import・sorry 検査への登録）を突き合わせ、準備 3 つ・$\Lambda$ の鎖 4 段・$\Lambda_{\mathbb Q}$ の鎖 8 段の根拠が一致した。
  本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

（これより古い 315 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

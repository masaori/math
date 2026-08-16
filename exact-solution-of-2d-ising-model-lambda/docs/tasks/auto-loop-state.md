# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-16 の tick 344 は、台帳の先頭行「倍数辺の部分正方形による密度の挟み込みの誤差評価」（$k\ge1$、$ka<L\le ka+a$、$0<q\le1$ で $\frac2L\iota(\log q)+\frac{(ka)^2}{L^2}\Psi^{\mathrm{op}}_{ka}\le\Psi^{\mathrm{op}}_L\le\frac{2a}L\iota(\ell_2)+\frac{4a}L\iota(\log(1+q))+\frac{(ka)^2}{L^2}\Psi^{\mathrm{op}}_{ka}$）を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_open_square_multiple_side_subsquare_density_error_bound`（`claim_rational_embedded_log_order_iff` の直後・`remark_real_escape_plan` の直前、住処 Lambda）。証明は準備 4 つ（部分正方形比較を $a:=ka$ で読む／$\mathbb Q$ の係数比較 $\frac{ka+L}{L^2}\le\frac2L$・$\frac{L^2-(ka)^2}{L^2}\le\frac{2a}L$（倍数辺との平方の差）・$\frac{2(L^2-(ka)^2)}{L^2}\le\frac{4a}L$／符号 $\iota(\log q)\le0$・$0\le\iota(\ell_2)$・$0\le\iota(\log(1+q))$（埋め込んだ対数の順序を $q':=1$、$(1,2)$、$(1,1+q)$ で読み $\log1=0$・$\iota(0)=0$・$\log2=\ell_2$）／係数の大小による有理数倍の比較（非正 1 件・非負 2 件））と、加法単調性・推移律による本体（左二段・右三段）。
  SageMath `check/open-square-multiple-side-subsquare-density-error-bound/`（形の三組 $(a,k,L)=(1,1,2),(2,1,3),(1,2,3)$ × 6 点、342 検査、11 秒。一辺 4 以上は配位和が長いので含めない）。Lean 具体版 `ThermodynamicLimit/OpenSquareMultipleSideSubsquareDensityErrorBound.lean`（`rationalLogOrderLE_openSquareMultipleSideSubsquareDensity_error_bounds_of_le_one`。補助に `toRational_zero` と符号の三つ）、
  必要十分版 `NecSuf/ThermodynamicLimit/OpenSquareMultipleSideSubsquareDensityErrorBound.lean`（`twoSided_bounds_enlarge_coefficients_necSuf`。関係の推移律・右加法の単調性・加法の交換則だけ。結合則も係数も要らない）、導出版。sorry 検査 1284 件。
  レビューでは前 tick の statement の読み方の例に主張自身の変数 $q$ を再利用していた箇所を $p$ に改めた（先に別コミットで push 済み）。次は「密度の列の Cauchy 性（$0<q\le1$）」。

- **2026-08-16 の tick 343 は、台帳の先頭行「埋め込んだ対数の符号」を、三つの符号を一つずつ主張にする代わりに、それらを一度に読める一行「埋め込んだ対数の順序は正の有理数の順序と一致する」（$q,q'\in\mathbb Q_{>0}$ について $q\le q'\iff\iota(\log q)\le_{\Lambda_{\mathbb Q}}\iota(\log q')$）として本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_rational_embedded_log_order_iff`（`claim_rational_log_order_group_scalar_compare_nonpos` の直後・`remark_real_escape_plan` の直前、住処 Lambda）。証明は同値の四段の鎖 $q\le q'\iff\log q\le_\Lambda\log q'$（`claim_rational_log_order_iff`）$\iff\frac1{1^2}\cdot\iota(\log q)\le\frac1{1^2}\cdot\iota(\log q')$（`claim_scaled_embedding_order_transfer` の $L:=1$）$\iff1\cdot\iota(\log q)\le1\cdot\iota(\log q')\iff\iota(\log q)\le\iota(\log q')$。
  三つの符号（$q\le1$ で $\iota(\log q)\le0$、$0\le\iota(\ell_2)$、$0\le\iota(\log(1+q))$）は $q':=1$、$q:=1,q':=2$、$q:=1,q':=1+q$ の読み方として statement に書き、誤差評価の準備で $\iota(\log1)=\iota(0)=0$・$\log2=\ell_2$ と合わせて一行ずつ引く（符号を別ブロックにすると「主張を一度読む」だけの中身の無いブロックになる）。
  SageMath `check/rational-embedded-log-order-iff/`（正の有理数 30 点の全組 900、同値 900 件・鎖 900 件・符号の読み方 42 件、12 秒）。Lean 具体版 `ThermodynamicLimit/RationalEmbeddedLogOrderIff.lean`（`rationalLogOrderLE_toRational_logRat_iff`）、
  必要十分版 `NecSuf/ThermodynamicLimit/RationalEmbeddedLogOrderIff.lean`（`iff_comp_of_iff_of_scaled_iff_necSuf`。関係を移し合う写像 $f$ と、係数 $s$ を掛けた形で関係を移し合う写像 $e$、$s=1$ と `one_smul` だけ）、導出版。sorry 検査 1277 件。
  次は「倍数辺の部分正方形による密度の挟み込みの誤差評価」（台帳の備考に手順）。

- **2026-08-16 の tick 342 は、台帳の先頭行「非正の元の有理数倍は係数の大小で比較できる（向きが逆）」（$r\le s$（$\mathbb Q$）、$\nu\le_{\Lambda_{\mathbb Q}}0$ なら $s\cdot\nu\le_{\Lambda_{\mathbb Q}}r\cdot\nu$）を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_rational_log_order_group_scalar_compare_nonpos`（`claim_rational_log_order_group_scalar_compare_nonneg` の直後・`remark_real_escape_plan` の直前、住処 Lambda）。証明は非負の元の版と同じ道具で、$c:=s-r\ge0$ を置き、非負有理数倍の順序保存を $\lambda:=\nu$、$\mu:=0$ で読んで $c\cdot\nu\le c\cdot0=0$、加法単調性で $r\cdot\nu$ を足し、
  四段の鎖 $s\cdot\nu=(c+r)\cdot\nu=c\cdot\nu+r\cdot\nu\le0+r\cdot\nu=r\cdot\nu$。
  SageMath `check/rational-log-order-group-scalar-compare-nonpos/`（非正ベクトル 27 本 × 係数の組 28、主張 756 件・鎖 756 件、13 秒）。Lean 具体版 `ThermodynamicLimit/RationalLogOrderGroupScalarCompareNonpos.lean`（`rationalLogOrderLE_ratSmul_le_ratSmul_of_le_of_nonpos`）、
  必要十分版 `NecSuf/ThermodynamicLimit/RationalLogOrderGroupScalarCompareNonpos.lean`（`smul_le_smul_of_le_of_nonpos_necSuf`。仮定は非負の元の版と同一で一つも増えない。(1) を読む向きだけが違う）、導出版。sorry 検査 1274 件。
  次は「埋め込んだ対数の符号」（着手時に既出か確認。台帳の備考）。

- **2026-08-16 の tick 341 は、台帳の先頭行「係数の大小による有理数倍の比較」を、非負の元についての一行「非負の元の有理数倍は係数の大小で比較できる」（$r\le s$（$\mathbb Q$）、$0\le_{\Lambda_{\mathbb Q}}\nu$ なら $r\cdot\nu\le_{\Lambda_{\mathbb Q}}s\cdot\nu$）として本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_rational_log_order_group_scalar_compare_nonneg`（`claim_rational_log_order_group_nonneg_scalar_monotone` の直後・`remark_real_escape_plan` の直前、住処 Lambda）。証明は $c:=s-r\ge0$ を置き、非負有理数倍の順序保存を $\lambda:=0$、$\mu:=\nu$ で読んで $0=c\cdot0\le c\cdot\nu$、加法単調性で $r\cdot\nu$ を足し、
  四段の鎖 $r\cdot\nu=0+r\cdot\nu\le c\cdot\nu+r\cdot\nu=(c+r)\cdot\nu=s\cdot\nu$。非正の元（$\nu\le0$ で向きが逆）は 1 ブロック 1 主張なので別行に切り出し、セクション表へ足した。
  SageMath `check/rational-log-order-group-scalar-compare-nonneg/`（非負ベクトル 38 本 × 係数の組 28、主張 1064 件・鎖 1064 件、10 秒）。Lean 具体版 `ThermodynamicLimit/RationalLogOrderGroupScalarCompareNonneg.lean`（`rationalLogOrderLE_ratSmul_le_ratSmul_of_le`）、
  必要十分版 `NecSuf/ThermodynamicLimit/RationalLogOrderGroupScalarCompareNonneg.lean`（`smul_le_smul_of_le_of_nonneg_necSuf`。順序付き加法群の係数環 $K$ 上の加群 $X$ と関係 `le` について、非負係数の作用と右加法が `le` を保てばよい。`le` の推移律・反射律も体も要らない）、導出版。sorry 検査 1271 件。
  次は「非正の元の有理数倍は係数の大小で比較できる（向きが逆）」（台帳の備考に手順）。

- **2026-08-16 の tick 340 は、台帳の先頭行「非負有理数倍は有理係数の対数順序群の順序を保つ」（$c\in\mathbb Q$、$0\le c$、$\lambda\le_{\Lambda_{\mathbb Q}}\mu$ なら $c\cdot\lambda\le_{\Lambda_{\mathbb Q}}c\cdot\mu$）を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_rational_log_order_group_nonneg_scalar_monotone`（`claim_square_difference_from_multiple_side_bound` の直後・`remark_real_escape_plan` の直前、住処 Lambda）。証明は $u:=\operatorname{num}(c)\in\mathbb N$、$v:=\operatorname{den}(c)\ge1$ を置き、仮定を「ある $N$」の形で読んで $\lambda_N\le_\Lambda\mu_N$ となる共通分母 $N$ を取り、
  六段の鎖 $(vN)\cdot(c\cdot\lambda)=((vN)c)\cdot\lambda=((vc)N)\cdot\lambda=(uN)\cdot\lambda=u\cdot(N\cdot\lambda)=u\cdot\iota(\lambda_N)=\iota(u\lambda_N)$ で $vN$ が $c\cdot\lambda$・$c\cdot\mu$ の共通分母（証人 $u\lambda_N$・$u\mu_N$）であることを示し、$u\ge1$ は `claim_log_order_group_positive_multiple_invariant`、$u=0$ は零写像と反射律で証人の順序を得る。
  SageMath `check/rational-log-order-group-nonneg-scalar-monotone/`（64 ベクトル × 係数 5 点、主張 10400 件・鎖 10400 件。125 ベクトル × 7 点は 2 分で終わらず縮めた）。Lean 具体版 `ThermodynamicLimit/RationalLogOrderGroupNonnegScalarMonotone.lean`（`commonDenominator_ratSmul`・`logOrderLE_natSmul_of_le`・`rationalLogOrderLE_ratSmul_of_nonneg`）、
  必要十分版 `NecSuf/ThermodynamicLimit/RationalLogOrderGroupNonnegScalarMonotone.lean`（`indexedLE_scale_necSuf`。添字・元・証人それぞれへの作用が `Rep` と `le` を保てばよい。$c$ の非負性は証人側の作用が順序を保つ理由にだけ入る）、導出版。sorry 検査 1268 件。
  次は「係数の大小による有理数倍の比較」（台帳の備考に手順）。

（これより古い 297 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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
- 熱力学極限: 64 セクション
- 全章（何も言っていない主張の一掃）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 密度の列の Cauchy 性（$0<q\le1$） | todo | $\bigl(\Psi^{\mathrm{op}}_L(q)\bigr)_L$ が `def_rational_log_order_group_cauchy_sequence` の Cauchy 列であること。$\varepsilon\mapsto N$ を明示する（Archimedes 性で $a$ と $N$ を取る）。完備性も極限論も使わない。$1\le q$ は部分正方形比較の $1\le q$ 版が無いので後回し（必要なら行を足す） |
| 熱力学極限 | 切断による実数体への一度きりの脱出 | todo | Cauchy 列が定める $\mathbb{Q}$ 上の切断として自由エネルギー密度を取る。引くのは「切断は実数を定める」ことだけ |
| 熱力学極限 | 削除した実数値経路の Lean の後片付け | todo | 2026-08-16 に本文から消した実数値経路（実対数・上限／下限による極限）の Lean ファイルが孤立して残っている。入口からの import と sorry 検査は通るが、対応する本文が無いので消す |
| 熱力学極限 | 周期境界自由エネルギー密度への移送 | todo | 周期境界と開境界の境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録

- 2026-08-16（tick 344）: 台帳の先頭行「倍数辺の部分正方形による密度の挟み込みの誤差評価」を実行した。`claim_open_square_multiple_side_subsquare_density_error_bound` を `claim_rational_embedded_log_order_iff` の直後に置いた。
  証明は台帳の備考のとおり（部分正方形比較を $a:=ka$ で読み、係数を倍数辺との平方の差と $ka+L\le2L$ で大きくし、符号は埋め込んだ対数の順序から、係数比較（非負・非正）と加法単調性・推移律でつなぐ）。SageMath `open-square-multiple-side-subsquare-density-error-bound`、Lean 具体版・必要十分版（推移律・右加法単調性・交換則だけ）・導出版を書き、入口 import・sorry 検査へ 7 件登録（計 1284 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 343）: 台帳の先頭行「埋め込んだ対数の符号」を、三つの符号を束ねずに済む一行「埋め込んだ対数の順序は正の有理数の順序と一致する」へ書き換えて実行した（符号を別ブロックにすると主張を一度読むだけの中身の無いブロックになるため。三つの読み方は statement に書いた）。`claim_rational_embedded_log_order_iff` を `claim_rational_log_order_group_scalar_compare_nonpos` の直後に置いた。
  証明は同値の四段の鎖（`claim_rational_log_order_iff`・`claim_scaled_embedding_order_transfer` の $L:=1$・$\frac1{1^2}=1$・$1\cdot\lambda=\lambda$）。SageMath `rational-embedded-log-order-iff`、Lean 具体版・必要十分版（関係を移し合う写像の合成。二段目は係数 $s$ を掛けた形で受けて $s=1$ に潰す）・導出版を書き、入口 import・sorry 検査へ 3 件登録（計 1277 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 342）: 台帳の先頭行「非正の元の有理数倍は係数の大小で比較できる（向きが逆）」を実行した。`claim_rational_log_order_group_scalar_compare_nonpos` を `claim_rational_log_order_group_scalar_compare_nonneg` の直後に置いた。
  証明は台帳の備考のとおり（$c:=s-r$、非負有理数倍の順序保存を $\lambda:=\nu$、$\mu:=0$ で読む・$c\cdot0=0$・加法単調性・分配則の四段の鎖）。SageMath `rational-log-order-group-scalar-compare-nonpos`、Lean 具体版・必要十分版（非負の元の版と同じ仮定）・導出版を書き、入口 import・sorry 検査へ 3 件登録（計 1274 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 341）: 台帳の先頭行「係数の大小による有理数倍の比較」は非負の元と非正の元で主張が二つあるので二行へ割り、非負の元の行 `claim_rational_log_order_group_scalar_compare_nonneg` を `claim_rational_log_order_group_nonneg_scalar_monotone` の直後に置いて四層で閉じた。
  証明は台帳の備考のとおり（$c:=s-r$、非負有理数倍の順序保存・$c\cdot0=0$・加法単調性・分配則の四段の鎖）。SageMath `rational-log-order-group-scalar-compare-nonneg`、Lean 具体版・必要十分版（係数環の順序付き加法群性と加群の分配則・零への作用、`le` を保つ二つの仮定だけ）・導出版を書き、入口 import・sorry 検査へ 3 件登録（計 1271 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 340）: 台帳の先頭行「非負有理数倍は有理係数の対数順序群の順序を保つ」を実行した。`claim_rational_log_order_group_nonneg_scalar_monotone` を `claim_square_difference_from_multiple_side_bound` の直後に置いた。
  証明は台帳の備考のとおり（既約分数表示 $c=u/v$、共通分母 $vN$ と証人 $u\lambda_N$・$u\mu_N$ の六段の鎖、$u\ge1$ と $u=0$ の場合分け）。
  SageMath `rational-log-order-group-nonneg-scalar-monotone`（標本は 64 ベクトル × 5 点に縮めた）、Lean 具体版・必要十分版（添字・元・証人への作用が `Rep` と `le` を保てば順序が移る）・導出版を書き、入口 import・sorry 検査へ 5 件登録（計 1268 件）。式変形統一は一時停止中のため実施せず。

（これより古い 307 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

- 2026-08-16（tick 344）: 前 tick の「埋め込んだ対数の順序は正の有理数の順序と一致する」の本文（同値の四段の鎖）・SageMath overview（900+900+42 検査）・Lean 具体版（`Nat.cast_one, one_pow, div_one, one_smul` と `logRat_le_iff` の合成が本文と 1 対 1）・必要十分版・導出版を突き合わせ、根拠が一致した。
  修正 1 件: statement の読み方の例「$q:=1,\ q':=1+q$」が主張自身の変数 $q$ を代入先と代入する値の両方に使っていた（1 記号 1 意味に反する）ので、読む側の有理数を $p$ と書いて「$q:=1,\ q':=1+p$」へ改めた。「何も言っていない主張」の観点: 順序を移し合う同値で誤差評価が三度引くので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。

- 2026-08-16（tick 343）: 前 tick の「非正の元の有理数倍は係数の大小で比較できる（向きが逆）」の本文（準備・四段の鎖）・SageMath overview（756 検査）・Lean 具体版（書き換え列が本文と 1 対 1）・必要十分版（非負の元の版と同じ二つの仮定）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: この主張は非負有理数倍の順序保存と加法単調性を組み合わせる比較で誤差評価の下端が引くので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 342）: 前 tick の「非負の元の有理数倍は係数の大小で比較できる」の本文（準備・四段の鎖）・SageMath overview（1064 検査）・Lean 具体版（`sub_nonneg`・`smul_zero`・`rationalLogOrderLE_add_right`・`zero_add`・`← add_smul`・`sub_add_cancel` が本文と 1 対 1）・必要十分版（二つの仮定だけ）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: この主張は非負有理数倍の順序保存と加法単調性を組み合わせる比較で誤差評価が引くので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 341）: 前 tick の「非負有理数倍は有理係数の対数順序群の順序を保つ」の本文（準備・六段の鎖・$u$ の場合分け）・SageMath overview（10400 検査）・Lean 具体版（`commonDenominator_ratSmul` の六段が本文と 1 対 1）・必要十分版（$c$ の非負性が証人側の作用にだけ入る旨のコメント）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: この主張は共通分母と証人を構成する主張で誤差評価が引くので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 340）: 前 tick の「倍数辺との平方の差の評価」の本文（七段の鎖と $\mathbb N$ の引き算）・SageMath overview（2816 検査）・Lean 具体版・必要十分版（順序可換半環。倍数の形を使わない理由のコメント）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: この主張は乗法単調性を三度使う不等式で誤差評価が引くので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

（これより古い 328 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

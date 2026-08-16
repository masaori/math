# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

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

- **2026-08-16 の tick 339 は、台帳の先頭行「倍数辺の部分正方形による密度の挟み込みの誤差評価」を論法の数で四行へ割り、その最初に要る「倍数辺との平方の差の評価」（$ka\le L\le ka+a$ なら $L^2-(ka)^2\le2aL$。$\mathbb N$）を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_square_difference_from_multiple_side_bound`（`claim_rational_log_order_group_archimedean` の直後・`remark_real_escape_plan` の直前、住処 N）。証明は七段の鎖 $L^2=L\cdot L\le(ka+a)L=kaL+aL\le ka(ka+a)+aL=(ka)^2+a\cdot ka+aL\le(ka)^2+aL+aL=(ka)^2+2aL$ と $\mathbb N$ の引き算。
  SageMath `check/square-difference-from-multiple-side-bound/`（$a,k\le8$ の全組、2816 検査）。Lean 具体版 `ThermodynamicLimit/SquareDifferenceFromMultipleSideBound.lean`（`sq_le_multiple_sq_add_two_mul_nat`・`sq_sub_multiple_sq_le_two_mul_nat`）、必要十分版 `NecSuf/.../SquareDifferenceFromMultipleSideBound.lean`（`sq_le_sq_add_two_mul_of_between_necSuf`。順序可換半環。$k$ と $a$ の積の形は使わず $b\le L\le b+a$ だけ）、導出版。sorry 検査 1263 件。
  割った四行は「非負有理数倍は順序を保つ」→「係数の大小による有理数倍の比較」→「埋め込んだ対数の符号」→「誤差評価本体（$ka<L\le ka+a$）」。$L=ka$ の場合は誤差評価に含めず、Cauchy 性の側でブロック敷き詰め密度を直接使う（備考に書いた）。締切（20:10）が近かったため最小の一行だけを閉じた。
  次は「非負有理数倍は有理係数の対数順序群の順序を保つ」。

- **2026-08-16 の tick 338 は、台帳の先頭行「有理係数の対数順序群の Archimedes 性」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_rational_log_order_group_archimedean`（`claim_rational_bernoulli_inequality` の直後・`remark_real_escape_plan` の直前、住処 Lambda）で、$0\le_{\Lambda_{\mathbb Q}}\mu$、$0\le_{\Lambda_{\mathbb Q}}\varepsilon$、$\varepsilon\ne0$ に対し $\mu\le_{\Lambda_{\mathbb Q}}n\cdot\varepsilon$ となる $n\in\mathbb N$ が存在する。
  準備 4 つ（$N:=N_\mu N_\varepsilon$ が $0$・$n\cdot\varepsilon$ の共通分母でもあること（五段の鎖 2 本）・証人の値 $1\le\operatorname{rat}_\Lambda(\mu_N),\operatorname{rat}_\Lambda(\varepsilon_N)$・$\varepsilon_N\ne0$（九段の鎖で矛盾）と反対称性から $1<\operatorname{rat}_\Lambda(\varepsilon_N)$・$n:=\operatorname{num}((A-1)/h)$ と $A-1\le nh$ の四段）と、
  本体の五段の鎖 $\operatorname{rat}_\Lambda(\mu_N)=A=1+(A-1)\le1+nh\le(1+h)^n=\operatorname{rat}_\Lambda(\varepsilon_N)^n=\operatorname{rat}_\Lambda(n\varepsilon_N)$。$n$ は有限回の整数の演算で明示。
  SageMath `check/rational-log-order-group-archimedean/`（$\mu$ 7 点 × $\varepsilon$ 6 点、42 組。$n=\operatorname{num}((A-1)/h)$ は $A$ が指数関数的に大きいため巨大になりやすく、最初の標本では $(1+h)^n$ が桁あふれした。標本を小さくし、$n>20000$ の組は冪の検査を外して記録する仕組みにした——今回は該当 0、$n$ の最大 5831）。
  Lean 具体版 `ThermodynamicLimit/RationalLogOrderGroupArchimedean.lean`（`rationalLogOrderLE_natSmul_of_pos` ほか 8 本）、必要十分版 `NecSuf/ThermodynamicLimit/RationalLogOrderGroupArchimedean.lean`（`archimedean_of_bernoulli_necSuf`。順序体＋「非負元は自然数で追い越せる」仮定から $1\le A$、$1<B$ に対し $A\le B^n$。仮定が削れない理由をコメントに書いた）、導出版 `RationalLogOrderGroupArchimedeanFromNecSuf.lean`。sorry 検査 1258 件。
  次は「倍数辺の部分正方形による密度の挟み込みの誤差評価」（備考に手順を書いてある）。

- **2026-08-16 の tick 337 は、台帳の先頭行「密度の列の Cauchy 性」を論法の数で三行（有理係数の対数順序群の Archimedes 性・倍数辺の部分正方形による密度の挟み込みの誤差評価・密度の列の Cauchy 性（$0<q\le1$））へ割り、その前に要る「有理数の Bernoulli 不等式」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_rational_bernoulli_inequality`（`def_rational_log_order_group_cauchy_sequence` の直後・`remark_real_escape_plan` の直前、住処 Q）で、$h\in\mathbb Q$、$0\le h$、$n\in\mathbb N$ に対し $1+nh\le(1+h)^n$。$n$ の帰納法 1 本（$n\to n+1$ は $0\le nh^2$ を足す・分配則・帰納法の仮定に $0\le1+h$ を掛ける・冪の定義の四段）。
  SageMath `check/rational-bernoulli-inequality/`（$h$ 9 点 × $n\in\{0,\dots,40\}$、1845 検査）。Lean 具体版 `ThermodynamicLimit/RationalBernoulliInequality.lean`（`one_add_nsmul_le_one_add_pow_rat`）、必要十分版 `NecSuf/ThermodynamicLimit/RationalBernoulliInequality.lean`（`one_add_nsmul_le_one_add_pow_necSuf`。順序可換半環。体は要らない）、導出版 `RationalBernoulliInequalityFromNecSuf.lean`。sorry 検査 1248 件。
  次は「有理係数の対数順序群の Archimedes 性」（備考に手順を書いた）。
（これより古い 294 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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
- 熱力学極限: 61 セクション
- 全章（何も言っていない主張の一掃）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 非正の元の有理数倍は係数の大小で比較できる（向きが逆） | todo | $r\le s$（$\mathbb Q$）、$\nu\le_{\Lambda_{\mathbb Q}}0$ なら $s\cdot\nu\le_{\Lambda_{\mathbb Q}}r\cdot\nu$。`claim_rational_log_order_group_scalar_compare_nonneg` と同じ型: $c:=s-r$、`claim_rational_log_order_group_nonneg_scalar_monotone` を $\lambda:=\nu$、$\mu:=0$ で読んで $c\cdot\nu\le c\cdot0=0$、`claim_rational_log_order_group_add_monotone` で $r\cdot\nu$ を足し、分配則 $c\cdot\nu+r\cdot\nu=s\cdot\nu$。誤差評価の下端（$\iota(\log q)\le0$ の係数を $\frac{ka+L}{L^2}$ から $\frac2L$ へ大きくすると値は小さくなる）で引く。Lean 必要十分版は `smul_le_smul_of_le_of_nonneg_necSuf` と対にする |
| 熱力学極限 | 埋め込んだ対数の符号（$q\le1$ で $\iota(\log q)\le0$、$0\le\iota(\ell_2)$、$0\le\iota(\log(1+q))$） | todo | `claim_rational_log_order_preserves_and_reflects`（$\log q\le_\Lambda\log1=0$、$0=\log1\le_\Lambda\log(1+q)$、$0\le_\Lambda\ell_2=\log2$）を `claim_scaled_embedding_order_transfer` の $L:=1$ で $\Lambda_{\mathbb Q}$ へ移す。既にどこかで示していれば書かない（着手時に確認） |
| 熱力学極限 | 倍数辺の部分正方形による密度の挟み込みの誤差評価 | todo | $k\ge1$、$ka<L\le ka+a$、$0<q\le1$ で $\frac2L\iota(\log q)+\frac{(ka)^2}{L^2}\Psi^{\mathrm{op}}_{ka}\le\Psi^{\mathrm{op}}_L\le\frac{2a}L\iota(\ell_2)+\frac{4a}L\iota(\log(1+q))+\frac{(ka)^2}{L^2}\Psi^{\mathrm{op}}_{ka}$。`claim_open_square_subsquare_comparison_density_le_one` を $a:=ka$ で読み（$ka<L$ が要る。$L=ka$ は Cauchy 性の側で `claim_open_square_block_tiling_density` を直接使う）、係数を `claim_square_difference_from_multiple_side_bound`（$\frac{L^2-(ka)^2}{L^2}\le\frac{2a}L$）と $ka+L\le2L$（$\frac{ka+L}{L^2}\le\frac2L$）で大きくする（上の三行を引く） |
| 熱力学極限 | 密度の列の Cauchy 性（$0<q\le1$） | todo | $\bigl(\Psi^{\mathrm{op}}_L(q)\bigr)_L$ が `def_rational_log_order_group_cauchy_sequence` の Cauchy 列であること。$\varepsilon\mapsto N$ を明示する（Archimedes 性で $a$ と $N$ を取る）。完備性も極限論も使わない。$1\le q$ は部分正方形比較の $1\le q$ 版が無いので後回し（必要なら行を足す） |
| 熱力学極限 | 切断による実数体への一度きりの脱出 | todo | Cauchy 列が定める $\mathbb{Q}$ 上の切断として自由エネルギー密度を取る。引くのは「切断は実数を定める」ことだけ |
| 熱力学極限 | 削除した実数値経路の Lean の後片付け | todo | 2026-08-16 に本文から消した実数値経路（実対数・上限／下限による極限）の Lean ファイルが孤立して残っている。入口からの import と sorry 検査は通るが、対応する本文が無いので消す |
| 熱力学極限 | 周期境界自由エネルギー密度への移送 | todo | 周期境界と開境界の境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録

- 2026-08-16（tick 341）: 台帳の先頭行「係数の大小による有理数倍の比較」は非負の元と非正の元で主張が二つあるので二行へ割り、非負の元の行 `claim_rational_log_order_group_scalar_compare_nonneg` を `claim_rational_log_order_group_nonneg_scalar_monotone` の直後に置いて四層で閉じた。
  証明は台帳の備考のとおり（$c:=s-r$、非負有理数倍の順序保存・$c\cdot0=0$・加法単調性・分配則の四段の鎖）。SageMath `rational-log-order-group-scalar-compare-nonneg`、Lean 具体版・必要十分版（係数環の順序付き加法群性と加群の分配則・零への作用、`le` を保つ二つの仮定だけ）・導出版を書き、入口 import・sorry 検査へ 3 件登録（計 1271 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 340）: 台帳の先頭行「非負有理数倍は有理係数の対数順序群の順序を保つ」を実行した。`claim_rational_log_order_group_nonneg_scalar_monotone` を `claim_square_difference_from_multiple_side_bound` の直後に置いた。
  証明は台帳の備考のとおり（既約分数表示 $c=u/v$、共通分母 $vN$ と証人 $u\lambda_N$・$u\mu_N$ の六段の鎖、$u\ge1$ と $u=0$ の場合分け）。
  SageMath `rational-log-order-group-nonneg-scalar-monotone`（標本は 64 ベクトル × 5 点に縮めた）、Lean 具体版・必要十分版（添字・元・証人への作用が `Rep` と `le` を保てば順序が移る）・導出版を書き、入口 import・sorry 検査へ 5 件登録（計 1268 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 339）: 台帳の先頭行「倍数辺の部分正方形による密度の挟み込みの誤差評価」は、非負有理数倍の順序保存・係数の大小による比較・埋め込んだ対数の符号・誤差評価本体の四つの論法を含むので四行へ割った
  （$L=ka$ は `claim_open_square_subsquare_comparison_density_le_one` の $a<L$ に当たらないので誤差評価から外し、Cauchy 性の側でブロック敷き詰め密度を直接使う）。そのうえで誤差評価が引く $\mathbb N$ の不等式「倍数辺との平方の差の評価」を先に書いた
  （`claim_square_difference_from_multiple_side_bound`。`claim_rational_log_order_group_archimedean` の直後。$\mathbb N$ の四則だけではなく $ka\le L\le ka+a$ から乗法単調性を三度使う七段の鎖であり、後の誤差評価が引く）。
  SageMath `square-difference-from-multiple-side-bound`、Lean 具体版・必要十分版（順序可換半環。倍数の形は使わない）・導出版を書き、入口 import・sorry 検査へ 5 件登録（計 1263 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 338）: 台帳の先頭行「有理係数の対数順序群の Archimedes 性」を実行した。`claim_rational_log_order_group_archimedean` を `claim_rational_bernoulli_inequality` の直後に置いた。
  共通分母は `claim_common_common_denominator_exists` の $N_\mu N_\varepsilon$、$\varepsilon_N\ne0$ から $1<\operatorname{rat}_\Lambda(\varepsilon_N)$ は `claim_log_order_group_linear_order` の反対称性と $\mathbb Q$ の全順序、$n$ は $(A-1)/h$ の既約分数の分子（`claim_common_denominator_exists` の $\operatorname{num}$ 記法）。
  SageMath `rational-log-order-group-archimedean`、Lean 具体版・必要十分版・導出版を書き、入口 import・sorry 検査へ 10 件登録（計 1258 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 337）: 台帳の先頭行「密度の列の Cauchy 性」は Archimedes 性の補題・倍数辺の誤差評価・Cauchy 性本体の三つの論法を含むので三行へ割り、さらに Archimedes 性が引く「有理数の Bernoulli 不等式」を先に書いた
  （本文に無かった。$\mathbb Q$ の四則だけの主張ではなく、$n$ の帰納法で示す不等式であり、後の Archimedes 性が引く）。`claim_rational_bernoulli_inequality` を `def_rational_log_order_group_cauchy_sequence` の直後に置いた。
  SageMath `rational-bernoulli-inequality`、Lean 具体版・必要十分版・導出版を書き、入口 import・sorry 検査へ 3 件登録（計 1248 件）。Cauchy 性の行は $0<q\le1$ に限った（$1\le q$ の部分正方形比較が無い）。式変形統一は一時停止中のため実施せず。
（これより古い 304 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

- 2026-08-16（tick 341）: 前 tick の「非負有理数倍は有理係数の対数順序群の順序を保つ」の本文（準備・六段の鎖・$u$ の場合分け）・SageMath overview（10400 検査）・Lean 具体版（`commonDenominator_ratSmul` の六段が本文と 1 対 1）・必要十分版（$c$ の非負性が証人側の作用にだけ入る旨のコメント）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: この主張は共通分母と証人を構成する主張で誤差評価が引くので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 340）: 前 tick の「倍数辺との平方の差の評価」の本文（七段の鎖と $\mathbb N$ の引き算）・SageMath overview（2816 検査）・Lean 具体版・必要十分版（順序可換半環。倍数の形を使わない理由のコメント）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: この主張は乗法単調性を三度使う不等式で誤差評価が引くので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 339）: 前 tick の「有理係数の対数順序群の Archimedes 性」の本文（準備 4 つ・本体の五段）・SageMath overview・Lean 具体版・必要十分版（hArch と体が削れない理由のコメント）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: Archimedes 性は $n$ を明示的に構成する主張で Cauchy 性が引くので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 338）: 前 tick の「有理数の Bernoulli 不等式」の本文（帰納法。$n\to n+1$ の四段）・SageMath overview・Lean 具体版（`one_add_nsmul_le_one_add_pow_rat`）・必要十分版（順序可換半環）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: この主張は $n$ の帰納法で示す不等式で Archimedes 性が引くので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 337）: 前 tick の「何も言っていない主張の一掃」で残した `claim_rational_embedding_commutes_with_integer_multiple` の本文（五段の鎖）・SageMath overview・Lean `toRational_intSmul` を突き合わせ、根拠が一致した。
  この主張は写像 $\iota$ が整数倍と交換することを言い 7 箇所が引くので残す（体の四則だけではない）。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。
（これより古い 325 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

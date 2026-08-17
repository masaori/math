# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地
- **2026-08-17 の tick 385 は、台帳の先頭行「零点密度: 零でない多項式を割る一次因子の冪の指数は係数の上界を超えない」（$f\ne0$、$i>n\Rightarrow\mathrm{ac}_i(f)=0$、$(t-\widehat w)^k\mid f$ ならば $k\le n$）を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_qbar_linear_factor_pow_divides_exponent_le`（`claim_qbar_linear_factor_pow_mul_leading_coeff` の直後・「この先に書くこと」の直前、住処 Qbar）。証明は背理法。準備: 整除の証人 $g$（$f=(t-\widehat w)^kg$）、$g\ne0$（$g=0$ なら $f=(t-\widehat w)^k\cdot0=0$ の一続き三段で $f\ne0$ に反する）、非零係数の番号の集合 $S(g)$ は有限（`def_qbar_polynomial_ring`）で空でない（$g\ne0$）ので最大元 $m$ を取る（$\mathrm{ac}_m(g)\ne0$、$i>m\Rightarrow\mathrm{ac}_i(g)=0$）。鎖 $\mathrm{ac}_{m+k}(f)=\mathrm{ac}_{m+k}((t-\widehat w)^kg)=\mathrm{ac}_m(g)\ne0$（`claim_qbar_linear_factor_pow_mul_leading_coeff` を $C:=g$、上界 $m$、$j:=k$ で）。$m+k>n$ なら係数の仮定で $\mathrm{ac}_{m+k}(f)=0$ となり矛盾、よって $m+k\le n$、$k\le m+k\le n$ の二段。本文末尾「この先に書くこと」の内訳から済んだ項目を消した。
  SageMath `check/qbar-linear-factor-pow-divides-exponent-le/`（$w$ 6 個・$g$ 5 個・$k\le5$・上界 $n$ 2 通り、`QQbar` 厳密。通過）。Lean 具体版 `ThermodynamicLimit/QbarLinearFactorPowDividesExponentLe.lean`（`qbarLinearFactorPowDividesExponentLe`。`g.support.max'`（`natDegree` は使わない）、`Polynomial.support_eq_empty`・`mem_support_iff`・`Finset.le_max'`、`qbarLinearFactorPowMulLeadingCoeff`、`by_contra`）、必要十分版 `NecSuf/ThermodynamicLimit/QbarLinearFactorPowDividesExponentLe.lean`（`poly_linear_factor_pow_divides_exponent_le_necSuf`。可換環だけを要求。零因子の有無は使わない）、導出版 `QbarLinearFactorPowDividesExponentLeFromNecSuf.lean`。sorry 検査 1345 件。check 475 ブロック・verify-check-linkage 263 件・PDF 258 ページ通過。
  式変形統一: 姉妹側「$H$ と $\hat Z$・$\hat Y$ の交換子の入れ子」（`008_TV1_hatZ_hatY_part1.ts`）の補題 1 で、散文中の $\mathrm{ad}_{\alpha X}(W)=[\alpha X,W]=\alpha[X,W]=\alpha\,\mathrm{ad}_X(W)$ の鎖を一続き三段（$\mathrm{ad}$ の定義／交換子の第 1 引数の $\mathbb C$ 線型性／$\mathrm{ad}$ の定義。行末根拠つき）へ揃えた（内容は不変）。姉妹側の check（300 ブロック）・PDF 324 ページ通過。
  レビュー: 前 tick の `claim_qbar_linear_factor_pow_mul_leading_coeff` の本文（出発点三段・冪の等式二段・一歩四段）と Lean 具体版（`calc` 三段・四段）を突き合わせて一致。修正なし。次は「零点密度: 根の重複度 $\mathrm{mult}_w(f)$ の定義」（$f\ne0$ について $(t-\widehat w)^k\mid f$ を満たす $k$ の最大元。集合が空でない（`def_qbar_linear_factor_power_divides` の $k=0$）かつ上に有界（今 tick の主張で $k\le n$）ので最大元がある。定義ブロックなので必要十分版・SageMath は無し。Lean は `Nat.find` か `Finset.max'` で書き、mathlib の `rootMultiplicity` との一致は橋渡し一本を添える）。
- **2026-08-17 の tick 384 は、台帳の先頭行「零点密度: 一次因子の冪との積の先頭の係数はもとの先頭の係数」（$k>m\Rightarrow\mathrm{ac}_k(C)=0$ のもとで $\mathrm{ac}_{m+j}((t-\widehat w)^jC)=\mathrm{ac}_m(C)$）を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_qbar_linear_factor_pow_mul_leading_coeff`（`claim_qbar_linear_factor_pow_mul_coeff_bound` の直後・「この先に書くこと」の直前、住処 Qbar）。証明は $j$ の帰納法（出発点は $\mathrm{ac}_{m+0}((t-\widehat w)^0C)=\mathrm{ac}_{m+0}(1\cdot C)=\mathrm{ac}_{m+0}(C)=\mathrm{ac}_m(C)$ の一続き三段。一歩は `claim_qbar_linear_factor_pow_mul_coeff_bound` で $(t-\widehat w)^jC$ の上界 $m+j$ を得、冪の等式 $(t-\widehat w)^{j+1}C=(t-\widehat w)(t-\widehat w)^jC$（二段）のあと、$\mathrm{ac}_{m+(j+1)}=\mathrm{ac}_{(m+j)+1}$（$\mathbb N$ の結合則）／冪の等式／`claim_qbar_poly_linear_factor_leading_coeff`（上界 $m+j$）／帰納法の仮定の一続き四段）。本文末尾「この先に書くこと」の内訳から済んだ項目を消した。
  SageMath `check/qbar-linear-factor-pow-mul-leading-coeff/`（$w$ 6 個・$C$ 5 個・上界 $m$ 2 通り・$j\le5$、`QQbar` 厳密。通過）。Lean 具体版 `ThermodynamicLimit/QbarLinearFactorPowMulLeadingCoeff.lean`（`qbarLinearFactorPowMulLeadingCoeff`。`induction j`、`calc` 三段・四段、`Nat.add_assoc`、`qbarLinearFactorPowMulCoeffBound`、`qbarPolyLinearFactorLeadingCoeff`）、必要十分版 `NecSuf/ThermodynamicLimit/QbarLinearFactorPowMulLeadingCoeff.lean`（`poly_linear_factor_pow_mul_leading_coeff_necSuf`。可換環だけを要求）、導出版 `QbarLinearFactorPowMulLeadingCoeffFromNecSuf.lean`。sorry 検査 1342 件。check 474 ブロック・verify-check-linkage 262 件・PDF 258 ページ通過。
  式変形統一: 姉妹側「$H$ と $\hat Z$・$\hat Y$ の交換子の入れ子」（`008_TV1_hatZ_hatY_part1.ts`）の証明の冒頭で、散文中の交換子の双線型性の二等号の鎖 $[\alpha X,\beta W]=(\alpha X)(\beta W)-(\beta W)(\alpha X)=\alpha\beta(XW-WX)$ を一続き四段（交換子の定義／スカラー倍が積と可換／$\mathbb C$ の可換則と分配則／交換子の定義。行末根拠つき。ラベル参照は姉妹側の生成器が `\blkref` を持たないので直前の散文に残した）へ揃えた（内容は不変）。姉妹側の check（300 ブロック）・PDF 324 ページ通過。
- **2026-08-17 の tick 383 は、台帳の先頭行「零点密度: 零でない多項式を割る一次因子の冪の指数は係数の上界を超えない」を論法で三行へ割り（一次因子の冪との積の係数の上界（帰納法）／一次因子の冪との積の先頭の係数はもとの先頭の係数（帰納法。前者を引く）／指数 $k\le n$（背理法。$g\ne0$ の最高次の係数と後者から $\mathrm{ac}_{m+k}(f)\ne0$））、その最初「一次因子の冪との積の係数は、上界と指数の和より上の番号で零である」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_qbar_linear_factor_pow_mul_coeff_bound`（`def_qbar_linear_factor_power_divides` の直後・「この先に書くこと」の直前、住処 Qbar）: $C\in\overline{\mathbb Q}[t]$ が $k>m\Rightarrow\mathrm{ac}_k(C)=0$ を満たすとき、任意の $w$、$j\in\mathbb N$ で $k>m+j\Rightarrow\mathrm{ac}_k((t-\widehat w)^jC)=0$。証明は $j$ の帰納法（出発点は $(t-\widehat w)^0C=1\cdot C=C$ の一続き三段。一歩は冪の等式 $(t-\widehat w)^{j+1}C=(t-\widehat w)(t-\widehat w)^jC$（冪の約束・可換則・結合則）に `claim_qbar_poly_linear_factor_coeff_bound` を上界 $m+j$ で当てる）。本文末尾「この先に書くこと」の内訳に「先頭の係数」を足した。
  SageMath `check/qbar-linear-factor-pow-mul-coeff-bound/`（$w$ 6 個・$C$ 5 個・$j\le5$、`QQbar` 厳密。通過）。Lean 具体版 `ThermodynamicLimit/QbarLinearFactorPowMulCoeffBound.lean`（`qbarLinearFactorPowMulCoeffBound`。`induction j`、`pow_succ`・`mul_comm`・`mul_assoc`、`qbarPolyLinearFactorCoeffBound`）、必要十分版 `NecSuf/ThermodynamicLimit/QbarLinearFactorPowMulCoeffBound.lean`（`poly_linear_factor_pow_mul_coeff_bound_necSuf`。可換環だけを要求）、導出版 `QbarLinearFactorPowMulCoeffBoundFromNecSuf.lean`。sorry 検査 1339 件。check 473 ブロック・verify-check-linkage 261 件・PDF 257 ページ通過。
  式変形統一: 姉妹側「$\hat T V_1$ と $\hat Z$・$\hat Y$」（`008_TV1_hatZ_hatY_part1.ts`）で、散文中の $i^n$ の値の二等号・三等号の鎖（$n$ 偶数: $i^n=(i^2)^{n/2}=(-1)^{n/2}$、奇数: $i^n=i\cdot i^{n-1}=i(i^2)^{(n-1)/2}=i(-1)^{(n-1)/2}$）を一続き（各二段・三段、行末根拠つき）へ揃えた（内容は不変）。姉妹側の check（300 ブロック）・PDF 324 ページ通過。
  レビュー: 前 tick の `def_qbar_linear_factor_power_divides` の本文（定義・$k=0$ で常に割り切る・係数の上界と $\mathrm{aev}_w(f)=0$ から $(t-\widehat w)^1\mid f$）と Lean 具体版（`qbarLinearFactorPowDivides`・`_zero`・`_one_of_root`・`_iff_dvd`）を突き合わせて一致。修正なし。次は「一次因子の冪との積の先頭の係数はもとの先頭の係数」（$k>m\Rightarrow\mathrm{ac}_k(C)=0$ のもとで $\mathrm{ac}_{m+j}((t-\widehat w)^jC)=\mathrm{ac}_m(C)$。$j$ の帰納法で、一歩は今 tick の主張で上界 $m+j$ を得てから `claim_qbar_poly_linear_factor_leading_coeff` を当てる。Lean は `qbarPolyLinearFactorLeadingCoeff` と `qbarLinearFactorPowMulCoeffBound`）。
- **2026-08-17 の tick 382 は、台帳の先頭行「零点密度: 重複度付きの個数への精密化」を論法で六行へ割り（一次因子の冪による整除の定義／零でない多項式を割る一次因子の冪の指数は係数の上界を超えない／根の重複度の定義（整除する指数の最大元）／重複度が 1 以上であることと根であることの一致／有限集合上の重複度の和は係数の上界を超えない／重複度付きの個数 $N^{\mathrm{mult}}_L(c,r)$ と $N_L\le N^{\mathrm{mult}}_L\le2L^2$）、その最初「代数的数係数多項式が一次因子の冪で割り切れること」を本文・Lean 具体版で閉じた（定義ブロックなので必要十分版と SageMath は置かない。住処 Qbar、脱出なし）。**
  `def_qbar_linear_factor_power_divides`（`def_fisher_zero_density_limsup_liminf` の直後・「この先に書くこと」の直前、住処 Qbar）: $w\in\overline{\mathbb Q}$、$k\in\mathbb N$、$f\in\overline{\mathbb Q}[t]$ で、$(t-\widehat w)^k\mid f$ :⇔ ある $g\in\overline{\mathbb Q}[t]$ で $f=(t-\widehat w)^k\cdot g$（記号 $\mid$ はこの意味にだけ使う）。定義から読めることとして、$k=0$ では常に割り切る（$g:=f$。整除する $k$ の集合が空でない——次の重複度（最大元）の定義が引く）、係数の上界 $n$ と $\mathrm{aev}_w(f)=0$ から $(t-\widehat w)^1\mid f$（`claim_qbar_factor_theorem` の商が証人）を置いた。本文末尾「この先に書くこと」の零点密度の内訳を六行の残り五つへ書き換えた。
  Lean 具体版 `ThermodynamicLimit/QbarLinearFactorPowDivides.lean`（`qbarLinearFactorPowDivides`（$\exists g,\ f=(X-C\,w)^k\cdot g$）・`_zero`・`_one_of_root`（`qbarFactorTheorem` の商を証人に）・`_iff_dvd`（mathlib の `∣` との一致を述べる橋渡し一本。`Iff.rfl`））。sorry 検査 1336 件。check 472 ブロック・verify-check-linkage 260 件・PDF 256 ページ通過。
  式変形統一: 姉妹側「$\exp(X)Y\exp(-X)=\exp(\mathrm{ad}_X)(Y)$ の証明」（`005_exp_conjugation_proof.ts`）の Step 3 で、散文中の $\frac1{m!}\binom mk=\frac1{m!}\cdot\frac{m!}{k!(m-k)!}=\frac1{k!(m-k)!}$ を一続き二段（二項係数の定義／約分。行末根拠つき）へ揃えた（内容は不変）。姉妹側の check・PDF 324 ページ通過。
  レビュー: 前 tick の `def_fisher_zero_density_limsup_liminf` の本文（尾部の像・空でない／上下に有界の含意の鎖・$s_N$・$i_N$・$\overline\nu$・$\underline\nu$）と Lean 具体版（`fisherZeroDensityTail*`・`fisherZeroDensityLimsup`／`Liminf`）を突き合わせて一致。修正なし。次は「零でない多項式を割る一次因子の冪の指数は係数の上界を超えない」（$f\ne0$、$k>n\Rightarrow\mathrm{ac}_k(f)=0$、$(t-\widehat w)^k\mid f$ ならば $k\le n$。着手前に論法を確かめる: $g\ne0$ の最高次の係数 $m$ と $(t-\widehat w)^k$ の $t^k$ の係数 $1$ から $\mathrm{ac}_{k+m}(f)=\mathrm{ac}_m(g)\ne0$（`claim_qbar_no_zero_divisors` は不要——係数 $1$ との積）、よって $k+m\le n$。$(t-\widehat w)^k$ の係数の形（$t^k$ の係数 $1$、$k$ より上は $0$）を先に主張として置く必要があれば、さらに割る。Lean は `Polynomial.natDegree` を使わず係数で書く）。
- **2026-08-17 の tick 381 は、台帳の先頭行「零点密度: 実数体への脱出——$(\nu_L(c,r))_{L\ge1}\subset\mathbb Q$ の上極限と下極限（完備性。極限の存在は主張しない）」を本文・Lean 具体版まで書いて閉じた（定義ブロックなので必要十分版と SageMath は置かない。住処 R、脱出理由は完備性）。**
  `def_fisher_zero_density_limsup_liminf`（`claim_fisher_zero_density_in_rational_disc_le_two` の直後・「この先に書くこと」の直前、住処 R）: $c,r$ を固定し、尾部の像 $T_N(c,r):=\{\iota_{\mathbb Q\to\mathbb R}(\nu_L(c,r))\mid N\le L\}\subset\mathbb R$（$N\ge1$）が空でなく（$L:=N$）上に有界（上界 $2$。含意の鎖: $\nu_L\le2$ と $\iota$ の順序保存）下に有界（下界 $0$）なので、完備性で $s_N:=\sup T_N$、$i_N:=\inf T_N$ が定まり $0\le s_N$、$i_N\le2$。集合 $\{s_N\mid N\ge1\}$ は空でなく下に有界、$\{i_N\mid N\ge1\}$ は空でなく上に有界なので、再び完備性で $\overline\nu(c,r):=\inf\{s_N\}$、$\underline\nu(c,r):=\sup\{i_N\}$。$\overline\nu=\underline\nu$（収束）は主張しない。本文末尾「この先に書くこと」の零点密度の内訳から「上極限・下極限による実数体への脱出」を消した。
  Lean 具体版 `ThermodynamicLimit/FisherZeroDensityLimsupLiminf.lean`（`fisherZeroDensitySequence`（$L=0$ は $0$ で埋める。`periodicDensitySequence` と同じ形）・`_of_ne_zero`・`_nonneg`・`_le_two`・`fisherZeroDensityTail`・`_nonempty`・`_bddAbove`・`_bddBelow`・`fisherZeroDensityTailSup_nonneg`・`fisherZeroDensityTailInf_le_two`・`fisherZeroDensityTailSupSet`／`InfSet` とその `_nonempty`・`_bddBelow`／`_bddAbove`・`fisherZeroDensityLimsup`（`sInf`）・`fisherZeroDensityLiminf`（`sSup`）。`Rat.cast_le`・`le_csSup`・`csInf_le`）。sorry 検査 1333 件。check 471 ブロック・verify-check-linkage 260 件・PDF 256 ページ通過。
  式変形統一: 姉妹側「Frobenius 内積の性質」（`005_exp_conjugation_proof.ts`）の Step 6（三角不等式）の末尾で、散文「両辺とも非負なので平方の単調性により $\|A+B\|\le\|A\|+\|B\|$」を含意の鎖二段（$\|A+B\|^2\le(\|A\|+\|B\|)^2\Longrightarrow\|A+B\|\le\|A\|+\|B\|$。行末根拠つき）へ揃えた（内容は不変）。姉妹側の check・PDF 323 ページ通過。
  レビュー: 前 tick の `def_fisher_zero_density_in_rational_disc`・`claim_fisher_zero_density_in_rational_disc_le_two` の本文（一続き四段）と Lean 具体版（`calc` 四段）を突き合わせて一致。修正なし。次は「零点密度: 重複度付きの個数への精密化（$\overline{\mathbb Q}[x]$ での根の重複度の定義から）」（着手前に論法で割る: 根の重複度の定義（$\overline{\mathbb Q}[t]$ で $(t-\xi)^k$ が割り切る最大の $k$）／重複度の和は次数以下／重複度付きの個数 $N^{\mathrm{mult}}_L(c,r)$ と $N_L\le N^{\mathrm{mult}}_L\le2L^2$。Lean は `Polynomial.rootMultiplicity`）。

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
- 熱力学極限: 90 セクション
- 全章（何も言っていない主張の一掃）: 1 セクション
- 零点の詰め寄り・固有値の代数性（本文の lean: から引かれていない Lean の配線）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 零点密度: 根の重複度 $\mathrm{mult}_w(f)$ の定義（$f\ne0$ について、$(t-\widehat w)^k\mid f$ を満たす $k$ の最大元） | todo | 定義ブロック。集合が空でなく上に有界なので最大元がある |
| 熱力学極限 | 零点密度: 重複度が 1 以上であることと $\mathrm{aev}_w(f)=0$ は同じこと | todo | 両向きの含意 |
| 熱力学極限 | 零点密度: 有限集合上の重複度の和は係数の上界を超えない（$\sum_{w\in s}\mathrm{mult}_w(f)\le n$） | todo | 帰納法（`claim_qbar_distinct_roots_card_bound` の形） |
| 熱力学極限 | 零点密度: 重複度付きの個数 $N^{\mathrm{mult}}_L(c,r):=\sum_{\xi\in\mathcal F_L\cap D(c,r)}\mathrm{mult}_\xi(\widehat{Z_L}^{\,F})$ と $N_L\le N^{\mathrm{mult}}_L\le2L^2$ | todo | 定義と挟み込み。論法が二つなら割る |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録
- 2026-08-17（tick 385）: 台帳の先頭行「零点密度: 零でない多項式を割る一次因子の冪の指数は係数の上界を超えない」を四層で閉じ、`claim_qbar_linear_factor_pow_divides_exponent_le` を `claim_qbar_linear_factor_pow_mul_leading_coeff` の直後に置いた。背理法（整除の証人 $g\ne0$、非零係数の番号の最大元 $m$、`claim_qbar_linear_factor_pow_mul_leading_coeff` で $\mathrm{ac}_{m+k}(f)=\mathrm{ac}_m(g)\ne0$、$m+k\le n$、$k\le n$）。SageMath（$k\le5$、上界 2 通り）、Lean 具体版・必要十分版（可換環）・導出版、sorry 検査 1345 件。式変形統一: 姉妹側「$H$ と $\hat Z$・$\hat Y$ の交換子の入れ子」（`008_TV1_hatZ_hatY_part1.ts`）の補題 1 で、散文中の $\mathrm{ad}_{\alpha X}(W)=[\alpha X,W]=\alpha[X,W]=\alpha\,\mathrm{ad}_X(W)$ を一続き三段（行末根拠つき）へ揃えた（内容は不変）。姉妹側の check（300 ブロック）・PDF 324 ページ通過。
- 2026-08-17（tick 384）: 台帳の先頭行「零点密度: 一次因子の冪との積の先頭の係数はもとの先頭の係数」を四層で閉じ、`claim_qbar_linear_factor_pow_mul_leading_coeff` を `claim_qbar_linear_factor_pow_mul_coeff_bound` の直後に置いた。$j$ の帰納法（一歩は前主張の上界 $m+j$・冪の等式・`claim_qbar_poly_linear_factor_leading_coeff`・帰納法の仮定の一続き四段）。SageMath（$j\le5$、上界 2 通り）、Lean 具体版・必要十分版（可換環）・導出版、sorry 検査 1342 件。式変形統一: 姉妹側「$H$ と $\hat Z$・$\hat Y$ の交換子の入れ子」（`008_TV1_hatZ_hatY_part1.ts`）の証明の冒頭で、散文中の交換子の双線型性の二等号の鎖 $[\alpha X,\beta W]=(\alpha X)(\beta W)-(\beta W)(\alpha X)=\alpha\beta(XW-WX)$ を一続き四段（交換子の定義／スカラー倍が積と可換／$\mathbb C$ の可換則と分配則／交換子の定義。行末根拠つき。ラベル参照は姉妹側の生成器が `\blkref` を持たないので直前の散文に残した）へ揃えた（内容は不変）。姉妹側の check（300 ブロック）・PDF 324 ページ通過。
- 2026-08-17（tick 383）: 台帳の先頭行「零点密度: 零でない多項式を割る一次因子の冪の指数は係数の上界を超えない」を三行へ割った（一次因子の冪との積の係数の上界／冪との積の先頭の係数／指数 $k\le n$。理由: 二つの帰納法と一つの背理法がそれぞれ別の論法になるため）。その最初「一次因子の冪との積の係数は、上界と指数の和より上の番号で零である」を四層で閉じ、`claim_qbar_linear_factor_pow_mul_coeff_bound` を `def_qbar_linear_factor_power_divides` の直後に置いた。SageMath（$j\le5$）、Lean 具体版・必要十分版（可換環）・導出版、sorry 検査 1339 件。式変形統一: 姉妹側「$\hat T V_1$ と $\hat Z$・$\hat Y$」（`008_TV1_hatZ_hatY_part1.ts`）で、散文中の $i^n$ の値の二等号・三等号の鎖（$n$ 偶数: $i^n=(i^2)^{n/2}=(-1)^{n/2}$、奇数: $i^n=i\cdot i^{n-1}=i(i^2)^{(n-1)/2}=i(-1)^{(n-1)/2}$）を一続き（各二段・三段、行末根拠つき）へ揃えた（内容は不変）。姉妹側の check（300 ブロック）・PDF 324 ページ通過。
- 2026-08-17（tick 382）: 台帳の先頭行「零点密度: 重複度付きの個数への精密化」を六行へ割った（一次因子の冪による整除の定義／整除する指数の上界／根の重複度の定義／重複度 1 以上と根の一致／有限集合上の重複度の和の上界／$N^{\mathrm{mult}}_L(c,r)$ の定義と挟み込み。理由: 定義・係数の比較・最大元の存在・両向きの含意・帰納法・定義の挟み込みがそれぞれ別の論法になるため）。その最初「代数的数係数多項式が一次因子の冪で割り切れること」を本文・Lean 具体版で閉じ、`def_qbar_linear_factor_power_divides` を `def_fisher_zero_density_limsup_liminf` の直後に置いた（定義ブロック。必要十分版・SageMath は無し）。sorry 検査 1336 件。式変形統一: 姉妹側「$\exp(X)Y\exp(-X)=\exp(\mathrm{ad}_X)(Y)$ の証明」（`005_exp_conjugation_proof.ts`）Step 3 の散文中の $\frac1{m!}\binom mk$ の二等号の鎖を一続き二段（行末根拠つき）へ揃えた（内容は不変。姉妹側 check・PDF 324 ページ通過）。
- 2026-08-17（tick 381）: 台帳の先頭行「零点密度: $(\nu_L(c,r))_{L\ge1}$ の上極限と下極限（実数体への脱出: 完備性）」を本文・Lean 具体版で閉じ、`def_fisher_zero_density_limsup_liminf` を `claim_fisher_zero_density_in_rational_disc_le_two` の直後に置いた（定義ブロック。必要十分版・SageMath は無し）。sorry 検査 1333 件。式変形統一: 姉妹側「Frobenius 内積の性質」（`005_exp_conjugation_proof.ts`）の Step 6（三角不等式）の末尾で、散文「両辺とも非負なので平方の単調性により $\|A+B\|\le\|A\|+\|B\|$」を含意の鎖二段（$\|A+B\|^2\le(\|A\|+\|B\|)^2\Longrightarrow\|A+B\|\le\|A\|+\|B\|$。行末根拠つき）へ揃えた（内容は不変）。姉妹側の check・PDF 323 ページ通過。

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
- 2026-08-17（tick 385）: 前 tick の「一次因子の冪との積の先頭の係数はもとの先頭の係数」の本文（帰納法。出発点三段・冪の等式二段・一歩四段）と Lean 具体版（`induction j`、`calc` 三段・四段、`Nat.add_assoc`、`qbarLinearFactorPowMulCoeffBound`、`qbarPolyLinearFactorLeadingCoeff`）・必要十分版（可換環）を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の主張は背理法で示す指数の上界であり、次の「根の重複度の定義」の well-defined 性（整除する指数の集合が上に有界）が引く（後で引く形）ので独立ブロックとして残す。$g\ne0$（$g=0$ なら $f=0$）、非零係数の番号の最大元 $m$ の存在（有限・空でない）、$k\le m+k$（$\mathbb N$ の加法の単調性）は独立ブロックにせず証明の中の準備と一続きの行に置いた。本文末尾「この先に書くこと」の内訳から済んだ項目を消し、台帳のセクション表（先頭行を消した）と揃えた。式変形統一: 姉妹側「$H$ と $\hat Z$・$\hat Y$ の交換子の入れ子」（`008_TV1_hatZ_hatY_part1.ts`）の補題 1 で、散文中の $\mathrm{ad}_{\alpha X}(W)=[\alpha X,W]=\alpha[X,W]=\alpha\,\mathrm{ad}_X(W)$ を一続き三段（行末根拠つき）へ揃えた（内容は不変）。姉妹側の check（300 ブロック）・PDF 324 ページ通過。
- 2026-08-17（tick 384）: 前 tick の「一次因子の冪との積の係数は、上界と指数の和より上の番号で零である」の本文（帰納法。出発点三段・冪の等式二段・一歩二段）と Lean 具体版（`induction j`、`pow_zero`/`one_mul`、`pow_succ`/`mul_comm`/`mul_assoc`、`qbarPolyLinearFactorCoeffBound`）・必要十分版（可換環）を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の主張は帰納法で示す先頭の係数の移動であり、次の「指数 $k\le n$」の背理法が引く（後で引く形）ので独立ブロックとして残す。$m+0=m$・$m+(j+1)=(m+j)+1$（$\mathbb N$ の加法）と冪の等式は独立ブロックにせず証明の中の一続きの行と行末の根拠に置いた。本文末尾「この先に書くこと」の内訳から済んだ項目を消し、台帳のセクション表（先頭行を消した）と揃えた。式変形統一: 姉妹側「$H$ と $\hat Z$・$\hat Y$ の交換子の入れ子」（`008_TV1_hatZ_hatY_part1.ts`）の証明の冒頭で、散文中の交換子の双線型性の二等号の鎖 $[\alpha X,\beta W]=(\alpha X)(\beta W)-(\beta W)(\alpha X)=\alpha\beta(XW-WX)$ を一続き四段（交換子の定義／スカラー倍が積と可換／$\mathbb C$ の可換則と分配則／交換子の定義。行末根拠つき。ラベル参照は姉妹側の生成器が `\blkref` を持たないので直前の散文に残した）へ揃えた（内容は不変）。姉妹側の check（300 ブロック）・PDF 324 ページ通過。
- 2026-08-17（tick 383）: 前 tick の「代数的数係数多項式が一次因子の冪で割り切れること」の本文と Lean 具体版を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の主張は帰納法で示す係数の上界であり、次の「先頭の係数」の帰納法の一歩と「指数 $k\le n$」の背理法が引く（後で繰り返し引く形）ので独立ブロックとして残す。冪の等式 $(t-\widehat w)^{j+1}C=(t-\widehat w)(t-\widehat w)^jC$ は独立ブロックにせず証明の中の一続き二段に置いた。本文末尾「この先に書くこと」の内訳と台帳のセクション表（先頭行を三行へ）を同じ tick で揃えた。式変形統一: 姉妹側「$\hat T V_1$ と $\hat Z$・$\hat Y$」（`008_TV1_hatZ_hatY_part1.ts`）で、散文中の $i^n$ の値の二等号・三等号の鎖（$n$ 偶数: $i^n=(i^2)^{n/2}=(-1)^{n/2}$、奇数: $i^n=i\cdot i^{n-1}=i(i^2)^{(n-1)/2}=i(-1)^{(n-1)/2}$）を一続き（各二段・三段、行末根拠つき）へ揃えた（内容は不変）。姉妹側の check（300 ブロック）・PDF 324 ページ通過。
- 2026-08-17（tick 382）: 前 tick の「格子点数あたりの Fisher 零点数の列の上極限と下極限（実数体への脱出: 完備性）」の本文と Lean 具体版を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick は定義ブロックで、独立の主張ブロックは足していない。$k=0$ で常に割り切ること（整除する指数の集合が空でない）は次の重複度の定義の well-defined 性が引く形、$\mathrm{aev}_w(f)=0\Rightarrow(t-\widehat w)^1\mid f$ は既存の因数定理の読み替えなので、どちらも定義の中に置いた。本文末尾「この先に書くこと」の内訳と台帳のセクション表（先頭行を六行へ）を同じ tick で揃えた。式変形統一: 姉妹側「$\exp(X)Y\exp(-X)=\exp(\mathrm{ad}_X)(Y)$ の証明」Step 3 の散文中の二等号の鎖を一続き二段へ（姉妹側 check・PDF 324 ページ通過）。
- 2026-08-17（tick 381）: 前 tick の「有理円板内の格子点数あたりの Fisher 零点数」の定義と「$2$ を超えない」の本文（一続き四段）と Lean 具体版（`calc` 四段）を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick は定義ブロックで、独立の主張ブロックは足していない。尾部の像が空でなく有界であること・$0\le s_N$・$i_N\le2$ は上限・下限が定まるための well-defined 性（住処の確定）なので定義の中に置いた。本文末尾「この先に書くこと」から済んだ項目を消し、台帳のセクション表（先頭行を消した）と揃えた。式変形統一: 姉妹側「Frobenius 内積の性質」（`005_exp_conjugation_proof.ts`）の Step 6（三角不等式）の末尾で、散文「両辺とも非負なので平方の単調性により $\|A+B\|\le\|A\|+\|B\|$」を含意の鎖二段（$\|A+B\|^2\le(\|A\|+\|B\|)^2\Longrightarrow\|A+B\|\le\|A\|+\|B\|$。行末根拠つき）へ揃えた（内容は不変）。姉妹側の check・PDF 323 ページ通過。

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

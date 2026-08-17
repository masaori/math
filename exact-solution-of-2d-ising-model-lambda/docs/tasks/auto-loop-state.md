# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-17 の tick 381 は、台帳の先頭行「零点密度: 実数体への脱出——$(\nu_L(c,r))_{L\ge1}\subset\mathbb Q$ の上極限と下極限（完備性。極限の存在は主張しない）」を本文・Lean 具体版まで書いて閉じた（定義ブロックなので必要十分版と SageMath は置かない。住処 R、脱出理由は完備性）。**
  `def_fisher_zero_density_limsup_liminf`（`claim_fisher_zero_density_in_rational_disc_le_two` の直後・「この先に書くこと」の直前、住処 R）: $c,r$ を固定し、尾部の像 $T_N(c,r):=\{\iota_{\mathbb Q\to\mathbb R}(\nu_L(c,r))\mid N\le L\}\subset\mathbb R$（$N\ge1$）が空でなく（$L:=N$）上に有界（上界 $2$。含意の鎖: $\nu_L\le2$ と $\iota$ の順序保存）下に有界（下界 $0$）なので、完備性で $s_N:=\sup T_N$、$i_N:=\inf T_N$ が定まり $0\le s_N$、$i_N\le2$。集合 $\{s_N\mid N\ge1\}$ は空でなく下に有界、$\{i_N\mid N\ge1\}$ は空でなく上に有界なので、再び完備性で $\overline\nu(c,r):=\inf\{s_N\}$、$\underline\nu(c,r):=\sup\{i_N\}$。$\overline\nu=\underline\nu$（収束）は主張しない。本文末尾「この先に書くこと」の零点密度の内訳から「上極限・下極限による実数体への脱出」を消した。
  Lean 具体版 `ThermodynamicLimit/FisherZeroDensityLimsupLiminf.lean`（`fisherZeroDensitySequence`（$L=0$ は $0$ で埋める。`periodicDensitySequence` と同じ形）・`_of_ne_zero`・`_nonneg`・`_le_two`・`fisherZeroDensityTail`・`_nonempty`・`_bddAbove`・`_bddBelow`・`fisherZeroDensityTailSup_nonneg`・`fisherZeroDensityTailInf_le_two`・`fisherZeroDensityTailSupSet`／`InfSet` とその `_nonempty`・`_bddBelow`／`_bddAbove`・`fisherZeroDensityLimsup`（`sInf`）・`fisherZeroDensityLiminf`（`sSup`）。`Rat.cast_le`・`le_csSup`・`csInf_le`）。sorry 検査 1333 件。check 471 ブロック・verify-check-linkage 260 件・PDF 256 ページ通過。
  式変形統一: 姉妹側「Frobenius 内積の性質」（`005_exp_conjugation_proof.ts`）の Step 6（三角不等式）の末尾で、散文「両辺とも非負なので平方の単調性により $\|A+B\|\le\|A\|+\|B\|$」を含意の鎖二段（$\|A+B\|^2\le(\|A\|+\|B\|)^2\Longrightarrow\|A+B\|\le\|A\|+\|B\|$。行末根拠つき）へ揃えた（内容は不変）。姉妹側の check・PDF 323 ページ通過。
  レビュー: 前 tick の `def_fisher_zero_density_in_rational_disc`・`claim_fisher_zero_density_in_rational_disc_le_two` の本文（一続き四段）と Lean 具体版（`calc` 四段）を突き合わせて一致。修正なし。次は「零点密度: 重複度付きの個数への精密化（$\overline{\mathbb Q}[x]$ での根の重複度の定義から）」（着手前に論法で割る: 根の重複度の定義（$\overline{\mathbb Q}[t]$ で $(t-\xi)^k$ が割り切る最大の $k$）／重複度の和は次数以下／重複度付きの個数 $N^{\mathrm{mult}}_L(c,r)$ と $N_L\le N^{\mathrm{mult}}_L\le2L^2$。Lean は `Polynomial.rootMultiplicity`）。

- **2026-08-17 の tick 380 は、台帳の先頭行「零点密度: 格子点数あたりの零点数 $\nu_L(c,r):=N_L(c,r)/L^2\in\mathbb Q$ と上界 $\nu_L\le2$」を、定義ブロックと主張ブロックの二つに分けて本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて閉じた（住処 Q、脱出なし）。**
  `def_fisher_zero_density_in_rational_disc`（`def_fisher_zero_count_in_rational_disc` の直後、住処 Q）: $\nu_L(c,r):=N_L(c,r)/L^2\in\mathbb Q$（$L^2\ge1$ なので分母は $0$ でない。分子は自然数、分母は正なので $0\le\nu_L$——住処の確定として定義の中に置いた）。`claim_fisher_zero_density_in_rational_disc_le_two`（その直後・「この先に書くこと」の直前、住処 Q）: $\nu_L(c,r)\le2$。証明は一続き四段（定義／$N_L\le\lvert\mathcal F_L\rvert$ を正の分母で割る／$\lvert\mathcal F_L\rvert\le2L^2$ を正の分母で割る／約分）。上界は $L,c,r$ によらないので、列 $(\nu_L(c,r))_{L\ge1}$ は $0$ 以上 $2$ 以下——次の上極限・下極限が引く。本文末尾「この先に書くこと」の零点密度の内訳から「格子点数あたりの零点数」を消した。
  SageMath `check/fisher-zero-density-in-rational-disc-le-two/`（$L\le2$、有理円板 9 組、鎖の各段を `QQ` で厳密に。18 検査、5 秒。$L=3$ は根 12 個の `AA` 厳密比較が 100 秒で終わらないので除外）。Lean 具体版 `ThermodynamicLimit/FisherZeroDensityInRationalDisc.lean`（`fisherZeroDensityInRationalDisc`・`lattice_size_sq_pos_rat`・`_nonneg`・`_le_two`（`calc` 四段。`div_le_div_of_nonneg_right`・`mul_div_cancel_right₀`））、必要十分版 `NecSuf/ThermodynamicLimit/FisherZeroDensityInRationalDiscLeTwo.lean`（`div_le_two_of_le_of_le_two_mul_necSuf`。順序体（`Field`＋`LinearOrder`＋`IsStrictOrderedRing`）で $a\le b$、$b\le2d$、$0<d$ から $a/d\le2$。ℚ であることは使わない）、導出版 `FisherZeroDensityInRationalDiscLeTwoFromNecSuf.lean`。sorry 検査 1321 件。check 470 ブロック・verify-check-linkage 260 件・PDF 255 ページ通過。
  式変形統一: 姉妹側「Frobenius 内積の性質」（`005_exp_conjugation_proof.ts`）の Cauchy--Schwarz の場合 2 で、散文中の「$|u|^2/\|B\|^2\le\|A\|^2$（$\mathbb R$ の移項）」を一続き三段（$|u|^2/\|B\|^2=\|A\|^2-(\|A\|^2-|u|^2/\|B\|^2)\le\|A\|^2-0=\|A\|^2$。行末根拠つき）へ揃えた（内容は不変）。姉妹側の check・PDF 323 ページ通過。
  レビュー: 前 tick の `def_fisher_zero_count_in_rational_disc` の本文（有限性の根拠・$N_L\in\mathbb N$・$N_L\le\lvert\mathcal F_L\rvert$）と Lean 具体版（`fisherZeroSet_inter_rationalDisc_finite`・`fisherZeroCountInRationalDisc`・`_le_ncard`）を突き合わせて一致。修正なし。次は「実数体への脱出——$(\nu_L(c,r))_{L\ge1}\subset\mathbb Q$ の上極限と下極限（完備性。極限の存在は主張しない）」（$0\le\nu_L\le2$ の有界性を今 tick の定義と主張から引き、$\mathbb R$ の完備性で $\limsup$・$\liminf$ を定義する。`def_open_square_free_energy_density` の $\sup$ の書き方（住処 R、`realEscape` は完備性）に揃える。Lean は `Filter.limsup`／`liminf` か、$\sup_{L\ge N}$ の下限として自前で書くかを着手時に決める）。

- **2026-08-17 の tick 379 は、台帳の先頭行「零点密度: 有限格子の Fisher 零点の有理円板内の個数 $N_L(c,r):=\lvert\mathcal F_L\cap D(c,r)\rvert\in\mathbb N$」を本文・Lean 具体版まで書いて閉じた（定義ブロックなので必要十分版と SageMath は置かない。住処 Qbar、脱出なし）。**
  `def_fisher_zero_count_in_rational_disc`（`claim_fisher_zero_set_finite_card_bound` の直後・「この先に書くこと」の直前、住処 Qbar）: $L\ge1$、$c\in\mathbb Q\times\mathbb Q$、$r\in\mathbb Q_{>0}$ で、$\mathcal F_L\cap D(c,r)$ は有限集合 $\mathcal F_L$（`claim_fisher_zero_set_finite_card_bound`）の部分集合なので有限集合、$N_L(c,r):=\lvert\mathcal F_L\cap D(c,r)\rvert\in\mathbb N$。定義の中に $N_L(c,r)\le\lvert\mathcal F_L\rvert$（有限集合の部分集合の元の個数は全体以下）を置いた（次の $\nu_L\le2$ が引く）。本文末尾「この先に書くこと」の零点密度の内訳から「$N_L(c,r)$」を消した。
  Lean 具体版 `ThermodynamicLimit/FisherZeroCountInRationalDisc.lean`（`fisherZeroSet_inter_rationalDisc_finite`（`Set.Finite.subset`）・`fisherZeroCountInRationalDisc`（`Set.ncard`）・`fisherZeroCountInRationalDisc_le_ncard`（`Set.ncard_le_ncard`））。sorry 検査 1316 件。check 468 ブロック・verify-check-linkage 259 件・PDF 255 ページ通過。
  式変形統一: 姉妹側「転送行列」（`004_transfer_matrix.ts`）の $\mathbf{end}$ の構成の証明 Step 4 で、散文中の $(\sum_I\Theta_{I,I})(f_K)=\sum_I\delta_{I,K}f_I=f_K$ を一続き四段（線型写像の和の値／$\Theta_{I,J}$ の定義／$\delta_{I,K}$／恒等写像の定義。行末根拠つき）へ揃えた（内容は不変）。姉妹側の check・PDF 323 ページ通過。
  レビュー: 前 tick の `claim_fisher_zero_set_finite_card_bound` の本文（背理法の一続き二段・有限集合自身への適用）と Lean 具体版（`fisherZeroSet_finite_ncard_le` の `exists_subset_card_eq`・`omega`・`ncard_eq_toFinset_card`）を突き合わせて一致。修正なし。次は「格子点数あたりの零点数 $\nu_L(c,r):=N_L(c,r)/L^2\in\mathbb Q$ と上界 $\nu_L\le2$」（$N_L\le\lvert\mathcal F_L\rvert\le2L^2$ を $L^2>0$ で割る一続き。Lean は `(fisherZeroCountInRationalDisc L data c r : ℚ) / (L^2 : ℚ)`）。


- **2026-08-17 の tick 378 は、台帳の先頭行「零点密度: $\mathcal F_L$ は有限集合で $\lvert\mathcal F_L\rvert\le2L^2$」を本文・SageMath・Lean（具体版・必要十分版（1 の冪根の場合と共有）・導出版）まで書いて四層で閉じた（背理法。`claim_root_of_unity_finite_card_bound` と同じ形。住処 Qbar、脱出なし）。**
  `claim_fisher_zero_set_finite_card_bound`（`claim_fisher_zero_finset_card_bound` の直後・「この先に書くこと」の直前、住処 Qbar）: $L\ge1$ で $\mathcal F_L$ は有限集合、$\lvert\mathcal F_L\rvert\le2L^2$。証明は背理法（無限なら $\lvert S\rvert=2L^2+1$ の有限部分集合 $S$ があり、`claim_fisher_zero_finset_card_bound` の $\lvert S\rvert\le2L^2$ と一続き二段で矛盾）と、有限になった $\mathcal F_L$ 自身を同じ主張に当てて上界。本文末尾「この先に書くこと」の零点密度の内訳から「$\mathcal F_L$ の有限性」を消した。
  SageMath `check/fisher-zero-set-finite-card-bound/`（$L\le3$、$\lvert\mathcal F_L\rvert=0,8,12$ を `QQbar` の相異なる根として厳密に列挙、12 秒）。Lean 具体版 `ThermodynamicLimit/FisherZeroSetFiniteCardBound.lean`（`fisherZeroSet_finite_ncard_le`。`Set.Finite`・`Set.ncard`、`rootOfUnityFiniteCardLe` と同じ道具）、必要十分版は `NecSuf/AlgebraicEigenvalue/RootOfUnityFiniteCardBound.lean` の `finite_ncard_le_of_finset_card_le_necSuf` を共有（元の型に構造を要求しない）、導出版 `FisherZeroSetFiniteCardBoundFromNecSuf.lean`。sorry 検査 1314 件。check 467 ブロック・verify-check-linkage 259 件・PDF 254 ページ通過。
  式変形統一: 姉妹側「Frobenius 内積の性質」の Step 6（三角不等式）で、散文に置かれていた「$\iota_{\mathbb R\to\mathbb C}$ の単射性により実数の等式 $\|A+B\|^2=\|A\|^2+2\mathrm{Re}(u)+\|B\|^2$」を、続く不等式の鎖の第 1 段（行末根拠つき）へ取り込み、鎖を $\|A+B\|^2$ から $(\|A\|+\|B\|)^2$ まで一続き四段にした（内容は不変）。姉妹側の check・PDF 323 ページ通過。
  レビュー: 前 tick の `claim_fisher_zero_finset_card_bound` の本文（準備・三つの仮定・一続きの鎖）と Lean 具体版（`partitionPolynomial_coeff`・`_ne_zero`・`_coeff_eq_zero_of_lt`・`fisherZeroSet_finset_card_le` の `hroot`）・SageMath を突き合わせて一致。修正なし。次は「有限格子の Fisher 零点の有理円板内の個数 $N_L(c,r):=\lvert\mathcal F_L\cap D(c,r)\rvert\in\mathbb N$」（定義ブロック。$\mathcal F_L\cap D(c,r)\subset\mathcal F_L$ は有限集合の部分集合なので有限で、個数は今 tick の主張から $2L^2$ 以下。Lean は `Set.ncard (FisherZeroSet L ∩ rationalDisc c r)` と `Set.Finite.subset`）。



- **2026-08-17 の tick 377 は、台帳の先頭行「零点密度: 有限格子の Fisher 零点の有限部分集合の個数は $2L^2$ を超えない」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた（`claim_qbar_distinct_roots_card_bound` の三つの仮定を順に確かめる形。住処 Qbar、脱出なし）。**
  `claim_fisher_zero_finset_card_bound`（`claim_integer_polynomial_qbar_lift_evaluation` の直後・「この先に書くこと」の直前、住処 Qbar）: $L\ge1$、有限部分集合 $S\subset\mathcal F_L$ で $\lvert S\rvert\le2L^2$。証明は準備（`claim_coefficient_representation` から $\mathrm{ac}_k(\widehat{Z_L}^{\,F})=\Omega_L(k)$（$k\le2L^2$）、$0$（$2L^2<k$））、第 1 の仮定 $\widehat{Z_L}^{\,F}\ne0$（零なら $\Omega_L(m)=0$ の一続き三段、`claim_coefficient_sum` の $2^{L^2}=\sum\Omega_L(m)=0$ の一続き三段で矛盾）、第 2 の仮定（準備の下の場合）、第 3 の仮定（$w\in S\subset\mathcal F_L$ で $\mathrm{aev}_w(\widehat{Z_L}^{\,F})=\mathrm{Ev}^F_w(Z_L)=0$ の一続き二段）、`claim_qbar_distinct_roots_card_bound` を当てる。本文末尾「この先に書くこと」の零点密度の内訳から「有限部分集合の個数の上界」を消した。
  SageMath `check/fisher-zero-finset-card-bound/`（$L\le3$、$\lvert\mathcal F_L\rvert=0,8,12$、準備の係数・第 1〜第 3 の仮定・部分集合 117 組。`ZZ[x]`・`QQbar` の厳密計算、13 秒）。Lean 具体版 `ThermodynamicLimit/FisherZeroFinsetCardBound.lean`（`partitionPolynomial_coeff`（`claim_coefficient_representation` を係数ごとに読む）・`integerPolynomialQbarLift_partitionPolynomial_ne_zero`・`integerPolynomialQbarLift_partitionPolynomial_coeff_eq_zero_of_lt`・`fisherZeroSet_finset_card_le`（`qbarDistinctRootsCardLe` を当てる））、必要十分版 `NecSuf/ThermodynamicLimit/FisherZeroFinsetCardBound.lean`（`finset_card_le_of_subset_root_set_necSuf`。零元・根・上界は述語で受け取り、個数の上界も仮定として受け取る。構造は係数の有限和のための `AddCommMonoid` だけ）、導出版 `FisherZeroFinsetCardBoundFromNecSuf.lean`。sorry 検査 1312 件。check 466 ブロック・verify-check-linkage 258 件・PDF 254 ページ通過。
  式変形統一: 姉妹側「Frobenius 内積の性質」の Step 6（三角不等式）で、散文中の「$\iota_{\mathbb R\to\mathbb C}$ の単射性により実数の等式 $\|A+B\|^2=\|A\|^2+2\mathrm{Re}(u)+\|B\|^2$」の手前にあった $\mathbb C$ 側の等式の組み立てを一続き三段（$(\|A+B\|^2)_{\mathbb C}=(\|A\|^2)_{\mathbb C}+(u+\overline u)+(\|B\|^2)_{\mathbb C}=(\|A\|^2)_{\mathbb C}+(2\mathrm{Re}(u))_{\mathbb C}+(\|B\|^2)_{\mathbb C}=(\|A\|^2+2\mathrm{Re}(u)+\|B\|^2)_{\mathbb C}$。行末根拠つき）へ揃えた（内容は不変）。姉妹側の check・PDF 323 ページ通過。
  レビュー: 前 tick の `claim_integer_polynomial_qbar_lift_evaluation` の本文（準備・一続き三段）と Lean 具体版（`integerPolynomialQbarLift_coeff_eq_zero_of_natDegree_lt`・`qbarPolyEval_integerPolynomialQbarLift` の `calc` 三段）・SageMath を突き合わせて一致。修正なし。次は「$\mathcal F_L$ は有限集合で $\lvert\mathcal F_L\rvert\le2L^2$」（背理法。`claim_root_of_unity_finite_card_bound` と同じ形: 有限部分集合の個数がすべて $2L^2$ 以下なら集合は有限で個数も $2L^2$ 以下。Lean は `Set.Finite` と `Set.ncard`——`claim_root_of_unity_finite_card_bound` の Lean（`rootOfUnityFiniteCardLe`）を見て同じ道具を使う）。







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
| 熱力学極限 | 零点密度: 重複度付きの個数への精密化（$\overline{\mathbb Q}[x]$ での根の重複度の定義から） | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録
- 2026-08-17（tick 381）: 台帳の先頭行「零点密度: $(\nu_L(c,r))_{L\ge1}$ の上極限と下極限（実数体への脱出: 完備性）」を本文・Lean 具体版で閉じ、`def_fisher_zero_density_limsup_liminf` を `claim_fisher_zero_density_in_rational_disc_le_two` の直後に置いた（定義ブロック。必要十分版・SageMath は無し）。sorry 検査 1333 件。式変形統一: 姉妹側「Frobenius 内積の性質」（`005_exp_conjugation_proof.ts`）の Step 6（三角不等式）の末尾で、散文「両辺とも非負なので平方の単調性により $\|A+B\|\le\|A\|+\|B\|$」を含意の鎖二段（$\|A+B\|^2\le(\|A\|+\|B\|)^2\Longrightarrow\|A+B\|\le\|A\|+\|B\|$。行末根拠つき）へ揃えた（内容は不変）。姉妹側の check・PDF 323 ページ通過。
- 2026-08-17（tick 380）: 台帳の先頭行「零点密度: 格子点数あたりの零点数 $\nu_L(c,r)$ と上界 $\nu_L\le2$」を定義ブロック `def_fisher_zero_density_in_rational_disc` と主張ブロック `claim_fisher_zero_density_in_rational_disc_le_two` に分けて四層で閉じ、`def_fisher_zero_count_in_rational_disc` の直後に置いた（一ブロック一主張のため二つにした。論法は一つ）。SageMath 18 検査（$L\le2$）、Lean 具体版・必要十分版（順序体）・導出版、sorry 検査 1321 件。式変形統一: 姉妹側「Frobenius 内積の性質」の Cauchy--Schwarz 場合 2 の散文「$|u|^2/\|B\|^2\le\|A\|^2$（$\mathbb R$ の移項）」を一続き三段へ（姉妹側 check・PDF 323 ページ通過）。
- 2026-08-17（tick 379）: 台帳の先頭行「零点密度: 有限格子の Fisher 零点の有理円板内の個数 $N_L(c,r)$」を本文・Lean 具体版で閉じ、`def_fisher_zero_count_in_rational_disc` を `claim_fisher_zero_set_finite_card_bound` の直後に置いた（定義ブロック。必要十分版・SageMath は無し）。sorry 検査 1316 件。式変形統一: 姉妹側「転送行列」の `end` の構成の証明 Step 4 で、散文中の $(\sum_I\Theta_{I,I})(f_K)=\sum_I\delta_{I,K}f_I=f_K$ を一続き四段（行末根拠つき）へ揃えた（内容は不変。姉妹側 check・PDF 323 ページ通過）。
- 2026-08-17（tick 378）: 台帳の先頭行「零点密度: $\mathcal F_L$ は有限集合で $\lvert\mathcal F_L\rvert\le2L^2$」を四層で閉じ、`claim_fisher_zero_set_finite_card_bound` を `claim_fisher_zero_finset_card_bound` の直後に置いた。SageMath（$L\le3$）、Lean 具体版・必要十分版（1 の冪根の場合と共有）・導出版、sorry 検査 1314 件。式変形統一: 姉妹側「Frobenius 内積の性質」の Step 6 の実数の等式を不等式の鎖の第 1 段へ取り込み一続き四段へ（姉妹側 check・PDF 323 ページ通過）。
- 2026-08-17（tick 377）: 台帳の先頭行「零点密度: 有限格子の Fisher 零点の有限部分集合の個数は $2L^2$ を超えない」を四層で閉じ、`claim_fisher_zero_finset_card_bound` を `claim_integer_polynomial_qbar_lift_evaluation` の直後に置いた。SageMath 117 組、Lean 具体版・必要十分版・導出版、sorry 検査 1312 件。式変形統一: 姉妹側「Frobenius 内積の性質」の Step 6 の $\mathbb C$ 側の等式の組み立てを一続き三段へ（姉妹側 check・PDF 323 ページ通過）。



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
- 2026-08-17（tick 381）: 前 tick の「有理円板内の格子点数あたりの Fisher 零点数」の定義と「$2$ を超えない」の本文（一続き四段）と Lean 具体版（`calc` 四段）を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick は定義ブロックで、独立の主張ブロックは足していない。尾部の像が空でなく有界であること・$0\le s_N$・$i_N\le2$ は上限・下限が定まるための well-defined 性（住処の確定）なので定義の中に置いた。本文末尾「この先に書くこと」から済んだ項目を消し、台帳のセクション表（先頭行を消した）と揃えた。式変形統一: 姉妹側「Frobenius 内積の性質」（`005_exp_conjugation_proof.ts`）の Step 6（三角不等式）の末尾で、散文「両辺とも非負なので平方の単調性により $\|A+B\|\le\|A\|+\|B\|$」を含意の鎖二段（$\|A+B\|^2\le(\|A\|+\|B\|)^2\Longrightarrow\|A+B\|\le\|A\|+\|B\|$。行末根拠つき）へ揃えた（内容は不変）。姉妹側の check・PDF 323 ページ通過。
- 2026-08-17（tick 380）: 前 tick の「有理円板内の有限格子の Fisher 零点の個数」の本文と Lean 具体版を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の上界 $\nu_L\le2$ は「正の数で割っても不等号が保たれる」だけで出るが、上界が $L,c,r$ によらないこと（列の有界性）が次の上極限・下極限の存在の根拠になり後で引く形なので、独立ブロックとして残す。$0<L^2$ と $0\le\nu_L$ は独立ブロックにせず、証明の冒頭と定義の中（住処の確定）に置いた。本文末尾「この先に書くこと」から済んだ項目を消し、台帳のセクション表（先頭行を消した）と揃えた。
- 2026-08-17（tick 379）: 前 tick の「有限格子の Fisher 零点の全体は有限集合であり元の個数は $2L^2$ を超えない」の本文（背理法の一続き二段・有限集合自身への適用）と Lean 具体版を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の定義は、$N_L(c,r)$ の住処 $\mathbb N$ の確定（有限性）と、次の $\nu_L\le2$ が引く $N_L\le\lvert\mathcal F_L\rvert$ を含む（後で引く形）ので残す。有限性の根拠（有限集合の部分集合は有限）は独立ブロックにせず定義の中に置いた。本文末尾「この先に書くこと」から済んだ項目を消し、台帳のセクション表（先頭行を消した）と揃えた。
- 2026-08-17（tick 378）: 前 tick の「有限格子の Fisher 零点の有限部分集合の個数は $2L^2$ を超えない」の本文（準備・三つの仮定・一続きの鎖）と Lean 具体版・SageMath を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の有限性と上界は、次の $N_L(c,r)\in\mathbb N$ と $\nu_L(c,r)\le2$ が引く（後で引く形。集合が有限であるという住処の確定でもある）ので残す。本文末尾「この先に書くこと」から済んだ項目を消し、台帳のセクション表（先頭行を消した）と揃えた。
- 2026-08-17（tick 377）: 前 tick の「持ち上げの値は整係数多項式の代数的数における値に一致する」の本文（準備・一続き三段）と Lean 具体版（`calc` 三段）・SageMath を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の上界は、`claim_qbar_distinct_roots_card_bound` の三つの仮定を $\widehat{Z_L}^{\,F}$ について確かめる主張であり、次の $\mathcal F_L$ の有限性と $N_L(c,r)\in\mathbb N$ が引く（後で引く形）ので残す。準備の $\mathrm{ac}_k(\widehat{Z_L}^{\,F})=\Omega_L(k)$ は独立ブロックにせず証明の冒頭に置いた。本文末尾「この先に書くこと」から済んだ項目を消し、台帳のセクション表（先頭行を消した）と揃えた。

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

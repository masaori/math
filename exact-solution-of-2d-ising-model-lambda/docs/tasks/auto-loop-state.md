# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-17 の tick 360 は、台帳の先頭行「有理係数の対数順序群の実現写像は順序を保つ（実数体への脱出: 実対数）」を論法の数で四行へ割り、その最初「実数体と実対数、および実現写像 $\rho_{\mathbb R}$ の定義（実数体への脱出: 実対数）」を本文・Lean まで書いた（定義のみ。SageMath 検証は定義には置かない）。**
  `def_real_logarithm`（本文で初めて住処 R を宣言。$\mathbb R$ は $\mathbb Q$ を部分体として含む順序体、包含 $\iota_{\mathbb Q\to\mathbb R}$ に名前を置いて有理数を実数として読むときは必ず通す、$\mathbb R_{>0}$、実対数 $\log_{\mathbb R}:\mathbb R_{>0}\to\mathbb R$。使う性質は乗法を加法へ移すことと狭義単調（したがって $u\le v\Rightarrow\log u\le\log v$）の二つだけと宣言。級数・微分・完備性は使わない。`realEscape` は「実対数」）と `def_rational_log_order_group_realization`（$\rho_{\mathbb R}(\mu):=\sum_{p\in\operatorname{supp}\mu}\iota_{\mathbb Q\to\mathbb R}(\mu(p))\cdot\log_{\mathbb R}(\iota_{\mathbb Q\to\mathbb R}(p))$。$\mu(p)=0$ の項が $0$ なので台を含む任意の有限集合に渡る和で同じ値。`realEscape` は「実対数」）。いずれも `claim_open_square_density_lower_set_le_upper_bound` の直後・`remark_real_escape_plan` の直前。`remark_real_escape_plan` の冒頭「ここまで実数体は現れていない」を「直前の二つの定義を除き」に直し、脱出の項に両定義への参照を足した。
  Lean `ThermodynamicLimit/RationalLogOrderGroupRealization.lean`（`PositiveReal`・`realLog`・`realLog_mul`（`Real.log_mul`）・`realLog_lt_realLog`（`Real.log_lt_log`）・`realLog_le_realLog`・`primePositiveReal`・`realizeRational`（`Finsupp.sum`）・`realizeRational_eq_sum_support`（`rfl`）。定義ブロックなので必要十分版は無い）。入口 import・sorry 検査へ 4 件登録（計 1346 件）。check 450 ブロック・PDF 243 ページ通過。
  割り方: 「実対数と実現写像の定義」→「実現写像は有理数倍と可換（$\rho_{\mathbb R}(r\cdot\mu)=\iota_{\mathbb Q\to\mathbb R}(r)\rho_{\mathbb R}(\mu)$。$\mathbb R$ の分配則を有限和へ）」→「$\Lambda$ の元の実現は $\mathrm{rat}_\Lambda$ の実対数（$\rho_{\mathbb R}(\iota_{\Lambda\to\Lambda_{\mathbb Q}}(\lambda))=\log_{\mathbb R}(\iota_{\mathbb Q\to\mathbb R}(\mathrm{rat}_\Lambda(\lambda)))$。台の大きさについての帰納法、積の対数と整数冪の対数）」→「実現写像は順序を保つ（共通分母 $N$ で $\lambda_N\le_\Lambda\mu_N$、$\mathrm{rat}_\Lambda$ の比較、実対数の単調性、前二行、$N>0$ で割る）」。
  レビュー: 前 tick が台帳から外した tick 354 の記録が保管庫へ移されていなかったので復元した（本文の修正は無い）。次は「実現写像は有理数倍と可換」。


- **2026-08-17 の tick 359 は、台帳の先頭行「開境界正方形の密度の下組の元は密度の上からの評価以下」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_open_square_density_lower_set_le_upper_bound`（`claim_open_square_density_lower_set_nonempty` の直後・`remark_real_escape_plan` の直前、住処 Lambda）: $q\in\mathbb Q_{>0}$、$\mu\in A^{\mathrm{op}}(q)$ なら $\mu\le_{\Lambda_{\mathbb Q}}\iota(\ell_2)+2\iota(\log(1+q))$（`claim_open_square_free_entropy_density_upper_bound` の右辺）。仮定は $q>0$ だけで $q\le1$ は要らない（台帳の行名の「$0<q\le1$」は外した）。証明は所属の証人 $\varepsilon,N$ を取り $L:=N$ で読む一続き五段（$\mu=0+\mu$（単位元）$\le\varepsilon+\mu$（`claim_rational_log_order_group_add_monotone` を $\lambda:=0,\mu:=\varepsilon,\nu:=\mu$ で）$=\mu+\varepsilon$（交換則）$\le\Psi^{\mathrm{op}}_N(q)$（証人の性質）$\le$ 上界（密度の上からの評価））と推移律。$\varepsilon\ne0$ は使わない。`remark_real_escape_plan` の脱出の項に「上に有界であること」への参照を足した。
  SageMath `check/open-square-density-lower-set-le-upper-bound/`（$q$ 8 値、$L\le4$、$\mu$ は空でないことの証人とそれ以下の三つ、別の証人 $(\frac12\iota(\ell_2),2)$ の元。244 検査、4 秒。順序の決定手続きの共通分母を分母の積から最小公倍数へ変えた——積だと $\Psi^{\mathrm{op}}_L(q)$ どうしの比較で指数が $16^{10}$ 程度になり 5 分超で実行不能。`claim_common_denominator_multiple` により結果は変わらない）。Lean 具体版 `ThermodynamicLimit/OpenSquareDensityLowerSetLeUpperBound.lean`（`rationalLogOrderLE_upperBound_of_mem_openSquareDensityLowerSet`。`rationalLogOrderLE_add_right`・`zero_add`・`add_comm`・`openSquareDensitySequence_of_ne_zero`・`rationalLogOrderLE_openScaledFreeEntropy_upperBound`・`rationalLogOrderLE_trans`）、必要十分版 `NecSuf/ThermodynamicLimit/OpenSquareDensityLowerSetLeUpperBound.lean`（`le_bound_of_mem_lowerSetOfSequence_necSuf`。`[Add X] [Zero X]`、推移律・右加法単調性・単位元 $0+x=x$・交換則・列の項の上界だけ。$\varepsilon\ne0$ も逆元も有理数倍も使わない）、導出版。sorry 検査 1342 件。前 tick のレビューでは修正なし。次は「有理係数の対数順序群の実現写像は順序を保つ（実数体への脱出: 実対数）」。


- **2026-08-17 の tick 358 は、台帳の先頭行「開境界正方形の密度の下組は空でない」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `def_open_square_density_lower_set`（$A^{\mathrm{op}}(q):=A((\Psi^{\mathrm{op}}_L(q))_{L\ge1})\subset\Lambda_{\mathbb Q}$。後の段が繰り返し引くので名前を置いた）と `claim_open_square_density_lower_set_nonempty`（$-\iota(\ell_2)\in A^{\mathrm{op}}(q)$。いずれも `claim_rational_log_order_group_sequence_lower_set_downward_closed` の直後・`remark_real_escape_plan` の直前、住処 Lambda）。仮定は $q\in\mathbb Q_{>0}$ だけで、$q\le1$ は要らない（密度の非負が $q>0$ で成り立つため。台帳の行名の「$0<q\le1$」は外した）。証明は準備二つ（$0\le\iota(\ell_2)$ は `claim_rational_embedded_log_order_iff` を $(1,2)$ で読む既出の鎖、$\iota(\ell_2)\ne0$ は $\ell_2(2)=1\ne0$ と `claim_rational_log_order_group_embedding` の単射性）と、証人 $\varepsilon:=\iota(\ell_2)$、$N:=1$ で一続き三段（$\varepsilon$ の定義、逆元律、`claim_open_square_free_entropy_density_nonnegative`）。`remark_real_escape_plan` の脱出の項に $A^{\mathrm{op}}(q)$ と空でないことへの参照を足した。
  SageMath `check/open-square-density-lower-set-nonempty/`（$q$ 8 値、$L\le4$。一辺 4 は行ごとの動的計画法で一辺 1〜3 の全列挙と一致を確認。141 検査、10 秒）。Lean 具体版 `ThermodynamicLimit/OpenSquareDensityLowerSetNonempty.lean`（`openSquareDensityLowerSet`・`mem_…_iff`・`toRational_generator_two_ne_zero`・`neg_toRational_generator_two_mem_openSquareDensityLowerSet`・`openSquareDensityLowerSet_nonempty`）、必要十分版 `NecSuf/ThermodynamicLimit/OpenSquareDensityLowerSetNonempty.lean`（`neg_mem_lowerSetOfSequence_of_nonneg_necSuf`。`[Add X] [Zero X] [Neg X]`、正の元 $\varepsilon$ とその逆元律 $-\varepsilon+\varepsilon=0$ だけ、列の非負を仮定として受ける。推移律も加法単調性も使わない）、導出版。sorry 検査 1339 件。前 tick のレビューでは修正なし。次は「開境界正方形の密度の下組の元は密度の上からの評価以下」。


- **2026-08-17 の tick 357 は、台帳の先頭行「切断による実数体への一度きりの脱出」を論法の数で五行へ割り、その最初「列が定める下組（$\Lambda_{\mathbb Q}$ の中）と下に閉じていること」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `def_rational_log_order_group_sequence_lower_set`（$\Lambda_{\mathbb Q}$ の列 $(\lambda_L)_{L\ge1}$ が定める下組 $A:=\{\mu\in\Lambda_{\mathbb Q}\mid\exists\varepsilon\,(0\le\varepsilon,\ \varepsilon\ne0)\ \exists N\ge1\ \forall L\ge N:\ \mu+\varepsilon\le_{\Lambda_{\mathbb Q}}\lambda_L\}$。可算集合の部分集合。極限も完備性も実対数も参照しない）と `claim_rational_log_order_group_sequence_lower_set_downward_closed`（$\mu\in A$、$\mu'\le\mu\Rightarrow\mu'\in A$。いずれも `claim_open_square_density_sequence_cauchy_le_one` の直後・`remark_real_escape_plan` の直前、住処 Lambda）。証明は $\mu$ の証人 $\varepsilon,N$ をそのまま引き継ぎ、$\mu'+\varepsilon\le\mu+\varepsilon$（`claim_rational_log_order_group_add_monotone`）$\le\lambda_L$（証人の性質）、推移律の二段だけ。
  あわせて `remark_real_escape_plan` の脱出の項を「$\mathbb Q$ 上の切断」から「$\Lambda_{\mathbb Q}$ の下組とその補集合の組（$\Lambda_{\mathbb Q}$ の切断）を素数の実対数で実現し、下組の実現像の上限として実数を取る」に書き直した（$\Lambda_{\mathbb Q}\not\subset\mathbb Q$ なので $\mathbb Q$ の切断は直接には作れない。脱出の位置は変わらない。理由は「実対数」と「完備性（上限の存在）」の二つになる）。
  SageMath `check/rational-log-order-group-sequence-lower-set/`（列 $\iota(\ell_2)+\frac1L\iota(\ell_3)$、所属する例・しない例、$\mu'\le\mu$ の 77 件で二段と所属、$L\le40$。4 秒）。Lean 具体版 `ThermodynamicLimit/RationalLogOrderGroupSequenceLowerSet.lean`（`rationalLogOrderSequenceLowerSet`・`mem_…_iff`・`mem_…_of_le`），必要十分版 `NecSuf/ThermodynamicLimit/RationalLogOrderGroupSequenceLowerSet.lean`（`lowerSetOfSequence`・`mem_lowerSetOfSequence_of_le_necSuf`。`[Add X] [Zero X]` と推移律・右加法単調性だけ。`Zero` は $0\le\varepsilon$ を述べる名前としてだけ要る）、導出版（下組の一致は `rfl`）。sorry 検査 1333 件。
  割り方: 「下組と下に閉じていること」→「開境界正方形の密度の下組は空でない」→「開境界正方形の密度の下組の元は密度の上からの評価以下」→「有理係数の対数順序群の実現写像は順序を保つ（脱出: 実対数）」→「下組の実現像の上限として開境界正方形の自由エネルギー密度を定める（脱出: 完備性）」。前 tick のレビューでは修正なし。次は「開境界正方形の密度の下組は空でない」。


- **2026-08-17 の tick 356 は、台帳の先頭行「密度の列の Cauchy 性（$0<q\le1$）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_open_square_density_sequence_cauchy_le_one`（`claim_open_square_density_difference_bound_core_nonneg_le_one` の直後・`remark_real_escape_plan` の直前、住処 Lambda）: $0<q\le1$ で列 $(\Psi^{\mathrm{op}}_L(q))_{L\ge1}$ は `def_rational_log_order_group_cauchy_sequence` の Cauchy 列。証明は準備三つ（核の非負から Archimedes 性で $\Gamma(q)\le n\varepsilon$ の $n$、$a:=n+2$、$N:=a^2$（$\mathbb N$ の事実 $a\ge1$、$n\le a$、$a<a^2$、$N\ge1$）／$N\le L,M$ から $a<L,M$、$a^2\le L,M$／`claim_rational_log_order_group_div_ge_multiplier_le` で $\frac1a\Gamma(q)\le\varepsilon$）と、上端一続き三段（差の上からの評価 $\le R_a$、核の等式で $=\frac1a\Gamma(q)$、$\le\varepsilon$）・下端一続き三段（逆元の順序反転で $-\varepsilon\le-\frac1a\Gamma(q)$、$=-R_a$、差の下からの評価）。完備性も極限の値も使わない。`remark_real_escape_plan` の Cauchy の項をこの主張への参照に書き換え、本文末尾の「この先に書くこと」から Cauchy 性を消した。
  SageMath `check/open-square-density-sequence-cauchy/`（$q\in\{1,\frac12,\frac23\}$、$n=1$・$a=3$・$N=9$ になる $\varepsilon$、$L,M\in\{9,10\}$。105 検査、35 秒。一辺 9 以上の分配関数は行ごとの動的計画法で計算し一辺 2, 3 で全列挙と一致を確認、$\Lambda_{\mathbb Q}$ の元は素因数分解を避けて「正の有理数の対数の形式和」で持ち、順序は共通分母を掛けて $\mathrm{rat}_\Lambda$ で比べる。理由は overview に記した）。Lean 具体版 `ThermodynamicLimit/OpenSquareDensitySequenceCauchy.lean`（`openSquareDensitySequence`（$L=0$ で $0$。定義は $L\ge1$ しか見ない）、`openSquareDensitySequence_of_ne_zero`、`isCauchyRationalLogOrder_openSquareDensitySequence_of_le_one`），
  必要十分版 `NecSuf/ThermodynamicLimit/OpenSquareDensitySequenceCauchy.lean`（`cauchy_of_uniform_difference_bounds_necSuf`。`[Zero X] [Neg X] [SMul ℚ X]` と推移律・逆元の順序反転・核の等式・差の上下の一様な評価・核の Archimedes 性・倍率以上で割る評価を仮定として受けるだけ。加法も群の公理も順序の線形性も要らない。$a:=n+2$、$N:=a^2$ は $\mathbb N$ のまま）、導出版。sorry 検査 1329 件。
  前 tick のレビューでは修正なし。次は「切断による実数体への一度きりの脱出」。


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
- 熱力学極限: 75 セクション
- 全章（何も言っていない主張の一掃）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 実現写像は有理数倍と可換（実数体への脱出: 実対数） | todo | $r\in\mathbb Q$、$\mu\in\Lambda_{\mathbb Q}$ で $\rho_{\mathbb R}(r\cdot\mu)=\iota_{\mathbb Q\to\mathbb R}(r)\cdot\rho_{\mathbb R}(\mu)$。$\operatorname{supp}(r\cdot\mu)\subset\operatorname{supp}(\mu)$ で和を $\operatorname{supp}(\mu)$ に揃え、$\iota_{\mathbb Q\to\mathbb R}$ が乗法を保つこと、$\mathbb R$ の分配則を有限和へ。Lean は `Finsupp.sum_smul_index'`・`Finset.mul_sum`。住処 R |
| 熱力学極限 | 対数順序群の元の実現は $\mathrm{rat}_\Lambda$ の実対数である（実数体への脱出: 実対数） | todo | $\lambda\in\Lambda$ で $\rho_{\mathbb R}(\iota_{\Lambda\to\Lambda_{\mathbb Q}}(\lambda))=\log_{\mathbb R}(\iota_{\mathbb Q\to\mathbb R}(\mathrm{rat}_\Lambda(\lambda)))$。台の大きさの帰納法、積の対数（`def_real_logarithm`）、整数冪の対数 $\log_{\mathbb R}(u^k)=k\log_{\mathbb R}(u)$（$k\in\mathbb Z$。乗法を加法へ移すことから帰納法で導く。別ブロックにするなら先に置く）。Lean は `Real.log_prod`・`Real.log_zpow`。住処 R |
| 熱力学極限 | 有理係数の対数順序群の実現写像は順序を保つ（実数体への脱出: 実対数） | todo | $\lambda\le_{\Lambda_{\mathbb Q}}\mu\Rightarrow\rho_{\mathbb R}(\lambda)\le\rho_{\mathbb R}(\mu)$。共通分母 $N$ で $\lambda_N\le_\Lambda\mu_N$、$\mathrm{rat}_\Lambda(\lambda_N)\le\mathrm{rat}_\Lambda(\mu_N)$（$\mathbb Q$）、$\iota_{\mathbb Q\to\mathbb R}$ の順序保存、実対数の単調性、前二行で $N\rho_{\mathbb R}(\lambda)\le N\rho_{\mathbb R}(\mu)$、$N>0$ で割る。住処 R |
| 熱力学極限 | 下組の実現像の上限として開境界正方形の自由エネルギー密度を定める（実数体への脱出: 完備性） | todo | $f^{\mathrm{op}}(q):=\sup\rho_{\mathbb R}(A)$。空でない・上に有界（前二行と順序保存）から上限の存在。住処 R、`realEscape` 必須。定義したら `remark_real_escape_plan` の題名から「まだ書いていない」を外す |
| 熱力学極限 | 削除した実数値経路の Lean の後片付け | todo | 2026-08-16 に本文から消した実数値経路（実対数・上限／下限による極限）の Lean ファイルが孤立して残っている。入口からの import と sorry 検査は通るが、対応する本文が無いので消す |
| 熱力学極限 | 周期境界自由エネルギー密度への移送 | todo | 周期境界と開境界の境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録

- 2026-08-17（tick 360）: 台帳の先頭行「有理係数の対数順序群の実現写像は順序を保つ」は、実対数と実現写像の定義、有理数倍との可換性（分配則）、$\Lambda$ の元の実現が $\mathrm{rat}_\Lambda$ の実対数であること（帰納法）、順序の保存（共通分母と単調性）の四つの論法を含むので四行へ割った。その最初「実数体と実対数、および実現写像の定義」を実行し、`def_real_logarithm` と `def_rational_log_order_group_realization` を `claim_open_square_density_lower_set_le_upper_bound` の直後に置いた（本文で初めての住処 R。脱出理由は実対数）。
  Lean `ThermodynamicLimit/RationalLogOrderGroupRealization.lean` を書き、入口 import・sorry 検査へ 4 件登録（計 1346 件）。定義ブロックなので SageMath 検証と必要十分版は無い。`remark_real_escape_plan` の冒頭と脱出の項を両定義に合わせて直した。式変形統一は一時停止中のため実施せず。


- 2026-08-17（tick 359）: 台帳の先頭行「開境界正方形の密度の下組の元は密度の上からの評価以下」を実行し、`claim_open_square_density_lower_set_le_upper_bound` を `claim_open_square_density_lower_set_nonempty` の直後に置いた。行名の「$0<q\le1$」は、密度の上からの評価が $q>0$ で成り立ち $q\le1$ を使わないので外した。
  証明は所属の証人を $L:=N$ で読む一続き五段（単位元・加法単調性・交換則・証人の性質・密度の上からの評価）と推移律だけ。SageMath `open-square-density-lower-set-le-upper-bound`（順序の決定手続きの共通分母は最小公倍数で取る）、Lean 具体版・必要十分版（`Add`・`Zero`、推移律・右加法単調性・単位元・交換則・列の上界だけ）・導出版を書き、入口 import・sorry 検査へ 3 件登録（計 1342 件）。式変形統一は一時停止中のため実施せず。


- 2026-08-17（tick 358）: 台帳の先頭行「開境界正方形の密度の下組は空でない」を実行し、`def_open_square_density_lower_set` と `claim_open_square_density_lower_set_nonempty` を `claim_rational_log_order_group_sequence_lower_set_downward_closed` の直後に置いた。行名の「$0<q\le1$」は、密度の非負が $q>0$ で成り立ち $q\le1$ を使わないので外した。
  証明は準備二つ（$\iota(\ell_2)$ の非負と非零）と、証人 $\varepsilon:=\iota(\ell_2)$、$N:=1$ での一続き三段だけ。SageMath `open-square-density-lower-set-nonempty`、Lean 具体版・必要十分版（`Add`・`Zero`・`Neg`、正の元一つとその逆元律、列の非負だけ）・導出版を書き、入口 import・sorry 検査へ 6 件登録（計 1339 件）。式変形統一は一時停止中のため実施せず。


- 2026-08-17（tick 357）: 台帳の先頭行「切断による実数体への一度きりの脱出」は、下組の定義とその下閉性（$\Lambda_{\mathbb Q}$ の中）、下組が空でないこと、下組が上に有界なこと、実現写像の順序保存（実対数）、上限として実数を取ること（完備性）の五つの論法を含むので五行へ割った。その最初「列が定める下組と下に閉じていること」を実行し、`def_rational_log_order_group_sequence_lower_set` と `claim_rational_log_order_group_sequence_lower_set_downward_closed` を `claim_open_square_density_sequence_cauchy_le_one` の直後に置いた。
  証明は証人 $\varepsilon,N$ を引き継ぎ、加法単調性と推移律の二段だけ。SageMath `rational-log-order-group-sequence-lower-set`、Lean 具体版・必要十分版（`Add`・`Zero`、推移律・右加法単調性だけ）・導出版を書き、入口 import・sorry 検査へ 4 件登録（計 1333 件）。`remark_real_escape_plan` の脱出の項を $\Lambda_{\mathbb Q}$ の切断の言葉に書き直した。式変形統一は一時停止中のため実施せず。


- 2026-08-17（tick 356）: 台帳の先頭行「密度の列の Cauchy 性（$0<q\le1$）」を実行し、`claim_open_square_density_sequence_cauchy_le_one` を `claim_open_square_density_difference_bound_core_nonneg_le_one` の直後に置いた。
  証明は核の非負・Archimedes 性で $n$ を取り $a:=n+2$、$N:=a^2$ と置く存在の構成と、上端・下端の一続き三段ずつ（差の一様な評価・核の等式・倍率以上で割る評価・逆元の順序反転・推移律）だけ。SageMath `open-square-density-sequence-cauchy`（一辺 9, 10 は行ごとの動的計画法）、Lean 具体版・必要十分版（`Zero`・`Neg`・`SMul ℚ`、推移律・逆元の順序反転と、核の等式・差の上下の評価・Archimedes 性・割る評価を仮定として受けるだけ）・導出版を書き、入口 import・sorry 検査へ 4 件登録（計 1329 件）。式変形統一は一時停止中のため実施せず。


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

- 2026-08-17（tick 360）: 前 tick の「開境界正方形の密度の下組の元は密度の上からの評価以下」の本文（証人を $L:=N$ で読む一続き五段）・SageMath overview（244 検査）・Lean 具体版（`rationalLogOrderLE_add_right`・`zero_add`・`add_comm`・`hN N (le_refl N)`・`rationalLogOrderLE_openScaledFreeEntropy_upperBound`・`rationalLogOrderLE_trans` が五段に 1 対 1）・必要十分版（`Add`・`Zero`、推移律・右加法単調性・単位元・交換則・列の上界）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: 上に有界であることは上限の存在の前提で残す。今 tick の二つは定義であり、実数体への脱出の位置と理由を宣言する（住処 R を持つ最初のブロック）。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。**台帳の整理の不備を 1 件直した**: 前 tick が「現在地」「前進の記録」「レビュー記録」から tick 354 分を外したが保管庫へ移していなかったので、git の履歴から取り出して保管庫へ復元した。本文の修正は無い。


- 2026-08-17（tick 359）: 前 tick の「開境界正方形の密度の列が定める下組」の定義と「開境界正方形の密度の下組は空でない」の本文（準備二つ・一続き三段）・SageMath overview（141 検査）・Lean 具体版（`toRational_generator_two_ne_zero`・`neg_add_cancel`・`openSquareDensitySequence_of_ne_zero`・`rationalLogOrderLE_zero_openScaledFreeEntropy` が本文の準備第二と三段に 1 対 1）・必要十分版（`Add`・`Zero`・`Neg`、正の元一つとその逆元律・列の非負）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: 空でないことは上限の存在の前提（値の属する側の証人）で残す。今 tick の「下組の元は上界以下」は下組が上に有界であること（上限の存在のもう一つの前提）を言うので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。


- 2026-08-17（tick 358）: 前 tick の「有理係数の対数順序群の列が定める下組」の定義と「列が定める下組は下に閉じている」の本文（証人の引き継ぎ・二段）・SageMath overview（125 ベクトル、77 件）・Lean 具体版（`rationalLogOrderSequenceLowerSet`・`mem_…_iff`・`mem_…_of_le` の `rationalLogOrderLE_add_right`・`rationalLogOrderLE_trans` が本文の二段に 1 対 1）・必要十分版（`Add`・`Zero`、推移律・右加法単調性）・導出版（`rfl`）を突き合わせ、根拠が一致した。書き直した `remark_real_escape_plan` の脱出の項も読み直した（$\Lambda_{\mathbb Q}$ の切断の言葉。実対数と完備性の二つの理由）。
  「何も言っていない主張」の観点: 下組の定義は切断の下側に名前を与えるもの、下閉性は値の属する側を言うので残す。今 tick の $A^{\mathrm{op}}(q)$ の定義は上限の段が繰り返し引く名前で、空でないことは上限の存在の前提（値の属する側の証人）を言うので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。


- 2026-08-17（tick 357）: 前 tick の「開境界正方形の密度の列は Cauchy 列である」の本文（準備三つ・上端三段・下端三段）・SageMath overview（105 検査）・Lean 具体版（`hcore0`・`hn`・`a`・`hdiv`・`hcore`・`hup`・`hlow`・`rationalLogOrderLE_neg_le_neg`・`rationalLogOrderLE_trans` が本文の準備と上端・下端に 1 対 1）・必要十分版（`Zero`・`Neg`・`SMul ℚ`、推移律・逆元の順序反転と核の等式・差の上下の評価・Archimedes 性・割る評価）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: Cauchy 性は $\varepsilon$ から $N$ を与える存在の構成そのもので残す。今 tick の下組の定義は切断の下側に名前を与えるもの、下閉性は下組が切断の下組であること（値の属する側）を言うので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。


- 2026-08-17（tick 356）: 前 tick の「Archimedes 性の倍率以上の自然数で割れば上界を超えない」の本文（準備二つ・本体五段）・SageMath overview（28491 組）・Lean 具体版（`h0`・`h1`・`s1`・`hcoef`・`s2`・`one_smul`・`rationalLogOrderLE_trans` が本文の準備と五段に 1 対 1）・必要十分版（`Zero`・`SMul ℚ`、推移律・非負係数の作用の順序保存・非負の元の係数比較・結合則・単位）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: この主張は係数の鎖で、Cauchy 性が上端・下端の両方で引くので残す。今 tick の Cauchy 性は $\varepsilon$ から $N$ を与える存在の構成そのもので、切断による脱出が引く。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。


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

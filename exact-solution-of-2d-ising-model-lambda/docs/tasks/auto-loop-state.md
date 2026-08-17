# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-17 の tick 375 は、台帳の先頭行「有理円板内の Fisher 零点の個数 $N_L(c,r)$」を論法で五行へ割り（整係数多項式の $\overline{\mathbb Q}[t]$ への持ち上げの定義／持ち上げの値と $\mathrm{Ev}^F$ の一致／$\mathcal F_L$ の有限部分集合の個数の上界（根の個数は次数以下）／$\mathcal F_L$ の有限性と $\lvert\mathcal F_L\rvert\le2L^2$（背理法）／$N_L(c,r)$ の定義）、その最初「整係数多項式の代数的数係数多項式への持ち上げ」を本文・Lean 具体版で閉じた（定義ブロックなので必要十分版と SageMath は置かない。住処 Qbar、脱出なし）。**
  `def_integer_polynomial_qbar_lift`（`def_rational_disc` の直後・「この先に書くこと」の直前、住処 Qbar）: $f=\sum_{m=0}^{n}a_mx^m\in\mathbb Z[x]$ に対し $\widehat f^{\,F}\in\overline{\mathbb Q}[t]$ を $\mathrm{ac}_k(\widehat f^{\,F}):=a_k$（$k\le n$）、$0$（$n<k$）で定める。`def_qbar_constant_embedding` の $\widehat{\ \cdot\ }$ とは定義域が違うので上付き $F$ で区別。理由: $\mathcal F_L$ の有限性を `claim_qbar_distinct_roots_card_bound`（$\overline{\mathbb Q}[t]$ の多項式について述べている）から出すには $Z_L\in\mathbb Z[x]$ をそこへ送る写像が本文に無かった（`def_qbar_polynomial_evaluation` は値だけを定めている）。
  Lean 具体版 `ThermodynamicLimit/IntegerPolynomialQbarLift.lean`（`integerPolynomialQbarLift`（`Polynomial.map (Int.castRingHom Qbar)`）・`integerPolynomialQbarLift_coeff`）。sorry 検査 1302 件。check 464 ブロック・verify-check-linkage 256 件・PDF 253 ページ通過。
  式変形統一: この tick は締切（14:10）を優先し見送った（次 tick で 1 件進める）。
  レビュー: 前 tick の `def_rational_disc` の本文と Lean 具体版（`distanceSquaredToRationalPoint`・`rationalDisc`・`distanceSquaredToRationalPoint_real_axis`）を突き合わせて一致。修正なし。次は「持ち上げの値と $\mathrm{Ev}^F$ の一致: $\mathrm{aev}_\xi(\widehat f^{\,F})=\mathrm{Ev}^F_\xi(f)$」（`def_qbar_poly_evaluation` の定義式（$\mathrm{aev}$ が係数と冪の有限和）と `def_qbar_polynomial_evaluation` の定義式を並べる一続き。Lean は `Polynomial.eval₂_map`／`eval_map` の形。SageMath は $Z_L$（$L\le3$）と数個の $\xi$ で厳密に）。

- **2026-08-17 の tick 374 は、台帳の先頭行「零点密度」を論法で五行へ割り（円板の定義／円板内の零点の個数／格子点数あたりの零点数／上極限・下極限による実数体への脱出／重複度付きの個数）、その最初「有理点を中心とする有理半径の円板（$\overline{\mathbb Q}$ の部分集合）」を本文・Lean 具体版まで書いて閉じた（定義ブロックなので必要十分版と SageMath は置かない。住処 Qbar、脱出なし）。**
  `def_rational_disc`（`remark_real_escape_plan` の直後・「この先に書くこと」の直前、住処 Qbar）: $c=(c_1,c_2)\in\mathbb Q\times\mathbb Q$、$r\in\mathbb Q_{>0}$ に対し、$\xi=a+b\cdot\omega$（`def_real_closed_subfield` の第 4 条件）から $\mathrm{dsq}_2(\xi,c):=(a-c_1)\cdot(a-c_1)+(b-c_2)\cdot(b-c_2)\in R$、$D(c,r):=\{\xi\mid\mathrm{dsq}_2(\xi,c)<_R r\cdot r\}\subset\overline{\mathbb Q}$。実軸上の場合 $\mathrm{dsq}_2(\xi,(q,0))=\mathrm{dsq}(\xi,q)$（`def_distance_squared_to_rational` の一般化）。複素数体を呼ばずに零点の分布を数える器。
  Lean 具体版 `ThermodynamicLimit/RationalDisc.lean`（`distanceSquaredToRationalPoint`・`rationalDisc`・`distanceSquaredToRationalPoint_real_axis`）。sorry 検査 1301 件。check 463 ブロック・verify-check-linkage 256 件・PDF 252 ページ通過。
  式変形統一: この tick は締切（13:40）を優先し見送った（次 tick で 1 件進める）。
  レビュー: 前 tick の `def_periodic_free_energy_density_le_one` の本文と Lean 具体版を突き合わせて一致。修正なし。次は「有限格子の Fisher 零点の有理円板内の個数 $N_L(c,r)\in\mathbb N$」（$\mathcal F_L$ の有限性——零でない多項式の根の個数は次数以下——を本文でどう引くかを先に確かめる。Lean は `FisherZeroSet` の有限性を `Z_L\ne0` から出す）。

- **2026-08-17 の tick 373 は、台帳の先頭行「周期境界の自由エネルギー密度 $f^{\mathrm{per}}(q):=\sup\rho_{\mathbb R}(A^{\mathrm{per}}(q))$ の定義と、$f^{\mathrm{op}}(q)$ との一致（q は 1 以下）」を本文・Lean 具体版まで書いて閉じた（定義ブロックなので必要十分版と SageMath は置かない。実数体への脱出は完備性の再利用で、新しい脱出理由は増えない）。**
  `def_periodic_free_energy_density_le_one`（`claim_periodic_density_lower_set_eq_open_square_le_one` の直後・`remark_real_escape_plan` の直前、住処 R）: $0<q\le1$ で $\rho_{\mathbb R}(A^{\mathrm{per}}(q))=\rho_{\mathbb R}(A^{\mathrm{op}}(q))$（一続き三段。下組の等号）、よって空でなく上に有界、$f^{\mathrm{per}}(q):=\sup\rho_{\mathbb R}(A^{\mathrm{per}}(q))$、$f^{\mathrm{per}}(q)=f^{\mathrm{op}}(q)$（一続き三段。同じ集合の上限）。`remark_real_escape_plan` の「三つの定義」を「四つ」へ、本文末尾の「この先に書くこと」から「周期境界自由エネルギー密度への移送」を消した。
  Lean 具体版 `ThermodynamicLimit/PeriodicFreeEnergyDensity.lean`（`periodicRealizedLowerSet`・`periodicRealizedLowerSet_eq_openSquare_of_le_one`・`_nonempty_of_le_one`・`_bddAbove_of_le_one`・`periodicFreeEnergyDensity`（`sSup`）・`periodicFreeEnergyDensity_eq_openSquare_of_le_one`）。sorry 検査 1300 件。check 462 ブロック・verify-check-linkage 256 件・PDF 252 ページ通過。
  式変形統一: 姉妹側「指数関数の和とクロネッカーのデルタ」（`transfer_matrix_009_claim_exp_sum`）の場合 (a) の $\sum(1+i\cdot0)=\sum1$ と場合 (b) の $r\cdot\frac{1-1}{1-r}=0$ に根拠が無かったので行末に $(\because\ \dots)$ を置いた（内容は不変）。姉妹側の check・PDF 323 ページ通過。
  レビュー: 前 tick の `claim_periodic_density_lower_set_eq_open_square_le_one` の本文（両包含・外延性）と Lean 具体版（`ext`＋二つの包含）を突き合わせて一致。修正なし。次は「零点密度」（着手前に論法で割る）。

- **2026-08-17 の tick 372 は、台帳の先頭行「周期境界の下組と開境界正方形の下組は等しく、周期境界の自由エネルギー密度 $f^{\mathrm{per}}(q)$ は $f^{\mathrm{op}}(q)$ に等しい（q は 1 以下）」を二行へ割り（集合の等号（両包含・外延性）／$f^{\mathrm{per}}(q)$ の定義と $f^{\mathrm{op}}(q)$ との一致）、その最初「周期境界の密度の下組と開境界正方形の密度の下組は等しい（q は 1 以下）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_periodic_density_lower_set_eq_open_square_le_one`（`claim_open_square_density_lower_set_subset_periodic_le_one` の直後、住処 Lambda）: $0<q\le1$ で $A^{\mathrm{per}}(q)=A^{\mathrm{op}}(q)$。証明は二つの包含（`claim_periodic_density_lower_set_subset_open_square_le_one`・`claim_open_square_density_lower_set_subset_periodic_le_one`）と集合の外延性だけ。
  SageMath `check/periodic-density-lower-set-eq-open-square/`（$L\le3$、有理点 6 点、$A^{\mathrm{per}}$ の証人 2244 組・$A^{\mathrm{op}}$ の証人 3876 組（うち $N'\le3$ が 2137 組）、4387 検査、12 秒。`ZZ`/`QQ` の厳密計算）。Lean 具体版 `ThermodynamicLimit/PeriodicDensityLowerSetEqOpenSquare.lean`（`periodicDensityLowerSet_eq_openSquareDensityLowerSet_of_le_one`。`ext`＋両包含）、必要十分版 `NecSuf/ThermodynamicLimit/PeriodicDensityLowerSetEqOpenSquare.lean`（`lowerSetOfSequence_eq_of_pointwise_le_and_eventually_le_add_error_necSuf`。仮定は二つの包含の必要十分版の仮定の和集合。新しい構造は無い）、導出版 `PeriodicDensityLowerSetEqOpenSquareFromNecSuf.lean`。sorry 検査 1296 件。check 461 ブロック・verify-check-linkage 256 件・PDF 251 ページ通過。
  式変形統一: 姉妹側「中心化環はスカラー行列」（`linear_space_general_004_lemma_centralizer_is_scalar`）の Step 3 の二本の鎖の第 1 段と Step 4 の鎖の第 1 段（$W$ の展開）に根拠が無かったので行末に $(\because\ W\text{ の基底 }\mathcal{E}\text{ による展開})$ を置いた（内容は不変）。姉妹側の check・PDF 323 ページ通過。
  レビュー: 前 tick の `claim_open_square_density_lower_set_subset_periodic_le_one` の本文（準備四つ・一続き八段）と Lean 具体版（`half_add_half_eq`〜`openSquareDensityLowerSet_subset_periodicDensityLowerSet_of_le_one`）を突き合わせて一致。修正なし。次は「周期境界の自由エネルギー密度 $f^{\mathrm{per}}(q):=\sup\rho_{\mathbb R}(A^{\mathrm{per}}(q))$ の定義と、$f^{\mathrm{op}}(q)$ との一致（q は 1 以下）」（定義ブロック、住処 R、脱出理由は完備性の再利用。下組が等しいので実現像も等しく、上限も同じ実数。`remark_real_escape_plan` の冒頭「三つの定義」を「四つの定義」へ直すこと。Lean は `OpenSquareFreeEnergyDensitySup.lean` と同じ形で `periodicRealizedLowerSet`・`periodicFreeEnergyDensity`・`periodicFreeEnergyDensity_eq_openSquare` を置く。SageMath は置かない）。

- **2026-08-17 の tick 371 は、台帳の先頭行「開境界正方形の密度の下組は周期境界の下組に含まれる（Archimedes 性。q は 1 以下）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_open_square_density_lower_set_subset_periodic_le_one`（`claim_periodic_density_lower_set_subset_open_square_le_one` の直後、住処 Lambda）: $0<q\le1$ で $A^{\mathrm{op}}(q)\subset A^{\mathrm{per}}(q)$。証明は $\mu$ の証人 $(\varepsilon,N)$ から、準備の第一（証人の半分 $\varepsilon':=\tfrac12\cdot\varepsilon$。$\varepsilon'+\varepsilon'=\varepsilon$ の三段・$0=0\cdot\varepsilon\le\varepsilon'$・$\varepsilon'\ne0$）、第二（$\delta:=-\iota(\log q)$ の符号。`claim_rational_embedded_log_order_iff` を $q':=1$ で・`claim_rational_log_order_group_neg_reverses_order`・`claim_rational_log_order_group_scalar_compare_nonneg`）、第三（`claim_rational_log_order_group_archimedean` の倍率 $n$、$N':=N+n$）、第四（`claim_rational_log_order_group_div_ge_multiplier_le` で $\tfrac1L\cdot(2\cdot\delta)\le\varepsilon'$、一続き五段で $-\varepsilon'\le\tfrac2L\cdot\iota(\log q)$）、本体の一続き八段（加法群の等式五段・`claim_rational_log_order_group_add_monotone` 二回・`claim_periodic_open_boundary_comparison_density_le_one` の左）。有理数倍の $0\cdot\lambda=0$・$-0=0$・$-(r\cdot(-\lambda))=r\cdot\lambda$ は独立ブロックにせず、行末の $(\because\ \dots)$ に「素数ごとに読む」と書いた。
  SageMath `check/open-square-density-lower-set-subset-periodic/`（$L\le3$、有理点 6 点、証人 1632 組（密度を要する段が空でない 931 組）、662530 検査、10 秒。`ZZ`/`QQ` の厳密計算。Archimedes の倍率は最小の $n$ を有限探索）。Lean 具体版 `ThermodynamicLimit/OpenSquareDensityLowerSetSubsetPeriodic.lean`（`half_add_half_eq`・`rationalLogOrderLE_zero_half_of_nonneg`・`half_ne_zero_of_ne_zero`・`rationalLogOrderLE_zero_neg_toRational_logRat_of_le_one`・`rationalLogOrderLE_neg_le_scaled_toRational_logRat`・`openSquareDensityLowerSet_subset_periodicDensityLowerSet_of_le_one`）、必要十分版 `NecSuf/ThermodynamicLimit/OpenSquareDensityLowerSetSubsetPeriodic.lean`（`lowerSetOfSequence_subset_of_eventually_le_add_error_necSuf`。仮定は `AddCommGroup`（八段の鎖の等式と七段目の並べ替え）・推移律・右加法単調性・証人の半分の存在・誤差列が正の元の逆元をやがて下回らないこと・$L\ge1$ での項ごとの比較。有理数倍と Archimedes 性は仮定の形にして具体版へ押し出した）、導出版 `OpenSquareDensityLowerSetSubsetPeriodicFromNecSuf.lean`。sorry 検査 1293 件。check 460 ブロック・verify-check-linkage 255 件・PDF 251 ページ通過。
  式変形統一: 姉妹側「クロネッカー積（2 次の複素行列・2 次元数ベクトルの M 個の積）」（`linear_space_general_000_definition_kronecker_product`、`def_kronecker`）の定義内 Step 3（単射性）で、根拠なしの二つの式（$\nu(I)-\nu(J)$ の分解、残りの和の絶対値の評価）を、$\nu$ の定義から始まる一続き四段と、三角不等式・各項の評価・添字の置き換え・Step 2 の等比和・狭義不等号の一続き五段へ揃えた（内容は不変）。姉妹側の check・PDF 323 ページ通過。
  レビュー: 前 tick の `def_periodic_density_lower_set`・`claim_periodic_density_lower_set_subset_open_square_le_one` の本文（証人の引き継ぎ・一続き二段）と Lean 具体版（`periodicDensitySequence`・`mem_…_iff`・`h1`/`h2`・推移律）を突き合わせて一致。`remark_real_escape_plan` の冒頭「直前の三つの定義と四つの主張」は、その間に周期境界の下組の定義と主張が入って「直前」でなくなっていたので「実数体を扱う三つの定義と四つの主張」へ直した（散文のみ）。次は「周期境界の下組と開境界正方形の下組は等しく、周期境界の自由エネルギー密度 $f^{\mathrm{per}}(q)$ は $f^{\mathrm{op}}(q)$ に等しい（q は 1 以下）」。

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
- 熱力学極限: 87 セクション
- 全章（何も言っていない主張の一掃）: 1 セクション
- 零点の詰め寄り・固有値の代数性（本文の lean: から引かれていない Lean の配線）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 零点密度: 持ち上げの値と $\mathrm{Ev}^F$ の一致——$\mathrm{aev}_\xi(\widehat f^{\,F})=\mathrm{Ev}^F_\xi(f)$（$f\in\mathbb Z[x]$、$\xi\in\overline{\mathbb Q}$） | todo | |
| 熱力学極限 | 零点密度: 有限格子の Fisher 零点の有限部分集合の個数は $2L^2$ を超えない（$\widehat{Z_L}^{\,F}\ne0$、$2L^2<k$ で $\mathrm{ac}_k=0$、`claim_qbar_distinct_roots_card_bound`） | todo | |
| 熱力学極限 | 零点密度: $\mathcal F_L$ は有限集合で $\lvert\mathcal F_L\rvert\le2L^2$（背理法。1 の冪根の場合と同じ形） | todo | |
| 熱力学極限 | 零点密度: 有限格子の Fisher 零点の有理円板内の個数 $N_L(c,r):=\lvert\mathcal F_L\cap D(c,r)\rvert\in\mathbb N$ | todo | |
| 熱力学極限 | 零点密度: 格子点数あたりの零点数 $\nu_L(c,r):=N_L(c,r)/L^2\in\mathbb Q$ と上界（$\deg Z_L\le2L^2$ から $\nu_L\le2$） | todo | |
| 熱力学極限 | 零点密度: 実数体への脱出——$(\nu_L(c,r))_{L\ge1}\subset\mathbb Q$ の上極限と下極限（完備性。極限の存在は主張しない） | todo | |
| 熱力学極限 | 零点密度: 重複度付きの個数への精密化（$\overline{\mathbb Q}[x]$ での根の重複度の定義から） | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録
- 2026-08-17（tick 375）: 台帳の先頭行「有理円板内の Fisher 零点の個数」を五行へ割った（持ち上げの定義／持ち上げの値と $\mathrm{Ev}^F$ の一致／有限部分集合の個数の上界／$\mathcal F_L$ の有限性／$N_L(c,r)$ の定義。理由: $\mathcal F_L$ の有限性は本文に無く、`claim_qbar_distinct_roots_card_bound` は $\overline{\mathbb Q}[t]$ の多項式について述べているので $\mathbb Z[x]$ からの持ち上げの定義・値の一致・上界・背理法がそれぞれ別の論法になるため）。その最初「整係数多項式の代数的数係数多項式への持ち上げ」を本文・Lean 具体版で閉じ、`def_integer_polynomial_qbar_lift` を `def_rational_disc` の直後に置いた。sorry 検査 1302 件。式変形統一は締切のため見送り。
- 2026-08-17（tick 374）: 台帳の先頭行「零点密度」を五行へ割った（円板の定義／円板内の零点の個数／格子点数あたりの零点数／上極限・下極限による実数体への脱出／重複度付きの個数。理由: 器の定義・有限集合の数え上げ・$\mathbb Q$ での正規化・完備性による脱出・$\overline{\mathbb Q}[x]$ の因数分解は別々の論法で、1 tick 1 論法にするため。重複度は相異なる零点の個数で器を閉じたあとの精密化として最後に置いた）。その最初「有理点を中心とする有理半径の円板」を本文・Lean 具体版で閉じ、`def_rational_disc` を `remark_real_escape_plan` の直後に置いた（定義ブロック。必要十分版・SageMath は無し）。sorry 検査 1301 件。式変形統一は締切のため見送り。
- 2026-08-17（tick 373）: 台帳の先頭行「周期境界の自由エネルギー密度 $f^{\mathrm{per}}(q)$ の定義と $f^{\mathrm{op}}(q)$ との一致（q は 1 以下）」を本文・Lean 具体版まで書いて閉じ、`def_periodic_free_energy_density_le_one` を下組の等号の直後に置いた（定義ブロック。必要十分版・SageMath は無し）。sorry 検査 1300 件。式変形統一: 姉妹側「指数関数の和とクロネッカーのデルタ」の根拠なし二行へ行末根拠（姉妹側 check・PDF 323 ページ通過）。
- 2026-08-17（tick 372）: 台帳の先頭行「周期境界の下組と開境界正方形の下組は等しく、周期境界の自由エネルギー密度は $f^{\mathrm{op}}(q)$ に等しい」を二行へ割った（集合の等号／$f^{\mathrm{per}}(q)$ の定義と一致。理由: 集合の等号は両包含と外延性の一論法、定義は実数体への脱出を伴う別のブロックなので、1 tick 1 論法にするため）。その最初「周期境界の密度の下組と開境界正方形の密度の下組は等しい（q は 1 以下）」を四層で閉じ、`claim_periodic_density_lower_set_eq_open_square_le_one` を逆の包含の直後に置いた。SageMath 4387 検査、Lean 具体版・必要十分版・導出版、sorry 検査 1296 件。式変形統一: 姉妹側「中心化環はスカラー行列」の Step 3・Step 4 の鎖の第 1 段へ行末根拠を置いた（姉妹側 check・PDF 323 ページ通過）。
- 2026-08-17（tick 371）: 台帳の先頭行「開境界正方形の密度の下組は周期境界の下組に含まれる（Archimedes 性。q は 1 以下）」を四層で閉じ、`claim_open_square_density_lower_set_subset_periodic_le_one` を周期境界の下組の包含の直後に置いた。SageMath 662530 検査、Lean 具体版・必要十分版・導出版、sorry 検査 1293 件。式変形統一: 姉妹側「クロネッカー積」定義内 Step 3（単射性）の二つの式を一続き四段・五段と行末根拠へ（姉妹側 check・PDF 323 ページ通過）。



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
- 2026-08-17（tick 375）: 前 tick の「有理点を中心とする有理半径の円板」の本文（$\mathrm{dsq}_2$・$D(c,r)$・実軸上の特別な場合）と Lean 具体版を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の持ち上げの定義は、次の値の一致・上界・有限性がすべて引く器（後で引く形）であり、値がどの環に属するかを言っているので残す。本文末尾「この先に書くこと」の零点密度の内訳へ持ち上げ・値の一致・有限性を足し、台帳のセクション表（四行追加）と同じ tick で揃えた。
- 2026-08-17（tick 374）: 前 tick の「周期境界の自由エネルギー密度の定義と $f^{\mathrm{op}}(q)$ との一致」の本文（実現像の等号三段・上限の等号三段）と Lean 具体版（`periodicRealizedLowerSet_eq_openSquare_of_le_one`・`periodicFreeEnergyDensity_eq_openSquare_of_le_one`）を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の円板の定義は、後の零点の個数・密度がすべて引く器（後で引く形）なので残す。$\mathrm{dsq}_2(\xi,(q,0))=\mathrm{dsq}(\xi,q)$ は独立ブロックにせず定義の中に置いた。本文末尾「この先に書くこと」の零点密度の内訳と台帳のセクション表（四行）を同じ tick で揃えた。
- 2026-08-17（tick 373）: 前 tick の「周期境界の密度の下組と開境界正方形の密度の下組は等しい」の本文（両包含と外延性）と Lean 具体版・必要十分版・導出版を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の定義ブロックは実数体への脱出点（上限を取る）そのものであり、$f^{\mathrm{per}}(q)=f^{\mathrm{op}}(q)$ は以後の周期境界についての言明を開境界正方形の側へ移す根拠として引く（後で引く形）ので残す。像の等号・上限の等号は独立ブロックにせず定義の中の一続きの式変形に置いた。本文末尾「この先に書くこと」（残り: 零点密度／臨界指数）と台帳のセクション表は食い違いなし。
- 2026-08-17（tick 372）: 前 tick の「開境界正方形の密度の下組は周期境界の密度の下組に含まれる（Archimedes 性）」の本文（準備四つ・一続き八段）と Lean 具体版・必要十分版・導出版を突き合わせ、根拠が一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の集合の等号は、二つの包含から従うだけだが、次の $f^{\mathrm{per}}(q)$ の定義が「実現像の上限を取る対象が同じ集合である」ことの根拠として引く（後で引く形）ので残す。本文末尾「この先に書くこと」と台帳のセクション表は食い違いなし（本文側の「周期境界自由エネルギー密度への移送」は表の残り一行を包む）。
- 2026-08-17（tick 371）: 前 tick の「周期境界の密度の列が定める下組」と「周期境界の密度の下組は開境界正方形の密度の下組に含まれる」の本文と Lean 具体版・必要十分版・導出版を突き合わせ、根拠が一致した。`remark_real_escape_plan` の冒頭の「直前の」が実態と合わなくなっていたので「実数体を扱う」へ直した（散文のみ）。
  「何も言っていない主張」の観点: 今 tick の包含は、前 tick の包含と合わせて集合の等号を与えるので残す。$0\cdot\lambda=0$・$-0=0$・$-(r\cdot(-\lambda))=r\cdot\lambda$・証人の半分の三性質・$\delta$ の符号は独立ブロックにせず、証明の準備と行末の $(\because\ \dots)$ に置いた。本文末尾「この先に書くこと」と台帳のセクション表は食い違いなし（本文側の「周期境界自由エネルギー密度への移送」は表の残り一行を包む）。



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

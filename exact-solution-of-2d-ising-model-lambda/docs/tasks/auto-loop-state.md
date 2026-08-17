# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

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

- **2026-08-17 の tick 370 は、台帳の先頭行「周期境界の密度の列は開境界正方形と同じ下組を定め、同じ実数 $f^{\mathrm{op}}(q)$ へ」を三行へ割り（下組の定義と一方の包含／逆の包含（Archimedes 性）／両包含から集合の等号と同じ実数）、その最初「周期境界の密度の列が定める下組と、その下組が開境界正方形の下組に含まれること（q は 1 以下）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `def_periodic_density_lower_set`（`def_open_square_free_energy_density` の直後、住処 Lambda）: $A^{\mathrm{per}}(q):=A((\Psi_L(q))_{L\ge1})\subset\Lambda_{\mathbb Q}$（`def_rational_log_order_group_sequence_lower_set` を周期境界の密度の列で読む。開境界正方形の $A^{\mathrm{op}}(q)$ と列だけが違う）。`claim_periodic_density_lower_set_subset_open_square_le_one`（その直後、住処 Lambda）: $0<q\le1$ で $A^{\mathrm{per}}(q)\subset A^{\mathrm{op}}(q)$。証明は $\mu$ の所属の証人 $\varepsilon,N$ をそのまま使い、一続き二段（証人の性質・`claim_periodic_open_boundary_comparison_density_le_one` の右の不等式）と推移律。逆の包含は誤差 $\tfrac{2}{L}\iota(\log q)$ を Archimedes 性で吸収する必要があるので次行に置いた。
  SageMath `check/periodic-density-lower-set-subset-open-square/`（$L\le3$、有理点 6 点、所属の証人 288 組、2016 検査、10 秒。`ZZ`/`QQ` の厳密計算）。Lean 具体版 `ThermodynamicLimit/PeriodicDensityLowerSet.lean`（`periodicDensitySequence`・`_of_ne_zero`・`periodicDensityLowerSet`・`mem_…_iff`・`periodicDensityLowerSet_subset_openSquareDensityLowerSet_of_le_one`）、必要十分版 `NecSuf/ThermodynamicLimit/PeriodicDensityLowerSetSubsetOpenSquare.lean`（`lowerSetOfSequence_subset_of_pointwise_le_necSuf`。使うのは推移律と $L\ge1$ での項ごとの比較だけ。下組は既存の `lowerSetOfSequence` を共有）、導出版 `PeriodicDensityLowerSetFromNecSuf.lean`。sorry 検査 1285 件。check 459 ブロック・verify-check-linkage 254 件・PDF 249 ページ通過。
  式変形統一: 姉妹側「クロネッカー積（2 次の複素行列・2 次元数ベクトルの M 個の積）」（`linear_space_general_000_definition_kronecker_product`、`def_kronecker`）の定義内 Step 2（値域）で、散文中の帰納法の段 $\sum_{t=0}^{n}2^t=(2^n-1)+2^n=2^{n+1}-1$ と根拠なしの一行 $0\le\sum(i_k-1)2^{M-k}\le\sum2^{M-k}=\sum_{t=0}^{M-1}2^t=2^M-1$ を、それぞれ一続き四段と行末根拠へ揃えた（内容は不変）。姉妹側の check・PDF 323 ページ通過。
  レビュー: 前 tick の `claim_periodic_open_boundary_comparison_density_le_one` の本文（準備二つ・七段・鎖二本）と Lean 具体版（`scaled_periodicOpenLowerForm_eq` の `calc` 七段・`rationalLogOrderLE_periodicOpenDensity_bounds_of_le_one`）を突き合わせて一致。Lean ファイル冒頭の注釈だけが「六段」と書いており「七段」へ直した（コメントのみ。先に別コミットで push 済み）。次は「開境界正方形の密度の下組は周期境界の下組に含まれる（Archimedes 性。q は 1 以下）」。

- **2026-08-17 の tick 369 は、台帳の先頭行「周期境界と開境界の密度の比較（Λ_ℚ。q は 1 以下）」を本文・SageMath・Lean（具体版・必要十分版は共有・導出版）まで書いて四層で閉じた。**
  `claim_periodic_open_boundary_comparison_density_le_one`（`def_open_square_free_entropy_density` の直後、住処 Lambda）: $L\ge1$、$0<q\le1$ で $\Psi^{\mathrm{op}}_L(q)+\tfrac{2}{L}\cdot\iota(\log q)\le_{\Lambda_{\mathbb Q}}\Psi_L(q)\le_{\Lambda_{\mathbb Q}}\Psi^{\mathrm{op}}_L(q)$。証明は準備二つ（値の正値性と $L\ne0$、下端の元の像を七段で $\Psi^{\mathrm{op}}_L(q)+\tfrac{2}{L}\cdot\iota(\log q)$ へ整える: $\iota$ の加法性・分配則・`claim_rational_embedding_commutes_with_integer_multiple`・結合則・$\mathbb Q$ の約分 $\tfrac{1}{L^2}\cdot2L=\tfrac2L$・密度の定義・加法の可換性）と一続き三段の鎖二本（`claim_scaled_embedding_order_transfer` で `claim_periodic_open_boundary_comparison_log_le_one` の $\Lambda$ の比較を移し、`def_finite_free_entropy_density`・`def_open_square_free_entropy_density` で閉じる）。部分正方形の density 版と同じ形。
  SageMath `check/periodic-open-boundary-comparison-density/`（$L\le3$、有理点 6 点、252 検査、5 秒。`ZZ`/`QQ` の厳密計算。決定手続きと順序の移送の一致も各段で見る）。Lean 具体版 `ThermodynamicLimit/PeriodicOpenComparisonDensity.lean`（`scaled_periodicOpenLowerForm_eq`（七段の `calc`）・`rationalLogOrderLE_periodicOpenDensity_bounds_of_le_one`）、必要十分版は `twoSided_bounds_transport_through_monotone_map_necSuf` を共有（新設しない。上端の等式は `rfl`）、導出版 `PeriodicOpenComparisonDensityFromNecSuf.lean`。sorry 検査 1280 件。check 457 ブロック・verify-check-linkage 253 件・PDF 249 ページ通過。
  式変形統一: 姉妹側「定数 $c$ の値」（`eigenvalues_of_V_017_claim_constant_c_value`）の Step 4 で、散文の $c^2=(2s_2)^M=((2s_2)^{M/2})^2$ と根拠なしの一行 $(c-(2s_2)^{M/2})(c+(2s_2)^{M/2})=0$ を、和と差の積・指数法則・Step 3 の代入の一続き四段と行末根拠へ揃えた（内容は不変）。姉妹側の check・PDF 323 ページ通過。
  レビュー: 前 tick の `claim_periodic_open_boundary_comparison_log_le_one` の本文（準備二つ・一続き四段）と Lean 具体版（`logRat_periodicOpenLowerValue_eq`・`logOrderLE_periodicOpenLog_bounds_of_le_one`。`hZ`/`hZop`/`hlow`・`logRat_le_iff`・`unfold freeEntropy` が本文と 1 対 1）を突き合わせて一致。修正なし。次は「周期境界の密度の列は開境界正方形と同じ下組を定め、同じ実数 $f^{\mathrm{op}}(q)$ へ」（着手前に論法で割る）。

- **2026-08-17 の tick 368 は、台帳の先頭行「周期境界自由エネルギー密度への移送」を三行へ割り（境界評価の対数化／密度の比較／周期境界の密度の列は同じ下組・同じ実数へ）、その最初「周期境界と開境界の境界評価の対数化（Λ の鎖。q は 1 以下）」を本文・SageMath・Lean（具体版・必要十分版は共有・導出版）まで書いて四層で閉じた。**
  `claim_periodic_open_boundary_comparison_log_le_one`（`claim_periodic_open_boundary_comparison_rational` の直後・`def_open_square_free_entropy_density` の直前、住処 Lambda）: $L\ge1$、$0<q\le1$ で $2L\log q+\log Z^{\mathrm{op}}_{L,L}(q)\le_\Lambda\Phi_L(q)\le_\Lambda\log Z^{\mathrm{op}}_{L,L}(q)$。証明は準備二つ（値の正値性、下端の値の対数を開く二段 `claim_log_additive`・`claim_log_power`）と一続き四段（準備の第二・`claim_rational_log_order_iff` で有理点の評価を移す・`def_finite_free_entropy`・移す）。上端は $\log Z^{\mathrm{op}}_{L,L}(q)$ そのもので開く操作は無い。
  SageMath `check/periodic-open-boundary-comparison-log/`（$L\le3$、有理点 6 点、126 検査、3 秒。`ZZ`/`QQ` の厳密計算）。Lean 具体版 `ThermodynamicLimit/PeriodicOpenComparisonLog.lean`（`logRat_periodicOpenLowerValue_eq`・`logOrderLE_periodicOpenLog_bounds_of_le_one`。`partitionPolynomial_eval_pos`・`openPartitionValueRat_pos`・`partitionValueRat_periodicOpen_bounds_of_le_one`・`logRat_le_iff`・`logRat_mul`・`logRat_pow` が本文の段に 1 対 1）、必要十分版は「開境界正方形のブロック敷き詰め評価の対数化」の `twoSided_bounds_transport_through_monotone_map_necSuf` を共有（新設しない。上端の等式は `rfl`）、導出版 `PeriodicOpenComparisonLogFromNecSuf.lean`。sorry 検査 1277 件。check 456 ブロック・verify-check-linkage 252 件・PDF 248 ページ通過。
  式変形統一: 姉妹側「同時固有空間分解」（`eigenvalues_of_V_008_claim_joint_eigenspace_decomposition`）の Step 4 末尾の $\dim\mathrm{im}\,Q_\epsilon=\mathrm{tr}(Q_\epsilon)=2^{M-m}$（散文内の二段）を一続きの等号と行末根拠へ揃えた（内容は不変。ラベル参照は直後に 1 つ置いた）。姉妹側の check・PDF 323 ページ通過。
  レビュー: 前 tick の姉妹側「冪等行列のトレースは像の次元」の書き換え差分を読み、四つの計算の根拠がすべて残り中身が不変であることを確認。前 tick に配線した `lean:` 28 件は check（`validate:lean`）で実在を確認。修正なし。次は「周期境界と開境界の密度の比較（Λ_ℚ。q は 1 以下）」。

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
- 熱力学極限: 85 セクション
- 全章（何も言っていない主張の一掃）: 1 セクション
- 零点の詰め寄り・固有値の代数性（本文の lean: から引かれていない Lean の配線）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 周期境界の自由エネルギー密度 $f^{\mathrm{per}}(q):=\sup\rho_{\mathbb R}(A^{\mathrm{per}}(q))$ の定義と、$f^{\mathrm{op}}(q)$ との一致（q は 1 以下） | todo | 定義ブロック（住処 R、脱出理由は完備性の再利用）。`claim_periodic_density_lower_set_eq_open_square_le_one` により $A^{\mathrm{per}}(q)=A^{\mathrm{op}}(q)$ なので実現像も等しく、空でなく上に有界で well-defined、上限は $f^{\mathrm{op}}(q)$ と同じ実数。`remark_real_escape_plan` の「三つの定義」を「四つ」へ |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録
- 2026-08-17（tick 372）: 台帳の先頭行「周期境界の下組と開境界正方形の下組は等しく、周期境界の自由エネルギー密度は $f^{\mathrm{op}}(q)$ に等しい」を二行へ割った（集合の等号／$f^{\mathrm{per}}(q)$ の定義と一致。理由: 集合の等号は両包含と外延性の一論法、定義は実数体への脱出を伴う別のブロックなので、1 tick 1 論法にするため）。その最初「周期境界の密度の下組と開境界正方形の密度の下組は等しい（q は 1 以下）」を四層で閉じ、`claim_periodic_density_lower_set_eq_open_square_le_one` を逆の包含の直後に置いた。SageMath 4387 検査、Lean 具体版・必要十分版・導出版、sorry 検査 1296 件。式変形統一: 姉妹側「中心化環はスカラー行列」の Step 3・Step 4 の鎖の第 1 段へ行末根拠を置いた（姉妹側 check・PDF 323 ページ通過）。
- 2026-08-17（tick 371）: 台帳の先頭行「開境界正方形の密度の下組は周期境界の下組に含まれる（Archimedes 性。q は 1 以下）」を四層で閉じ、`claim_open_square_density_lower_set_subset_periodic_le_one` を周期境界の下組の包含の直後に置いた。SageMath 662530 検査、Lean 具体版・必要十分版・導出版、sorry 検査 1293 件。式変形統一: 姉妹側「クロネッカー積」定義内 Step 3（単射性）の二つの式を一続き四段・五段と行末根拠へ（姉妹側 check・PDF 323 ページ通過）。
- 2026-08-17（tick 370）: 台帳の先頭行「周期境界の密度の列は開境界正方形と同じ下組を定め、同じ実数 $f^{\mathrm{op}}(q)$ へ」を三行へ割った（下組の定義と一方の包含／逆の包含（Archimedes 性）／両包含から集合の等号と同じ実数。理由: 一方の包含は証人の引き継ぎと推移律だけ、逆の包含は Archimedes 性で誤差を吸収する別の論法、集合の等号と実数の一致はさらに別なので、1 tick 1 論法にするため）。その最初を四層で閉じ、`def_periodic_density_lower_set` と `claim_periodic_density_lower_set_subset_open_square_le_one` を `def_open_square_free_energy_density` の直後に置いた。SageMath 2016 検査、Lean 具体版・必要十分版・導出版、sorry 検査 1285 件。式変形統一: 姉妹側「クロネッカー積（2 次の複素行列・2 次元数ベクトルの M 個の積）」（`linear_space_general_000_definition_kronecker_product`、`def_kronecker`）の定義内 Step 2（値域）で、散文中の帰納法の段 $\sum_{t=0}^{n}2^t=(2^n-1)+2^n=2^{n+1}-1$ と根拠なしの一行 $0\le\sum(i_k-1)2^{M-k}\le\sum2^{M-k}=\sum_{t=0}^{M-1}2^t=2^M-1$ を、それぞれ一続き四段と行末根拠へ揃えた（内容は不変）。姉妹側の check・PDF 323 ページ通過。
- 2026-08-17（tick 369）: 台帳の先頭行「周期境界と開境界の密度の比較（Λ_ℚ。q は 1 以下）」を四層で閉じ、`claim_periodic_open_boundary_comparison_density_le_one` を開境界正方形の密度の定義の直後に置いた。SageMath 252 検査、Lean 具体版・導出版（必要十分版は既存を共有）、sorry 検査 1280 件。式変形統一は姉妹側「定数 $c$ の値」の Step 4 の因数分解の一行を一続きの四段へ。
- 2026-08-17（tick 368）: 台帳の先頭行「周期境界自由エネルギー密度への移送」を三行へ割った（境界評価の対数化／密度の比較／同じ下組・同じ実数へ。理由: 対数化・密度化・下組の一致は別々の論法で、1 tick 1 論法にするため）。その最初「周期境界と開境界の境界評価の対数化（Λ の鎖。q は 1 以下）」を四層で閉じ、`claim_periodic_open_boundary_comparison_log_le_one` を有理点の評価の直後に置いた。SageMath 126 検査、Lean 具体版・導出版（必要十分版は既存を共有）、sorry 検査 1277 件。式変形統一は姉妹側「同時固有空間分解」の Step 4 末尾の二段を一続きの形へ。

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
- 2026-08-17（tick 372）: 前 tick の「開境界正方形の密度の下組は周期境界の密度の下組に含まれる（Archimedes 性）」の本文（準備四つ・一続き八段）と Lean 具体版・必要十分版・導出版を突き合わせ、根拠が一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の集合の等号は、二つの包含から従うだけだが、次の $f^{\mathrm{per}}(q)$ の定義が「実現像の上限を取る対象が同じ集合である」ことの根拠として引く（後で引く形）ので残す。本文末尾「この先に書くこと」と台帳のセクション表は食い違いなし（本文側の「周期境界自由エネルギー密度への移送」は表の残り一行を包む）。
- 2026-08-17（tick 371）: 前 tick の「周期境界の密度の列が定める下組」と「周期境界の密度の下組は開境界正方形の密度の下組に含まれる」の本文と Lean 具体版・必要十分版・導出版を突き合わせ、根拠が一致した。`remark_real_escape_plan` の冒頭の「直前の」が実態と合わなくなっていたので「実数体を扱う」へ直した（散文のみ）。
  「何も言っていない主張」の観点: 今 tick の包含は、前 tick の包含と合わせて集合の等号を与えるので残す。$0\cdot\lambda=0$・$-0=0$・$-(r\cdot(-\lambda))=r\cdot\lambda$・証人の半分の三性質・$\delta$ の符号は独立ブロックにせず、証明の準備と行末の $(\because\ \dots)$ に置いた。本文末尾「この先に書くこと」と台帳のセクション表は食い違いなし（本文側の「周期境界自由エネルギー密度への移送」は表の残り一行を包む）。
- 2026-08-17（tick 370）: 前 tick の「周期境界と開境界の密度の比較（Λ_ℚ 版）」の本文と Lean 具体版・導出版を突き合わせ、根拠が一致した。Lean ファイル冒頭の注釈の段数「六段」を本文どおり「七段」へ直した（コメントのみ）。
  「何も言っていない主張」の観点: 今 tick の下組の定義は次の両包含と実数の一致が引くので残す。包含の主張は集合の包含についての主張で、次の逆包含と合わせて集合の等号を与えるので残す。$L\ge1$ の導出（$1\le N\le L$）は独立ブロックにせず証明の散文に置いた。本文末尾「この先に書くこと」と台帳のセクション表は食い違いなし（本文側の「周期境界自由エネルギー密度への移送」は表の残り二行を包む）。本文の修正は無い。
- 2026-08-17（tick 369）: 前 tick の「周期境界と開境界の境界評価の対数化」の本文（準備二つ・一続き四段）と Lean 具体版・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: 今 tick の密度の比較は $\Lambda_{\mathbb Q}$ の順序についての主張で、次の下組の一致が引くので残す。準備の $\mathbb Q$ の約分・加法の可換性は独立ブロックにせず、行末の $(\because\ \dots)$ に置いた。本文末尾「この先に書くこと」と台帳のセクション表は食い違いなし（本文側の「周期境界自由エネルギー密度への移送」は表の残り一行を包む）。本文の修正は無い。
- 2026-08-17（tick 368）: 前 tick の姉妹側「冪等行列のトレースは像の次元」の書き換え差分（Step 1 の二計算・Step 2・Step 3）を読み、根拠がすべて残り中身が不変であることを確認。前 tick に配線した `lean:` 28 件は check の `validate:lean` で実在を確認。
  「何も言っていない主張」の観点: 今 tick の対数化は有理点の評価を $\Lambda$ の順序へ移す主張で、密度の比較が引くので残す。準備の正値性・対数を開く二段は独立ブロックにせず証明の中に置いた。本文末尾「この先に書くこと」と台帳のセクション表は食い違いなし。本文の修正は無い。


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

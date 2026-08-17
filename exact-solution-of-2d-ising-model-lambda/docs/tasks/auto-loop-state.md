# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-17 の tick 367 は、台帳の先頭行「本文の lean: から引かれていない Lean の配線」を実行し、章「零点の詰め寄り」の五ブロックと章「固有値の代数性」の二主張の `lean:` へ、既にある Lean の宣言（計 28 件）を足した。**
  対象は、tick 366 の閉包計算で本文の `lean:` から辿れなかった 8 ファイル。章「零点の詰め寄り」は `def_distance_squared_to_rational`（`realClosedComponents`・`_spec`・`distanceSquaredToRational`・必要十分版 `distanceSquaredOfPair`）、`claim_distance_squared_zero_iff_equal`（具体版・必要十分版・導出版）、`def_zero_pinching_predicate`（`PositiveRational`・`PositiveLatticeSize`・`fisherZeroSetAtPositiveSize`・`zeroPinchingPredicate`）、`claim_distance_positive_on_fisher_zeros`（具体版・必要十分版・導出版）、`def_phase_transition_countable_statement`（`phaseTransitionCountableStatement`）——台帳の行名は「三定義」だったが、同じファイルに載る二主張も `lean:` を持たなかったので併せて配線した。章「固有値の代数性」は `claim_row_config_order_linear` に導出版 `RowConfigOrderFromNecSuf.lean` の 5 宣言、`claim_orbit_permutation_sign_values` に必要十分版 `signOn_*`・`inversionCountOn_id` と導出版 `OrbitPermutationSignValuesFromNecSuf.lean` の 4 宣言を足した。中身の突き合わせ: 距離の二乗の定義 $(a-q)(a-q)+b\cdot b$、零性の同値（$w:=(a-q)b^{-1}$ で $w^2=-1$ の背理法）、詰め寄りの述語（$L\ge1$・$\xi\in\mathcal F_L$・$q\in\mathbb Q_{>0}$ の存在量化と $<_R$）、非零性（正の有理数は零点でない）、相転移の言明（$\forall\varepsilon$）が本文と Lean で一致。本文も Lean も直していない。Lean 対応先 1240 → 1268 件、import 閉包の外のファイルは 0 件。sorry 検査 1274 件（登録は既にあった）。`lake build`・check・verify-check-linkage 251 件・PDF 247 ページ通過。
  式変形統一（再開後の 1 件目）: 姉妹側「冪等行列のトレースは像の次元」（`eigenvalues_of_V_003_claim_trace_of_idempotent`）の Step 1 の二計算・Step 2・Step 3 を一続きの等号と行末根拠へ揃えた（内容は不変。姉妹側の生成器は `\blkref` を持たないので根拠には題を書き、ラベル参照は散文に残した）。姉妹側の check・PDF 323 ページ通過。
  レビュー: 前 tick の `ConstantPlusConfiguration.lean`（`allPlusConfig`・`allPlusConfig_brokenBondCount_eq_zero`）と本文 `def_constant_plus_configuration`・`claim_constant_plus_breaks_no_bond` を突き合わせて一致。修正なし。次は「周期境界自由エネルギー密度への移送」。

- **2026-08-17 の tick 366 は、台帳の先頭行「削除した実数値経路の Lean の後片付け」を実行し、本文から引かれていない旧実数値経路の Lean ファイル 61 個を消して、新しい自由エネルギー密度の Lean ファイルの名前から `Sup` を外した。**
  特定は機械的に行った: 本文の `lean:` に現れる名前を含むファイルを起点に import の閉包を取り、その外にあるファイルを列挙（65 個）。うち 55 個は 2026-08-16 に本文から消した実数値経路（`30d11b8a` で `lean:` から外れた 94 名）の宣言を含む。加えて、可算側の主張だけが引いていた `allPlusConfig`（`def_constant_plus_configuration`）と `allPlusConfig_brokenBondCount_eq_zero`（`claim_constant_plus_breaks_no_bond`）が実数値経路のファイル（`PartitionValuePositive.lean`・`FreeEnergyDensityLowerBound.lean`）に同居し、そこから `FreeEnergyDensity.lean`・`FiniteRealFreeEntropy.lean`（実対数・上限）を引きずっていたので、この二つを新ファイル `ThermodynamicLimit/ConstantPlusConfiguration.lean`（import は `PartitionPolynomial.Basic` だけ）へ切り出し、`PartitionValueGeOneRational.lean` の import を付け替えたうえで、それら 6 個（`FreeEnergyDensity` の具体版・必要十分版・導出版を含む）も消した。計 61 ファイル削除・1 ファイル新設（792 → 732）。入口 `Ising2DLambda.lean` の import と sorry 検査の登録（実在しなくなった 96 件）を外し、登録は 1274 件。`OpenSquareFreeEnergyDensitySup.lean` → `OpenSquareFreeEnergyDensity.lean`、`openSquareFreeEnergyDensitySup*` → `openSquareFreeEnergyDensity*` に改名し、本文 `def_open_square_free_energy_density` の `lean:` と sorry 検査の登録も合わせた。`lake build`・sorry 検査・check（Lean 対応先 1240 件実在）・verify-check-linkage（251 件）・PDF 247 ページ通過。
  閉包の外に残った 8 ファイルは実数値経路ではない（章「零点の詰め寄り」の三定義 `def_distance_squared_to_rational`・`def_zero_pinching_predicate`・`def_phase_transition_countable_statement` に対応する Lean と、章「固有値の代数性」の導出版二つ `RowConfigOrderFromNecSuf`・`OrbitPermutationSignValuesFromNecSuf`）。本文のブロックが `lean:` を持たないだけなので消さず、配線する行をセクション表へ足した。
  レビュー: 前 tick の `def_open_square_free_energy_density` の本文（空でない・上に有界の含意の鎖二段・完備性で上限・特徴づけ二つ）と Lean（`openSquareRealizedLowerSet_nonempty`・含意の鎖・`_bddAbove`・`sSup`・`le_csSup`・`csSup_le`）を突き合わせて一致。修正なし。次は「本文の lean: から引かれていない Lean の配線」。

- **2026-08-17 の tick 365 は、台帳の先頭行「下組の実現像の上限として開境界正方形の自由エネルギー密度を定める（実数体への脱出: 完備性）」を本文・Lean まで書いた（定義のみ。SageMath 検証は定義には置かない）。**
  `def_open_square_free_energy_density`（`claim_rational_log_order_group_realization_monotone` の直後・`remark_real_escape_plan` の直前、住処 R、`realEscape` は「完備性（下組の実現像 $\rho_{\mathbb R}(A^{\mathrm{op}}(q))\subset\mathbb R$ が空でなく上に有界で、その上限を取る一点。実対数について使うのは順序保存だけ）」）: $f^{\mathrm{op}}(q):=\sup\rho_{\mathbb R}(A^{\mathrm{op}}(q))\in\mathbb R$。well-defined 性は statement に書いた——空でない（`claim_open_square_density_lower_set_nonempty` の証人 $-\iota(\ell_2)$ の像）、上に有界（含意の鎖二段: `claim_open_square_density_lower_set_le_upper_bound` → `claim_rational_log_order_group_realization_monotone` で $b(q):=\rho_{\mathbb R}(\iota(\ell_2)+2\iota(\log(1+q)))$ が上界）。上限の特徴づけ（上界である・最小である）と $\rho_{\mathbb R}(-\iota(\ell_2))\le f^{\mathrm{op}}(q)\le b(q)$ を添え、列の各項の実現がこの値に近づくことは主張しない旨を明記。`remark_real_escape_plan` の題名から「まだ書いていない」を外し、冒頭を「三つの定義と四つの主張」に、脱出の項を「$f^{\mathrm{op}}(q)$ を一つ取る（定義への参照）」に直した。本文末尾「この先に書くこと」から「切断による実数体への一度きりの脱出と旧実数値経路の撤去」を外した（本文側は済み。Lean の後片付けはセクション表の次行）。
  Lean 具体版 `ThermodynamicLimit/OpenSquareFreeEnergyDensitySup.lean`（`openSquareRealizedLowerSet`・`openSquareRealizedLowerSet_nonempty`・`realizeRational_le_realizeRational_upperBound_of_mem_openSquareDensityLowerSet`・`openSquareRealizedLowerSet_bddAbove`・`openSquareFreeEnergyDensitySup`（`sSup`）・`realizeRational_le_openSquareFreeEnergyDensitySup`（`le_csSup`）・`openSquareFreeEnergyDensitySup_le_of_forall_le`（`csSup_le`）。定義ブロックなので必要十分版は無い）。**名前の末尾 `Sup` は、削除済み旧実数値経路のファイル `OpenSquareFreeEnergyDensity.lean`（同名の `openSquareFreeEnergyDensity` を持つ）と衝突しないために付けた。** 最初に同名で上書きしてしまい旧経路の依存ファイルが壊れたので、旧ファイルを復元して自分の側を改名した。次行「削除した実数値経路の Lean の後片付け」で旧経路を消したら `Sup` を外してよい。sorry 検査 1370 件。check 455 ブロック・PDF 247 ページ通過。
  レビュー: 前 tick の「有理係数の対数順序群の実現写像は順序を保つ」の本文（証人・準備・含意の鎖六段・三段）と Lean 具体版（`h1`〜`h6`・`calc`）を突き合わせて一致。修正なし。次は「削除した実数値経路の Lean の後片付け」。

- **2026-08-17 の tick 364 は、台帳の先頭行「有理係数の対数順序群の実現写像は順序を保つ（実数体への脱出: 実対数）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_rational_log_order_group_realization_monotone`（`claim_log_order_group_realization_real_log` の直後・`remark_real_escape_plan` の直前、住処 R、`realEscape` は「実対数（$\rho_{\mathbb R}$ の値どうしの不等式。$\iota_{\mathbb Q\to\mathbb R}$ の順序保存、$\log_{\mathbb R}$ の単調性、$\mathbb R$ が順序体であることだけ）」）: $\lambda,\mu\in\Lambda_{\mathbb Q}$ で $\lambda\le_{\Lambda_{\mathbb Q}}\mu\Rightarrow\rho_{\mathbb R}(\lambda)\le\rho_{\mathbb R}(\mu)$。証明は順序の定義から証人 $N\ge1,\lambda_N,\mu_N$ を取り、準備一つ（$0<\iota(N)$、$0<\iota(N)^{-1}$）、含意の鎖六段（$\Lambda$ の順序の定義・$\iota$ の順序保存・実対数の単調性・`claim_log_order_group_realization_real_log`・共通分母の定義・`claim_rational_log_order_group_realization_smul` を $r:=N$ で）、最後の一続き三段（$\rho(\lambda)=\iota(N)^{-1}(\iota(N)\rho(\lambda))\le\iota(N)^{-1}(\iota(N)\rho(\mu))=\rho(\mu)$。正の元を左から掛けても順序が保たれる）。完備性は使わない。`remark_real_escape_plan` の冒頭と脱出の項の「順序を保つことはこれから示す」をこの主張への参照に直した。
  SageMath `check/rational-log-order-group-realization-monotone/`（可算側の段は `ZZ`/`QQ` の厳密計算、実数側の段は区間演算 `RealBallField(256)`——素数の実対数は超越数なので、丸めを区間で包む厳密な包含で不等式を判定し、区間が重なれば FAIL とする。理由は overview に記した。標本 218 個、順序対 23871 組、286452 検査、14 秒）。Lean 具体版 `ThermodynamicLimit/RationalLogOrderGroupRealizationMonotone.lean`（`natCast_real_pos`・`realizeRational_le_of_rationalLogOrderLE`。`Rat.cast_le`・`realLog_le_realLog`・`realizeRational_toRational`・`IsCommonDenominator`・`realizeRational_smul`・`inv_pos`・`inv_mul_cancel₀`・`mul_le_mul_of_nonneg_left` が六段と三段に 1 対 1）、必要十分版 `NecSuf/ThermodynamicLimit/RationalLogOrderGroupRealizationMonotone.lean`（`le_of_smul_le_smul_necSuf`（順序体で正の元を外す三段）・`realize_monotone_of_common_denominator_necSuf`。値の側だけ `Field`＋`LinearOrder`＋`IsStrictOrderedRing`、$\Lambda_{\mathbb Q}$・$\Lambda$・$\mathbb Q$・$\mathbb R_{>0}$ に当たる型は代数構造なし（$\mathbb Q$ に当たる型の半順序だけ）、順序の証人を仮定として受ける）、導出版（`∃` を剥がして渡す）。sorry 検査 1365 件。check 454 ブロック・PDF 247 ページ通過。
  レビュー: 前 tick の「対数順序群の元の実現は $\mathrm{rat}_\Lambda$ の実対数」の本文（準備三つ・一続き八段）と Lean 具体版（`realLog_prod`・`realizeRational_toRational` の八段）を突き合わせて一致。修正なし。次は「下組の実現像の上限として開境界正方形の自由エネルギー密度を定める（実数体への脱出: 完備性）」。

- **2026-08-17 の tick 363 は、台帳の先頭行「対数順序群の元の実現は $\mathrm{rat}_\Lambda$ の実対数である（実数体への脱出: 実対数）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_log_order_group_realization_real_log`（`claim_real_logarithm_int_power` の直後・`remark_real_escape_plan` の直前、住処 R、`realEscape` は「実対数（$\rho_{\mathbb R}$ と $\log_{\mathbb R}$ の値どうしの等式。乗法を加法へ移すことと $\iota$ が乗法・逆数を保つことだけ）」）: $\lambda\in\Lambda$ で $\rho_{\mathbb R}(\iota_{\Lambda\to\Lambda_{\mathbb Q}}(\lambda))=\log_{\mathbb R}(\iota_{\mathbb Q\to\mathbb R}(\mathrm{rat}_\Lambda(\lambda)))$。証明は準備三つ（台の一致、$\iota$ が整数冪・有限積を保つ、有限積の実対数は和（元の個数の帰納法。空集合は `claim_real_logarithm_int_power` を $k:=0$ で））と一続き八段（定義・台の一致・$\iota_{\Lambda\to\Lambda_{\mathbb Q}}$ の定義・整数冪の実対数・$\iota$ が整数冪を保つ・有限積の実対数は和・$\iota$ が有限積を保つ・$\mathrm{rat}_\Lambda$ の定義）。狭義単調性は使わない。`remark_real_escape_plan` の冒頭と脱出の項に参照を足した。
  SageMath `check/log-order-group-realization-real-log/`（$\ell_p$ を記号のまま持つ模型。10724 検査、4 秒）。Lean 具体版 `ThermodynamicLimit/LogOrderGroupRealizationRealLog.lean`（`realLog_prod`（`Finset.induction_on` と `realLog_mul`。`Real.log_prod` は使わない）・`realizeRational_toRational`（`Finsupp.support_mapRange_of_injective`・`toRational_apply`・`realLog_zpow`・`Rat.cast_zpow`・`realLog_prod`・`Rat.cast_prod`・`rfl` が八段に対応））、必要十分版 `NecSuf/ThermodynamicLimit/LogOrderGroupRealizationRealLog.lean`（`map_prod_necSuf`・`realize_int_prod_necSuf`。`[CommGroup G] [AddCommGroup A]`、乗法を加法へ移す写像だけ。可換性は有限積・有限和を作るために要る。$\iota_{\mathbb Q\to\mathbb R}$ の読み替えは導出版に置く）、導出版（`positive_val_prod`・`Positive.coe_zpow`・`Rat.cast_zpow`・`Rat.cast_prod`）。sorry 検査 1360 件。check 453 ブロック・PDF 246 ページ通過。
  レビュー: 前 tick の「整数冪の実対数は整数倍」の本文（準備・帰納法・逆数・符号の場合分け）と Lean 具体版（`realLog_one`・`realLog_pow`・`realLog_inv`・`realLog_zpow`）・必要十分版（`Group`・`AddGroup`）を突き合わせて一致。修正なし。次は「有理係数の対数順序群の実現写像は順序を保つ」。

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
- 熱力学極限: 80 セクション
- 全章（何も言っていない主張の一掃）: 1 セクション
- 零点の詰め寄り・固有値の代数性（本文の lean: から引かれていない Lean の配線）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 周期境界自由エネルギー密度への移送 | todo | 周期境界と開境界の境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録
- 2026-08-17（tick 367）: 台帳の先頭行「本文の lean: から引かれていない Lean の配線」を実行した。章「零点の詰め寄り」の五ブロック（三定義と二主張）と章「固有値の代数性」の二主張の `lean:` に、既存の Lean 宣言 28 件を足した（本文・Lean は不変。Lean 対応先 1268 件、閉包外 0 ファイル）。式変形統一を再開し、姉妹側「冪等行列のトレースは像の次元」を一続きの形へ書き換えた。

- 2026-08-17（tick 366）: 台帳の先頭行「削除した実数値経路の Lean の後片付け」を実行した。本文の `lean:` から辿れる import 閉包の外にある実数値経路の Lean 61 ファイルを削除し、可算側だけが使う `allPlusConfig`・`allPlusConfig_brokenBondCount_eq_zero` を `ConstantPlusConfiguration.lean` へ切り出し、`OpenSquareFreeEnergyDensitySup` の `Sup` を外した。sorry 検査 1274 件。閉包の外に残った 8 ファイル（零点の詰め寄りの三定義と固有値の代数性の導出版二つ。実数値経路ではない）を配線する行をセクション表の先頭へ足した。式変形統一は一時停止中のため実施せず。

- 2026-08-17（tick 365）: 台帳の先頭行「下組の実現像の上限として開境界正方形の自由エネルギー密度を定める（実数体への脱出: 完備性）」を実行し、`def_open_square_free_energy_density` を `claim_rational_log_order_group_realization_monotone` の直後に置いた。
  定義のみ（SageMath は置かない）。Lean 具体版 `OpenSquareFreeEnergyDensitySup.lean`（`sSup`・`le_csSup`・`csSup_le`。旧実数値経路の同名ファイルと衝突するので `Sup` を付けた）を書き、入口 import・sorry 検査へ 5 件登録（計 1370 件）。`remark_real_escape_plan` の題名から「まだ書いていない」を外した。式変形統一は一時停止中のため実施せず。

- 2026-08-17（tick 364）: 台帳の先頭行「有理係数の対数順序群の実現写像は順序を保つ（実数体への脱出: 実対数）」を実行し、`claim_rational_log_order_group_realization_monotone` を `claim_log_order_group_realization_real_log` の直後に置いた。
  証明は順序の証人・準備一つ（$0<\iota(N)$）・含意の鎖六段・最後の三段だけ。SageMath `rational-log-order-group-realization-monotone`（可算側は厳密、実数側は区間演算 `RealBallField`。理由を overview に明記）、Lean 具体版・必要十分版（値の側だけ順序体、可算側の型は構造なし、順序の証人を仮定として受ける）・導出版を書き、入口 import・sorry 検査へ 5 件登録（計 1365 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-17（tick 363）: 台帳の先頭行「対数順序群の元の実現は $\mathrm{rat}_\Lambda$ の実対数である（実数体への脱出: 実対数）」を実行し、`claim_log_order_group_realization_real_log` を `claim_real_logarithm_int_power` の直後に置いた。
  証明は準備三つ（台の一致、$\iota$ が整数冪・有限積を保つ、有限積の実対数は和）と一続き八段だけ。SageMath `log-order-group-realization-real-log`（$\ell_p$ を記号のまま持つ模型）、Lean 具体版・必要十分版（`CommGroup`・`AddCommGroup`、乗法を加法へ移す写像だけ）・導出版を書き、入口 import・sorry 検査へ 5 件登録（計 1360 件）。式変形統一は一時停止中のため実施せず。

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
- 2026-08-17（tick 367）: 前 tick の切り出し `ThermodynamicLimit/ConstantPlusConfiguration.lean`（`allPlusConfig`・`allPlusConfig_brokenBondCount_eq_zero`。import は `PartitionPolynomial.Basic` だけ）と本文 `def_constant_plus_configuration`（各頂点に $+1$ の定数写像）・`claim_constant_plus_breaks_no_bond`（破れボンド数 $0$）を突き合わせ、一致した。
  「何も言っていない主張」の観点: 定数配位の破れボンド数が零であることは値の確定（$\mathbb N$ の元 $0$）で、正の有理点での値の下界が引くので残す。今 tick に配線した零点の詰め寄りの五ブロックは、住処 $R\subset\overline{\mathbb Q}$ の確定・零点でないことの根拠・後の言明が引く述語であり残す。本文末尾「この先に書くこと」と台帳のセクション表は食い違いなし。本文の修正は無い。

- 2026-08-17（tick 366）: 前 tick の「下組の実現像の上限として開境界正方形の自由エネルギー密度を定める」の本文（像の定義・空でない・上に有界の含意の鎖二段・完備性で上限・上界である／最小である・$\rho_{\mathbb R}(-\iota(\ell_2))\le f^{\mathrm{op}}(q)\le b(q)$）と Lean 具体版（`openSquareRealizedLowerSet`・`_nonempty`・`realizeRational_le_realizeRational_upperBound_of_mem_openSquareDensityLowerSet`（二段）・`_bddAbove`・`sSup`・`le_csSup`・`csSup_le`）を突き合わせ、一致した。
  「何も言っていない主張」の観点: 定義ブロックの中の空でない・上に有界は独立ブロックにしておらず、値の住処（$\mathbb R$ の部分集合が上限を持つ前提）を言うので残す。本文末尾「この先に書くこと」と台帳のセクション表は食い違いなし。本文の修正は無い。

- 2026-08-17（tick 365）: 前 tick の「有理係数の対数順序群の実現写像は順序を保つ」の本文（順序の証人・準備 $0<\iota(N)$・含意の鎖六段・最後の三段）・SageMath overview（286452 検査、実数側は区間演算）・Lean 具体版（`obtain`・`h1`〜`h6`・`calc` が本文と 1 対 1）・必要十分版（値の側だけ順序体、可算側の型は構造なし）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: 順序保存は今 tick の定義が上界の存在のために引くので残す。今 tick の定義は、実数体の完備性を使う唯一の位置を宣言するもので、well-defined 性（空でない・上に有界）を独立ブロックにせず statement 内の含意の鎖に置いた。本文末尾「この先に書くこと」から済んだ項目（切断による脱出）を外し、台帳のセクション表と食い違いなし。本文の修正は無い。

- 2026-08-17（tick 364）: 前 tick の「対数順序群の元の実現は $\mathrm{rat}_\Lambda$ の実対数」の本文（準備三つ・一続き八段）・SageMath overview（10724 検査）・Lean 具体版（`realLog_prod`（`Finset.induction_on`・`realLog_mul`）・`realizeRational_toRational` の八段が本文と 1 対 1。`Real.log_prod` は使わない）・必要十分版（`CommGroup`・`AddCommGroup`、乗法を加法へ移す写像だけ）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: 前 tick の主張は可算側の量と実数側の量を結ぶ等式で今 tick が引くので残す。今 tick の順序保存は、可算側で決定可能な順序が実現の側で保たれることを言い、上限の存在（下組の実現像が上に有界であること）が引くので残す。準備の $0<\iota(N)$ は独立ブロックにせず証明の中に置いた。本文末尾「この先に書くこと」と台帳のセクション表は食い違いなし。修正は無い。

- 2026-08-17（tick 363）: 前 tick の「整数冪の実対数は整数倍」の本文（準備 $\log_{\mathbb R}(1)=0$・自然数冪の帰納法・逆数・$k<0$ の六段）・SageMath overview（1246 検査）・Lean 具体版（`realLog_one`・`realLog_pow`・`realLog_inv`・`realLog_zpow` が本文の四つの部分に 1 対 1。`realLog_mul` だけを使う）・必要十分版（`Group`・`AddGroup`、乗法を加法へ移す写像だけ）・導出版（`Positive` の群構造）を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: 整数冪の実対数は今 tick の主張が各素数について引く形で残す。今 tick の「$\Lambda$ の元の実現は $\mathrm{rat}_\Lambda$ の実対数」は可算側の量（正の有理数）と実数側の量（実現）を結ぶ等式で、順序保存が $\Lambda$ の順序を実対数の単調性へ移すために引くので残す。本文末尾「この先に書くこと」と台帳のセクション表は食い違いなし。修正は無い。

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

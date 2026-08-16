# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-17 の tick 364 は、台帳の先頭行「有理係数の対数順序群の実現写像は順序を保つ（実数体への脱出: 実対数）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_rational_log_order_group_realization_monotone`（`claim_log_order_group_realization_real_log` の直後・`remark_real_escape_plan` の直前、住処 R、`realEscape` は「実対数（$\rho_{\mathbb R}$ の値どうしの不等式。$\iota_{\mathbb Q\to\mathbb R}$ の順序保存、$\log_{\mathbb R}$ の単調性、$\mathbb R$ が順序体であることだけ）」）: $\lambda,\mu\in\Lambda_{\mathbb Q}$ で $\lambda\le_{\Lambda_{\mathbb Q}}\mu\Rightarrow\rho_{\mathbb R}(\lambda)\le\rho_{\mathbb R}(\mu)$。証明は順序の定義から証人 $N\ge1,\lambda_N,\mu_N$ を取り、準備一つ（$0<\iota(N)$、$0<\iota(N)^{-1}$）、含意の鎖六段（$\Lambda$ の順序の定義・$\iota$ の順序保存・実対数の単調性・`claim_log_order_group_realization_real_log`・共通分母の定義・`claim_rational_log_order_group_realization_smul` を $r:=N$ で）、最後の一続き三段（$\rho(\lambda)=\iota(N)^{-1}(\iota(N)\rho(\lambda))\le\iota(N)^{-1}(\iota(N)\rho(\mu))=\rho(\mu)$。正の元を左から掛けても順序が保たれる）。完備性は使わない。`remark_real_escape_plan` の冒頭と脱出の項の「順序を保つことはこれから示す」をこの主張への参照に直した。
  SageMath `check/rational-log-order-group-realization-monotone/`（可算側の段は `ZZ`/`QQ` の厳密計算、実数側の段は区間演算 `RealBallField(256)`——素数の実対数は超越数なので、丸めを区間で包む厳密な包含で不等式を判定し、区間が重なれば FAIL とする。理由は overview に記した。標本 218 個、順序対 23871 組、286452 検査、14 秒）。Lean 具体版 `ThermodynamicLimit/RationalLogOrderGroupRealizationMonotone.lean`（`natCast_real_pos`・`realizeRational_le_of_rationalLogOrderLE`。`Rat.cast_le`・`realLog_le_realLog`・`realizeRational_toRational`・`IsCommonDenominator`・`realizeRational_smul`・`inv_pos`・`inv_mul_cancel₀`・`mul_le_mul_of_nonneg_left` が六段と三段に 1 対 1）、必要十分版 `NecSuf/ThermodynamicLimit/RationalLogOrderGroupRealizationMonotone.lean`（`le_of_smul_le_smul_necSuf`（順序体で正の元を外す三段）・`realize_monotone_of_common_denominator_necSuf`。値の側だけ `Field`＋`LinearOrder`＋`IsStrictOrderedRing`、$\Lambda_{\mathbb Q}$・$\Lambda$・$\mathbb Q$・$\mathbb R_{>0}$ に当たる型は代数構造なし（$\mathbb Q$ に当たる型の半順序だけ）、順序の証人を仮定として受ける）、導出版（`∃` を剥がして渡す）。sorry 検査 1365 件。check 454 ブロック・PDF 247 ページ通過。
  レビュー: 前 tick の「対数順序群の元の実現は $\mathrm{rat}_\Lambda$ の実対数」の本文（準備三つ・一続き八段）と Lean 具体版（`realLog_prod`・`realizeRational_toRational` の八段）を突き合わせて一致。修正なし。次は「下組の実現像の上限として開境界正方形の自由エネルギー密度を定める（実数体への脱出: 完備性）」。

- **2026-08-17 の tick 363 は、台帳の先頭行「対数順序群の元の実現は $\mathrm{rat}_\Lambda$ の実対数である（実数体への脱出: 実対数）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_log_order_group_realization_real_log`（`claim_real_logarithm_int_power` の直後・`remark_real_escape_plan` の直前、住処 R、`realEscape` は「実対数（$\rho_{\mathbb R}$ と $\log_{\mathbb R}$ の値どうしの等式。乗法を加法へ移すことと $\iota$ が乗法・逆数を保つことだけ）」）: $\lambda\in\Lambda$ で $\rho_{\mathbb R}(\iota_{\Lambda\to\Lambda_{\mathbb Q}}(\lambda))=\log_{\mathbb R}(\iota_{\mathbb Q\to\mathbb R}(\mathrm{rat}_\Lambda(\lambda)))$。証明は準備三つ（台の一致、$\iota$ が整数冪・有限積を保つ、有限積の実対数は和（元の個数の帰納法。空集合は `claim_real_logarithm_int_power` を $k:=0$ で））と一続き八段（定義・台の一致・$\iota_{\Lambda\to\Lambda_{\mathbb Q}}$ の定義・整数冪の実対数・$\iota$ が整数冪を保つ・有限積の実対数は和・$\iota$ が有限積を保つ・$\mathrm{rat}_\Lambda$ の定義）。狭義単調性は使わない。`remark_real_escape_plan` の冒頭と脱出の項に参照を足した。
  SageMath `check/log-order-group-realization-real-log/`（$\ell_p$ を記号のまま持つ模型。10724 検査、4 秒）。Lean 具体版 `ThermodynamicLimit/LogOrderGroupRealizationRealLog.lean`（`realLog_prod`（`Finset.induction_on` と `realLog_mul`。`Real.log_prod` は使わない）・`realizeRational_toRational`（`Finsupp.support_mapRange_of_injective`・`toRational_apply`・`realLog_zpow`・`Rat.cast_zpow`・`realLog_prod`・`Rat.cast_prod`・`rfl` が八段に対応））、必要十分版 `NecSuf/ThermodynamicLimit/LogOrderGroupRealizationRealLog.lean`（`map_prod_necSuf`・`realize_int_prod_necSuf`。`[CommGroup G] [AddCommGroup A]`、乗法を加法へ移す写像だけ。可換性は有限積・有限和を作るために要る。$\iota_{\mathbb Q\to\mathbb R}$ の読み替えは導出版に置く）、導出版（`positive_val_prod`・`Positive.coe_zpow`・`Rat.cast_zpow`・`Rat.cast_prod`）。sorry 検査 1360 件。check 453 ブロック・PDF 246 ページ通過。
  レビュー: 前 tick の「整数冪の実対数は整数倍」の本文（準備・帰納法・逆数・符号の場合分け）と Lean 具体版（`realLog_one`・`realLog_pow`・`realLog_inv`・`realLog_zpow`）・必要十分版（`Group`・`AddGroup`）を突き合わせて一致。修正なし。次は「有理係数の対数順序群の実現写像は順序を保つ」。

- **2026-08-17 の tick 362 は、台帳の先頭行「対数順序群の元の実現は $\mathrm{rat}_\Lambda$ の実対数である」が二つの帰納法（整数冪の実対数、台の大きさ）を含むので二行へ割り、その最初「整数冪の実対数は整数倍である（実数体への脱出: 実対数）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_real_logarithm_int_power`（`claim_rational_log_order_group_realization_smul` の直後・`remark_real_escape_plan` の直前、住処 R、`realEscape` は「実対数（$\log_{\mathbb R}$ の値どうしの等式。乗法を加法へ移すことと $\mathbb R$ の加法群の移項だけ）」）: $u\in\mathbb R_{>0}$、$k\in\mathbb Z$ で $\log_{\mathbb R}(u^k)=\iota_{\mathbb Q\to\mathbb R}(k)\cdot\log_{\mathbb R}(u)$。証明は準備 $\log_{\mathbb R}(1)=0$（$1=1\cdot1$・乗法を加法へ・移項）、自然数冪の帰納法（$n=0$ 三段、$n\to n+1$ 五段）、逆数 $\log_{\mathbb R}(v^{-1})=-\log_{\mathbb R}(v)$（三段・移項）、$k<0$ の六段。狭義単調性は使わない。`remark_real_escape_plan` の冒頭と脱出の項に参照を足した。
  SageMath `check/real-logarithm-int-power/`（$\ell_p$ を記号のまま持ち、正の有理数 $u=\prod p^{e_p}\mapsto\sum e_p\ell_p$ を「乗法を加法へ移す写像」の模型として各段を検査。1246 検査、3 秒。実数体そのものの上の等式は Lean が担う旨を overview に明記）。Lean 具体版 `ThermodynamicLimit/RealLogarithmIntPower.lean`（`realLog_one`・`realLog_pow`・`realLog_inv`・`realLog_zpow`。`realLog_mul` だけを使い `Real.log_pow`・`Real.log_zpow` は使わない）、必要十分版 `NecSuf/ThermodynamicLimit/RealLogarithmIntPower.lean`（`map_zpow_necSuf`。`[Group G] [AddGroup A]`、写像が乗法を加法へ移すことだけ。可換性・順序・完備性・狭義単調を使わない。`MonoidHom.map_zpow` は使わない）、導出版（`G:={t:\mathbb R\mid 0<t}` の mathlib の群構造。`Positive.coe_zpow` は `rfl`）。sorry 検査 1355 件。check 452 ブロック・PDF 245 ページ通過。
  レビュー: 前 tick の「実現写像は有理数倍と可換」の本文（準備一つ・一続き六段）と Lean 具体版（`Finsupp.support_smul`・`Finset.sum_subset`・`Finsupp.smul_apply`・`Rat.cast_mul`・`mul_assoc`・`Finset.mul_sum`）を突き合わせて一致。修正なし。次は「対数順序群の元の実現は $\mathrm{rat}_\Lambda$ の実対数である」。

- **2026-08-17 の tick 361 は、台帳の先頭行「実現写像は有理数倍と可換（実数体への脱出: 実対数）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_rational_log_order_group_realization_smul`（`def_rational_log_order_group_realization` の直後・`remark_real_escape_plan` の直前、住処 R、`realEscape` は「実対数（$\rho_{\mathbb R}$ の値どうしの等式。$\mathbb R$ の結合則と分配則）」）: $r\in\mathbb Q$、$\mu\in\Lambda_{\mathbb Q}$ で $\rho_{\mathbb R}(r\cdot\mu)=\iota_{\mathbb Q\to\mathbb R}(r)\cdot\rho_{\mathbb R}(\mu)$。証明は準備一つ（$\mu(p)=0\Rightarrow(r\mu)(p)=0$ で $\operatorname{supp}(r\mu)\subset\operatorname{supp}\mu$）と一続き六段（定義／台を含む有限集合に渡る和は同じ値／有理数倍の定義／$\iota$ の乗法保存／$\mathbb R$ の結合則／分配則を有限和へ／定義）。実対数の性質は使わない。`remark_real_escape_plan` の冒頭と脱出の項にこの主張への参照を足した。
  SageMath `check/rational-log-order-group-realization-smul/`（$\ell_p$ を $\mathbb Q$ 上の多項式環の不定元として記号のまま持ち、実対数の値は計算しない。344 標本 × 7 倍率、18235 検査、1 秒未満）。Lean 具体版 `ThermodynamicLimit/RationalLogOrderGroupRealizationSmul.lean`（`realizeRational_smul`。`Finsupp.support_smul`・`Finset.sum_subset`・`Finsupp.smul_apply`・`Rat.cast_mul`・`mul_assoc`・`Finset.mul_sum` が六段に 1 対 1）、必要十分版 `NecSuf/ThermodynamicLimit/RationalLogOrderGroupRealizationSmul.lean`（`realizeWith`・`realizeWith_smul_necSuf`。`[MulZeroClass K] [NonUnitalSemiring R]`、$\iota$ の乗法保存と $\iota(0)=0$ を仮定として受け、重み $w:P\to R$ は任意。単位元・逆元・順序・実対数を使わない）、導出版（$\rho_{\mathbb R}$ と `realizeWith` の一致は `rfl`）。sorry 検査 1349 件。check 451 ブロック・PDF 244 ページ通過。
  レビュー: 前 tick の二定義と Lean を突き合わせて一致。`def_rational_log_order_group_realization` の末尾「加法・有理数倍・順序をどう保つかは続く主張で示す」の「加法」は台帳のどの行も示す予定が無い（順序保存の証明が加法を使わない）ので「有理数倍と順序」に直し、加法は述べない旨を添えた。次は「対数順序群の元の実現は $\mathrm{rat}_\Lambda$ の実対数である」。

- **2026-08-17 の tick 360 は、台帳の先頭行「有理係数の対数順序群の実現写像は順序を保つ（実数体への脱出: 実対数）」を論法の数で四行へ割り、その最初「実数体と実対数、および実現写像 $\rho_{\mathbb R}$ の定義（実数体への脱出: 実対数）」を本文・Lean まで書いた（定義のみ。SageMath 検証は定義には置かない）。**
  `def_real_logarithm`（本文で初めて住処 R を宣言。$\mathbb R$ は $\mathbb Q$ を部分体として含む順序体、包含 $\iota_{\mathbb Q\to\mathbb R}$ に名前を置いて有理数を実数として読むときは必ず通す、$\mathbb R_{>0}$、実対数 $\log_{\mathbb R}:\mathbb R_{>0}\to\mathbb R$。使う性質は乗法を加法へ移すことと狭義単調（したがって $u\le v\Rightarrow\log u\le\log v$）の二つだけと宣言。級数・微分・完備性は使わない。`realEscape` は「実対数」）と `def_rational_log_order_group_realization`（$\rho_{\mathbb R}(\mu):=\sum_{p\in\operatorname{supp}\mu}\iota_{\mathbb Q\to\mathbb R}(\mu(p))\cdot\log_{\mathbb R}(\iota_{\mathbb Q\to\mathbb R}(p))$。$\mu(p)=0$ の項が $0$ なので台を含む任意の有限集合に渡る和で同じ値。`realEscape` は「実対数」）。いずれも `claim_open_square_density_lower_set_le_upper_bound` の直後・`remark_real_escape_plan` の直前。`remark_real_escape_plan` の冒頭「ここまで実数体は現れていない」を「直前の二つの定義を除き」に直し、脱出の項に両定義への参照を足した。
  Lean `ThermodynamicLimit/RationalLogOrderGroupRealization.lean`（`PositiveReal`・`realLog`・`realLog_mul`（`Real.log_mul`）・`realLog_lt_realLog`（`Real.log_lt_log`）・`realLog_le_realLog`・`primePositiveReal`・`realizeRational`（`Finsupp.sum`）・`realizeRational_eq_sum_support`（`rfl`）。定義ブロックなので必要十分版は無い）。入口 import・sorry 検査へ 4 件登録（計 1346 件）。check 450 ブロック・PDF 243 ページ通過。
  割り方: 「実対数と実現写像の定義」→「実現写像は有理数倍と可換（$\rho_{\mathbb R}(r\cdot\mu)=\iota_{\mathbb Q\to\mathbb R}(r)\rho_{\mathbb R}(\mu)$。$\mathbb R$ の分配則を有限和へ）」→「$\Lambda$ の元の実現は $\mathrm{rat}_\Lambda$ の実対数（$\rho_{\mathbb R}(\iota_{\Lambda\to\Lambda_{\mathbb Q}}(\lambda))=\log_{\mathbb R}(\iota_{\mathbb Q\to\mathbb R}(\mathrm{rat}_\Lambda(\lambda)))$。台の大きさについての帰納法、積の対数と整数冪の対数）」→「実現写像は順序を保つ（共通分母 $N$ で $\lambda_N\le_\Lambda\mu_N$、$\mathrm{rat}_\Lambda$ の比較、実対数の単調性、前二行、$N>0$ で割る）」。
  レビュー: 前 tick が台帳から外した tick 354 の記録が保管庫へ移されていなかったので復元した（本文の修正は無い）。次は「実現写像は有理数倍と可換」。


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
- 熱力学極限: 78 セクション
- 全章（何も言っていない主張の一掃）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 下組の実現像の上限として開境界正方形の自由エネルギー密度を定める（実数体への脱出: 完備性） | todo | $f^{\mathrm{op}}(q):=\sup\rho_{\mathbb R}(A)$。空でない・上に有界（前二行と順序保存）から上限の存在。住処 R、`realEscape` 必須。定義したら `remark_real_escape_plan` の題名から「まだ書いていない」を外す |
| 熱力学極限 | 削除した実数値経路の Lean の後片付け | todo | 2026-08-16 に本文から消した実数値経路（実対数・上限／下限による極限）の Lean ファイルが孤立して残っている。入口からの import と sorry 検査は通るが、対応する本文が無いので消す |
| 熱力学極限 | 周期境界自由エネルギー密度への移送 | todo | 周期境界と開境界の境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録
- 2026-08-17（tick 364）: 台帳の先頭行「有理係数の対数順序群の実現写像は順序を保つ（実数体への脱出: 実対数）」を実行し、`claim_rational_log_order_group_realization_monotone` を `claim_log_order_group_realization_real_log` の直後に置いた。
  証明は順序の証人・準備一つ（$0<\iota(N)$）・含意の鎖六段・最後の三段だけ。SageMath `rational-log-order-group-realization-monotone`（可算側は厳密、実数側は区間演算 `RealBallField`。理由を overview に明記）、Lean 具体版・必要十分版（値の側だけ順序体、可算側の型は構造なし、順序の証人を仮定として受ける）・導出版を書き、入口 import・sorry 検査へ 5 件登録（計 1365 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-17（tick 363）: 台帳の先頭行「対数順序群の元の実現は $\mathrm{rat}_\Lambda$ の実対数である（実数体への脱出: 実対数）」を実行し、`claim_log_order_group_realization_real_log` を `claim_real_logarithm_int_power` の直後に置いた。
  証明は準備三つ（台の一致、$\iota$ が整数冪・有限積を保つ、有限積の実対数は和）と一続き八段だけ。SageMath `log-order-group-realization-real-log`（$\ell_p$ を記号のまま持つ模型）、Lean 具体版・必要十分版（`CommGroup`・`AddCommGroup`、乗法を加法へ移す写像だけ）・導出版を書き、入口 import・sorry 検査へ 5 件登録（計 1360 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-17（tick 362）: 台帳の先頭行「対数順序群の元の実現は $\mathrm{rat}_\Lambda$ の実対数である」は、整数冪の実対数（$k$ の帰納法と符号の場合分け）と、$\Lambda$ の元の台の大きさの帰納法の二つの論法を含むので二行へ割った。その最初「整数冪の実対数は整数倍である」を実行し、`claim_real_logarithm_int_power` を `claim_rational_log_order_group_realization_smul` の直後に置いた。
  証明は準備（$\log_{\mathbb R}(1)=0$）・自然数冪の帰納法・逆数・符号の場合分けだけ。SageMath `real-logarithm-int-power`（$\ell_p$ を記号のまま持つ模型）、Lean 具体版・必要十分版（`Group`・`AddGroup`、乗法を加法へ移す写像だけ）・導出版を書き、入口 import・sorry 検査へ 6 件登録（計 1355 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-17（tick 361）: 台帳の先頭行「実現写像は有理数倍と可換（実数体への脱出: 実対数）」を実行し、`claim_rational_log_order_group_realization_smul` を `def_rational_log_order_group_realization` の直後に置いた。
  証明は台の包含の準備一つと一続き六段（定義・台を含む有限集合の和・有理数倍の定義・$\iota$ の乗法保存・結合則・分配則・定義）だけ。SageMath `rational-log-order-group-realization-smul`（$\ell_p$ を記号のまま多項式環で比較）、Lean 具体版・必要十分版（`MulZeroClass`・`NonUnitalSemiring`、$\iota$ の乗法保存と $\iota(0)=0$、重みは任意）・導出版を書き、入口 import・sorry 検査へ 3 件登録（計 1349 件）。式変形統一は一時停止中のため実施せず。

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
- 2026-08-17（tick 364）: 前 tick の「対数順序群の元の実現は $\mathrm{rat}_\Lambda$ の実対数」の本文（準備三つ・一続き八段）・SageMath overview（10724 検査）・Lean 具体版（`realLog_prod`（`Finset.induction_on`・`realLog_mul`）・`realizeRational_toRational` の八段が本文と 1 対 1。`Real.log_prod` は使わない）・必要十分版（`CommGroup`・`AddCommGroup`、乗法を加法へ移す写像だけ）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: 前 tick の主張は可算側の量と実数側の量を結ぶ等式で今 tick が引くので残す。今 tick の順序保存は、可算側で決定可能な順序が実現の側で保たれることを言い、上限の存在（下組の実現像が上に有界であること）が引くので残す。準備の $0<\iota(N)$ は独立ブロックにせず証明の中に置いた。本文末尾「この先に書くこと」と台帳のセクション表は食い違いなし。修正は無い。

- 2026-08-17（tick 363）: 前 tick の「整数冪の実対数は整数倍」の本文（準備 $\log_{\mathbb R}(1)=0$・自然数冪の帰納法・逆数・$k<0$ の六段）・SageMath overview（1246 検査）・Lean 具体版（`realLog_one`・`realLog_pow`・`realLog_inv`・`realLog_zpow` が本文の四つの部分に 1 対 1。`realLog_mul` だけを使う）・必要十分版（`Group`・`AddGroup`、乗法を加法へ移す写像だけ）・導出版（`Positive` の群構造）を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: 整数冪の実対数は今 tick の主張が各素数について引く形で残す。今 tick の「$\Lambda$ の元の実現は $\mathrm{rat}_\Lambda$ の実対数」は可算側の量（正の有理数）と実数側の量（実現）を結ぶ等式で、順序保存が $\Lambda$ の順序を実対数の単調性へ移すために引くので残す。本文末尾「この先に書くこと」と台帳のセクション表は食い違いなし。修正は無い。

- 2026-08-17（tick 362）: 前 tick の「実現写像は有理数倍と可換」の本文（台の包含の準備と一続き六段）・SageMath overview（18235 検査）・Lean 具体版（`realizeRational_eq_sum_support`・`Finsupp.support_smul`＋`Finset.sum_subset`・`Finsupp.smul_apply`・`Rat.cast_mul`・`mul_assoc`・`Finset.mul_sum` が六段に 1 対 1）・必要十分版（`MulZeroClass`・`NonUnitalSemiring`、$\iota$ の乗法保存と $\iota(0)=0$）・導出版（`rfl`）を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: 有理数倍との可換性は順序保存の証明が $N$ で割り戻すために引く写像の性質で残す。今 tick の整数冪の実対数は、次の「$\Lambda$ の元の実現は $\mathrm{rat}_\Lambda$ の実対数」が各素数について引く形で、乗法を加法へ移すことだけから帰納法で出す実対数の性質（$\mathbb R$ の四則から直ちには従わない）なので残す。本文末尾「この先に書くこと」と台帳のセクション表は食い違いなし。修正は無い。

- 2026-08-17（tick 361）: 前 tick の「実数体と実対数」「有理係数の対数順序群の実現写像」の二定義の本文・Lean（`PositiveReal`・`realLog`・`realLog_mul`・`realLog_lt_realLog`・`realLog_le_realLog`・`primePositiveReal`・`realizeRational`・`realizeRational_eq_sum_support`）を突き合わせ、宣言した性質（乗法を加法へ・狭義単調）と定義の形（台に渡る和）が一致した。
  「何も言っていない主張」の観点: 二定義は実数体への脱出の位置と理由を宣言するもので残す。今 tick の有理数倍との可換性は $\rho_{\mathbb R}$ という写像の性質（台の付け替えを含む）で、順序保存の証明が $N$ で割り戻すために引くので残す。**修正 1 件**: `def_rational_log_order_group_realization` の末尾が「加法・有理数倍・順序をどう保つかは続く主張で示す」と加法を約束していたが、台帳のどの行も加法を示さない（順序保存は共通分母と有理数倍だけで閉じる）ので「有理数倍と順序」に直し、加法は述べない旨を添えた。本文末尾「この先に書くこと」と台帳のセクション表は食い違いなし。

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

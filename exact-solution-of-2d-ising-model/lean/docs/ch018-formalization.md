# 章 018「偶セクターの完結（Onsager の厳密解）」の Lean 形式化

正本: `structured-latex/content/018_even_sector_closing.ts`（12 ブロック）

この文書は `lean/README.md` への統合前の記録である（統合は呼び出し元が行う）。

## 0. 土台の選択と「仮定として受け取るもの」

章 018 は**本プロジェクトの結論**（Onsager の自由エネルギー）に至る章であり、
章 014–017（半整数運動量のフェルミオン `ψ̌_μ^†, ψ̌_μ`、個数演算子 `ň_μ`、
同時固有射影 `Q̌_ε`、`V^{(+)}` の固有値 `Λ̌_ε`）の上に立つ。
**本章の形式化に着手した時点で、それらは本リポジトリの Lean 側に存在しなかった**
（`Ising2D/` に `Part016` / `Part017` が無く、`Part014`（章 014「偶セクターでの `T` の作用」）
にも `ψ̌` / `ň` / `Q̌` は現れなかった）。

そこで**章 014–017 から受け取る入力だけを束ねた構造**を置き、章 018 の主張は
すべてそこからの帰結として証明した。

| 構造 | 場所 | 受け取る内容（すべて原文の主張そのまま） | 出典の章 |
| --- | --- | --- | --- |
| `Ising2D.CheckFermi` | `Part018/Setup.lean` | `ψ̌` の正準反交換関係（`anticommutator_of_check_psi`）、`(ψ̌_μ^†)^* = ψ̌_{M+1-μ}`（`check_number_operator_is_hermitian` (3)） | 016 |
| `Ising2D.VPlusData` | `Part018/Claim003_TraceEpsilonVPlus.lean` | `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε`、`Λ̌_ε = C·exp(∑_μ γ(θ̃_μ)(ε_μ − 1/2))`、`C > 0`、`γ(θ̃_μ) > 0`（`eigenvalues_of_V_plus`, `def_gamma_theta_tilde_mu`） | 015・017 |
| `Ising2D.EvenSectorBridge` | `Part018/Theorem009_CPlusEqualsLambda.lean` | 章 011 の実行列 `W` と章 017 の複素行列 `V^{(+)}` の橋渡し（`W P^{(+)} = V^{(+)} P^{(+)}`、`V^{(+)}` が実行列であること） | 011・017 |

**`ε` が `Ž, Y̌` と反可換であること（`epsilon_anticommutes_with_check_Z_Y` (1)(2)）は
仮定していない。** 章 004・010・013 の形式化済みの定理から**無条件に**従う。

演算の土台は、章 018 の主鎖では**複素行列 `TensorPow M = Matrix (Conf M) (Conf M) ℂ`**、
章 011・019 と接続する部分では**実行列 `Matrix (Conf M) (Conf M) ℝ`** である。
両者の橋渡しは `Ising2D.cvec`（実ベクトルの複素化）と `Ising2D.EvenSectorBridge.reVec`
（複素ベクトルの実部）で行い、章 019 の `epsilon_eq_ofReal_epsilonR` と同じ性質のものである。

**実数解析（極限・積分・連続性）へ移行するのは、章 012 の
`Ising2D.riemann_sum_to_integral` を経由する最後の等号だけ**である（人手証明の最終段落と同じ）。

## 1. 形式化した定理の一覧

### 1.1 具体版（`lean/Ising2D/Part018/`）

#### `Setup.lean`（章 014–017 からの入力と、その直接の帰結）

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Ising2D.CheckFermi` | 章 016 から受け取る入力（`ψ̌_μ^†`, `ψ̌_{M+1-μ}` と CAR） | `def_check_fermi` / `anticommutator_of_check_psi` |
| `Ising2D.CheckFermi.nOp` | `ň_μ = ψ̌_μ^† ψ̌_{M+1-μ}` | `def_check_number_operator` |
| `CheckFermi.cre_sq` / `ann_sq` / `ann_mul_cre` / `acomm_cre_ann_self` | `(ψ̌^†)² = 0`, `ψ̌² = 0`, `ψ̌ψ̌^† = I − ň` | `anticommutator_of_check_psi` |
| `CheckFermi.nOp_mul_self` | `ň_μ² = ň_μ`（射影） | `def_check_number_operator` |
| `CheckFermi.commute_cre_nOp` / `commute_ann_nOp` / `commute_nOp_nOp` | `ň` どうし・`ň` と `ψ̌` の可換性（異なる添字） | 同上 |
| `Ising2D.CheckFermi.Qproj` | `Q̌_ε = ∏_μ (ň_μ or I−ň_μ)` | `check_joint_eigenspace_decomposition` |
| `CheckFermi.Qproj_mul_self` / `Qproj_mul_Qproj_of_ne` / `sum_Qproj` | 直交射影系で和が `I` | 同上 |
| `CheckFermi.nOp_mul_Qproj` | `ň_μ Q̌_ε = ε_μ Q̌_ε` | 同上 |
| `CheckFermi.trace_Qproj` / `Qproj_ne_zero` | `tr Q̌_ε = 1`（`im Q̌_ε` は 1 次元） | 同上 |
| `CheckFermi.epsilon_anticomm_cre` / `epsilon_anticomm_ann` | `ε ψ̌^† = −ψ̌^† ε`, `ε ψ̌ = −ψ̌ ε` | `epsilon_anticommutes_with_check_Z_Y` (3) |
| **`CheckFermi.commute_epsilon_nOp` / `commute_epsilon_Qproj`** | **`ε ň_μ = ň_μ ε`, `ε Q̌_ε = Q̌_ε ε`** | **同 (4)** |
| `CheckFermi.ann_conjTranspose` / `nOp_conjTranspose` / `Qproj_conjTranspose` | `ψ̌^* = ψ̌^†`, `ň^* = ň`, `Q̌^* = Q̌` | `check_number_operator_is_hermitian` (3)(4) |

#### `Claim001_EpsilonAnticommutes.lean`（ラベル `epsilon_anticommutes_with_check_Z_Y`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.epsilon_anticomm_Z` / `epsilon_anticomm_Y` | `ε Z_j = −Z_j ε`, `ε Y_j = −Y_j ε` | (1)（章 010 で証明済み。再掲） |
| **`Ising2D.epsilon_anticomm_checkZ` / `epsilon_anticomm_checkY`** | **`ε Ž_μ = −Ž_μ ε`, `ε Y̌_μ = −Y̌_μ ε`** | **(2)** |
| `Ising2D.IsCheckMode` | 「`ψ̌_μ^†` は `Ž_μ, Y̌_μ` の ℂ 係数 1 次結合」（章 016 の入力を述語化） | `def_check_fermi` |
| **`Ising2D.epsilon_anticomm_of_isCheckMode`** | **`ε ψ̌_μ^† = −ψ̌_μ^† ε`** | **(3)** |

**(1)(2) は無条件**（章 004・010・013 の形式化済みの定理だけを使う）。

#### `Claim002_EpsilonEigenvalueOnQ.lean`（ラベル `epsilon_eigenvalue_on_check_Q`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.matrix_eq_of_mulVec_eq` | `∀x, Ax = Bx ⇒ A = B` | 補助 |
| `Ising2D.smul_cancel_of_matrix_ne_zero` | `Q ≠ 0`, `ηQ = η'Q ⇒ η = η'` | (1) の「一意に定まる」 |
| `CheckFermi.Qproj_eq` / `Qproj_mulVec_of_mem_range` / `finrank_range_Qproj` / `exists_Qproj_generator` | `im Q̌_ε` が 1 次元で、生成元 `q` がとれる | (1)（1 次元性はここだけで使う） |
| **`CheckFermi.exists_eta` / `eta` / `eta_mem` / `epsilon_mul_Qproj` / `eta_unique`** | **`∃! η_ε ∈ {±1}, ε Q̌_ε = η_ε Q̌_ε`** | **(1)** |
| **`CheckFermi.eta_insert`** | **反転則 `η_{ε[μ→1]} = −η_ε`** | **(2)** |
| `CheckFermi.eta_univ_eq_aux` | `|ε|` に関する帰納法の補助 | (3) |
| **`CheckFermi.eta_eq_eta_univ_mul`** | **`η_ε = η_{(1,…,1)}·(−1)^{M−|ε|}`** | **(3)** |
| `CheckFermi.parityFactor` / `parityProd` / `commute_parityFactor` | `∏_μ (I − 2ň_μ)` とその可換性 | (4) |
| `CheckFermi.parityFactor_mul_Qproj` / `parityProd_mul_Qproj` / `eq_of_mul_Qproj_eq` | 各因子が `Q̌_ε` にスカラー倍として働く／`Q̌_ε` 全体で行列が決まる | (4) |
| **`CheckFermi.epsilon_eq_parityProd`** | **`ε = η_{(1,…,1)}(−1)^M ∏_μ(I − 2ň_μ)`** | **(4)** |

#### `Claim003_TraceEpsilonVPlus.lean`（ラベル `trace_of_epsilon_V_plus_via_check_eigenvalues`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.checkLambda` | `Λ̌_ε = C·exp(∑_μ γ_μ(ε_μ − 1/2))` | `eigenvalues_of_V_plus` |
| `Ising2D.checkLambda_pos` / `checkLambda_le_univ` / `checkLambda_lt_univ` | `Λ̌_ε > 0`、`Λ̌_ε ≤ Λ̌_{(1,…,1)}`（`ε ≠ (1,…,1)` なら狭義） | 同 (2) |
| `Ising2D.VPlusData` | 章 015・017 から受け取る入力 | 同上 |
| `VPlusData.lamMax` / `lamMax_pos` / `checkLambda_le_lamMax` | `Λ̌_max = Λ̌_{(1,…,1)}` とその最大性 | 同 (2) |
| `VPlusData.epsilon_mul_V_mul_Qproj` | `εV^{(+)}Q̌_ε = η_ε Λ̌_ε Q̌_ε` | Step 1 |
| `VPlusData.trace_epsilon_mul_V_eq_sum` | `tr(εV^{(+)}) = ∑_ε η_ε Λ̌_ε` | Step 1 |
| `VPlusData.traceFactor` / `traceFactor_pos` | `C·∏_μ 2 sinh(γ_μ/2) > 0` | Step 2 |
| **`VPlusData.trace_epsilon_mul_V`** | **`tr(εV^{(+)}) = η_{(1,…,1)}·C·∏_μ 2 sinh(γ(θ̃_μ)/2)`** | **Step 2（定理本体）** |
| **`VPlusData.eta_univ_eq_one_of_trace_pos`** | **`tr(εV^{(+)}) > 0 ⇒ η_{(1,…,1)} = +1`** | Step 3 |

#### `Claim008_CheckQHermitian.lean`（ラベル `check_number_operator_is_hermitian`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.expPhase_conj` / `checkPhase_conj_star` | `conj(e^{−2πik/M}) = e^{2πik/M}` と半整数位相の共役 | (2) の計算 |
| **`Ising2D.checkZ_conjTranspose` / `checkY_conjTranspose`** | **`Ž_μ^* = Ž_{M+1−μ}`, `Y̌_μ^* = Y̌_{M+1−μ}`** | **(2)（無条件）** |
| `Ising2D.Z_conjTranspose` / `Y_conjTranspose` | `Z_j^* = Z_j`, `Y_j^* = Y_j` | (1)（章 009 で証明済み） |
| `CheckFermi.nOp_conjTranspose` / `Qproj_conjTranspose` | `ň_μ^* = ň_μ`, `Q̌_ε^* = Q̌_ε` | (4)（`Setup.lean`） |
| `EvenSectorBridge.quad_Qproj` | `x^* Q̌_ε x = ‖Q̌_ε x‖² ≥ 0` | (4) の帰結（`Theorem009_...`） |

#### `Theorem007_MaxEigenvectorEvenSector.lean`（ラベル `max_eigenvector_in_even_sector`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| **`VPlusData.eta_univ_eq_one`** | **`η_{(1,…,1)} = +1`** | **(1)**（`tr(εV^{(+)}) > 0` を仮定として受け取る。下記 3 を参照） |
| **`VPlusData.eta_eq_sign`** | **`η_ε = (−1)^{M−|ε|}`** | **(2)** |
| **`VPlusData.epsilon_eq_parityProd_of_trace_pos`** | **`ε = (−1)^M ∏_μ(I − 2ň_μ)`** | **(3)** |
| **`VPlusData.epsilon_mul_Qproj_univ`** | **`ε Q̌_{(1,…,1)} = Q̌_{(1,…,1)}`** | **(4)** |
| **`VPlusData.mem_evenSector_of_mem_range_univ`** | **最大固有ベクトルは偶セクター `𝓕^{(+)}` に属する** | **定理本体** |

#### `Theorem009_CPlusEqualsLambda.lean`（ラベル `c_plus_equals_Lambda_half_integer`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.cvec` / `cvec_ne_zero` / `star_cvec` / `cvec_mulVec` / `cvec_dotProduct` / `cvec_smul` | 実ベクトルの複素化とその基本性質 | 実／複素の橋渡し（新規） |
| `Ising2D.star_dotProduct_self` | `x^* x = ‖x‖²` | 同上 |
| `Ising2D.EvenSectorBridge` | 章 011 の `W` と章 017 の `V^{(+)}` の橋渡し（上記 0 の表） | 011・017 からの入力 |
| `EvenSectorBridge.quad_Qproj` | `x^* Q̌_ε x = ‖Q̌_ε x‖²` | `check_number_operator_is_hermitian` (4) |
| `EvenSectorBridge.sum_quad_Qproj` | `∑_ε ‖Q̌_ε x‖² = ‖x‖²` | Step 1 |
| `EvenSectorBridge.quad_Vr_eq_sum` | `x^T V^{(+)} x = ∑_ε Λ̌_ε ‖Q̌_ε x‖²` | Step 1 |
| **`EvenSectorBridge.quad_le_lamMax`** | **`x ∈ 𝓕^{(+)}, ‖x‖ = 1 ⇒ x^T W x ≤ Λ̌_max`** | **Step 1** |
| `EvenSectorBridge.reVec` / `cvec_reVec_add` / `reVec_eigen` | 複素固有ベクトルの実部も（実固有値なら）固有ベクトル | Step 2 |
| **`EvenSectorBridge.exists_real_max_eigenvector`** | **`Λ̌_max` の実固有ベクトルが存在し、偶セクターに属する** | **Step 2** |
| **`EvenSectorBridge.c_plus_equals_lamMax`** | **`c_+(M) = Λ̌_max`** | **定理本体（Step 3）** |
| `EvenSectorBridge.exists_maximizer` | 上限が偶セクターの実単位ベクトル `x_0` で**達成される** | 最後の一文 |

#### `Theorem010_OnsagerExactSolution.lean`（ラベル `onsager_exact_solution`、**本プロジェクトの結論**）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `EvenSectorBridge.lamMax_eq_LambdaM` | `Λ̌_max = Λ^{(1/2)}_M`（章 012 の記法との突き合わせ） | 記法の同定 |
| **`EvenSectorBridge.rayleighSup_eq_LambdaM`** | **`c(M) = Λ^{(1/2)}_M`**（章 019 の `c_equals_c_plus` と接続） | Step 2・Step 3 の代替（下記 4 を参照） |
| `Ising2D.onsager_limit_in_N_row` | `N_row → ∞` の極限は `(1/M) log c(M)` | Step 1（章 012 の `limit_of_log_Z_in_N_row`） |
| `Ising2D.onsager_limit_in_M` | `M → ∞` の極限が Onsager の表式になる | Step 4（章 012 の `onsager_free_energy_expression` を `δ = 1/2` で適用） |
| **`Ising2D.onsager_exact_solution`** | **`lim_{M→∞} lim_{N_row→∞} (1/(M N_row)) log Z = (1/2)log(2 sinh 2K_2) + (1/4π)∫₀^{2π} γ(θ)dθ`** | **定理本体** |

### 1.2 必要十分版（`lean/Ising2D/NecSuf/ParityFermion.lean`、名前空間 `Ising2D.NecSuf`）

| Lean の名前 | 内容 | 台に要求する構造 | 人手証明のラベル |
| --- | --- | --- | --- |
| `NecSuf.anticomm_sum_smul` | `e` が各 `x_i` と反交換 ⇒ `x_i` の任意の有限 `𝕜` 線型結合とも反交換 | `Ring A` + `Algebra 𝕜 A` | `epsilon_anticommutes_with_check_Z_Y` (2)(3) |
| **`NecSuf.commute_parity_num`** | **`e` が `c_i`, `a_i` の両方と反交換 ⇒ `e` は `n_i = c_i a_i` と可換** | **`Ring A` だけ** | 同 (4) 前半 |
| **`NecSuf.commute_parity_projOn`** | **`e` は `Q_ε` とも可換** | **`Ring A` だけ** | 同 (4) 後半 |
| `NecSuf.num_mul_cre` | `n_i c_i = c_i` | `Ring A` | `epsilon_eigenvalue_on_check_Q` Step 2 冒頭 |
| **`NecSuf.projOn_insert_mul_cre`** | **`μ ∈ s`, `μ ∉ T` ⇒ `Q_{T∪{μ}}(c_μ Q_T) = c_μ Q_T`** | **`Ring A` だけ** | 同 (2) Step 2 |
| **`NecSuf.cre_mul_projOn_ne_zero`** | **`Q_T ≠ 0` ⇒ `c_μ Q_T ≠ 0`** | **`Ring A` だけ（1 次元性不要）** | 同 (2) Step 1 |
| `NecSuf.noncommProd_mul_of_mul_eq_smul` | 各因子が `Q` にスカラー倍として働くなら積も働く | `Ring A` + `Algebra 𝕜 A` | 同 (4) |
| `NecSuf.star_projOn` | `n_i` が可換な自己共役族なら `Q_ε^* = Q_ε` | `StarRing A` | `check_number_operator_is_hermitian` (4) |
| `NecSuf.smul_left_cancel_of_ne_zero` | `x ≠ 0` ⇒ `ηx = η'x ⇒ η = η'` | `Module 𝕜 A`（`𝕜` は体） | `epsilon_eigenvalue_on_check_Q` (1) |
| **`NecSuf.sum_powerset_signed_exp`** | **`∑_{T ⊆ s} (−1)^{|s|−|T|} exp(∑_{i∈s} g_i(1_{i∈T} − 1/2)) = ∏_{i∈s} 2 sinh(g_i/2)`** | **ℝ の `exp`/`sinh` だけ** | `trace_of_epsilon_V_plus_via_check_eigenvalues` Step 2 |

## 2. 2 本立ての対応表と「必要十分版で判明した本質」

| 人手証明のラベル | 具体版 | 必要十分版 | 具体版は必要十分版の系か |
| --- | --- | --- | --- |
| `epsilon_anticommutes_with_check_Z_Y` (2)(3) | `Ising2D.epsilon_anticomm_checkZ` / `checkY` / `epsilon_anticomm_of_isCheckMode` | `NecSuf.anticomm_sum_smul` | **すべて系** |
| 同 (4) | `CheckFermi.commute_epsilon_nOp` / `commute_epsilon_Qproj` | `NecSuf.commute_parity_num` / `commute_parity_projOn` | **すべて系** |
| `epsilon_eigenvalue_on_check_Q` (1) | `CheckFermi.exists_eta` / `eta` / `eta_unique` | `NecSuf.smul_left_cancel_of_ne_zero`（一意性のみ） | **存在の部分は系にならない**（1 次元性が要る。下記参照） |
| 同 (2) | `CheckFermi.eta_insert` | `NecSuf.projOn_insert_mul_cre` / `cre_mul_projOn_ne_zero` | **系** |
| 同 (4) | `CheckFermi.epsilon_eq_parityProd` | `NecSuf.noncommProd_mul_of_mul_eq_smul` | **系** |
| `trace_of_epsilon_V_plus_via_check_eigenvalues` Step 2 | `VPlusData.trace_epsilon_mul_V` | `NecSuf.sum_powerset_signed_exp` | **系** |
| `check_number_operator_is_hermitian` (4) | `CheckFermi.Qproj_conjTranspose` | `NecSuf.star_projOn` | **系** |
| `max_eigenvector_in_even_sector` | `VPlusData.eta_univ_eq_one` ほか | **置かない** | `Claim002`（反転則）と `Claim003`（トレースの符号）の組み合わせであり、新しい抽象構造が現れない |
| `c_plus_equals_Lambda_half_integer` | `EvenSectorBridge.c_plus_equals_lamMax` | **置かない** | `sSup` は ℝ の完備性そのものでほどく余地がない（章 011 の `Definition006_RayleighSup.lean` と同じ理由）。新しく現れる道具は実／複素の橋渡しだけ |
| `onsager_exact_solution` | `Ising2D.onsager_exact_solution` | **置かない** | 既存の必要十分版（`NecSuf/LogSqueeze.lean`, `NecSuf/RiemannSum.lean`）を章 012 が既に系として使っており、本章はその具体版を章 018・019 の結果に接続するだけ |

### 必要十分版で判明した本質（本文には持ち込まない）

- **`ε` が `ň_μ`・`Q̌_ε` と可換であること（人手証明 (4)）に効いているのは、
  `ε` が生成・消滅演算子の両方と反交換することと `(−1)² = 1` だけである。**
  `ε = σ^x_1⋯σ^x_M` であることも、`ψ̌` が `Ž, Y̌` の 1 次結合であることも、
  行列であることも、複素数であることも、テンソル冪であることも効いていない。
  台は**任意の環**でよい（`NecSuf.commute_parity_num` / `commute_parity_projOn`）。

- **符号の反転則（人手証明 (2)）に `im Q̌_ε` の 1 次元性は要らない。**
  人手証明は (1)(2) の両方で 1 次元性を引くが、必要な材料は次の 3 つだけである。
  1. `Q_{T∪{μ}}(c_μ Q_T) = c_μ Q_T` — `n_μ c_μ = c_μ` と「`n_ν`（`ν ≠ μ`）が `c_μ` と可換」から、
     環の計算だけで出る（`NecSuf.projOn_insert_mul_cre`）。
  2. `c_μ Q_T ≠ 0` — `a_μ c_μ = 1 − n_μ` と `n_μ Q_T = 0`（`μ ∉ T`）から出る
     （`NecSuf.cre_mul_projOn_ne_zero`）。**ここが 1 次元性を使わない要点である。**
  3. `ε(c_μ Q_T) = −η_T (c_μ Q_T)` — 反交換関係だけ。

  すなわち**1 次元性が本当に要るのは `η_ε` の「存在」だけ**であり、反転則そのものは
  1 次元性なしで出る。存在の部分は台が行列環であることが本質的なので、
  具体版（`Part018/Claim002_EpsilonEigenvalueOnQ.lean`）にしか置いていない。

- **`tr(εV^{(+)})` の積への分解（人手証明 Step 2）に効いているのは、
  有限集合の冪集合にわたる和の積への変形（`Finset.prod_add`）と
  `sinh x = (e^x − e^{−x})/2` だけである。** `γ` が `arccosh` で書けることも、
  `V^{(+)}` が転送行列であることも、`Λ̌_ε` が固有値であることも、半整数運動量であることも
  効いていない（`NecSuf.sum_powerset_signed_exp` は `g : ι → ℝ` を任意にとる）。

- **`γ(θ̃_μ) > 0`（半整数運動量に固有の性質）が効くのは 1 箇所だけである。**
  `∏_μ 2 sinh(γ_μ/2) ≠ 0`（したがって `tr(εV^{(+)})` の符号が `η_{(1,…,1)}` で決まる）と、
  `Λ̌_ε ≤ Λ̌_{(1,…,1)}` の 2 つに使う。整数運動量なら `γ = 0` のモードが出て両方が壊れる。

## 3. 形式化できなかった主張とその理由

| 人手証明（ブロック） | 状況 | 理由 |
| --- | --- | --- |
| `closing_definition_D0_open_chain_operator`・`closing_definition_G_boundary_operator`・`closing_004_claim_H1_plus_in_sigma_z_form`・`closing_claim_D0_G_diagonal_action`・`closing_claim_epsilon_D0_G_pairwise_commute`・`closing_claim_epsilon_G_is_involution`（`D_0,G` の定義から `iH_1^{(+)} = D_0 + εG`、対角作用、可換性、`(εG)^2=I` まで） | **未形式化** | `tr(εV^{(+)})` の直接計算の枝。配置基底での `σ^z` 表示を要し、章 018 の主鎖（`ε` の固有値 → `c_+(M) = Λ̌_max` → Onsager）とは独立 |
| `closing_005_definition_open_chain_spin_energy`・`closing_005_claim_open_chain_partition_sum`・`closing_005_claim_open_chain_endpoint_product_sum`・`closing_005_claim_open_chain_spin_sums_positive`（1次元開鎖の記法、二つのスピン和、正値性） | **未形式化** | 同上。原文自身が「この計算には `Ž, Y̌, ψ̌` も半整数運動量も現れない」と述べる独立の組合せ論的計算 |
| `closing_006_theorem_trace_of_epsilon_V_plus`（`tr(εV^{(+)}) = (2e^{−K_2}\cosh K_1)^M + (2e^{K_2}\sinh K_1)^M > 0`） | **仮定として受け取る** | 上記10ブロックに依存する。`Ising2D.VPlusData.eta_univ_eq_one` 以降は `0 < (tr(εV^{(+)})).re` を仮定に置いた。**人手証明で証明済みであり循環参照はない**（この定理は `epsilon_eigenvalue_on_check_Q` にも `max_eigenvector_in_even_sector` にも依存しない） |
| `def_check_fermi` / `anticommutator_of_check_psi`（章 016） | **`CheckFermi` の仮定** | 本章の形式化時点で Lean 側に `Part016` が無かった |
| `eigenvalues_of_V_plus`（章 017） | **`VPlusData` の仮定** | 本章の形式化時点で Lean 側に `Part017` が無かった |
| `W P^{(+)} = V^{(+)} P^{(+)}`（章 011 の `symmetrized_transfer_matrix_on_sectors`） | **`EvenSectorBridge` の仮定** | 章 011 の Lean 形式化もこの行列等式を形式化していない（`lean/docs/ch011-formalization.md`: 「`V^{(±)}`, `V_1^{(±)}` は章 004/010 の対象で、本タスクの担当範囲外の定義に依存する」）。章 019 も同じ扱い |
| `closing_000_remark_overview` | 形式化対象外 | `remark`（本章の位置づけの説明）であり、数学的主張は他ブロックに含まれる |

詳細と一次情報は `docs/tasks/2026-07_lean-ch009-013/015_ch018-formalization-findings.md` に記録した。

## 4. 人手証明との意図的な相違点（Onsager の最終定理）

人手証明 `onsager_exact_solution` の Step 2・Step 3 は
`Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M` という**粗い挟み撃ち**を採る（原文 `conversion.notes` に
よれば `c_-(M)` の値に依存しないため）。

Lean 側はこれを使わない。**章 019 の `Ising2D.c_minus_le_c_plus` が `c_-(M) ≤ c_+(M)` を
無条件に与える**ので、`c_-(M)` の値を知らなくても `Ising2D.c_equals_c_plus` で
`c(M) = c_+(M)` が言え、`EvenSectorBridge.rayleighSup_eq_LambdaM` は挟み撃ちなしに

```
c(M) = c_+(M) = Λ̌_max = Λ^{(1/2)}_M
```

を出す。**得られる結論は人手証明と同じ**（挟み撃ち版で必要だった `log 2 / M → 0` が
不要になるだけ）である。本文は変更していない。

## 5. 検証

```
$ cd exact-solution-of-2d-ising-model/lean
$ lake build                    # Build completed successfully
$ ./scripts/check-no-sorry.sh   # exit 0
OK: ソース中に sorry / admit は無い
OK: 主要定理はいずれも sorryAx に依存していない
```

`scripts/check-no-sorry.sh` の `targets` 配列の末尾に本章の 106 個の定義・定理を追加してある。
`sorry` / `admit` は 1 つも残っていない。

## 6. 本章のあとに入った章 014–017 の形式化との接続（**完了**）

本章のコミット後、並行セッションが章 014・015・016・017 を形式化して main に入れた。
**その結果を差し込んで、`Ising2D.CheckFermi` / `Ising2D.VPlusData` の仮定はすべて
定理に置き換わった。** 章 018 以外の `.lean` ファイルは 1 つも編集していない（読むだけ）。

### 6.1 追加したファイル

| ファイル | 内容 |
| --- | --- |
| `Part018/Claim011_CheckFermiFromPart016.lean` | `Ising2D.checkFermiOf`（`CheckFermi` のインスタンス）と、その `hstar` を埋める橋渡し補題 `Ising2D.checkPsiDag_conjTranspose` |
| `Part018/Claim012_VPlusDataFromPart017.lean` | `Ising2D.vPlusDataOf`（`VPlusData` のインスタンス）と、章 017 の `CheckFermiSetup`（添字型 `CheckIdx M`）と章 018 の `CheckFermi`（添字型 `Fin M`）を噛み合わせる `Ising2D.finCheckIdxEquiv` / `checkFermiSetupOf_Vprime` |
| `Part018/Theorem013_OnsagerUnconditional.lean` | 残る仮定だけを束ねた `Ising2D.EvenSectorClosureInput` と、`Ising2D.onsager_exact_solution_unconditional` |

### 6.2 消えた仮定（何で埋めたか）

| もとの仮定 | 出典の章 | 埋めた定理 |
| --- | --- | --- |
| `CheckFermi.hcre` / `hann`（`ψ̌^†, ψ̌` が `Ž, Y̌` の 1 次結合） | 016 | `Ising2D.checkPsiDag` / `checkPsi` の定義そのもの（`Part016/Definition001_CheckFermi.lean`） |
| `CheckFermi.acomm_cre_cre` / `acomm_ann_ann` / `acomm_cre_ann`（CAR） | 016 | `Ising2D.checkPsi_car'`（`Part016/Claim010_UnconditionalViaPart015.lean`。仮定は `M ≠ 0` だけ） |
| `CheckFermi.hstar`（`(ψ̌_μ^†)^* = ψ̌_{M+1-μ}`） | 016 | **本セッションで新たに証明**した `Ising2D.checkPsiDag_conjTranspose`（章 018 の `checkZ_conjTranspose` / `checkY_conjTranspose` と章 008 の `gamma2_neg_eq_neg_conj` だけを使う） |
| `VPlusData.hV`（`V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε`） | 016・017 | `Ising2D.VPlus_eq_smul_checkVprime_const`（016 の `VPlus_eq_smul_checkVprime_of_dual` ＋ 017 の `constant_c_value_even_sector`）と `Ising2D.checkVprime_mul_Qproj` |
| `VPlusData.C`, `hC`（`C = (2 sinh 2K_2)^{M/2} > 0`） | 017 | 同上（`constant_c_value_even_sector` が `c` の値を確定させる） |
| `VPlusData.gam`, `hgam`（`γ(θ̃_μ) > 0`） | 015・017 | `Ising2D.gammaFn_thetaTilde_pos`（`Part017/Theorem011_MaxEigenvalueSimple.lean`。**無条件**） |
| `rayleighSup_eq_LambdaM` の `hC` / `hgam`（章 012 の記法との一致） | 012・017 | `rfl` と `Ising2D.sum_checkGam`（`tagPoint_half_eq_thetaTilde` の系） |

### 6.3 噛み合わせが必要だった箇所（一次情報）

1. **添字型のずれ。** 章 017 の `CheckFermiSetup` は `CheckIdx M = {μ ∈ ℤ | 1 ≤ μ ≤ M}`、
   章 018 の `CheckFermi` は `Fin M` で添字づけている。`Ising2D.finCheckIdxEquiv`
   （`j ↦ j+1`、全単射性は `checkIdx_injective` と `CheckIdx.card` から）を置き、
   `X̌` が両側で同じ行列であること（`checkFermiSetupOf_Xop`）を示した。
   これにより章 017 の `constant_c_value_even_sector` を章 016 の `checkVprime` に適用できる。
   なお `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε` 自体は章 017 の `Q̌_ε` を経由せず、章 018 側の
   `CheckFermi.nOp_mul_Qproj` から直接導いた（射影を添字型ごと移す必要が無くなる）。
2. **`(ψ̌_μ^†)^* = ψ̌_{M+1-μ}` が章 016 に無かった。** 章 016 は CAR と `V^{(+)} = cV̌'` までで、
   `ψ̌` の共役転置は扱っていない（`grep -rn "conjTranspose" Ising2D/Part016/` が空）。
   係数側の等式 `conj(p_μ) = -p_{M+1-μ}`（`Ising2D.star_checkP`）を新たに証明して埋めた。

### 6.4 残った仮定と、それが消せない理由（一次情報）

`Ising2D.EvenSectorClosureInput`（`Theorem013_OnsagerUnconditional.lean`）に束ねてある。
**いずれも章 014–017 由来ではない。**

| 場 | 内容 | 消せない理由 |
| --- | --- | --- |
| `hM` | `M ≠ 0` | 章 016・017 の主張自体が要求する（`CheckFermiSetup.hM`、`checkPsi_car'` の `hM`） |
| `hdual` | 双対関係 `c_2 s_2^* = c_2^*` | **原文が置いている関係**であって形式化の穴ではない（`lean/docs/ch016-formalization.md` 3 章: 「残る仮定は双対関係の 1 つだけ」）。008 章以来 `det A(θ) = 1` に必要 |
| `bridge` | `W P^{(+)} = V^{(+)} P^{(+)}` と `V^{(+)}` が実行列であること | 章 011 の `symmetrized_transfer_matrix_on_sectors` が **Lean 未形式化**。`V₁` の固有空間制限と下流のセクター置換は形式化済みで、章 011 の実行列 `W` と複素 `TensorPow` 上の物理的転送行列の同一視、および既存の `Vsym`・`epsProj` への最終接続が残る。実行列性のほうは「実行列の `exp` が実行列である」ことを要し、本リポジトリの Lean 側にその補題が無い |
| `htr` | `tr(εV^{(+)}) > 0` | 章 018 自身の `closing_004` / `closing_005` / `closing_006`（配置基底での 1 次元開鎖のスピン和）が未形式化。本章の主鎖とは独立の枝である（上記 3 の表と同じ） |
| `hWpos`, `hWcomm` | `W` の成分が正・`ε` と可換 | 章 010 の `V2_component_equals_pauli` / `epsilon_commutes_with_transfer_matrices` に依存。章 011 も同じ形で仮定として受け取っている（`lean/docs/ch011-formalization.md` 3 章） |

`hZ1` / `hZ2` は章 011 `partition_function_sandwich` の内容であり、章 018 の仮定ではない。

### 6.5 検証

```
$ cd exact-solution-of-2d-ising-model/lean
$ export PATH="$HOME/.elan/bin:$PATH" && lake build   # Build completed successfully
$ ./scripts/check-no-sorry.sh                          # exit 0
```

`scripts/check-no-sorry.sh` の `targets` 配列の末尾に、本接続で追加した 28 個の
定義・定理（`Ising2D.checkFermiOf` … `Ising2D.onsager_exact_solution_unconditional`）を追加した。

## 7. （旧記録）本章のあとに入った章 016・017 の形式化との関係

本章のコミット後、並行セッションが章 016（`Ising2D/Part016/`）と章 017（`Ising2D/Part017/`）を
形式化して main に入れた。**本章の `Ising2D.CheckFermi` / `Ising2D.VPlusData` を
それらの定理から埋める作業は未着手である。** 本タスクの担当範囲（章 018）外なので、
章 016・017 のファイルには手を触れていない。接続すれば `CheckFermi` の仮定（`ψ̌` の CAR）と
`VPlusData` の仮定（`V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε` ほか）は定理に置き換わる。

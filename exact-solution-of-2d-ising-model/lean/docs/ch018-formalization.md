# 章 018「偶セクターの完結（Onsager の厳密解）」の Lean 形式化

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`（`epsilon_anticommutes_with_check_Z_Y` から `max_eigenvector_in_even_sector` まで）と `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`（`check_number_operator_is_hermitian` 以降）

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
| `Ising2D.CheckFermi` | `EigenvalueProblem/EigenvectorOfMaxEigenvalue/CheckFermiInput.lean` | `ψ̌` の正準反交換関係（`anticommutator_of_check_psi`）、`(ψ̌_μ^†)^* = ψ̌_{M+1-μ}`（`check_number_operator_is_hermitian` (3)） | 016 |
| `Ising2D.VPlusData` | `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusViaCheckEigenvalues.lean` | `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε`、`Λ̌_ε = C·exp(∑_μ γ(θ̃_μ)(ε_μ − 1/2))`、`C > 0`、`γ(θ̃_μ) > 0`（`eigenvalues_of_V_plus`, `gamma_theta_tilde_mu_positive`） | 015・017 |
| `Ising2D.EvenSectorBridge` | `ThermodynamicLimit/ColumnLimitAndClosedForm/TheoremCPlusEqualsLambda.lean` | 章 011 の実行列 `W` と章 017 の複素行列 `V^{(+)}` の橋渡し（`W P^{(+)} = V^{(+)} P^{(+)}`、`V^{(+)}` が実行列であること） | 011・017 |

**`ε` が `Ž, Y̌` と反可換であること（`epsilon_anticommutes_with_check_Z_Y` (1)(2)）は
仮定していない。** 章 004・010・013 の形式化済みの定理から**無条件に**従う。

演算の土台は、章 018 の主鎖では**複素行列 `TensorPow M = Matrix (Conf M) (Conf M) ℂ`**、
章 011 と接続する部分では**実行列 `Matrix (Conf M) (Conf M) ℝ`** である。
両者の橋渡しは `Ising2D.cvec`（実ベクトルの複素化）と `Ising2D.EvenSectorBridge.reVec`
（複素ベクトルの実部）で行い、章 011 の `epsilon_eq_ofReal_epsilonR`（`ε` は実行列 `epsilonR` の成分の埋め込み）と
同じ性質のものである。

**実数解析（極限・積分・連続性）へ移行するのは、章 012 の
`Ising2D.riemann_sum_to_integral` を経由する最後の等号だけ**である（人手証明の最終段落と同じ）。

## 1. 形式化した定理の一覧

### 1.1 具体版（章「V^{(+)} の最大固有値に属する固有ベクトル」の分は `lean/Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/`、残りは章「M→∞ の極限と閉形式」の `lean/Ising2D/ThermodynamicLimit/ColumnLimitAndClosedForm/`）

#### `EigenvalueProblem/EigenvectorOfMaxEigenvalue/CheckFermiInput.lean`（章 014–017 からの入力と、その直接の帰結）

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
| **`CheckFermi.commute_epsilon_nOp`** | **`ε ň_μ = ň_μ ε`**（人手の 3 行の鎖と同じ calc。2 行目は `product_of_anticommuting_matrices_commutes` の `TensorPow M` での系 `mul_comm_of_anticomm_pair_tensorPow`） | **同 (4) 前半** |
| `CheckFermi.defFactor` | 人手の `Q̌_ε` の因子 `A_ν = ε_ν ň_ν + (1 − ε_ν)(I − ň_ν)`（`ε_ν` は `ν ∈ T` なら `1`） | 同 (4) の置き方 |
| `CheckFermi.epsilon_mul_identity_eq_identity_mul_epsilon` | `εI = Iε`（2 行） | 同 (4) |
| `CheckFermi.commute_epsilon_defFactor` | `εA_ν = A_νε`（3 式と 5 行の鎖） | 同 (4) |
| `CheckFermi.projFactor_eq_defFactor` / `Qproj_eq_finProdLeft_defFactor` | Lean の `Qproj` は人手の `Q̌_ε = ∏_{ν=1}^{M_col} A_ν`（左から掛ける積）に等しい（人手の行ではなく、定義どうしをつなぐ等式） | `check_joint_eigenspace_decomposition` の `Q̌_ε` の定義 |
| `CheckFermi.commute_epsilon_Qproj_succ` | `M_col = r + 1` での `ε Q̌_ε = Q̌_ε ε`（人手の 3 行の鎖と同じ calc） | 同 (4) 後半 |
| **`CheckFermi.commute_epsilon_Qproj`** | **`ε Q̌_ε = Q̌_ε ε`**（`M = r + 1` は `commute_epsilon_Qproj_succ`。`M = 0` は人手の主張の外で、必要十分版の特殊化） | **同 (4) 後半** |
| `CheckFermi.commute_epsilon_nOp_of_necSuf` / `commute_epsilon_Qproj_of_necSuf` / `commute_epsilon_Qproj_succ_of_necSuf` | 同じ主張を必要十分版 `NecSuf.commute_parity_num` / `commute_parity_projOn` / `commute_parity_finProdLeft_defFactor` の特殊化として | 同 (4) |
| `CheckFermi.ann_conjTranspose` / `nOp_conjTranspose` / `Qproj_conjTranspose` | `ψ̌^* = ψ̌^†`, `ň^* = ň`, `Q̌^* = Q̌` | `check_number_operator_is_hermitian` (3)(4) |

#### `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimEpsilonAnticommutesWithCheckZY.lean`（ラベル `epsilon_anticommutes_with_check_Z_Y`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.epsilon_anticomm_Z` / `epsilon_anticomm_Y` | `ε Z_j = −Z_j ε`, `ε Y_j = −Y_j ε` | (1)（章 010 で証明済み。再掲） |
| `Ising2D.epsilon_anticomm_phase_sum` | `ε Σ_j c_j W_j = −(Σ_j c_j W_j) ε`（`M_col = r + 1`、人手の鎖の 2〜8 行目と同じ行の calc） | (2) の鎖 |
| `Ising2D.epsilon_anticomm_checkZ_succ` / `epsilon_anticomm_checkY_succ` | `M_col = r + 1` での `ε Ž_μ = −Ž_μ ε`, `ε Y̌_μ = −Y̌_μ ε` | (2) |
| **`Ising2D.epsilon_anticomm_checkZ` / `epsilon_anticomm_checkY`** | **`ε Ž_μ = −Ž_μ ε`, `ε Y̌_μ = −Y̌_μ ε`**（`M = 0` は人手の主張の外で、空の和） | **(2)** |
| `Ising2D.epsilon_anticomm_checkZ_of_necSuf` / `epsilon_anticomm_checkY_of_necSuf` | 同じ主張を必要十分版 `NecSuf.anticomm_sum_smul` の特殊化として | (2) |
| `Ising2D.IsCheckMode` | 「`ψ̌_μ^†`・`ψ̌_μ` は `Ž_μ, Y̌_μ` の ℂ 係数 1 次結合」（章 016 の入力を述語化） | `def_check_fermi` |
| `Ising2D.epsilon_anticomm_two_term` | `ε(pX + qY) = −((pX + qY) ε)`（`X`・`Y` は `Ž_μ`・`Y̌_μ`、人手の鎖の 2〜8 行目と同じ行の calc） | (3) の鎖 |
| **`Ising2D.epsilon_anticomm_checkPsiDag` / `epsilon_anticomm_checkPsi`** | **`ε ψ̌_μ^† = −ψ̌_μ^† ε`, `ε ψ̌_μ = −ψ̌_μ ε`**（`ψ̌` は `def_check_fermi` の `checkPsiDag`・`checkPsi`） | **(3)** |
| `Ising2D.epsilon_anticomm_checkPsiDag_of_necSuf` / `epsilon_anticomm_checkPsi_of_necSuf` | 同じ主張を必要十分版 `NecSuf.anticomm_add_smul` の特殊化として | (3) |
| `Ising2D.epsilon_anticomm_of_isCheckMode` | `IsCheckMode` の元 `x` について `ε x = −x ε`（`epsilon_anticomm_two_term` を使う。`CheckFermi` へ渡す形） | (3) |

**(1)(2)(3) は無条件**（章 004・010・013 の形式化済みの定理と `def_check_fermi` の定義だけを使う）。

#### `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimEpsilonEigenvalueOnCheckQ.lean`（ラベル `epsilon_eigenvalue_on_check_Q`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.smul_cancel_of_matrix_ne_zero` | `Q ≠ 0`, `ηQ = η'Q ⇒ η = η'` | (2) Step 3 |
| `CheckFermi.Qproj_eq` / `finrank_range_Qproj` / `exists_Qproj_spanning_vector` | `im Q̌_ε` が 1 次元で、`im Q̌_ε = ℂq`・`q = Q̌_ε x` なる `q ≠ 0`・`x` がとれる | (1) の冒頭（1 次元性はここだけで使う） |
| `CheckFermi.Qproj_mulVec_generator` | `Q̌_ε q = q`（人手の 4 行） | (1) |
| `CheckFermi.exists_Qproj_generator` / `Qproj_mulVec_of_mem_range` | 下流（`TheoremCPlusEqualsLambda.lean`）が使う形の `q` | (1) の帰結 |
| `CheckFermi.Qproj_mulVec_epsilon_mulVec_generator` | `Q̌_ε(εq) = εq`（人手の 4 行） | (1) |
| `CheckFermi.generator_eq_eta_mul_eta_smul` / `eta_mul_eta_sub_one_smul_generator` / `eta_mem_of_mul_self_sub_one` | `q = (ηη)q`（7 行）、`(ηη − 1)q = O`（4 行）、`(η − 1)(η + 1) = 0`（4 行）から `η ∈ {±1}` | (1) |
| `CheckFermi.smul_generator_cancel` | `q ≠ 0`, `aq = bq ⇒ a = b`（成分 `q_k ≠ 0` で約す） | (1) の「一意に定まる」 |
| `CheckFermi.epsilon_mul_Qproj_mulVec` / `epsilon_mul_Qproj_eq_smul_of_mulVec` | `(εQ̌_ε)x = (ηQ̌_ε)x`（9 行）、列ごとに `εQ̌_ε = ηQ̌_ε`（7 行。`mat_columnwise` の `mul_columns_tensorPow`） | (1) |
| **`CheckFermi.exists_eta_with_generator` / `exists_eta` / `eta` / `eta_mem` / `epsilon_mul_Qproj` / `exists_generator_of_eta`** | **`∃ η_ε ∈ {±1}, ε Q̌_ε = η_ε Q̌_ε`**（`η_ε` を定めた `q` と `εq = η_ε q` を組で持つ） | **(1)** |
| `CheckFermi.smul_generator_eq_eta_smul` / **`eta_unique`** | 一意性の 6 行の鎖 `η'q = … = εq = ηq` と、`q ≠ 0` による `η' = η_ε` | **(1) の一意性** |
| `CheckFermi.nOp_mulVec_generator_eq_zero` / `ann_mulVec_cre_mulVec_generator` / `cre_mulVec_generator_ne_zero` | `ň_μ q = 0`（6 行）、`ψ̌_{M+1−μ}(ψ̌_μ^† q) = q`（6 行。Lean の `ann μ` が人手の `ψ̌_{M+1−μ}`）、背理法の 3 行で `ψ̌_μ^† q ≠ 0` | (2) Step 1 |
| `CheckFermi.nOp_mul_cre` | `ň_μψ̌_μ^† = ψ̌_μ^†`（13 行） | (2) Step 2 冒頭 |
| `CheckFermi.defFactor_of_notMem` / `defFactor_of_mem` / `defFactor_insert_of_ne` | `A_μ^ε = I − ň_μ`（`ε_μ = 0`、8 行）、`A_μ^{ε'} = ň_μ`（`ε'_μ = 1`、8 行）、`ν ≠ μ` で `A_ν^{ε'} = A_ν^ε`（Lean の `ε'` は `insert μ T`） | (2) Step 2 |
| `CheckFermi.commute_defFactor_of_commute` / `nOp_mul_defFactor` / `defFactor_mul_defFactor` / `cre_mul_defFactor_of_ne` | `Xň_ν = ň_νX` ⇒ `XA_ν^δ = A_ν^δX`（3 式と 5 行）と、`X → ň_κ`・`X → A_κ^δ`・`X → ψ̌_μ^†`（`ν ≠ μ`） | (2) Step 2 |
| `CheckFermi.nOp_mul_cre_of_necSuf` / `commute_defFactor_of_commute_of_necSuf` | 同じ主張を必要十分版 `NecSuf.num_mul_cre'` / `NecSuf.commute_defFactor_of_commute'` の特殊化として | (2) Step 2 |
| `CheckFermi.cre_mul_omittingDefFactor` / `omittingDefFactor_insert` | `Π' := ∏_{ν≠μ}A_ν`（Lean は `NecSuf.finProdLeftOmitting r μ (F.defFactor T)`、人手の `M_col` が `r + 2`）について `ψ̌_μ^†Π' = Π'ψ̌_μ^†`、`∏_{ν≠μ}A_ν^{ε'} = Π'` | (2) Step 2 |
| `CheckFermi.defFactor_mulVec_generator_of_notMem` / `omittingDefFactor_mulVec_generator` / `Qproj_insert_mulVec_cre_mulVec_generator` | `A_μ^ε q = q`（5 行）、`Π'q = q`（5 行）、`Q̌_{ε'}(ψ̌_μ^† q) = ψ̌_μ^† q`（10 行）。必要十分版の特殊化は `*_of_necSuf` | (2) Step 2 |
| `CheckFermi.epsilon_mulVec_cre_mulVec_generator` | `ε(ψ̌_μ^† q) = (−η_ε)(ψ̌_μ^† q)`（9 行） | (2) Step 3 の前半 |
| `CheckFermi.epsilon_mulVec_generator_eq_eta_smul` | `εq = η_ε q`（5 行。`Q̌_ε q = q` は冪等性の `Qproj_mulVec_generator`） | (2) の冒頭 |
| `CheckFermi.eta_insert_smul_cre_mulVec_generator` | (1) を `ε'` に使った `η_{ε'}(ψ̌_μ^† q) = (−η_ε)(ψ̌_μ^† q)`（6 行） | (2) Step 3 の後半 |
| `CheckFermi.Qproj_insert_mulVec_cre_mulVec_of_notMem` / `Qproj_insert_mulVec_cre_mulVec_generator_one` | Step 2 の結論を `M` を限らずに述べたもの（`M = r + 2` は上の 3 本の鎖。人手の範囲外の `M = 1` は `Π'` が因子を持たない場合の縮めた鎖） | (2) Step 2 |
| **`CheckFermi.eta_insert`** / `eta_insert_of_necSuf` | **反転則 `η_{ε[μ→1]} = −η_ε`**（`im Q̌_ε` の `0` でない元 `q`（`exists_ne_zero_mem_range_Qproj`。`Q̌_ε ≠ 0` の 0 でない列で、1 次元性は使わない）を取り、上の数ベクトルの鎖を人手の順に組み、`ψ̌_μ^† q ≠ 0` の 0 でない成分で約す。後者は同じ組み方で冒頭の `εq = η_ε q`・Step 1〜3 の鎖を必要十分版の特殊化に替えたもの。`q` を取る段・`Q̌_ε q = q`・`M = 1`・約す段は共通） | **(2)** |
| `CheckFermi.eta_eq_neg_eta_insert` / `eta_eq_eta_univ_mul_of_sub_card` | (2) の両辺に `−1` を掛けた `η_ε = −η_{ε[μ→1]}`（2 行）と、`k := M−|ε|` の帰納法（`k = 0` の 4 行、`k ≥ 1` で `ε_μ = 0` の `μ` を取る 7 行の鎖） | (3) |
| **`CheckFermi.eta_eq_eta_univ_mul`** / `eta_eq_eta_univ_mul_of_necSuf` | **`η_ε = η_{(1,…,1)}·(−1)^{M−|ε|}`**（後者は必要十分版 `NecSuf.eq_univ_mul_neg_one_pow`（`NecSuf/SignAfterReplacingComponents.lean`）の特殊化。`eta_eq_neg_eta_insert_of_necSuf` も同じ） | **(3)** |
| `CheckFermi.parityFactor_mul_Qproj` / `parityFactor_mul_Qproj_of_necSuf` | `(I − 2ň_μ)Q̌_ε = (1 − 2ε_μ)Q̌_ε`（人手の 10 行と同じ行の calc。後者は必要十分版 `NecSuf.one_sub_smul_mul_eq_smul'` の特殊化） | (4) |
| `CheckFermi.finProdLeft_mul_Qproj` / `finProdLeft_mul_Qproj_of_necSuf` | `P_kQ̌_ε = p_kQ̌_ε` の `k` の帰納法（`P_k` は左から掛ける有限積 `NecSuf.finProdLeft`、`p_k` は `∏`。`k = 1` の 3 行と `k → k+1` の 8 行。後者は必要十分版 `NecSuf.finProdLeft_mul_eq_prod_smul'` の特殊化） | (4) |
| `CheckFermi.parityProd` / `prod_one_sub_two_mul_indicator` / `parityProd_mul_Qproj` | `P := P_{M_col}`（人手の範囲外の `M = 0` は単位行列）、`p_{M_col} = (−1)^{|ε|}`、`PQ̌_ε = (−1)^{|ε|}Q̌_ε` | (4) |
| `CheckFermi.neg_one_pow_mul_self` / `epsilon_mul_Qproj_eq_smul_parityProd_mul` | `(−1)^{|ε|}(−1)^{|ε|} = ((−1)(−1))^{|ε|} = 1^{|ε|} = 1`（3 行）と、`εQ̌_ε = c(PQ̌_ε)`（`c := η_{(1,…,1)}(−1)^M`。人手の 7 行と同じ行の calc）。必要十分版の特殊化は `*_of_necSuf` | (4) |
| `CheckFermi.finsetOfWord` / `finsetOfWord_bijective` / `sum_Qproj_eq_binWordSum` / `binWordSum_Qproj` | 人手の語 `ε ∈ {0,1}^𝓜̌` を Lean の `Qproj` の添字（部分集合）へ送る全単射と、`Σ_εQ̌_ε = I` を人手の和 `def_sum_over_binary_words`（`NecSuf.binWordSum`）で述べたもの（運ぶ段。人手の行は無い） | (4)（`check_joint_eigenspace_decomposition` (2)） |
| `CheckFermi.epsilon_eq_parityProd_succ` / `epsilon_eq_parityProd_succ_of_necSuf` | `ε = εI = εΣ_εQ̌_ε = … = cP`（人手の 9 行と同じ行の calc。人手の `M_col ≥ 1` が `r + 1`。後者は必要十分版の特殊化） | (4) |
| `CheckFermi.eq_of_mul_Qproj_eq` | `Q̌_ε` 全体に右から掛けて一致すれば行列が一致する（人手の範囲外の `M = 0` にだけ使う） | (4) |
| **`CheckFermi.epsilon_eq_parityProd`** | **`ε = η_{(1,…,1)}(−1)^M ∏_μ(I − 2ň_μ)`**（`M = r + 1` は 9 行の鎖。人手の範囲外の `M = 0` は 7 行の鎖と `eq_of_mul_Qproj_eq`） | **(4)** |

#### `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusViaCheckEigenvalues.lean`（ラベル `trace_of_epsilon_V_plus_via_check_eigenvalues`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.checkLambda` | `Λ̌_ε = C·exp(∑_μ γ_μ(ε_μ − 1/2))` | `eigenvalues_of_V_plus` |
| `Ising2D.checkLambda_pos` / `checkLambda_le_univ` / `checkLambda_lt_univ` | `Λ̌_ε > 0`、`Λ̌_ε ≤ Λ̌_{(1,…,1)}`（`ε ≠ (1,…,1)` なら狭義） | 同 (2) |
| `Ising2D.VPlusData` | 章 015・017 から受け取る入力 | 同上 |
| `VPlusData.lamMax` / `lamMax_pos` / `checkLambda_le_lamMax` | `Λ̌_max = Λ̌_{(1,…,1)}` とその最大性 | 同 (2) |
| `VPlusData.trace_epsilon_mul_V_step1` | `tr(εV^{(+)}) = tr((εV^{(+)})I) = … = Σ_εη_ε(Λ̌_ε)_ℂ`（人手の 13 行と同じ行の calc。人手の `M_col` が `r + 1`、行列の和も複素数の和も `NecSuf.binWordSum r`） | Step 1 |
| `VPlusData.trace_epsilon_mul_V_eq_sum` | `tr(εV^{(+)}) = ∑_T η_T Λ̌_T`（`Finset.sum`。`M = r + 1` は Step 1 の鎖を `finsetOfWord` で付け替える。人手の範囲外の `M = 0` は mathlib） | Step 1 |
| `Ising2D.checkU` / `ite_eq_one_eq_val` / `card_finsetOfWord_one` / `card_finsetOfWord_castSucc` / `card_finsetOfWord_le` | `ǔ^{(1)} := 1`、`ǔ^{(0)} := −1`、`\|ε\|_1 = ε_1`、`\|ε\|_{k+1} = \|ε\|_k + ε_{k+1}`、`\|ε\|_k ≤ k` | 準備 |
| `Ising2D.checkU_prod_eq_neg_one_pow` / `checkU_prod_eq_neg_one_pow_of_necSuf` | `(Π_{μ≤k}ǔ^{(ε_μ)})_ℂ = (−1_ℂ)^{k−\|ε\|_k}`（`k` の帰納法。人手の `k = 1` の 5 行・7 行、`k → k+1` の 6 行・6 行と同じ行の calc。人手の `k` が `n + 1`。後者は必要十分版の特殊化） | Step 2 |
| `CheckFermi.checkH` / `checkH_mem` / `checkH_ofReal` / `VPlusData.checkT` | `ȟ ∈ {1,−1}` を `ȟ_ℂ = η_{(1,…,1)}` となるように取る、`ť_ε := (Π_μǔ^{(ε_μ)})Λ̌_ε` | 準備・Step 3 |
| `VPlusData.eta_mul_checkLambda_eq_checkT_mul_checkH` / `eta_mul_checkLambda_eq_checkT_mul_checkH_of_necSuf` | `η_ε(Λ̌_ε)_ℂ = (ť_εȟ)_ℂ`（人手の 7 行と同じ行の calc。人手の `M_col` が `r + 1`。後者は必要十分版の特殊化） | Step 3 |
| `VPlusData.checkW` / `checkLambda_finsetOfWord` / `Ising2D.ite_eq_one_eq_val_real` / `VPlusData.checkT_eq_prod_checkW_mul` | `w̌_μ^{(e)} := ǔ^{(e)}exp(γ(θ̃_μ)(e − 1/2))`、`Λ̌_ε` の定義を語の成分 `ε_μ` で読む運ぶ段、`ť_ε = … = (Π_μw̌_μ^{(ε_μ)})(2sinh 2K_2)^{M_col/2}`（人手の 7 行と同じ行の calc。人手の `M_col` が `r + 1`。`finite_product_of_real_products` は具体版 `Ising2D.finite_product_of_real_products`。必要十分版は置かない: 効くのは引いた 2 つの主張（それぞれ必要十分版あり）と ℝ の `a(bc) = b(ac)`・`ab = ba` だけで、この鎖に固有の取り払える構造が無い） | Step 4 |
| `VPlusData.traceFactor` | `ϰ := (2sinh 2K_2)^{M_col/2}Π_μ2sinh(γ(θ̃_μ)/2)`（`(2sinh 2K_2)^{M_col/2}` が `C`） | 主張の `ϰ` |
| `VPlusData.sum_checkT_eq_traceFactor` | `Σ_εť_ε = … = ϰ`（人手の Step 4 の 2 本目の和の鎖と同じ行の calc。人手の `M_col` が `r + 1`、和は `binaryWordRealSum r`。`w̌_μ^{(e)}` の `e` を ℝ の `1`・`0` へ付け替える運ぶ段が 1 つある。`real_sum_over_binary_words_distributes_in_left_factor` は具体版 `binaryWordRealSum_mul`、`expansion_of_finite_product_of_two_term_sums_of_real_numbers` は具体版 `expansion_of_finite_product_of_two_term_sums_of_real`、`def_cosh_sinh` の `sinh` は mathlib の `Real.sinh_eq`。必要十分版は置かない: 効くのは引いた 2 つの主張（それぞれ必要十分版あり）と ℝ の計算規則と `sinh` の式だけ） | Step 4 |
| `VPlusData.trace_epsilon_mul_V_step5_rows_one_to_six` / `trace_epsilon_mul_V_step5` | `tr(εV^{(+)}) = Σ_εη_ε(Λ̌_ε)_ℂ = … = (ȟϰ)_ℂ = ȟ_ℂϰ_ℂ = η_{(1,…,1)}ϰ_ℂ`（人手の Step 5 の 8 行と同じ行の calc。前者が 1〜6 行目（Step 7 の `⟸` が引く）、後者がそれに 7・8 行目を続けた全体。人手の `M_col` が `r + 1`。Step 1 の和 `NecSuf.binWordSum r` を具体版 `binaryWordComplexSum r` へ付け替える運ぶ段が 1 つある。`real_inclusion_preserves_sum_over_binary_words` は具体版 `binaryWordComplexSum_ofReal`。必要十分版は置かない: 効くのは引いた Step 1・3・4 の鎖と 3 つの主張と ℝ の乗法の交換則だけで、この鎖はそれらをつなぐだけ） | Step 5 |
| **`VPlusData.trace_epsilon_mul_V`** | **`tr(εV^{(+)}) = η_{(1,…,1)}ϰ_ℂ`**（`M` を一般に取る形。`M = r + 1` は `trace_epsilon_mul_V_step5`、人手の範囲外の `M = 0` は mathlib の `simp`） | **(1)（定理本体）** |
| `VPlusData.gam_half_pos` / `two_sinh_gam_half_pos` / `prod_two_sinh_gam_half_pos` / `traceFactor_pos_step6` | `γ(θ̃_μ)/2 = γ(θ̃_μ)·½ > 0·½ = 0`、`2sinh(γ(θ̃_μ)/2) > 2·0 = 0`、`Π_μ2sinh(γ(θ̃_μ)/2) > 0`、`ϰ = (2sinh 2K_2)^{M_col/2}Π_μ2sinh(γ(θ̃_μ)/2) > 0`（人手の Step 6 の 4 本の鎖と同じ行。1・2・4 本目は calc、人手が 1 行の 3 本目は `finite_product_of_positive_reals_is_positive` の適用 1 つ。人手の `M_col` が `r + 1`。`gamma_theta_tilde_mu_positive` は入力 `VPlusData.hgam`、`cosh_sinh_basic_properties` (3) は具体版 `cosh_sinh_basic_properties_3`、`finite_product_of_positive_reals_is_positive` は具体版 `Ising2D.finite_product_of_positive_reals_is_positive`、`def_second_transfer_matrix_prefactor` の正値性は入力 `VPlusData.hC`。必要十分版は置かない: 効くのは引いた 2 つの主張（それぞれ必要十分版あり）と ℝ の順序と乗法の計算規則だけ） | Step 6 |
| **`VPlusData.traceFactor_pos`** | **`ϰ > 0`**（`M` を一般に取る形。`M = r + 1` は `traceFactor_pos_step6`、人手の範囲外の `M = 0` は mathlib の `simp`） | **(2)** |
| `VPlusData.trace_pos_of_eta_univ_eq_one_step7` / `eta_univ_eq_one_of_trace_pos_step7` / `eta_univ_eq_one_iff_trace_pos_step7` | `⟹`: `tr(εV^{(+)}) = 1_ℂϰ_ℂ = ϰ_ℂ` で `r := ϰ`。`⟸`: `(r,0) = r_ℂ = tr(εV^{(+)}) = (ȟϰ)_ℂ = (ȟϰ,0)`、成分の比較で `r = ȟϰ`、`ȟ = −1` なら `r = ȟϰ = (−1)ϰ = −ϰ < 0` で矛盾、`η_{(1,…,1)} = ȟ_ℂ = 1_ℂ`（人手の Step 7 と同じ行の calc。人手の `M_col` が `r + 1`、人手の `r` が `s`。`z > 0` は `∃ s : ℝ, 0 < s ∧ z = (s : ℂ)`。必要十分版は置かない） | Step 7 |
| **`VPlusData.eta_univ_eq_one_iff_trace_pos`** | **`η_{(1,…,1)} = +1 ⟺ tr(εV^{(+)}) > 0`**（`M` を一般に取る形。`M = r + 1` は `eta_univ_eq_one_iff_trace_pos_step7`、人手の範囲外の `M = 0` は `Complex.ofReal_injective` と `linarith`） | **(3)** |
| `VPlusData.trace_epsilon_mul_V_eq_ofReal` / `eta_univ_eq_one_of_trace_pos` | `tr(εV^{(+)}) = (ȟϰ)_ℂ`（`M` を一般に取る (1) の読み替え）と、下流が渡す `0 < Re tr(εV^{(+)})` から `r := ȟϰ` を取って (3) の `⟸` を当てる運ぶ段 | (3) の `⟸` の運ぶ段 |

#### `ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimCheckQHermitian.lean`（ラベル `check_number_operator_is_hermitian`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.expPhase_conj` / `checkPhase_conj_star` | `conj(e^{−2πik/M}) = e^{2πik/M}` と半整数位相の共役 | (2) の計算 |
| **`Ising2D.checkZ_conjTranspose` / `checkY_conjTranspose`** | **`Ž_μ^* = Ž_{M+1−μ}`, `Y̌_μ^* = Y̌_{M+1−μ}`** | **(2)（無条件）** |
| `Ising2D.Z_conjTranspose` / `Y_conjTranspose` | `Z_j^* = Z_j`, `Y_j^* = Y_j` | (1)（章 009 で証明済み） |
| `CheckFermi.nOp_conjTranspose` / `Qproj_conjTranspose` | `ň_μ^* = ň_μ`, `Q̌_ε^* = Q̌_ε` | (4)（`EigenvalueProblem/EigenvectorOfMaxEigenvalue/CheckFermiInput.lean`） |
| `EvenSectorBridge.quad_Qproj` | `x^* Q̌_ε x = ‖Q̌_ε x‖² ≥ 0` | (4) の帰結（`TheoremCPlusEqualsLambda.lean`） |

#### `EigenvalueProblem/EigenvectorOfMaxEigenvalue/TheoremMaxEigenvectorInEvenSector.lean`（ラベル `max_eigenvector_in_even_sector`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.neg_one_pow_mul_neg_one_pow` | `(−1)^k(−1)^k = 1_ℂ` | 準備 (P1) の 4 行 |
| `Ising2D.card_le_of_finset` | `|ε| ≤ M` | 準備 (P2) の 3 行 |
| **`Ising2D.vPlusDataOf_eta_univ_eq_one`** | **`η_{(1,…,1)} = +1`**（具体的な `V^{(+)}`、`vPlusDataOf`） | **(1)** の 3 行の含意（`trace_of_epsilon_V_plus` の等号と `∈ ℝ_{>0}` の読み方、`z > 0` の定め方、`trace_of_epsilon_V_plus_via_check_eigenvalues` (3) の `⟸`） |
| `CheckFermi.eta_eq_neg_one_pow_sub_card` / `eta_eq_neg_one_pow_add_card` | `η_ε = (−1)^{M−|ε|}` / `η_ε = (−1)^{M+|ε|}` | (2) の鎖の 1〜3 行 / 3〜8 行（`η_{(1,…,1)} = 1` を仮定 `heta` で受け取る） |
| `CheckFermi.epsilon_mul_Qproj_eq_neg_one_pow_add_card` | `εQ̌_ε = (−1)^{M+|ε|}Q̌_ε` | (2) の行列の式 2 行 |
| `CheckFermi.epsilon_eq_neg_one_pow_smul_parityProd` | `ε = (−1)^M ∏_μ(I − 2ň_μ)` | (3) の 3 行 |
| `CheckFermi.epsilon_mul_Qproj_univ_of_eta` | `εQ̌_{(1,…,1)} = Q̌_{(1,…,1)}` | (4) の 1 つ目の鎖 3 行 |
| `CheckFermi.Qproj_univ_mulVec_of_mem_range` | `y = Q̌_{(1,…,1)}x` なら `Q̌_{(1,…,1)}y = y` | (4) の 2 つ目の鎖 4 行（3 行目の冪等性は仮定 `hidem` で受け取る） |
| `CheckFermi.epsilon_mulVec_of_mem_range_univ` | `y = Q̌_{(1,…,1)}x` なら `εy = y` | (4) の 3 つ目の鎖 4 行（冪等性は仮定 `hidem` で受け取る） |
| `Ising2D.checkFermiOf_Qproj_eq` / `checkFermiOf_Qproj_univ_eq` | 具体的な `ψ̌` の `CheckFermi` の `Q̌_T` と `CheckFermiSetup` の `Q̌_{e(T)}`（`e = finCheckIdxEquiv`）は同じ行列 | 運ぶ段（人手の証明の行ではない） |
| `Ising2D.checkFermiOf_Qproj_univ_mul_self` | `Q̌_{(1,…,1)}Q̌_{(1,…,1)} = Q̌_{(1,…,1)}`（人手と 1 対 1 の `CheckFermiSetup.Qproj_mul_self` から運んだもの） | (4) の 2 つ目の鎖の 3 行目が引く `check_joint_eigenspace_decomposition` (1) |
| `Ising2D.eigenspace_VPlus_max_eq_range_Qproj_univ_checkFermiSetupOf` | `{x | V^{(+)}x = Λ̌_max x} = im Q̌_{(1,…,1)}`（具体的な `V^{(+)}`、`CheckFermiSetup` の `Q̌`。一般の `Ising2D.eigenspace_VPlus_max_eq_range_Qproj_univ` の特殊化） | `max_eigenvalue_of_V_plus_simple` (3) の集合の等号 |
| `Ising2D.eigenspace_VPlus_max_subset_evenSector` | `{x | V^{(+)}x = Λ̌_max x} = im Q̌_{(1,…,1)} ⊆ 𝓕^{(+)}` | (4) の言い換えの 2 行 |
| **`Ising2D.max_eigenvector_in_even_sector`** | **(1)〜(4)** と言い換え（具体的な `V^{(+)}`。仮定は `IsingParam` の `K_1, K_2 > 0` と `2 ≤ M`） | **主張** |
| `VPlusData.eta_univ_eq_one` / `eta_eq_sign` / `epsilon_eq_parityProd_of_trace_pos` / `epsilon_mul_Qproj_univ` / `mem_evenSector_of_mem_range_univ` | 上の (1)〜(4) を任意の `VPlusData` について `0 < Re tr(εV^{(+)})` の仮定で述べた形 | 下流（`TheoremCPlusEqualsLambda.lean`）のための形。`heta` を (1) の最後の行で、`hidem` を必要十分版の特殊化 `CheckFermi.Qproj_mul_self` で埋める |

#### `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimMaxEigenvectorInEvenSectorViaTraceOfEpsilonVPlus.lean`（ラベル `max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus` | (1) `tr(εV^{(+)}) = (2e^{−K_2}cosh K_1)^M + (2e^{K_2}sinh K_1)^M` かつ実部が正（`V^{(+)}` は人手 `def_V_plus` の `VPlusOfTransfer`。`trace_of_epsilon_V_plus` そのもの）、(2) `Q̌_{(1,…,1)}` の像の元 `y` は `εy = y`（仮定は `IsingParam` の `K_1, K_2 > 0` と `2 ≤ M`） | 章末の主張の (1)・(2) |

#### `ThermodynamicLimit/ColumnLimitAndClosedForm/TheoremCPlusEqualsLambda.lean`（ラベル `c_plus_equals_Lambda_half_integer`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.cvec` / `cvec_ne_zero` / `star_cvec` / `cvec_mulVec` / `cvec_dotProduct` / `cvec_smul` | 実ベクトルの複素化とその基本性質 | `cvec` は `def_real_vector_inclusion`（準備 1 の `ι^n`）。ほかは実／複素の橋渡し |
| `Ising2D.star_dotProduct_self` | `x^* x = ‖x‖²` | 同上 |
| `Ising2D.EvenSectorBridge` | 章 011 の `W` と章 017 の `V^{(+)}` の橋渡し（上記 0 の表） | 011・017 からの入力 |
| `EvenSectorBridge.quad_Qproj` | `x^* Q̌_ε x = ‖Q̌_ε x‖²` | `check_number_operator_is_hermitian` (4) |
| `EvenSectorBridge.sum_quad_Qproj` | `∑_ε ‖Q̌_ε x‖² = ‖x‖²` | Step 1 |
| `EvenSectorBridge.quad_Vr_eq_sum` | `x^T V^{(+)} x = ∑_ε Λ̌_ε ‖Q̌_ε x‖²` | Step 1 |
| **`EvenSectorBridge.quad_le_lamMax`** | **`ε_ℝx = x, ‖x‖ = 1 ⇒ x^⊤W_ℝx ≤ Λ̌_max`**（`EvenSectorBridge.W` が人手 `def_W_real` の `W_ℝ`） | **Step 1** |
| `EvenSectorBridge.reVec` / `cvec_reVec_add` / `reVec_eigen` | 複素固有ベクトルの実部も（実固有値なら）固有ベクトル | Step 2 |
| **`EvenSectorBridge.exists_real_max_eigenvector`** | **`Λ̌_max` の実固有ベクトルが存在し、偶セクターに属する** | **Step 2** |
| **`EvenSectorBridge.c_plus_equals_lamMax`** | **`c_+(M) = Λ̌_max`** | **定理本体（Step 3）** |
| `EvenSectorBridge.exists_maximizer` | 上限が偶セクターの実単位ベクトル `x_0` で**達成される** | 最後の一文 |

#### `ThermodynamicLimit/ColumnLimitAndClosedForm/TheoremOnsagerExactSolution.lean`（ラベル `onsager_exact_solution`、**本プロジェクトの結論**）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `EvenSectorBridge.lamMax_eq_LambdaM` | `Λ̌_max = Λ^{(1/2)}_M`（章 012 の記法との突き合わせ） | 記法の同定 |
| **`EvenSectorBridge.LambdaM_le_rayleighSup`** | **`Λ^{(1/2)}_M = c_+(M) ≤ c(M)`**（章 011 の `c_plus_le_c` と `c_plus_equals_lamMax`） | `c_between_Lambda_half_and_twice_Lambda_half` Step 1 |
| `Ising2D.NecSuf.rayleighSup_le_two_mul_evenSectorRayleighSup`（`NecSuf/EvenSectorUpperBound.lean`）/ `Ising2D.onsager_step3_c_le_two_c_plus` | **`c(M) ≤ 2c_+(M)`**（Step 2 の前の形の形式化の記録とその `ε = epsilonR M` への特殊化。今の Step 2 の必要十分版ではない） | `c_between_Lambda_half_and_twice_Lambda_half` Step 2 |
| **`EvenSectorBridge.rayleighSup_le_two_mul_LambdaM`** | **`c(M) ≤ 2c_+(M) = 2Λ^{(1/2)}_M`**（任意の橋渡しの `W` について、記録の特殊化を通す。形式化の記録で、通しの定理は使わない） | `c_between_Lambda_half_and_twice_Lambda_half` Step 2 |
| **`Ising2D.c_le_twice_c_plus_physical`**（`TheoremOnsagerExactSolution.lean`） | 具体的な `W_ℝ = ϱ(W)` と `ε_ℝ` について、`Λ = c_+(M)` なら **`c(M) ≤ 2Λ`**（人手の準備の各行・7 行の鎖・2 行・2 行と 1 対 1） | `c_between_Lambda_half_and_twice_Lambda_half` Step 2（通しの定理が引く） |
| `EvenSectorBridge.rayleighSup_sandwich_LambdaM` | `Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M`（任意の橋渡しの `W` について。形式化の記録で、通しの定理は具体的な `W` の `rayleighSup_sandwich_LambdaM_physical` を使う） | `c_between_Lambda_half_and_twice_Lambda_half` |
| `Ising2D.onsager_limit_in_N_row` | `N_row → ∞` の極限は `(1/M) log c(M)` | Step 1（章 012 の `limit_of_log_Z_in_N_row`） |
| `Ising2D.onsager_limit_in_M` | 挟み撃ち `(1/M)log Λ ≤ (1/M)log c(M) ≤ (1/M)log Λ + (log 2)/M` から、`M → ∞` の極限が Onsager の表式になる | Step 3（`log` の単調性、`(log 2)/M → 0`、章 012 の `onsager_free_energy_expression` を `δ = 1/2` で適用） |
| **`Ising2D.onsager_exact_solution`** | **`lim_{M→∞} lim_{N_row→∞} (1/(M N_row)) log Z = (1/2)log(2 sinh 2K_2) + (1/4π)∫₀^{2π} γ(θ)dθ`** | **定理本体** |

#### `ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimCPlusValueCSandwichAndDoubleLimitOfLogZ.lean`（ラベル `c_plus_value_c_sandwich_and_double_limit_of_log_Z`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.c_plus_eq_LambdaM_half_physical` | 具体的な `W` について、`M ≥ 2` で `c_+(M) = Λ^{(1/2)}_M` | 章末の主張の (1)（`c_plus_equals_Lambda_half_integer`） |
| `Ising2D.c_plus_value_c_sandwich_and_double_limit_of_log_Z` | (1) `c_+(M) = Λ^{(1/2)}_M`、(2) `Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M`、(3) 2 重極限が Onsager の表式（仮定は `K_1, K_2 > 0` だけ） | 章末の主張 |

#### `EigenvalueProblem/EigenvectorOfMaxEigenvalue/DefinitionOpenChainAndBoundaryOperators.lean`・`ClaimH1PlusInSigmaZForm.lean`（ラベル `def_D0_open_chain_operator`・`def_G_boundary_operator`・`H1_plus_in_sigma_z_form`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.openChainD0` / `boundaryG` | `D_0 = ∑_{m=1}^{M_col-1}σ^z_mσ^z_{m+1}`、`G = σ^z_{M_col}σ^z_1` | `def_D0_open_chain_operator`・`def_G_boundary_operator` |
| `Ising2D.Y_kronecker_form` / `Z_nextSite_kronecker_form` / `sigmaZ_mul_sigmaZ_nextSite_kronecker`（と `ne_nextSite_of_not_last`） | `Y_m`・`Z_{m+1}`・`σ^z_mσ^z_{m+1}` のクロネッカー積表示（`Y`・`Z` の 2 本は定義そのもので `rfl`、`σ^zσ^z` は 4 段の `calc`） | 証明の準備 1 |
| `Ising2D.Y_lastSite_kronecker_form` / `Z_firstSite_kronecker_form` / `epsilon_kronecker_form` / `sigmaZ_lastSite_mul_sigmaZ_firstSite_kronecker` | `Y_{M_col}`・`Z_1`・`ε`・`σ^z_{M_col}σ^z_1` のクロネッカー積表示（`Z_1` は 2 段、`σ^zσ^z` は 4 段の `calc`） | 証明の準備 2 |
| `Ising2D.I_smul_Y_mul_Z_next_of_not_last`（と `siteProd_ite_smul`） | `i(Y_mZ_{m+1}) = σ^z_mσ^z_{m+1}`（11 段の `calc`。`siteProd_ite_smul` は第 `m` 因子を `if` で書いた族についての `kronecker_multilinear` の `r = 1` の式） | 証明の準備 3 |
| `Ising2D.neg_I_smul_Y_lastSite_mul_Z_firstSite`（と `siteProd_ite_ite_smul`） | `-(i(Y_{M_col}Z_1)) = εG`（17 段の `calc`） | 証明の準備 4 |
| `Ising2D.H1plus_eq_bulk_sub_boundary` / `sum_filter_not_last_eq_sum_castSucc` / `castSucc_val_add_one_ne` | `H_1^{(+)} = ∑_{m=1}^{M_col-1}Y_mZ_{m+1} - Y_{M_col}Z_1`、和の添字 `{1,…,M_col-1}` の `Finset.filter` から `Fin (M_col-1)` への読み替え | `def_H1_plus` と最後の鎖の 1・5 行目 |
| **`Ising2D.H1_plus_in_sigma_z_form`** | **`iH_1^{(+)} = D_0 + εG`**（`M_col ≥ 2`。最後の 7 行の鎖と 7 段の `calc`） | **主張本体** |

#### `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimEpsilonD0GCommuteAndDiagonalAction.lean`（ラベル `epsilon_D0_G_pairwise_commute`・`epsilon_G_is_involution`・`D0_G_diagonal_action`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.epsilon_mul_sigmaZ_mul_sigmaZ` | `ε(σ^z_jσ^z_k) = (σ^z_jσ^z_k)ε`（8 段の `calc`） | `epsilon_D0_G_pairwise_commute` の準備（`ε` と `σ^z` の対の可換）の 8 行 |
| `Ising2D.sigmaZ_mul_sigmaZ_comm` | `σ^z_jσ^z_k = σ^z_kσ^z_j`（`j ≠ k` は `siteOp_mul_comm`） | 同 準備（`σ^z` どうしの可換） |
| `Ising2D.sigmaZ_mul_sigmaZ_mul_boundaryG` | `(σ^z_aσ^z_b)G = G(σ^z_aσ^z_b)`（14 段の `calc`） | 同 準備（`σ^z` の対と `G` の可換）の 14 行 |
| `Ising2D.epsilon_mul_openChainD0` / `epsilon_mul_boundaryG` / `openChainD0_mul_boundaryG` | `εD_0 = D_0ε`（`M_col ≥ 2`、5 段）、`εG = Gε`（3 段）、`D_0G = GD_0`（`M_col ≥ 2`、5 段） | `epsilon_D0_G_pairwise_commute` の 3 つの鎖 |
| `Ising2D.sigmaZ_mul_self` | `σ^z_kσ^z_k = I`（5 段の `calc`） | `epsilon_G_is_involution` の準備の 5 行 |
| `Ising2D.epsilon_mul_boundaryG_sq` | `(εG)^2 = I`（`M_col ≥ 2`、15 段の `calc`） | `epsilon_G_is_involution` の 15 行 |
| `Ising2D.sigmaZ_mul_sigmaZ_mulVec_basisVec_spin` | `(σ^z_aσ^z_b)f_{ι(s)} = (s(a)s(b))_ℂ f_{ι(s)}`（7 段の `calc`） | `D0_G_diagonal_action` の準備の 7 行 |
| `Ising2D.openChainD0_mulVec_basisVec` / `boundaryG_mulVec_basisVec` | `D_0f_{ι(s)} = (∑_m s(m)s(m+1))_ℂ f_{ι(s)}`（5 段）、`Gf_{ι(s)} = (s(M_col)s(1))_ℂ f_{ι(s)}`（8 段） | `D0_G_diagonal_action` の開鎖項の 5 行・周期境界項の 8 行 |

#### `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimOpenChainSpinSums.lean`（ラベル `def_open_chain_spin_energy`・`open_chain_partition_sum`・`open_chain_endpoint_product_sum`・`open_chain_spin_sums_positive`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.openChainEnergy` / `openChainEnergy_mem_int` | `E(s) = ∑_{m=1}^{M_col-1}s(m)s(m+1) ∈ ℤ` | `def_open_chain_spin_energy` |
| `Ising2D.bondSpin` / `openChainPhi` / `openChainPhiInv` / `openChainPhiInv_zero` / `openChainPhiInv_succ` / `openChainPhiEquiv` | `t_m(s) = s(m)s(m+1)`、`Φ(s) = (s(1); t_1(s),…,t_{M_col-1}(s))` は全単射（逆写像は `s(1) := u`、`s(m+1) := s(m)τ_m`。人手の `M_col` は `n + 2`、結合の添字は `Fin (n + 1)`） | `open_chain_partition_sum` の Step 1 |
| `Ising2D.varsigma` / `coe_varsigma_one` / `coe_varsigma_zero` / `varsigmaEquiv` / `varsigmaWordEquiv` | `ς(e) = 2e - 1` と、成分ごとの `ς` による `{0,1}^{M_col-1} → {-1,1}^{M_col-1}` の全単射 | `open_chain_partition_sum` の Step 1 |
| `Ising2D.exp_openChainEnergy_eq_prod_bondSpin` | `exp(KE(s)) = Π_m exp(Kt_m(s))`（3 段） | `open_chain_partition_sum` の Step 2 の準備の鎖 |
| `Ising2D.binaryWordRealSum_eq_sum_univ` / `openChainEnergy_eq_sum_fin` | 運ぶ段（人手の行は無い）: `{0,1}^r` の上の和を全体の上の和で読む、`E(s)` を添字 `Fin (n + 1)` の和で読む | `open_chain_partition_sum` の Step 2 |
| `Ising2D.prod_bondSpin_of_two` / `prod_bondSpin_of_ge_three` / `prod_bondSpin_rearrange` / `prod_bondSpin_eq_first_mul_last` | `Π_m t_m(s) = s(1)s(M_col)`（`M_col = 2` の 3 段と `M_col ≥ 3` の 4 段。可換性と結合性の段は `prod_bondSpin_rearrange`） | `open_chain_endpoint_product_sum` の Step 2 |
| `Ising2D.endpoint_mul_exp_openChainEnergy_eq_prod` | `s(M_col)s(1)exp(KE(s)) = Π_m(t_m(s)exp(Kt_m(s)))`（4 段） | `open_chain_endpoint_product_sum` の Step 2 |
| **`Ising2D.open_chain_partition_sum`** | **`∑_s exp(KE(s)) = 2(2cosh K)^{M_col-1}`**（左辺と 10 行の calc） | **主張本体** |
| **`Ising2D.open_chain_endpoint_product_sum`** | **`∑_s s(M_col)s(1)exp(KE(s)) = 2(2sinh K)^{M_col-1}`**（左辺と 12 行の calc） | **主張本体** |
| `Ising2D.open_chain_partition_sum_pos` / `open_chain_endpoint_product_sum_pos` | 二つのスピン和は正（`K > 0`） | `open_chain_spin_sums_positive` |

#### `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusReduction.lean`（ラベル `trace_of_epsilon_V_plus` の Step 1・Step 2）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| **`Ising2D.trace_epsilon_VPlusOfTransfer`** | **`tr(εV^{(+)}) = tr(εV_1^{(+)}V_2)`** | **Step 1** |
| `Ising2D.I_mul_smul_H1plus` | `(iκ)H_1^{(+)} = κD_0 + κ(εG)`（4 段の calc） | 準備 (P1) |
| `Ising2D.commute_openChainD0_epsilon_mul_boundaryG` | `D_0(εG) = (εG)D_0`（5 段の calc） | 準備 (P2) の鎖 |
| `Ising2D.openChainD0_mul_smul_epsilon_mul_boundaryG` / `smul_epsilon_mul_boundaryG_mul_smul_openChainD0` / `epsilon_mul_smul_openChainD0` | `D_0(κ(εG)) = (κ(εG))D_0`、`(κ(εG))(κD_0) = (κD_0)(κ(εG))`、`ε(κD_0) = (κD_0)ε` | 準備 (P2) の `commuting_with_scalar_multiple` の 3 回の適用 |
| `Ising2D.V1plus_eq_exp_openChainD0_mul_exp` | `V_1^{(+)} = exp(K_1D_0)exp(K_1εG)` | Step 2（`theorem_exp_product`） |
| `Ising2D.matExp_hasSum`（`Representation.lean`） / `toFinPow_matExp_eq_evenOddSeriesSum` | `Φ(exp(X)) = Σ_{n=0}^{∞}(1/n!)_ℂΦ(X^n)`（`def_exp` (1) を、添字を `Fin (2^M)` へ付け替える `Φ := toFinPowAlgEquiv M` で移し、部分和 `Σ_{n=0}^{N}` の極限で読む） | Step 2 の真ん中の鎖の 1 行目 |
| `Ising2D.smul_epsilon_mul_boundaryG_pow_of_even` / `smul_epsilon_mul_boundaryG_pow_of_odd` | `(κ(εG))^n` は `n` 偶数で `κ^nI`、奇数で `(1_ℂκ^n)(εG)` | Step 2（`exponential_series_of_even_odd_power_terms` の仮定。(P4)・(P3)） |
| `Ising2D.exp_epsilon_mul_boundaryG` | `exp(K_1εG) = cosh(K_1)I + sinh(K_1)εG`（人手の 3 行と印 `人手 1`〜`人手 3` の段。`exponential_series_of_even_odd_power_terms` は `Φ` で移した `Fin (2^M)` 添字の行列に当て、逆写像で戻す） | Step 2 の真ん中の鎖 |
| **`Ising2D.epsilon_mul_V1plus`** | **`εV_1^{(+)} = exp(K_1D_0)(cosh(K_1)ε + sinh(K_1)G)`** | **Step 2** |

#### `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusMatrixEntries.lean`（ラベル `trace_of_epsilon_V_plus` の準備 (P5) と Step 3）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.basisVec_apply_eq_prod` | `(f_I)_J = ∏_m (e_{i_m})_{j_m}`（Lean の定義 `Pi.single` を人手の形へ読み替える段） | 準備 (P5) の 2 行目の根拠（`def_end_iso`・`def_kronecker` (1)） |
| **`Ising2D.basisVec_configBasisIso_apply`** | **`(f_{ι(s)})_{ord(s')} = δ_{s=s'}`** | **準備 (P5)** |
| **`Ising2D.mulVec_basisVec_configBasisIso_apply`** | **`(Xf_{ι(s)})_{ord(s')} = X_{ord(s'),ord(s)}`** | **準備 (P5) の列の読み取り** |
| `Ising2D.negSpinConf` / `configBasisIso_negSpinConf` | `(-s)(m) := -s(m)`、`ι` のもとで全成分の入れ替えは `ι(s) ↦ ι(-s)` | Step 3 (b) とその理由 |
| **`Ising2D.openChainD0_apply_configBasisIso`** | **`(D_0)_{ord(s'),ord(s)} = (E(s))_ℂδ_{s=s'}` の 4 段** | **Step 3 (a) の 4 行** |
| **`Ising2D.boundaryG_apply_configBasisIso`** | **`G_{ord(s'),ord(s)} = (s(M_col)s(1))_ℂδ_{s=s'}` の 4 段** | **Step 3 (a) の「同じ 4 行で」** |
| `Ising2D.eq_diagonal_of_apply_configBasisIso` | 非対角成分が `0_ℂ`、対角成分が `d(s)` なら対角成分 `d` の対角行列 | Step 3 (a) の「全ての番号は `ord(s)` の形なので対角行列」（`row_configuration_numbering_bijective`・`def_diagonal_matrix`） |
| `Ising2D.openChainD0_eq_diagonal` / `boundaryG_eq_diagonal` | `D_0`・`G` は対角行列で、対角成分は `(E(s))_ℂ`・`(s(M_col)s(1))_ℂ` | Step 3 (a) |
| **`Ising2D.smul_openChainD0_eq_diagonal`** | **`κD_0` は対角行列で `(κD_0)_{ord(s),ord(s)} = κ(E(s))_ℂ = (K_1E(s))_ℂ`** | **Step 3 (a) の `κD_0` の 2 行** |
| **`Ising2D.matExp_smul_openChainD0`** / **`matExp_smul_openChainD0_apply`** | **`exp(κD_0)` は対角行列で `(exp(κD_0))_{ord(s),ord(s)} = exp((K_1E(s))_ℂ) = (exp(K_1E(s)))_ℂ`** | **Step 3 (a) の最後の 2 行**（`exp_of_diagonal_matrix`・`complex_exp_of_real_argument`） |
| **`Ising2D.epsilon_mulVec_basisVec_configBasisIso`** | **`εf_{ι(s)} = f_{ι(-s)}`** | **Step 3 (b)** |
| **`Ising2D.epsilon_apply_configBasisIso_col`** | **`ε_{ord(s'),ord(s)} = δ_{-s=s'}` の 3 段** | **Step 3 (b) の 3 行** |
| `Ising2D.mul_apply_configBasisIso_of_single_nonzero` | 行 `ord(s)` の成分が `ord(u)` 以外で `0_ℂ` なら `(AX)_{ord(s),J} = A_{ord(s),ord(u)}X_{ord(u),J}` | Step 4 の二つの鎖の 1・2 行目の根拠（`mat_mult`・`complex_zero_times_is_zero`・`finite_sum_with_single_nonzero_term`） |
| `Ising2D.matExp_smul_openChainD0_apply_of_ne` / `boundaryG_apply_configBasisIso_of_ne` / `boundaryG_apply_configBasisIso_self` | `(exp(κD_0))_{ord(s),ord(t)} = 0_ℂ`・`G_{ord(s),ord(t)} = 0_ℂ`（`t ≠ s`）、`G_{ord(s),ord(s)} = (s(M_col)s(1))_ℂ` | Step 4 が (a) として使う形 |
| `Ising2D.negSpinConf_negSpinConf` / `epsilon_apply_configBasisIso_of_ne` / `epsilon_apply_configBasisIso_neg_self` | `-(-s) = s`、`ε_{ord(s),ord(t)} = 0_ℂ`（`t ≠ -s`）、`ε_{ord(s),ord(-s)} = δ_{-(-s)=s} = 1_ℂ`（(b) の 3 行を行の成分に使う） | Step 4 が (b) として使う形 |
| `Ising2D.sum_spin_mul_self` / `sum_negSpin_mul_self` / **`V2_apply_configBasisIso_self`** / **`V2_apply_configBasisIso_neg_self`** | `∑_m s(m)s(m) = M_col`、`∑_m (-s(m))s(m) = -M_col`（項ごとに `1`・`-1` を足す）、**`(V_2)_{ord(s),ord(s)} = (exp(K_2M_col))_ℂ`、`(V_2)_{ord(-s),ord(s)} = (exp(-K_2M_col))_ℂ`** | **Step 3 (c)**（一般の成分は `Ising2D.V2_apply_configBasisIso`） |

#### `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusClosedForm.lean`（ラベル `trace_of_epsilon_V_plus` の Step 4・Step 5・Step 6 と主張）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.trace_eq_sum_configBasisIso` | `tr(X) = ∑_{s∈𝔐} X_{ord(s),ord(s)}` | Step 5 の二つの鎖の 1 行目の根拠（`def_trace` と準備の和の定め方） |
| `Ising2D.finite_sum_over_spinConf_of_real_scalar_multiples` | `∑_{s∈𝔐} c a(s) = c ∑_{s∈𝔐} a(s)`（`Fin (2^M)` へ付け替えて具体版 `finite_sum_of_real_scalar_multiples` を当てる） | Step 5 の二つの鎖の 4 行目の根拠 |
| **`Ising2D.matExp_openChainD0_mul_epsilon_mul_V2_apply_self`** / **`matExp_openChainD0_mul_boundaryG_mul_V2_apply_self`** | **`(exp(κD_0)(εV_2))_{ord(s),ord(s)} = (exp(-K_2M_col)exp(K_1E(s)))_ℂ`、`(exp(κD_0)(GV_2))_{ord(s),ord(s)} = (exp(K_2M_col)(s(M_col)s(1)exp(K_1E(s))))_ℂ`（人手と同じ 7 段ずつ）** | **Step 4 の二つの鎖** |
| **`Ising2D.trace_matExp_openChainD0_mul_epsilon_mul_V2`** / **`trace_matExp_openChainD0_mul_boundaryG_mul_V2`** | **`tr(exp(κD_0)(εV_2)) = (exp(-K_2M_col)S_cosh)_ℂ`、`tr(exp(κD_0)(GV_2)) = (exp(K_2M_col)S_sinh)_ℂ`（人手と同じ 4 段ずつ）** | **Step 5 の二つのトレースの鎖** |
| **`Ising2D.trace_epsilon_VPlusOfTransfer_eq_spin_sums`** | **`tr(εV^{(+)}) = (cosh K_1(exp(-K_2M_col)S_cosh) + sinh K_1(exp(K_2M_col)S_sinh))_ℂ`（人手と同じ 11 段）** | **Step 5 の組み立ての鎖** |
| `Ising2D.finite_sum_of_constant_real` | `∑_{j=1}^{M} c = cM` | Step 5 の実数の鎖の 4 行目の根拠（`+K_2` の側） |
| `Ising2D.finite_sum_of_negated_constant_real` | `∑_{j=1}^{M} (-c) = -(cM)` | 同（`-K_2` の側） |
| `Ising2D.spin_sums_combination_eq_closed_form` | `cosh K_1(exp(-K_2M_col)S_cosh) + sinh K_1(exp(K_2M_col)S_sinh) = (2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col}` | Step 5 の実数の鎖（左辺と 8 行） |
| `Ising2D.trace_epsilon_VPlusOfTransfer_closed_form` | `tr(εV^{(+)}) = (2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col}` | Step 5 の「ゆえに主張の等号が成り立つ」 |
| `Ising2D.closed_form_of_trace_epsilon_V_plus_pos` | `(2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col} > 0`（`K_1 > 0`） | Step 6 |
| `Ising2D.trace_epsilon_VPlusOfTransfer_pos` | `0 < Re tr(εV^{(+)})`（`K_1 > 0`） | 主張の `∈ ℝ_{>0}` を実部で読んだもの |
| **`Ising2D.trace_of_epsilon_V_plus`** | **閉じた式と正値性** | **主張本体** |
| `Ising2D.trace_epsilon_vPlusDataOf_pos` | `vPlusDataOf` の `V^{(+)}` について `0 < Re tr(εV^{(+)})`（`VPlusOfTransfer_eq_VPlus` で人手の形へ戻す） | 最終定理の入力から欄 `htr` を外すために使う |

### 1.2 必要十分版（`lean/Ising2D/NecSuf/ParityFermion.lean`、名前空間 `Ising2D.NecSuf`）

| Lean の名前 | 内容 | 台に要求する構造 | 人手証明のラベル |
| --- | --- | --- | --- |
| `NecSuf.anticomm_sum_smul` | `e` が各 `x_i` と反交換 ⇒ `x_i` の任意の有限 `𝕜` 線型結合とも反交換 | `NonUnitalNonAssocRing A` + `DistribSMul 𝕜 A` + `SMulCommClass 𝕜 A A` + `IsScalarTower 𝕜 A A`（`𝕜` に構造は不要。`A` の積の結合律・単位元・代数構造も不要） | `epsilon_anticommutes_with_check_Z_Y` (2)(3) |
| **`NecSuf.commute_parity_num`** | **`e` が `c_i`, `a_i` の両方と反交換 ⇒ `e` は `n_i = c_i a_i` と可換**（具体版と同じ 3 行。2 行目は `NecSuf.commute_mul_of_anticomm'`） | **`Semigroup A` + `HasDistribNeg A` だけ** | 同 (4) 前半 |
| `NecSuf.commute_mul_of_anticomm'`（`NecSuf/CommuteWithAnticommutingProductAndScalarMultiple.lean`） | `GX = −(XG)`, `GY = −(YG)` ⇒ `G(XY) = (XY)G`（8 段） | `Semigroup A` + `HasDistribNeg A` | `product_of_anticommuting_matrices_commutes` |
| `NecSuf.commute_smul_of_commute'`（同） | `GX = XG` ⇒ `G(cX) = (cX)G`（3 段） | `Mul A` + `SMulCommClass 𝕜 A A` + `IsScalarTower 𝕜 A A`（`𝕜` に構造なし） | `commuting_with_scalar_multiple` |
| `NecSuf.commute_sub_of_commute'` | `GX = XG`, `GW = WG` ⇒ `G(X − W) = (X − W)G`（8 段） | `Mul A` + `Add A` + 左右の分配則 + `HasDistribNeg A` + `x − y = x + (−y)`（積の結合則・単位元、加法の零・結合則・可換性・逆元則は不要） | `commuting_with_difference` |
| `NecSuf.commute_defFactor_of_commute'` | `en = ne` ⇒ `e(cn + d(1 − n)) = (cn + d(1 − n))e`（`c`・`d` は無関係な二つのスカラー） | `MulOneClass A` + `Add A` + 左右の分配則 + `HasDistribNeg A` + `x − y = x + (−y)` + `SMul 𝕜 A` + `SMulCommClass` + `IsScalarTower`（`𝕜` に構造なし。`d = 1 − c`・`c ∈ {0,1}`・`n` の冪等性は不要） | `epsilon_anticommutes_with_check_Z_Y` (4) の `A_ν` の鎖 |
| **`NecSuf.commute_parity_finProdLeft_defFactor`** | **`e` が `c_ν`, `a_ν` と反交換 ⇒ `e` は `∏_ν (c'_ν n_ν + d'_ν(1 − n_ν))` と可換**（具体版と同じ並び） | 同上で `MulOneClass A` を `Monoid A` に（有限積に積の結合則が効く） | 同 (4) 後半 |
| **`NecSuf.commute_parity_projOn`** | **`e` は `Q_ε` とも可換**（添字を `Finset` で取る `projOn` の形。`M = 0` の埋め合わせに使う） | **`Ring A` だけ**（`projOn` の定義が要する） | 同 (4) 後半 |
| `NecSuf.num_mul_cre'` | `a_ic_i = 1 − n_i`, `c_ic_i = 0` ⇒ `n_i c_i = c_i`（具体版 `nOp_mul_cre` と同じ 13 行） | `Monoid A` + `Add A` + `Zero A` + 左分配則 + `HasDistribNeg A` + `x − y = x + (−y)` + `0x = 0` + `x − 0 = x`（加法の結合則・可換性・逆元則、右分配則、`x0 = 0` は不要） | `epsilon_eigenvalue_on_check_Q` (2) Step 2 冒頭 |
| `NecSuf.num_mul_cre` | `n_i c_i = c_i`（反交換関係から `ann_mul_cre` で `a_ic_i = 1 − n_i` を出し、`num_mul_cre'` を使う） | `Ring A` | 同 |
| **`NecSuf.projOn_insert_mul_cre`** | **`μ ∈ s`, `μ ∉ T` ⇒ `Q_{T∪{μ}}(c_μ Q_T) = c_μ Q_T`** | **`Ring A` だけ** | 同 (2) Step 2 と同じ結論の、行列の上の別の手順（人手との対応には数えない） |
| **`NecSuf.cre_mul_projOn_ne_zero`** | **`Q_T ≠ 0` ⇒ `c_μ Q_T ≠ 0`** | **`Ring A` だけ（1 次元性不要）** | 同 (2) Step 1 と同じ結論の、行列の上の別の手順（人手との対応には数えない） |
| `NecSuf.num_mulVec_eq_zero_of_fixed`（`NecSuf/SignReversalOnGeneratorVector.lean`） | `Qq = q`, `nQ = sQ`, `s = 0` ⇒ `nq = 0`（具体版と同じ 6 行） | 係数は `NonUnitalSemiring`（行列 `Matrix ι ι R` と数ベクトル `ι → R`）。スカラー `s` は別の集合 `S` の元で、`0 • x = 0` だけを使う | 同 (2) Step 1 |
| `NecSuf.ann_mulVec_cre_mulVec_eq_of_num_mulVec_eq_zero`（同） | `ac = I − n`, `nq = 0` ⇒ `a(cq) = q`（具体版と同じ 6 行） | 係数は `Ring`（可換則は不要。`n = ca` も `n` の冪等性も不要） | 同 (2) Step 1 |
| `NecSuf.cre_mulVec_ne_zero_of_ann_mulVec_cre_mulVec_eq`（同） | `a(cq) = q`, `q ≠ 0` ⇒ `cq ≠ 0`（具体版と同じ 3 行） | 係数は `NonUnitalNonAssocSemiring` | 同 (2) Step 1 |
| `NecSuf.mulVec_eq_of_eq_one_sub_of_mulVec_eq_zero`（同） | `A = I − n`, `nq = 0` ⇒ `Aq = q`（具体版と同じ 5 行） | 係数は `NonAssocRing`（単位行列と差に要る。積の結合則・可換則は不要） | 同 (2) Step 2 |
| `NecSuf.finProdLeftOmitting_mulVec_eq_of_fixed`（同） | `μ < j` で `A_μA_j = A_jA_μ`, `A_μq = q`, `(∏A)q = q` ⇒ `(∏_{j≠μ}A_j)q = q`（具体版と同じ 5 行） | 係数は `NonUnitalSemiring`（行列の積の結合則だけ。単位元・差は不要） | 同 (2) Step 2 |
| `NecSuf.finProdLeft_mulVec_cre_mulVec_eq_of_omitting_mulVec_eq`（同） | `A'` と `A` が `μ` 以外で一致、`A'_μ = n`, `nc = c`, `cΠ' = Π'c`, `Π'q = q` ⇒ `(∏A')(cq) = cq`（具体版と同じ 10 行） | 係数は `NonUnitalSemiring`（`n` が `ca` であること・冪等性・`A` の形は不要） | 同 (2) Step 2 |
| `NecSuf.mulVec_cre_mulVec_eq_neg_smul_of_anticomm`（同） | `ec = −(ce)`, `eq = ηq` ⇒ `e(cq) = (−η)(cq)`（具体版と同じ 9 行） | 係数は `NonUnitalRing`（可換則・単位元は不要）。スカラー `η` は別の環 `S` の元で、`S` の可換則も不要。効くのは `SMulCommClass S R R`（`A(ηv) = η(Av)`） | 同 (2) Step 3 の前半 |
| `NecSuf.eq_neg_of_insert` / **`NecSuf.eq_univ_mul_neg_one_pow_of_sub_card`** / `eq_univ_mul_neg_one_pow`（`NecSuf/SignAfterReplacingComponents.lean`） | **`μ ∉ T ⇒ η(T∪{μ}) = −η(T)` なら `η(T) = η(univ)(−1)^{|ι|−|T|}`**（具体版と同じ 2 行と、`k := |ι| − |T|` の帰納法の 4 行・7 行） | 値の集合は `Monoid R` + `HasDistribNeg R` だけ。人手の「乗法の交換則」の行は `−1` が任意の元と可換であることしか使わず、それは `HasDistribNeg` から出る（`R` の可換則・加法・`η ∈ {±1}` は不要）。添字の集合は有限であることだけ | `epsilon_eigenvalue_on_check_Q` (3) |
| `NecSuf.one_sub_smul_mul_eq_smul'`（`NecSuf/FactorsActingAsScalarsOnProjection.lean`） | `nQ = dQ` ⇒ `(1 − cn)Q = (1 − cd)Q`（具体版と同じ 10 行） | `NonAssocRing R`・`Ring 𝕜`・`Module 𝕜 R`・`IsScalarTower 𝕜 R R`（`R` の積の結合則・係数の `2`・`ε_μ ∈ {0,1}`・`ň_μ` の冪等性・`𝕜` の可換則は不要） | 同 (4) の前半 |
| `NecSuf.finProdLeft_mul_eq_prod_smul'`（同） | `A_jQ = a_jQ` ⇒ `(∏_j A_j)Q = (∏_j a_j)Q`（左から掛ける有限積。具体版と同じ 3 行・8 行） | `Semigroup R`・`SemigroupAction 𝕜 R`・`SMulCommClass 𝕜 R R`・`CommMonoid 𝕜`（`R` の加法・単位元、`1x = x`、因子どうしの可換性は不要） | 同 (4) の前半 |
| `NecSuf.neg_one_pow_mul_self'` / `mul_eq_smul_mul_of_sign_pow'`（`NecSuf/ParityFormFromSignsOnProjections.lean`） | `eQ = η_εQ`, `η_ε = η(−1)^{m−k}`, `PQ = (−1)^kQ`, `k ≤ m` ⇒ `eQ = (η(−1)^m)(PQ)`（具体版と同じ 3 行・7 行） | `Monoid 𝕜`・`HasDistribNeg 𝕜`・`Mul R`・`SemigroupAction 𝕜 R`（`1x = x`、`𝕜` の積の可換則・加法、`R` の結合則・分配則・単位元、`η ∈ {±1}` は不要。`−1` どうしの可換性は `Commute.refl`） | 同 (4) の後半 |
| `NecSuf.map_prod_two_valued_eq_pow'`（`NecSuf/PowerFromProductOfTwoValuedFactors.lean`。数え上げの `wordCount_one'`・`wordCount_castSucc'`・`wordCount_le'` も同じファイル） | `f(ab) = f(a)f(b)`, `f(u(1)) = 1`, `f(u(0)) = s` ⇒ `f(Π_μ u(ε_μ)) = s^{k−\|ε\|_k}`（具体版と同じ 5 行・7 行・6 行・6 行） | `Mul R`（有限積は左から掛ける `finProdLeft`。`R` の結合則・単位元・可換則は不要）・`Monoid S`（効くのは単位元の `1z = z`・`z1 = z` と冪の定義。`S` の結合則・可換則、`s = −1`、`(−1)(−1) = 1`、`f(1) = 1` は不要） | `trace_of_epsilon_V_plus_via_check_eigenvalues` Step 2 |
| `NecSuf.signed_term_eq_map_mul'`（`NecSuf/SignedTermAsImageOfReorderedProduct.lean`） | `f(a)f(b) = f(ab)`, `ηε = η1q`, `f(u) = q`, `f(h) = η1` ⇒ `ηεf(l) = f((ul)h)`（具体版と同じ 6 行。7 行目の `ť_ε` の置き方は具体版の定義） | `CommSemigroup R`（6 行目の `(ab)c = (bc)a` に結合則と可換則が 1 回ずつ要る）・`Mul S`（`S` の結合則・可換則・単位元、`q` が `−1` の冪であること、`η1`・`h` が `±1` であること、`f(1) = 1` は不要） | `trace_of_epsilon_V_plus_via_check_eigenvalues` Step 3 |
| `NecSuf.eq_smul_of_mul_eq_smul_mul'`（同） | `Σ_εQ_ε = 1`（`binWordSum`）, `eQ_ε = c(PQ_ε)` ⇒ `e = cP`（具体版の 9 行のうち「`c`, `P` の置き方」を除く 8 行と同じ行） | `MulOneClass R`・`Add R`・`LeftDistribClass R`・`SMul 𝕜 R`・`IsScalarTower 𝕜 R R`（左単位元は効かないが右単位元だけのクラスが無いので `MulOneClass` で受ける。`R` の積の結合則、加法の結合則・可換則・零元、`Q_ε` の冪等性・直交性、`𝕜` の積は不要） | 同 (4) の後半 |
| `NecSuf.star_projOn` | `n_i` が可換な自己共役族なら `Q_ε^* = Q_ε` | `StarRing A` | `check_number_operator_is_hermitian` (4) |
| `NecSuf.smul_left_cancel_of_ne_zero` | `x ≠ 0` ⇒ `ηx = η'x ⇒ η = η'` | `Module 𝕜 A`（`𝕜` は体） | `epsilon_eigenvalue_on_check_Q` (1) |
| `NecSuf.sum_powerset_signed_exp` | `∑_{T ⊆ s} (−1)^{|s|−|T|} exp(∑_{i∈s} g_i(1_{i∈T} − 1/2)) = ∏_{i∈s} 2 sinh(g_i/2)` | ℝ の `exp`/`sinh` だけ | 旧い分け方の `trace_of_epsilon_V_plus_via_check_eigenvalues` Step 2（冪集合の上の和を一度に積へ変える別の手順。いまの具体版は Step 2〜5 の鎖で、これを使っていない） |
| **`NecSuf.open_chain_weighted_sum`**（`NecSuf/OpenChainSpinSum.lean`。前半は `open_chain_weighted_sum_eq_sum_prod`、`{-1,1}` の上の和は `sum_spinVal_const`、展開の段は `prod_add_eq_binWordSum'`・`finset_prod_eq_finProdLeft'`、`ς` の値は `varsigma_one_eq`・`varsigma_zero_eq`） | **`∑_{s∈𝔐} ∏_{m=1}^{M_col-1} g(t_m(s)) = 2(g(1)+g(-1))^{M_col-1}`**（具体版の最後の鎖の `人手 2`〜`人手 5` と `{-1,1}` の上の和・冪と同じ並び） | **重みの値は可換半環（加法・乗法の可換モノイドと二つの分配律。零の吸収律は不要）。`M_col ≥ 2` は具体版と同じ `n + 2` の形** | `open_chain_partition_sum`・`open_chain_endpoint_product_sum` |
| `NecSuf.prod_mul_succ_eq_first_mul_last` / `prod_mul_succ_of_two` / `prod_mul_succ_of_ge_three` / `prod_mul_succ_rearrange`（同） | 中間のサイトで `x(m)x(m) = 1` なら `∏_{m=1}^{M_col-1} x(m)x(m+1) = x(1)x(M_col)`（具体版の `M_col = 2` の 3 段と `M_col ≥ 3` の鎖と同じ並び） | 可換モノイド（`M_col = 2` の鎖は `x·x = 1` を使わない。両端の `x·x = 1` は不要。積の並べ替えは `finset_prod_mul_distrib'`） | `open_chain_endpoint_product_sum` の Step 2 |

## 2. 2 本立ての対応表と「必要十分版で判明した本質」

| 人手証明のラベル | 具体版 | 必要十分版 | 具体版は必要十分版の系か |
| --- | --- | --- | --- |
| `epsilon_anticommutes_with_check_Z_Y` (2) | `Ising2D.epsilon_anticomm_checkZ` / `checkY`（人手の鎖と同じ行の `epsilon_anticomm_phase_sum` で証明） | `NecSuf.anticomm_sum_smul`（具体版と同じ 7 段の calc。効くのは積が各因子について `𝕜` 倍と交換すること、分配律、`𝕜` の作用が符号反転と交換することだけ） | **系としても得られる**（`epsilon_anticomm_checkZ_of_necSuf` / `checkY_of_necSuf`） |
| 同 (3) | `Ising2D.epsilon_anticomm_checkPsiDag` / `checkPsi`（人手の鎖と同じ行の `epsilon_anticomm_two_term` で証明） | `NecSuf.anticomm_add_smul`（具体版と同じ 7 段の calc） | **系としても得られる**（`epsilon_anticomm_checkPsiDag_of_necSuf` / `checkPsi_of_necSuf`） |
| 同 (4) | `CheckFermi.commute_epsilon_nOp` / `commute_epsilon_Qproj`（人手の鎖と同じ行の calc。`Q̌_ε` は `commute_epsilon_Qproj_succ`） | `NecSuf.commute_parity_num`（具体版と同じ 3 行）/ `commute_parity_finProdLeft_defFactor`（具体版と同じ並び）/ `commute_parity_projOn` | **系としても得られる**（`commute_epsilon_nOp_of_necSuf` / `commute_epsilon_Qproj_succ_of_necSuf` / `commute_epsilon_Qproj_of_necSuf`） |
| `epsilon_eigenvalue_on_check_Q` (1) | `CheckFermi.exists_eta` / `eta` / `eta_unique` | `NecSuf.smul_left_cancel_of_ne_zero`（一意性のみ） | **存在の部分は系にならない**（1 次元性が要る。下記参照） |
| 同 (2) の冒頭・Step 1・Step 2 の後半・Step 3 | `CheckFermi.epsilon_mulVec_generator_eq_eta_smul` / `cre_mulVec_generator_ne_zero` / `Qproj_insert_mulVec_cre_mulVec_generator` / `epsilon_mulVec_cre_mulVec_generator` / `eta_insert_smul_cre_mulVec_generator`（人手の鎖と同じ行の calc） | `NecSuf/SignReversalOnGeneratorVector.lean` の 9 つ（具体版と同じ行の calc） | **系としても得られる**（`*_of_necSuf`） |
| 同 (2) | `CheckFermi.eta_insert`（数ベクトルの鎖を人手の順に組む） | 各段の `NecSuf/SignReversalOnGeneratorVector.lean`（行列 `c_μQ_T` の上で同じ結論を出す `NecSuf.projOn_insert_mul_cre` / `cre_mul_projOn_ne_zero` は手順が違うので対応に数えない） | **系**（`eta_insert_of_necSuf` が冒頭・Step 1〜3 の段を特殊化に替えて同じ組み方をする。`q` を取る段・`Q̌_ε q = q`・`M = 1`・約す段は具体版と共通） |
| 同 (3) | `CheckFermi.eta_eq_eta_univ_mul`（`eta_eq_eta_univ_mul_of_sub_card`・`eta_eq_neg_eta_insert`。人手の帰納法と同じ行の calc） | `NecSuf.eq_univ_mul_neg_one_pow`（具体版と同じ行。効くのは (2) と `Monoid`・`HasDistribNeg` だけ） | **系**（`eta_eq_eta_univ_mul_of_necSuf` / `eta_eq_neg_eta_insert_of_necSuf`） |
| 同 (4) の前半 | `CheckFermi.parityFactor_mul_Qproj` / `finProdLeft_mul_Qproj`（人手の鎖と同じ行の calc） | `NecSuf.one_sub_smul_mul_eq_smul'` / `finProdLeft_mul_eq_prod_smul'`（具体版と同じ行） | **系としても得られる**（`*_of_necSuf`） |
| 同 (4) の後半 | `CheckFermi.epsilon_mul_Qproj_eq_smul_parityProd_mul` / `epsilon_eq_parityProd_succ`（人手の 7 行・9 行の鎖と同じ行の calc） | `NecSuf.mul_eq_smul_mul_of_sign_pow'` / `eq_smul_of_mul_eq_smul_mul'`（具体版と同じ行。7 行に効くのは `Monoid`・`HasDistribNeg`・`SemigroupAction` だけ、9 行に効くのは右単位元・左分配則・`IsScalarTower` だけ） | **系としても得られる**（`*_of_necSuf`） |
| `trace_of_epsilon_V_plus_via_check_eigenvalues` Step 2・Step 3 | `checkU_prod_eq_neg_one_pow`・`VPlusData.eta_mul_checkLambda_eq_checkT_mul_checkH` | `NecSuf.map_prod_two_valued_eq_pow'`・`NecSuf.signed_term_eq_map_mul'` | **系としても得られる**（`*_of_necSuf`）。Step 1・Step 4・Step 5 の鎖には必要十分版を置かない（引いた主張と鎖をつなぐだけで、鎖に固有の取り払える構造が無い） |
| `check_number_operator_is_hermitian` (4) | `CheckFermi.Qproj_conjTranspose` | `NecSuf.star_projOn` | **系** |
| `max_eigenvector_in_even_sector` | `Ising2D.max_eigenvector_in_even_sector` ほか | **置かない** | `ClaimEpsilonEigenvalueOnCheckQ.lean`（反転則）と `ClaimTraceEpsilonVPlusViaCheckEigenvalues.lean`（トレースの符号）の組み合わせであり、新しい抽象構造が現れない |
| `c_plus_equals_Lambda_half_integer` | `EvenSectorBridge.c_plus_equals_lamMax` | **置かない** | `sSup` は ℝ の完備性そのものでほどく余地がない（章 011 の `ThermodynamicLimit/RowLimitAndMaxEigenvalue/DefinitionRayleighSup.lean` と同じ理由）。新しく現れる道具は実／複素の橋渡しだけ |
| `c_between_Lambda_half_and_twice_Lambda_half` Step 2 | `Ising2D.c_le_twice_c_plus_physical`（人手の鎖と 1 対 1） | **置かない** | 準備で本文の主張（`real_bilinear_value_at_most_value_at_absolute_vector`・`sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero`・`epsilon_real_fixes_sum_of_vector_and_its_image`・`norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four`・`W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice` ほか）を 1 つずつ引き、上限の性質と `ℝ` の四則演算・大小でつなぐだけで、引いた主張の外に取り払える構造を持たない（`ε_ℝ`・`W_ℝ` のどの性質が効くかは引いた各主張のファイルが書く）。`Ising2D.NecSuf.rayleighSup_le_two_mul_evenSectorRayleighSup`（`NecSuf/EvenSectorUpperBound.lean`）とその特殊化 `Ising2D.onsager_step3_c_le_two_c_plus` は、Step 2 の前の形（下の 4 節の表）の形式化の記録で、今の Step 2 の必要十分版ではない |
| `H1_plus_in_sigma_z_form` | `Ising2D.H1_plus_in_sigma_z_form` | **置かない** | 具体的な複素行列 `Y_m, Z_m, ε, σ^z_m` の等式で、主張に固有なのは各サイトの Pauli 行列の積だけ。一般的な部分は `siteProd_mul`・`siteProd_ite_smul`・`siteProd_ite_ite_smul` に分離済み（`V1_in_Z_Y_epsilon` と同じ判断） |
| `epsilon_D0_G_pairwise_commute`・`epsilon_G_is_involution`・`D0_G_diagonal_action` | `Ising2D.epsilon_mul_openChainD0` ほか | **置かない** | 具体的な `ε, σ^z_m` の反可換性（`epsilon_anticomm_sigmaZ`）・相異なるサイトの `σ^z` の可換性（`siteOp_mul_comm`）・`(σ^z)^2 = I`・対角作用という既存の関係を、環の公理と有限和の分配で組み合わせるだけで、主張に固有の構造が無い（`H1_plus_in_sigma_z_form` と同じ判断） |
| `open_chain_partition_sum`・`open_chain_endpoint_product_sum` | `Ising2D.open_chain_partition_sum` / `open_chain_endpoint_product_sum` / `prod_bondSpin_eq_first_mul_last` | `NecSuf.open_chain_weighted_sum_eq_sum_prod` / `NecSuf.sum_spinVal_const`（二つをまとめた形が `NecSuf.open_chain_weighted_sum`）/ `NecSuf.prod_mul_succ_eq_first_mul_last` | **系**（`EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimOpenChainSpinSumsFromNecSuf.lean` の `*_of_necSuf`。`endpoint_mul_exp_openChainEnergy_eq_prod_of_necSuf` は 2 段目だけを導出に替える） |
| `trace_of_epsilon_V_plus` Step 2 の `exp(K_1εG) = cosh(K_1)I + sinh(K_1)εG` | `Ising2D.exp_epsilon_mul_boundaryG` | **置かない** | 引いている `exponential_series_of_even_odd_power_terms` が中間目標「各項」「部分和」「差」を行列の成分の鎖で示すので、同じ手順のまま抽象度を上げられない（ノルムの評価の必要十分版は `NecSuf/EvenOddSeriesNormEstimate.lean`）。偶数次と奇数次の二つの級数に分ける必要十分版 `NecSuf.exp_series_sum_of_sq_eq_one`（`NecSuf/ExpOfInvolution.lean`）は手順が違うので対応に数えない（`two_by_two_transfer_identity` の必要十分版である。`ch010-formalization.md`）。Step 1 と Step 2 の残りも具体的な `ε, B, V_1^{(+)}, D_0, G` の可換性とトレースの巡回性だけなので置かない |
| `trace_of_epsilon_V_plus` Step 3 | `Ising2D.matExp_smul_openChainD0` ほか | **置かない** | 一般化できるのは行列の列の読み取り（任意の半環で成り立つ自明な事実）と `{±1}` の符号反転の組合せだけで、必要十分版にしても何が本質的かについて情報を与えない |
| `onsager_exact_solution`（Step 1・2・4） | `Ising2D.onsager_exact_solution` | **置かない** | 既存の必要十分版（`NecSuf/LogSqueeze.lean`, `NecSuf/RiemannSum.lean`）を章 012 が既に系として使っており、本章はその具体版を章 011・018 の結果に接続するだけ |

### 必要十分版で判明した本質（本文には持ち込まない）

- **`ε` が `ň_μ`・`Q̌_ε` と可換であること（人手証明 (4)）に効いているのは、
  `ε` が生成・消滅演算子の両方と反交換することと、積の結合則・符号反転が積の因子から外へ出ること・二重の符号反転だけである**
  （`NecSuf.commute_parity_num` は `Semigroup` と `HasDistribNeg` だけを仮定する）。`Q̌_ε` の側ではさらに、単位元・分配則・
  `x − y = x + (−y)`・`𝕜` 倍との交換が効く。
  `Q̌_ε` の因子 `ε_ν ň_ν + (1 − ε_ν)(I − ň_ν)` の係数が `ε_ν`・`1 − ε_ν` であることも、`ň_ν` が冪等であることも効かない
  （`NecSuf.commute_defFactor_of_commute'` は二つの係数を無関係なスカラーに置いて通る）。
  `ε = σ^x_1⋯σ^x_M` であることも、`ψ̌` が `Ž, Y̌` の 1 次結合であることも、
  行列であることも、複素数であることも、テンソル冪であることも効いていない。
  加法の零・結合則・可換性・逆元則は効かない（`NecSuf.commute_parity_num` / `commute_parity_finProdLeft_defFactor`）。

- **符号の反転則（人手証明 (2)）に `im Q̌_ε` の 1 次元性は要らない。**
  人手証明は (1)(2) の両方で 1 次元性を引くが、必要な材料は次の 3 つだけである。
  1. `Q_{T∪{μ}}(c_μ Q_T) = c_μ Q_T` — `n_μ c_μ = c_μ` と「`n_ν`（`ν ≠ μ`）が `c_μ` と可換」から、
     環の計算だけで出る（`NecSuf.projOn_insert_mul_cre`）。
  2. `c_μ Q_T ≠ 0` — `a_μ c_μ = 1 − n_μ` と `n_μ Q_T = 0`（`μ ∉ T`）から出る
     （`NecSuf.cre_mul_projOn_ne_zero`）。**ここが 1 次元性を使わない要点である。**
  3. `ε(c_μ Q_T) = −η_T (c_μ Q_T)` — 反交換関係だけ。

  すなわち**1 次元性が本当に要るのは `η_ε` の「存在」だけ**であり、反転則そのものは
  1 次元性なしで出る。存在の部分は台が行列環であることが本質的なので、
  具体版（`EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimEpsilonEigenvalueOnCheckQ.lean`）にしか置いていない。

- **`tr(εV^{(+)})` の積への分解（人手証明 Step 2）に効いているのは、
  有限集合の冪集合にわたる和の積への変形（`Finset.prod_add`）と
  `sinh x = (e^x − e^{−x})/2` だけである。** `γ` が `arccosh` で書けることも、
  `V^{(+)}` が転送行列であることも、`Λ̌_ε` が固有値であることも、半整数運動量であることも
  効いていない（`NecSuf.sum_powerset_signed_exp` は `g : ι → ℝ` を任意にとる）。これは旧い Step の分け方での記述で、
  いまの具体版（Step 2〜5 の鎖）はこの必要十分版を使っていない。

- **1 次元開鎖の二つのスピン和に効いているのは、変数変換 `Φ(s) = (s(1); s(m)s(m+1))` と `ς(e) = 2e - 1` の全単射と、
  重みの値の側の可換半環の構造（二項の和の有限積の展開と `c + c = 2c`）だけである。** 重みの値については実数・指数関数・`cosh`・`sinh` は効いておらず、
  二つの和は重み `g(t) = exp(Kt)` と `g(t) = t·exp(Kt)` の特殊化にすぎない（`NecSuf.open_chain_weighted_sum`）。
  スピンの側（`𝔐`）は人手の定義のまま固定した。そこで効くのは、`{-1,1}` が乗法で閉じることと `s·s = 1`（`Φ` の逆写像）、
  `ς` が `{0,1}` と `{-1,1}` の全単射であること、
  `{-1,1}` の元の個数 `2` だけで、`ℝ` の加法・順序は効いていない。
  端点因子の書き替えでは、`x(m)x(m) = 1` は中間のサイトでしか効かず、`M_col = 2` の鎖では使わない。
  人手の端点因子の書き替えの一段「`ℝ` の乗法の可換性と結合性」は、Lean では `∏_m s(m)` と `∏_m s(m+1)` への分解・
  両端の括り出し・中間のサイトの書き方の揃え・結合性の段に割れる（`prod_bondSpin_rearrange`・`NecSuf.prod_mul_succ_rearrange`）。

- **`γ(θ̃_μ) > 0`（半整数運動量に固有の性質）が効くのは 1 箇所だけである。**
  `∏_μ 2 sinh(γ_μ/2) ≠ 0`（したがって `tr(εV^{(+)})` の符号が `η_{(1,…,1)}` で決まる）と、
  `Λ̌_ε ≤ Λ̌_{(1,…,1)}` の 2 つに使う。整数運動量なら `γ = 0` のモードが出て両方が壊れる。

## 3. 形式化できなかった主張とその理由

| 人手証明（ブロック） | 状況 | 理由 |
| --- | --- | --- |
| `closing_006_theorem_trace_of_epsilon_V_plus`（`tr(εV^{(+)}) = (2e^{−K_2}\cosh K_1)^M + (2e^{K_2}\sinh K_1)^M > 0`） | **形式化した**（`ClaimTraceEpsilonVPlusClosedForm.lean` の `trace_of_epsilon_V_plus`） | 依存先の `D_0,G` の定義・`H1_plus_in_sigma_z_form`・可換性と対角作用・二つのスピン和は形式化した（「形式化した定理の一覧」の `DefinitionOpenChainAndBoundaryOperators.lean`・`ClaimH1PlusInSigmaZForm.lean`・`ClaimEpsilonD0GCommuteAndDiagonalAction.lean`・`ClaimOpenChainSpinSums.lean` の表）。この定理本体のうち Step 1・Step 2 は `ClaimTraceEpsilonVPlusReduction.lean`、Step 3 は `ClaimTraceEpsilonVPlusMatrixEntries.lean`、Step 4・Step 5 は `ClaimTraceEpsilonVPlusClosedForm.lean` で形式化した。`Ising2D.VPlusData.eta_univ_eq_one` 以降は一般の `VPlusData` について述べるので `0 < (tr(εV^{(+)})).re` を仮定に置き、最終定理では `trace_epsilon_vPlusDataOf_pos` で埋める。**人手証明で証明済みであり循環参照はない**（この定理は `epsilon_eigenvalue_on_check_Q` にも `max_eigenvector_in_even_sector` にも依存しない） |
| `closing_000_remark_overview` | 形式化対象外 | `remark`（本章の位置づけの説明）であり、数学的主張は他ブロックに含まれる |

詳細と一次情報は `docs/tasks/2026-07_lean-ch009-013/015_ch018-formalization-findings.md` に記録した。

## 4. Onsager の最終定理の挟み撃ち `c_between_Lambda_half_and_twice_Lambda_half`（人手証明と 1 対 1）

人手証明 `c_between_Lambda_half_and_twice_Lambda_half`（もとは `onsager_exact_solution` の Step 2・Step 3。2026-10-31 に独立した主張へ分けた）は
`Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M` という**粗い挟み撃ち**を採る（原文 `conversion.notes` に
よれば `c_-(M)` の値に依存しないため）。Lean も同じ挟み撃ちで述べる
（通しの定理は `rayleighSup_sandwich_LambdaM_physical` で、Step 1 は `EvenSectorBridge.LambdaM_le_rayleighSup`、Step 2 は `c_le_twice_c_plus_physical`。
`onsager_exact_solution` の Step 3 の `onsager_limit_in_M` で `(log 2)/M → 0` を使う）。

以前の Lean は、章 019 の `Ising2D.c_minus_le_c_plus`（`c_-(M) ≤ c_+(M)`）と `Ising2D.c_equals_c_plus`
（`c(M) = c_+(M)`）で挟み撃ちなしに `c(M) = Λ^{(1/2)}_M` を出していた（旧 `rayleighSup_eq_LambdaM`）。
2026-09-26 に人手の本文が `(−)` セクターを参照用ノート
`structured-latex/notes/minus_sector_not_adopted.ts` へ退避し、章 019 も本文から外れたので、Lean も
本文と同じ経路に揃えた。章 019 の Lean は形式化の記録として残してある（`lean/docs/ch019-formalization.md`）。

`c_between_Lambda_half_and_twice_Lambda_half` の Step 2 の前の形（`W_ℝ`・`ε_ℝ` で書き直す前、Cauchy–Schwarz で `‖v‖² ≤ 4` を出す形）と、その形式化の記録 `NecSuf/EvenSectorUpperBound.lean` の対応:

| 人手の段 | Lean |
| --- | --- |
| `u_k := |x_k|`, `uᵀWu ≥ |xᵀWx| ≥ xᵀWx` | `NecSuf.quad_le_quad_absVec`（`NecSuf/PermMatrix.lean`） |
| `ε` は置換行列（`trace_of_epsilon_V_plus` Step 3 (b)）、`‖εu‖ = ‖u‖ = ‖x‖ = 1` | `epsilonR M = permMat flipConf`、`NecSuf.vecNormSq_permMat_mulVec`、`NecSuf.vecNormSq_absVec` |
| `εv = v`（`ε² = I`）、`v ≠ 0` | `permMat_mul_self`、`v ≥ u` から `‖v‖² ≥ ‖u‖² = 1` |
| `‖v‖² = 2 + 2uᵀεu ≤ 4`（Cauchy–Schwarz） | `Ising2D.psd_cauchy_schwarz` を `P = I` で |
| `vᵀWv = 2uᵀWu + 2uᵀWεu ≥ 2uᵀWu`（`εᵀ = ε`, `εW = Wε`, `ε² = I`） | `mulVec_dotProduct_selfadjoint`（`εᵀ = ε`）、仮定 `hcomm`、`NecSuf.bilin_nonneg_of_nonneg` |
| `c_+ ≥ v̂ᵀWv̂ = vᵀWv/‖v‖² ≥ ⋯ ≥ xᵀWx/2` | `le_evenSectorRayleighSup` と同じ順の `calc` |

この表は記録 `NecSuf/EvenSectorUpperBound.lean` の手順で、今の Step 2 の必要十分版ではない（手順が今の具体版と違い、具体版をその特殊化として導いていない）。記録は `v ≠ 0` を「`v ≥ u ≥ 0` と `u ≠ 0`」から直接でなく
`‖v‖² ≥ ‖u‖² = 1 > 0` の形で示し、`v̂ := v/‖v‖` の代わりに `(1/√‖v‖²)·v` を使う。

人手の鎖と 1 対 1 の具体版は `Ising2D.c_le_twice_c_plus_physical`（`TheoremOnsagerExactSolution.lean`）で、人手の準備の各行を
`W_real_has_positive_entries`・`real_bilinear_value_at_most_value_at_absolute_vector`・`norm_of_vector_of_absolute_values_equals_norm`・
`sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero`・`norm_of_normalized_real_vector_is_one`・
`epsilon_real_fixes_sum_of_vector_and_its_image`・`real_matrix_fixed_vector_stays_fixed_after_normalization`・
`norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four`・
`W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice`・
`real_bilinear_value_with_nonnegative_entries_is_nonnegative` の Lean の同名の定理で引き、7 行の鎖を `calc` の 7 段
（`real_bilinear_value_of_normalized_vector` を引く）、続く 2 行と `c(M) = sup𝓡 ≤ 2Λ` の 2 行を同じ順に書く。
`u ≠ 0` の行（`matrix_norm_triangle_inequality` (1) の `K^n`）は、その具体版が Lean に無いので `vecNormSq_eq_zero_iff` と `Real.sqrt` の零で示す。

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
| `ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimCheckFermiFromDiagonalizationAndExponentialForm.lean` | `Ising2D.checkFermiOf`（`CheckFermi` のインスタンス）と、その `hstar` を埋める橋渡し補題 `Ising2D.checkPsiDag_conjTranspose` |
| `EigenvalueProblem/EigenvaluesOfVPlus/ClaimVPlusDataFromEigenvaluesOfVPlus.lean` | `Ising2D.vPlusDataOf`（`VPlusData` のインスタンス）と、章 017 の `CheckFermiSetup`（添字型 `CheckIdx M`）と章 018 の `CheckFermi`（添字型 `Fin M`）を噛み合わせる `Ising2D.finCheckIdxEquiv` / `checkFermiSetupOf_Vprime` |
| `ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimVPlusRealEntries.lean` | 「`V^{(+)}` の成分は実である」（`Ising2D.VPlus_hasRealEntries`。人手 `c_plus_equals_Lambda_half_integer` は 2026-11-05 の書き直しでこの主張を使わなくなり、Lean の書き直し前の経路の入力として残る。各段は `iH_is_real_symmetric` の結論 `S1plus_isRealSymmetric`・`S2_isRealSymmetric`、`exp_of_real_symmetric_is_real_symmetric`、`real_scalar_multiple_of_real_entry_matrix_has_real_entries`、`product_of_real_entry_matrices_has_real_entries` の具体版を引き、成分の実性は `MatrixHasRealEntries`）と、`vPlusDataOf` の `V^{(+)}` の実行列表示 `Ising2D.VPlusR`・`Ising2D.vPlusDataOf_V_eq_map`（`EvenSectorBridge` の欄 `Vr`・`hVr`） |
| `ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimWEqVPlusOnEvenSector.lean` | 人手 `c_plus_equals_Lambda_half_integer` Step 0「`𝓕^{(+)}` の上で `W` と `V^{(+)}` が一致する」。`P^{(+)}x = x`（`Ising2D.epsProjPlus_mulVec_of_even`）、複素ベクトル上の `Wx = V^{(+)}x`（`Ising2D.W_mulVec_eq_VPlus_mulVec_of_even`）、具体的な `W` と `VPlusR` についての実ベクトル版 `Ising2D.hWV_physical`（`EvenSectorBridge` の欄 `hWV`）。必要十分版は `NecSuf/EvenSectorAgreement.lean` の `Ising2D.NecSuf.invProj_smul_of_fixed`（加群・`2` の可逆性だけ）と `Ising2D.NecSuf.smul_eq_of_mul_proj_eq`（半群の作用だけ）で、具体版はその特殊化（`*_of_necSuf`） |
| `ThermodynamicLimit/ColumnLimitAndClosedForm/PhysicalEvenSectorBridge.lean` | 具体的な `W = physicalSymTransferR M K_1 K_2` と `vPlusDataOf` の `V^{(+)}` についての `Ising2D.EvenSectorBridge`（`Ising2D.physicalEvenSectorBridge`）。欄 `hWsymm`・`hWpsd` は章 011 `W_is_real_symmetric_positive_definite` の具体版 `physicalSymTransferR_isSymm`・`physicalSymTransferR_posDef`（`x = 0` を足した `Ising2D.physicalSymTransferR_nonneg`）、`Vr`・`hVr` は人手の書き直し前の Step 2（いまの人手は使わない。`ClaimVPlusRealEntries.lean` の冒頭）、`hWV` は Step 0 |
| `ThermodynamicLimit/ColumnLimitAndClosedForm/TheoremOnsagerUnconditional.lean` | 仮定を取らない挟み撃ち `Ising2D.rayleighSup_sandwich_LambdaM_physical`、Step 1 `Ising2D.onsager_limit_in_N_row_physical`（`c(M) > 0` は人手 `limit_of_log_Z_in_N_row` と同じく `def_rayleigh_sup` から `rayleighSup_pos` で出す）と、`Ising2D.onsager_exact_solution_unconditional`（入力は結合定数の組だけ） |
| `ThermodynamicLimit/ColumnLimitAndClosedForm/TheoremOnsagerExactSolutionEndToEnd.lean` | 通しの定理 `Ising2D.onsager_exact_solution_end_to_end`（`scripts/check-end-to-end.sh` が固定する型。入力は `K_1, K_2` とその正値性だけ）と、被積分関数を `gammaFn` を経ずに書いた `Ising2D.gammaFn_eq_arcosh_Kstar` |

### 6.2 消えた仮定（何で埋めたか）

| もとの仮定 | 出典の章 | 埋めた定理 |
| --- | --- | --- |
| `CheckFermi.hcre` / `hann`（`ψ̌^†, ψ̌` が `Ž, Y̌` の 1 次結合） | 016 | `Ising2D.checkPsiDag` / `checkPsi` の定義そのもの（`EigenvalueProblem/DiagonalizationAndExponentialForm/DefinitionCheckFermi.lean`） |
| `CheckFermi.acomm_cre_cre` / `acomm_ann_ann` / `acomm_cre_ann`（CAR） | 016 | `Ising2D.checkPsi_car'`（`EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimCheckFermiResultsUnconditional.lean`。仮定は `M ≠ 0` だけ） |
| `CheckFermi.hstar`（`(ψ̌_μ^†)^* = ψ̌_{M+1-μ}`） | 016 | **本セッションで新たに証明**した `Ising2D.checkPsiDag_conjTranspose`（章 018 の `checkZ_conjTranspose` / `checkY_conjTranspose` と章 008 の `gamma2_neg_eq_neg_conj` だけを使う） |
| `VPlusData.hV`（`V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε`） | 016・017 | `Ising2D.VPlus_eq_smul_checkVprime_const`（016 の `VPlus_eq_smul_checkVprime_of_dual` ＋ 017 の `constant_c_value_even_sector`）と `Ising2D.checkVprime_mul_Qproj` |
| `VPlusData.C`, `hC`（`C = (2 sinh 2K_2)^{M/2} > 0`） | 017 | 同上（`constant_c_value_even_sector` が `c` の値を確定させる） |
| `VPlusData.gam`, `hgam`（`γ(θ̃_μ) > 0`） | 015・017 | `Ising2D.gammaFn_thetaTilde_pos`（`EigenvalueProblem/DiagonalizationAndExponentialForm/TheoremMaxEigenvalueSimple.lean`。**無条件**） |
| `rayleighSup_sandwich_LambdaM` の `hC` / `hgam`（章 012 の記法との一致） | 012・017 | `rfl` と `Ising2D.sum_checkGam`（`tagPoint_half_eq_thetaTilde` の系） |
| `hWpos`（具体的な `W` の成分が正） | 011 | `Ising2D.physicalSymTransferR_pos`（人手 `W_has_positive_entries`、`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimPhysicalWHasPositiveEntries.lean`）。いまの通しの経路では、Step 2 の `c_le_twice_c_plus_physical` が同じ内容を `W_real_has_positive_entries` で引く |
| `hWcomm`（`ε` と具体的な `W` の可換性） | 011 | `Ising2D.epsilon_commutes_with_W`（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonCommutesWithW.lean`）。いまの通しの経路では使わない（Step 2 の `c_le_twice_c_plus_physical` が引く `W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice` が、`epsilon_real_commutes_with_W_real` を通して可換性を使う） |
| `htr`（`tr(εV^{(+)}) > 0`）と `hM`（`M ≠ 0`） | 018 | `Ising2D.trace_epsilon_vPlusDataOf_pos`（人手 `trace_of_epsilon_V_plus`）。`M ≠ 0` は `2 ≤ M` から出す |

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

### 6.4 残った仮定（無い）

残った仮定は無い。もとの場 `htr`（`tr(εV^{(+)}) > 0`）は `trace_epsilon_vPlusDataOf_pos` で埋め、
その型のために置いていた `hM`（`M ≠ 0`）は `2 ≤ M` から出す。`hWpos`（具体的な `W` の成分が正）は
`Ising2D.physicalSymTransferR_pos`（人手 `W_has_positive_entries`、`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimPhysicalWHasPositiveEntries.lean`）、
`hWcomm`（`ε` と具体的な `W` の可換性）は `Ising2D.epsilon_commutes_with_W`（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonCommutesWithW.lean`）で埋め、
欄を束ねていた構造 `EvenSectorClosureInput` を消した。

`onsager_exact_solution_unconditional` の `Z` は具体的な `partitionFunction N_row M K_1 K_2`、`c(M)` は
`rayleighSup (physicalSymTransferR M K_1 K_2)` で、挟み撃ち `c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}`（`N_row ≥ 1`）は
章 011 の `partition_function_sandwich_physical`（`ThermodynamicLimit/RowLimitAndMaxEigenvalue/PhysicalPartitionFunctionSandwich.lean`）が与える。
`W` と `V^{(+)}` の橋渡し（もとの場 `bridge` と、`bridge.W` が具体的な `W` であるという仮定 `hW`）は、
`Ising2D.physicalEvenSectorBridge`（`PhysicalEvenSectorBridge.lean`）で具体的な `W` について構成し、仮定から外した。

双対関係 `c_2 s_2^* = c_2^*`（もとの場 `hdual`）は、`IsingParam.K2star` を `Kstar K2`
（人手 `def_second_dual_coupling_constant`）で定義し、人手 `duality_c2_star_eq_s2_star_c2` を
`EigenvalueProblem/ReductionToATheta/ClaimDualityC2StarEqS2StarC2.lean` で形式化したことで定理 `IsingParam.c2_mul_s2star_eq_c2star`
になり、最終定理の仮定から外した。

### 6.5 検証

```
$ cd exact-solution-of-2d-ising-model/lean
$ export PATH="$HOME/.elan/bin:$PATH" && lake build   # Build completed successfully
$ ./scripts/check-no-sorry.sh                          # exit 0
$ ./scripts/check-end-to-end.sh                        # OK（sorryAx に依存しない）
```

`scripts/check-no-sorry.sh` の `targets` 配列の末尾に、本接続で追加した 28 個の
定義・定理（`Ising2D.checkFermiOf` … `Ising2D.onsager_exact_solution_unconditional`）を追加した。

## 7. （旧記録）本章のあとに入った章 016・017 の形式化との関係

本章のコミット後、並行セッションが章 016（`Ising2D/Part016/`）と章 017（`Ising2D/Part017/`）を
形式化して main に入れた。**本章の `Ising2D.CheckFermi` / `Ising2D.VPlusData` を
それらの定理から埋める作業は未着手である。** 本タスクの担当範囲（章 018）外なので、
章 016・017 のファイルには手を触れていない。接続すれば `CheckFermi` の仮定（`ψ̌` の CAR）と
`VPlusData` の仮定（`V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε` ほか）は定理に置き換わる。

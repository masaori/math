# 章 010「転送行列の橋渡し」の形式化

対象: `structured-latex/content/010_transfer_matrix_bridge.ts`（13 ブロック）
および、その証明が引用している 001 章
（`structured-latex/content/001_partition_function_2d_ising.ts`）の分配関数とトレース公式。

この章は **001 章（成分で定義された転送行列・分配関数）と 004 章以降（Pauli 行列表示の
`V_1, V_2`）を同一視して、分配関数から固有値までの経路をつなぐ**役割を持つ。

記号の読み替え（010 章冒頭の表）:

| 001 章 | 004 章以降・Lean | 意味 |
| --- | --- | --- |
| `N` | `M` | 鎖の長さ |
| `M` | `N_row` | 転送の回数（行数） |
| `J'` | `K_1` | 行内（同一の鎖の隣接サイト）の結合定数 |
| `J`  | `K_2` | 行間（隣り合う 2 本の鎖の同じサイト）の結合定数 |

---

## 1. 形式化した定理の一覧

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Ising2D.SpinVal` / `Ising2D.SpinConf` | `{-1,1} ⊂ ℝ` と `𝔐 = Map({1,…,M},{-1,1})` | `def_config_basis_iso` |
| `Ising2D.sgn` / `Ising2D.sgnC` | 多重添字 `Fin 2` からスピン値への読み替え（`ι` の逆） | 同上 |
| `Ising2D.configBasisIso` | **全単射 `ι : 𝔐 ≃ 𝓘 = Conf M`**（`+1 ↦ 0`, `-1 ↦ 1`） | 同上 |
| `Ising2D.sgn_configBasisIso` | `sgn(ι(μ)(m)) = μ(m)` | 同上 |
| `Ising2D.basisVec` | 標準基底 `f_I` | 同上 |
| `Ising2D.siteProd_diagonal` | 因子が全部対角ならクロネッカー積も対角 | `sigma_z_diagonal_action` |
| `Ising2D.sigmaZ_eq_diagonal` | `σ^z_m = diagonal (I ↦ sgn(I m))` | 同上 |
| `Ising2D.sigmaZ_mulVec_basisVec` | **`σ^z_m f_I = sgn(I m) f_I`** | 同上 |
| `Ising2D.sigmaZ_mulVec_basisVec_spin` | 同上を `μ ∈ 𝔐` で書いた形（`σ^z_m f_{ι(μ)} = μ(m) f_{ι(μ)}`） | 同上 |
| `Ising2D.sigmaZ_mul_sigmaZ_eq_diagonal` | `σ^z_m σ^z_{m'}` も対角 | 同上 |
| `Ising2D.exp_pi_apply` | 有限直積の `exp` は成分ごと | `exp_of_diagonal_matrix` |
| `Ising2D.matrixExp_diagonal` | **`exp(diagonal d) = diagonal (exp ∘ d)`** | 同上 |
| `Ising2D.matrixExp_diagonal_apply` | 原文の成分表示 `exp(D)_{kl}` | 同上 |
| `Ising2D.rowEnergy` / `Ising2D.interEnergy` | `V_1, V_2` の指数の肩 | `def_transfer_matrix`（001 章） |
| `Ising2D.V1comp` / `Ising2D.V2comp` | **成分で定義された `V_1, V_2`**（001 章） | 同上 |
| `Ising2D.V1pauli` | **`V_1 = exp(K_1 ∑_m σ^z_m σ^z_{m+1})`**（004 章） | `def_transfer_matrix_symbols` |
| `Ising2D.V1pauli_eq_diagonal` | パウリ表示の `V_1` も対角 | `V1_component_equals_pauli` Step 1, 2 |
| `Ising2D.V1pauli_eq_V1comp` | **2 つの `V_1` は同一の行列** | `V1_component_equals_pauli` |
| `Ising2D.V1_component_equals_pauli` | 同上を原文どおり成分（`μ, μ'`）で述べた形 | 同上 |
| `Ising2D.hadU` | `σ^x` を対角化する単元 `!![1,1;1,-1]` | `two_by_two_transfer_identity` Step 1 |
| `Ising2D.exp_smul_pauliX` | **`exp(t σ^x) = !![cosh t, sinh t; sinh t, cosh t]`** | 同上 |
| `Ising2D.exp_smul_pauliX_eq_cosh_add_sinh` | 原文の形 `cosh t·I + sinh t·σ^x` | 同上 |
| `Ising2D.Kstar` | 双対変数 `K_2^* = -(1/2)log(tanh K_2)` | 同上 Step 2 |
| `Ising2D.exp_neg_Kstar` / `Ising2D.exp_Kstar` | `e^{∓K_2^*} = (tanh K_2)^{±1/2}` | 同上 Step 2 |
| `Ising2D.sqrt_two_s2_eq` | `(2s_2)^{1/2} = 2(sinh K_2 cosh K_2)^{1/2}` | 同上 Step 3 |
| `Ising2D.sqrt_two_s2_mul_cosh_Kstar` / `..._sinh_Kstar` | `(2s_2)^{1/2}cosh K_2^* = e^{K_2}` ほか | 同上 Step 4 |
| `Ising2D.twoByTwo` | `A_{ij} = exp(K_2 ς_i ς_j)` | 同上 |
| `Ising2D.two_by_two_transfer_identity` | **`A = (2s_2)^{1/2} exp(K_2^* σ^x)`** | `two_by_two_transfer_identity` |
| `Ising2D.hadUnits` | 全サイト同時の対角化行列 | `V2_component_equals_pauli` Step 3 |
| `Ising2D.exp_smul_sum_sigmaX` | **`exp(t ∑_m σ^x_m) = ⊠_m exp(t σ^x)`** | 同上 Step 3, 4 |
| `Ising2D.V2pauli` | `V_2 = (2s_2)^{M/2} exp(K_2^* ∑_m σ^x_m)` | `def_transfer_matrix_symbols` |
| `Ising2D.V2_eq_V2pauli` | 既存の `Ising2D.V2`（`H_2` 表式）と一致 | 同上 |
| `Ising2D.V2comp_eq_siteProd_twoByTwo` | 成分定義の `V_2` は `A` のクロネッカー冪 | `V2_component_equals_pauli` Step 1 |
| `Ising2D.siteProd_smul_const` | スカラーは `M` 因子から前へ出せる | 同上 Step 2 |
| `Ising2D.V2pauli_eq_V2comp` | **2 つの `V_2` は同一の行列** | `V2_component_equals_pauli` |
| `Ising2D.V2_component_equals_pauli` | 同上を原文どおり成分で述べた形 | 同上 |
| `Ising2D.partitionFunction` | **分配関数 `Z(J,J')`（001 章。Lean 新規）** | `def_partition_function_2d_ising` |
| `Ising2D.partitionFunctionC` | 上を多重添字 `Conf M` で書いた版 | 同上（`ι` を通した形） |
| `Ising2D.partitionFunction_eq_conf` | 全単射 `Φ`・`ι` による添字の付け替え | `partition_function_via_transfer_matrix` Step 5 |
| `Ising2D.V1comp_mul_V2comp_apply` | `(V_1V_2)_{μ,μ'}` の成分 | 同 Step 1 |
| `Ising2D.partitionFunctionC_eq_trace` | **`Z = tr((V_1V_2)^{N_row})`（成分定義。001 章の主張）** | `partition_function_via_transfer_matrix` |
| `Ising2D.partition_function_in_pauli_form` | **`Z = tr((V_1V_2)^{N_row})`（パウリ表示。010 章の主張）** | `partition_function_in_pauli_form` |
| `Ising2D.partition_function_in_pauli_form_V2` | 同上を既存の `Ising2D.V2` で述べた版 | 同上 |
| `Ising2D.instInvertibleTwoTensorPow` | `Mat(2^M,ℂ)` で `2` が可逆 | `def_epsilon_projectors`（`/2` の意味づけ） |
| `Ising2D.epsProj` | **`P^{(±)} = (I ± ε)/2`** | `def_epsilon_projectors` |
| `Ising2D.epsilon_sq` | `ε² = I` | `epsilon_projector_properties` (1) |
| `Ising2D.epsProj_sq` / `epsProj_mul_epsProj_neg` | `(P^{(±)})² = P^{(±)}`, `P^{(+)}P^{(-)} = 0` | 同 (2) |
| `Ising2D.epsProj_add_epsProj_neg` | `P^{(+)} + P^{(-)} = I` | 同 (3) |
| `Ising2D.epsilon_mul_epsProj` | `ε P^{(±)} = ±P^{(±)}` | 同 (4) の計算 |
| `Ising2D.epsProj_mulVec_mem` / `epsProj_mulVec_eq_self` | `im P^{(±)} = 𝓕^{(±)}` の 2 つの包含 | 同 (4) |
| `Ising2D.epsilon_eq_siteProd` | `ε = σ^x ⊠ ⋯ ⊠ σ^x` | `epsilon_commutes_with_transfer_matrices` Step 1 |
| `Ising2D.epsilon_commute_sigmaX` | `ε σ^x_k = σ^x_k ε` | 同 Step 1 |
| `Ising2D.epsilon_anticomm_sigmaZ` / `..._sigmaY` | `ε σ^{z,y}_k = -σ^{z,y}_k ε` | 同 Step 1 |
| `Ising2D.epsilon_anticomm_Z` / `..._Y` | `ε Z_m = -Z_m ε`, `ε Y_m = -Y_m ε` | 同 Step 4 |
| `Ising2D.epsilon_commute_V1pauli` | **`ε V_1 = V_1 ε`** | 同 Step 3 |
| `Ising2D.epsilon_commute_V2pauli` / `epsilon_commute_V2` | **`ε V_2 = V_2 ε`** | 同 Step 2 |
| `Ising2D.epsilon_commute_H1` | `ε H_1^{(±)} = H_1^{(±)} ε` | 同 Step 4 |
| `Ising2D.epsilon_commute_V1` / `epsilon_commute_V1half` | **`ε V_1^{(±)} = V_1^{(±)}ε`, `ε (V_1^{(±)})^{1/2} = ⋯`** | 同 Step 4 |
| `Ising2D.commute_epsProj_of_commute_epsilon` ほか 5 本 | `P^{(±)}` との可換性 | 同 Step 5 |
| `Ising2D.RestrictsOnSector` | 004 章 `V1_restriction_to_eigenspaces` を仮定として述べた述語 | `sector_replacement_of_V1` の前提 |
| `Ising2D.sector_replacement_of_V1` | **`V_1 P^{(±)} = V_1^{(±)} P^{(±)}`** | `sector_replacement_of_V1` |
| `Ising2D.sector_replacement_pow` | **`(V_1V_2)^n P^{(±)} = (V_1^{(±)}V_2)^n P^{(±)}`** | `sector_replacement_pow` |
| `Ising2D.Vsym` | `V^{(±)} = (V_1^{(±)})^{1/2} V_2 (V_1^{(±)})^{1/2}` | `V_eq_Vprime` |
| `Ising2D.trace_eq_sector_sum` | `tr X = tr(P^{(+)}X) + tr(P^{(-)}X)` | `partition_function_sector_decomposition` Step 1 |
| `Ising2D.trace_epsProj_sym_pow` | 対称形の解消（Step 3） | 同 Step 3 |
| `Ising2D.trace_epsProj_sym_pow_eq_plain` | Step 2 と Step 3 の合成 | 同 Step 2, 3 |
| `Ising2D.partition_function_sector_decomposition` | **`Z = tr(P^{(+)}(V^{(+)})^{N_row}) + tr(P^{(-)}(V^{(-)})^{N_row})`** | `partition_function_sector_decomposition` |

必要十分版（`Ising2D/NecSuf/`）:

| Lean の名前 | 内容 |
| --- | --- |
| `Ising2D.NecSuf.prod_entry_eq_zero_of_ne` / `prod_entry_eq_ite` | 因子が全部「対角」なら積も対角 |
| `Ising2D.NecSuf.map_exp_of_continuous` | 連続な環準同型は `exp` と可換 |
| `Ising2D.NecSuf.invProj` / `invProj_sq` / `invProj_mul_invProj_neg` / `invProj_add_invProj_neg` / `commute_invProj` | 対合から作る射影子とその性質 |
| `Ising2D.NecSuf.pow_mul_proj` | 冪等元上での因子の置き換え |
| `Ising2D.NecSuf.mul_pow_conj_left` | `B (BVB)^n = (BBV)^n B` |
| `Ising2D.NecSuf.cycSucc` / `openW` / `openW_snoc` | 巡回後者と「開いた道」の重み |
| `Ising2D.NecSuf.pow_succ_apply_eq_sum` | `(A^{n+1})_{ij}` は道の重みの総和 |
| `Ising2D.NecSuf.trace_pow_succ` | `tr(A^{n+1})` は閉じた道の重みの総和 |

---

## 2. 2 本立ての対応表と「必要十分版で判明した本質」

| 人手証明のラベル | 具体版 | 必要十分版 | 必要十分版で分かったこと |
| --- | --- | --- | --- |
| `sigma_z_diagonal_action` | `Ising2D.sigmaZ_eq_diagonal` / `sigmaZ_mulVec_basisVec`（`Mat(2^M,ℂ)`。必要十分版からの導出は `siteProd_diagonal` の中） | `Ising2D.NecSuf.prod_entry_eq_zero_of_ne`（`NecSuf/SiteDiagonal.lean`） | 効いているのは「クロネッカー積の成分は因子の成分の積」と「各因子が対角」の 2 点だけ。**行列であることも、複素数であることも、サイトの次元が 2 であることも、加法すら効いていない**（零元をもつ可換モノイドで足りる）。零因子の非存在も不要 |
| `exp_of_diagonal_matrix` | `Ising2D.matrixExp_diagonal` / `matrixExp_diagonal_apply`（必要十分版からの導出は `exp_pi_apply`） | `Ising2D.NecSuf.map_exp_of_continuous`（`NecSuf/ExpDiagonal.lean`） | 原文の「冪 → 部分和 → 成分ごとの収束」の 3 段は、**「連続な環準同型は `exp` と可換」1 本**に集約される。対角行列であることも行列であることも本質ではない |
| `epsilon_projector_properties` (1)(2)(3) | `Ising2D.epsProj_sq` / `epsProj_mul_epsProj_neg` / `epsProj_add_epsProj_neg`（**必要十分版の系として導出済み**） | `Ising2D.NecSuf.invProj_sq` ほか（`NecSuf/Projector.lean`） | 効いているのは **`ε² = I` と `2` が可逆であること**だけ。`ε` が Jordan–Wigner 文字列の積であることも、行列であることも、環が可換であることも効いていない |
| `epsilon_commutes_with_transfer_matrices` Step 5 | `Ising2D.commute_epsProj_of_commute_epsilon`（**必要十分版の系**） | `Ising2D.NecSuf.commute_invProj` | 「`ε` と可換なら `P^{(±)}` とも可換」に効いているのはスカラー作用と加法の両立則だけ |
| `sector_replacement_pow` | `Ising2D.sector_replacement_pow`（**必要十分版の系**） | `Ising2D.NecSuf.pow_mul_proj` | 効いているのは「`P` が冪等」「`P` が `V_1, V_2, V_1^{(±)}` と可換」「`V_1P = V_1^{(±)}P`」の 3 点だけ。**`P` が `(I±ε)/2` の形であることすら使わない**。すなわち「偶奇セクター」という言葉のうちこの段で使われている情報は冪等元と可換性だけである |
| `partition_function_sector_decomposition` Step 3 | `Ising2D.trace_epsProj_sym_pow` | `Ising2D.NecSuf.mul_pow_conj_left` | 対称形 `(BV_2B)^n` の解消は**結合法則だけ**（原文の「結合法則で括り直すだけ」が文字どおり正しい）。トレース側で追加に要るのは巡回性と `P` と `B` の可換性のみで、`B` が `exp` であることは効いていない |
| `partition_function_via_transfer_matrix`（001 章 Step 2, 3） | `Ising2D.partitionFunctionC_eq_trace`（**必要十分版の系**） | `Ising2D.NecSuf.trace_pow_succ`（`NecSuf/TracePathSum.lean`） | 「トレースは閉じた道の重みの総和」に効いているのは**有限添字集合と可換半環**だけ。Ising 模型であることも、成分が `exp` の形であることも、複素数であることも、可逆性・ノルム・位相も効いていない |

必要十分版を置かなかった主張とその理由:

* `V1_component_equals_pauli` / `V2_component_equals_pauli`
  — 内容は上の必要十分版（対角性・`exp` の準同型性）の**合成**であり、
    このファイル固有の内容は「2 つの定義の突き合わせ」という具体的な主張だから。
* `two_by_two_transfer_identity`
  — `Real.tanh`, `Real.sinh` の具体的な恒等式そのもので、取り払える構造が無い。
* `def_config_basis_iso`
  — Lean では添字型 `Conf M = Fin M → Fin 2` が多重添字そのものなので、
    主張は「成分ごとの全単射の直積」という 1 行であり抽象化の余地が無い。

---

## 3. 形式化できなかった主張・条件つきになった主張

| 主張 | 状況 | 記録 |
| --- | --- | --- |
| `sector_replacement_of_V1` と、それに依存する `partition_function_sector_decomposition` | **仮定 `RestrictsOnSector` つきで形式化**。仮定の中身は 004 章の `V1_restriction_to_eigenspaces`（Lean 未形式化） | `docs/tasks/2026-07_lean-ch009-013/001_ch010_sector_replacement_depends_on_unformalized_ch004.md` |
| `epsilon_projector_properties` (4) の「`im P^{(±)} = 𝓕^{(±)}`」 | 部分空間の等式としてではなく、**2 つの包含をベクトルの言葉で**述べた（`epsProj_mulVec_mem` / `epsProj_mulVec_eq_self`）。`𝓕^{(±)}` を `Submodule` として導入すると 004 章の `def_eigenspaces_of_epsilon` の形式化が要り、本タスクの範囲外になるため | 本ファイル |
| `bridge_000_remark_overview`（記号の対応の説明） | 主張ではなく記号の宣言なので、定理としては形式化していない。内容（`K_1 = J'`, `K_2 = J`）は `partitionFunctionC_eq_trace` が実際に成り立つことで裏づけた | `docs/tasks/2026-07_lean-ch009-013/002_ch010_Nrow_positive_is_necessary.md` |

### mathlib について調べた結果（一次情報）

* `Matrix.exp_diagonal`（`Mathlib/Analysis/Normed/Algebra/MatrixExponential.lean:84`）が存在するので、
  対角行列の指数関数は自前の級数計算を要しない。
* 一方 `NormedSpace.map_exp`（`Mathlib/Analysis/Normed/Algebra/Exponential.lean:578`）は
  **始域・終域の両方に `NormedRing` を要求する**（同ファイル 504 行目の `variable`）。
  `Matrix ι ι ℂ` の `NormedRing` は `Matrix.Norms.Operator` スコープにしか無く、
  そのノルム由来の位相は行列の既定の位相と定義的に一致しないため、
  「`diagonal` が連続な環準同型だから `exp` と可換」という筋は**そのままでは通らない**
  （`Application type mismatch: … PseudoMetricSpace.toUniformSpace.toTopologicalSpace …`）。
  この事情は `Ising2D/Part010/Claim003_ExpDiagonal.lean` のコメントに記録した。
* `Commute.exp_left` / `Commute.exp_right`（同 228, 235 行目）は位相環の設定で使えるので、
  「`ε` が指数の肩と可換なら `exp` とも可換」はノルムを経由せずに済む。
* 行列の冪のトレースを「道の総和」へ展開する補題は mathlib に**無い**
  （`Matrix.trace_pow` / `Matrix.pow_apply` を `Mathlib/LinearAlgebra/Matrix/Trace.lean`,
  `Mathlib/Data/Matrix/Mul.lean` で検索したが、`Matrix.pow_apply_nonneg` と
  `SimpleGraph.adjMatrix_pow_apply_eq_card_walk` しか無い）。
  そのため `Ising2D/NecSuf/TracePathSum.lean` として自前で証明した
  （`Fin.consEquiv` / `Fin.snocEquiv` による添字の付け替えを使う）。

---

## 4. 検証

```
cd exact-solution-of-2d-ising-model/lean
lake build            # 成功（警告のみ）
./scripts/check-no-sorry.sh   # exit 0
```

`scripts/check-no-sorry.sh` の `targets` には本章の主要定理 58 本を追記済み。
数値検証は `sagemath/check/043_claim_transfer_matrix_bridge/`（5 チェック全 PASS）。

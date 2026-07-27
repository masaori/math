# 016 章「偶セクターのフェルミオンと `V^{(+)} = c V̌'`」の Lean 形式化

対象の人手証明: `structured-latex/content/016_even_sector_fermions.ts`（9 主張）

新規ファイル:

- 具体版 `lean/Ising2D/Part016/`（8 ファイル）
- 抽象版 `lean/Ising2D/Abstract/FermionLadder.lean`, `lean/Ising2D/Abstract/ExpEigenvector.lean`

`lean/Ising2D.lean` と `lean/scripts/check-no-sorry.sh` へは末尾追記のみ。
既存の `.lean` ファイルは 1 つも編集していない。

## 1. 形式化した定理の一覧

| Lean の名前 | 内容 | 対応する人手証明のラベル |
| --- | --- | --- |
| `Ising2D.gamma1_add_int_mul_two_pi` | `γ_1(θ + 2kπ) = γ_1(θ)` | `periodicity_of_check_fermi` (1) |
| `Ising2D.thetaTilde_add_int_mul` | `θ̃_{μ+kM} = θ̃_μ + 2kπ` | 同 (2) |
| `Ising2D.gamma1_thetaTilde_add_int_mul` / `gamma2_thetaTilde_add_int_mul` / `gamma2_neg_thetaTilde_add_int_mul` | `γ_1(θ̃_{μ+kM}) = γ_1(θ̃_μ)` ほか | 同 (2) |
| `Ising2D.gamma2_thetaTilde_conj` | `γ_2(θ̃_{M+1-μ}) = γ_2(-θ̃_μ)` | 同 (3) |
| `Ising2D.gamma2_neg_thetaTilde_conj` | `γ_2(-θ̃_{M+1-μ}) = γ_2(θ̃_μ)` | 同 (3) |
| `Ising2D.gamma1_thetaTilde_conj` | `γ_1(θ̃_{M+1-μ}) = γ_1(θ̃_μ)` | 同 (3) |
| `Ising2D.checkR` | `r_μ := \|γ_2(θ̃_μ)\|` | `def_check_fermi` の係数 |
| `Ising2D.checkR_sq` | `(r_μ:ℂ)^2 = -(γ_2(θ̃_μ)γ_2(-θ̃_μ))`（**無条件**） | 同（分枝が要らないことの核） |
| `Ising2D.checkR_conj` | `r_{M+1-μ} = r_μ`（絶対値の計算だけ） | `anticommutator_of_check_psi` Step 1 |
| `Ising2D.checkPsiDag` / `Ising2D.checkPsi` | `ψ̌_μ^†`, `ψ̌_μ` | **`def_check_fermi`** |
| `Ising2D.checkPsiDag_eq` / `checkPsi_eq` | 原文の「すなわち」の明示式との一致 | 同（検算） |
| `Ising2D.checkP_mul_checkP_conj` | `p_μ p_{M+1-μ} = -1/(4M)` | `anticommutator_of_check_psi` Step 1 |
| `Ising2D.checkQ_mul_checkQ` | `q^2 = 1/(4M)` | 同 |
| `Ising2D.checkPsi_car` | CAR 3 式（抽象版の系として導出） | **`anticommutator_of_check_psi`** |
| `Ising2D.acomm_checkPsiDag_checkPsiDag` | `[ψ̌_μ^†, ψ̌_ν^†]₊ = 0` | 同 第 1 式 |
| `Ising2D.acomm_checkPsiDag_checkPsi` | `[ψ̌_μ^†, ψ̌_ν]₊ = δ_{ν,M+1-μ} I` | 同 第 2 式 |
| `Ising2D.acomm_checkPsi_checkPsi` | `[ψ̌_μ, ψ̌_ν]₊ = 0` | 同 第 3 式 |
| `Ising2D.AMat_mulVec_checkPsiDag_coeff` | `A(θ̃_μ)(p_μ,q)ᵀ = (γ_1+r_μ)(p_μ,q)ᵀ` | `commutation_V_plus_check_psi` の中身 |
| `Ising2D.AMat_mulVec_checkPsi_coeff` | `A(θ̃_μ)(-p_μ,q)ᵀ = (γ_1-r_μ)(-p_μ,q)ᵀ` | 同 |
| `Ising2D.TVPlus_checkPsiDag_of_action` / `TVPlus_checkPsi_of_action` | `T(ψ̌_μ^†) = (γ_1+r_μ)ψ̌_μ^†` ほか | **`commutation_V_plus_check_psi`** |
| `Ising2D.TVPlus_checkPsiDag_psi_of_action` | 上を `e^{±γ(θ̃_μ)}` の形で述べた版 | 同 |
| `Ising2D.checkIdx` / `checkIndex_checkIdx` / `checkIdx_rev` / `checkIdx_eq_rev_iff` | `𝓜̌ = {1,…,M}` を `Fin M` で走らせる。対の添字は `Fin.rev`（対合） | `def_check_Vprime` (1) |
| `Ising2D.checkX` / `Ising2D.checkVprime` | `X̌`, `V̌' = exp(X̌)` | **`def_check_Vprime`** |
| `Ising2D.checkVprimeUnits` / `isUnit_checkVprime` | `V̌'` の可逆性と `(V̌')^{-1} = exp(-X̌)` | 同 (2) |
| `Ising2D.checkX_eq_carHam` | `X̌` は抽象版 `Abstract.carHam` そのもの | 橋渡し |
| `Ising2D.matExp_conj_eigen` | `[X,a] = c a ⟹ exp(X) a exp(-X) = e^c a` | `action_of_T_check_Vprime_on_check_psi` Step 3〜5 |
| `Ising2D.lie_checkX_checkPsiDag` | `[X̌, ψ̌_μ^†] = γ(θ̃_μ) ψ̌_μ^†` | 同 Step 2 |
| `Ising2D.lie_checkX_checkPsi` | `[X̌, ψ̌_μ] = -γ(θ̃_μ) ψ̌_μ` | 同 Step 2' |
| `Ising2D.TCheckVprime_checkPsiDag` / `TCheckVprime_checkPsi` | `T_{(V̌')}(ψ̌_μ^†) = e^{+γ}ψ̌_μ^†`, `T_{(V̌')}(ψ̌_μ) = e^{-γ}ψ̌_μ` | **`action_of_T_check_Vprime_on_check_psi`** |
| `Ising2D.checkPsiDag_sub_checkPsi` / `checkPsiDag_add_checkPsi` | `ψ̌^† ∓ ψ̌` が `Ž, Y̌` のスカラー倍 | `T_V_plus_eq_T_check_Vprime_on_check_Z_Y` Step 1 |
| `Ising2D.checkZ_eq_smul` / `checkY_eq_smul` | `Ž_μ, Y̌_μ` をフェルミオンで書く（`P̌_μ^{-1}` の代用） | 同 Step 1 |
| `Ising2D.eq_on_checkZY_of_eq_on_checkPsi` | フェルミオン上の一致を `Ž, Y̌` へ移す | 同 Step 2・Step 3 |
| `Ising2D.TVPlus_eq_TCheckVprime_on_checkZY` | 原文の statement そのもの | **`T_V_plus_eq_T_check_Vprime_on_check_Z_Y`** |
| `Ising2D.TConj_eq_of_eq_on_checkZY` | `Ž, Y̌` 上で一致する共役は全体で一致 | **`T_V_plus_eq_T_check_Vprime`** |
| `Ising2D.TVPlus_eq_TCheckVprime` | 上を `V^{(+)}` の形で述べた版 | 同 |
| `Ising2D.TConj_one_apply` | `T_1 = id` | 補助（原文は暗黙） |
| `Ising2D.commute_of_TConj_eq` | `W := v^{-1}u` はすべての元と可換 | `V_plus_eq_c_check_Vprime` Step 1・2 |
| `Ising2D.exists_smul_of_TConj_eq` | 共役が一致する 2 つの可逆元は `0` でないスカラー倍を除いて等しい | **`V_plus_eq_c_check_Vprime`** |
| `Ising2D.VPlus_eq_smul_checkVprime` | `∃ c ≠ 0, V^{(+)} = c V̌'`（**本章の結論**） | 同 |
| `Ising2D.Abstract.lie_creAnn_cre` / `lie_creAnn_ann` | `[d a, c] = δ d`, `[d a, b] = -(δ a)`（**抽象版**） | `action_of_T_check_Vprime_on_check_psi` Step 1, 1' |
| `Ising2D.Abstract.carHam` / `lie_carHam_cre` / `lie_carHam_ann` | `[Σ g_ν (d_ν e_{σν} - κ), d_μ] = g_μ d_μ` ほか（**抽象版**） | 同 Step 2, 2' |
| `Ising2D.Abstract.cosh_add_sinh_eq_exp` | `cosh c + sinh c = e^c` | 補助 |
| `Ising2D.Abstract.exp_conj_of_ad_eigen` / `exp_conj_of_lie_eigen` | `ad x` の固有ベクトルは `exp` 共役の固有ベクトル（**抽象版**） | 同 Step 3〜5 |

## 2. 2 本立ての対応表と「抽象版で判明した本質」

| 人手証明のラベル | 具体版 | 抽象版 |
| --- | --- | --- |
| `anticommutator_of_check_psi` | `Ising2D.checkPsi_car` ほか 3 本（`Part016/Claim003_AnticommutatorCheckPsi.lean`） | **008 章の `Ising2D.Abstract.car_of_coeffs` がそのまま使える**（`Abstract/Fermion.lean`。新規作成不要だった） |
| `action_of_T_check_Vprime_on_check_psi` Step 1〜2' | `Ising2D.lie_checkX_checkPsiDag` / `lie_checkX_checkPsi` | `Ising2D.Abstract.lie_creAnn_cre` / `lie_creAnn_ann` / `lie_carHam_cre` / `lie_carHam_ann`（`Abstract/FermionLadder.lean`、新規） |
| `action_of_T_check_Vprime_on_check_psi` Step 3〜5 | `Ising2D.matExp_conj_eigen` | `Ising2D.Abstract.exp_conj_of_ad_eigen`（`Abstract/ExpEigenvector.lean`、新規） |

抽象版から得られた知見（本文には持ち込まない）:

- **008 章の抽象版 CAR（`Abstract.car_of_coeffs`）は半整数運動量でも一字一句そのまま使えた。**
  抽象版が要求するのは「反交換子がスカラー倍の `1` になること」と「係数についてのスカラー恒等式 2 本」
  だけで、対の条件が `μ+ν ≡ 0 (mod M)` から `ν = M+1-μ` へ変わっても、
  そこは `D` と `δ` の中身が変わるだけである。整数運動量／半整数運動量の違いは
  **CAR の代数的な内容には一切効いていない**。

- **`X̌` の梯子作用（原文 Step 1〜2'）に効いているのは、恒等式 `[a b, c] = a [b,c]₊ - [a,c]₊ b` と、
  反交換子の値がクロネッカーのデルタになることだけ**である。`ψ̌` の具体形も、
  複素行列であることも、`M`・`γ_2`・`θ̃` も効いていない。減じる `½ I` は
  「中心の元」でありさえすればよく、`½` である必要すらない（抽象版の `κ` は任意）。
  係数環は任意の可換環、台は任意の環でよい。

- **原文が「008 章と違って場合分けが一つも要らない」と述べている改善は、
  抽象版では仮定 `hed` / `hde`（反交換子がクロネッカーのデルタ）の形にそのまま吸収される。**
  つまりこの改善は**添字集合の取り方だけの問題であって、代数的な内容ではない**。
  008 章の `μ ∈ ℳ = {-M,…,-1,1,…,M}` では `ν = -μ` が `ℳ` の対合にならない場面があったのに対し、
  半整数運動量では `μ ↦ M+1-μ` が `𝓜̌` 上の対合（Lean では `Fin.rev`）になる。
  これが場合分けの消滅の唯一の理由である。

- **原文 Step 3（帰納法）・Step 4（部分和の極限）・Step 5（`exp` の積公式）の 3 段は、
  008 章ですでに形式化した「`ad X` が 2 次元部分空間を保つ場合の閉じた形」
  （`Abstract.exp_conj_two_dim_z`）の 1 次元への退化にすぎない**（`z = y = a` と置くだけ。
  `cosh c + c·sinhc c = cosh c + sinh c = e^c`）。新しい解析は 1 つも要らなかった。
  台は ℂ 上の完備ノルム環であればよく、行列であることも有限次元性も効いていない。

- **原文 `T_V_plus_eq_T_check_Vprime` / `V_plus_eq_c_check_Vprime` は `V^{(+)}` の定義に依存しない。**
  Lean 側では「`Ž, Y̌` 上で一致する 2 つの共役は全体で一致する」
  （`TConj_eq_of_eq_on_checkZY`）と「共役が一致する 2 つの可逆元はスカラー倍を除いて等しい」
  （`exists_smul_of_TConj_eq`）という形で無条件に証明でき、原文の主張はその特殊化である。

## 3. 形式化できなかった主張・残っている仮定

**担当範囲の 9 主張はすべて形式化した**（`sorry` / `admit` ゼロ）。ただし次の仮定が残っている。
いずれも**本セッションの担当範囲外（014 章・015 章）で、並行して形式化中**のものである。

| 仮定 | 出所 | 消える条件 |
| --- | --- | --- |
| `hga : ∀ μ ∈ 𝓜̌, γ_2(θ̃_μ) ≠ 0` | 015 章 `gamma_2_theta_tilde_nonzero` | 015 章がこれを `K_1, K_2 ∈ ℝ_{>0}` から無条件に閉じれば消える |
| `hT : ActsBy T (Ž_μ) (Y̌_μ) (A(θ̃_μ))` | 014 章 `T_V_plus_check_Z_Y` | 014 章の完成で消える |
| `hlamPlus` / `hlamMinus : γ_1(θ̃_μ) ± r_μ = e^{±γ(θ̃_μ)}` | 015 章 `lambda_eq_exp_gamma_theta_tilde` | 015 章の完成で消える |
| `g : ℤ → ℂ`（重み `γ(θ̃_μ)`）と `hgconj : γ(θ̃_{M+1-μ}) = γ(θ̃_μ)` | 015 章 `def_gamma_theta_tilde_mu` | 015 章が `γ` を定義すれば `g := fun μ => γ(θ̃_μ)` と置くだけ |

また、原文 `def_check_fermi` が `P̌_μ`（015 章 `diagonalization_check_P_D`）の列として
`ψ̌^†, ψ̌` を定義しているのに対し、本形式化は原文が「すなわち」として与えている**明示式**を
定義に採った。015 章が `P̌_μ` を用意したら、その列と本定義の一致を 1 本の補題で確認すればよい。
同じ理由で、原文 `T_V_plus_eq_T_check_Vprime_on_check_Z_Y` Step 1 の `P̌_μ^{-1}` は
`ψ̌^† ∓ ψ̌` の直接計算（`checkZ_eq_smul` / `checkY_eq_smul`）で置き換えた。
`det P̌_μ ≠ 0` に相当するのは `checkP_ne_zero` / `checkQ_ne_zero` である。

**実数解析（極限・積分・連続性）を新たに使った箇所は無い。**
`exp` の収束は 008 章の `Abstract/ExpConjugation.lean`（mathlib の
`NormedSpace.exp` と `Complex.hasSum_cosh` / `Abstract.hasSum_sinhc`）に閉じている。

## 4. 人手証明に見つけた誤り・穴

**無し。**

特に、008 章の `anticommutator_of_psi` で問題になった「平方根の分枝が `μ` と `ν` で一致するか」
という論点は、**本章の `anticommutator_of_check_psi` には存在しない**ことを機械的に確認した。
詳細は `docs/tasks/2026-07_lean-ch009-013/010_ch016_no_sqrt_branch_gap.md`。

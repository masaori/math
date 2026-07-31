/-
# Clifford 型の反交換関係から交換関係を出す計算（**必要十分版**）

対応する人手証明のラベル（具体版と共通）:

* `<H1_H2_via_hatZ_hatY>`
  （`structured-latex/content/004_transfer_matrix.mjs` の
  `transfer_matrix_012_claim_H1_H2_via_hatZ_hatY`）— 具体版は
  `Ising2D/Part004/Claim011_H1H2ViaHat.lean`
* `<commutator_of_H_and_Z_Y>`
  （`structured-latex/content/008_TV1_hatZ_hatY_part1.mjs` の
  `TV1_hatZ_hatY_001_claim_commutator_H_Z_Y`）— 具体版は
  `Ising2D/Part008/Claim001_CommutatorHZY.lean`

## このファイルの目的（`lean/README.md`「具体版と必要十分版の 2 本立て」）

人手証明 `<commutator_of_H_and_Z_Y>` は、`H_1^{(±)}, H_2` と `hat(Z)^{(±)}, hat(Y)` の
6 本の交換関係を、二重和の展開と反交換関係の代入で計算している。
そこで実際に効いているのは次の 2 つだけである。

1. 恒等式 `[a b, c] = a [b, c]₊ - [a, c]₊ b`
   （`Ising2D.lie_mul_eq_acomm_sub_acomm`、`<commutator_via_anticommutators>`）
2. 反交換子が**係数環のスカラー倍の 1**（`α • 1`）になること。具体的には
   `[z_μ, z_ν]₊ = D_z(μ,ν) • 1`、`[z_μ, y_ν]₊ = 0`、`[y_μ, y_ν]₊ = D_y(μ,ν) • 1`

すなわち、`hat(Z), hat(Y)` が**行列であること**も、その**具体形（離散フーリエ変換）**も、
`D` の中身（`2M δ^M_{μ+ν,0}` や `-4 e^{-i2π(μ+ν)/M}`）も効いていない。
本ファイルはこの事実を、台を任意の環 `A`（係数は任意の可換半環 `S` 上の代数）、
`z, y` を任意の族として述べることで示す。具体版はここからの特殊化として導く。

**必要十分版は Lean の中だけに置く**（`exact-solution-of-2d-ising-model/README.md` 4 節）。
人手証明の本文にも参照用ノートにも持ち込まない。
-/
import Ising2D.Part000.Claim046_CommutatorViaAnticommutators

namespace Ising2D.NecSuf

open Ising2D

section Basic

variable {A : Type*} [Ring A] {S : Type*} [CommSemiring S] [Algebra S A]

/-- 交換子はスカラー倍を外へ出す: `[c • x, w] = c • [x, w]`。 -/
theorem lie_smul_left (c : S) (x w : A) : ⁅c • x, w⁆ = c • ⁅x, w⁆ := by
  simp only [Ring.lie_def, Algebra.smul_mul_assoc, Algebra.mul_smul_comm, smul_sub]

/-- 交換子は第 1 引数について有限線型結合を外へ出す:
`[∑ᵢ γᵢ xᵢ, w] = ∑ᵢ γᵢ [xᵢ, w]`。 -/
theorem lie_sum_smul_left {ι : Type*} [Fintype ι] (γ : ι → S) (x : ι → A) (w : A) :
    ⁅∑ i, γ i • x i, w⁆ = ∑ i, γ i • ⁅x i, w⁆ := by
  simp only [Ring.lie_def, Finset.sum_mul, Finset.mul_sum, Algebra.smul_mul_assoc,
    Algebra.mul_smul_comm, smul_sub, Finset.sum_sub_distrib]

/-- **必要十分版の核**: 積の交換子は、2 つの反交換子がスカラー倍の `1` になるなら
線型結合に潰れる。

  `[a, c]₊ = α • 1`, `[b, c]₊ = β • 1` ⟹ `[a b, c] = β • a - α • b`

人手証明が「反交換子の値を代入する」と書いている操作は、すべてこの形である。 -/
theorem lie_mul_of_acomm_smul_one (a b c : A) (α β : S)
    (ha : acomm a c = α • (1 : A)) (hb : acomm b c = β • (1 : A)) :
    ⁅a * b, c⁆ = β • a - α • b := by
  rw [lie_mul_eq_acomm_sub_acomm, ha, hb, Algebra.mul_smul_comm, Algebra.smul_mul_assoc,
    mul_one, one_mul]

/-- 上の有限線型結合版（人手証明の `H_1^{(±)}, H_2` は `1/M` 倍を除けばこの形）。 -/
theorem lie_sum_smul_mul_of_acomm_smul_one {ι : Type*} [Fintype ι]
    (γ : ι → S) (a b : ι → A) (c : A) (α β : ι → S)
    (ha : ∀ i, acomm (a i) c = α i • (1 : A))
    (hb : ∀ i, acomm (b i) c = β i • (1 : A)) :
    ⁅∑ i, γ i • (a i * b i), c⁆ = ∑ i, (γ i * β i) • a i - ∑ i, (γ i * α i) • b i := by
  rw [lie_sum_smul_left, ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [lie_mul_of_acomm_smul_one _ _ _ _ _ (ha i) (hb i), smul_sub, smul_smul, smul_smul]

end Basic

/-! ## Clifford 型の 3 族と、そこから出る 6 本の交換関係

人手証明では `hat(Z)^{(±)}`（積の中と交換相手の両方に現れる）、`hat(Z)^{(∓)}`（交換相手だけ）、
`hat(Y)` の 3 つの族が現れる。それを `z`, `z'`, `y` として抽象化する。

必要な仮定は反交換関係 4 本だけで、族の添字型 `κ` は任意（有限である必要すらない）。 -/

/-- **Clifford 型の 3 族**。

* `z`  … 積の中にも交換相手にも現れる族（具体版の `hat(Z)^{(±)}`、`H_2` では `hat(Z)^{(-)}`）
* `z'` … 交換相手にだけ現れるもう一方の族（具体版の `hat(Z)^{(∓)}`、`H_2` では `hat(Z)^{(+)}`）
* `y`  … もう一方の Clifford 族（具体版の `hat(Y)`）

`D_z, D_{z'}, D_y` は反交換子の値（スカラー）で、中身は一切使わない。 -/
structure CliffordTriple (S : Type*) [CommSemiring S] (A : Type*) [Ring A] [Algebra S A]
    (κ : Type*) where
  /-- 積の中にも交換相手にも現れる族。 -/
  z : κ → A
  /-- 交換相手にだけ現れるもう一方の族。 -/
  z' : κ → A
  /-- もう一方の Clifford 族。 -/
  y : κ → A
  /-- `[z_a, z_b]₊` の値。 -/
  Dz : κ → κ → S
  /-- `[z_a, z'_b]₊` の値。 -/
  Dz' : κ → κ → S
  /-- `[y_a, y_b]₊` の値。 -/
  Dy : κ → κ → S
  /-- `[z_a, z_b]₊ = D_z(a,b) • 1`。 -/
  acomm_z_z : ∀ a b, acomm (z a) (z b) = Dz a b • (1 : A)
  /-- `[z_a, z'_b]₊ = D_{z'}(a,b) • 1`。 -/
  acomm_z_z' : ∀ a b, acomm (z a) (z' b) = Dz' a b • (1 : A)
  /-- `[z_a, y_b]₊ = 0`。 -/
  acomm_z_y : ∀ a b, acomm (z a) (y b) = 0
  /-- `[z'_a, y_b]₊ = 0`。 -/
  acomm_z'_y : ∀ a b, acomm (z' a) (y b) = 0
  /-- `[y_a, y_b]₊ = D_y(a,b) • 1`。 -/
  acomm_y_y : ∀ a b, acomm (y a) (y b) = Dy a b • (1 : A)

namespace CliffordTriple

variable {S : Type*} [CommSemiring S] {A : Type*} [Ring A] [Algebra S A] {κ : Type*}
variable (C : CliffordTriple S A κ)

theorem acomm_y_z (a b : κ) : acomm (C.y a) (C.z b) = 0 := by
  rw [acomm_comm]; exact C.acomm_z_y b a

theorem acomm_y_z' (a b : κ) : acomm (C.y a) (C.z' b) = 0 := by
  rw [acomm_comm]; exact C.acomm_z'_y b a

variable {ι : Type*} [Fintype ι] (γ : ι → S) (p q : ι → κ)

/-! ### 積の並びが `y z` の場合（具体版の `H_1^{(±)} = (1/M) ∑ⱼ e_j (hat(Y)_j hat(Z)^{(±)}_{-j})`） -/

/-- `[∑ᵢ γᵢ (y_{p i} z_{q i}), z_ν] = ∑ᵢ (γᵢ D_z(q i, ν)) • y_{p i}`。 -/
theorem lie_sum_yz_z (ν : κ) :
    ⁅∑ i, γ i • (C.y (p i) * C.z (q i)), C.z ν⁆ = ∑ i, (γ i * C.Dz (q i) ν) • C.y (p i) := by
  rw [lie_sum_smul_mul_of_acomm_smul_one γ (fun i => C.y (p i)) (fun i => C.z (q i)) (C.z ν)
      (fun _ => (0 : S)) (fun i => C.Dz (q i) ν)
      (fun i => by rw [C.acomm_y_z, zero_smul]) (fun i => C.acomm_z_z (q i) ν)]
  simp

/-- `[∑ᵢ γᵢ (y_{p i} z_{q i}), z'_ν] = ∑ᵢ (γᵢ D_{z'}(q i, ν)) • y_{p i}`。 -/
theorem lie_sum_yz_z' (ν : κ) :
    ⁅∑ i, γ i • (C.y (p i) * C.z (q i)), C.z' ν⁆ = ∑ i, (γ i * C.Dz' (q i) ν) • C.y (p i) := by
  rw [lie_sum_smul_mul_of_acomm_smul_one γ (fun i => C.y (p i)) (fun i => C.z (q i)) (C.z' ν)
      (fun _ => (0 : S)) (fun i => C.Dz' (q i) ν)
      (fun i => by rw [C.acomm_y_z', zero_smul]) (fun i => C.acomm_z_z' (q i) ν)]
  simp

/-- `[∑ᵢ γᵢ (y_{p i} z_{q i}), y_ν] = -∑ᵢ (γᵢ D_y(p i, ν)) • z_{q i}`。 -/
theorem lie_sum_yz_y (ν : κ) :
    ⁅∑ i, γ i • (C.y (p i) * C.z (q i)), C.y ν⁆ = -∑ i, (γ i * C.Dy (p i) ν) • C.z (q i) := by
  rw [lie_sum_smul_mul_of_acomm_smul_one γ (fun i => C.y (p i)) (fun i => C.z (q i)) (C.y ν)
      (fun i => C.Dy (p i) ν) (fun _ => (0 : S))
      (fun i => C.acomm_y_y (p i) ν) (fun i => by rw [C.acomm_z_y, zero_smul])]
  simp

/-! ### 積の並びが `z y` の場合（具体版の `H_2 = (1/M) ∑ⱼ hat(Z)^{(-)}_{-j} hat(Y)_j`） -/

/-- `[∑ᵢ γᵢ (z_{q i} y_{p i}), z_ν] = -∑ᵢ (γᵢ D_z(q i, ν)) • y_{p i}`。 -/
theorem lie_sum_zy_z (ν : κ) :
    ⁅∑ i, γ i • (C.z (q i) * C.y (p i)), C.z ν⁆ = -∑ i, (γ i * C.Dz (q i) ν) • C.y (p i) := by
  rw [lie_sum_smul_mul_of_acomm_smul_one γ (fun i => C.z (q i)) (fun i => C.y (p i)) (C.z ν)
      (fun i => C.Dz (q i) ν) (fun _ => (0 : S))
      (fun i => C.acomm_z_z (q i) ν) (fun i => by rw [C.acomm_y_z, zero_smul])]
  simp

/-- `[∑ᵢ γᵢ (z_{q i} y_{p i}), z'_ν] = -∑ᵢ (γᵢ D_{z'}(q i, ν)) • y_{p i}`。 -/
theorem lie_sum_zy_z' (ν : κ) :
    ⁅∑ i, γ i • (C.z (q i) * C.y (p i)), C.z' ν⁆
      = -∑ i, (γ i * C.Dz' (q i) ν) • C.y (p i) := by
  rw [lie_sum_smul_mul_of_acomm_smul_one γ (fun i => C.z (q i)) (fun i => C.y (p i)) (C.z' ν)
      (fun i => C.Dz' (q i) ν) (fun _ => (0 : S))
      (fun i => C.acomm_z_z' (q i) ν) (fun i => by rw [C.acomm_y_z', zero_smul])]
  simp

/-- `[∑ᵢ γᵢ (z_{q i} y_{p i}), y_ν] = ∑ᵢ (γᵢ D_y(p i, ν)) • z_{q i}`。 -/
theorem lie_sum_zy_y (ν : κ) :
    ⁅∑ i, γ i • (C.z (q i) * C.y (p i)), C.y ν⁆ = ∑ i, (γ i * C.Dy (p i) ν) • C.z (q i) := by
  rw [lie_sum_smul_mul_of_acomm_smul_one γ (fun i => C.z (q i)) (fun i => C.y (p i)) (C.y ν)
      (fun _ => (0 : S)) (fun i => C.Dy (p i) ν)
      (fun i => by rw [C.acomm_z_y, zero_smul]) (fun i => C.acomm_y_y (p i) ν)]
  simp

end CliffordTriple

end Ising2D.NecSuf

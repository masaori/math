/-
# `ε` の固有空間への射影子 `P^{(±)}` とその性質

対応する人手証明（正本は `structured-latex/content/010_transfer_matrix_bridge.ts`）:

* `bridge_008_definition_epsilon_projectors`（ラベル **`def_epsilon_projectors`**）
* `bridge_009_claim_epsilon_projector_properties`（ラベル **`epsilon_projector_properties`**）

抽象版は `Ising2D/Abstract/Projector.lean`（同じラベル）。
そこで確かめたとおり、(1)(2)(3) に効いているのは
**`ε` が対合であること（`ε² = I`）と `2` が可逆であること**だけである。
本ファイルの (2)(3) は抽象版 `Ising2D.Abstract.invProj_sq` /
`invProj_mul_invProj_neg` / `invProj_add_invProj_neg` の**系として**導いてある。

(4)（`im P^{(±)} = 𝓕^{(±)}`）だけは「行列がベクトルに作用する」という具体的な文脈が要るので、
ベクトルの言葉で直接述べる（`epsProj_mulVec_mem` と `epsProj_mulVec_eq_self`）。
-/
import Ising2D.Part004.Definition000_TransferMatrixSymbols
import Ising2D.Abstract.Projector

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## `2` の可逆性 -/

/-- `TensorPow M = Mat(2^M, ℂ)` では `2` は可逆で、逆元は `(1/2) I`。 -/
noncomputable instance instInvertibleTwoTensorPow : Invertible (2 : TensorPow M) where
  invOf := (1 / 2 : ℂ) • (1 : TensorPow M)
  invOf_mul_self := by
    have h2 : (2 : TensorPow M) = (2 : ℂ) • (1 : TensorPow M) := by
      rw [← Algebra.algebraMap_eq_smul_one, map_ofNat]
    rw [h2, smul_mul_smul_comm, one_mul]
    norm_num
  mul_invOf_self := by
    have h2 : (2 : TensorPow M) = (2 : ℂ) • (1 : TensorPow M) := by
      rw [← Algebra.algebraMap_eq_smul_one, map_ofNat]
    rw [h2, smul_mul_smul_comm, one_mul]
    norm_num

theorem invOf_two_tensorPow : ⅟(2 : TensorPow M) = (1 / 2 : ℂ) • (1 : TensorPow M) := rfl

/-! ## 射影子の定義 -/

/-- **原文の `P^{(±)} = (I ± ε)/2`**（`η = +1` が `P^{(+)}`、`η = -1` が `P^{(-)}`）。 -/
noncomputable def epsProj (M : ℕ) (η : ℂ) : TensorPow M :=
  (1 / 2 : ℂ) • (1 + η • epsilon M)

/-- 抽象版の射影子との一致（`e = η ε`）。 -/
theorem epsProj_eq_invProj (η : ℂ) :
    epsProj M η = Abstract.invProj (η • epsilon M) := by
  rw [epsProj, Abstract.invProj, invOf_two_tensorPow, smul_mul_assoc, one_mul]

/-- **原文 (1) `ε² = I`**（既存の `Ising2D.epsilon_mul_self` の言い換え）。 -/
theorem epsilon_sq : epsilon M * epsilon M = 1 := epsilon_mul_self

/-- `η² = 1` のとき `(η ε)² = I`。 -/
theorem eta_smul_epsilon_sq {η : ℂ} (hη : η * η = 1) :
    (η • epsilon M) * (η • epsilon M) = 1 := by
  rw [smul_mul_smul_comm, epsilon_sq, hη, one_smul]

/-- **原文 (2) の前半 `(P^{(±)})^2 = P^{(±)}`**（抽象版の系）。 -/
theorem epsProj_sq {η : ℂ} (hη : η * η = 1) :
    epsProj M η * epsProj M η = epsProj M η := by
  rw [epsProj_eq_invProj]
  exact Abstract.invProj_sq (eta_smul_epsilon_sq hη)

/-- **原文 (2) の後半 `P^{(+)}P^{(-)} = 0`**（抽象版の系）。 -/
theorem epsProj_mul_epsProj_neg {η : ℂ} (hη : η * η = 1) :
    epsProj M η * epsProj M (-η) = 0 := by
  have h : epsProj M (-η) = Abstract.invProj (-(η • epsilon M)) := by
    rw [epsProj_eq_invProj, neg_smul]
  rw [epsProj_eq_invProj, h]
  exact Abstract.invProj_mul_invProj_neg (eta_smul_epsilon_sq hη)

/-- **原文 (3) `P^{(+)} + P^{(-)} = I`**（抽象版の系）。 -/
theorem epsProj_add_epsProj_neg (η : ℂ) :
    epsProj M η + epsProj M (-η) = 1 := by
  have h : epsProj M (-η) = Abstract.invProj (-(η • epsilon M)) := by
    rw [epsProj_eq_invProj, neg_smul]
  rw [epsProj_eq_invProj, h]
  exact Abstract.invProj_add_invProj_neg _

/-! ## (4) 像は `ε` の固有空間 -/

/-- `ε P^{(±)} = ± P^{(±)}`（原文 (4) の `(⊆)` の計算そのもの）。 -/
theorem epsilon_mul_epsProj {η : ℂ} (hη : η * η = 1) :
    epsilon M * epsProj M η = η • epsProj M η := by
  rw [epsProj, mul_smul_comm, smul_comm η (1 / 2 : ℂ)]
  congr 1
  rw [mul_add, mul_one, mul_smul_comm, epsilon_sq, smul_add, smul_smul, hη, one_smul,
    add_comm]

/-- **原文 (4) の `(⊆)`**: `P^{(±)}x` は `ε` の固有値 `±1` の固有ベクトルである。 -/
theorem epsProj_mulVec_mem {η : ℂ} (hη : η * η = 1) (x : Conf M → ℂ) :
    epsilon M *ᵥ (epsProj M η *ᵥ x) = η • (epsProj M η *ᵥ x) := by
  rw [Matrix.mulVec_mulVec, epsilon_mul_epsProj hη, Matrix.smul_mulVec]

/-- **原文 (4) の `(⊇)`**: `ε f = ±f` なら `P^{(±)} f = f`。 -/
theorem epsProj_mulVec_eq_self {η : ℂ} (hη : η * η = 1) {f : Conf M → ℂ}
    (hf : epsilon M *ᵥ f = η • f) : epsProj M η *ᵥ f = f := by
  rw [epsProj, Matrix.smul_mulVec, Matrix.add_mulVec, Matrix.one_mulVec,
    Matrix.smul_mulVec, hf, smul_smul, hη, one_smul, ← two_smul ℂ f, smul_smul]
  norm_num

end Ising2D

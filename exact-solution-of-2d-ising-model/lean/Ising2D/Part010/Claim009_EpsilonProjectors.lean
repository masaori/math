/-
# `ε` の固有空間への射影子 `P^{(+)}` とその性質

対応する人手証明（正本は `structured-latex/content/010_transfer_matrix_bridge.ts`）:

* `bridge_008_definition_epsilon_projectors`（ラベル **`def_epsilon_projectors`**）
  — `P^{(+)} := (1/2)(I + ε)`（`Ising2D.epsProjPlus`）
* `bridge_009_claim_epsilon_projector_properties`（ラベル **`epsilon_projector_properties`**）
  — (1) `(P^{(+)})^2 = P^{(+)}`（`epsProjPlus_sq`）、
    (2) `im P^{(+)} = 𝓕^{(+)}`（`epsilon_projector_properties_image`。二つの包含は
    `epsProjPlus_mulVec_mem` と `epsProjPlus_mulVec_eq_self`）

## 符号引数つきの一般形（補助）

`epsProj M η := (1/2)(I + ηε)` は符号引数つきの補助の一般形で、`P^{(+)}` は `η = 1`
（`epsProjPlus_eq_epsProj`）。`η = -1` の `P^{(-)}` と、`P^{(+)}P^{(-)} = 0`・`P^{(+)} + P^{(-)} = I`
（`epsProj_mul_epsProj_neg` / `epsProj_add_epsProj_neg`）は、人手の本文から参照用ノート
`structured-latex/notes/minus_sector_not_adopted.ts` へ退避した `(−)` セクターの議論
（`partition_function_sector_decomposition` ほか）の形式化の記録として残してある。

必要十分版は `Ising2D/NecSuf/Projector.lean`（同じラベル）。
そこで確かめたとおり、(1) に効いているのは
**`ε` が対合であること（`ε² = I`）と `2` が可逆であること**だけである。
(1) は一般形 `epsProj_sq`（必要十分版 `Ising2D.NecSuf.invProj_sq` の系）を `η = 1` で使う。

(2)（`im P^{(+)} = 𝓕^{(+)}`）は「行列がベクトルに作用する」という具体的な文脈が要るので、
ベクトルの言葉で直接述べる。
-/
import Ising2D.Part004.Definition000_TransferMatrixSymbols
import Ising2D.NecSuf.Projector

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

/-- 補助: 符号引数つきの一般形 `(I + ηε)/2`（`η = 1` が人手の `P^{(+)}`）。 -/
noncomputable def epsProj (M : ℕ) (η : ℂ) : TensorPow M :=
  (1 / 2 : ℂ) • (1 + η • epsilon M)

/-- 必要十分版の射影子との一致（`e = η ε`）。 -/
theorem epsProj_eq_invProj (η : ℂ) :
    epsProj M η = NecSuf.invProj (η • epsilon M) := by
  rw [epsProj, NecSuf.invProj, invOf_two_tensorPow, smul_mul_assoc, one_mul]

/-- `ε² = I`（人手 `epsilon_square_and_eigenvalues`。既存の `Ising2D.epsilon_mul_self` の言い換え）。 -/
theorem epsilon_sq : epsilon M * epsilon M = 1 := epsilon_mul_self

/-- `η² = 1` のとき `(η ε)² = I`。 -/
theorem eta_smul_epsilon_sq {η : ℂ} (hη : η * η = 1) :
    (η • epsilon M) * (η • epsilon M) = 1 := by
  rw [smul_mul_smul_comm, epsilon_sq, hη, one_smul]

/-- 補助: 一般形の冪等性（必要十分版の系）。 -/
theorem epsProj_sq {η : ℂ} (hη : η * η = 1) :
    epsProj M η * epsProj M η = epsProj M η := by
  rw [epsProj_eq_invProj]
  exact NecSuf.invProj_sq (eta_smul_epsilon_sq hη)

/-- 退避した `(−)` セクターの議論の記録: `P^{(+)}P^{(-)} = 0`（必要十分版の系）。 -/
theorem epsProj_mul_epsProj_neg {η : ℂ} (hη : η * η = 1) :
    epsProj M η * epsProj M (-η) = 0 := by
  have h : epsProj M (-η) = NecSuf.invProj (-(η • epsilon M)) := by
    rw [epsProj_eq_invProj, neg_smul]
  rw [epsProj_eq_invProj, h]
  exact NecSuf.invProj_mul_invProj_neg (eta_smul_epsilon_sq hη)

/-- 退避した `(−)` セクターの議論の記録: `P^{(+)} + P^{(-)} = I`（必要十分版の系）。 -/
theorem epsProj_add_epsProj_neg (η : ℂ) :
    epsProj M η + epsProj M (-η) = 1 := by
  have h : epsProj M (-η) = NecSuf.invProj (-(η • epsilon M)) := by
    rw [epsProj_eq_invProj, neg_smul]
  rw [epsProj_eq_invProj, h]
  exact NecSuf.invProj_add_invProj_neg _

/-! ## 一般形の像は `ε` の固有空間（補助） -/

/-- 補助: `ε (I + ηε)/2 = η (I + ηε)/2`。 -/
theorem epsilon_mul_epsProj {η : ℂ} (hη : η * η = 1) :
    epsilon M * epsProj M η = η • epsProj M η := by
  rw [epsProj, mul_smul_comm, smul_comm η (1 / 2 : ℂ)]
  congr 1
  rw [mul_add, mul_one, mul_smul_comm, epsilon_sq, smul_add, smul_smul, hη, one_smul,
    add_comm]

/-- 補助: 一般形で `ε ((I + ηε)/2 x) = η ((I + ηε)/2 x)`。 -/
theorem epsProj_mulVec_mem {η : ℂ} (hη : η * η = 1) (x : Conf M → ℂ) :
    epsilon M *ᵥ (epsProj M η *ᵥ x) = η • (epsProj M η *ᵥ x) := by
  rw [Matrix.mulVec_mulVec, epsilon_mul_epsProj hη, Matrix.smul_mulVec]

/-- 補助: 一般形で `ε f = η f` なら `(I + ηε)/2 f = f`。 -/
theorem epsProj_mulVec_eq_self {η : ℂ} (hη : η * η = 1) {f : Conf M → ℂ}
    (hf : epsilon M *ᵥ f = η • f) : epsProj M η *ᵥ f = f := by
  rw [epsProj, Matrix.smul_mulVec, Matrix.add_mulVec, Matrix.one_mulVec,
    Matrix.smul_mulVec, hf, smul_smul, hη, one_smul, ← two_smul ℂ f, smul_smul]
  norm_num

/-! ## `P^{(+)}`（人手 `def_epsilon_projectors`, `epsilon_projector_properties`） -/

/-- **人手本文 `def_epsilon_projectors`**: `P^{(+)} := (1/2)(I + ε)`。 -/
noncomputable def epsProjPlus (M : ℕ) : TensorPow M :=
  (1 / 2 : ℂ) • (1 + epsilon M)

/-- `P^{(+)}` は一般形 `epsProj` の `η = 1`。 -/
theorem epsProjPlus_eq_epsProj : epsProjPlus M = epsProj M 1 := by
  rw [epsProjPlus, epsProj, one_smul]

/-- **人手本文 `epsilon_projector_properties` (1)**: `(P^{(+)})^2 = P^{(+)}`。 -/
theorem epsProjPlus_sq : epsProjPlus M * epsProjPlus M = epsProjPlus M := by
  rw [epsProjPlus_eq_epsProj]
  exact epsProj_sq (by norm_num)

/-- **人手本文 `epsilon_projector_properties` (2) の `(⊆)`**:
`P^{(+)} x ∈ 𝓕^{(+)}`、すなわち `ε (P^{(+)} x) = P^{(+)} x`。

人手の鎖（`ε y = ε P^{(+)} y = (1/2)(ε + ε²) y = (1/2)(I + ε) y = y`）は、行列の等式
`ε P^{(+)} = P^{(+)}`（`epsilon_mul_epsProj` の `η = 1`）を `x` に作用させる形で辿る。 -/
theorem epsProjPlus_mulVec_mem (x : Conf M → ℂ) :
    epsilon M *ᵥ (epsProjPlus M *ᵥ x) = epsProjPlus M *ᵥ x := by
  rw [epsProjPlus_eq_epsProj, epsProj_mulVec_mem (by norm_num) x, one_smul]

/-- **人手本文 `epsilon_projector_properties` (2) の `(⊇)`**: `ε f = f` なら `P^{(+)} f = f`。 -/
theorem epsProjPlus_mulVec_eq_self {f : Conf M → ℂ} (hf : epsilon M *ᵥ f = f) :
    epsProjPlus M *ᵥ f = f := by
  rw [epsProjPlus_eq_epsProj]
  exact epsProj_mulVec_eq_self (by norm_num) (by rw [hf, one_smul])

/-- **人手本文 `epsilon_projector_properties` (2)**: `im P^{(+)} = 𝓕^{(+)}`
（`𝓕^{(+)}` は `def_even_eigenvectors_of_epsilon` の `{f | ε f = f}`）。 -/
theorem epsilon_projector_properties_image :
    Set.range (fun x : Conf M → ℂ => epsProjPlus M *ᵥ x)
      = {f : Conf M → ℂ | epsilon M *ᵥ f = f} := by
  ext y
  constructor
  · rintro ⟨x, rfl⟩
    exact epsProjPlus_mulVec_mem x
  · intro hy
    exact ⟨y, epsProjPlus_mulVec_eq_self hy⟩

end Ising2D

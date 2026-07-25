/-
# 全行列と可換な行列はスカラー（中心 = スカラー）

対応する人手証明:
`parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ`
(`<centralizer_is_scalar>`)

原文: `M ∈ ℤ_{≥1}`、`W ∈ Mat(2,ℂ)^{⊗M}` がすべての `x ∈ Mat(2,ℂ)^{⊗M}` と可換ならば、
ある `c ∈ ℂ` があって `W = c · I`。

人手証明は行列単位 `E_{IJ}` を用いた 4 ステップ（基底展開 → 積公式 → 係数比較 → 結論）だが、
推奨表現 `TensorPow M = Matrix (Conf M) (Conf M) ℂ` を採ると、mathlib の
`Matrix.center_eq_scalar_image`（行列環の中心 = 係数環の中心のスカラー行列の像）に
そのまま帰着する。**この補題が既存で賄えることが、行列表現を推奨する主要な根拠のひとつ。**
-/
import Mathlib.Data.Matrix.Basis
import Ising2D.Representation

namespace Ising2D

section General

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- 一般の行列環版: `Matrix n n ℂ` の中で全元と可換な元はスカラー行列。 -/
theorem matrix_centralizer_is_scalar (W : Matrix n n ℂ)
    (h : ∀ x : Matrix n n ℂ, W * x = x * W) :
    ∃ c : ℂ, W = c • (1 : Matrix n n ℂ) := by
  have hW : W ∈ Set.center (Matrix n n ℂ) :=
    Subsemigroup.mem_center_iff.mpr fun g => (h g).symm
  rw [Matrix.center_eq_scalar_image] at hW
  obtain ⟨c, -, hc⟩ := hW
  refine ⟨c, ?_⟩
  rw [← hc]
  ext i j
  by_cases hij : i = j <;> simp [Matrix.scalar_apply, hij]

end General

/-- **`<centralizer_is_scalar>` の形式化（推奨表現 `TensorPow M` 上）**。 -/
theorem centralizer_is_scalar {M : ℕ} (W : TensorPow M)
    (h : ∀ x : TensorPow M, W * x = x * W) :
    ∃ c : ℂ, W = c • (1 : TensorPow M) :=
  matrix_centralizer_is_scalar W h

/-- 同じ主張を抽象テンソル冪表現 `AbstractTensorPow M` 側で述べたもの。
`tensorPowAlgEquiv` による移送で得られる（表現の橋渡しが実際に働くことの確認）。 -/
theorem centralizer_is_scalar_abstract {M : ℕ} (W : AbstractTensorPow M)
    (h : ∀ x : AbstractTensorPow M, W * x = x * W) :
    ∃ c : ℂ, W = c • (1 : AbstractTensorPow M) := by
  set e := tensorPowAlgEquiv M with he
  obtain ⟨c, hc⟩ := centralizer_is_scalar (e W) fun y => by
    have := h (e.symm y)
    have h' := congrArg e this
    simpa using h'
  refine ⟨c, ?_⟩
  have : e.symm (e W) = e.symm (c • (1 : TensorPow M)) := congrArg e.symm hc
  simpa using this

end Ising2D

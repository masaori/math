/-
人手証明の主張「奇数側だけ反転する写像は各辺の破れを反転する」
（ラベル `claim_odd_flip_reverses_edges`）の具体版。

人手証明の場合分けとこのファイルの対応:

  辺の両端の偶奇は異なる                         `edge_endpoints_parity_differ`
  第一端点だけが奇数側なら第一端点だけ符号反転   `oddFlip_reverses_edge` の第一の場合
  第二端点だけが奇数側なら第二端点だけ符号反転   `oddFlip_reverses_edge` の第二の場合
  反転後に両端が異なることと反転前に等しいこと   `negSpin_ne_iff_eq` と `ne_negSpin_iff_eq`

一般の二部グラフや二元集合上の置換の定理へ委ねず、値が +1 と -1 の二場合を
このファイルで直接確かめる。

住処: `Fin`、`Nat`、`Bool`、整数 ±1 のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.OddFlipInvolution

namespace Ising3DCut.NullModel

/-- ±1 の値では、一方だけを符号反転して異なることと、反転前の二値が等しいことは同値。 -/
lemma negSpin_ne_iff_eq (x y : Spin) : negSpin x ≠ y ↔ x = y := by
  constructor
  · intro h
    apply Subtype.ext
    have hval : -x.1 ≠ y.1 := by
      intro heq
      apply h
      apply Subtype.ext
      exact heq
    rcases x.2 with hx | hx <;> rcases y.2 with hy | hy <;> omega
  · intro hxy
    subst y
    intro h
    have hval := congrArg Subtype.val h
    simp [negSpin] at hval
    rcases x.2 with hx | hx <;> omega

/-- 符号反転する端点を左右で入れ替えた場合の同じ同値。 -/
lemma ne_negSpin_iff_eq (x y : Spin) : x ≠ negSpin y ↔ x = y := by
  rw [ne_comm, negSpin_ne_iff_eq, eq_comm]

/-- `claim_odd_flip_reverses_edges` の具体版。 -/
theorem oddFlip_reverses_edge {L : ℕ} (σ : Config L) (e : Edge L) :
    oddFlip σ (endpoint0 e) ≠ oddFlip σ (endpoint1 e) ↔
      σ (endpoint0 e) = σ (endpoint1 e) := by
  have hp := edge_endpoints_parity_differ e
  by_cases h₀ : parity (endpoint0 e)
  · have h₁ : parity (endpoint1 e) = false := by
      cases h : parity (endpoint1 e)
      · exact rfl
      · exact False.elim (hp (h₀.trans h.symm))
    simp [oddFlip, h₀, h₁, negSpin_ne_iff_eq]
  · have h₀' : parity (endpoint0 e) = false := Bool.eq_false_of_not_eq_true h₀
    have h₁ : parity (endpoint1 e) = true := by
      cases h : parity (endpoint1 e)
      · exact False.elim (hp (h₀'.trans h.symm))
      · exact rfl
    simp [oddFlip, h₀', h₁, ne_negSpin_iff_eq]

end Ising3DCut.NullModel

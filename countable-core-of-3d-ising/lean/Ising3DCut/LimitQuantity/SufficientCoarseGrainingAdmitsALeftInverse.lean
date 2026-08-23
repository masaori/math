/-
「値の衝突を持たない粗視化は左逆写像を持ち、その値から元の正の有理数を復元する」の
Lean 具体版。

人手証明と 1 対 1 に対応させる。すなわち像の各点に原像が存在する段、
衝突が無いことから原像がちょうど一つである段、その一意な原像を対応させる規則が
写像を定める段、その写像が左逆写像である段、そして左逆写像が一つだけである段を、この順で辿る。

有限の箱ごとの言明であり、箱の大きさの極限を含まない。
-/
import Ising3DCut.LimitQuantity.CollidingCoarseGrainingNotSufficient

namespace Ising3DCut.LimitQuantity

/-- 粗視化 `π` の、正の有理数の上での像。人手証明の
`\pi(\mathbb Q_{>0})=\{ s : \exists u\in\mathbb Q_{>0},\ \pi(u)=s \}` に対応する。 -/
def positiveCoarseImage {S : Type*} (π : ℚ → S) : Type _ :=
  {s : S // ∃ u : ℚ, 0 < u ∧ π u = s}

/-- 正の有理数を、その粗視化の値として像へ送る写像。 -/
def toPositiveCoarseImage {S : Type*} (π : ℚ → S) (u : ℚ) (hu : 0 < u) :
    positiveCoarseImage π :=
  ⟨π u, u, hu, rfl⟩

/-- 人手証明の第一段。像の各点には正の有理数の原像が少なくとも一つ存在する。 -/
theorem exists_positive_preimage {S : Type*} (π : ℚ → S) (s : positiveCoarseImage π) :
    ∃ u : ℚ, 0 < u ∧ π u = s.val := s.property

/-- 人手証明の第二段。値の衝突が無ければ、像の各点の原像はちょうど一つである。 -/
theorem positive_preimage_unique {S : Type*} (π : ℚ → S)
    (hfree : ∀ u w : ℚ, 0 < u → 0 < w → π u = π w → u = w)
    (s : positiveCoarseImage π) {u w : ℚ}
    (hu : 0 < u) (hw : 0 < w) (hus : π u = s.val) (hws : π w = s.val) :
    u = w :=
  hfree u w hu hw (hus.trans hws.symm)

/-- 人手証明の第三段。各点にその一意な原像を対応させる規則は写像を定める。 -/
noncomputable def positiveCoarseLeftInverse {S : Type*} (π : ℚ → S)
    (s : positiveCoarseImage π) : ℚ :=
  Classical.choose s.property

theorem positiveCoarseLeftInverse_spec {S : Type*} (π : ℚ → S) (s : positiveCoarseImage π) :
    0 < positiveCoarseLeftInverse π s ∧ π (positiveCoarseLeftInverse π s) = s.val :=
  Classical.choose_spec s.property

/-- 人手証明の第四段。構成した写像は左逆写像である。 -/
theorem positiveCoarseLeftInverse_leftInverse {S : Type*} (π : ℚ → S)
    (hfree : ∀ u w : ℚ, 0 < u → 0 < w → π u = π w → u = w)
    (u : ℚ) (hu : 0 < u) :
    positiveCoarseLeftInverse π (toPositiveCoarseImage π u hu) = u := by
  obtain ⟨hpos, hval⟩ := positiveCoarseLeftInverse_spec π (toPositiveCoarseImage π u hu)
  exact positive_preimage_unique π hfree (toPositiveCoarseImage π u hu) hpos hu hval rfl

/-- 人手証明の第五段。左逆写像の条件を満たす写像は一つだけである。 -/
theorem positiveCoarseLeftInverse_unique {S : Type*} (π : ℚ → S)
    (hfree : ∀ u w : ℚ, 0 < u → 0 < w → π u = π w → u = w)
    (τ : positiveCoarseImage π → ℚ)
    (hτ : ∀ (u : ℚ) (hu : 0 < u), τ (toPositiveCoarseImage π u hu) = u) :
    τ = positiveCoarseLeftInverse π := by
  funext s
  obtain ⟨u, hu, hus⟩ := exists_positive_preimage π s
  have hs : s = toPositiveCoarseImage π u hu := Subtype.ext hus.symm
  rw [hs, hτ u hu, positiveCoarseLeftInverse_leftInverse π hfree u hu]

end Ising3DCut.LimitQuantity

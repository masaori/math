/-
「値の衝突を持たない粗視化の像は素指数データと一対一に対応する」の Lean 具体版。

人手証明と 1 対 1 に対応させる。すなわち左逆写像を取る段、像の上で
`π ∘ σ` が恒等であることを示す段、素指数データの写像へ同じ主張を適用する段、
二つの像を結ぶ写像 `Φ`・`Ψ` を定める段、`Ψ ∘ Φ` が恒等である段、
`Φ ∘ Ψ` が恒等である段を、この順で辿る。

素指数データの写像が値の衝突を持たないこと（素因数分解の一意性）は、
この具体版では仮定 `hλ` として置く。人手証明の第三段でその一意性を引用する箇所に対応する。

有限の箱ごとの言明であり、箱の大きさの極限を含まない。扱う量は正の有理数と
その素指数データだけである。
-/
import Ising3DCut.LimitQuantity.SufficientCoarseGrainingAdmitsALeftInverse

namespace Ising3DCut.LimitQuantity

variable {S T : Type*}

/-- 人手証明の第二段。像の各点 `s` について `π (σ s) = s` である。 -/
theorem coarse_image_section {π : ℚ → S}
    (_hfree : ∀ u w : ℚ, 0 < u → 0 < w → π u = π w → u = w)
    (s : positiveCoarseImage π) :
    π (positiveCoarseLeftInverse π s) = s.val :=
  (positiveCoarseLeftInverse_spec π s).2

/-- 人手証明の第四段の前半。`Φ (s) = λ (σ s)` は像から像への写像である。 -/
noncomputable def coarseToPrimeExponent (π : ℚ → S) (lam : ℚ → T)
    (s : positiveCoarseImage π) : positiveCoarseImage lam :=
  toPositiveCoarseImage lam (positiveCoarseLeftInverse π s)
    (positiveCoarseLeftInverse_spec π s).1

/-- 人手証明の第四段の後半。`Ψ (t) = π (μ t)` は像から像への写像である。 -/
noncomputable def primeExponentToCoarse (π : ℚ → S) (lam : ℚ → T)
    (t : positiveCoarseImage lam) : positiveCoarseImage π :=
  toPositiveCoarseImage π (positiveCoarseLeftInverse lam t)
    (positiveCoarseLeftInverse_spec lam t).1

/-- 人手証明の第五段。`Ψ (Φ s) = s` である。 -/
theorem primeExponentToCoarse_coarseToPrimeExponent (π : ℚ → S) (lam : ℚ → T)
    (hfree : ∀ u w : ℚ, 0 < u → 0 < w → π u = π w → u = w)
    (hlam : ∀ u w : ℚ, 0 < u → 0 < w → lam u = lam w → u = w)
    (s : positiveCoarseImage π) :
    primeExponentToCoarse π lam (coarseToPrimeExponent π lam s) = s := by
  apply Subtype.ext
  show π (positiveCoarseLeftInverse lam (coarseToPrimeExponent π lam s)) = s.val
  have hμ : positiveCoarseLeftInverse lam (coarseToPrimeExponent π lam s)
      = positiveCoarseLeftInverse π s :=
    positiveCoarseLeftInverse_leftInverse lam hlam _ (positiveCoarseLeftInverse_spec π s).1
  rw [hμ, coarse_image_section hfree s]

/-- 人手証明の第六段。`Φ (Ψ t) = t` である。 -/
theorem coarseToPrimeExponent_primeExponentToCoarse (π : ℚ → S) (lam : ℚ → T)
    (hfree : ∀ u w : ℚ, 0 < u → 0 < w → π u = π w → u = w)
    (hlam : ∀ u w : ℚ, 0 < u → 0 < w → lam u = lam w → u = w)
    (t : positiveCoarseImage lam) :
    coarseToPrimeExponent π lam (primeExponentToCoarse π lam t) = t := by
  apply Subtype.ext
  show lam (positiveCoarseLeftInverse π (primeExponentToCoarse π lam t)) = t.val
  have hσ : positiveCoarseLeftInverse π (primeExponentToCoarse π lam t)
      = positiveCoarseLeftInverse lam t :=
    positiveCoarseLeftInverse_leftInverse π hfree _ (positiveCoarseLeftInverse_spec lam t).1
  rw [hσ, coarse_image_section hlam t]

/-- 六段を束ねた主張そのもの。二つの像は互いに打ち消し合う二つの写像で一対一に対応する。 -/
theorem countable_core_corresponds_to_prime_exponent_data (π : ℚ → S) (lam : ℚ → T)
    (hfree : ∀ u w : ℚ, 0 < u → 0 < w → π u = π w → u = w)
    (hlam : ∀ u w : ℚ, 0 < u → 0 < w → lam u = lam w → u = w) :
    ∃ (Φ : positiveCoarseImage π → positiveCoarseImage lam)
      (Ψ : positiveCoarseImage lam → positiveCoarseImage π),
      (∀ s, Ψ (Φ s) = s) ∧ (∀ t, Φ (Ψ t) = t) :=
  ⟨coarseToPrimeExponent π lam, primeExponentToCoarse π lam,
    primeExponentToCoarse_coarseToPrimeExponent π lam hfree hlam,
    coarseToPrimeExponent_primeExponentToCoarse π lam hfree hlam⟩

end Ising3DCut.LimitQuantity

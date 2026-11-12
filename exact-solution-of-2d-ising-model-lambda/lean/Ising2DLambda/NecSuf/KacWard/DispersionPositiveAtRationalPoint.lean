/-
「分散因子は零と一の間の有理点で正である」の必要十分版。

具体版と同じ手順（`2 − ϖ − ϖ' = (1−α)² + β² = c·c` の五行を二つのモードへ、
`q(1−q²) = q(1−q)(1+q) = r = s·s`、正値分解の四行で `Δ(q) − p·p = (se)·(se)`、
`se ≠ 0` か `se = 0` で `p·p ≤ Δ(q)`、`(q+1)(q+1) = p + 2 = 2` の矛盾から `p ≠ 0`）を、次の仮定だけで行う。

- `R`, `K`: 可換環。`ι : R →+* K` は包含にあたる環準同型（単射性は使わない）。
- `j : ℚ →+* R` は有理数の埋め込み。`R` が非自明であることは `p ≠ 0 ⇒ j p ≠ 0`（体からの環準同型の単射性）
  で使う。これを外すと `0 <_R p·p` の証人 `j p` が零になりうる。
- 順序は差が零でない平方であること（`sqLt`）。正の有理数が正であること `pos_rat` と、
  二つの平方の和が平方であること `sum_is_square` だけを仮定する。推移律・三分法は使わない。
- 各モード `ϖ` とその逆元にあたる `ϖ'` には、共役の主張の結論 `ϖ = ια + ιβ·ω`、`ϖ' = ια − ιβ·ω`、
  `α² + β² = 1` だけを仮定する。`ω` には何も仮定しない（`ω·ω = −1` は五行で使わない）。
  `ϖ'` が `ϖ` の逆元であること、`K` が体であること、`R` に零因子が無いことは使わない。

住処: 一般の可換環と ℚ。実数体・複素数体は現れない。
-/
import Ising2DLambda.NecSuf.KacWard.RootOfUnityInverseRealClosedConjugate
import Mathlib.Algebra.Ring.Rat
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Linarith

namespace Ising2DLambda.NecSuf.KacWard

variable {R K : Type*} [CommRing R] [CommRing K]

/-- 五行: `2 − ϖ − ϖ' = 2 − (ια+ιβω) − (ια−ιβω) = 2 − 2ια = 1 − 2ια + ι(α²+β²) = ι((1−α)²+β²) = ι(c·c)`。 -/
theorem two_sub_mode_sub_inv_eq_square_necSuf (ι : R →+* K) (ω : K)
    (sum_is_square : ∀ u v : R, ∃ c : R, u * u + v * v = c * c)
    (z z' : K) (a b : R) (h : z = ι a + ι b * ω) (h' : z' = ι a - ι b * ω)
    (hN : a * a + b * b = 1) :
    ∃ c : R, 2 - z - z' = ι (c * c) := by
  obtain ⟨c, hc⟩ := sum_is_square (1 - a) b
  refine ⟨c, ?_⟩
  calc 2 - z - z' = 2 - (ι a + ι b * ω) - (ι a - ι b * ω) := by rw [h, h']
    _ = 2 - 2 * ι a := by ring
    _ = 1 - 2 * ι a + ι (a * a + b * b) := by rw [hN, map_one]; ring
    _ = ι ((1 - a) * (1 - a) + b * b) := by simp only [map_add, map_mul, map_sub, map_one]; ring
    _ = ι (c * c) := by rw [hc]

/-- `(q+1)(q+1) = q²+2q+1 = p+2 = 2` は有理数の平方が 2 にならないことに反するので `p ≠ 0`。 -/
theorem selfDual_rational_ne_zero_necSuf (noSquareTwo : ∀ t : ℚ, t * t ≠ 2) (q : ℚ) :
    q ^ 2 + 2 * q - 1 ≠ 0 := by
  intro hp
  apply noSquareTwo (q + 1)
  calc (q + 1) * (q + 1) = q ^ 2 + 2 * q + 1 := by ring
    _ = (q ^ 2 + 2 * q - 1) + 2 := by ring
    _ = 2 := by rw [hp]; ring

theorem dispersion_positive_at_rationalPoint_necSuf [Nontrivial R] (ι : R →+* K) (j : ℚ →+* R)
    (ω : K)
    (sum_is_square : ∀ u v : R, ∃ c : R, u * u + v * v = c * c)
    (pos_rat : ∀ r : ℚ, 0 < r → sqLt (0 : R) (j r))
    (noSquareTwo : ∀ t : ℚ, t * t ≠ 2)
    (z z' w w' : K) (a b c d : R)
    (hz : z = ι a + ι b * ω) (hz' : z' = ι a - ι b * ω) (hab : a * a + b * b = 1)
    (hw : w = ι c + ι d * ω) (hw' : w' = ι c - ι d * ω) (hcd : c * c + d * d = 1)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    ∃ D : R,
      ι D = (1 + ι (j q) ^ 2) ^ 2 - ι (j q) * (1 - ι (j q) ^ 2) * (z + z' + w + w') ∧
      sqLt 0 (j (q ^ 2 + 2 * q - 1) * j (q ^ 2 + 2 * q - 1)) ∧
      (sqLt (j (q ^ 2 + 2 * q - 1) * j (q ^ 2 + 2 * q - 1)) D ∨
        j (q ^ 2 + 2 * q - 1) * j (q ^ 2 + 2 * q - 1) = D) := by
  obtain ⟨cz, hcz⟩ := two_sub_mode_sub_inv_eq_square_necSuf ι ω sum_is_square z z' a b hz hz' hab
  obtain ⟨cw, hcw⟩ := two_sub_mode_sub_inv_eq_square_necSuf ι ω sum_is_square w w' c d hw hw' hcd
  obtain ⟨e, he⟩ := sum_is_square cz cw
  have hr : 0 < q * (1 - q) * (1 + q) := by
    have h1 : 0 < 1 - q := by linarith
    have h2 : 0 < 1 + q := by linarith
    positivity
  obtain ⟨s, hs0, hs⟩ := pos_rat _ hr
  -- q(1−q²) = q(1−q)(1+q) = r = s·s
  have hqs : ι (j q) * (1 - ι (j q) ^ 2) = ι (s * s) := by
    calc ι (j q) * (1 - ι (j q) ^ 2) = ι (j (q * (1 - q) * (1 + q))) := by
          simp only [map_mul, map_sub, map_add, map_one]; ring
      _ = ι (s * s) := by rw [← hs, sub_zero]
  set p : ℚ := q ^ 2 + 2 * q - 1 with hpdef
  have hpK : ι (j p) = ι (j q) ^ 2 + 2 * ι (j q) - 1 := by
    rw [hpdef]; simp only [map_sub, map_add, map_mul, map_pow, map_one, map_ofNat]
  -- Δ(q) − p·p の四行（正値分解の評価から始める）
  have hmain : ((1 + ι (j q) ^ 2) ^ 2 - ι (j q) * (1 - ι (j q) ^ 2) * (z + z' + w + w'))
      - ι (j p) * ι (j p) = ι ((s * e) * (s * e)) := by
    calc ((1 + ι (j q) ^ 2) ^ 2 - ι (j q) * (1 - ι (j q) ^ 2) * (z + z' + w + w'))
          - ι (j p) * ι (j p)
        = ι (j q) * (1 - ι (j q) ^ 2) * ((2 - z - z') + (2 - w - w')) := by rw [hpK]; ring
      _ = ι (s * s) * (ι (cz * cz) + ι (cw * cw)) := by rw [hqs, hcz, hcw]
      _ = ι (s * s) * ι (e * e) := by rw [← he, map_add]
      _ = ι ((s * e) * (s * e)) := by rw [← map_mul]; ring_nf
  have hp0 : p ≠ 0 := selfDual_rational_ne_zero_necSuf noSquareTwo q
  -- `j p · j p⁻¹ = j (p p⁻¹) = j 1 = 1` なので、`j p = 0` なら `0 = 1`（非自明性に反する）。
  have hjp0 : j p ≠ 0 := by
    intro h
    apply zero_ne_one (α := R)
    calc (0 : R) = j p * j p⁻¹ := by rw [h, zero_mul]
      _ = j (p * p⁻¹) := (map_mul j p p⁻¹).symm
      _ = j 1 := by rw [mul_inv_cancel₀ hp0]
      _ = 1 := map_one j
  refine ⟨j p * j p + (s * e) * (s * e), ?_, ⟨j p, hjp0, by ring⟩, ?_⟩
  · rw [map_add, ← hmain, map_mul]; ring
  · by_cases hse : s * e = 0
    · right; rw [hse]; ring
    · left; exact ⟨s * e, hse, by ring⟩

end Ising2DLambda.NecSuf.KacWard

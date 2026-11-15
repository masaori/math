/-
「分散因子の積分の Onsager 表示への書換え」の書換えの段の必要十分版。

具体版と同じ手順（`E(−2K) = E(lg r) = r`、`E(2K) = (E(−2K))⁻¹ = r⁻¹`、cosh・sinh の三行ずつ、
`B = 4r²(…) = 4r²H`、`B > 0` と `4r² > 0` から `H > 0`、`lg(4r²)` の四行、
積分の線型性と面積、`n·area = ½` による六行）を、次の仮定だけで行う。

- `K`: 線型順序体（実数体にあたる）。順序は `4r² > 0` と `H > 0` の取り出しで、体は `r⁻¹` と
  `c, s` の分母で使う。完備性・位相は使わない。
- `r : K`、`0 < r`（`ι_{ℚ→ℝ}(q)` にあたる）。`r < 1` は使わない（具体版では `B > 0` を引くときにだけ要る）。
- `lg : K → K` は正の元の上で積を和へ送る（実対数にあたる）。単調性・連続性は使わない。
- `E : K → K` は `E(lg u) = u`（`u > 0`）と `E(−t) = (E t)⁻¹` を満たす（指数にあたる）。
  加法を積へ送る一般の指数法則は使わない。
- `c₁, c₂ : X → K`（実余弦にあたる）。性質は使わない。`B = (1+r²)² − 2r(1−r²)(c₁+c₂)` の正値性
  `hB` だけを仮定する（具体版は `claim_dispersion_angle_log_continuous` の具体版から得る）。
- `I : (X → K) → K` と述語 `Adm`（二重積分と可積分性にあたる）。`Adm` な `g` について
  `I(a + g) = area·a + I g` だけを使い、`lg ∘ H` が `Adm` であること `hadm` を仮定する。
  加法一般・単調性・測度は使わない。`n·area = ½`（`n = 1/8π²`、`area = 4π²`）を仮定する。
-/
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.RealEscape

variable {K X : Type*} [Field K] [LinearOrder K] [IsStrictOrderedRing K]

/-- `B(x) := (1+r²)² − 2r(1−r²)(c₁(x)+c₂(x))`。 -/
def onsagerDispersionArgumentNecSuf (r : K) (c₁ c₂ : X → K) (x : X) : K :=
  (1 + r ^ 2) ^ 2 - 2 * r * (1 - r ^ 2) * (c₁ x + c₂ x)

/-- `H(x) := c² − s(c₁(x)+c₂(x))`、`c := (1+r²)/(2r)`、`s := (1−r²)/(2r)`。 -/
def onsagerHyperbolicArgumentNecSuf (r : K) (c₁ c₂ : X → K) (x : X) : K :=
  ((1 + r ^ 2) / (2 * r)) ^ 2 - (1 - r ^ 2) / (2 * r) * (c₁ x + c₂ x)

/-- `B = 4r²(…) = 4r²H`。体の四則と `r ≠ 0`、`2 ≠ 0` を使う（`2 ≠ 0` は順序体であることから得る。
標数 2 の体では `c, s` の分母が零になるので、この仮定は削れない）。 -/
theorem onsagerDispersionArgument_eq_necSuf (r : K) (hr : r ≠ 0) (c₁ c₂ : X → K) (x : X) :
    onsagerDispersionArgumentNecSuf r c₁ c₂ x =
      4 * r ^ 2 * onsagerHyperbolicArgumentNecSuf r c₁ c₂ x := by
  have h2 : (2 : K) ≠ 0 := two_ne_zero
  calc onsagerDispersionArgumentNecSuf r c₁ c₂ x
      = (1 + r ^ 2) ^ 2 - 2 * r * (1 - r ^ 2) * (c₁ x + c₂ x) := rfl
    _ = 4 * r ^ 2 * ((1 + r ^ 2) ^ 2 / (4 * r ^ 2)
          - (1 - r ^ 2) / (2 * r) * (c₁ x + c₂ x)) := by
        field_simp; ring
    _ = 4 * r ^ 2 * onsagerHyperbolicArgumentNecSuf r c₁ c₂ x := by
        unfold onsagerHyperbolicArgumentNecSuf
        rw [div_pow, mul_pow]; ring

/-- 必要十分版の本体。 -/
theorem onsager_hyperbolic_integral_rewrite_necSuf
    (r : K) (hr0 : 0 < r)
    (lg : K → K) (hlg : ∀ u v : K, 0 < u → 0 < v → lg (u * v) = lg u + lg v)
    (E : K → K) (hE : ∀ u : K, 0 < u → E (lg u) = u) (hEneg : ∀ t : K, E (-t) = (E t)⁻¹)
    (c₁ c₂ : X → K) (hB : ∀ x, 0 < onsagerDispersionArgumentNecSuf r c₁ c₂ x)
    (I : (X → K) → K) (Adm : (X → K) → Prop) (area n : K)
    (hI : ∀ (a : K) (g : X → K), Adm g → I (fun x => a + g x) = area * a + I g)
    (hadm : Adm (fun x => lg (onsagerHyperbolicArgumentNecSuf r c₁ c₂ x)))
    (hn : n * area = 1 / 2) :
    (E (2 * (-(1 / 2) * lg r)) + E (-(2 * (-(1 / 2) * lg r)))) / 2 = (1 + r ^ 2) / (2 * r) ∧
      (E (2 * (-(1 / 2) * lg r)) - E (-(2 * (-(1 / 2) * lg r)))) / 2 = (1 - r ^ 2) / (2 * r) ∧
      (∀ x, 0 < onsagerHyperbolicArgumentNecSuf r c₁ c₂ x) ∧
      n * I (fun x => lg (onsagerDispersionArgumentNecSuf r c₁ c₂ x)) =
        lg 2 + lg r + n * I (fun x => lg (onsagerHyperbolicArgumentNecSuf r c₁ c₂ x)) := by
  have hr : r ≠ 0 := ne_of_gt hr0
  set k : K := -(1 / 2) * lg r
  -- E(−2K) = E(lg r) = r
  have hEm : E (-(2 * k)) = r := by
    calc E (-(2 * k)) = E (lg r) := by simp only [k]; ring_nf
      _ = r := hE r hr0
  -- E(2K) = (E(−2K))⁻¹ = r⁻¹
  have hEp : E (2 * k) = r⁻¹ := by
    calc E (2 * k) = (E (-(2 * k)))⁻¹ := by rw [hEneg, inv_inv]
      _ = r⁻¹ := by rw [hEm]
  have hcosh : (E (2 * k) + E (-(2 * k))) / 2 = (1 + r ^ 2) / (2 * r) := by
    calc (E (2 * k) + E (-(2 * k))) / 2 = (r⁻¹ + r) / 2 := by rw [hEp, hEm]
      _ = (1 + r ^ 2) / (2 * r) := by field_simp
  have hsinh : (E (2 * k) - E (-(2 * k))) / 2 = (1 - r ^ 2) / (2 * r) := by
    calc (E (2 * k) - E (-(2 * k))) / 2 = (r⁻¹ - r) / 2 := by rw [hEp, hEm]
      _ = (1 - r ^ 2) / (2 * r) := by field_simp
  have h4 : 0 < 4 * r ^ 2 := by positivity
  -- B > 0 と 4r² > 0 から H > 0
  have hH : ∀ x, 0 < onsagerHyperbolicArgumentNecSuf r c₁ c₂ x := by
    intro x
    have h := hB x
    rw [onsagerDispersionArgument_eq_necSuf r hr] at h
    exact pos_of_mul_pos_right h h4.le
  -- lg(4r²) の四行
  have hlog4 : lg (4 * r ^ 2) = 2 * lg 2 + 2 * lg r := by
    calc lg (4 * r ^ 2) = lg 4 + lg (r ^ 2) := hlg 4 (r ^ 2) (by norm_num) (by positivity)
      _ = lg (2 * 2) + lg (r ^ 2) := by norm_num
      _ = 2 * lg 2 + lg (r ^ 2) := by rw [hlg 2 2 two_pos two_pos]; ring
      _ = 2 * lg 2 + 2 * lg r := by rw [sq, hlg r r hr0 hr0]; ring
  refine ⟨hcosh, hsinh, hH, ?_⟩
  -- 直前の恒等式 B = 4r²H と積法則
  have hpt : (fun x => lg (onsagerDispersionArgumentNecSuf r c₁ c₂ x)) =
      fun x => lg (4 * r ^ 2) + lg (onsagerHyperbolicArgumentNecSuf r c₁ c₂ x) := by
    funext x
    rw [onsagerDispersionArgument_eq_necSuf r hr, hlg _ _ h4 (hH x)]
  calc n * I (fun x => lg (onsagerDispersionArgumentNecSuf r c₁ c₂ x))
      = n * I (fun x => lg (4 * r ^ 2) + lg (onsagerHyperbolicArgumentNecSuf r c₁ c₂ x)) := by
        rw [hpt]
    _ = n * area * lg (4 * r ^ 2) + n * I (fun x => lg (onsagerHyperbolicArgumentNecSuf r c₁ c₂ x)) := by
        rw [hI _ _ hadm]; ring
    _ = 1 / 2 * lg (4 * r ^ 2) + n * I (fun x => lg (onsagerHyperbolicArgumentNecSuf r c₁ c₂ x)) := by
        rw [hn]
    _ = 1 / 2 * (2 * lg 2 + 2 * lg r) + n * I (fun x => lg (onsagerHyperbolicArgumentNecSuf r c₁ c₂ x)) := by
        rw [hlog4]
    _ = lg 2 + lg r + n * I (fun x => lg (onsagerHyperbolicArgumentNecSuf r c₁ c₂ x)) := by
        ring

end Ising2DLambda.NecSuf.RealEscape

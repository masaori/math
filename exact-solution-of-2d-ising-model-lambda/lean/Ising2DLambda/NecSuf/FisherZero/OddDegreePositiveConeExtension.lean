/-
節「奇数次の元を付け足しても正錐は延長できる」の必要十分版。

具体版と同じ段（`T := Sq(C; E)` は前錐 → `-1 ∉ T` → 列挙に沿った増大列の和集合 `T_∞` →
`T_∞` から零元を除いた集合が延長）で示し、各段が実際に使う性質だけを仮定に置く。

- 台は体（`Type`）。`-1 ∉ T` の段（`oddDegree_weightedSquareSum_ne_neg_one_necSuf`）と、
  零元を除く段（`coveringPrecone_extendsPositiveConeOn_necSuf`）が体を要する。
- 係数の集合 `S`・写像 `deg`・証人 `hspec`・最小性 `hmin`・根の存在 `hroot` は、`-1 ∉ T` の段にだけ渡す。
- 正錐 `C` は `IsPositiveConeOn S C` で受ける。延長の結論の成分として要り、`-1 ∉ T` の段が使う
  単位元を含むこと・零元を含まないこと・零でない元の平方を含むことは、ここから出す
  （具体版の前段 `mul_self_mem_of_isSubfieldPositiveCone` と同じ段）。
- 値の全体 `E` は、`hEV` で値の集合 `{f.eval α}` と同じ元を持つ集合として受ける。
  `S ⊆ E`、零元・単位元を含むことは `hEV` と定数多項式から出す。
  和・積・符号反転で閉じること（増大列の段）と零でない元の逆元で閉じること（零元を除く段）は仮定に置く。
- 列挙 `ξ` は `E` の各元を値に取れば足りる（台全体への全射は要らない）。
台の可算性・代数閉性そのものは要らない（根の存在 `hroot` だけを使う）。
-/
import Ising2DLambda.NecSuf.FisherZero.OddDegreeWeightedSquareSumAvoidsMinusOne
import Ising2DLambda.NecSuf.FisherZero.PositiveWeightedSquareSums
import Ising2DLambda.NecSuf.FisherZero.EnumeratedPreconeChain
import Ising2DLambda.NecSuf.FisherZero.CoveringPreconePositiveCone

namespace Ising2DLambda.NecSuf.FisherZero

open Polynomial

/-- 主張（具体版 `oddDegree_positiveCone_extension` と同じ段）。 -/
theorem oddDegree_positiveCone_extension_necSuf {K : Type} [Field K] (S C E : Set K)
    (h0 : (0 : K) ∈ S) (h1S : (1 : K) ∈ S) (hadd : ∀ a b : K, a ∈ S → b ∈ S → a + b ∈ S)
    (hsub : ∀ a b : K, a ∈ S → b ∈ S → a - b ∈ S) (hmul : ∀ a b : K, a ∈ S → b ∈ S → a * b ∈ S)
    (hdiv : ∀ a b : K, a ∈ S → b ∈ S → a / b ∈ S)
    (hC : IsPositiveConeOn S C) (deg : K → ℕ)
    (hspec : ∀ β : K, ∃ p : K[X], (∀ k : ℕ, p.coeff k ∈ S) ∧ p ≠ 0 ∧
      (∀ k : ℕ, deg β < k → p.coeff k = 0) ∧ p.eval β = 0)
    (hmin : ∀ (β : K) (d : ℕ) (q : K[X]), (∀ k : ℕ, q.coeff k ∈ S) → q ≠ 0 →
      (∀ k : ℕ, d < k → q.coeff k = 0) → q.eval β = 0 → deg β ≤ d)
    (hroot : ∀ (f : K[X]) (n : ℕ), (∀ k : ℕ, f.coeff k ∈ S) → 1 ≤ n → f.coeff n ≠ 0 →
      ∃ β : K, f.eval β = 0)
    (α : K) (hodd : Odd (deg α))
    (hEV : ∀ y : K, y ∈ E ↔ ∃ f : K[X], (∀ k : ℕ, f.coeff k ∈ S) ∧ f.eval α = y)
    (hEadd : ∀ x y : K, x ∈ E → y ∈ E → x + y ∈ E)
    (hEmul : ∀ x y : K, x ∈ E → y ∈ E → x * y ∈ E)
    (hEneg : ∀ x : K, x ∈ E → -x ∈ E)
    (hEinv : ∀ z : K, z ∈ E → z ≠ 0 → z⁻¹ ∈ E)
    (ξ : ℕ → K) (hξ : ∀ z : K, z ∈ E → ∃ n : ℕ, ξ n = z) :
    ∃ Cα : Set K, ExtendsPositiveConeOn S E C Cα := by
  -- S ⊆ E: 定数多項式 Polynomial.C a の値。
  have hSE : ∀ a : K, a ∈ S → a ∈ E := by
    intro a ha
    refine (hEV a).mpr ⟨Polynomial.C a, fun k => ?_, Polynomial.eval_C⟩
    rw [Polynomial.coeff_C]
    split_ifs
    · exact ha
    · exact h0
  have hE0 : (0 : K) ∈ E := hSE 0 h0
  have hE1 : (1 : K) ∈ E := hSE 1 h1S
  -- 正錐から: 零でない元の平方、単位元、零元を含まないこと。
  have hsq : ∀ a : K, a ∈ S → a ≠ 0 → a * a ∈ C := fun a ha ha0 =>
    mul_self_mem_of_cover_necSuf C hC.mul_mem a (hC.trichotomy a ha).1 ha0
  have h1C : (1 : K) ∈ C := by
    have h := hsq 1 h1S one_ne_zero
    rw [mul_one] at h
    exact h
  have h0C : (0 : K) ∉ C := fun h => (hC.trichotomy 0 (hC.subset 0 h)).2.1 ⟨rfl, h⟩
  -- T := Sq(C; E) は前錐。
  have hT : IsPreconeOn E C (weightedSquareSums E C) :=
    weightedSquareSums_isPreconeOn_necSuf E C hE0 hE1 hEadd hEmul
      (fun c hc => hSE c (hC.subset c hc)) h1C hC.mul_mem
  -- -1 ∉ T。
  have hEeq : E = {y | ∃ f : K[X], (∀ k : ℕ, f.coeff k ∈ S) ∧ f.eval α = y} := Set.ext hEV
  have hneg : (-1 : K) ∉ weightedSquareSums E C := by
    rw [hEeq]
    exact oddDegree_weightedSquareSum_ne_neg_one_necSuf S C h0 h1S hadd hsub hmul hdiv
      hC.add_mem hC.mul_mem h1C h0C hC.subset hsq deg hspec hmin hroot (deg α) α rfl hodd
  -- T_∞ の三つの結論。
  obtain ⟨hT', hneg', hcov⟩ :=
    chainUnion_covers_signs_necSuf E C (weightedSquareSums E C) hE0 hE1 hEadd hEmul hEneg
      hT hneg ξ hξ
  -- T_∞ から零元を除いた集合が延長。
  exact ⟨nonzeroPart (chainUnion E (weightedSquareSums E C) ξ),
    coveringPrecone_extendsPositiveConeOn_necSuf S E C _ hE0 hEinv hSE hC hT' hneg' hcov⟩

end Ising2DLambda.NecSuf.FisherZero

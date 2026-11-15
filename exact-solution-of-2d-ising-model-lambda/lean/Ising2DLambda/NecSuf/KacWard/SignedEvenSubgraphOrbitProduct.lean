import Mathlib

/-!
「符号付き偶部分グラフ多項式の軌道ごとの明示積」（`claim_signed_even_subgraph_orbit_product`）の
定数項と一意性の段の必要十分版。

具体版 `Ising2DLambda.KacWard.orbitExplicitProduct_eq_signedEvenSubgraphPolynomial` と同じ手順
（定数項の式鎖: 定義 → 有限積の定数項は各因子の定数項の積 → `F_O` の定数項は一 → `Δ_O` の定数項は一。
続いて平方根の一意性で `P = S`）を、次の仮定だけで行う。`S = Q` の一行は具体版の対象についての等式なので、
導出版で合成する。

* 値の型 `R` は可換モノイドであればよい（有限積を取るため）。加法・零は使わない。
* 定数項 `c : R →* K` は単位元と積を保つ写像であればよい。`K` は可換モノイド。
  積を保たないと二行目が成り立たず、単位元を保たないと空積の定数項が一にならない。
* `hF`（`c(F_O) = 1`）と `hg`（`c(Δ_O) = 1`）が無いと、定数項は一にならない。
* `hsq`（`P · P = D`。平方の段の結論）と、平方根 `S` の二条件 `hS1`・`hSD` が無いと、`P` と `S` は同じ多項式の平方根にならない。
* `huniq`（定数項一の平方根の一意性）が無いと `P = S` が出ない。
-/

namespace Ising2DLambda.NecSuf.KacWard

/-- 必要十分版: `P := ∏_{A} F · ∏_{B} g · ∏_{C} g^2` の定数項は一で、`P · P = D` なら、
`D` の定数項一の平方根 `S` に等しい。 -/
theorem orbit_explicit_product_eq_squareRoot_necSuf {β R K : Type*} [CommMonoid R] [CommMonoid K]
    (c : R →* K) (A B C : Finset β) (F g : β → R) (D S : R)
    (hF : ∀ O ∈ A, c (F O) = 1) (hg : ∀ O, c (g O) = 1)
    (hsq : ((∏ O ∈ A, F O) * (∏ O ∈ B, g O) * (∏ O ∈ C, g O ^ 2)) *
      ((∏ O ∈ A, F O) * (∏ O ∈ B, g O) * (∏ O ∈ C, g O ^ 2)) = D)
    (hS1 : c S = 1) (hSD : S * S = D)
    (huniq : ∀ T U : R, c T = 1 → c U = 1 → T * T = U * U → T = U) :
    (∏ O ∈ A, F O) * (∏ O ∈ B, g O) * (∏ O ∈ C, g O ^ 2) = S := by
  have hc : c ((∏ O ∈ A, F O) * (∏ O ∈ B, g O) * (∏ O ∈ C, g O ^ 2)) = 1 := by
    calc c ((∏ O ∈ A, F O) * (∏ O ∈ B, g O) * (∏ O ∈ C, g O ^ 2))
        = (∏ O ∈ A, c (F O)) * (∏ O ∈ B, c (g O)) * (∏ O ∈ C, c (g O) ^ 2) := by
          -- 有限積の定数項は各因子の定数項の積
          rw [map_mul, map_mul, map_prod, map_prod, map_prod]
          simp only [map_pow]
      _ = (∏ O ∈ B, c (g O)) * (∏ O ∈ C, c (g O) ^ 2) := by
          -- `F_O` の定数項は一
          rw [Finset.prod_congr rfl hF, Finset.prod_const_one, one_mul]
      _ = 1 := by
          -- `Δ_O` の定数項は一
          simp only [hg, one_pow, Finset.prod_const_one, mul_one]
  exact huniq _ _ hc hS1 (hsq.trans hSD.symm)

end Ising2DLambda.NecSuf.KacWard

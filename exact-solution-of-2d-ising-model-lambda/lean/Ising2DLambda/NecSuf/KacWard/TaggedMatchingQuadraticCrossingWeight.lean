/-
「非零項の位相は補辺の二次符号と短い対の横断数に等しい」（`claim_tagged_matching_quadratic_crossing_weight`）の
必要十分版。具体版 `taggedMatchingTerm_quadraticCrossingWeight` と同じ手順（閉路ごとの因子の置き換え →
有限積の分配と冪の指数の和 → 閉路族の二次符号の積 → 横断対の分割 → 台の個数）で組み立てる。

仮定に残した構造と、それが要る理由:
- 係数側 `K` と多項式側 `R` は可換環: 閉路の因子 `−φ_i` と `(−1)` の冪を書くのに加法逆元が要り、
  有限積を添字の順に依らず読むのに可換性が要る。
- `C : K →+* R`（具体版の定数多項式）: 係数の積を多項式の積へ移す段（`map_prod`）で積を保つことを使う。
- 閉路の族 `s` は有限集合: 本文の閉路集合 `𝒞(D,T)` は有限であり、積と和はその上の有限積・有限和である。
具体版の閉路の実体（交互閉路・閉歩道・横断数）と、二次符号が `±1` であることは使わない。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 必要十分版: 非零項 `M` が閉路ごとの `−X^{k_i} C(φ_i)` の積で、各閉路で `−φ_i = ψ_i`、
    閉路族で `Π_i ψ_i = χ (−1)^n`、横断対の分割 `t = n`、台の非交和 `p = Σ_i k_i` なら、
    `M = C(χ (−1)^t) X^p`。 -/
theorem tagged_matching_quadratic_crossing_weight_necSuf {K R ι : Type*} [CommRing K] [CommRing R]
    (C : K →+* R) (X : R) (s : Finset ι) (k : ι → ℕ) (φ ψ : ι → K) (χ : K) (n tcount p : ℕ) (M : R)
    (hterm : M = ∏ i ∈ s, -(X ^ k i) * C (φ i))
    (hcycle : ∀ i ∈ s, -φ i = ψ i)
    (hfam : ∏ i ∈ s, ψ i = χ * (-1) ^ n)
    (hsplit : tcount = n)
    (hcard : p = ∑ i ∈ s, k i) :
    M = C (χ * (-1) ^ tcount) * X ^ p := by
  calc M = ∏ i ∈ s, -(X ^ k i) * C (φ i) := hterm
    -- 各閉路の因子を置き換える
    _ = ∏ i ∈ s, X ^ k i * C (ψ i) := by
        refine Finset.prod_congr rfl fun i hi => ?_
        rw [← hcycle i hi, map_neg]
        ring
    -- 有限積の分配律、X の冪の積は指数の和の冪、C は積を保つ
    _ = X ^ (∑ i ∈ s, k i) * C (∏ i ∈ s, ψ i) := by
        rw [Finset.prod_mul_distrib, Finset.prod_pow_eq_pow_sum, map_prod]
    -- 閉路族の二次符号の積、横断対の分割、台の非交和
    _ = X ^ p * C (χ * (-1) ^ tcount) := by
        rw [hfam, hsplit, hcard]
    _ = C (χ * (-1) ^ tcount) * X ^ p := mul_comm _ _

end Ising2DLambda.NecSuf.KacWard

/-
具体版が必要十分版の特殊化として得られることの導出。

具体版では `M := Qbar`、`μn := RootOfUnity n` とし、除法の分解を `Nat.div_add_mod` から、
鎖の 4 法則を `Qbar` のモノイドの法則から、境界 `hbound` を有限性
（`rootOfUnityFiniteCardLe`）・指数 `r` の上界（`rootOfUnitySubsetCardLe`。ここでだけ
`1 ≤ r` が要る）・個数の値（`rootOfUnityCardEq`）の組み立てから供給する。
ここで `Qbar` の体・代数閉性は使わない。

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerNotOneExists
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootOfUnityPowerNotOneExists

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化である。 -/
theorem rootOfUnityPowerNotOneExists_from_necSuf {n m : ℕ} (hn : 1 ≤ n)
    (hndvd : ¬ n ∣ m) :
    ∃ w ∈ RootOfUnity n, w ^ m ≠ 1 := by
  classical
  have hr1 : 1 ≤ m % n := by
    rcases Nat.eq_zero_or_pos (m % n) with h0 | hpos
    · exact absurd (Nat.dvd_of_mod_eq_zero h0) hndvd
    · exact hpos
  obtain ⟨hfin, _⟩ := rootOfUnityFiniteCardLe n hn
  exact NecSuf.AlgebraicEigenvalue.power_not_one_exists_necSuf
    (Nat.div_add_mod m n).symm
    (Nat.mod_lt m hn)
    one_mul
    (fun k => one_pow k)
    (fun w a b => pow_mul w a b)
    (fun w a b => pow_add w a b)
    (fun w hw => hw)
    (fun hall => by
      -- 境界の供給。μ_n の Finset 化に指数 m % n の上界を当て、個数の値で n へ書き換える。
      have hsub : ∀ w ∈ hfin.toFinset, w ^ (m % n) = 1 := fun w hw =>
        hall w (hfin.mem_toFinset.mp hw)
      have hle : hfin.toFinset.card ≤ m % n :=
        rootOfUnitySubsetCardLe (m % n) hr1 hfin.toFinset hsub
      have hcard : (RootOfUnity n).ncard = n := rootOfUnityCardEq n hn
      have hcard_toFinset : (RootOfUnity n).ncard = hfin.toFinset.card :=
        Set.ncard_eq_toFinset_card (RootOfUnity n) hfin
      omega)

end Ising2DLambda.AlgebraicEigenvalue

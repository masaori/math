/-
章「固有値の代数性」の「指数が根の次数の倍数でないとき、冪が 1 でない 1 の冪根が存在する」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張
`claim_root_of_unity_power_not_one_exists` に対応する。

  人手証明                                          このファイル
  準備（除法 m = nq + r、0 ≤ r < n）                `Nat.div_add_mod` と `Nat.mod_lt`
  準備（r ≠ 0。r = 0 なら n ∣ m で仮定に反する）    `Nat.dvd_of_mod_eq_zero` への場合分け
  背理法の仮定（すべての w で w^m = 1）             `by_contra` と `push_neg`
  鎖（w^r = 1·w^r = 1^q·w^r = (w^n)^q·w^r
      = w^{nq}·w^r = w^{nq+r} = w^m = 1）           `calc`（one_mul / one_pow / 根の条件 /
                                                    pow_mul / pow_add / 除法の等式 / 背理法の仮定）
  μ_n ⊆ μ_r と有限性から |μ_n| ≤ r                 `rootOfUnityFiniteCardLe` の Finite と
                                                    `rootOfUnitySubsetCardLe`（指数 r）
  |μ_n| = n                                        `rootOfUnityCardEq`
  n ≤ r < n の矛盾                                 `Nat.lt` の非反射性（omega）

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（元は ℚ の代数閉包の元、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityCard
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnitySubsetCardBound

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の本体。`n ≥ 1` で `n` が `m` を割り切らないならば、
`w ^ m ≠ 1` を満たす `w ∈ μ_n` が存在する
（`claim_root_of_unity_power_not_one_exists`）。 -/
theorem rootOfUnityPowerNotOneExists {n m : ℕ} (hn : 1 ≤ n) (hndvd : ¬ n ∣ m) :
    ∃ w ∈ RootOfUnity n, w ^ m ≠ 1 := by
  classical
  -- 準備。除法 m = n * q + r と 0 ≤ r < n。
  set q := m / n with hqdef
  set r := m % n with hrdef
  have hm : m = n * q + r := (Nat.div_add_mod m n).symm
  have hrlt : r < n := Nat.mod_lt m hn
  -- 準備。r ≠ 0（r = 0 なら n ∣ m となり仮定に反する）。
  have hr1 : 1 ≤ r := by
    rcases Nat.eq_zero_or_pos r with h0 | hpos
    · exact absurd (Nat.dvd_of_mod_eq_zero h0) hndvd
    · exact hpos
  -- 背理法。結論を否定すると、すべての w ∈ μ_n が w ^ m = 1 を満たす。
  by_contra hexists
  push_neg at hexists
  -- 鎖。すべての w ∈ μ_n について w ^ r = 1。
  have hpow_r : ∀ w ∈ RootOfUnity n, w ^ r = 1 := by
    intro w hw
    have hwn : w ^ n = 1 := hw
    calc w ^ r
        = 1 * w ^ r := (one_mul (w ^ r)).symm
          -- 第 1 段。積の単位元。
      _ = (1 : Qbar) ^ q * w ^ r := by rw [one_pow]
          -- 第 2 段。単位元の冪。
      _ = (w ^ n) ^ q * w ^ r := by rw [hwn]
          -- 第 3 段。根の条件 w ^ n = 1。
      _ = w ^ (n * q) * w ^ r := by rw [pow_mul]
          -- 第 4 段。冪の法則（指数の積）。
      _ = w ^ (n * q + r) := (pow_add w (n * q) r).symm
          -- 第 5 段。冪の法則（指数の和）。
      _ = w ^ m := by rw [← hm]
          -- 第 6 段。除法の等式 m = n * q + r。
      _ = 1 := hexists w hw
          -- 第 7 段。背理法の仮定。
  -- μ_n は有限（n ≥ 1）。
  obtain ⟨hfin, _⟩ := rootOfUnityFiniteCardLe n hn
  -- |μ_n| ≤ r。μ_n の元はすべて w ^ r = 1 を満たすので、指数 r の上界を当てる。
  have hsub : ∀ w ∈ hfin.toFinset, w ^ r = 1 := by
    intro w hw
    exact hpow_r w (hfin.mem_toFinset.mp hw)
  have hle : hfin.toFinset.card ≤ r := rootOfUnitySubsetCardLe r hr1 hfin.toFinset hsub
  -- |μ_n| = n。
  have hcard : (RootOfUnity n).ncard = n := rootOfUnityCardEq n hn
  have hcard_toFinset : (RootOfUnity n).ncard = hfin.toFinset.card :=
    Set.ncard_eq_toFinset_card (RootOfUnity n) hfin
  -- n ≤ r < n の矛盾。
  omega

end Ising2DLambda.AlgebraicEigenvalue

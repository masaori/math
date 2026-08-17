/-
章「零点の詰め寄り」の「自己双対点の平方根と臨界点は実閉部分体の元である」
（`claim_critical_point_mem_real_closed`）の具体版。

  人手証明                                                          このファイル
  第 4 条件で s = a + bω と一意表示                                  `data.unique_decomposition`
  展開と一意性で a·a - b·b = 1+1、a·b + a·b = 0                      `hx`, `hy`
  2 ≠ 0 と零因子の非存在から a = 0 または b = 0                      `hab0`
  b = 0 の枝: s = a ∈ R                                              `Or.inr` の枝
  a = 0 の枝: -(1+1) = b·b、b ≠ 0 は `neg_two_not_square_in_realClosed` に反する
  R は部分体なので x_c = -1 + s ∈ R                                  `criticalPoint_mem_realClosed`

`2` は `1 + 1` と書く（部分体の数値リテラルの型変換を避けるため。人手証明の `2 := 1+1` と同じ）。
住処: Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresIsSquare

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `s·s = 2` を満たす `s` は `R` の元である。 -/
theorem sqrtTwo_mem_realClosed (data : RealClosedSubfieldData) (s : Qbar)
    (hs : s * s = 2) : ∃ r : data.carrier, (r : Qbar) = s := by
  -- 第 4 条件で s = a + bω。
  obtain ⟨⟨a, b⟩, hab, _⟩ := data.unique_decomposition s
  -- 展開して 1+1 = (a·a - b·b) + (a·b + a·b)·ω。
  have hexp : ((1 + 1 : data.carrier) : Qbar) + ((0 : data.carrier) : Qbar) * data.omega
      = ((a * a - b * b : data.carrier) : Qbar)
        + ((a * b + a * b : data.carrier) : Qbar) * data.omega := by
    push_cast
    linear_combination (-1 : Qbar) * hs
      + (s + (a : Qbar) + (b : Qbar) * data.omega) * hab
      + ((b : Qbar) * (b : Qbar)) * data.omega_sq
  -- 一意性で成分を比べる。
  obtain ⟨cd, _, huniq⟩ :=
    data.unique_decomposition
      (((1 + 1 : data.carrier) : Qbar) + ((0 : data.carrier) : Qbar) * data.omega)
  have hxy : ((1 + 1, 0) : data.carrier × data.carrier)
      = (a * a - b * b, a * b + a * b) := by
    rw [huniq (1 + 1, 0) rfl, ← huniq (a * a - b * b, a * b + a * b) hexp]
  have hx : (1 + 1 : data.carrier) = a * a - b * b := congrArg Prod.fst hxy
  have hy : (0 : data.carrier) = a * b + a * b := congrArg Prod.snd hxy
  -- a·b = 0 なので a = 0 または b = 0。
  have hab0 : a = 0 ∨ b = 0 := by
    have h2 : (a * b : data.carrier) = 0 := by
      have hcast := congrArg (fun z : data.carrier => (z : Qbar)) hy
      push_cast at hcast
      have : (a : Qbar) * (b : Qbar) = 0 := by linear_combination -hcast / 2
      exact_mod_cast this
    exact mul_eq_zero.mp h2
  rcases hab0 with ha | hb
  · -- a = 0 の枝は起きない。
    exfalso
    refine neg_two_not_square_in_realClosed data ⟨b, ?_, ?_⟩
    · -- b ≠ 0（b = 0 なら 1+1 = 0 になる）。
      intro hb0
      rw [ha, hb0] at hx
      have hcast := congrArg (fun z : data.carrier => (z : Qbar)) hx
      push_cast at hcast
      norm_num at hcast
    · -- -(1+1) = b·b。
      rw [ha] at hx
      have : (1 + 1 : data.carrier) = -(b * b) := by
        rw [hx]; ring
      rw [this]; ring
  · -- b = 0 の枝: s = a。
    refine ⟨a, ?_⟩
    rw [hab, hb]
    push_cast
    ring

/-- 臨界点 `x_c = -1 + s` も `R` の元である（部分体の加法で閉じている）。 -/
theorem criticalPoint_mem_realClosed (data : RealClosedSubfieldData) (s : Qbar)
    (hs : s * s = 2) : ∃ r : data.carrier, (r : Qbar) = -1 + s := by
  obtain ⟨r, hr⟩ := sqrtTwo_mem_realClosed data s hs
  refine ⟨-1 + r, ?_⟩
  push_cast
  rw [hr]

end Ising2DLambda.FisherZero

/-
章「固有値の代数性」の「1 の冪根の全体にわたる冪の和は、1 の冪根の冪を掛けても動かない」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_root_of_unity_power_sum_invariant`）に対応する。

  人手証明                                          このファイル
  μ_n が有限集合であるという仮定                     `[Fintype (RootOfUnity n)]`
  S_{n,m} = Σ_{z ∈ μ_n} z^m                         `powerSum n m`
  第 2 の等号（積が有限和へ分配される）              `Finset.mul_sum`
  第 3 の等号（(wz)^m = w^m z^m）                    `qbarMul_pow`（`claim_qbar_mul_pow` の具体版）
  第 4 の等号（掛ける写像の定義）                     `mulMap` の定義そのもの（`rfl`）
  第 5 の等号（θ_w が全単射であることによる添字の取り替え）
                                                    `Fintype.sum_bijective` へ `mulMap_bijective`
  第 6 の等号（S の定義へ戻る）                       `powerSum` の定義そのもの

μ_n の有限性はここでも仮定であって、示していない（μ_n がちょうど n 個の元を持つことは別の段）。
mathlib の一般論（`Finset.sum_nbij`・群の指標和・`rootsOfUnity` の一般論等）へ委ねず、
人手証明の 6 段の鎖をそのまま書く。積の冪と全単射性は自前の `qbarMul_pow` /
`mulMap_bijective` を引く。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（元は ℚ の代数閉包の元、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityMulMap
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.BigOperators.Group.Finset.Defs

namespace Ising2DLambda.AlgebraicEigenvalue

open BigOperators

/-- 人手証明の `S_{n,m} = Σ_{z ∈ μ_n} z^m`。μ_n の有限性は仮定である。 -/
noncomputable def powerSum (n : ℕ) [Fintype (RootOfUnity n)] (m : ℕ) : Qbar :=
  ∑ z : RootOfUnity n, (z.1) ^ m

/-- 人手証明の本体。`n ≥ 1`・`w ∈ μ_n` のもとで `w^m S_{n,m} = S_{n,m}`
（`claim_root_of_unity_power_sum_invariant`）。 -/
theorem powerSum_mul_invariant {n : ℕ} (hn : 1 ≤ n) [Fintype (RootOfUnity n)]
    {w : Qbar} (hw : w ∈ RootOfUnity n) (m : ℕ) :
    w ^ m * powerSum n m = powerSum n m := by
  calc w ^ m * powerSum n m
      = ∑ z : RootOfUnity n, w ^ m * (z.1) ^ m := by
        -- 第 2 の等号。積が有限和へ分配される。
        rw [powerSum, Finset.mul_sum]
    _ = ∑ z : RootOfUnity n, (w * z.1) ^ m := by
        -- 第 3 の等号。(w z)^m = w^m z^m を各項へ。
        exact Finset.sum_congr rfl (fun z _ => (qbarMul_pow w z.1 m).symm)
    _ = ∑ z : RootOfUnity n, ((mulMap hw z).1) ^ m := rfl
        -- 第 4 の等号。掛ける写像の定義そのもの。
    _ = ∑ z : RootOfUnity n, (z.1) ^ m := by
        -- 第 5 の等号。θ_w が全単射であることによる添字の取り替え。
        exact Fintype.sum_bijective (mulMap hw) (mulMap_bijective hn hw)
          (fun z => ((mulMap hw z).1) ^ m) (fun z => (z.1) ^ m) (fun _ => rfl)
    _ = powerSum n m := rfl
        -- 第 6 の等号。S の定義へ戻る。

end Ising2DLambda.AlgebraicEigenvalue

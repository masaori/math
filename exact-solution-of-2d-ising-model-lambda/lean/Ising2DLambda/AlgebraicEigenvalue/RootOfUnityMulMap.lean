/-
章「固有値の代数性」の「1 の冪根を掛ける写像は全単射である」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（`def_root_of_unity_mul_map`）と主張 1 件（`claim_root_of_unity_mul_map_bijective`）に対応する。

  人手証明                                        このファイル
  定義 θ^{(n)}_w(z) = w z（行き先が μ_n）          `mulMap`（所属の証明に `rootOfUnity_mul`）
  準備 w^{n-1} ∈ μ_n                              `rootOfUnity_pow hw (n-1)`
  準備 w^{n-1} w = w^{(n-1)+1} = w^n = 1           `powPred_mul`（3 段の鎖）
  第 1 の往復 θ_{w^{n-1}}(θ_w(z)) = z              `mulMap_left`（5 段の鎖）
  第 2 の往復 θ_w(θ_{w^{n-1}}(z)) = z              `mulMap_right`（6 段の鎖。可換則を 1 度使う）
  単射性（第 1 の往復を 2 度当てる 3 段の鎖）        `mulMap_bijective` の第 1 成分
  全射性（第 2 の往復から像に属する）               `mulMap_bijective` の第 2 成分

mathlib の一般論（`Equiv.mulLeft`・`Group` の一般論・`rootsOfUnity` 等）へ委ねず、
人手証明の往復をそのまま書く。μ_n が積で閉じていることと冪が μ_n に入ることは、
自前の `rootOfUnity_mul` / `rootOfUnity_pow` を引く。

住処: 人手証明のこの 2 ブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（元は ℚ の代数閉包の元、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPow

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の定義。`w ∈ μ_n` を掛ける写像 `θ^{(n)}_w : μ_n → μ_n`
（`def_root_of_unity_mul_map`）。行き先が `μ_n` に収まることは `rootOfUnity_mul` による。 -/
noncomputable def mulMap {n : ℕ} {w : Qbar} (hw : w ∈ RootOfUnity n) :
    RootOfUnity n → RootOfUnity n :=
  fun z => ⟨w * z.1, rootOfUnity_mul hw z.2⟩

/-- 人手証明の準備。`n ≥ 1` と `w ∈ μ_n` のもとで `w^{n-1} w = 1`。 -/
theorem powPred_mul {n : ℕ} (hn : 1 ≤ n) {w : Qbar} (hw : w ∈ RootOfUnity n) :
    w ^ (n - 1) * w = 1 := by
  calc w ^ (n - 1) * w
      = w ^ (n - 1 + 1) := (pow_succ w (n - 1)).symm  -- 第 1 段。冪の約束 y^{j+1} = y^j y。
    _ = w ^ n := by rw [Nat.sub_add_cancel hn]        -- 第 2 段。n ≥ 1 より (n-1)+1 = n。
    _ = 1 := hw                                      -- 第 3 段。w ∈ μ_n。

/-- 人手証明の第 1 の往復。`θ_{w^{n-1}}(θ_w(z)) = z`。 -/
theorem mulMap_left {n : ℕ} (hn : 1 ≤ n) {w : Qbar} (hw : w ∈ RootOfUnity n)
    (z : RootOfUnity n) :
    mulMap (rootOfUnity_pow hw (n - 1)) (mulMap hw z) = z := by
  apply Subtype.ext
  show w ^ (n - 1) * (w * z.1) = z.1
  calc w ^ (n - 1) * (w * z.1)
      = (w ^ (n - 1) * w) * z.1 := (mul_assoc _ _ _).symm  -- 積の結合則。
    _ = 1 * z.1 := by rw [powPred_mul hn hw]               -- 準備の等式。
    _ = z.1 := one_mul _                                   -- 1 は積の単位元。

/-- 人手証明の第 2 の往復。`θ_w(θ_{w^{n-1}}(z)) = z`。可換則を 1 度使う。 -/
theorem mulMap_right {n : ℕ} (hn : 1 ≤ n) {w : Qbar} (hw : w ∈ RootOfUnity n)
    (z : RootOfUnity n) :
    mulMap hw (mulMap (rootOfUnity_pow hw (n - 1)) z) = z := by
  apply Subtype.ext
  show w * (w ^ (n - 1) * z.1) = z.1
  calc w * (w ^ (n - 1) * z.1)
      = (w * w ^ (n - 1)) * z.1 := (mul_assoc _ _ _).symm      -- 積の結合則。
    _ = (w ^ (n - 1) * w) * z.1 := by rw [mul_comm w (w ^ (n - 1))]  -- 積の可換則。
    _ = 1 * z.1 := by rw [powPred_mul hn hw]                   -- 準備の等式。
    _ = z.1 := one_mul _                                       -- 1 は積の単位元。

/-- 人手証明の本体。`n ≥ 1` と `w ∈ μ_n` のもとで `θ^{(n)}_w` は全単射である
（`claim_root_of_unity_mul_map_bijective`）。 -/
theorem mulMap_bijective {n : ℕ} (hn : 1 ≤ n) {w : Qbar} (hw : w ∈ RootOfUnity n) :
    Function.Bijective (mulMap hw) := by
  constructor
  · -- 単射性。第 1 の往復を 2 度当てる。
    intro z₁ z₂ h
    calc z₁ = mulMap (rootOfUnity_pow hw (n - 1)) (mulMap hw z₁) :=
          (mulMap_left hn hw z₁).symm
      _ = mulMap (rootOfUnity_pow hw (n - 1)) (mulMap hw z₂) := by rw [h]
      _ = z₂ := mulMap_left hn hw z₂
  · -- 全射性。第 2 の往復が原像を与える。
    intro z
    exact ⟨mulMap (rootOfUnity_pow hw (n - 1)) z, mulMap_right hn hw z⟩

end Ising2DLambda.AlgebraicEigenvalue

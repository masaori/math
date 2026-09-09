/-
# 必要十分版: 二乗が恒等写像である線型写像の固有値候補

対応する人手証明のラベル: `<epsilon_action_eigenvalues_are_signs>`。

具体的な複素行列、有限添字、全スピン反転行列は使わない。必要なのは、差と負元を
扱う係数環、スカラーの零積から因子を分ける整域性、非零スカラーが非零ベクトルを
零にしない無ねじれ加群、二回作用すると元へ戻る線型写像、非零固有ベクトルだけである。
係数の可換性は使わない。

具体版 `epsilon_action_eigenvalues_are_signs` との対応では、`hinvolution` が
単位行列の作用・`epsilon_mul_self`・行列作用の結合則をまとめた条件に、`map_smul` が
具体版で成分から示す `hmulVec_smul` に当たる。その後のスカラー計算は同じ順序で
一段ずつ対応する。
-/
import Mathlib.Algebra.Module.LinearMap.Basic
import Mathlib.Algebra.Module.Torsion.Free
import Mathlib.Tactic.NoncommRing

namespace Ising2D.NecSuf

/-- 二乗が恒等写像である線型写像の非零固有ベクトルに対応する固有値は
`1` または `-1` である。

仮定の用途は次のとおりである。`Ring K` は差と負元および平方差を扱うため、
`IsDomain K` はスカラーの積が零なら一方が零であることを使うため、
`Module.IsTorsionFree K V` は非零ベクトルに掛けて零になったスカラーを消すために要る。 -/
theorem eigenvalue_eq_one_or_neg_one_of_involution
    {K V : Type*} [Ring K] [IsDomain K]
    [AddCommGroup V] [Module K V] [Module.IsTorsionFree K V]
    (T : V →ₗ[K] V) (f : V) (lambda : K)
    (hf : f ≠ 0) (hinvolution : ∀ x, T (T x) = x)
    (heigen : T f = lambda • f) :
    lambda = 1 ∨ lambda = -1 := by
  have hvector : f = lambda ^ 2 • f := by
    calc
      f = T (T f) := (hinvolution f).symm -- 本文: `If=ε²f` と作用の結合則を対合性へ抽象化
      _ = T (lambda • f) := by rw [heigen] -- 本文: 内側の固有値方程式を代入
      _ = lambda • T f := by rw [map_smul] -- 本文: スカラー倍への線型性
      _ = lambda • (lambda • f) := by rw [heigen] -- 本文: 外側の固有値方程式を代入
      _ = (lambda * lambda) • f := by rw [smul_smul] -- 本文: スカラー倍の結合則
      _ = lambda ^ 2 • f := by rw [pow_two] -- 本文: 二乗の定義
  have hdifference : lambda ^ 2 • f - f = 0 := by
    rw [← hvector, sub_self] -- 本文: 固有ベクトル等式の両辺から `f` を引く
  have hexpansion :
      (lambda ^ 2 - 1) • f = lambda ^ 2 • f - (1 : K) • f := by
    exact sub_smul (lambda ^ 2) 1 f -- 本文: 分配律でスカラー差の作用を展開
  have honeSmul : lambda ^ 2 • f - (1 : K) • f = lambda ^ 2 • f - f := by
    simpa only [one_smul] -- 本文: 単位元の作用を簡約
  have hscaled : (lambda ^ 2 - 1) • f = 0 := by
    calc
      (lambda ^ 2 - 1) • f = lambda ^ 2 • f - (1 : K) • f := hexpansion
      _ = lambda ^ 2 • f - f := honeSmul
      _ = 0 := hdifference -- 本文: 直前の差が零であることを代入
  have hquadratic : lambda ^ 2 - 1 = 0 :=
    (smul_eq_zero.mp hscaled).resolve_right hf -- 本文: 非零ベクトルを無ねじれ性で消去
  have hfactorization : (lambda - 1) * (lambda + 1) = lambda ^ 2 - 1 := by
    noncomm_ring -- 本文: 平方差を因数分解
  have hfactor : (lambda - 1) * (lambda + 1) = 0 := by
    calc
      (lambda - 1) * (lambda + 1) = lambda ^ 2 - 1 := hfactorization
      _ = 0 := hquadratic -- 本文: 二次式が零であることを代入
  rcases mul_eq_zero.mp hfactor with hminus | hplus
  · exact Or.inl (sub_eq_zero.mp hminus) -- 本文: `lambda-1=0` を解く
  · exact Or.inr (add_eq_zero_iff_eq_neg.mp hplus) -- 本文: `lambda+1=0` を解く

end Ising2D.NecSuf

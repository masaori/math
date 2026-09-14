/-
# 全スピン反転行列の作用の固有値候補

対応する人手本文は `structured-latex/content/004_transfer_matrix.ts` の
`transfer_matrix_004c_claim_epsilon_action_eigenvalues`
（ラベル **`epsilon_action_eigenvalues_are_signs`**）。

本文と同じく、具体的な複素行列 `epsilon M` と非零数ベクトル `f` について、
`epsilon M *ᵥ f = lambda • f` と `epsilon M * epsilon M = 1` から
`lambda = 1 ∨ lambda = -1` を導く。固有空間の次元公式は扱わない。

必要十分版 `eigenvalue_eq_one_or_neg_one_of_involution` との対応では、
`hmulVec_assoc` と `epsilon_mul_self` と `honeMulVec` が対合性 `hinvolution` に、
`hmulVec_smul` が線型写像の `map_smul` に当たる。その後のスカラー計算は
同じ順序で一段ずつ対応する。
-/
import Ising2D.Part004.Definition000_TransferMatrixSymbols

namespace Ising2D

open Matrix

/-- **人手本文 `epsilon_action_eigenvalues_are_signs`**:
全スピン反転行列の非零固有ベクトルに対応する固有値は `1` または `-1` である。 -/
theorem epsilon_action_eigenvalues_are_signs
    (M : ℕ) (_hM : 1 ≤ M) (f : Conf M → ℂ) (lambda : ℂ)
    (hf : f ≠ 0) (heigen : epsilon M *ᵥ f = lambda • f) :
    lambda = 1 ∨ lambda = -1 := by
  have hmulVec_assoc
      (A B : Matrix (Conf M) (Conf M) ℂ) (g : Conf M → ℂ) :
      (A * B) *ᵥ g = A *ᵥ (B *ᵥ g) := by
    funext i
    calc
      ((A * B) *ᵥ g) i = ∑ k, (A * B) i k * g k := rfl -- 本文: 行列作用を成分和へ展開
      _ = ∑ k, (∑ l, A i l * B l k) * g k := by rfl -- 本文: 行列積を成分和へ展開
      _ = ∑ k, ∑ l, (A i l * B l k) * g k := by
        apply Finset.sum_congr rfl
        intro k _
        rw [Finset.sum_mul] -- 本文: ベクトル成分を内側の和へ分配
      _ = ∑ k, ∑ l, A i l * (B l k * g k) := by
        apply Finset.sum_congr rfl
        intro k _
        apply Finset.sum_congr rfl
        intro l _
        rw [mul_assoc] -- 本文: 各項の積の結合を変更
      _ = ∑ l, ∑ k, A i l * (B l k * g k) := Finset.sum_comm -- 本文: 有限二重和の順序を交換
      _ = ∑ l, A i l * (∑ k, B l k * g k) := by
        apply Finset.sum_congr rfl
        intro l _
        rw [Finset.mul_sum] -- 本文: 行列成分を有限和の外へ括り出す
      _ = (A *ᵥ (B *ᵥ g)) i := rfl -- 本文: 内側と外側の行列作用へ戻す
  have hmulVec_smul
      (A : Matrix (Conf M) (Conf M) ℂ) (mu : ℂ) (g : Conf M → ℂ) :
      A *ᵥ (mu • g) = mu • (A *ᵥ g) := by
    funext i
    calc
      (A *ᵥ (mu • g)) i = ∑ k, A i k * (mu * g k) := by
        rfl -- 本文: スカラー倍したベクトルへの作用を成分和へ展開
      _ = ∑ k, (A i k * mu) * g k := by
        apply Finset.sum_congr rfl
        intro k _
        rw [mul_assoc] -- 本文: 最初の二因子を先に掛ける
      _ = ∑ k, (mu * A i k) * g k := by
        apply Finset.sum_congr rfl
        intro k _
        rw [mul_comm (A i k) mu] -- 本文: 複素スカラーと行列成分を交換
      _ = ∑ k, mu * (A i k * g k) := by
        apply Finset.sum_congr rfl
        intro k _
        rw [mul_assoc] -- 本文: 交換後の積の結合を変更
      _ = mu * ∑ k, A i k * g k := by rw [Finset.mul_sum] -- 本文: スカラーを有限和の外へ括り出す
      _ = (mu • (A *ᵥ g)) i := rfl -- 本文: スカラー倍した行列作用へ戻す
  have honeMulVec : (1 : Matrix (Conf M) (Conf M) ℂ) *ᵥ f = f := by
    funext i
    calc
      ((1 : Matrix (Conf M) (Conf M) ℂ) *ᵥ f) i =
          ∑ k, (1 : Matrix (Conf M) (Conf M) ℂ) i k * f k := rfl -- 本文: 単位行列の作用を成分和へ展開
      _ = f i := by
        simp only [Matrix.one_apply]
        simp -- 本文: 単位行列の成分と複素数の 0, 1 の法則
  have hvector : f = lambda ^ 2 • f := by
    calc
      f = 1 *ᵥ f := honeMulVec.symm -- 本文: 直前に成分から示した `f=If`
      _ = (epsilon M * epsilon M) *ᵥ f := by rw [epsilon_mul_self] -- 本文: `If=epsilon^2f`
      _ = epsilon M *ᵥ (epsilon M *ᵥ f) := hmulVec_assoc _ _ _ -- 本文: 直前に成分から示した結合則
      _ = epsilon M *ᵥ (lambda • f) := by rw [heigen] -- 本文: 内側の固有値方程式を代入
      _ = lambda • (epsilon M *ᵥ f) := hmulVec_smul _ _ _ -- 本文: 直前に成分から示した複素線型性
      _ = lambda • (lambda • f) := by rw [heigen] -- 本文: 外側の固有値方程式を代入
      _ = (lambda * lambda) • f := by rw [smul_smul] -- 本文: 複素数倍の結合則
      _ = lambda ^ 2 • f := by rw [pow_two] -- 本文: 二乗の定義
  obtain ⟨j, hfj⟩ : ∃ j, f j ≠ 0 := by
    by_contra h
    apply hf
    funext j
    exact not_ne_iff.mp (fun hj => h ⟨j, hj⟩)
  have hcomponent : f j = lambda ^ 2 * f j := by
    simpa only [Pi.smul_apply, smul_eq_mul] using congrFun hvector j
  have hdifference : lambda ^ 2 * f j - f j = 0 := by
    rw [← hcomponent, sub_self] -- 本文: 両辺から非零成分を引く
  have hexpansion :
      (lambda ^ 2 - 1) * f j = lambda ^ 2 * f j - 1 * f j := by
    rw [sub_mul] -- 本文: 分配律で `(lambda^2-1)f_j` を展開
  have honeProduct :
      lambda ^ 2 * f j - 1 * f j = lambda ^ 2 * f j - f j := by
    simpa only [one_mul] -- 本文: 単位元の積を簡約
  have hproduct : (lambda ^ 2 - 1) * f j = 0 := by
    calc
      (lambda ^ 2 - 1) * f j = lambda ^ 2 * f j - 1 * f j := hexpansion
      _ = lambda ^ 2 * f j - f j := honeProduct
      _ = 0 := hdifference -- 本文: 直前の差が零であることを代入
  have hquadratic : lambda ^ 2 - 1 = 0 :=
    (mul_eq_zero.mp hproduct).resolve_right hfj -- 本文: 非零成分を零積則で消去
  have hfactorization : (lambda - 1) * (lambda + 1) = lambda ^ 2 - 1 := by
    ring -- 本文: 平方差を因数分解
  have hfactor : (lambda - 1) * (lambda + 1) = 0 := by
    rw [hfactorization, hquadratic] -- 本文: 二次式が零であることを代入
  have hlinear : lambda - 1 = 0 ∨ lambda + 1 = 0 :=
    mul_eq_zero.mp hfactor -- 本文: 零積の二つの場合
  rcases hlinear with hminus | hplus
  · exact Or.inl (sub_eq_zero.mp hminus) -- 本文: `lambda-1=0` を解く
  · exact Or.inr (add_eq_zero_iff_eq_neg.mp hplus) -- 本文: `lambda+1=0` を解く

end Ising2D

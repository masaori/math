/-
# 全スピン反転行列の Jordan--Wigner 表示を必要十分版から導く

対応する人手証明のラベル: `<global_spin_flip_jordan_wigner_representation>`。

具体版は `Definition000_TransferMatrixSymbols.lean` に置き、本文の二つの有限帰納法、
局所積、終端を各等号に対応する `calc` で追う。本ファイルは、第二帰納法の結論だけが
`NecSuf.prefix_eq_pow_smul_of_local_smul` の特殊化でも得られることを記録する。

必要十分版に渡す構造は、複素数と複素行列の二つのモノイド、スカラー作用、
およびスカラー作用と行列積の左右の両立だけである。
-/
import Ising2D.NecSuf.ScalarPrefixProduct
import Ising2D.Part004.Definition000_TransferMatrixSymbols

namespace Ising2D

/-- 必要十分版を `c=-√-1`、`P_m=xString M m`、
`Q_m=zyPrefixProduct M m` へ特殊化した等式。 -/
theorem zyPrefixProduct_eq_neg_i_pow_smul_xString_of_necSuf
    {M : ℕ} (m : ℕ) (hm : m ≤ M) :
    zyPrefixProduct M m = (-Complex.I) ^ m • xString M m := by
  apply NecSuf.prefix_eq_pow_smul_of_local_smul M (-Complex.I)
      (xString M) (zyPrefixProduct M)
      (fun n => if h : n < M then sigmaX ⟨n, h⟩ else 1)
      (fun n => if h : n < M then Z ⟨n, h⟩ * Y ⟨n, h⟩ else 1)
      xString_zero rfl
  · intro n hn
    rw [dif_pos hn, xString_succ n hn]
  · intro n hn
    rw [zyPrefixProduct, dif_pos hn]
  · intro n hn
    simp only [dif_pos hn]
    exact Z_mul_Y_same ⟨n, hn⟩
  · intro k a b
    exact Matrix.smul_mul k a b
  · intro k a b
    exact Matrix.mul_smul a k b
  · exact hm

end Ising2D

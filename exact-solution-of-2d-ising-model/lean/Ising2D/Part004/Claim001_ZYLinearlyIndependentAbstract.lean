/-
# `Z_m, Y_m` の線型独立性 — 具体版を抽象版の特殊化として導出する

対応する人手証明（正本は `structured-latex/content/004_transfer_matrix.mjs` の
ブロック `transfer_matrix_002_claim_Z_Y_linearly_independent`、ラベル `Z_Y_linearly_independent`）:
`parts/004_転送行列/001_claim_Z_mとY_mは線型独立.typ`

## このファイルの位置づけ（README のゴール設定 4 節「2 本立て」）

| | 定理 | 何を仮定しているか |
| --- | --- | --- |
| **具体版** | `Ising2D.ZY_linearIndependent`（`Claim001_ZYLinearlyIndependent.lean`） | `TensorPow M`（`2^M × 2^M` の複素行列）の `Z_m, Y_m` |
| **抽象版** | `Abstract.linearIndependent_of_clifford_abstract`（`Abstract/CliffordIndependence.lean`） | 任意の可換環 `S` 上の任意の環 `A` の族が Clifford 関係を満たすこと＋スカラーの忠実性＋`2` の非零因子性 |

本ファイルは、**具体版が抽象版の特殊化にすぎないこと**を実際の導出として書く
（`ZY_linearIndependent_of_abstract`）。特殊化で埋めるべき仮定は 2 つだけで、
どちらも複素行列に固有の事実である。

* `smul_one_faithful_tensorPow`: `s I = 0 → s = 0`。単位行列の対角成分を見るだけ
  （具体版の証明の最後の一行にあたる）。
* `2` が零因子でないこと: ℂ が体で `2 ≠ 0` であること。

これにより「線型独立性に効いているのは Clifford 関係だけで、
行列であること・テンソル冪であること・`Z, Y` の具体形は効いていない」ことが確認できる。
-/
import Ising2D.Abstract.CliffordIndependence
import Ising2D.Part004.Claim001_ZYLinearlyIndependent

namespace Ising2D

variable {M : ℕ}

/-- `TensorPow M` ではスカラーが忠実に入る: `s I = 0` なら `s = 0`。
（抽象版の仮定 `hfaithful` を複素行列について埋める部分。） -/
theorem smul_one_faithful_tensorPow (s : ℂ) (h : s • (1 : TensorPow M) = 0) : s = 0 := by
  have hentry := congrArg (fun A : TensorPow M => A (default : Conf M) (default : Conf M)) h
  simpa only [Matrix.smul_apply, Matrix.one_apply_eq, smul_eq_mul, mul_one,
    Matrix.zero_apply] using hentry

/-- **具体版 `ZY_linearIndependent` を抽象版の特殊化として導出した形**。

抽象版 `Abstract.linearIndependent_of_clifford_abstract` に
`S := ℂ`, `A := TensorPow M`, `e := ZY`（`<anticommutator_of_Z_and_Y>` の 3 式をまとめた
Clifford 関係 `acomm_ZY`）を代入したものが、そのまま原文の主張になる。 -/
theorem ZY_linearIndependent_of_abstract (M : ℕ) :
    LinearIndependent ℂ (ZY : Fin M ⊕ Fin M → TensorPow M) :=
  Abstract.linearIndependent_of_clifford_abstract ZY acomm_ZY
    (fun s hs => smul_one_faithful_tensorPow s hs)
    (fun s hs => by
      have : s * 2 = 0 := hs
      simpa using this)

end Ising2D
